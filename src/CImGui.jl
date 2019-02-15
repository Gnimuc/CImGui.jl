module CImGui

include("LibCImGui.jl")
using .LibCImGui

include("convert.jl")
include("wrapper.jl")

include("backend/GLFW/GLFWBackend.jl")
using .GLFWBackend

include("backend/OpenGL/OpenGLBackend.jl")
using .OpenGLBackend

end # module
