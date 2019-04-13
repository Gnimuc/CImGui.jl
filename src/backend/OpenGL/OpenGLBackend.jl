module OpenGLBackend

using ModernGL
using CSyntax
using CSyntax.CEnum
using ..LibCImGui
using ..CImGui: GetIO, GetTexDataAsRGBA32, SetTexID

include("impl.jl")
export ImGui_ImplOpenGL3_Init, ImGui_ImplOpenGL3_Shutdown
export ImGui_ImplOpenGL3_NewFrame
export ImGui_ImplOpenGL3_RenderDrawData
export ImGui_ImplOpenGL3_CreateFontsTexture, ImGui_ImplOpenGL3_DestroyFontsTexture
export ImGui_ImplOpenGL3_CreateDeviceObjects, ImGui_ImplOpenGL3_DestroyDeviceObjects
export ImGui_ImplOpenGL3_CreateImageTexture, ImGui_ImplOpenGL3_UpdateImageTexture, ImGui_ImplOpenGL3_DestroyImageTexture

function __init__()
    global g_GlslVersion = 130
    global g_FontTextures = GLuint[]
    global g_ShaderHandle = GLuint(0)
    global g_VertHandle = GLuint(0)
    global g_FragHandle = GLuint(0)
    global g_AttribLocationTex = GLint(0)
    global g_AttribLocationProjMtx = GLint(0)
    global g_AttribLocationPosition = GLint(0)
    global g_AttribLocationUV = GLint(0)
    global g_AttribLocationColor = GLint(0)
    global g_VboHandle = GLuint(0)
    global g_ElementsHandle = GLuint(0)
    global g_ImageTexture = Dict{Int,GLuint}()
end

end # module
