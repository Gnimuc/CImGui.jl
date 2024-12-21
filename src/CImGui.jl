module CImGui

using CSyntax
using CEnum
using CEnum: Cenum, name_value_pairs
import Compat: @compat
import DocStringExtensions: TYPEDSIGNATURES


include("lib.jl")
using .lib

const IM_COL32_R_SHIFT = 0
const IM_COL32_G_SHIFT = 8
const IM_COL32_B_SHIFT = 16
const IM_COL32_A_SHIFT = 24
const IM_COL32_A_MASK  = 0xff000000
IM_COL32(R,G,B,A) = (ImU32(A)<<IM_COL32_A_SHIFT) | (ImU32(B)<<IM_COL32_B_SHIFT) | (ImU32(G)<<IM_COL32_G_SHIFT) | (ImU32(R)<<IM_COL32_R_SHIFT)

const IM_COL32_WHITE       = IM_COL32(255,255,255,255)  # opaque white = 0xffffffff
const IM_COL32_BLACK       = IM_COL32(0,0,0,255)        # opaque black
const IM_COL32_BLACK_TRANS = IM_COL32(0,0,0,0)          # transparent black = 0x00000000
const IMGUI_PAYLOAD_TYPE_COLOR_3F = "_COL3F"
const IMGUI_PAYLOAD_TYPE_COLOR_4F = "_COL4F"
const FLT_MAX = igGET_FLT_MAX()
const FLT_MIN = igGET_FLT_MIN()

Base.convert(::Type{ImVec2}, x::NTuple{2}) = ImVec2(x...)
Base.convert(::Type{ImVec2}, x::Vector) = ImVec2(x...)
Base.convert(::Type{ImVec4}, x::NTuple{4}) = ImVec4(x...)
Base.convert(::Type{ImVec4}, x::Vector) = ImVec4(x...)
Base.convert(::Type{ImVec4}, x::ImU32) = ColorConvertU32ToFloat4(x)
Base.convert(::Type{ImU32}, x::ImVec4) = ColorConvertFloat4ToU32(x)

Base.:~(x::Cenum{UInt32}) = ~UInt32(x)
Base.:(:)(a::T, b::Cenum) where {T<:Integer} = a:T(b)
Base.:(:)(a::Cenum, b::T) where {T<:Integer} = T(a):b

"""
    imgui_version()::VersionNumber

Return the upstream ImGui version.
"""
function imgui_version()
    VersionNumber(unsafe_string(igGetVersion()))
end

function ShowFlags(::Type{T}) where {T<:Cenum}
    io = IOBuffer()
    s = "```\n"
    for (n,v) in name_value_pairs(T)
        s *= string(n)*" $v \n"
    end
    s*"\n```"
end
GetFlags(::Type{T}) where {T<:Cenum} = name_value_pairs(T) |> collect

# These two functions give 'unbound type parameter' warnings from Aqua.jl
# because if a Ptr{NTuple{0}} is passed the 'T' parameter cannot be
# deduced. Kinda annoying, but if someone's passing a pointer to zero bytes
# there's bigger problems.
function c_get(x::Ptr{NTuple{N,T}}, i) where {N,T}
    unsafe_load(Ptr{T}(x), Integer(i)+1)
end

function c_set!(x::Ptr{NTuple{N,T}}, i, v) where {N,T}
    unsafe_store!(Ptr{T}(x), v, Integer(i)+1)
end

include("wrapper.jl")
include("extras.jl")

const IMGUI_VERSION = unsafe_string(GetVersion())

# Helper function to pin tasks to a specific thread. We need this because
# OpenGL/GLFW/ImGui are not threadsafe so task migration could cause segfaults.
function pintask!(task::Task, tid::Integer)
    if tid ∉ Threads.threadpooltids(:default) && tid ∉ Threads.threadpooltids(:interactive)
        error("Thread ID '$tid' does not exist in the :default or :interactive threadpool, cannot schedule a task onto it.")
    end

    task.sticky = true
    ret = ccall(:jl_set_task_tid, Cint, (Any, Cint), task, tid - 1)

    if Threads.threadid(task) != tid
        error("jl_set_task_tid() onto Julia thread ID $tid failed!")
    end
end

# This is implemented by the MakieIntegration extension but we document it here
# so that we don't have to install GLMakie to build the docs.
"""
    MakieFigure(id::String, f::GLMakie.Figure;
                auto_resize_x=true, auto_resize_y=false,
                tooltip=true, stats=false)

Display a Makie figure in ImGui. See
[`examples/makie_demo.jl`](https://github.com/JuliaImGui/CImGui.jl/blob/master/examples/makie_demo.jl)
for an example of how to use it.

These are the [interaction
events](https://docs.makie.org/stable/explanations/events#The-Events-struct)
that are wired up and can be used:
- `hasfocus`
- `entered_window`
- `mousebutton`
- `mouseposition`

Known issues:
- Mouse events aren't delivered unless the mouse is hovered over the figure, so
  dragging the mouse from within the figure to somewhere outside the figure will
  keep the old mouse state. e.g. if you're RMB panning and the mouse goes
  outside the figure, when it enters the figure again panning will resume even
  the RMB was released.
- Note that scrolling to zoom will also cause the ImGui window to scroll, which
  can be annoying. This may be fixed in the future by using some other key
  combination for scrolling to zoom.
- Sometimes zooming way out or in can trigger segfaults if a CImGui window has
  been opened multiple times in the same process (e.g. when experimenting in the
  REPL). Some resources probably aren't getting cleaned up properly.

!!! note
    GLMakie requires OpenGL 3.3, on some systems you will need to explicitly
    pass `opengl_version=v"3.3"` (or higher) to [`render()`](@ref) to fix OpenGL
    shader errors.

!!! warning
    This is very experimental, you will almost definitely encounter bugs (and if
    so please submit an issue/PR). We don't consider this covered under semver
    yet so there may be breaking changes in minor releases.
"""
function MakieFigure end

