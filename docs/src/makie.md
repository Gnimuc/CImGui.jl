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

It supports all the interaction features in GLMakie:
- Scroll to zoom
- Click and drag to rectangle select a region to zoom to
- Right click and drag to pan
- Shift + {x/y} and scroll to zoom along the X/Y axes
- Ctrl + left click to reset the limits

Here's a quick demo using
[`examples/makie_demo.jl`](https://github.com/Gnimuc/CImGui.jl/blob/master/examples/makie_demo.jl)
(you may want to `Right click -> Open in new tab` to see it in full resolution):
![Makie demo](assets/makie-demo.gif)

```@docs
MakieFigure
```
