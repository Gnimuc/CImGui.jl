# CImGui

[![Build Status](https://travis-ci.com/Gnimuc/CImGui.jl.svg?branch=master)](https://travis-ci.com/Gnimuc/CImGui.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/Gnimuc/CImGui.jl?svg=true)](https://ci.appveyor.com/project/Gnimuc/CImGui-jl)
[![Codecov](https://codecov.io/gh/Gnimuc/CImGui.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/Gnimuc/CImGui.jl)
[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://Gnimuc.github.io/CImGui.jl/stable)
[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://Gnimuc.github.io/CImGui.jl/dev)

This package provides a Julia language wrapper for [cimgui](https://github.com/cimgui/cimgui): a thin c-api wrapper programmatically generated for the excellent C++ immediate mode gui [Dear ImGui](https://github.com/ocornut/imgui). Dear ImGui is mainly for creating content creation tools and visualization / debug tools. You could browse [Gallery](https://github.com/ocornut/imgui/issues/2265)
to get an idea of its use cases.

![demo](demo/demo.png)

## Installation
```julia
pkg> add CImGui
```

## Quick Start
1. Run `demo/demo.jl` to test whether the default backend works on your machine.
2. Run `examples/demo.jl` and browse demos in the `examples` folder to learn how to use the API.
3. Read documentation or run `? CImGui.xxx` to retrieve docs:
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
```

## Usage
The API provided in this package is as close as possible to the original C++ API. When translating C++ code to Julia, please follow the tips below:
- Replace `ImGui::` to `CImGui.`;
- `using LibCImGui` to import all of the `ImGuiXXX` types into the current namespace;
- Member function calling should be translated in Julia style: `fonts.AddFont(cfg)` => `CImGui.AddFont(fonts, cfg)`;
- Prefer to define colors as `Vector{Cfloat}` instead of `CImGui.ImVec4`;
- [CSyntax.jl](https://github.com/Gnimuc/CSyntax.jl) provides two useful macros: `@c` for translating C's `&` operator on immutables and `@cstatic`-block for emulating C's `static` keyword;
- pointer arithmetic: `&A[n]` should be translated to `pointer(A) + n * sizeof(T)` where `n` counts from 0.

As mentioned before, this package aims to provide the same user experience as the original C++ API, so any high-level abstraction should go into a more high-level package.

### LibCImGui
LibCImGui is a thin wrapper over cimgui. It's one-to-one mapped to the original cimgui APIs. By using CImGui.LibCImGui, all of the ImGui-prefixed types, enums and ig-prefixed functions will be imported into the current namespace. It's mainly for people who prefer to use original cimgui's interface.

### Backend
The default backend is based on [ModernGL](https://github.com/JuliaGL/ModernGL.jl) and [GLFW](https://github.com/JuliaGL/GLFW.jl) which are stable and under actively maintained. Other popular backends like [SFML](https://github.com/zyedidia/SFML.jl) and [SDL](https://github.com/ariejdl/SDL.jl) could be added in the future if someone should invest time to make these packages work in post Julia 1.0 era.

## License
Only the Julia code in this repo is released under MIT license. Other assets such as those fonts in the `fonts` folder are released under their own license.
