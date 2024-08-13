import JSON3
using Clang.Generators
using Clang.JLLEnvs
using CImGuiPack_jll
import JuliaFormatter: format_file, format_text
import MacroTools: @capture, splitdef, prettify


"""
This anonymous module contains the raw bindings from Clang.jl.
"""
bindings_module::Module = Module()

# Special-case: the `flags_value` argument of CheckboxFlags() can
# take in any kind of flag so we leave it untyped.
const args_to_ignore = [(:igCheckboxFlags_IntPtr, :flags_value),
                        (:igCheckboxFlags_UintPtr, :flags_value)]

# ImGui::Begin() would otherwise have an ambiguity with ImGuiListClipper::Begin()
const args_to_annotate = [(:igBegin, :name)]

const function_ignorelist = (
    :ImVec2, :ImVec4, :ImRect,
    :igFindHoveredWindowEx,
    :igDebugNodeWindowsListByBeginStackParent,

    # These functions are implemented explicitly in extras.jl:
    :igPlotLines_FloatPtr, :igPlotLines_FnFloatPtr,
    :igPlotHistogram_FloatPtr, :igPlotHistogram_FnFloatPtr,

    # Ignore these functions because the same constructors are already defined
    # by the types default constructor.
    :ImColor_ImColor_Vec4, :ImVec1_ImVec1_Float,

    # This function and GetForegroundDrawList(ImGuiViewPort*) kinda
    # conflict. Because they're both pointer types the generator doesn't allow
    # either to be Ptr{Cvoid}, but C_NULL is the default argument to
    # GetForegroundDrawList(ImGuiViewPort*). Hence we disable this other
    # (internal) overload.
    :igGetForegroundDrawList_WindowPtr
)

struct WrapperMethod
    name::Union{Expr, Symbol}
    internal::Bool
    docstring::String
    expr::Expr
end

is_internal(metadata) = contains(metadata[:location], "imgui_internal")

function create_docstring(func_name, overload)
    docstring = "\$(TYPEDSIGNATURES)"

    comment = get(overload, :comment, "")
    if !isempty(comment)
        formatted_comment = chopprefix(comment, "//") |> strip |> uppercasefirst
        if !isempty(formatted_comment) && formatted_comment[end] ∉ ('.', '!', '?')
            formatted_comment *= "."
        end

        docstring *= "\n\n$(formatted_comment)"
    end

    header, line = split(overload[:location], ':')
    link = "https://github.com/ocornut/imgui/blob/v1.91.0-docking/$(header).h#L$(line)"

    if is_internal(overload)
        docstring *= """\n
                     !!! warning
                         This function is internal, it may change in the future."""
    end

    docstring *= "\n\n[Upstream link]($link)."

    return docstring
end

"""
Convert an ImGui argument type to a Julia type annotation.
"""
function imgui_to_jl_type(ig_type)
    parsed_type = Meta.parse(ig_type)
    if !(parsed_type isa Symbol)
        # If it's a whole expression, just return
        return parsed_type
    end

    # Figure out what other types should be allowed as arguments. Otherwise
    # users would have to be careful to only pass in e.g. Int32's for ImGuiID,
    # which is quite annoying.
    unions = if parsed_type === :ImVec2
        # ImVec2 and ImVec4 have special support for NTuple's
        [:(NTuple{2})]
    elseif parsed_type === :ImVec4
        [:(NTuple{4})]
    elseif getproperty(bindings_module, parsed_type) in (Cint, Cuint)
        [:Integer]
    elseif endswith(string(parsed_type), "Callback")
        # Allow passing CFunctions and Ptr{Cvoid}'s to callback arguments
        [:(Base.CFunction), :(Ptr{Cvoid})]
    else
        []
    end

    # ImGui always defines type aliases for enum primitive types, and then a
    # separate enum type with a trailing underscore. Here we check if such an
    # enum type exists and add it to the union if so.
    enum_type = Symbol(parsed_type, :_)
    try
        # Note that we have to use getproperty() and catch an exception because
        # `bindings_module` is an anonymous module, for which propertynames()
        # doesn't work as usual.
        getproperty(bindings_module, enum_type)
        pushfirst!(unions, enum_type)
    catch ex
        if !(ex isa UndefVarError)
            rethrow()
        end
    end

    return if isempty(unions)
        [parsed_type]
    else
        [parsed_type, unions...]
    end
