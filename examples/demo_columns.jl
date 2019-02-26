using CImGui
using CImGui: ImVec2

"""
    ShowDemoWindowColumns()
"""
function ShowDemoWindowColumns()
    CImGui.CollapsingHeader("Columns") || return

    CImGui.PushID("Columns")

    # basic columns
    if CImGui.TreeNode("Basic")
        CImGui.Text("Without border:")
        CImGui.Columns(3, "mycolumns3", false) # 3-ways, no border
        CImGui.Separator()
        for n = 0:13
            if CImGui.Selectable("Item $n")
                @info "Trigger Item $n | find me here: $(@__FILE__) at line $(@__LINE__)"
            end
            # if (CImGui.Button(label, ImVec2(-1,0))) {}
            CImGui.NextColumn()
        end
        CImGui.Columns(1)
        CImGui.Separator()

        CImGui.Text("With border:")
        CImGui.Columns(4, "mycolumns") # 4-ways, with border
        CImGui.Separator()
        CImGui.Text("ID"); CImGui.NextColumn()
        CImGui.Text("Name"); CImGui.NextColumn()
        CImGui.Text("Path"); CImGui.NextColumn()
        CImGui.Text("Hovered"); CImGui.NextColumn()
        CImGui.Separator()
        names = ["One", "Two", "Three"]
        paths = ["/path/one", "/path/two", "/path/three"]
        @cstatic selected=Cint(-1) begin
            for i = 0:2
                label = @sprintf "%04d" i
                if CImGui.Selectable(label, selected == i, CImGui.ImGuiSelectableFlags_SpanAllColumns)
                    selected = i
                end
                hovered = CImGui.IsItemHovered()
                CImGui.NextColumn()
                CImGui.Text(names[i+1]); CImGui.NextColumn()
                CImGui.Text(paths[i+1]); CImGui.NextColumn()
                CImGui.Text("hovered"); CImGui.NextColumn()
            end
        end
        CImGui.Columns(1)
        CImGui.Separator()
        CImGui.TreePop()
    end

    # create multiple items in a same cell before switching to next column
    if CImGui.TreeNode("Mixed items")
        CImGui.Columns(3, "mixed")
        CImGui.Separator()

        CImGui.Text("Hello")
        CImGui.Button("Banana")
        CImGui.NextColumn()

        CImGui.Text("ImGui")
        CImGui.Button("Apple")
        @cstatic foo=Cfloat(1.0) @c CImGui.InputFloat("red", &foo, 0.05, 0, "%.3f")
        CImGui.Text("An extra line here.")
        CImGui.NextColumn()

        CImGui.Text("Sailor")
        CImGui.Button("Corniflower")
        @cstatic bar=Cfloat(1.0) @c CImGui.InputFloat("blue", &bar, 0.05, 0, "%.3f")
        CImGui.NextColumn()

        CImGui.CollapsingHeader("Category A") && CImGui.Text("Blah blah blah")
        CImGui.NextColumn()
        CImGui.CollapsingHeader("Category B") && CImGui.Text("Blah blah blah")
        CImGui.NextColumn()
        CImGui.CollapsingHeader("Category C") && CImGui.Text("Blah blah blah")
        CImGui.NextColumn()
        CImGui.Columns(1)
        CImGui.Separator()
        CImGui.TreePop()
    end

    # word wrapping
    if CImGui.TreeNode("Word-wrapping")
        CImGui.Columns(2, "word-wrapping")
        CImGui.Separator()
        CImGui.TextWrapped("The quick brown fox jumps over the lazy dog.")
        CImGui.TextWrapped("Hello Left")
        CImGui.NextColumn()
        CImGui.TextWrapped("The quick brown fox jumps over the lazy dog.")
        CImGui.TextWrapped("Hello Right")
        CImGui.Columns(1)
        CImGui.Separator()
        CImGui.TreePop()
    end

    if CImGui.TreeNode("Borders")
        # NB: Future columns API should allow automatic horizontal borders.
        @cstatic h_borders=true v_borders=true begin
            @c CImGui.Checkbox("horizontal", &h_borders)
            CImGui.SameLine()
            @c CImGui.Checkbox("vertical", &v_borders)
            CImGui.Columns(4, C_NULL, v_borders)
            for i = 0:4*3-1
                (h_borders && CImGui.GetColumnIndex() == 0) && CImGui.Separator()
                CImGui.Text(@sprintf("%c%c%c", 'a'+i, 'a'+i, 'a'+i))
                CImGui.Text(@sprintf("Width %.2f\nOffset %.2f", CImGui.GetColumnWidth(), CImGui.GetColumnOffset()))
                CImGui.NextColumn()
            end
            CImGui.Columns(1)
            h_borders && CImGui.Separator()
        end
        CImGui.TreePop()
    end

    # scrolling columns
    # if CImGui.TreeNode("Vertical Scrolling")
    #     CImGui.BeginChild("##header", ImVec2(0, CImGui.GetTextLineHeightWithSpacing()+CImGui.GetStyle().ItemSpacing.y))
    #     CImGui.Columns(3)
    #     CImGui.Text("ID"); CImGui.NextColumn()
    #     CImGui.Text("Name"); CImGui.NextColumn()
    #     CImGui.Text("Path"); CImGui.NextColumn()
    #     CImGui.Columns(1)
    #     CImGui.Separator()
    #     CImGui.EndChild()
    #     CImGui.BeginChild("##scrollingregion", (0, 60))
    #     CImGui.Columns(3)
    #     for i = 0:9
    #         CImGui.Text(@sprintf("%04d", i))
    #         CImGui.NextColumn()
    #         CImGui.Text("Foobar")
    #         CImGui.NextColumn()
    #         CImGui.Text(@sprintf("/path/foobar/%04d/", i))
    #         CImGui.NextColumn()
    #     end
    #     CImGui.Columns(1)
    #     CImGui.EndChild()
    #     CImGui.TreePop()
    # end

    if CImGui.TreeNode("Horizontal Scrolling")
        CImGui.SetNextWindowContentSize((1500.0, 0.0))
        CImGui.BeginChild("##ScrollingRegion", ImVec2(0, CImGui.GetFontSize() * 20), false, CImGui.ImGuiWindowFlags_HorizontalScrollbar)
        CImGui.Columns(10)
        ITEMS_COUNT = 2000

        clipper = CImGui.Clipper(ITEMS_COUNT) # also demonstrate using the clipper for large list
        while CImGui.Step(clipper)
            s = CImGui.Get(clipper, :DisplayStart)
            e = CImGui.Get(clipper, :DisplayEnd)-1
            for i = s:e, j = 0:9
                CImGui.Text("Line $i Column $j...")
                CImGui.NextColumn()
            end
        end
        CImGui.Destroy(clipper)

        CImGui.Columns(1)
        CImGui.EndChild()
        CImGui.TreePop()
    end

    node_open = CImGui.TreeNode("Tree within single cell")
    CImGui.SameLine()
    ShowHelpMarker("NB: Tree node must be poped before ending the cell. There's no storage of state per-cell.")
    if node_open
        CImGui.Columns(2, "tree items")
        CImGui.Separator()
        if CImGui.TreeNode("Hello")
            CImGui.BulletText("Sailor")
            CImGui.TreePop()
        end
        CImGui.NextColumn()
        if CImGui.TreeNode("Bonjour")
            CImGui.BulletText("Marin")
            CImGui.TreePop()
        end
        CImGui.NextColumn()
        CImGui.Columns(1)
        CImGui.Separator()
        CImGui.TreePop()
    end
    CImGui.PopID()
end
