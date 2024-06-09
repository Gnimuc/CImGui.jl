using Clang.Generators
using Clang.JLLEnvs
using CImGuiPack_jll

cd(@__DIR__)

include_dir = joinpath(CImGuiPack_jll.artifact_dir, "include")

cimgui_h = joinpath(include_dir, "cimgui.h") |> normpath
cimplot_h = joinpath(include_dir, "cimplot.h") |> normpath
cimnodes_h = joinpath(include_dir, "cimnodes.h") |> normpath

for target in JLLEnvs.JLL_ENV_TRIPLES
    @info "processing $target"

    options = load_options(joinpath(@__DIR__, "generator.toml"))
    options["general"]["output_file_path"] = joinpath(@__DIR__, "..", "lib", "$target.jl")

    args = get_default_args(target)
    push!(args, "-I$include_dir", "-DCIMGUI_DEFINE_ENUMS_AND_STRUCTS")

    ctx = create_context([cimgui_h, cimplot_h, cimnodes_h], args, options)

    build!(ctx)
end
