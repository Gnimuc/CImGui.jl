module CImGui

using CSyntax

include("LibCImGui.jl")
using .LibCImGui

const FLT_MAX = igGET_FLT_MAX()

include("helper.jl")
include("wrapper.jl")

const IMGUI_VERSION = GetVersion()

include("backend/GLFW/GLFWBackend.jl")
using .GLFWBackend

include("backend/OpenGL/OpenGLBackend.jl")
using .OpenGLBackend

end # module
