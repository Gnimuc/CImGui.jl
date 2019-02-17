module CImGui

include("LibCImGui.jl")
using .LibCImGui

const FLT_MAX = igGET_FLT_MAX()
const IMGUI_VERSION = unsafe_string(igGetVersion())

include("convert.jl")
include("wrapper.jl")

include("backend/GLFW/GLFWBackend.jl")
using .GLFWBackend

include("backend/OpenGL/OpenGLBackend.jl")
using .OpenGLBackend

end # module
