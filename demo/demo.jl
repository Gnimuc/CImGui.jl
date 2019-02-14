using CImGui
using CImGui.LibCImGui
using CImGui.GLFWBackend
using CImGui.OpenGLBackend
using GLFW, ModernGL
using CSyntax

@static if Sys.isapple()
    const VERSION_MAJOR = 3
    const VERSION_MINOR = 3
end

@static if Sys.isapple()
    GLFW.WindowHint(GLFW.CONTEXT_VERSION_MAJOR, VERSION_MAJOR)
    GLFW.WindowHint(GLFW.CONTEXT_VERSION_MINOR, VERSION_MINOR)
    GLFW.WindowHint(GLFW.OPENGL_PROFILE, GLFW.OPENGL_CORE_PROFILE)
    GLFW.WindowHint(GLFW.OPENGL_FORWARD_COMPAT, GL_TRUE)
else
    GLFW.DefaultWindowHints()
end

# setup GLFW error callback
error_callback(err::GLFW.GLFWError) = @error "GLFW ERROR: code $(err.code) msg: $(err.description)"
GLFW.SetErrorCallback(error_callback)

# create window
window = GLFW.CreateWindow(1280, 720, "Demo")
@assert window != C_NULL
GLFW.MakeContextCurrent(window)
GLFW.SwapInterval(1)

# setup Dear ImGui context
ctx = igCreateContext(C_NULL)
io = igGetIO()

# setup Dear ImGui style
igStyleColorsDark(C_NULL)

# setup Platform/Renderer bindings
igImplGlfw_InitForOpenGL(window, true)
igImplOpenGL3_Init()

show_demo_window = true
show_another_window = false
clear_color = ImVec4(0.45, 0.55, 0.60, 1.00)
while !GLFW.WindowShouldClose(window)
    GLFW.PollEvents()

    igImplOpenGL3_NewFrame()
    igImplGlfw_NewFrame()
    igNewFrame()

    global show_demo_window
    x = Ref{Bool}(show_demo_window)
    igShowDemoWindow(x)

    # rendering
    igRender()
    GLFW.MakeContextCurrent(window)
    display_w, display_h = GLFW.GetFramebufferSize(window)
    glViewport(0, 0, display_w, display_h)
    glClearColor(clear_color.x, clear_color.y, clear_color.z, clear_color.w)
    glClear(GL_COLOR_BUFFER_BIT)
    igImplOpenGL3_RenderDrawData(igGetDrawData())

    GLFW.MakeContextCurrent(window)
    GLFW.SwapBuffers(window)
end

# cleanup
igImplOpenGL3_Shutdown()
igImplGlfw_Shutdown()
igDestroyContext(ctx)

GLFW.DestroyWindow(window)
