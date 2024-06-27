```@meta
CurrentModule = CImGui
```

# Backends
ImGui is a very embeddable library because it abstracts things like drawing to
the screen and creating windows to its *backends*. There are many official
backends, but currently CImGui.jl only supports the GLFW/OpenGL3 backend.

```@docs
set_backend
render
```
