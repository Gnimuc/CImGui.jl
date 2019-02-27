# CImGui
## Installation
```julia
pkg> add https://github.com/Gnimuc/CImGui.jl.git
```
you might also need to `dev https://github.com/Gnimuc/CSyntax.jl`

## Quick Start
1. Run `demo/demo.jl` to test whether the GLFW+OpenGL backend works on your machine.
2. Run `examples/demo.jl` and browse demos in the `examples` folder to learn how to use the API.
3. Press `? CImGui.xxx` to fetch docs.
```
help?> CImGui.Begin
  Begin(name, p_open=C_NULL, flags=0) -> Bool

  Push window to the stack and start appending to it.

  Usage
  –––––––

    •    you may append multiple times to the same window during the same frame.

    •    passing p_open != C_NULL shows a window-closing widget in the upper-right corner of
        the window, which clicking will set the boolean to false when clicked.

    •    Begin return false to indicate the window is collapsed or fully clipped, so you may
        early out and omit submitting anything to the window.

  │ Note
  │
  │  Always call a matching End for each Begin call, regardless of its return value. This
  │  is due to legacy reason and is inconsistent with most other functions (such as
  │  BeginMenu/EndMenu, BeginPopup/EndPopup, etc.) where the EndXXX call should only be
  │  called if the corresponding BeginXXX function returned true.

  ────────────────────────────────────────────────────────────────────────────────────────────────

  Begin(handle::Ptr{ImGuiTextBuffer}) -> Cstring

  ────────────────────────────────────────────────────────────────────────────────────────────────

  Begin(handle::Ptr{ImGuiListClipper}, items_count, items_height=-1.0)

  Automatically called by constructor if you passed items_count or by Step in Step 1.
```
