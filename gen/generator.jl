using Clang

# do not forget to add #define CIMGUI_DEFINE_ENUMS_AND_STRUCTS in the top of the header
const CIMGUI_H = joinpath(@__DIR__, "..", "deps", "usr", "include", "cimgui.h") |> normpath

# create a work context
ctx = DefaultContext()

# parse headers
stdlibs = @static Sys.isapple() ? ["-I/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.14.sdk/usr/include"] : [""]
parse_headers!(ctx, [CIMGUI_H], args=stdlibs, includes=[LLVM_INCLUDE])

# settings
ctx.libname = "libcimgui"
ctx.options["is_function_strictly_typed"] = false
ctx.options["is_struct_mutable"] = false

# write output
api_file = joinpath(@__DIR__, "libcimgui_api.jl")
api_stream = open(api_file, "w")

for trans_unit in ctx.trans_units
    root_cursor = getcursor(trans_unit)
    push!(ctx.cursor_stack, root_cursor)
    header = spelling(root_cursor)
    @info "wrapping header: $header ..."
    # loop over all of the child cursors and wrap them, if appropriate.
    ctx.children = children(root_cursor)
    for (i, child) in enumerate(ctx.children)
        child_name = name(child)
        child_header = filename(child)
        ctx.children_index = i
        # choose which cursor to wrap
        startswith(child_name, "__") && continue  # skip compiler definitions
        child_name in keys(ctx.common_buffer) && continue  # already wrapped
        child_header != header && continue  # skip if cursor filename is not in the headers to be wrapped

        wrap!(ctx, child)
    end
    @info "writing $(api_file)"
    println(api_stream, "# Julia wrapper for header: $header")
    println(api_stream, "# Automatically generated using Clang.jl\n")
    print_buffer(api_stream, ctx.api_buffer)
    empty!(ctx.api_buffer)  # clean up api_buffer for the next header
end
close(api_stream)

# write "common" definitions: types, typealiases, etc.
common_file = joinpath(@__DIR__, "libcimgui_common.jl")
open(common_file, "w") do f
    println(f, "# Automatically generated using Clang.jl\n")
    print_buffer(f, dump_to_buffer(ctx.common_buffer))
end

# uncomment the following code to generate dependency and template files
# copydeps(dirname(api_file))
# print_template(joinpath(dirname(api_file), "LibTemplate.jl"))
