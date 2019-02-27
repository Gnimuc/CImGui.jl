using CImGui
using CImGui.CSyntax
using CImGui.GLFWBackend
using CImGui.OpenGLBackend
using CImGui.GLFWBackend.GLFW
using CImGui.OpenGLBackend.ModernGL
using Printf
using Makie, GLMakie

include(joinpath(@__DIR__, "demo_window.jl"))

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
# fonts_dir = joinpath(@__DIR__, "..", "fonts")
# fonts = CImGui.GetIO().Fonts
# default_font = CImGui.AddFontDefault(fonts)
# CImGui.AddFontFromFileTTF(fonts, joinpath(fonts_dir, "Cousine-Regular.ttf"), 15)
# CImGui.AddFontFromFileTTF(fonts, joinpath(fonts_dir, "DroidSans.ttf"), 16)
# CImGui.AddFontFromFileTTF(fonts, joinpath(fonts_dir, "Karla-Regular.ttf"), 10)
# CImGui.AddFontFromFileTTF(fonts, joinpath(fonts_dir, "ProggyTiny.ttf"), 10)
# CImGui.AddFontFromFileTTF(fonts, joinpath(fonts_dir, "Roboto-Medium.ttf"), 16)
# @assert default_font != C_NULL

scene = scatter(rand(9))
window = GLMakie.getscreen(scene) |> GLMakie.to_native

# setup Platform/Renderer bindings
ImGui_ImplGlfw_InitForOpenGL(window, true)
ImGui_ImplOpenGL3_Init(glsl_version)

demo_open = true
clear_color = Cfloat[0.45, 0.55, 0.60, 1.00]
while !GLFW.WindowShouldClose(window)
    global demo_open # oh my global scope

    GLFW.PollEvents()
    # start the Dear ImGui frame
    ImGui_ImplOpenGL3_NewFrame()
    ImGui_ImplGlfw_NewFrame()
    CImGui.NewFrame()

    demo_open && @c ShowDemoWindow(&demo_open)

    # rendering
    CImGui.Render()
    GLFW.MakeContextCurrent(window)
    display_w, display_h = GLFW.GetFramebufferSize(window)
    glViewport(0, 0, display_w, display_h)
    glClearColor(clear_color...)
    glClear(GL_COLOR_BUFFER_BIT)
    ImGui_ImplOpenGL3_RenderDrawData(CImGui.GetDrawData())

    GLFW.MakeContextCurrent(window)
    GLFW.SwapBuffers(window)
end

# cleanup
ImGui_ImplOpenGL3_Shutdown()
ImGui_ImplGlfw_Shutdown()
CImGui.DestroyContext(ctx)
GLMakie.destroy!(screen)
# GLFW.DestroyWindow(window)
