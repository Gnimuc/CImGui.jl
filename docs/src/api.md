```@meta
CurrentModule = CImGui
CollapsedDocStrings = true
```

# API Reference
This page documents the wrapper functions we have for the ImGui API. The
[Backends](@ref) and the [Makie integration](@ref) are documented separately.

You can always get the current ImGui version with:
```@docs
imgui_version
```

---

```@autodocs
Modules = [CImGui]
Order   = [:constant, :function, :type]
Filter  = t -> nameof(t) ∉ (:imgui_version, :render, :set_backend, :MakieFigure)
```
