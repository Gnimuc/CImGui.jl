"""
    ShowHelpMarker(desc)
Helper to display a little (?) mark which shows a tooltip when hovered.
"""
function ShowHelpMarker(desc)
    CImGui.TextDisabled("(?)")
    if CImGui.IsItemHovered()
        CImGui.BeginTooltip()
        CImGui.PushTextWrapPos(CImGui.GetFontSize() * 35.0)
        CImGui.TextUnformatted(desc)
        CImGui.PopTextWrapPos()
        CImGui.EndTooltip()
    end
end

"""
    ShowUserGuide()
Helper to display basic user controls.
"""
function ShowUserGuide()
    CImGui.BulletText("Double-click on title bar to collapse window.")
    CImGui.BulletText("Click and drag on lower right corner to resize window\n(double-click to auto fit window to its contents).")
    CImGui.BulletText("Click and drag on any empty space to move window.")
    CImGui.BulletText("TAB/SHIFT+TAB to cycle through keyboard editable fields.")
    CImGui.BulletText("CTRL+Click on a slider or drag box to input value as text.")
    CImGui.GetIO().FontAllowUserScaling && CImGui.BulletText("CTRL+Mouse Wheel to zoom window contents.")
    CImGui.BulletText("Mouse Wheel to scroll.")
    CImGui.BulletText("While editing text:\n")
    CImGui.Indent()
    CImGui.BulletText("Hold SHIFT or use mouse to select text.")
    CImGui.BulletText("CTRL+Left/Right to word jump.")
    CImGui.BulletText("CTRL+A or double-click to select all.")
    CImGui.BulletText("CTRL+X,CTRL+C,CTRL+V to use clipboard.")
    CImGui.BulletText("CTRL+Z,CTRL+Y to undo/redo.")
    CImGui.BulletText("ESCAPE to revert.")
    CImGui.BulletText("You can apply arithmetic operators +,*,/ on numerical values.\nUse +- to subtract.")
    CImGui.Unindent()
end
