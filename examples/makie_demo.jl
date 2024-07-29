import GLFW
using GLMakie
import GLMakie.Makie as Makie
import CImGui as ig
import CImGui.CSyntax: @c
import ModernGL as gl


ig.set_backend(:GlfwOpenGL3)

function generate_data(type::Symbol=:random, N=1000)
    if type === :random
        [Point2f(i, rand()) for i in 1:N]
    end
end

function HelpMarker(msg)
    ig.TextDisabled("(?)");

    if ig.IsItemHovered() && ig.BeginTooltip()
        ig.PushTextWrapPos(ig.GetFontSize() * 35.0);
        ig.TextUnformatted(msg);
        ig.PopTextWrapPos();
        ig.EndTooltip();
    end
end

function makie_demo(; engine=nothing)
    # Create a plot
    f = Figure()
    scene = Makie.get_scene(f)
    ax1 = Axis(f[1, 1]; title="Random data")
    data = Observable(generate_data())
    lines!(ax1, data)
    data2 = Observable(generate_data())
    ax2 = Axis(f[2, 1])
    lines!(ax2, data2)

    ctx = ig.CreateContext()
    io = ig.GetIO()
    io.ConfigFlags = unsafe_load(io.ConfigFlags) | ig.lib.ImGuiConfigFlags_DockingEnable
    io.ConfigFlags = unsafe_load(io.ConfigFlags) | ig.lib.ImGuiConfigFlags_ViewportsEnable

    ax1_tight_spacing = true
    auto_resize_x = true
    auto_resize_y = false

    # Start the GUI
    ig.render(ctx; engine, window_size=(1280, 760), window_title="ImGui Window") do
        ig.Begin("Makie demo")

        if ig.Button("Random data")
            data[] = generate_data()
        end

        @c ig.Checkbox("Ax1 tight tick spacing", &ax1_tight_spacing)
        ig.SameLine()
        HelpMarker("""
                   Try zooming into the top plot, if this option is disabled
                   the axis will not resize itself to stop clipping the tick labels on the Y axis.
                   """)

        @c ig.Checkbox("Auto resize X", &auto_resize_x)
        ig.SameLine()
        @c ig.Checkbox("Auto resize Y", &auto_resize_y)

        if ig.MakieFigure("plot", f; auto_resize_x, auto_resize_y)
            if ax1_tight_spacing
                Makie.tight_ticklabel_spacing!(ax1)
            end

            Makie.tight_ticklabel_spacing!(ax2)
        end

        ig.Text("Mouse position in scene: $(scene.events.mouseposition[])")
        ig.Text("Scene size: $(size(scene))")
        ig.Text("Mouse position in ax1: $(mouseposition(ax1))")

        ig.End()
    end
end

# Run automatically if the script is launched from the command-line
if !isempty(Base.PROGRAM_FILE)
    makie_demo()
end
