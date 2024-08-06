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
    elseif type === :sine
        [Point2f(i, sin(i * 0.1) + 0.5) for i in 1:N]
    end
end

function HelpMarker(msg)
    ig.TextDisabled("(?)")

    if ig.IsItemHovered() && ig.BeginTooltip()
        ig.PushTextWrapPos(ig.GetFontSize() * 35.0)
        ig.TextUnformatted(msg)
        ig.PopTextWrapPos()
        ig.EndTooltip()
    end
end

function makie_demo(; engine=nothing)
    # Create a plot
    f = Figure()
    scene = Makie.get_scene(f)
    ax1 = Axis(f[1, 1]; title="Random data")
    data = Observable(generate_data())
    lines!(ax1, data, label="Random data")
    lines!(ax1, generate_data(:sine), label="Sin")
    data2 = Observable(generate_data())
    axislegend(ax1)

    ax2 = Axis(f[2, 1])
    lines!(ax2, data2)

    ctx = ig.CreateContext()
    io = ig.GetIO()
    io.ConfigFlags = unsafe_load(io.ConfigFlags) | ig.lib.ImGuiConfigFlags_DockingEnable
    io.ConfigFlags = unsafe_load(io.ConfigFlags) | ig.lib.ImGuiConfigFlags_ViewportsEnable

    auto_resize_x = true
    auto_resize_y = false
    tooltip = true
    stats = true
    stream_data = false

    data_task = nothing
    function live_data(obs::Observable)
        obs_data = obs[]

        while stream_data
            push!(obs_data, Point2f(length(obs_data), rand()))
            obs[] = obs_data
            autolimits!(ax1)
            sleep(0.01)
        end

        data_task = nothing
    end

    # Start the GUI
    ig.render(ctx; engine, window_size=(1280, 760), window_title="ImGui Window", opengl_version=v"3.3") do
        ig.Begin("Makie demo")

        if ig.Button("Random data")
            data[] = generate_data()
        end

        @c ig.Checkbox("Auto resize X", &auto_resize_x)
        ig.SameLine()
        @c ig.Checkbox("Auto resize Y", &auto_resize_y)
        ig.SameLine()
        @c ig.Checkbox("Draw tooltip", &tooltip)
        ig.SameLine()
        @c ig.Checkbox("Show render times", &stats)
        ig.SameLine()
        @c ig.Checkbox("Stream data", &stream_data)

        if stream_data && isnothing(data_task)
            data_task = errormonitor(Threads.@spawn live_data(data))
        end

        ig.MakieFigure("plot", f; auto_resize_x, auto_resize_y, tooltip, stats)

        ig.Text("Mouse position in scene: $(scene.events.mouseposition[])")
        ig.Text("Scene size: $(size(scene))")

        # These extra transformations are necessary to handle non-linear axis
        # scales. See: https://github.com/MakieOrg/Makie.jl/pull/4090.
        x, y = mouseposition(ax1)
        x = Makie.inverse_transform(ax1.xscale[])(x)
        y = Makie.inverse_transform(ax1.yscale[])(y)
        ig.Text("Mouse position in ax1: ($x, $y)")

        ig.End()
    end
end

# Run automatically if the script is launched from the command-line
if !isempty(Base.PROGRAM_FILE)
    makie_demo()
end
