# This is a port of a C++ stress-test of the renderer: https://github.com/ocornut/imgui/issues/2591#issuecomment-496954460

# It basically draws a bunch of squares and text to force ImGui to create lots of
# vertices, which should result in visual artifacts unless vertex offsets are
# enabled (or ImGui was built with 32-bit indices).

using CImGui
using CImGui.ImGuiGLFWBackend
using CImGui.ImGuiGLFWBackend.LibCImGui
using CImGui.ImGuiGLFWBackend.LibGLFW
using CImGui.ImGuiOpenGLBackend
using CImGui.ImGuiOpenGLBackend.ModernGL

# create contexts
imgui_ctx = CImGui.CreateContext()

window_ctx = ImGuiGLFWBackend.create_context()
window = ImGuiGLFWBackend.get_window(window_ctx)

gl_ctx = ImGuiOpenGLBackend.create_context()

# enable docking and multi-viewport
io = CImGui.GetIO()
io.ConfigFlags = unsafe_load(io.ConfigFlags) | ImGuiConfigFlags_DockingEnable
io.ConfigFlags = unsafe_load(io.ConfigFlags) | ImGuiConfigFlags_ViewportsEnable

# set style
CImGui.StyleColorsDark()

# init
ImGuiGLFWBackend.init(window_ctx)
ImGuiOpenGLBackend.init(gl_ctx)

mutable struct GuiState
    vtx_count::Cint
    vtx_count2::Cint
end

function generate_widget_properties(n)
    off_x = (n % 100) * 3f0
    off_y = (n % 100) * 1f0

    color::ImU32 = ((n * 17) & 255)
    color |= ((n * 59) & 255) << 8
    color |= ((n * 83) & 255) << 16
    color |= 255 << 24

    off_x, off_y, color
end

function gui(state)
    if CImGui.Begin("Dear ImGui Backend Checker")
        version = unsafe_string(CImGui.GetVersion())
        io_ref = unsafe_load(io)
        platform = unsafe_string(io_ref.BackendPlatformName)
        renderer = unsafe_string(io_ref.BackendRendererName)

        CImGui.Text("Dear ImGui $(version) Backend Checker")
        CImGui.Text("Platform: $(platform)")
        CImGui.Text("Renderer: $(renderer)")

        CImGui.Separator()

        if CImGui.TreeNode("0001: Renderer: Large Mesh Support")
            drawlist_ptr = CImGui.GetWindowDrawList()

            let vtx_count = Ref(state.vtx_count)
                CImGui.SliderInt("VtxCount##1", vtx_count, 0, 100_000)
                pos = CImGui.GetCursorScreenPos()

                for n = 0:(vtx_count[] ÷ 4 - 1)
                    off_x, off_y, color = generate_widget_properties(n)
                    CImGui.AddRectFilled(drawlist_ptr,
                                         ImVec2(pos.x + off_x, pos.y + off_y),
                                         ImVec2(pos.x + off_x + 50, pos.y + off_y + 50),
                                         color)
                end

                CImGui.Dummy(350, 150)
                drawlist = unsafe_load(drawlist_ptr)
                CImGui.Text("VtxBuffer.Size = $(drawlist.VtxBuffer.Size)")

                state.vtx_count = vtx_count[]
            end

            let vtx_count2 = Ref(state.vtx_count2)
                CImGui.SliderInt("VtxCount##2", vtx_count2, 0, 100_000)
                pos = CImGui.GetCursorScreenPos()

                for n = 0:(vtx_count2[] ÷ 40 - 1)
                    off_x, off_y, color = generate_widget_properties(n)
                    CImGui.AddText(drawlist_ptr,
                                   ImVec2(pos.x + off_x, pos.y + off_y),
                                   color, "ABCDEFGHIJ")
                end

                CImGui.Dummy(350, 120)
                drawlist = unsafe_load(drawlist_ptr)
                CImGui.Text("VtxBuffer.Size = $(drawlist.VtxBuffer.Size)")

                state.vtx_count2 = vtx_count2[]
            end

            CImGui.TreePop()
        end

        CImGui.End()
    end
end

try
    state = GuiState(60_000, 60_000)

    while glfwWindowShouldClose(window) == GLFW_FALSE
        glfwPollEvents()
        # new frame
        ImGuiOpenGLBackend.new_frame(gl_ctx)
        ImGuiGLFWBackend.new_frame(window_ctx)
        CImGui.NewFrame()

        # UIs
        gui(state)

        # rendering
        CImGui.Render()
        glfwMakeContextCurrent(window)
        w_ref, h_ref = Ref{Cint}(0), Ref{Cint}(0)
        glfwGetFramebufferSize(window, w_ref, h_ref)
        display_w, display_h = w_ref[], h_ref[]
        glViewport(0, 0, display_w, display_h)
        glClearColor(0.45, 0.55, 0.60, 1.00)
        glClear(GL_COLOR_BUFFER_BIT)
        ImGuiOpenGLBackend.render(gl_ctx)

        if unsafe_load(CImGui.GetIO().ConfigFlags) & ImGuiConfigFlags_ViewportsEnable == ImGuiConfigFlags_ViewportsEnable
            backup_current_context = glfwGetCurrentContext()
            LibCImGui.igUpdatePlatformWindows()
            GC.@preserve gl_ctx LibCImGui.igRenderPlatformWindowsDefault(C_NULL, pointer_from_objref(gl_ctx))
            glfwMakeContextCurrent(backup_current_context)
        end

        glfwSwapBuffers(window)
    end
catch e
    @error "Error in renderloop!" exception=e
    Base.show_backtrace(stderr, catch_backtrace())
finally
    ImGuiOpenGLBackend.shutdown(gl_ctx)
    ImGuiGLFWBackend.shutdown(window_ctx)
    CImGui.DestroyContext(imgui_ctx)
    glfwDestroyWindow(window)
end
