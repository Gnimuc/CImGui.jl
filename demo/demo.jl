using Printf

using CImGui
import CImGui.CSyntax: @c, @cstatic

# Load deps for the GLFW/OpenGL backend
import GLFW
import ModernGL

# Setup Dear ImGui context
CImGui.set_backend(:GlfwOpenGL3)

function official_demo(; engine=nothing)
    ctx = CImGui.CreateContext()

    # Enable docking and multi-viewport
    io = CImGui.GetIO()
    io.ConfigFlags = unsafe_load(io.ConfigFlags) | CImGui.ImGuiConfigFlags_DockingEnable
    io.ConfigFlags = unsafe_load(io.ConfigFlags) | CImGui.ImGuiConfigFlags_ViewportsEnable

    # Setup Dear ImGui style
    CImGui.StyleColorsDark()
    # CImGui.StyleColorsClassic()
    # CImGui.StyleColorsLight()

    # Load fonts
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

    show_demo_window = true
    show_another_window = false
    clear_color = Cfloat[0.45, 0.55, 0.60, 1.00]

    # for tests
    timeout = parse(Int, get(ENV, "AUTO_CLOSE_DEMO", "0"))
    timer = Timer(timeout)

    CImGui.render(ctx; window_title="Demo", clear_color=Ref(clear_color), engine) do
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

        if haskey(ENV, "AUTO_CLOSE_DEMO") && !isopen(timer)
            return :imgui_exit_loop
        end

        # Yield for the timer
        yield()
    end
end

# Run automatically if the script is launched from the command-line
if !isempty(Base.PROGRAM_FILE)
    official_demo()
end
