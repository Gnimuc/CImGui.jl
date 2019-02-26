using CImGui
using CImGui: ImVec2, FLT_MAX, ImGuiSizeCallbackData
using CImGui.CSyntax
using CImGui.CSyntax.CStatic

"""
    ShowExampleAppConstrainedResize(p_open::Ref{Bool})
Create a window with custom resize constraints.
"""
global function ShowExampleAppConstrainedResize(p_open::Ref{Bool})
    function Square(data::Ptr{ImGuiSizeCallbackData})::Cvoid
        desired_size = CImGui.Get_DesiredSize(data)
        max_size = max(desired_size.x, desired_size.y)
        CImGui.Set_DesiredSize(data, ImVec2(max_size, max_size))
    end

    function Step(data::Ptr{ImGuiSizeCallbackData})::Cvoid
        desired_size = CImGui.Get_DesiredSize(data)
        step::Cfloat = CImGui.Get_UserData(data) |> Int
        size_x = trunc(desired_size.x / step + 0.5) * step
        size_y = trunc(desired_size.y / step + 0.5) * step
        CImGui.Set_DesiredSize(data, ImVec2(size_x, size_y))
    end

    square_fptr = @cfunction($Square, Cvoid, (Ptr{ImGuiSizeCallbackData},))
    step_fptr = @cfunction($Step, Cvoid, (Ptr{ImGuiSizeCallbackData},))

    @cstatic auto_resize=false type=Cint(0) display_lines=Cint(10) begin
        type == 0 && CImGui.SetNextWindowSizeConstraints(ImVec2(-1, 0),    ImVec2(-1, FLT_MAX))      # vertical only
        type == 1 && CImGui.SetNextWindowSizeConstraints(ImVec2(0, -1),    ImVec2(FLT_MAX, -1))      # horizontal only
        type == 2 && CImGui.SetNextWindowSizeConstraints(ImVec2(100, 100), ImVec2(FLT_MAX, FLT_MAX)) # width > 100, Height > 100
        type == 3 && CImGui.SetNextWindowSizeConstraints(ImVec2(400, -1),  ImVec2(500, -1))          # width 400-500
        type == 4 && CImGui.SetNextWindowSizeConstraints(ImVec2(-1, 400),  ImVec2(-1, 500))          # height 400-500
        type == 5 && CImGui.SetNextWindowSizeConstraints(ImVec2(0, 0),     ImVec2(FLT_MAX, FLT_MAX), square_fptr) # always Square
        type == 6 && CImGui.SetNextWindowSizeConstraints(ImVec2(0, 0),     ImVec2(FLT_MAX, FLT_MAX), step_fptr, Ptr{Cvoid}(100)) # fixed Step

        flags = auto_resize ? CImGui.ImGuiWindowFlags_AlwaysAutoResize : 0
        if CImGui.Begin("Example: Constrained Resize", p_open, flags)
            desc = [
                "Resize vertical only",
                "Resize horizontal only",
                "Width > 100, Height > 100",
                "Width 400-500",
                "Height 400-500",
                "Custom: Always Square",
                "Custom: Fixed Steps (100)",
            ]
            CImGui.Button("200x200") && CImGui.SetWindowSize(ImVec2(200, 200))
            CImGui.SameLine()
            CImGui.Button("500x500") && CImGui.SetWindowSize(ImVec2(500, 500))
            CImGui.SameLine()
            CImGui.Button("800x200") && CImGui.SetWindowSize(ImVec2(800, 200))
            CImGui.PushItemWidth(200)
            @c CImGui.Combo("Constraint", &type, desc, length(desc))
            @c CImGui.DragInt("Lines", &display_lines, 0.2, 1, 100)
            CImGui.PopItemWidth()
            @c CImGui.Checkbox("Auto-resize", &auto_resize)
            foreach(i->CImGui.Text("$(" "^4i)Hello, sailor! Making this line long enough for the example."), 1:display_lines)
        end
        CImGui.End()
    end # @cstatic
end
