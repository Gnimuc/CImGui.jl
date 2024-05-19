using CImGui
using Documenter
import Changelog

# Note that the changelog file is named `_changelog.md` so we can use
# `changelog.md` as the generated name, which makes for a prettier URL.
Changelog.generate(
    Changelog.Documenter(),
    joinpath(@__DIR__, "src/_changelog.md"),
    joinpath(@__DIR__, "src/changelog.md"),
    repo="Gnimuc/CImGui.jl"
)

makedocs(;
    modules=[CImGui],
    authors="Yupei Qi <qiyupei@gmail.com>",
    sitename="CImGui.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Gnimuc.github.io/CImGui.jl",
        assets=String[],
        size_threshold=400000
    ),
    pages=[
        "Introduction" => "index.md",
        "API Reference" => "api.md",
        "Changelog" => "changelog.md"
    ]
)

deploydocs(;
    repo="github.com/Gnimuc/CImGui.jl.git",
)
