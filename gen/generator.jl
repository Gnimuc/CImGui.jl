using Clang.Generators
using CImGuiPack_jll

cd(@__DIR__)

include_dir = joinpath(CImGuiPack_jll.artifact_dir, "include")
cimgui_h = joinpath(include_dir, "cimgui.h") |> normpath
cimplot_h = joinpath(include_dir, "cimplot.h") |> normpath
cimnodes_h = joinpath(include_dir, "cimnodes.h") |> normpath

options = load_options(joinpath(@__DIR__, "generator.toml"))

args = get_default_args()
push!(args, "-I$include_dir", "-DCIMGUI_DEFINE_ENUMS_AND_STRUCTS")

@add_def time_t

ctx = create_context([cimgui_h, cimplot_h, cimnodes_h], args, options)

build!(ctx)
