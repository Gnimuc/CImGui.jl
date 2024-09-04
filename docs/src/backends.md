```@meta
CurrentModule = CImGui
```

# Backends
ImGui is a very embeddable library because it abstracts things like drawing to
the screen and creating windows to its *backends*. There are many official
backends, but currently CImGui.jl only supports the GLFW/OpenGL3 backend. Other
popular backends like [SFML](https://github.com/zyedidia/SFML.jl) and
[SDL](https://github.com/ariejdl/SDL.jl) could be added in the future if someone
should invest time to make these packages work.


```@docs
set_backend
render
```
