using CImGui
using CImGui.LibCImGui
using CImGui.GLFWBackend
using CImGui.OpenGLBackend
using GLFW, ModernGL
using CSyntax
using Printf

include(joinpath(@__DIR__, "main_menu_bar.jl"))

@static if Sys.isapple()
    # OpenGL 3.2 + GLSL 150
    const glsl_version = "#version 150"
    GLFW.WindowHint(GLFW.CONTEXT_VERSION_MAJOR, 3)
    GLFW.WindowHint(GLFW.CONTEXT_VERSION_MINOR, 2)
    GLFW.WindowHint(GLFW.OPENGL_PROFILE, GLFW.OPENGL_CORE_PROFILE) # 3.2+ only
    GLFW.WindowHint(GLFW.OPENGL_FORWARD_COMPAT, GL_TRUE) # required on Mac
else
    # OpenGL 3.0 + GLSL 130
    const glsl_version = "#version 130"
    GLFW.WindowHint(GLFW.CONTEXT_VERSION_MAJOR, 3)
    GLFW.WindowHint(GLFW.CONTEXT_VERSION_MINOR, 0)
    # GLFW.WindowHint(GLFW.OPENGL_PROFILE, GLFW.OPENGL_CORE_PROFILE) # 3.2+ only
    # GLFW.WindowHint(GLFW.OPENGL_FORWARD_COMPAT, GL_TRUE) # 3.0+ only
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

# load Fonts
# - If no fonts are loaded, dear imgui will use the default font. You can also load multiple fonts and use `CImGui.PushFont/PopFont` to select them.
# - `CImGui.AddFontFromFileTTF` will return the `Ptr{ImFont}` so you can store it if you need to select the font among multiple.
# - If the file cannot be loaded, the function will return C_NULL. Please handle those errors in your application (e.g. use an assertion, or display an error and quit).
# - The fonts will be rasterized at a given size (w/ oversampling) and stored into a texture when calling ImFontAtlas::Build()/GetTexDataAsXXXX(), which `ImGui_ImplXXXX_NewFrame` below will call.
# - Read 'fonts/README.txt' for more instructions and details.
fonts_dir = joinpath(@__DIR__, "..", "fonts")
fonts = ImGuiIO_Get_Fonts(io)
default_font = ImFontAtlas_AddFontDefault(fonts, C_NULL)
ImFontAtlas_AddFontFromFileTTF(fonts, joinpath(fonts_dir, "Cousine-Regular.ttf"), 15, C_NULL, C_NULL)
ImFontAtlas_AddFontFromFileTTF(fonts, joinpath(fonts_dir, "DroidSans.ttf"), 16, C_NULL, C_NULL)
ImFontAtlas_AddFontFromFileTTF(fonts, joinpath(fonts_dir, "Karla-Regular.ttf"), 10, C_NULL, C_NULL)
ImFontAtlas_AddFontFromFileTTF(fonts, joinpath(fonts_dir, "ProggyTiny.ttf"), 10, C_NULL, C_NULL)
ImFontAtlas_AddFontFromFileTTF(fonts, joinpath(fonts_dir, "Roboto-Medium.ttf"), 16, C_NULL, C_NULL)
@assert default_font != C_NULL

# setup Platform/Renderer bindings
ImGui_ImplGlfw_InitForOpenGL(window, true)
ImGui_ImplOpenGL3_Init()

clear_color = Cfloat[0.45, 0.55, 0.60, 1.00]
while !GLFW.WindowShouldClose(window)
    # oh my global scope
    global clear_color;

    GLFW.PollEvents()
    # start the Dear ImGui frame
    ImGui_ImplOpenGL3_NewFrame()
    ImGui_ImplGlfw_NewFrame()
    CImGui.NewFrame()


    show_app_main_menubar()


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
