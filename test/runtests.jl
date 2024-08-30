using Test
import CImGui as ig
using ImGuiTestEngine
import ImGuiTestEngine as te
import ModernGL, GLFW

ig.set_backend(:GlfwOpenGL3)


# Note: these tests may not be portable
@testset "Setting renderloop threads" begin
    if Threads.nthreads() == 1
        @warn "Skipping the renderloop threads test because we're only running with one thread."
        return
    elseif Threads.nthreads(:default) == 0 || Threads.nthreads(:interactive) == 0
        @warn "Skipping the renderloop threads test because one of the threadpools is empty."
        return
    end

    ctx = ig.CreateContext()

    # The default thread should be 1
    tid = -1
    ig.render(ctx) do
        tid = Threads.threadid()
        return :imgui_exit_loop
    end
    @test tid == 1

    # Test pinning to a specific thread ID
    ctx = ig.CreateContext()
    ig.render(ctx; spawn=2) do
        tid = Threads.threadid()
        return :imgui_exit_loop
    end
    @test tid == 2

    # Test pinning to a threadpool
    ctx = ig.CreateContext()
    ig.render(ctx; spawn=:interactive) do
        tid = Threads.threadid()
        return :imgui_exit_loop
    end
    @test tid in Threads.threadpooltids(:interactive)

    # Test pinning to any thread, which should prioritize the interactive
    # threadpool.
    ctx = ig.CreateContext()
    ret = ig.render(ctx; spawn=true) do
        tid = Threads.threadid()
        return :imgui_exit_loop
    end
    @test tid in Threads.threadpooltids(:interactive)

    # When not spawning it should run on the current thread
    ctx = ig.CreateContext()
    tid = -1
    ig.render(ctx; spawn=false) do
        tid = Threads.threadid()
        return :imgui_exit_loop
    end
    @test tid == Threads.threadid()

    # It should return a Task when wait=false
    ctx = ig.CreateContext()
    ret = ig.render(Returns(:imgui_exit_loop), ctx; wait=false)
    wait(ret)
end

include(joinpath(@__DIR__, "../demo/demo.jl"))

@testset "Official demo" begin
    @test ig.imgui_version() isa VersionNumber
    engine = te.CreateContext()

    @register_test(engine, "Official demo", "Hiding demo window") do ctx
        @imcheck GetWindowByRef("Dear ImGui Demo") != nothing

        SetRef("Hello, world!")
        ItemClick("Demo Window") # This should hide the demo window

        @imcheck GetWindowByRef("Dear ImGui Demo") == nothing
    end

    official_demo(; engine)

    te.DestroyContext(engine)
end

include(joinpath(@__DIR__, "../examples/demo.jl"))

