# This is a port of a C++ stress-test of the renderer: https://github.com/ocornut/imgui/issues/2591#issuecomment-496954460

# It basically draws a bunch of squares and text to force ImGui to create lots of
# vertices, which should result in visual artifacts unless vertex offsets are
# enabled (or ImGui was built with 32-bit indices).

import CImGui as ig
using CImGui.lib
import GLFW
import ModernGL

# create contexts
CImGui.set_backend(:GlfwOpenGL3)
imgui_ctx = CImGui.CreateContext()

# enable docking and multi-viewport
io = CImGui.GetIO()
io.ConfigFlags = io.ConfigFlags | ImGuiConfigFlags_DockingEnable
io.ConfigFlags = io.ConfigFlags | ImGuiConfigFlags_ViewportsEnable

# set style
CImGui.StyleColorsDark()

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
        platform = unsafe_string(io.BackendPlatformName)
        renderer = unsafe_string(io.BackendRendererName)

        CImGui.Text("Dear ImGui $(version) Backend Checker")
        CImGui.Text("Platform: $(platform)")
        CImGui.Text("Renderer: $(renderer)")

        CImGui.Separator()

        if CImGui.TreeNode("0001: Renderer: Large Mesh Support")
            drawlist = CImGui.GetWindowDrawList()

            let vtx_count = Ref(state.vtx_count)
                CImGui.SliderInt("VtxCount##1", vtx_count, 0, 100_000)
                pos = CImGui.GetCursorScreenPos()

                for n = 0:(vtx_count[] ÷ 4 - 1)
                    off_x, off_y, color = generate_widget_properties(n)
                    CImGui.AddRectFilled(drawlist,
                                         ImVec2(pos.x + off_x, pos.y + off_y),
                                         ImVec2(pos.x + off_x + 50, pos.y + off_y + 50),
                                         color)
                end

                CImGui.Dummy(350, 150)
                CImGui.Text("VtxBuffer.Size = $(drawlist.VtxBuffer.Size)")

                state.vtx_count = vtx_count[]
            end

            let vtx_count2 = Ref(state.vtx_count2)
                CImGui.SliderInt("VtxCount##2", vtx_count2, 0, 100_000)
                pos = CImGui.GetCursorScreenPos()

                for n = 0:(vtx_count2[] ÷ 40 - 1)
                    off_x, off_y, color = generate_widget_properties(n)
                    CImGui.AddText(drawlist,
                                   ImVec2(pos.x + off_x, pos.y + off_y),
                                   color, "ABCDEFGHIJ")
                end

                CImGui.Dummy(350, 120)
                CImGui.Text("VtxBuffer.Size = $(drawlist.VtxBuffer.Size)")

                state.vtx_count2 = vtx_count2[]
            end

            CImGui.TreePop()
        end

        CImGui.End()
    end
end

state = GuiState(60_000, 60_000)

CImGui.render(() -> gui(state), imgui_ctx)
