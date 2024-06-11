import WrapIt: wrapit
import CxxWrap
import GLFW_jll


cxxwrap_prefix = CxxWrap.prefix_path()

# Generate the imgui_test_engine wrappers
cd(joinpath(@__DIR__, "test_engine")) do
    # Write the config file from the template
    config = read("config.template.toml", String)
    new_config = replace(config,
                         "{CXXWRAP_INCLUDE_DIR}" => joinpath(cxxwrap_prefix, "include"),
                         "{JULIA_INCLUDE_DIR}" => joinpath(dirname(Sys.BINDIR), "include/julia"))
    write("config.toml", new_config)

    rm("src/overrides.h"; force=true)
    wrapit("config.toml"; force=true, verbosity=0)
end

cd(@__DIR__) do
    if !isdir("build")
        mkdir("build")
    end

    cp("test_engine/overrides.h", "test_engine/src/overrides.h"; force=true)

    cd("build") do
        run(`cmake -DCMAKE_BUILD_TYPE=Release
                   -DGLFW_LIBRARY=$(GLFW_jll.libglfw)
                   -DCMAKE_PREFIX_PATH=$(cxxwrap_prefix) ..`)
        nprocs = Sys.CPU_THREADS
        run(`cmake --build . -j$(nprocs)`)
    end
end
