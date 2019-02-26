function ShowDemoWindowLayout()
    CImGui.CollapsingHeader("Layout") || return

    if CImGui.TreeNode("Child windows")
        ShowHelpMarker("Use child windows to begin into a self-contained independent scrolling/clipping regions within a host window.")
        @cstatic disable_mouse_wheel=false disable_menu=false line=Cint(50) begin
            @c CImGui.Checkbox("Disable Mouse Wheel", &disable_mouse_wheel)
            @c CImGui.Checkbox("Disable Menu", &disable_menu)

            goto_line = CImGui.Button("Goto")
            CImGui.SameLine()
            CImGui.PushItemWidth(100)
            goto_line |= @c CImGui.InputInt("##Line", &line, 0, 0, CImGui.ImGuiInputTextFlags_EnterReturnsTrue)
            CImGui.PopItemWidth()

            # child 1: no border, enable horizontal scrollbar
            begin
                window_flags = CImGui.ImGuiWindowFlags_HorizontalScrollbar | (disable_mouse_wheel ? CImGui.ImGuiWindowFlags_NoScrollWithMouse : 0)
                CImGui.BeginChild("Child1", ImVec2(CImGui.GetWindowContentRegionWidth() * 0.5, 260), false, window_flags)
                for i = 0:100-1
                    CImGui.Text(@sprintf("%04d: scrollable region", i))
                    (goto_line && line == i) && CImGui.SetScrollHereY()
                end
                (goto_line && line >= 100) && CImGui.SetScrollHereY()
                CImGui.EndChild()
            end

            CImGui.SameLine()

            # child 2: rounded border
            begin
                window_flags = (disable_mouse_wheel ? CImGui.ImGuiWindowFlags_NoScrollWithMouse : 0) | (disable_menu ? 0 : CImGui.ImGuiWindowFlags_MenuBar)
                CImGui.PushStyleVar(CImGui.ImGuiStyleVar_ChildRounding, 5.0)
                CImGui.BeginChild("Child2", ImVec2(0, 260), true, window_flags)
                if !disable_menu && CImGui.BeginMenuBar()
                    if CImGui.BeginMenu("Menu")
                        ShowExampleMenuFile()
                        CImGui.EndMenu()
                    end
                    CImGui.EndMenuBar()
                end
                CImGui.Columns(2)
                for i = 0:100-1
                    buf = @sprintf("%03d", i)
                    CImGui.Button(buf, ImVec2(-1.0, 0.0))
                    CImGui.NextColumn()
                end
                CImGui.EndChild()
                CImGui.PopStyleVar()
            end
        end
        CImGui.Separator()

        # Demonstrate a few extra things
        # - Changing ImGuiCol_ChildBg (which is transparent black in default styles)
        # - Using SetCursorPos() to position the child window (because the child window is an item from the POV of the parent window)
        #   You can also call SetNextWindowPos() to position the child window. The parent window will effectively layout from this position.
        # - Using CImGui.GetItemRectMin/Max() to query the "item" state (because the child window is an item from the POV of the parent window)
        #   See "Widgets" -> "Querying Status (Active/Focused/Hovered etc.)" section for more details about this.
        begin
            CImGui.SetCursorPosX(50)
            CImGui.PushStyleColor(CImGui.ImGuiCol_ChildBg, IM_COL32(255, 0, 0, 100))
            CImGui.BeginChild("blah", ImVec2(200, 100), true, CImGui.ImGuiWindowFlags_None)
            for n = 0:50-1
                CImGui.Text("Some test $n")
            end
            CImGui.EndChild()
            child_rect_min = CImGui.GetItemRectMin()
            child_rect_max = CImGui.GetItemRectMax()
            CImGui.PopStyleColor()
            txt = @sprintf("Rect of child window is: (%.0f,%.0f) (%.0f,%.0f)", child_rect_min.x, child_rect_min.y, child_rect_max.x, child_rect_max.y)
            CImGui.Text(txt)
        end

        CImGui.TreePop()
    end

    if CImGui.TreeNode("Widgets Width")
        @cstatic f = Cfloat(0.0) begin
            CImGui.Text("PushItemWidth(100)")
            CImGui.SameLine()
            ShowHelpMarker("Fixed width.")
            CImGui.PushItemWidth(100)
            @c CImGui.DragFloat("float##1", &f)
            CImGui.PopItemWidth()

            CImGui.Text("PushItemWidth(GetWindowWidth() * 0.5)")
            CImGui.SameLine()
            ShowHelpMarker("Half of window width.")
            CImGui.PushItemWidth(CImGui.GetWindowWidth() * 0.5)
            @c CImGui.DragFloat("float##2", &f)
            CImGui.PopItemWidth()

            CImGui.Text("PushItemWidth(GetContentRegionAvailWidth() * 0.5)")
            CImGui.SameLine()
            ShowHelpMarker("Half of available width.\n(~ right-cursor_pos)\n(works within a column set)")
            CImGui.PushItemWidth(CImGui.GetContentRegionAvailWidth() * 0.5)
            @c CImGui.DragFloat("float##3", &f)
            CImGui.PopItemWidth()

            CImGui.Text("PushItemWidth(-100)")
            CImGui.SameLine()
            ShowHelpMarker("Align to right edge minus 100")
            CImGui.PushItemWidth(-100)
            @c CImGui.DragFloat("float##4", &f)
            CImGui.PopItemWidth()

            CImGui.Text("PushItemWidth(-1)")
            CImGui.SameLine()
            ShowHelpMarker("Align to right edge")
            CImGui.PushItemWidth(-1)
            @c CImGui.DragFloat("float##5", &f)
            CImGui.PopItemWidth()
        end
        CImGui.TreePop()
    end

    if CImGui.TreeNode("Basic Horizontal Layout")
        CImGui.TextWrapped("(Use CImGui.SameLine() to keep adding items to the right of the preceding item)")

        # text
        CImGui.Text("Two items: Hello"); CImGui.SameLine()
        CImGui.TextColored(ImVec4(1,1,0,1), "Sailor")

        # adjust spacing
        CImGui.Text("More spacing: Hello"); CImGui.SameLine(0, 20)
        CImGui.TextColored(ImVec4(1,1,0,1), "Sailor")

        # button
        CImGui.AlignTextToFramePadding()
        CImGui.Text("Normal buttons"); CImGui.SameLine()
        CImGui.Button("Banana"); CImGui.SameLine()
        CImGui.Button("Apple"); CImGui.SameLine()
        CImGui.Button("Corniflower")

        # button
        CImGui.Text("Small buttons"); CImGui.SameLine()
        CImGui.SmallButton("Like this one"); CImGui.SameLine()
        CImGui.Text("can fit within a text block.")

        # aligned to arbitrary position. Easy/cheap column.
        CImGui.Text("Aligned")
        CImGui.SameLine(150); CImGui.Text("x=150")
        CImGui.SameLine(300); CImGui.Text("x=300")
        CImGui.Text("Aligned")
        CImGui.SameLine(150); CImGui.SmallButton("x=150")
        CImGui.SameLine(300); CImGui.SmallButton("x=300")

        # checkbox
        @cstatic c1=false c2=false c3=false c4=false begin
            @c CImGui.Checkbox("My", &c1)
            CImGui.SameLine()
            @c CImGui.Checkbox("Tailor", &c2)
            CImGui.SameLine()
            @c CImGui.Checkbox("Is", &c3)
            CImGui.SameLine()
            @c CImGui.Checkbox("Rich", &c4)
        end

        # various
        items = ["AAAA", "BBBB", "CCCC", "DDDD"]
        @cstatic f0=Cfloat(1.0) f1=Cfloat(2.0) f2=Cfloat(3.0) item=Cint(-1) begin
            CImGui.PushItemWidth(80)
            @c CImGui.Combo("Combo", &item, items, length(items))
            CImGui.SameLine()
            @c CImGui.SliderFloat("X", &f0, 0.0, 5.0)
            CImGui.SameLine()
            @c CImGui.SliderFloat("Y", &f1, 0.0, 5.0)
            CImGui.SameLine()
            @c CImGui.SliderFloat("Z", &f2, 0.0, 5.0)
            CImGui.PopItemWidth()
        end

        CImGui.PushItemWidth(80)
        CImGui.Text("Lists:")
        @cstatic selection=Cint[0, 1, 2, 3] begin
            for i = 0:4-1
                i > 0 && CImGui.SameLine()
                CImGui.PushID(i)
                CImGui.ListBox("", pointer(selection)+i*sizeof(Cint), items, length(items))
                CImGui.PopID()
                # CImGui.IsItemHovered() && CImGui.SetTooltip("ListBox $i hovered")
            end
            CImGui.PopItemWidth()
        end

        # dummy
        button_sz = ImVec2(40, 40)
        CImGui.Button("A", button_sz)
        CImGui.SameLine()
        CImGui.Dummy(button_sz)
        CImGui.SameLine()
        CImGui.Button("B", button_sz)

        # manually wrapping (we should eventually provide this as an automatic layout feature,
        # but for now you can do it manually)
        CImGui.Text("Manually wrapping:")
        # ImGuiStyle& style = CImGui.GetStyle()
        # buttons_count = 20
        # window_visible_x2 = CImGui.GetWindowPos().x + CImGui.GetWindowContentRegionMax().x
        # for n = 0:buttons_count-1
        #     CImGui.PushID(n)
        #     CImGui.Button("Box", button_sz)
        #     last_button_x2 = CImGui.GetItemRectMax().x
        #     next_button_x2 = last_button_x2 + style.ItemSpacing.x + button_sz.x # expected position if next button was on same line
        #     if n + 1 < buttons_count && next_button_x2 < window_visible_x2
        #         CImGui.SameLine()
        #     end
        #     CImGui.PopID()
        # end

        CImGui.TreePop()
    end

    if CImGui.TreeNode("Tabs")
        if CImGui.TreeNode("Basic")
            tab_bar_flags = CImGui.ImGuiTabBarFlags_None
            if CImGui.BeginTabBar("MyTabBar", tab_bar_flags)
                if CImGui.BeginTabItem("Avocado")
                    CImGui.Text("This is the Avocado tab!\nblah blah blah blah blah")
                    CImGui.EndTabItem()
                end
                if CImGui.BeginTabItem("Broccoli")
                    CImGui.Text("This is the Broccoli tab!\nblah blah blah blah blah")
                    CImGui.EndTabItem()
                end
                if CImGui.BeginTabItem("Cucumber")
                    CImGui.Text("This is the Cucumber tab!\nblah blah blah blah blah")
                    CImGui.EndTabItem()
                end
                CImGui.EndTabBar()
            end
            CImGui.Separator()
            CImGui.TreePop()
        end

        if CImGui.TreeNode("Advanced & Close Button")
            # expose a couple of the available flags. In most cases you may just call BeginTabBar() with no flags (0).
            @cstatic tab_bar_flags=Cint(CImGui.ImGuiTabBarFlags_Reorderable) begin
                @c CImGui.CheckboxFlags("ImGuiTabBarFlags_Reorderable", &tab_bar_flags, CImGui.ImGuiTabBarFlags_Reorderable)
                @c CImGui.CheckboxFlags("ImGuiTabBarFlags_AutoSelectNewTabs", &tab_bar_flags, CImGui.ImGuiTabBarFlags_AutoSelectNewTabs)
                @c CImGui.CheckboxFlags("ImGuiTabBarFlags_TabListPopupButton", &tab_bar_flags, CImGui.ImGuiTabBarFlags_TabListPopupButton)
                @c CImGui.CheckboxFlags("ImGuiTabBarFlags_NoCloseWithMiddleMouseButton", &tab_bar_flags, CImGui.ImGuiTabBarFlags_NoCloseWithMiddleMouseButton)
                if (tab_bar_flags & CImGui.ImGuiTabBarFlags_FittingPolicyMask_) == 0
                    tab_bar_flags |= CImGui.ImGuiTabBarFlags_FittingPolicyDefault_
                end
                result = @c CImGui.CheckboxFlags("ImGuiTabBarFlags_FittingPolicyResizeDown", &tab_bar_flags, CImGui.ImGuiTabBarFlags_FittingPolicyResizeDown)
                if result != 0
                    tab_bar_flags &= ~(CImGui.ImGuiTabBarFlags_FittingPolicyMask_ ⊻ CImGui.ImGuiTabBarFlags_FittingPolicyResizeDown)
                end
                result = @c CImGui.CheckboxFlags("ImGuiTabBarFlags_FittingPolicyScroll", &tab_bar_flags, CImGui.ImGuiTabBarFlags_FittingPolicyScroll)
                if result != 0
                    tab_bar_flags &= ~(CImGui.ImGuiTabBarFlags_FittingPolicyMask_ ⊻ CImGui.ImGuiTabBarFlags_FittingPolicyScroll)
                end

                # Tab Bar
                names = ["Artichoke", "Beetroot", "Celery", "Daikon"]
                @cstatic opened=[true, true, true, true] begin
                    # persistent user state
                    for n = 0:length(opened)-1
                        n > 0 && CImGui.SameLine()
                        CImGui.Checkbox(names[n+1], pointer(opened)+n*sizeof(Bool))
                    end

                    # passing a bool* to BeginTabItem() is similar to passing one to Begin(): the underlying bool will be set to false when the tab is closed.
                    if CImGui.BeginTabBar("MyTabBar", tab_bar_flags)
                        for n = 0:length(opened)-1
                            if opened[n+1] && CImGui.BeginTabItem(names[n+1], pointer(opened)+n*sizeof(Bool))
                                CImGui.Text("This is the $(names[n+1]) tab!")
                                n & 1 != 0 && CImGui.Text("I am an odd tab.")
                                CImGui.EndTabItem()
                            end
                        end
                        CImGui.EndTabBar()
                    end
                end
            end # @cstatic
            CImGui.Separator()
            CImGui.TreePop()
        end
        CImGui.TreePop()
    end

    if CImGui.TreeNode("Groups")
        ShowHelpMarker("Using CImGui.BeginGroup()/EndGroup() to layout items. BeginGroup() basically locks the horizontal position. EndGroup() bundles the whole group so that you can use functions such as IsItemHovered() on it.")
        CImGui.BeginGroup()
        begin
            CImGui.BeginGroup()
            CImGui.Button("AAA")
            CImGui.SameLine()
            CImGui.Button("BBB")
            CImGui.SameLine()
            CImGui.BeginGroup()
            CImGui.Button("CCC")
            CImGui.Button("DDD")
            CImGui.EndGroup()
            CImGui.SameLine()
            CImGui.Button("EEE")
            CImGui.EndGroup()
            CImGui.IsItemHovered() && CImGui.SetTooltip("First group hovered")
        end
        # capture the group size and create widgets using the same size
        size = CImGui.GetItemRectSize()
        values = Cfloat[0.5, 0.20, 0.80, 0.60, 0.25]
        CImGui.PlotHistogram("##values", values, length(values), 0, C_NULL, 0.0, 1.0, size)

        # CImGui.Button("ACTION", ImVec2((size.x - CImGui.GetStyle().ItemSpacing.x)*0.5, size.y))
        CImGui.SameLine()
        # CImGui.Button("REACTION", ImVec2((size.x - CImGui.GetStyle().ItemSpacing.x)*0.5, size.y))
        CImGui.EndGroup()
        CImGui.SameLine()

        CImGui.Button("LEVERAGE\nBUZZWORD", size)
        CImGui.SameLine()

        if CImGui.ListBoxHeader("List", size)
            CImGui.Selectable("Selected", true)
            CImGui.Selectable("Not Selected", false)
            CImGui.ListBoxFooter()
        end

        CImGui.TreePop()
    end
end
