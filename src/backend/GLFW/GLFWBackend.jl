module GLFWBackend

using Libdl
using GLFW
using Blobs
using ..LibCImGui

include("callbacks.jl")

include("impl.jl")
export GlfwClientApi, GlfwClientApi_Unknown, GlfwClientApi_OpenGL, GlfwClientApi_Vulkan
export igImplGlfw_Init
export igImplGlfw_InitForOpenGL, igImplGlfw_InitForVulkan
export igImplGlfw_Shutdown
export igImplGlfw_NewFrame

function __init__()
    global g_Window = C_NULL
    global g_ClientApi = GlfwClientApi_Unknown
    global g_Time = 0.0
    global g_MouseJustPressed = [false, false, false, false, false]
    global g_MouseCursors = [GLFW.Cursor(C_NULL) for i = 1:Int(ImGuiMouseCursor_COUNT)]

    global g_ImplGlfw_GetClipboardText = dlsym(dlopen(GLFW.lib), :glfwGetClipboardString)
    global g_ImplGlfw_SetClipboardText = dlsym(dlopen(GLFW.lib), :glfwSetClipboardString)
end

end # module
