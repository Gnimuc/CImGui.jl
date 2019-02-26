using CImGui
using CImGui.CSyntax
using CImGui.CSyntax.CStatic
using Printf

"""
    ShowDemoWindowMisc()
"""
function ShowDemoWindowMisc()
    if CImGui.CollapsingHeader("Filtering")
        # static ImGuiTextFilter filter;
        CImGui.Text("Filter usage:\n"*
                    "  \"\"         display all lines\n"*
                    "  \"xxx\"      display lines containing \"xxx\"\n"*
                    "  \"xxx,yyy\"  display lines containing \"xxx\" or \"yyy\"\n"*
                    "  \"-xxx\"     hide lines containing \"xxx\"")
        # filter.Draw()
        lines = ["aaa1.c", "bbb1.c", "ccc1.c", "aaa2.cpp", "bbb2.cpp", "ccc2.cpp", "abc.h", "hello, world"]
        for i = 1:length(lines)
            # filter.PassFilter(lines[i]) && CImGui.BulletText(lines[i])
        end
    end

    if CImGui.CollapsingHeader("Inputs, Navigation & Focus")
        io = CImGui.GetIO()

        CImGui.Text("WantCaptureMouse: $(io.WantCaptureMouse)")
        CImGui.Text("WantCaptureKeyboard: $(io.WantCaptureKeyboard)")
        CImGui.Text("WantTextInput: $(io.WantTextInput)")
        CImGui.Text("WantSetMousePos: $(io.WantSetMousePos)")
        CImGui.Text("NavActive: $(io.NavActive), NavVisible: $(io.NavVisible)")

        if CImGui.TreeNode("Keyboard, Mouse & Navigation State")
            if CImGui.IsMousePosValid()
                CImGui.Text("Mouse pos: ($(io.MousePos.x), $(io.MousePos.y))")
            else
                CImGui.Text("Mouse pos: <INVALID>")
            end
            CImGui.Text("Mouse delta: ($(io.MouseDelta.x), $(io.MouseDelta.y))")
            CImGui.Text("Mouse down:")
            for i = 0:4
                dur = CImGui.Get_MouseDownDuration(io, i)
                dur ≥ 0 || continue
                CImGui.SameLine()
                CImGui.Text(@sprintf("b%d (%.02f secs)", i, dur))
            end
            CImGui.Text("Mouse clicked:")
            for i = 0:4
                CImGui.IsMouseClicked(i) || continue
                CImGui.SameLine()
                CImGui.Text("b$i")
            end
            CImGui.Text("Mouse dbl-clicked:")
            for i = 0:4
                CImGui.IsMouseDoubleClicked(i) || continue
                CImGui.SameLine()
                CImGui.Text("b$i")
            end
            CImGui.Text("Mouse released:")
            for i = 0:4
                CImGui.IsMouseReleased(i) || continue
                CImGui.SameLine()
                CImGui.Text("b$i")
            end
            CImGui.Text(@sprintf("Mouse wheel: %.1f", io.MouseWheel))

            CImGui.Text("Keys down:")
            for i = 0:511
                dur = CImGui.Get_KeysDownDuration(io, i)
                dur ≥ 0 || continue
                CImGui.SameLine()
                txt = @sprintf "%d (%.02f secs)" i dur
                CImGui.Text(txt)
            end
            CImGui.Text("Keys pressed:")
            for i = 0:511
                CImGui.IsKeyPressed(i) || continue
                CImGui.SameLine()
                CImGui.Text("$i")
            end
            CImGui.Text("Keys release:")
            for i = 0:511
                CImGui.IsKeyReleased(i) || continue
                CImGui.SameLine()
                CImGui.Text("$i")
            end
            CImGui.Text(@sprintf("Keys mods: %s%s%s%s", io.KeyCtrl ? "CTRL " : "", io.KeyShift ? "SHIFT " : "", io.KeyAlt ? "ALT " : "", io.KeySuper ? "SUPER " : ""))

            CImGui.Text("NavInputs down:")
            for i = 0:20
                nav = CImGui.Get_NavInputs(io, i)
                nav > 0 || continue
                CImGui.SameLine()
                CImGui.Text(@sprintf("[%d] %.2f", i, nav))
            end
            CImGui.Text("NavInputs pressed:")
            for i = 0:20
                dur = CImGui.Get_NavInputsDownDuration(io, i)
                dur == 0.0 || continue
                CImGui.SameLine()
                CImGui.Text("[$i]")
            end
            CImGui.Text("NavInputs duration:")
            for i = 0:20
                dur = CImGui.Get_NavInputsDownDuration(io, i)
                dur ≥ 0.0 || continue
                CImGui.SameLine()
                CImGui.Text(@sprintf("[%d] %.2f", i, dur))
            end

            CImGui.Button("Hovering me sets the\nkeyboard capture flag")
            CImGui.IsItemHovered() && CImGui.CaptureKeyboardFromApp(true)
            CImGui.SameLine()
            CImGui.Button("Holding me clears the\nthe keyboard capture flag")
            CImGui.IsItemActive() && CImGui.CaptureKeyboardFromApp(false)

            CImGui.TreePop()
        end

        if CImGui.TreeNode("Tabbing")
            CImGui.Text("Use TAB/SHIFT+TAB to cycle through keyboard editable fields.")
            @cstatic buf="dummy"*"\0"^(27) begin
                CImGui.InputText("1", buf, length(buf))
                CImGui.InputText("2", buf, length(buf))
                CImGui.InputText("3", buf, length(buf))
                CImGui.PushAllowKeyboardFocus(false)
                CImGui.InputText("4 (tab skip)", buf, length(buf))
                # CImGui.SameLine(); ShowHelperMarker("Use CImGui.PushAllowKeyboardFocus(bool)\nto disable tabbing through certain widgets.")
                CImGui.PopAllowKeyboardFocus()
                CImGui.InputText("5", buf, length(buf))
            end
            CImGui.TreePop()
        end

        if CImGui.TreeNode("Focus from code")
            focus_1 = CImGui.Button("Focus on 1"); CImGui.SameLine();
            focus_2 = CImGui.Button("Focus on 2"); CImGui.SameLine();
            focus_3 = CImGui.Button("Focus on 3");
            has_focus = Cint(0)

            @cstatic buf="click on a button to set focus"*"\0"^98 begin
                focus_1 && CImGui.SetKeyboardFocusHere()
                CImGui.InputText("1", buf, length(buf))
                CImGui.IsItemActive() && (has_focus = 1;)

                focus_2 && CImGui.SetKeyboardFocusHere()
                CImGui.InputText("2", buf, length(buf))
                CImGui.IsItemActive() && (has_focus = 2;)

                CImGui.PushAllowKeyboardFocus(false)
                focus_3 && CImGui.SetKeyboardFocusHere()
                CImGui.InputText("3 (tab skip)", buf, length(buf))
                CImGui.IsItemActive() && (has_focus = 3;)
                CImGui.PopAllowKeyboardFocus()
            end
            if has_focus != 0
                CImGui.Text("Item with focus: $has_focus")
            else
                CImGui.Text("Item with focus: <none>")
            end

            # use >= 0 parameter to SetKeyboardFocusHere() to focus an upcoming item
            @cstatic f3 = Cfloat[0.0, 0.0, 0.0] begin
                focus_ahead = Cint(-1)
                CImGui.Button("Focus on X") && (focus_ahead = 0;)
                CImGui.SameLine()
                CImGui.Button("Focus on Y") && (focus_ahead = 1;)
                CImGui.SameLine()
                CImGui.Button("Focus on Z") && (focus_ahead = 2;)
                focus_ahead != -1 && CImGui.SetKeyboardFocusHere(focus_ahead)
                CImGui.SliderFloat3("Float3", f3, 0.0, 1.0)
            end
            CImGui.TextWrapped("NB: Cursor & selection are preserved when refocusing last used item in code.")
            CImGui.TreePop()
        end

        if CImGui.TreeNode("Dragging")
            CImGui.TextWrapped("You can use CImGui.GetMouseDragDelta(0) to query for the dragged amount on any widget.")
            for button = 0:2
                CImGui.Text(@sprintf("IsMouseDragging(%d):\n  w/ default threshold: %d,\n  w/ zero threshold: %d\n  w/ large threshold: %d",
                    button, CImGui.IsMouseDragging(button), CImGui.IsMouseDragging(button, 0.0), CImGui.IsMouseDragging(button, 20.0)))
            end
            CImGui.Button("Drag Me")
            if CImGui.IsItemActive()
                # draw a line between the button and the mouse cursor
                draw_list = CImGui.GetWindowDrawList()
                CImGui.PushClipRectFullScreen(draw_list)
                click_pos = CImGui.Get_MouseClickedPos(io, 0)
                CImGui.AddLine(draw_list, click_pos, io.MousePos, CImGui.GetColorU32(CImGui.ImGuiCol_Button), 4.0)
                CImGui.PopClipRect(draw_list)

                # drag operations gets "unlocked" when the mouse has moved past a certain threshold (the default threshold is stored in io.MouseDragThreshold)
                # you can request a lower or higher threshold using the second parameter of IsMouseDragging() and GetMouseDragDelta()
                value_raw = CImGui.GetMouseDragDelta(0, 0.0)
                value_with_lock_threshold = CImGui.GetMouseDragDelta(0)
                mouse_delta = io.MouseDelta
                CImGui.SameLine()
                txt = @sprintf "Raw (%.1f, %.1f), WithLockThresold (%.1f, %.1f), MouseDelta (%.1f, %.1f)" value_raw.x value_raw.y value_with_lock_threshold.x value_with_lock_threshold.y mouse_delta.x mouse_delta.y
                CImGui.Text(txt)
            end
            CImGui.TreePop()
        end

        if CImGui.TreeNode("Mouse cursors")
            mouse_cursors_names = ["Arrow", "TextInput", "Move", "ResizeNS", "ResizeEW", "ResizeNESW", "ResizeNWSE", "Hand"]
            @assert length(mouse_cursors_names) == CImGui.ImGuiMouseCursor_COUNT
            cur = CImGui.GetMouseCursor()
            CImGui.Text("Current mouse cursor = $cur: $(mouse_cursors_names[cur+1])")
            CImGui.Text("Hover to see mouse cursors:")
            CImGui.SameLine()
            ShowHelpMarker("Your application can render a different mouse cursor based on what CImGui.GetMouseCursor() returns. If software cursor rendering (io.MouseDrawCursor) is set ImGui will draw the right cursor for you, otherwise your backend needs to handle it.")
            for i = 0:CImGui.ImGuiMouseCursor_COUNT-1
                label = @sprintf("Mouse cursor %d: %s", i, mouse_cursors_names[i+1])
                CImGui.Bullet()
                CImGui.Selectable(label, false)
                (CImGui.IsItemHovered() || CImGui.IsItemFocused()) && CImGui.SetMouseCursor(i)
            end
            CImGui.TreePop()
        end
    end
end
