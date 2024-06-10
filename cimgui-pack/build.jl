import GLFW_jll

cd(@__DIR__) do
    if !isdir("build")
        mkdir("build")
    end

    cd("build") do
        run(`cmake -DCMAKE_BUILD_TYPE=Release -DGLFW_LIBRARY=$(GLFW_jll.libglfw) ..`)
        nprocs = Sys.CPU_THREADS
        run(`cmake --build . -j$(nprocs)`)
    end
end
