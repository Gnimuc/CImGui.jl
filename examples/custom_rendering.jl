using CImGui
using CImGui: ImVec2
using CSyntax

let
sz::Cfloat = 36.0
thickness::Cfloat = 4.0
col = Cfloat[1.0, 1.0, 0.4, 1.0]
"""
    show_app_custom_rendering(p_open::Ref{Bool})
Demonstrate using the low-level ImDrawList to draw custom shapes.
"""
global function show_app_custom_rendering(p_open::Ref{Bool})
    CImGui.SetNextWindowSize((350, 560), CImGui.ImGuiCond_FirstUseEver)
    CImGui.Begin("Example: Custom rendering", p_open) || (CImGui.End(); return)

    draw_list = CImGui.GetWindowDrawList()

    # primitives
    CImGui.Text("Primitives")
    @c CImGui.DragFloat("Size", &sz, 0.2, 2.0, 72.0, "%.0f")
    @c CImGui.DragFloat("Thickness", &thickness, 0.05, 1.0, 8.0, "%.02f")
    @c CImGui.ColorEdit3("Color", col)
    begin
        p = CImGui.GetCursorScreenPos()
        col32 = igGetColorU32Vec4(ImVec4(col...))
        x::Cfloat = p.x + 4.0
        y::Cfloat = p.y + 4.0
        spacing = 8.0
        for n = 0:2-1
            curr_thickness::Cfloat = (n == 0) ? 1.0 : thickness
            ImDrawList_AddCircle(draw_list, ImVec2(x+sz*0.5, y+sz*0.5), sz*0.5, col32, 20, curr_thickness); x += sz + spacing;
            ImDrawList_AddRect(draw_list, ImVec2(x, y), ImVec2(x+sz, y+sz), col32, 0.0, CImGui.ImDrawCornerFlags_All, curr_thickness); x += sz + spacing;
            ImDrawList_AddRect(draw_list, ImVec2(x, y), ImVec2(x+sz, y+sz), col32, 10.0, CImGui.ImDrawCornerFlags_All, curr_thickness); x += sz + spacing;
            ImDrawList_AddRect(draw_list, ImVec2(x, y), ImVec2(x+sz, y+sz), col32, 10.0, CImGui.ImDrawCornerFlags_TopLeft|CImGui.ImDrawCornerFlags_BotRight, curr_thickness); x += sz + spacing;
            ImDrawList_AddTriangle(draw_list, ImVec2(x+sz*0.5, y), ImVec2(x+sz,y+sz-0.5), ImVec2(x,y+sz-0.5), col32, curr_thickness); x += sz + spacing;
            ImDrawList_AddLine(draw_list, ImVec2(x, y), ImVec2(x+sz, y   ), col32, curr_thickness); x += sz + spacing;  # horizontal line (note: drawing a filled rectangle will be faster!)
            ImDrawList_AddLine(draw_list, ImVec2(x, y), ImVec2(x,    y+sz), col32, curr_thickness); x += spacing;       # vertical line (note: drawing a filled rectangle will be faster!)
            ImDrawList_AddLine(draw_list, ImVec2(x, y), ImVec2(x+sz, y+sz), col32, curr_thickness); x += sz +spacing;   # diagonal line
            # ImDrawList_AddBezierCurve(draw_list, ImVec2(x, y), ImVec2(x+sz*1.3,y+sz*0.3), ImVec2(x+sz-sz*1.3,y+sz-sz*0.3), ImVec2(x+sz, y+sz), col32, curr_thickness);
            x = p.x + 4
            y += sz + spacing
        end
        # ImDrawList_AddCircleFilled(draw_list, ImVec2(x+sz*0.5, y+sz*0.5), sz*0.5, col32, 32); x += sz+spacing;
        # ImDrawList_AddRectFilled(draw_list, ImVec2(x, y), ImVec2(x+sz, y+sz), col32); x += sz+spacing;
        # ImDrawList_AddRectFilled(draw_list, ImVec2(x, y), ImVec2(x+sz, y+sz), col32, 10.0f); x += sz+spacing;
        # ImDrawList_AddRectFilled(draw_list, ImVec2(x, y), ImVec2(x+sz, y+sz), col32, 10.0f, ImDrawCornerFlags_TopLeft|ImDrawCornerFlags_BotRight); x += sz+spacing;
        # ImDrawList_AddTriangleFilled(draw_list, ImVec2(x+sz*0.5, y), ImVec2(x+sz,y+sz-0.5), ImVec2(x,y+sz-0.5), col32); x += sz+spacing;
        # ImDrawList_AddRectFilled(draw_list, ImVec2(x, y), ImVec2(x+sz, y+thickness), col32); x += sz+spacing;          # horizontal line (faster than AddLine, but only handle integer thickness)
        # ImDrawList_AddRectFilled(draw_list, ImVec2(x, y), ImVec2(x+thickness, y+sz), col32); x += spacing+spacing;     # vertical line (faster than AddLine, but only handle integer thickness)
        # ImDrawList_AddRectFilled(draw_list, ImVec2(x, y), ImVec2(x+1, y+1), col32);          x += sz;                  # pixel (faster than AddLine)
        # ImDrawList_AddRectFilledMultiColor(draw_list, ImVec2(x, y), ImVec2(x+sz, y+sz), IM_COL32(0,0,0,255), IM_COL32(255,0,0,255), IM_COL32(255,255,0,255), IM_COL32(0,255,0,255));
        CImGui.Dummy(ImVec2((sz+spacing)*8, (sz+spacing)*3))
    end
    CImGui.Separator()
    # {
    #     static ImVector<ImVec2> points;
    #     static bool adding_line = false;
    #     CImGui.Text("Canvas example");
    #     if (CImGui.Button("Clear")) points.clear();
    #     if (points.Size >= 2) { CImGui.SameLine(); if (CImGui.Button("Undo")) { points.pop_back(); points.pop_back(); } }
    #     CImGui.Text("Left-click and drag to add lines,\nRight-click to undo");
    #
    #     // Here we are using InvisibleButton() as a convenience to 1) advance the cursor and 2) allows us to use IsItemHovered()
    #     // But you can also draw directly and poll mouse/keyboard by yourself. You can manipulate the cursor using GetCursorPos() and SetCursorPos().
    #     // If you only use the ImDrawList API, you can notify the owner window of its extends by using SetCursorPos(max).
    #     ImVec2 canvas_pos = CImGui.GetCursorScreenPos();            // ImDrawList API uses screen coordinates!
    #     ImVec2 canvas_size = CImGui.GetContentRegionAvail();        // Resize canvas to what's available
    #     if (canvas_size.x < 50.0f) canvas_size.x = 50.0f;
    #     if (canvas_size.y < 50.0f) canvas_size.y = 50.0f;
    #     draw_list->AddRectFilledMultiColor(canvas_pos, ImVec2(canvas_pos.x + canvas_size.x, canvas_pos.y + canvas_size.y), IM_COL32(50, 50, 50, 255), IM_COL32(50, 50, 60, 255), IM_COL32(60, 60, 70, 255), IM_COL32(50, 50, 60, 255));
    #     draw_list->AddRect(canvas_pos, ImVec2(canvas_pos.x + canvas_size.x, canvas_pos.y + canvas_size.y), IM_COL32(255, 255, 255, 255));
    #
    #     bool adding_preview = false;
    #     CImGui.InvisibleButton("canvas", canvas_size);
    #     ImVec2 mouse_pos_in_canvas = ImVec2(CImGui.GetIO().MousePos.x - canvas_pos.x, CImGui.GetIO().MousePos.y - canvas_pos.y);
    #     if (adding_line)
    #     {
    #         adding_preview = true;
    #         points.push_back(mouse_pos_in_canvas);
    #         if (!CImGui.IsMouseDown(0))
    #             adding_line = adding_preview = false;
    #     }
    #     if (CImGui.IsItemHovered())
    #     {
    #         if (!adding_line && CImGui.IsMouseClicked(0))
    #         {
    #             points.push_back(mouse_pos_in_canvas);
    #             adding_line = true;
    #         }
    #         if (CImGui.IsMouseClicked(1) && !points.empty())
    #         {
    #             adding_line = adding_preview = false;
    #             points.pop_back();
    #             points.pop_back();
    #         }
    #     }
    #     draw_list->PushClipRect(canvas_pos, ImVec2(canvas_pos.x + canvas_size.x, canvas_pos.y + canvas_size.y), true);      // clip lines within the canvas (if we resize it, etc.)
    #     for (int i = 0; i < points.Size - 1; i += 2)
    #         draw_list->AddLine(ImVec2(canvas_pos.x + points[i].x, canvas_pos.y + points[i].y), ImVec2(canvas_pos.x + points[i + 1].x, canvas_pos.y + points[i + 1].y), IM_COL32(255, 255, 0, 255), 2.0f);
    #     draw_list->PopClipRect();
    #     if (adding_preview)
    #         points.pop_back();
    # }
    CImGui.End()
end

end # let
