module CImGui

include("LibCImGui.jl")
using .LibCImGui

const FLT_MAX = igGET_FLT_MAX()
const IMGUI_VERSION = igGetVersion()

include("helper.jl")
include("wrapper.jl")

include("backend/GLFW/GLFWBackend.jl")
using .GLFWBackend

include("backend/OpenGL/OpenGLBackend.jl")
using .OpenGLBackend

end # module
