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

"""
    ShowAboutWindow(p_open::Ref{Bool})
Access from ImGui Demo -> Help -> About
"""
function ShowAboutWindow(p_open::Ref{Bool})
    CImGui.Begin("About Dear ImGui", p_open, CImGui.ImGuiWindowFlags_AlwaysAutoResize) || (CImGui.End(); return)

    CImGui.Text("Dear ImGui $(CImGui.IMGUI_VERSION)")
    CImGui.Separator()
    CImGui.Text("By Omar Cornut and all dear imgui contributors.")
    CImGui.Text("Dear ImGui is licensed under the MIT License, see LICENSE for more information.")

@cstatic show_config_info=false begin
    @c CImGui.Checkbox("Config/Build Information", &show_config_info)
    if show_config_info
        io = CImGui.GetIO()
        style = CImGui.GetStyle()

        copy_to_clipboard = CImGui.Button("Copy to clipboard")
        CImGui.BeginChildFrame(CImGui.GetID("cfginfos"), ImVec2(0, CImGui.GetTextLineHeightWithSpacing() * 18), CImGui.ImGuiWindowFlags_NoMove)
        copy_to_clipboard && CImGui.LogToClipboard()

        CImGui.Text("Dear ImGui $(CImGui.IMGUI_VERSION)")
        CImGui.Separator()
        CImGui.Text("sizeof(size_t): $(sizeof(Csize_t)), sizeof(ImDrawIdx): $(sizeof(CImGui.ImDrawIdx)), sizeof(ImDrawVert): $(sizeof(CImGui.ImDrawVert))")
        CImGui.Separator()
        CImGui.Text(@sprintf("io.BackendPlatformName: %s", io.BackendPlatformName ? io.BackendPlatformName : "NULL"))
        CImGui.Text(@sprintf("io.BackendRendererName: %s", io.BackendRendererName ? io.BackendRendererName : "NULL"))
        CImGui.Text(@sprintf("io.ConfigFlags: 0x%08X", io.ConfigFlags))
        io.ConfigFlags & CImGui.ImGuiConfigFlags_NavEnableKeyboard    != 0 && CImGui.Text(" NavEnableKeyboard")
        io.ConfigFlags & CImGui.ImGuiConfigFlags_NavEnableGamepad     != 0 && CImGui.Text(" NavEnableGamepad")
        io.ConfigFlags & CImGui.ImGuiConfigFlags_NavEnableSetMousePos != 0 && CImGui.Text(" NavEnableSetMousePos")
        io.ConfigFlags & CImGui.ImGuiConfigFlags_NavNoCaptureKeyboard != 0 && CImGui.Text(" NavNoCaptureKeyboard")
        io.ConfigFlags & CImGui.ImGuiConfigFlags_NoMouse              != 0 && CImGui.Text(" NoMouse")
        io.ConfigFlags & CImGui.ImGuiConfigFlags_NoMouseCursorChange  != 0 && CImGui.Text(" NoMouseCursorChange")
        io.MouseDrawCursor                   && CImGui.Text("io.MouseDrawCursor")
        io.ConfigMacOSXBehaviors             && CImGui.Text("io.ConfigMacOSXBehaviors")
        io.ConfigInputTextCursorBlink        && CImGui.Text("io.ConfigInputTextCursorBlink")
        io.ConfigWindowsResizeFromEdges      && CImGui.Text("io.ConfigWindowsResizeFromEdges")
        io.ConfigWindowsMoveFromTitleBarOnly && CImGui.Text("io.ConfigWindowsMoveFromTitleBarOnly")
        CImGui.Text(@sprintf("io.BackendFlags: 0x%08X", io.BackendFlags))
        io.BackendFlags & ImGuiBackendFlags_HasGamepad      != 0  && CImGui.Text(" HasGamepad")
        io.BackendFlags & ImGuiBackendFlags_HasMouseCursors != 0  && CImGui.Text(" HasMouseCursors")
        io.BackendFlags & ImGuiBackendFlags_HasSetMousePos  != 0  && CImGui.Text(" HasSetMousePos")
        CImGui.Separator()
        # CImGui.Text("io.Fonts: %d fonts, Flags: 0x%08X, TexSize: %d,%d", io.Fonts->Fonts.Size, io.Fonts->Flags, io.Fonts->TexWidth, io.Fonts->TexHeight);
        CImGui.Text(@sprintf("io.DisplaySize: %.2f,%.2f", io.DisplaySize.x, io.DisplaySize.y))
        CImGui.Text(@sprintf("io.DisplayFramebufferScale: %.2f,%.2f", io.DisplayFramebufferScale.x, io.DisplayFramebufferScale.y))
        CImGui.Separator()
        CImGui.Text(@sprintf("style.WindowPadding: %.2f,%.2f", style.WindowPadding.x, style.WindowPadding.y))
        CImGui.Text(@sprintf("style.WindowBorderSize: %.2f", style.WindowBorderSize))
        CImGui.Text(@sprintf("style.FramePadding: %.2f,%.2f", style.FramePadding.x, style.FramePadding.y))
        CImGui.Text(@sprintf("style.FrameRounding: %.2f", style.FrameRounding))
        CImGui.Text(@sprintf("style.FrameBorderSize: %.2f", style.FrameBorderSize))
        CImGui.Text(@sprintf("style.ItemSpacing: %.2f,%.2f", style.ItemSpacing.x, style.ItemSpacing.y))
        CImGui.Text(@sprintf("style.ItemInnerSpacing: %.2f,%.2f", style.ItemInnerSpacing.x, style.ItemInnerSpacing.y))

        copy_to_clipboard && CImGui.LogFinish()
        CImGui.EndChildFrame()
    end
end
    CImGui.End()
end
