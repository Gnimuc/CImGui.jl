using Clang
using Clang.Generators
using CImGui.LibCImGui.CImGui_jll

include_dir = joinpath(CImGui_jll.artifact_dir, "include")

const CIMGUI_H = joinpath(include_dir, "cimgui.h") |> normpath

options = load_options(joinpath(@__DIR__, "libcimgui.toml"))

args = ["-I$include_dir", "-DCIMGUI_DEFINE_ENUMS_AND_STRUCTS"]

ctx = create_context([CIMGUI_H], args, options)

build!(ctx)
