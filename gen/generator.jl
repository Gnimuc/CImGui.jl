using Clang.Generators
using Clang.JLLEnvs
using CImGuiPack_jll

cd(@__DIR__) do
    include_dir = joinpath(CImGuiPack_jll.artifact_dir, "include")

    cimgui_h = joinpath(include_dir, "cimgui.h") |> normpath
    cimgui_impl_h = joinpath(include_dir, "cimgui_impl.h") |> normpath
    cimplot_h = joinpath(include_dir, "cimplot.h") |> normpath
    cimnodes_h = joinpath(include_dir, "cimnodes.h") |> normpath

    for target in JLLEnvs.JLL_ENV_TRIPLES
        @info "processing $target"

        options = load_options(joinpath(@__DIR__, "generator.toml"))
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
end
