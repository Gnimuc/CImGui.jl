```@meta
CurrentModule = CImGui
```

# Changelog
This documents notable changes in CImGui.jl. The format is based on [Keep a
Changelog](https://keepachangelog.com).

## Unreleased

### Added
- The OpenGL version can now be set with [`render()`](@ref).

## [v2.0.0] - 2024-06-27

Note: this release has particularly many breaking changes, please file an issue
or submit a pull request if something isn't working.

### Added
- A renderloop for the OpenGL/GLFW backend has been added to CImGui, so it's no
  longer necessary to copy and paste the examples around.
- The renderloop also integrates with the new
  [ImGuiTestEngine.jl](https://github.com/JuliaImGui/ImGuiTestEngine.jl) to make
  it possible to write automated tests.

### Changed
- CImGui.jl now uses semantic versioning to make development easier. This
  release is based on [Dear ImGui
  1.90.8](https://github.com/ocornut/imgui/releases/tag/v1.90.8).
- **Breaking**: LibCImGui.jl has been merged into `CImGui.lib`, again for the
  sake of ease of development.
- **Breaking**: The custom backends that we developed,
  [ImGuiOpenGLBackend.jl](https://github.com/JuliaImGui/ImGuiOpenGLBackend.jl)
  and [ImGuiGLFWBackend.jl](https://github.com/JuliaImGui/ImGuiGLFWBackend.jl),
  have been deprecated in favour of using ImGui's official backends. With this
  change we also dropped support for OpenGL 2, but purely out of laziness. If
  you need OpenGL 2 let us know and we can build and ship the official OpenGL 2
  backend.
- **Breaking**: The built-in renderloop is implemented using package extensions,
  which are only available on Julia 1.9+. Hence the new minimum required Julia
  version is 1.9.

### Deprecated
- `GetKeyIndex()` has been [deprecated
  upstream](https://github.com/ocornut/imgui/blob/6d948ab47ecf984239af01434f3ed03808dbf188/imgui.h#L3532). It
  will be removed in a future release.

## [v1.89.1] - 2024-05-19

### Fixed
- Fixed the implementations of [SetScrollX()](@ref) and [SetScrollY()](@ref) ([#115]).
