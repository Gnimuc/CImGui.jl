module CImGui

using CSyntax
using CSyntax.CEnum
using CSyntax.CEnum: Cenum, name_value_pairs

include("LibCImGui.jl")
using .LibCImGui

# missing macros
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

include("helper.jl")
include("wrapper.jl")

const IMGUI_VERSION = unsafe_string(GetVersion())

include("backend/GLFW/GLFWBackend.jl")
using .GLFWBackend

include("backend/OpenGL/OpenGLBackend.jl")
using .OpenGLBackend

end # module