end

"""
For numeric C arguments, widen to the safest possible Julia type so that people
can e.g. pass Int literals to functions that take in a Int32.
"""
function widen_numeric_type(arg_type, overload_arg_types)
    c_numeric_types = Dict("int" => :Int,
                           "unsigned int" => :UInt,
                           "float" => :Float32,
                           "double" => :Float64)
    if arg_type ∉ keys(c_numeric_types)
        error("Cannot widen a non-numeric type")
    end

    check_integral = x -> x in ("int", "unsigned int")
    check_floating = x -> x in ("float", "double")
    is_integral = check_integral(arg_type)
    is_floating = !is_integral
    widest_possible_type = [is_integral ? :Integer : :Real]

    # If the type is the same for all overloads we can widen
    if all(==(arg_type), overload_arg_types)
        return widest_possible_type
    end

    # If this is the only numeric type in all the overloads we can widen
    if !any(x -> x in keys(c_numeric_types), overload_arg_types)
        return widest_possible_type
    end

    # If this is the only integral/floating type in all the overloads we can widen
    if (is_integral && !any(check_integral, overload_arg_types)) || (is_floating && !any(check_floating, overload_arg_types))
        return widest_possible_type
    end

    # Otherwise fall back to the matching C type
    return [c_numeric_types[arg_type]]
end

"""
Convert a C argument type to a Julia type annotation.
"""
function to_jl_type(func_name, func_idx, arg_idx, overloads)
    # Find the type for this argument
    func_args = overloads[func_idx][:argsT]
    arg_info = func_args[arg_idx]
    type_str = arg_info[:type]

    unqualify = x -> replace(x, "const " => "")

    # And the types of the same argument *by name* and *by position* in any other overloads
    arg_name = arg_info[:name]
    overload_arg_types = String[]
    positional_overload_arg_types = String[]
    shares_other_args = false
    for overload_metadata in overloads
        overload_name = Symbol(overload_metadata[:ov_cimguiname])
        if overload_name == func_name || overload_name in function_ignorelist
            continue
        end

        # Get the type of the same argument by name
        overload_args = overload_metadata[:argsT]
        idx = findfirst(x -> x[:name] == arg_name, overload_args)
        if !isnothing(idx)
            push!(overload_arg_types, unqualify(overload_args[idx][:type]))
        end

        # Get the type of the same argument by position
        if arg_idx <= length(overload_args)
            push!(positional_overload_arg_types, unqualify(overload_args[arg_idx][:type]))
        end

        # Check if this overload shares the same types with the other arguments
        if length(overload_args) == length(func_args)
            # Get the types of the other args, except for any arguments that
            # we're explicitly ignoring.
            arg_is_ignored = arg -> (overload_name, Symbol(arg[:name])) in args_to_ignore
            func_args_types = String[arg[:type] for (i, arg) in enumerate(func_args) if i != arg_idx && !arg_is_ignored(arg)]
            overload_args_types = String[arg[:type] for (i, arg) in enumerate(overload_args) if i != arg_idx && !arg_is_ignored(arg)]

            if func_args_types == overload_args_types
                shares_other_args = true
            end
        end
    end

    # Strip const qualifiers and determine if the arg is a pointer type
    unqualified_type = unqualify(type_str)
    is_ptr = unqualified_type != "char*" && unqualified_type[end] == '*'
    if is_ptr
        unqualified_type = unqualified_type[1:end - 1]
    end

    unions = if startswith(unqualified_type, "Im")
        imgui_to_jl_type(unqualified_type)
    elseif unqualified_type == "bool"
        [:Bool]
    elseif unqualified_type == "int"
        is_ptr ? [:Int32] : widen_numeric_type(unqualified_type, overload_arg_types)
    elseif unqualified_type == "unsigned int"
        is_ptr ? [:UInt32] : widen_numeric_type(unqualified_type, overload_arg_types)
    elseif unqualified_type == "float"
        is_ptr ? [:Float32] : widen_numeric_type(unqualified_type, overload_arg_types)
    elseif unqualified_type == "double"
        is_ptr ? [:Float64] : widen_numeric_type(unqualified_type, overload_arg_types)
    elseif unqualified_type == "char"
        [:Char]
    elseif unqualified_type == "char*"
        # Strings are complicated. Usually we want to pass String objects but
        # sometimes it's also desirable to pass C_NULL. For this reason we try
        # to allow passing a Ptr{Cvoid} to a string argument when possible, but
        # that can cause method ambiguities when one overload takes in a string
        # and the other takes in a pointer. The second will be given a
        # PtrOrRef{T} type which is a type union that includes Ptr{Cvoid}, so if
        # the string overload also allows taking in a Ptr{Cvoid} we might get a
        # method ambiguity.
        #
        # To avoid this we check the types of the arguments in all the overloads
        # with the same name and position. If any of them are non-string
        # pointers we forbid passing a Ptr{Cvoid} to the string overload.
        is_different_ptr = x -> x != unqualified_type && contains(x, "*")
        has_non_string_ptr = (!isnothing(findfirst(is_different_ptr, overload_arg_types))
                              || !isnothing(findfirst(is_different_ptr, positional_overload_arg_types)))

        if has_non_string_ptr
            # Conservative option (only taken if necessary)
            [:String, :(Ptr{Cchar})]
        else
            # Loosest option (preferable)
            [:String, :(Ptr{Cchar}), :(Ptr{Cvoid})]
        end
    elseif unqualified_type == "void"
        [:Cvoid]
    elseif unqualified_type == "size_t"
        [:Int]
    elseif type_str == "const char* const[]"
        [:(Vector{String})]
    else
        error("Unsupported C type: '$(type_str)'")
    end

    return if is_ptr
        # If this argument is the only one that has a different type from the
        # other arguments across all the overloads, and the other overloads all
        # have pointers for this argument too, then we can't allow Ptr{Cvoid}
        # because of method ambiguity.
        correct_ptr_type = shares_other_args ? :PtrOrRef : :VoidablePtrOrRef

        if length(unions) == 1
            :($correct_ptr_type{$(only(unions))})
        else
            ptr_exprs = [:($correct_ptr_type{$T}) for T in unions]
            :(Union{$(ptr_exprs...)})
        end
    else
        if length(unions) == 1
            only(unions)
        else
            :(Union{$(unions...)})
        end
    end
