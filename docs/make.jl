using Documenter, CImGui

makedocs(
    modules = [CImGui],
    clean = false,
    sitename = "CImGui.jl",
    linkcheck = !("skiplinks" in ARGS),
    pages = [
        "Introduction" => "index.md",
        "API Reference" => "api.md",
    ],
)

deploydocs(
    repo = "github.com/Gnimuc/CImGui.jl.git",
    target = "build",
)
