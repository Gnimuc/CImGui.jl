module GlfwOpenGLBackend

import CSyntax: @c
import CImGui
import LibCImGui as lib
import GLFW
import ModernGL as GL

const g_ImageTexture = Dict{Int, GL.GLuint}()

@static if Sys.isapple()
    # OpenGL 3.2 + GLSL 150
    const glsl_version = 150
    GLFW.WindowHint(GLFW.CONTEXT_VERSION_MAJOR, 3)
    GLFW.WindowHint(GLFW.CONTEXT_VERSION_MINOR, 2)
    GLFW.WindowHint(GLFW.OPENGL_PROFILE, GLFW.OPENGL_CORE_PROFILE) # 3.2+ only
    GLFW.WindowHint(GLFW.OPENGL_FORWARD_COMPAT, GL.GL_TRUE) # required on Mac
else
    # OpenGL 3.0 + GLSL 130
    const glsl_version = 130
    GLFW.WindowHint(GLFW.CONTEXT_VERSION_MAJOR, 3)
    GLFW.WindowHint(GLFW.CONTEXT_VERSION_MINOR, 0)
    # GLFW.WindowHint(GLFW.OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE) # 3.2+ only
    # GLFW.WindowHint(GLFW.OPENGL_FORWARD_COMPAT, GL_TRUE) # 3.0+ only
end


function CImGui._create_image_texture(::Val{:GlfwOpenGL3}, image_width, image_height; format=GL.GL_RGBA, type=GL.GL_UNSIGNED_BYTE)
    id = GL.GLuint(0)
    @c GL.glGenTextures(1, &id)
    GL.glBindTexture(GL.GL_TEXTURE_2D, id)
    GL.glTexParameteri(GL.GL_TEXTURE_2D, GL.GL_TEXTURE_MIN_FILTER, GL.GL_LINEAR)
    GL.glTexParameteri(GL.GL_TEXTURE_2D, GL.GL_TEXTURE_MAG_FILTER, GL.GL_LINEAR)
    GL.glPixelStorei(GL.GL_UNPACK_ROW_LENGTH, 0)
    GL.glTexImage2D(GL.GL_TEXTURE_2D, 0, format, GL.GLsizei(image_width), GL.GLsizei(image_height), 0, format, type, C_NULL)
    g_ImageTexture[id] = id
    return Int(id)
end

function CImGui._update_image_texture(::Val{:GlfwOpenGL3}, id, image_data, image_width, image_height; format=GL.GL_RGBA, type=GL.GL_UNSIGNED_BYTE)
    GL.glBindTexture(GL.GL_TEXTURE_2D, g_ImageTexture[id])
    GL.glTexSubImage2D(GL.GL_TEXTURE_2D, 0, 0, 0, GL.GLsizei(image_width), GL.GLsizei(image_height), format, type, image_data)
end

function CImGui._destroy_image_texture(::Val{:GlfwOpenGL3}, id)
    id = g_ImageTexture[id]
    @c GL.glDeleteTextures(1, &id)
    delete!(g_ImageTexture, id)
    return true
end

function CImGui._render(ui, ctx::Ptr{lib.ImGuiContext}, ::Val{:GlfwOpenGL3};
                        hotloading=true,
                        on_exit=nothing,
                        clear_color=Cfloat[0.45, 0.55, 0.60, 1.00],
                        window_size=(1280, 720),
                        window_title="CImGui",
                        engine=nothing)
    if clear_color isa Ref && !isassigned(clear_color)
        throw(ArgumentError("'clear_color' is a unassigned reference, it must be initialized properly."))
    end

    if !isnothing(engine)
        CImGui._start_test_engine(engine, ctx)
    end

    GLFW.Init()

    # Create window
    window = GLFW.CreateWindow(window_size[1], window_size[2], window_title)
    @assert window != C_NULL
    GLFW.MakeContextCurrent(window)
    GLFW.SwapInterval(1)  # enable vsync

    # Setup Platform/Renderer bindings
    lib.ImGui_ImplGlfw_InitForOpenGL(Ptr{lib.GLFWwindow}(window.handle), true)
    lib.ImGui_ImplOpenGL3_Init("#version $(glsl_version)")

    try
        while !GLFW.WindowShouldClose(window)
            GLFW.PollEvents()

            # Start the Dear ImGui frame
            lib.ImGui_ImplOpenGL3_NewFrame()
            lib.ImGui_ImplGlfw_NewFrame()
            CImGui.NewFrame()

            result = if hotloading
                @invokelatest ui()
            else
                ui()
            end

            if !isnothing(engine) && engine.show_test_window
                CImGui._show_test_window(engine)
            end

            tests_completed = (!isnothing(engine)
                               && engine.exit_on_completion
                               && !CImGui._test_engine_is_running(engine))
            if result === :imgui_exit_loop || tests_completed
                GLFW.SetWindowShouldClose(window, true)
            end

            # Rendering
            CImGui.Render()
            GLFW.MakeContextCurrent(window)

            display_w, display_h = GLFW.GetFramebufferSize(window)

            GL.glViewport(0, 0, display_w, display_h)
            GL.glClearColor((clear_color isa Ref ? clear_color[] : clear_color)...)
            GL.glClear(GL.GL_COLOR_BUFFER_BIT)
            lib.ImGui_ImplOpenGL3_RenderDrawData(Ptr{Cint}(CImGui.GetDrawData()))

            GLFW.MakeContextCurrent(window)
            GLFW.SwapBuffers(window)

            if (unsafe_load(lib.igGetIO().ConfigFlags) & lib.ImGuiConfigFlags_ViewportsEnable) == lib.ImGuiConfigFlags_ViewportsEnable
                backup_current_context = GLFW.GetCurrentContext()
                lib.igUpdatePlatformWindows()
                lib.igRenderPlatformWindowsDefault(C_NULL, C_NULL)
                GLFW.MakeContextCurrent(backup_current_context)
            end
        end
    catch e
        @error "Error in CImGui $(CImGui.backend) renderloop!" exception=(e, catch_backtrace())
    finally
        if !isnothing(on_exit)
            try
                on_exit()
            catch exit_ex
                @error "Error in on_exit()!" exception=exit_ex
            end
        end

        lib.ImGui_ImplOpenGL3_Shutdown()
        lib.ImGui_ImplGlfw_Shutdown()
        CImGui.DestroyContext(ctx)
        GLFW.DestroyWindow(window)
        GLFW.Terminate()
    end
end

end
