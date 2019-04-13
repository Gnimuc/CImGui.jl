using CImGui
using CImGui.LibCImGui
using CImGui.GLFWBackend
using CImGui.OpenGLBackend
using GLFW, ModernGL
using CSyntax
using Printf
@static if Sys.isapple()
    # OpenGL 3.2 + GLSL 150
    const glsl_version = 150
    GLFW.WindowHint(GLFW.CONTEXT_VERSION_MAJOR, 3)
    GLFW.WindowHint(GLFW.CONTEXT_VERSION_MINOR, 2)
    GLFW.WindowHint(GLFW.OPENGL_PROFILE, GLFW.OPENGL_CORE_PROFILE) # 3.2+ only
    GLFW.WindowHint(GLFW.OPENGL_FORWARD_COMPAT, GL_TRUE) # required on Mac
else
    # OpenGL 3.0 + GLSL 130
    const glsl_version = 130
    GLFW.WindowHint(GLFW.CONTEXT_VERSION_MAJOR, 3)
    GLFW.WindowHint(GLFW.CONTEXT_VERSION_MINOR, 0)
    # GLFW.WindowHint(GLFW.OPENGL_PROFILE, GLFW.OPENGL_CORE_PROFILE) # 3.2+ only
    # GLFW.WindowHint(GLFW.OPENGL_FORWARD_COMPAT, GL_TRUE) # 3.0+ only
end
# setup GLFW error callback
error_callback(err::GLFW.GLFWError) = @error "GLFW ERROR: code $(err.code) msg: $(err.description)"
GLFW.SetErrorCallback(error_callback)
# first window and its context
window1 = GLFW.CreateWindow(1280, 720, "Demo")
@assert window1 != C_NULL
GLFW.MakeContextCurrent(window1)
ctx1 = CImGui.CreateContext()
CImGui.StyleColorsDark()
ImGui_ImplGlfw_InitForOpenGL(window1, true)
ImGui_ImplOpenGL3_Init(glsl_version)
# second window and its context
window2 = GLFW.CreateWindow(800, 600, "Demo2")
@assert window2 != C_NULL
GLFW.MakeContextCurrent(window2)
ctx2 = CImGui.CreateContext()
CImGui.SetCurrentContext(ctx2)  # swap context
CImGui.StyleColorsLight()
ImGui_ImplGlfw_InitForOpenGL(window2, true)
ImGui_ImplOpenGL3_Init(glsl_version)
show_demo_window = true
show_another_window = false
counter = 0
f = Cfloat(0.0)
clear_color = Cfloat[0.45, 0.55, 0.60, 1.00]
window1_open = true
window2_open = true
while window1_open || window2_open
    # oh my global scope
    global show_demo_window; global show_another_window
    global counter; global f; global clear_color;
    global window1_open; global window2_open;
    GLFW.PollEvents()
    GLFW.WindowShouldClose(window1) && (window1_open = false;)
    GLFW.WindowShouldClose(window2) && (window2_open = false;)
    if window1_open
        GLFW.MakeContextCurrent(window1)
        CImGui.SetCurrentContext(ctx1)
        GLFW.PollEvents()
        # append ctx1's frame
        ImGui_ImplOpenGL3_NewFrame()
        ImGui_ImplGlfw_NewFrame(window1)
        CImGui.NewFrame()
        # show the big demo window
        show_demo_window && @c igShowDemoWindow(&show_demo_window)
        # render window1
        CImGui.Render()
        GLFW.MakeContextCurrent(window1)
        display_w, display_h = GLFW.GetFramebufferSize(window1)
        glViewport(0, 0, display_w, display_h)
        glClearColor(clear_color...)
        glClear(GL_COLOR_BUFFER_BIT)
        ImGui_ImplOpenGL3_RenderDrawData(igGetDrawData())
        GLFW.SwapBuffers(window1)
    else
        GLFW.HideWindow(window1)
    end
    # window 2
    if window2_open
        GLFW.MakeContextCurrent(window2)
        CImGui.SetCurrentContext(ctx2)
        GLFW.PollEvents()
        # append ctx2's frame
        ImGui_ImplOpenGL3_NewFrame()
        ImGui_ImplGlfw_NewFrame(window2)
        CImGui.NewFrame()
        # show a simple window that we create ourselves.
        # we use a Begin/End pair to created a named window.
        CImGui.Begin("Hello, world!")  # create a window called "Hello, world!" and append into it.
        CImGui.Text("This is some useful text.")  # display some text
        @c CImGui.Checkbox("Demo Window", &show_demo_window)  # edit bools storing our window open/close state
        @c CImGui.Checkbox("Another Window", &show_another_window)
        @c CImGui.SliderFloat("float", &f, 0, 1)  # edit 1 float using a slider from 0 to 1
        CImGui.ColorEdit3("clear color", clear_color)  # edit 3 floats representing a color
        CImGui.Button("Button") && (counter += 1)
        CImGui.SameLine()
        CImGui.Text("counter = $counter")
        CImGui.Text(@sprintf("Application average %.3f ms/frame (%.1f FPS)", 1000 / ImGuiIO_Get_Framerate(CImGui.GetIO()), ImGuiIO_Get_Framerate(CImGui.GetIO())))
        CImGui.End()
        CImGui.Render()
        GLFW.MakeContextCurrent(window2)
        display_w, display_h = GLFW.GetFramebufferSize(window2)
        glViewport(0, 0, display_w, display_h)
        glClearColor(clear_color...)
        glClear(GL_COLOR_BUFFER_BIT)
        ImGui_ImplOpenGL3_RenderDrawData(igGetDrawData())
        GLFW.MakeContextCurrent(window2)
        GLFW.SwapBuffers(window2)
    else
        GLFW.HideWindow(window2)
    end
end
# cleanup
ImGui_ImplOpenGL3_Shutdown()
ImGui_ImplGlfw_Shutdown()
CImGui.DestroyContext(ctx1)
CImGui.DestroyContext(ctx2)
GLFW.DestroyWindow(window1)
GLFW.DestroyWindow(window2)
