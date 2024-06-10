# cimgui-pack

This is a meta-repo containing submodules of the C bindings for Dear ImGui and
related packages:
- [cimgui](https://github.com/cimgui/cimgui)
- [cimplot](https://github.com/cimgui/cimplot)
- [cimnodes](https://github.com/cimgui/cimnodes)

The versions have been picked so that they're all compatible with each other,
i.e. matching the latest ImGui version. The currently supported ImGui version
is: [*v1.90.8*](https://github.com/ocornut/imgui/releases/tag/v1.90.8).

You can build the resulting shared library locally with:
```julia-repl
# $ julia --project=.
julia> include("cimgui-pack/build.jl")
```

This repo is used directly by:
- [CImGuiPack](https://github.com/JuliaPackaging/Yggdrasil/tree/master/C/CImGuiPack)
  to create a JLL.
- [ImPlot.jl](https://github.com/wsphillips/ImPlot.jl) to generate bindings.
