module LibCImGui

import Libdl

# Load in `deps.jl`, complaining if it does not exist
const depsjl_path = joinpath(@__DIR__, "..", "deps", "deps.jl")
if !isfile(depsjl_path)
    error("CImGui was not build properly. Please run Pkg.build(\"CImGui\").")
end
include(depsjl_path)
# Module initialization function
function __init__()
    check_deps()
end

using CSyntax.CEnum

const Ctm = Base.Libc.TmStruct
const Ctime_t = UInt
const Cclock_t = UInt
export Ctm, Ctime_t, Cclock_t

include(joinpath(@__DIR__, "..", "gen", "libcimgui_common.jl"))
include(joinpath(@__DIR__, "..", "gen", "libcimgui_api.jl"))
include(joinpath(@__DIR__, "..", "gen", "libhelper_api.jl"))

foreach(names(@__MODULE__, all=true)) do s
    if startswith(string(s), "ig") || startswith(string(s), "Im")
        @eval export $s
    end
end

end # module
