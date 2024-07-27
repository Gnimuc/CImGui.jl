```@meta
CurrentModule = CImGui
```

# Makie integration

We currently have *very experimental* [Makie](https://docs.makie.org/stable)
support through
[GLMakie](https://docs.makie.org/stable/explanations/backends/glmakie). GLMakie
mostly works around a `Screen{T}` object to display a scene, where `T` is some
OpenGL-supporting window. GLMakie sets this to a `GLFW.Window`, but we've made a
custom window type to represent a single `Figure` to be drawn in ImGui. What we
get from GLMakie is a framebuffer with a color image texture attachment, and
that's displayed by us as an image.

```@docs
MakieFigure
```
