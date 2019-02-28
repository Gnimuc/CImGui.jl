# CImGui
This package provides a Julia language wrapper for [cimgui](https://github.com/cimgui/cimgui): a thin c-api wrapper programmatically generated for the excellent C++ immediate mode gui [Dear ImGui](https://github.com/ocornut/imgui). Dear ImGui is mainly for creating content creation tools and visualization / debug tools. You could browse [Gallery](https://github.com/ocornut/imgui/issues/2265)
to get an idea of its use cases.

## Installation
```julia
pkg> add CImGui
```

## Usage
The API provided in this package is as close as possible to the original C++ API. When translating C++ code to Julia, please follow the tips below:
- Replace `ImGui::` to `CImGui.`;
- `using LibCImGui` to import all of the `ImGuiXXX` types into the current namespace;
- Member function calling should be translated in Julia style: `fonts.AddFont(cfg)` => `CImGui.Add(fonts, cfg)`;
- Prefer to define colors as `Vector{Cfloat}` instead of `CImGui.ImVec4`;
- [CSyntax.jl](https://github.com/Gnimuc/CSyntax.jl) provides two useful macros: `@c` for translating C's `&` operator on immutables and `@cstatic`-block for emulating C's `static` keyword;
- pointer arithmetic: `&A[n]` should be translated to `pointer(A) + n * sizeof(T)`

As mentioned before, this package aims to provide the same user experience as the original C++ API, so any high-level abstraction should go into a more high-level package.

### LibCImGui
LibCImGui is a thin wrapper over cimgui. It's one-to-one mapped to the original cimgui APIs. By using CImGui.LibCImGui, all of the ImGui-prefixed types, enums and ig-prefixed functions are imported into the current namespace.

### Backend
The default backend is based on [ModernGL](https://github.com/JuliaGL/ModernGL.jl) and [GLFW](https://github.com/JuliaGL/GLFW.jl) which are stable and under actively maintained. Other popular backends like [SFML](https://github.com/zyedidia/SFML.jl) and [SDL](https://github.com/ariejdl/SDL.jl) could be added in the future if someone would invest time to make these packages work in post Julia 1.0 era.

## License
Only the Julia code in this repo is released under MIT license. Other assets such as those fonts in the `fonts` folder are released under their own license.
