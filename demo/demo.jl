using CImGui
using CImGui.LibCImGui
using CImGui.GLFWBackend
using CImGui.OpenGLBackend
using GLFW, ModernGL
using CSyntax
using Printf

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
GLFW.SwapInterval(1)  # enable vsync

# setup Dear ImGui context
ctx = CImGui.CreateContext()
io = CImGui.GetIO()

# setup Dear ImGui style
CImGui.StyleColorsDark()
# CImGui.StyleColorsClassic()
# CImGui.StyleColorsLight()

# setup Platform/Renderer bindings
ImGui_ImplGlfw_InitForOpenGL(window, true)
ImGui_ImplOpenGL3_Init()

show_demo_window = true
show_another_window = false
counter = 0
f = Cfloat(0.0)
clear_color = Cfloat[0.45, 0.55, 0.60, 1.00]
while !GLFW.WindowShouldClose(window)
    # oh my global scope
    global show_demo_window; global show_another_window
    global counter; global f; global clear_color;

    GLFW.PollEvents()
    # start the Dear ImGui frame
    ImGui_ImplOpenGL3_NewFrame()
    ImGui_ImplGlfw_NewFrame()
    CImGui.NewFrame()

    # show the big demo window
    show_demo_window && @c igShowDemoWindow(&show_demo_window)

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

    # show another simple window.
    if show_another_window
        @c CImGui.Begin("Another Window", &show_another_window)  # pass a pointer to our bool variable (the window will have a closing button that will clear the bool when clicked)
        # CImGui.Text("Hello from another window!")
        CImGui.Button("Close Me") && (show_another_window = false;)
        CImGui.End()
    end

    # rendering
    CImGui.Render()
    GLFW.MakeContextCurrent(window)
    display_w, display_h = GLFW.GetFramebufferSize(window)
    glViewport(0, 0, display_w, display_h)
    glClearColor(clear_color...)
    glClear(GL_COLOR_BUFFER_BIT)
    ImGui_ImplOpenGL3_RenderDrawData(igGetDrawData())

    GLFW.MakeContextCurrent(window)
    GLFW.SwapBuffers(window)
end

# cleanup
ImGui_ImplOpenGL3_Shutdown()
ImGui_ImplGlfw_Shutdown()
CImGui.DestroyContext(ctx)

GLFW.DestroyWindow(window)
