using Clang.Generators
using CImGui.LibCImGui.CImGui_jll

cd(@__DIR__)

include_dir = joinpath(CImGui_jll.artifact_dir, "include")
cimgui_h = joinpath(include_dir, "cimgui.h") |> normpath

options = load_options(joinpath(@__DIR__, "generator.toml"))

args = get_default_args()
push!(args, "-I$include_dir", "-DCIMGUI_DEFINE_ENUMS_AND_STRUCTS")

ctx = create_context(cimgui_h, args, options)

build!(ctx)
