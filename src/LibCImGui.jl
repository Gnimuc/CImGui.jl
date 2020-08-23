module LibCImGui

using CImGui_jll
export CImGui_jll

using CSyntax.CEnum

const Ctm = Base.Libc.TmStruct
const Ctime_t = UInt
const Cclock_t = UInt
export Ctm, Ctime_t, Cclock_t

include(joinpath(@__DIR__, "..", "gen", "libcimgui_common.jl"))
include(joinpath(@__DIR__, "..", "gen", "libcimgui_api.jl"))
include(joinpath(@__DIR__, "..", "gen", "libhelper_api.jl"))
include(joinpath(@__DIR__, "libcimgui_patch.jl"))

foreach(names(@__MODULE__, all=true)) do s
    if startswith(string(s), "ig") || startswith(string(s), "Im")
        @eval export $s
    end
end

end # module
