module GLFWBackend

using Libdl
using GLFW
using ..LibCImGui
using CImGui: FLT_MAX, AddInputCharacter
using CImGui: GetIO, Set_KeyMap, Set_KeysDown, Get_KeysDown, Set_MouseDown, GetMouseCursor

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

function __init__()
    global g_Window = C_NULL
    global g_ClientApi = GlfwClientApi_Unknown
    global g_Time = 0.0
    global g_MouseJustPressed = [false, false, false, false, false]
    global g_MouseCursors = [GLFW.Cursor(C_NULL) for i = 1:ImGuiMouseCursor_COUNT]
    global g_ImplGlfw_GetClipboardText = dlsym(dlopen(GLFW.lib), :glfwGetClipboardString)
    global g_ImplGlfw_SetClipboardText = dlsym(dlopen(GLFW.lib), :glfwSetClipboardString)
    global g_CustomCallbackMousebutton = C_NULL
    global g_CustomCallbackScroll = C_NULL
    global g_CustomCallbackKey = C_NULL
    global g_CustomCallbackChar = C_NULL
end

end # module