end

# Stolen from ImPlot.jl
function split_ccall(body)
    local funsymbol, rettype, argtypes, argnames
    for ex in body.args
        @capture(ex, ccall((funsymbol_, libcimgui), rettype_, (argtypes__,), argnames__)) && break
    end
    return (; funsymbol, rettype, argtypes, argnames)
end

"""
Wrap a single cimgui function.
"""
function wrap_function!(methods, func_name, func_def, overloads; with_arg_types=false)
    func_idx = findfirst(x -> x[:ov_cimguiname] === string(func_name), overloads)
    func_metadata = overloads[func_idx]

    # Filter out variadic arguments. These are always related to string
    # formatting and it's simpler to let that be done in Julia by the users.
    arg_names = filter(!=(:(va_list...)), func_def[:args])
    arg_types_strs = [func_metadata[:argsT][i][:type] for i in eachindex(arg_names)]

    args = copy(arg_names)
    is_pOut = false

    for i in eachindex(args)
        # pOut arguments are part of cimgui and are a pointer to a return value,
        # to be filled in by the cimgui function.
        if arg_names[i] == :pOut
            is_pOut = true
        end

        arg_type_str = arg_types_strs[i]

        # If this is the `self` argument and this function belongs to a struct,
        # then it must be the self object.
        if arg_names[i] == :self && func_metadata[:stname] != ""
            args[i] = :($(args[i])::Ptr{$(Symbol(func_metadata[:stname]))})
        elseif ((with_arg_types
                 || (func_name, arg_names[i]) in args_to_annotate
                 # We don't support parsing array types yet
                 || (contains(arg_type_str, "Im") && !contains(arg_type_str, '[')))
                && (func_name, arg_names[i]) ∉ args_to_ignore)
            # Always try to parse arg types if `arg_types` is true, or if it's any non-array ImGui type
            type = to_jl_type(func_name, func_idx, i, overloads)
            args[i] = :($(args[i])::$(type))
        end

        if haskey(func_metadata[:defaults], arg_names[i])
            default = func_metadata[:defaults][arg_names[i]]
            if default == "NULL"
                default = "C_NULL"
            end

            # Replace all float literals of the form '1f' or '0.0f' etc with '1f0'/'0.0f0'
            default = replace(default, r"\df" => x -> "$(x[1])f0")

            args[i] = Expr(:kw, args[i], Meta.parse(default))
        end
    end

    ig_name = Symbol(func_metadata[:funcname])

    # Ignore the CheckboxFlags() overloads in imgui_internal.h, they're [U]Int64
    # overloads that conflict with the overload wrappers defined from imgui.h.
    if ig_name == :CheckboxFlags && startswith(func_metadata[:location], "imgui_internal")
        @info "Skipping '$func_name' from imgui_internal.h"
        return
    end

    # Create the identifier for the wrapper function. If it's a constructor then
    # we need to add the method to the original type in the `lib` submodule to
    # avoid shadowing the *type* in `lib` with the *function* in `CImGui`. We
    # also capitalize the name for backwards compatibility with the manually
    # created wrappers.
    capitalized_name = Symbol(uppercasefirst(string(ig_name)))
    new_identifier = get(func_metadata, :constructor, false) ? :(lib.$capitalized_name) : capitalized_name

    # String array arguments are always given a Vector{String} type, and are
    # followed by a 'count' argument. Here we delete the 'count' argument in
    # favour of calling `length()` on the vector.
    count_args = [i + 1 for i in eachindex(arg_names) if arg_types_strs[i] == "const char* const[]"]
    deleteat!(args, count_args)
    for i in count_args
        # Take the length of the *previous* argument
        arg_names[i] = :(length($(arg_names[i - 1])))
    end

    func_expr = if is_pOut
        ccall_info = split_ccall(func_def[:body])
        local pOut_type
        if !@capture(ccall_info.argtypes[1], Ptr{pOut_type_})
            @warn "Skipping '$func_name', couldn't get type of the `pOut` argument"
            return
        end

        popfirst!(args)
        popfirst!(arg_names)

        # Special-case HSV() because it should return an ImVec4 instead of an ImColor
        return_expr = if func_name === :ImColor_HSV
            :(pOut[].Value)
        else
            :(pOut[])
        end

        quote
            function $new_identifier($(args...))
                pOut = Ref{$pOut_type}()
                $func_name(pOut, $(arg_names...))
                return $return_expr
            end
        end
    else
        quote
            $new_identifier($(args...)) = $func_name($(arg_names...))
        end
    end

    docstring = create_docstring(func_name, func_metadata)

    push!(methods, WrapperMethod(new_identifier, is_internal(func_metadata), docstring, prettify(func_expr)))
