using CImGui
using CImGui.lib
using CImGui.CSyntax

import GLFW
import ModernGL as GL

include(joinpath(@__DIR__, "demo_window.jl"))

CImGui.set_backend(:GlfwOpenGL3)

function julia_demo(; engine=nothing)
    # setup Dear ImGui context
    ctx = CImGui.CreateContext()

    # enable docking and multi-viewport
    io = CImGui.GetIO()
    io.ConfigFlags = io.ConfigFlags | CImGui.ImGuiConfigFlags_DockingEnable
    io.ConfigFlags = io.ConfigFlags | CImGui.ImGuiConfigFlags_ViewportsEnable

    # setup Dear ImGui style
    CImGui.StyleColorsDark()
    # CImGui.StyleColorsClassic()
    # CImGui.StyleColorsLight()

    # When viewports are enabled we tweak WindowRounding/WindowBg so platform windows can look identical to regular ones.
    style = Ptr{ImGuiStyle}(CImGui.GetStyle())
    if io.ConfigFlags & ImGuiConfigFlags_ViewportsEnable == ImGuiConfigFlags_ViewportsEnable
        style.WindowRounding = 5.0f0
        col = CImGui.c_get(style.Colors, CImGui.ImGuiCol_WindowBg)
        CImGui.c_set!(style.Colors, CImGui.ImGuiCol_WindowBg, ImVec4(col.x, col.y, col.z, 1.0f0))
    end

    # load Fonts
    # - If no fonts are loaded, dear imgui will use the default font. You can also load multiple fonts and use `CImGui.PushFont/PopFont` to select them.
    # - `CImGui.AddFontFromFileTTF` will return the `Ptr{ImFont}` so you can store it if you need to select the font among multiple.
    # - If the file cannot be loaded, the function will return C_NULL. Please handle those errors in your application (e.g. use an assertion, or display an error and quit).
    # - The fonts will be rasterized at a given size (w/ oversampling) and stored into a texture when calling `CImGui.Build()`/`GetTexDataAsXXXX()``, which `ImGui_ImplXXXX_NewFrame` below will call.
    # - Read 'fonts/README.txt' for more instructions and details.
    fonts_dir = joinpath(@__DIR__, "..", "fonts")
    fonts = CImGui.GetIO().Fonts
    # default_font = CImGui.AddFontDefault(fonts)
    # CImGui.AddFontFromFileTTF(fonts, joinpath(fonts_dir, "Cousine-Regular.ttf"), 15)
    # CImGui.AddFontFromFileTTF(fonts, joinpath(fonts_dir, "DroidSans.ttf"), 16)
    # CImGui.AddFontFromFileTTF(fonts, joinpath(fonts_dir, "Karla-Regular.ttf"), 10)
    # CImGui.AddFontFromFileTTF(fonts, joinpath(fonts_dir, "ProggyTiny.ttf"), 10)
    # CImGui.AddFontFromFileTTF(fonts, joinpath(fonts_dir, "Roboto-Medium.ttf"), 16)
    CImGui.AddFontFromFileTTF(fonts, joinpath(fonts_dir, "Recursive Mono Casual-Regular.ttf"), 16)
    CImGui.AddFontFromFileTTF(fonts, joinpath(fonts_dir, "Recursive Mono Linear-Regular.ttf"), 16)
    CImGui.AddFontFromFileTTF(fonts, joinpath(fonts_dir, "Recursive Sans Casual-Regular.ttf"), 16)
    CImGui.AddFontFromFileTTF(fonts, joinpath(fonts_dir, "Recursive Sans Linear-Regular.ttf"), 16)
    # @assert default_font != C_NULL

    # create texture for image drawing
    img_width, img_height = 256, 256
    image_id = nothing

    demo_open = true
    clear_color = Cfloat[0.45, 0.55, 0.60, 1.00]

    CImGui.render(ctx; engine, clear_color=Ref(clear_color)) do
        if isnothing(image_id)
            image_id = CImGui.create_image_texture(img_width, img_height)
        end

        demo_open && @c ShowJuliaDemoWindow(&demo_open)

        # show image example
        if CImGui.Begin("Image Demo")
            image = rand(GL.GLubyte, 4, img_width, img_height)
            CImGui.update_image_texture(image_id, image, img_width, img_height)
            CImGui.Image(Ptr{Cvoid}(image_id), CImGui.ImVec2(img_width, img_height))
            CImGui.End()
        end
    end
end


# Run automatically if the script is launched from the command-line
if !isempty(Base.PROGRAM_FILE)
    julia_demo()
end