@testset "Julia demo" begin
    engine = te.CreateContext(; exit_on_completion=true)
    engine_io = te.GetIO(engine)
    # engine_io.ConfigRunSpeed = te.RunSpeed_Normal

    @register_test(engine, "Julia demo", "About window") do ctx
        SetRef("ImGui Demo")
        MenuClick("Help/About Dear ImGui")

        Yield() # Let it run another frame so that the new window can be drawn
        @imcheck GetWindowByRef("//About Dear ImGui") != nothing

        SetRef("About Dear ImGui")
        ItemCheck("Config\\/Build Information")
    end

    @register_test(engine, "Examples", "Main menu bar") do ctx
        SetRef("ImGui Demo")
        MenuClick("Examples/Main menu bar")

        SetRef("##MainMenuBar")
        MenuClick("File/Open Recent/More../Recurse..")
        MenuClick("File/Options")
        MenuClick("File/Colors")
        MenuClick("File/Quit")
    end

    @register_test(engine, "Examples", "Long text display") do ctx
        SetRef("ImGui Demo")
        MenuClick("Examples/Long text display")

        SetRef("Example: Long text display")
        ItemClick("Add 1000 lines")
        ComboClickAll("Test type")
    end

    @register_test(engine, "Examples", "Constrained-resizing window") do ctx
        SetRef("ImGui Demo")
        MenuClick("Examples/Constrained-resizing window")

        SetRef("Example: Constrained Resize")
        ComboClickAll("Constraint")
    end

    @register_test(engine, "Configuration", "ConfigFlags") do ctx
        SetRef("ImGui Demo")
        ItemClick("Configuration")
        ItemClick("Configuration##2")
        SetRef("ImGui Demo/Configuration##2")
        ItemCheck("io.ConfigFlags: NoMouse")
    end

    @register_test(engine, "Julia demo", "Widgets") do ctx
        SetRef("ImGui Demo")
        ItemClick("Widgets")

        # We do double-clicks to open and then close the sections
        ItemDoubleClick("Basic")
        ItemDoubleClick("Trees/Basic trees")
        ItemDoubleClick("Trees/Advanced, with Selectable nodes")
        ItemClick("Trees") # Close the 'Trees' section
        ItemDoubleClick("Collapsing Headers")
        ItemDoubleClick("Bullets")
        ItemDoubleClick("Text/Colored Text")
        ItemDoubleClick("Text/Word Wrapping")
        ItemClick("Text") # Close the 'Text' section
        ItemDoubleClick("Images")
        ItemDoubleClick("Combo")

        ItemClick("Selectables/Basic")
        SetRef("ImGui Demo/Selectables/Basic")
        ItemDoubleClick("5. I am double clickable")
        SetRef("ImGui Demo")
        ItemClick("Selectables")

        ItemDoubleClick("Filtered Text Input")
        ItemDoubleClick("Multi-line Text Input")
        ItemDoubleClick("Plots Widgets")
        ItemDoubleClick("Color\\/Picker Widgets")
        ItemDoubleClick("Range Widgets")
        ItemDoubleClick("Multi-component Widgets")
        ItemDoubleClick("Vertical Sliders")
        ItemDoubleClick("Drag and Drop")
        ItemDoubleClick("Querying Status (Active\\/Focused\\/Hovered etc.)")

        ItemClick("Widgets") # Close the 'Widgets' section
    end

    @register_test(engine, "Julia demo", "Layout") do ctx
        SetRef("ImGui Demo")
        ItemClick("Layout")

        ItemClick("Child windows")
        ItemDoubleClick("Child windows/Disable Mouse Wheel")
        ItemDoubleClick("Child windows/Disable Menu")
        ItemClick("Child windows")

        ItemDoubleClick("Widgets Width")
        ItemDoubleClick("Basic Horizontal Layout")

        ItemClick("Tabs")
        ItemDoubleClick("Tabs/Basic")
        ItemDoubleClick("Tabs/Advanced & Close Button")
        ItemClick("Tabs")

        ItemDoubleClick("Groups")

        ItemClick("Layout")
    end

    @register_test(engine, "Julia demo", "Popups & modal windows") do ctx
        SetRef("ImGui Demo")
        OpenAndClose("Popups & Modal windows") do
            OpenAndClose("Popups") do
                ItemDoubleClick("Popups/Select..")
                ItemDoubleClick("Popups/Toggle..")
                ItemDoubleClick("Popups/File Menu..")
            end

            OpenAndClose("Context menus") do
                ItemClick("Context menus/Button: Label1###Button", ig.ImGuiMouseButton_Right)
                ItemClick("//\$FOCUSED/Close")
            end

            OpenAndClose("Modals") do
                ItemClick("Modals/Delete..")
                ItemClick("//\$FOCUSED/OK")

                ItemClick("Modals/Stacked modals..")
                ItemClick("//\$FOCUSED/Add another modal..")
                ItemClick("//\$FOCUSED/Close")
                ItemClick("//\$FOCUSED/Close")
            end

            ItemDoubleClick("Menus inside a regular window")
        end
    end

    @register_test(engine, "Julia demo", "Columns") do ctx
        SetRef("ImGui Demo")
        OpenAndClose("Columns") do
            OpenAndClose("Columns/Basic")
            OpenAndClose("Columns/Mixed items")
            OpenAndClose("Columns/Word-wrapping")
            OpenAndClose("Columns/Borders") do
                ItemClick("Columns/Borders/horizontal")
                ItemClick("Columns/Borders/vertical")
            end
            OpenAndClose("Columns/Tree within single cell") do
                ItemClick("Columns/Tree within single cell/Hello")
            end
        end
    end

    @register_test(engine, "Julia demo", "Inputs") do ctx
        SetRef("ImGui Demo")
        OpenAndClose("Inputs, Navigation & Focus") do
            section = "Keyboard, Mouse & Navigation State"
            OpenAndClose("Keyboard, Mouse & Navigation State") do
                MouseMove("$section/Hovering me sets the\nkeyboard capture flag")
                ItemClick("$section/Holding me clears the\nthe keyboard capture flag")
            end

            OpenAndClose("Tabbing")
            OpenAndClose("Focus from code")
            OpenAndClose("Dragging")
            OpenAndClose("Mouse cursors")
        end
    end

    julia_demo(; engine)

    te.DestroyContext(engine)
end

include(joinpath(@__DIR__, "../examples/makie_demo.jl"))

@testset "MakieFigure" begin
    engine = te.CreateContext()

    @register_test(engine, "Makie demo", "Simple plot") do ctx
        SetRef("Makie demo")
        ItemClick("Random data")
    end

    makie_demo(; engine)
    te.DestroyContext(engine)
end
