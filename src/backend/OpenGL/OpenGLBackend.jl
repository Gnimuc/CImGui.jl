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

const g_GlslVersion = Ref(130)
const g_FontTextures = GLuint[]
const g_ShaderHandle = Ref(GLuint(0))
const g_VertHandle = Ref(GLuint(0))
const g_FragHandle = Ref(GLuint(0))
const g_AttribLocationTex = Ref(GLint(0))
const g_AttribLocationProjMtx = Ref(GLint(0))
const g_AttribLocationVtxPos = Ref(GLint(0))
const g_AttribLocationVtxUV = Ref(GLint(0))
const g_AttribLocationVtxColor = Ref(GLint(0))
const g_VboHandle = Ref(GLuint(0))
const g_ElementsHandle = Ref(GLuint(0))
const g_ImageTexture = Dict{Int,GLuint}()

end # module
