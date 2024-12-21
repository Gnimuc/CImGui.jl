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
[`examples/makie_demo.jl`](https://github.com/JuliaImGui/CImGui.jl/blob/master/examples/makie_demo.jl)
(you may want to `Right click -> Open in new tab` to see it in full resolution):
![Makie demo](assets/makie-demo.gif)

## Thread safety
None of this is thread-safe. Here's what you can and can't do:
- You can create a `Figure` on any thread and pass it to [`MakieFigure()`](@ref)
  to display.
- You cannot call [`MakieFigure()`](@ref) (or generally any ImGui functions) on
  a different thread from the [`render()`](@ref) thread.
- You cannot update a `Figure` from a separate thread, including with
  observables. Updating it from the same thread (i.e. in the renderloop) is
  fine.

## API

```@docs
MakieFigure
```
