module GLFWBackend

using Libdl
using GLFW
using ..LibCImGui

function c_get(x::Ptr{NTuple{N,T}}, i) where {N,T}
    unsafe_load(Ptr{T}(x), Integer(i)+1)
end

function c_set!(x::Ptr{NTuple{N,T}}, i, v) where {N,T}
    unsafe_store!(Ptr{T}(x), v, Integer(i)+1)
end

struct ImGuiViewportDataGlfw
    Window::Ptr{Cvoid}
    WindowOwned::Bool
    IgnoreWindowPosEventFrame::Cint
    IgnoreWindowSizeEventFrame::Cint
end

function Base.getproperty(x::Ptr{ImGuiViewportDataGlfw}, f::Symbol)
    f === :Window && return Ptr{Ptr{Cvoid}}(x + fieldoffset(ImGuiViewportDataGlfw,1))
    f === :WindowOwned && return Ptr{Bool}(x + fieldoffset(ImGuiViewportDataGlfw,2))
    f === :IgnoreWindowPosEventFrame && return Ptr{Cint}(x + fieldoffset(ImGuiViewportDataGlfw,3))
    f === :IgnoreWindowSizeEventFrame && return Ptr{Cint}(x + fieldoffset(ImGuiViewportDataGlfw,4))
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{ImGuiViewportDataGlfw}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

include("callbacks.jl")
export SetCustomMouseButtonCallback
export SetCustomScrollCallback
export SetCustomKeyCallback
export SetCustomCharCallback

include("impl.jl")
export GlfwClientApi, GlfwClientApi_Unknown, GlfwClientApi_OpenGL, GlfwClientApi_Vulkan
export ImGui_ImplGlfw_Init
export ImGui_ImplGlfw_InitForOpenGL, ImGui_ImplGlfw_InitForVulkan
export ImGui_ImplGlfw_Shutdown
export ImGui_ImplGlfw_NewFrame

const g_Window = Ref{GLFW.Window}(GLFW.Window(C_NULL))
const g_ClientApi = Ref(GlfwClientApi_Unknown)
const g_Time = Ref{Cfloat}(0.0)
const g_MouseJustPressed = [false, false, false, false, false]
const g_MouseCursors = [GLFW.Cursor(C_NULL) for i = 1:ImGuiMouseCursor_COUNT]
const g_KeyOwnerWindows = fill(GLFW.Window(C_NULL), 512)
const g_InstalledCallbacks = Ref{Bool}(false)
const g_WantUpdateMonitors = Ref{Bool}(true)

const g_ImplGlfw_GetClipboardText = Ref(C_NULL)
const g_ImplGlfw_SetClipboardText = Ref(C_NULL)

const g_CustomCallbackMousebutton = Ref{Any}(C_NULL)
const g_CustomCallbackScroll = Ref{Any}(C_NULL)
const g_CustomCallbackKey = Ref{Any}(C_NULL)
const g_CustomCallbackChar = Ref{Any}(C_NULL)

const g_Monitors = Vector{ImGuiPlatformMonitor}(undef, 0)
const g_MainViewportData = Ref{ImGuiViewportDataGlfw}()

function __init__()
    g_ImplGlfw_GetClipboardText[] = dlsym(dlopen(GLFW.libglfw), :glfwGetClipboardString)
    g_ImplGlfw_SetClipboardText[] = dlsym(dlopen(GLFW.libglfw), :glfwSetClipboardString)
end

end # module