end

"""
Wrap a destructor. These are pretty simple so we define them separately from
other functions.
"""
function wrap_destructor!(methods, func_name)
    type = Symbol(split(string(func_name), "_")[1])

    func_expr = :(Destroy(self::Ptr{$type}) = $func_name(self))

    push!(methods, WrapperMethod(:Destroy, false, "Destructor for `$type`", prettify(func_expr)))
end

"""
Iterate over all the functions in the DAG and create wrapper Expr's for them.
"""
function get_wrappers(dag::ExprDAG)
    methods = WrapperMethod[]
    imgui_defs = JSON3.read(CImGuiPack_jll.cimgui_definitions)

    for node in dag.nodes
        for (i, expr) in enumerate(node.exprs)
            # If this is a generated function, extract the :function from it
            if Meta.isexpr(expr, :macrocall) && expr.args[1] == Symbol("@generated")
                expr = expr.args[3]
            end

            if Meta.isexpr(expr, :function)
                # Wrap regular functions

                func_def = splitdef(expr)
                func_name = func_def[:name]

                if func_name in function_ignorelist
                    continue
                end

                if func_name in keys(imgui_defs)
                    all_overloads = imgui_defs[func_name]
                    func_metadata = only(all_overloads)

                    # Handle destructors specially
                    if haskey(func_metadata, :destructor) && func_metadata[:destructor]
                        wrap_destructor!(methods, func_name)
                        continue
                    end

                    try
                        wrap_function!(methods, func_name, func_def, all_overloads)
                    catch ex
                        @warn "Couldn't wrap '$(func_name)'" exception=ex
                    end
                else
                    # Check if this is an overload, in which case the function
                    # name will something like `name_type()` or
                    # `struct_name_type()`. We need to strip the `type` part off
                    # to index into `imgui_defs`. `X_Str_arr()` is special-cased
                    # because it has two underscores in the name.
                    split_token = endswith(string(func_name), "_Str_arr") ? "_Str_arr" : "_"
                    split_name = rsplit(string(func_name), split_token; limit=2)
                    if length(split_name) == 1
                        continue
                    end

                    abstract_name = split_name[1]
                    if any(startswith(abstract_name, string(x)) for x in function_ignorelist)
                        @info "Skipping '$(func_name)' because it was explicitly ignored"
                        continue
                    elseif !haskey(imgui_defs, abstract_name)
                        # This is very spammy so we don't print a warning by default. It removes symbols from ImPlot and ImNodes.
                        # @warn "Skipping '$(func_name)' because it's not in `imgui_defs`"
                        continue
                    end

                    all_overloads = imgui_defs[abstract_name]
                    for overload_metadata in imgui_defs[abstract_name]
                        if overload_metadata[:ov_cimguiname] == string(func_name)
                            try
                                wrap_function!(methods, func_name, func_def, all_overloads; with_arg_types=true)
                            catch ex
                                @warn "Couldn't wrap '$(func_name)'" exception=ex
                            end
                        end
                    end
                end
            end
        end
    end

    return methods
