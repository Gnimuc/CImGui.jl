using LibCImGui
using Test

@testset "Dock" begin
    @test IMGUI_HAS_DOCK == 1
end
