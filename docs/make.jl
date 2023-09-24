using CImGui
using Documenter

makedocs(;
    modules=[CImGui],
    authors="Yupei Qi <qiyupei@gmail.com>",
    sitename="CImGui.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Gnimuc.github.io/CImGui.jl",
        assets=String[],
    ),
    pages=[
       "Introduction" => "index.md",
       "API Reference" => "api.md",
    ],
)

deploydocs(;
    repo="github.com/Gnimuc/CImGui.jl.git",
)
