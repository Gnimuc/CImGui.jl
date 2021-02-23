using Clang
using Clang.Generators
using CImGui.LibCImGui.CImGui_jll

include_dir = joinpath(CImGui_jll.artifact_dir, "include")

const CIMGUI_H = joinpath(include_dir, "cimgui.h") |> normpath
const HELPER_H = joinpath(include_dir, "helper.h") |> normpath

options = load_options(joinpath(@__DIR__, "libcimgui.toml"))

args = ["-I$include_dir", "-DCIMGUI_DEFINE_ENUMS_AND_STRUCTS"]

ctx = create_context([CIMGUI_H, HELPER_H], args, options)

build!(ctx, BUILDSTAGE_NO_PRINTING)

for node in get_nodes(ctx.dag)
    file = get_filename(node.cursor)
    file == HELPER_H || continue
    Generators.is_function(node) || continue
    if !Generators.is_variadic_function(node)
        expr = node.exprs[1]
        expr.args[2].args[1].args[2].args[2] = :libcimgui_helper
    end
end

build!(ctx, BUILDSTAGE_PRINTING_ONLY)
