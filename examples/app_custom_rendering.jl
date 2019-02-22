using CImGui
using CImGui: ImVec2, ImVec4, IM_COL32, ImU32
using CSyntax
using CSyntax.CFor
using CSyntax.CStatic


"""
    ShowExampleAppCustomRendering(p_open::Ref{Bool})
Demonstrate using the low-level ImDrawList to draw custom shapes.
"""
function ShowExampleAppCustomRendering(p_open::Ref{Bool})
    CImGui.SetNextWindowSize((350, 560), CImGui.ImGuiCond_FirstUseEver)
    CImGui.Begin("Example: Custom rendering", p_open) || (CImGui.End(); return)

    draw_list = CImGui.GetWindowDrawList()

    # primitives
    CImGui.Text("Primitives")
    sz, thickness, col = @cstatic sz=Cfloat(36.0) thickness=Cfloat(4.0) col=Cfloat[1.0,1.0,0.4,1.0] begin
        @c CImGui.DragFloat("Size", &sz, 0.2, 2.0, 72.0, "%.0f")
        @c CImGui.DragFloat("Thickness", &thickness, 0.05, 1.0, 8.0, "%.02f")
        CImGui.ColorEdit4("Color", col)
    end

    p = CImGui.GetCursorScreenPos()
    col32 = CImGui.ColorConvertFloat4ToU32(ImVec4(col...))
    begin
        x::Cfloat = p.x + 4.0
        y::Cfloat = p.y + 4.0
        spacing = 8.0
        for n = 0:2-1
            th::Cfloat = (n == 0) ? 1.0 : thickness
            CImGui.AddCircle(draw_list, ImVec2(x+sz*0.5, y+sz*0.5), sz*0.5, col32, 6, th); x += sz + spacing; # hexagon
            CImGui.AddCircle(draw_list, ImVec2(x+sz*0.5, y+sz*0.5), sz*0.5, col32, 20, th); x += sz + spacing; # circle
            CImGui.AddRect(draw_list, ImVec2(x, y), ImVec2(x+sz, y+sz), col32, 0.0, CImGui.ImDrawCornerFlags_All, th); x += sz + spacing;
            CImGui.AddRect(draw_list, ImVec2(x, y), ImVec2(x+sz, y+sz), col32, 10.0, CImGui.ImDrawCornerFlags_All, th); x += sz + spacing;
            CImGui.AddRect(draw_list, ImVec2(x, y), ImVec2(x+sz, y+sz), col32, 10.0, CImGui.ImDrawCornerFlags_TopLeft|CImGui.ImDrawCornerFlags_BotRight, th); x += sz + spacing;
            CImGui.AddTriangle(draw_list, ImVec2(x+sz*0.5, y), ImVec2(x+sz,y+sz-0.5), ImVec2(x,y+sz-0.5), col32, th); x += sz + spacing;
            CImGui.AddLine(draw_list, ImVec2(x, y), ImVec2(x+sz,    y), col32, th); x += sz + spacing;  # horizontal line (note: drawing a filled rectangle will be faster!)
            CImGui.AddLine(draw_list, ImVec2(x, y), ImVec2(x,    y+sz), col32, th); x += spacing;       # vertical line (note: drawing a filled rectangle will be faster!)
            CImGui.AddLine(draw_list, ImVec2(x, y), ImVec2(x+sz, y+sz), col32, th); x += sz +spacing;   # diagonal line
            CImGui.AddBezierCurve(draw_list, ImVec2(x, y), ImVec2(x+sz*1.3,y+sz*0.3), (x+sz-sz*1.3,y+sz-sz*0.3), ImVec2(x+sz, y+sz), col32, th);
            x = p.x + 4
            y += sz + spacing
        end
        CImGui.AddCircleFilled(draw_list, ImVec2(x+sz*0.5, y+sz*0.5), sz*0.5, col32, 6); x += sz+spacing; # hexagon
        CImGui.AddCircleFilled(draw_list, ImVec2(x+sz*0.5, y+sz*0.5), sz*0.5, col32, 32); x += sz+spacing; # circle
        CImGui.AddRectFilled(draw_list, ImVec2(x, y), ImVec2(x+sz, y+sz), col32); x += sz+spacing;
        CImGui.AddRectFilled(draw_list, ImVec2(x, y), ImVec2(x+sz, y+sz), col32, 10.0); x += sz+spacing;
        CImGui.AddRectFilled(draw_list, ImVec2(x, y), ImVec2(x+sz, y+sz), col32, 10.0, CImGui.ImDrawCornerFlags_TopLeft|CImGui.ImDrawCornerFlags_BotRight); x += sz+spacing;
        CImGui.AddTriangleFilled(draw_list, ImVec2(x+sz*0.5, y), ImVec2(x+sz,y+sz-0.5), ImVec2(x,y+sz-0.5), col32); x += sz+spacing;
        CImGui.AddRectFilled(draw_list, ImVec2(x, y), ImVec2(x+sz, y+thickness), col32); x += sz+spacing;          # horizontal line (faster than AddLine, but only handle integer thickness)
        CImGui.AddRectFilled(draw_list, ImVec2(x, y), ImVec2(x+thickness, y+sz), col32); x += spacing+spacing;     # vertical line (faster than AddLine, but only handle integer thickness)
        CImGui.AddRectFilled(draw_list, ImVec2(x, y), ImVec2(x+1, y+1), col32);          x += sz;                  # pixel (faster than AddLine)
        CImGui.AddRectFilledMultiColor(draw_list, ImVec2(x, y), ImVec2(x+sz, y+sz), IM_COL32(0,0,0,255), IM_COL32(255,0,0,255), IM_COL32(255,255,0,255), IM_COL32(0,255,0,255))
        CImGui.Dummy(ImVec2((sz+spacing)*8, (sz+spacing)*3))
    end
    CImGui.Separator()
    @cstatic adding_line=false points=ImVec2[] begin
        CImGui.Text("Canvas example")
        CImGui.Button("Clear") && empty!(points)
        if length(points) ≥ 2
            CImGui.SameLine()
            CImGui.Button("Undo") && (pop!(points); pop!(points);)
        end
        CImGui.Text("Left-click and drag to add lines,\nRight-click to undo")

        # here we are using InvisibleButton() as a convenience to 1) advance the cursor and 2) allows us to use IsItemHovered()
        # but you can also draw directly and poll mouse/keyboard by yourself. You can manipulate the cursor using GetCursorPos() and SetCursorPos().
        # if you only use the ImDrawList API, you can notify the owner window of its extends by using SetCursorPos(max).
        canvas_pos = CImGui.GetCursorScreenPos()            # ImDrawList API uses screen coordinates!
        canvas_size = CImGui.GetContentRegionAvail()        # resize canvas to what's available

        cx, cy = canvas_size.x, canvas_size.y
        cx < 50.0 && (cx = 50.0)
        cy < 50.0 && (cy = 50.0)
        canvas_size = ImVec2(cx, cy)
        CImGui.AddRectFilledMultiColor(draw_list, canvas_pos, ImVec2(canvas_pos.x + canvas_size.x, canvas_pos.y + canvas_size.y), IM_COL32(50, 50, 50, 255), IM_COL32(50, 50, 60, 255), IM_COL32(60, 60, 70, 255), IM_COL32(50, 50, 60, 255))
        CImGui.AddRect(draw_list, canvas_pos, ImVec2(canvas_pos.x + canvas_size.x, canvas_pos.y + canvas_size.y), IM_COL32(255, 255, 255, 255))

        adding_preview = false
        CImGui.InvisibleButton("canvas", canvas_size)
        mouse_pos_in_canvas = ImVec2(CImGui.GetIO().MousePos.x - canvas_pos.x, CImGui.GetIO().MousePos.y - canvas_pos.y)
        if adding_line
            adding_preview = true
            push!(points, mouse_pos_in_canvas)
            !CImGui.IsMouseDown(0) && (adding_line = adding_preview = false;)
        end
        if CImGui.IsItemHovered()
            if !adding_line && CImGui.IsMouseClicked(0)
                push!(points, mouse_pos_in_canvas)
                adding_line = true
            end
            if CImGui.IsMouseClicked(1) && !isempty(points)
                adding_line = adding_preview = false
                pop!(points)
                pop!(points)
            end
        end
        CImGui.PushClipRect(draw_list, canvas_pos, ImVec2(canvas_pos.x + canvas_size.x, canvas_pos.y + canvas_size.y), true) # clip lines within the canvas (if we resize it, etc.)
        @cfor i=1 i<length(points) i+=2 begin
            CImGui.AddLine(draw_list, ImVec2(canvas_pos.x + points[i].x, canvas_pos.y + points[i].y), ImVec2(canvas_pos.x + points[i + 1].x, canvas_pos.y + points[i + 1].y), IM_COL32(255, 255, 0, 255), 2.0)
        end
        CImGui.PopClipRect(draw_list)
        adding_preview && pop!(points)
    end
    CImGui.End()
end
