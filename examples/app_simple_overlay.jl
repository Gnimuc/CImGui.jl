using CImGui
using CImGui.CSyntax.CStatic
using Printf

"""
    ShowExampleAppSimpleOverlay(p_open::Ref{Bool})
Create a simple static window with no decoration + a context-menu to choose which corner of
the screen to use.
"""
function ShowExampleAppSimpleOverlay(p_open::Ref{Bool})
    DISTANCE = Cfloat(10.0)

    io = CImGui.GetIO()
    @cstatic corner=Cint(0) begin
        if corner != -1
            window_pos_x = corner & 1 != 0 ? io.DisplaySize.x - DISTANCE : DISTANCE
            window_pos_y = corner & 2 != 0 ? io.DisplaySize.y - DISTANCE : DISTANCE
            window_pos = (window_pos_x, window_pos_y)
            window_pos_pivot = (corner & 1 != 0 ? 1.0 : 0.0, corner & 2 != 0 ? 1.0 : 0.0)
            CImGui.SetNextWindowPos(window_pos, CImGui.ImGuiCond_Always, window_pos_pivot)
        end
        CImGui.SetNextWindowBgAlpha(0.3) # transparent background
        flag = CImGui.ImGuiWindowFlags_NoTitleBar | CImGui.ImGuiWindowFlags_NoResize |
               CImGui.ImGuiWindowFlags_AlwaysAutoResize | CImGui.ImGuiWindowFlags_NoSavedSettings |
               CImGui.ImGuiWindowFlags_NoFocusOnAppearing | CImGui.ImGuiWindowFlags_NoNav
        flag |= corner != -1 ? CImGui.ImGuiWindowFlags_NoMove : CImGui.ImGuiWindowFlags_None
        if CImGui.Begin("Example: Simple Overlay", p_open, flag)
            CImGui.Text("Simple overlay\n in the corner of the screen.\n (right-click to change position)")
            CImGui.Separator()
            if CImGui.IsMousePosValid()
                CImGui.Text(@sprintf("Mouse Position: (%.1f,%.1f)", io.MousePos.x, io.MousePos.y))
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
    end # @cstatic
end
