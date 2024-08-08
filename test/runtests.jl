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
