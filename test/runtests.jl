using Test
import CImGui as ig
using ImGuiTestEngine
import ImGuiTestEngine as te
import ModernGL, GLFW


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
    engine = te.CreateContext()#; exit_on_completion=false, show_test_window=true)
    # engine_io = te.GetIO(engine)
    # engine_io.ConfigRunSpeed = te.RunSpeed_Normal

    @register_test(engine, "Julia demo", "About window") do ctx
        SetRef("ImGui Demo")
        MenuClick("Help/About Dear ImGui")

        Yield() # Let it run another frame so that the new window can be drawn
        @imcheck GetWindowByRef("//About Dear ImGui") != nothing

        SetRef("About Dear ImGui")
        ItemCheck("Config\\/Build Information")
    end

    @register_test(engine, "Configuration", "ConfigFlags") do ctx
        SetRef("ImGui Demo")
        ItemClick("Configuration")
        ItemClick("Configuration##2")
        SetRef("ImGui Demo/Configuration##2")
        ItemCheck("io.ConfigFlags: NoMouse")
    end

    @register_test(engine, "Widgets", "Selectables") do ctx
        SetRef("ImGui Demo")
        ItemClick("Widgets")
        ItemClick("Selectables")
        ItemClick("Selectables/Basic")
        SetRef("ImGui Demo/Selectables/Basic")
        ItemDoubleClick("5. I am double clickable")

        SetRef("ImGui Demo")
        ItemClick("Plots Widgets")
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
