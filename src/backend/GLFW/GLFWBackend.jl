module GLFWBackend

using Libdl
using GLFW
using ..LibCImGui
using CImGui: FLT_MAX, AddInputCharacter
using CImGui: GetIO, GetMouseCursor, c_get, c_set!

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

const g_Window = Ref{GLFW.Window}()
const g_ClientApi = Ref(GlfwClientApi_Unknown)
const g_Time = Ref(0.0)
const g_MouseJustPressed = [false, false, false, false, false]
const g_MouseCursors = [GLFW.Cursor(C_NULL) for i = 1:ImGuiMouseCursor_COUNT]
const g_ImplGlfw_GetClipboardText = Ref(C_NULL)
const g_ImplGlfw_SetClipboardText = Ref(C_NULL)
const g_CustomCallbackMousebutton = Ref{Any}(C_NULL)
const g_CustomCallbackScroll = Ref{Any}(C_NULL)
const g_CustomCallbackKey = Ref{Any}(C_NULL)
const g_CustomCallbackChar = Ref{Any}(C_NULL)

function __init__()
    g_ImplGlfw_GetClipboardText[] = dlsym(dlopen(GLFW.libglfw), :glfwGetClipboardString)
    g_ImplGlfw_SetClipboardText[] = dlsym(dlopen(GLFW.libglfw), :glfwSetClipboardString)
end

end # module