end

function generate()
    cd(@__DIR__) do
        include_dir = joinpath(CImGuiPack_jll.artifact_dir, "include")

        cimgui_h = joinpath(include_dir, "cimgui.h") |> normpath
        cimgui_impl_h = joinpath(include_dir, "cimgui_impl.h") |> normpath
        cimplot_h = joinpath(include_dir, "cimplot.h") |> normpath
        cimnodes_h = joinpath(include_dir, "cimnodes.h") |> normpath

        local ctx
        options = load_options(joinpath(@__DIR__, "generator.toml"))
        for target in JLLEnvs.JLL_ENV_TRIPLES
            @info "processing $target"

            options["general"]["output_file_path"] = joinpath(@__DIR__, "..", "lib", "$target.jl")

            args = get_default_args(target)
            push!(args,
                  "-I$include_dir",
                  "-DCIMGUI_DEFINE_ENUMS_AND_STRUCTS",

                  # Enable some defines to generate bindings for the backends
                  "-DCIMGUI_USE_GLFW",
                  "-DCIMGUI_USE_OPENGL3",
                  # Define a dummy override since cimgui_impl.h doesn't define CIMGUI_API
                  "-DCIMGUI_API=;",
                  # cimgui_impl.h uses 'bool', but that requires an extra header
                  "-includestdbool.h")

            ctx = create_context([cimgui_h, cimplot_h, cimnodes_h, cimgui_impl_h], args, options)
            build!(ctx)
        end

        println()
        @info "Generating wrapper.jl..."
        println()

        global bindings_module = Module()
        Base.include(bindings_module, options["general"]["output_file_path"])
        wrappers = get_wrappers(ctx.dag)
        output_file = joinpath(@__DIR__, "../src/wrapper.jl")
        open(output_file; write=true) do io
            write(io,
                  """
                  const PtrOrRef{T} = Union{Ptr{T}, Ref{T}} where T
                  const VoidablePtrOrRef{T} = Union{Ptr{T}, Ref{T}, Ptr{Cvoid}} where T

                  """)

            # Write the methods
            for w in wrappers
                write(io,
                      """
                          \"\"\"
                          $(w.docstring)
                          \"\"\"
                          """)
                write(io, string(w.expr), "\n\n")
            end

            # Write the `public` statement
            function_names = unique([string(w.name) for w in wrappers if !w.internal])
            # Filter out methods of another module and internal methods
            filter!(x -> !startswith(x, "lib.") && !startswith(x, "_"), function_names)
            function_names = join(function_names, ", ")

            write(io, "@compat public ($(function_names))")
        end

        format_file(output_file; margin=120)
    end

    return nothing
end

# Run automatically if the script is launched from the command-line
if !isempty(Base.PROGRAM_FILE)
    generate()
end
