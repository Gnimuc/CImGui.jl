using CImGui
using CImGui.CSyntax
using CImGui.CSyntax.CStatic
using ImGuiGLFWBackend #CImGui.GLFWBackend
using ImGuiOpenGLBackend #CImGui.OpenGLBackend
using ImGuiGLFWBackend.LibGLFW # #CImGui.OpenGLBackend.GLFW
using ImGuiOpenGLBackend.ModernGL
using Printf

@static if Sys.isapple()
    # OpenGL 3.2 + GLSL 150
    const glsl_version = 150
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3)
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 2)
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE) # 3.2+ only
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE) # required on Mac
else
    # OpenGL 3.0 + GLSL 130
    const glsl_version = 130
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3)
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 0)
    # glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE) # 3.2+ only
    # glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE) # 3.0+ only
end

# setup GLFW error callback
#? error_callback(err::GLFW.GLFWError) = @error "GLFW ERROR: code $(err.code) msg: $(err.description)"
#? GLFW.SetErrorCallback(error_callback)

# create window
window = glfwCreateWindow(1280, 720, "Demo", C_NULL, C_NULL)
@assert window != C_NULL
glfwMakeContextCurrent(window)
glfwSwapInterval(1)  # enable vsync

# setup Dear ImGui context
ctx = CImGui.CreateContext()

# setup Dear ImGui style
CImGui.StyleColorsDark()
# CImGui.StyleColorsClassic()
# CImGui.StyleColorsLight()

# load Fonts
# - If no fonts are loaded, dear imgui will use the default font. You can also load multiple fonts and use `CImGui.PushFont/PopFont` to select them.
# - `CImGui.AddFontFromFileTTF` will return the `Ptr{ImFont}` so you can store it if you need to select the font among multiple.
# - If the file cannot be loaded, the function will return C_NULL. Please handle those errors in your application (e.g. use an assertion, or display an error and quit).
# - The fonts will be rasterized at a given size (w/ oversampling) and stored into a texture when calling `CImGui.Build()`/`GetTexDataAsXXXX()``, which `ImGui_ImplXXXX_NewFrame` below will call.
# - Read 'fonts/README.txt' for more instructions and details.
fonts_dir = joinpath(@__DIR__, "..", "fonts")
fonts = unsafe_load(CImGui.GetIO().Fonts)
# default_font = CImGui.AddFontDefault(fonts)
# CImGui.AddFontFromFileTTF(fonts, joinpath(fonts_dir, "Cousine-Regular.ttf"), 15)
# CImGui.AddFontFromFileTTF(fonts, joinpath(fonts_dir, "DroidSans.ttf"), 16)
# CImGui.AddFontFromFileTTF(fonts, joinpath(fonts_dir, "Karla-Regular.ttf"), 10)
# CImGui.AddFontFromFileTTF(fonts, joinpath(fonts_dir, "ProggyTiny.ttf"), 10)
CImGui.AddFontFromFileTTF(fonts, joinpath(fonts_dir, "Roboto-Medium.ttf"), 16)
# @assert default_font != C_NULL

# setup Platform/Renderer bindings
glfw_ctx = ImGuiGLFWBackend.create_context(window, install_callbacks = true)
ImGuiGLFWBackend.init(glfw_ctx)
opengl_ctx = ImGuiOpenGLBackend.create_context(glsl_version)
ImGuiOpenGLBackend.init(opengl_ctx)

try
    show_demo_window = true
    show_another_window = false
    clear_color = Cfloat[0.45, 0.55, 0.60, 1.00]
    while glfwWindowShouldClose(window) == 0
        glfwPollEvents()
        # start the Dear ImGui frame
        ImGuiOpenGLBackend.new_frame(opengl_ctx) #ImGui_ImplOpenGL3_NewFrame()
        ImGuiGLFWBackend.new_frame(glfw_ctx) #ImGui_ImplGlfw_NewFrame()
        CImGui.NewFrame()

        # show the big demo window
        show_demo_window && @c CImGui.ShowDemoWindow(&show_demo_window)

        # show a simple window that we create ourselves.
        # we use a Begin/End pair to created a named window.
        @cstatic f=Cfloat(0.0) counter=Cint(0) begin
            CImGui.Begin("Hello, world!")  # create a window called "Hello, world!" and append into it.
            CImGui.Text("This is some useful text.")  # display some text
            @c CImGui.Checkbox("Demo Window", &show_demo_window)  # edit bools storing our window open/close state
            @c CImGui.Checkbox("Another Window", &show_another_window)

            @c CImGui.SliderFloat("float", &f, 0, 1)  # edit 1 float using a slider from 0 to 1
            CImGui.ColorEdit3("clear color", clear_color)  # edit 3 floats representing a color
            CImGui.Button("Button") && (counter += 1)

            CImGui.SameLine()
            CImGui.Text("counter = $counter")
            CImGui.Text(@sprintf("Application average %.3f ms/frame (%.1f FPS)", 1000 / unsafe_load(CImGui.GetIO().Framerate), unsafe_load(CImGui.GetIO().Framerate)))

            CImGui.End()
        end

        # show another simple window.
        if show_another_window
            @c CImGui.Begin("Another Window", &show_another_window)  # pass a pointer to our bool variable (the window will have a closing button that will clear the bool when clicked)
            CImGui.Text("Hello from another window!")
            CImGui.Button("Close Me") && (show_another_window = false;)
            CImGui.End()
        end

        # rendering
        CImGui.Render()
        glfwMakeContextCurrent(window)

        width, height = Ref{Cint}(), Ref{Cint}() #! need helper fcn
        glfwGetFramebufferSize(window, width, height)
        display_w = width[]
        display_h = height[]
        
        glViewport(0, 0, display_w, display_h)
        glClearColor(clear_color...)
        glClear(GL_COLOR_BUFFER_BIT)
        ImGuiOpenGLBackend.render(opengl_ctx) #ImGui_ImplOpenGL3_RenderDrawData(CImGui.GetDrawData())

        glfwMakeContextCurrent(window)
        glfwSwapBuffers(window)
    end
catch e
    @error "Error in renderloop!" exception=e
    Base.show_backtrace(stderr, catch_backtrace())
finally
    ImGuiOpenGLBackend.shutdown(opengl_ctx) #ImGui_ImplOpenGL3_Shutdown()
    ImGuiGLFWBackend.shutdown(glfw_ctx) #ImGui_ImplGlfw_Shutdown()
    CImGui.DestroyContext(ctx)
    glfwDestroyWindow(window)
end
