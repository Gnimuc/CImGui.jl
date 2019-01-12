module OpenGLBackend

using ModernGL
using Blobs
using ..LibCImGui

include("impl.jl")
export igImplOpenGL3_Init, igImplOpenGL3_Shutdown
export igImplOpenGL3_NewFrame
export igImplOpenGL3_RenderDrawData
export igImplOpenGL3_CreateFontsTexture, igImplOpenGL3_DestroyFontsTexture
export igImplOpenGL3_CreateDeviceObjects, igImplOpenGL3_DestroyDeviceObjects

function __init__()
    global g_FontTexture = GLuint(0)
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
end

end # module