## Backends

const _exit_handlers = Function[]
atrenderexit(f::Function) = push!(_exit_handlers, f)

# These are backend functions that must be implemented by package extensions
function _render end
function _create_image_texture end
function _update_image_texture end
function _destroy_image_texture end
function _current_window end

const _backend = Ref{Symbol}()

"""
    set_backend(backend::Symbol)

Set the backend to use. Currently supported backends are:
- `:GlfwOpenGL3` (GLFW/OpenGL3, requires ModernGL.jl and GLFW.jl)
"""
function set_backend(backend::Symbol)
    if backend ∉ (:GlfwOpenGL3,)
        throw(ArgumentError("Unrecognized backend: $(backend)"))
    end

    global _backend[] = backend
end

function _check_backend()
    if !isassigned(_backend)
        error("You must call `CImGui.set_backend()` to the backend you want before calling this function, e.g. `CImGui.set_backend(:GlfwOpenGL3)` for the GLFW/OpenGL3 backend.")
    end
end

"""
    render(ui::Function, ctx::Ptr{lib.ImGuiContext}; kwargs...)

Top-level function to call a renderloop implemented by the backend selected by
[`set_backend()`](@ref). This function will not return until the program exits,
either by the user closing the window or `ui()` returning `:imgui_exit_loop`. It
will also not yield the loop, though you may explicitly call `yield()` in
`ui()`.

# Arguments
Positional arguments:
- `ui`: The function to execute in the renderloop. This where all the GUI code
  with calls to CImGui should go.
- `ctx`: The ImGui context to use. Note that [`DestroyContext()`](@ref) will
  automatically be called on it at the end of the renderloop, so it will be
  unusable afterwards.

Keyword arguments:
- `hotloading=true`: Enable calling the latest version of `ui()` using
  `@invokelatest`. This is handy when using Revise.jl.
- `on_exit::Union{Function, Nothing}=nothing`: A destructor/finalizer function
  that will be called before destroying `ctx`. This might be useful if you're
  using some external library that needs to be cleaned up in a certain order.
- `clear_color=Cfloat[0.45, 0.55, 0.60, 1.00]`: The color of the window
  background. This can also be a `Ref{Vector{Cfloat}}` if you want to control
  the color dynamically (see the official demo for an example).
- `window_size=(1280, 720)`: The initial size of the window.
- `window_title="CImGui"`: The window title.
- `engine=nothing`: An optional `ImGuiTestEngine.Engine` instance. If there are
  any tests registered with the test engine they will be queued and run
  automatically.
- `opengl_version::VersionNumber=v"3.2"`: The OpenGL version to use.
- `spawn::Union{Bool, Integer, Symbol}=1`: How/where to spawn the
  renderloop. It defaults to thread 1 for safety, but note that currently Julia
  also uses thread 1 to run the libuv event loop:
  [#50643](https://github.com/JuliaLang/julia/issues/50643). The renderloop does
  `yield()` on each iteration but it's still likely to hog thread 1 which may
  cause libuv things like task switching to become slower. In most cases this is
  unlikely to be a problem, but keep it in mind if you observe IO/task heavy
  things being slower than you'd expect.

  Possible values are:
  - `true`: a thread will automatically be chosen, preferring the `:interactive`
    threadpool.
  - `false`: don't spawn a task at all. The caller is reponsible for disabling
    task migration etc.
  - An `Integer`: the task will be pinned to this thread ID.
  - `:default`/`:interactive`: the task will be pinned to an arbitrary thread in
    the threadpool.

  !!! warning
      Only thread 1 is sure to be portable across platforms, do otherwise at
      your own risk. See also:
      - The [thread safety
        docs](https://www.glfw.org/docs/latest/intro_guide.html#thread_safety).
      - [This answer](https://discourse.glfw.org/t/multithreading-glfw/573/5)
        describing platform requirements.

- `wait::Bool=true`: Block until the spawned renderloop task exits.
"""
function render(args...; kwargs...)
    _check_backend()
    _render(args..., Val(_backend[]); kwargs...)
end

function current_window()
    _check_backend()
    _current_window(Val(_backend[]))
end

function create_image_texture(args...; kwargs...)
    _check_backend()
    _create_image_texture(Val(_backend[]), args...; kwargs...)
end

function update_image_texture(args...; kwargs...)
    _check_backend()
    _update_image_texture(Val(_backend[]), args...; kwargs...)
end

function destroy_image_texture(args...; kwargs...)
    _check_backend()
    _destroy_image_texture(Val(_backend[]), args...; kwargs...)
end

## Test engine

# These are implemented by ImGuiTestEngine.jl
function _test_engine_is_running end
function _start_test_engine end
function _show_test_window end


function __init__()
    Base.Experimental.register_error_hint(MethodError) do io, exc, argtypes, kwargs
        if exc.f === _render
            if isempty(methods(exc.f))
                print(io, "\nrender() cannot be called yet. You must load the packages for supported backends, e.g. `import ModernGL, GLFW` for the GLFW/OpenGL3 backend.")
            end
        elseif exc.f === MakieFigure
            if isempty(methods(exc.f))
                print(io, "\nMakieFigure() cannot be called yet, you must load GLMakie with e.g. `import GLMakie`.")
            end
        end
    end
end

end # module
