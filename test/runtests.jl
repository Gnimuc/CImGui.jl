using CImGui
using Test

@testset "CImGui.jl" begin
    # if CI only run if linux given xvfb is available in CI
    if !haskey(ENV, "CI") || Sys.islinux() && Sys.WORD_SIZE == 64
        withenv("AUTO_CLOSE_DEMO" => "5") do
            include(joinpath("..", "demo", "demo.jl"))
        end
    else
        @warn "Tests not run" haskey(ENV, "CI") Sys.islinux() Sys.WORD_SIZE
    end
end
