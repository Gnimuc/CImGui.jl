using CImGui
using Printf

const DISTANCE = Cfloat(10.0)

let corner::Cint = 0
"""
    show_app_simple_overlay(p_open::Ref{Bool})
Create a simple static window with no decoration + a context-menu to choose which corner of
the screen to use.
"""
global function show_app_simple_overlay(p_open::Ref{Bool})
    display_size = CImGui.Get_DisplaySize(CImGui.GetIO())
    window_pos_x = corner & 1 != 0 ? display_size.x - DISTANCE : DISTANCE
    window_pos_y = corner & 2 != 0 ? display_size.y - DISTANCE : DISTANCE
    window_pos = (window_pos_x, window_pos_y)
    window_pos_pivot = (corner & 1 != 0 ? 1.0 : 0.0, corner & 2 != 0 ? 1.0 : 0.0)
    corner != -1 && CImGui.SetNextWindowPos(window_pos, CImGui.ImGuiCond_Always, window_pos_pivot)
    CImGui.SetNextWindowBgAlpha(0.3) # transparent background
    flag = ImGuiWindowFlags_NoTitleBar | ImGuiWindowFlags_NoResize | ImGuiWindowFlags_AlwaysAutoResize |
           ImGuiWindowFlags_NoSavedSettings | ImGuiWindowFlags_NoFocusOnAppearing | ImGuiWindowFlags_NoNav
    flag |= corner != -1 ? ImGuiWindowFlags_NoMove : ImGuiWindowFlags_None
    if CImGui.Begin("Example: Simple Overlay", p_open, flag)
        CImGui.Text("Simple overlay\n in the corner of the screen.\n (right-click to change position)")
        CImGui.Separator()
        if CImGui.IsMousePosValid()
            mouse_pos = CImGui.GetMousePos()
            txt = @sprintf "Mouse Position: (%.1f,%.1f)" mouse_pos.x mouse_pos.y
            CImGui.Text(txt)
        else
            CImGui.Text("Mouse Position: <invalid>")
        end
        if CImGui.BeginPopupContextWindow()
            CImGui.MenuItem("Custom",       C_NULL, corner == -1) && (corner = -1;)
            CImGui.MenuItem("Top-left",     C_NULL, corner == 0) && (corner = 0;)
            CImGui.MenuItem("Top-right",    C_NULL, corner == 1) && (corner = 1;)
            CImGui.MenuItem("Bottom-left",  C_NULL, corner == 2) && (corner = 2;)
            CImGui.MenuItem("Bottom-right", C_NULL, corner == 3) && (corner = 3;)
            p_open[] && CImGui.MenuItem("Close") && (p_open[] = false;)
            CImGui.EndPopup()
        end
    end
    CImGui.End()
end

end # let
