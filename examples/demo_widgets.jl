using CImGui
using CImGui.CSyntax
using CImGui.CSyntax.CStatic
using CImGui: ImVec2, ImVec4, IM_COL32, ImS32, ImU32, ImS64, ImU64

"""
    ShowDemoWindowWidgets()
"""
function ShowDemoWindowWidgets()
    CImGui.CollapsingHeader("Widgets") || return

    if CImGui.TreeNode("Basic")
        @cstatic clicked=Cint(0) begin
            CImGui.Button("Button") && (clicked += 1;)
            if clicked & 1 != 0
                CImGui.SameLine()
                CImGui.Text("Thanks for clicking me!")
            end
        end

        @cstatic check=true @c CImGui.Checkbox("checkbox", &check)

        @cstatic e=Cint(0) begin
            @c CImGui.RadioButton("radio a", &e, 0); CImGui.SameLine()
            @c CImGui.RadioButton("radio b", &e, 1); CImGui.SameLine()
            @c CImGui.RadioButton("radio c", &e, 2);
        end

        # color buttons, demonstrate using PushID() to add unique identifier in the ID stack, and changing style.
        for i = 0:7-1
            i > 0 && CImGui.SameLine()
            CImGui.PushID(i)
            CImGui.PushStyleColor(CImGui.ImGuiCol_Button, CImGui.HSV(i/7.0, 0.6, 0.6))
            CImGui.PushStyleColor(CImGui.ImGuiCol_ButtonHovered, CImGui.HSV(i/7.0, 0.7, 0.7))
            CImGui.PushStyleColor(CImGui.ImGuiCol_ButtonActive, CImGui.HSV(i/7.0, 0.8, 0.8))
            CImGui.Button("Click")
            CImGui.PopStyleColor(3)
            CImGui.PopID()
        end

        # use AlignTextToFramePadding() to align text baseline to the baseline of framed elements (otherwise a Text+SameLine+Button sequence will have the text a little too high by default)
        CImGui.AlignTextToFramePadding()
        CImGui.Text("Hold to repeat:")
        CImGui.SameLine()

        # arrow buttons with Repeater
        @cstatic counter=Cint(0) begin
            spacing = CImGui.GetStyle().ItemInnerSpacing.x
            CImGui.PushButtonRepeat(true)
            CImGui.ArrowButton("##left", CImGui.ImGuiDir_Left) && (counter-=1;)
            CImGui.SameLine(0.0, spacing)
            CImGui.ArrowButton("##right", CImGui.ImGuiDir_Right) && (counter+=1;)
            CImGui.PopButtonRepeat()
            CImGui.SameLine()
            CImGui.Text("$counter")
        end

        CImGui.Text("Hover over me")
        CImGui.IsItemHovered() && CImGui.SetTooltip("I am a tooltip")

        CImGui.SameLine()
        CImGui.Text("- or me")
        if CImGui.IsItemHovered()
            CImGui.BeginTooltip()
            CImGui.Text("I am a fancy tooltip")
            @cstatic arr=Cfloat[0.6, 0.1, 1.0, 0.5, 0.92, 0.1, 0.2] CImGui.PlotLines("Curve", arr, length(arr))
            CImGui.EndTooltip()
        end

        CImGui.Separator()

        CImGui.LabelText("label", "Value")

        @cstatic item_current=Cint(0)
                 items = ["AAAA", "BBBB", "CCCC", "DDDD", "EEEE", "FFFF", "GGGG", "HHHH", "IIII", "JJJJ", "KKKK", "LLLLLLL", "MMMM", "OOOOOOO"]
                begin
            # using the _simplified_ one-liner Combo() api here
            # see "Combo" section for examples of how to use the more complete BeginCombo()/EndCombo() api.
            @c CImGui.Combo("combo", &item_current, items, length(items))
            CImGui.SameLine()
            ShowHelpMarker("Refer to the \"Combo\" section below for an explanation of the full BeginCombo/EndCombo API, and demonstration of various flags.\n")
        end

        @cstatic str0="Hello, world!"*"\0"^115 i0=Cint(123) begin
            CImGui.InputText("input text", str0, length(str0))
            CImGui.SameLine()
            ShowHelpMarker("USER:\nHold SHIFT or use mouse to select text.\n"*"CTRL+Left/Right to word jump.\n"*"CTRL+A or double-click to select all.\n"*"CTRL+X,CTRL+C,CTRL+V clipboard.\n"*"CTRL+Z,CTRL+Y undo/redo.\n"*"ESCAPE to revert.\n\nPROGRAMMER:\nYou can use the ImGuiInputTextFlags_CallbackResize facility if you need to wire InputText() to a dynamic string type. See misc/cpp/imgui_stdlib.h for an example (this is not demonstrated in imgui_demo.cpp).")

            @c CImGui.InputInt("input int", &i0)
            CImGui.SameLine(); ShowHelpMarker("You can apply arithmetic operators +,*,/ on numerical values.\n  e.g. [ 100 ], input \'*2\', result becomes [ 200 ]\nUse +- to subtract.\n")
        end

        @cstatic f0=Cfloat(0.001) d0=Cdouble(999999.00000001) f1=Cfloat(1.e10) begin
            @c CImGui.InputFloat("input float", &f0, 0.01, 1.0, "%.3f")
            @c CImGui.InputDouble("input double", &d0, 0.01, 1.0, "%.8f")
            @c CImGui.InputFloat("input scientific", &f1, 0.0, 0.0, "%e")
            CImGui.SameLine()
            ShowHelpMarker("You can input value using the scientific notation,\n  e.g. \"1e+8\" becomes \"100000000\".\n")
        end
        @cstatic vec4a=Cfloat[0.10, 0.20, 0.30, 0.44] CImGui.InputFloat3("input float3", vec4a)

        @cstatic i1=Cint(50) i2=Cint(42) begin
            @c CImGui.DragInt("drag int", &i1, 1)
            CImGui.SameLine()
            ShowHelpMarker("Click and drag to edit value.\nHold SHIFT/ALT for faster/slower edit.\nDouble-click or CTRL+click to input value.")

            @c CImGui.DragInt("drag int 0..100", &i2, 1, 0, 100, "%d%%")
        end

        @cstatic f1=Cfloat(1.00) f2=Cfloat(0.0067) begin
            @c CImGui.DragFloat("drag float", &f1, 0.005)
            @c CImGui.DragFloat("drag small float", &f2, 0.0001, 0.0, 0.0, "%.06f ns")
        end

        @cstatic i1=Cint(0) f1=Cfloat(0.123) f2=Cfloat(0.0) angle=Cfloat(0.0) begin
            @c CImGui.SliderInt("slider int", &i1, -1, 3)
            CImGui.SameLine()
            ShowHelpMarker("CTRL+click to input value.")

            @c CImGui.SliderFloat("slider float", &f1, 0.0, 1.0, "ratio = %.3f")
            @c CImGui.SliderFloat("slider float (curve)", &f2, -10.0, 10.0, "%.4f", 2.0)

            @c CImGui.SliderAngle("slider angle", &angle)
        end

        @cstatic col1=Cfloat[1.0,0.0,0.2] col2=Cfloat[0.4,0.7,0.0,0.5] begin
            CImGui.ColorEdit3("color 1", col1)
            CImGui.SameLine()
            ShowHelpMarker("Click on the colored square to open a color picker.\nClick and hold to use drag and drop.\nRight-click on the colored square to show options.\nCTRL+click on individual component to input value.\n")
            CImGui.ColorEdit4("color 2", col2)
        end

        @cstatic listbox_item_current=Cint(1) listbox_items=["Apple", "Banana", "Cherry", "Kiwi", "Mango", "Orange", "Pineapple", "Strawberry", "Watermelon"] begin
            # list box
            @c CImGui.ListBox("listbox\n(single select)", &listbox_item_current, listbox_items, length(listbox_items), 4)
        end
        # CImGui.PushItemWidth(-1)
        # CImGui.ListBox("##listbox2", &listbox_item_current2, listbox_items, length(listbox_items), 4)
        # CImGui.PopItemWidth()

        CImGui.TreePop()
    end

    if CImGui.TreeNode("Trees")
        if CImGui.TreeNode("Basic trees")
            for i = 0:4
                if CImGui.TreeNode(Ptr{Cvoid}(i), "Child $i")
                    CImGui.Text("blah blah")
                    CImGui.SameLine()
                    CImGui.SmallButton("button") && @info "Trigger `Basic trees`'s button | find me here: $(@__FILE__) at line $(@__LINE__)"
                    CImGui.TreePop()
                end
            end
            CImGui.TreePop()
        end

        if CImGui.TreeNode("Advanced, with Selectable nodes")
            ShowHelpMarker("This is a more standard looking tree with selectable nodes.\nClick to select, CTRL+Click to toggle, click on arrows or double-click to open.")
            align_label_with_current_x_position= @cstatic align_label_with_current_x_position=false begin
                @c CImGui.Checkbox("Align label with current X position)", &align_label_with_current_x_position)
                CImGui.Text("Hello!")
                align_label_with_current_x_position && CImGui.Unindent(CImGui.GetTreeNodeToLabelSpacing())
            end

            @cstatic selection_mask=Cint(1 << 2) begin  # dumb representation of what may be user-side selection state. You may carry selection state inside or outside your objects in whatever format you see fit.
                node_clicked = -1  # temporary storage of what node we have clicked to process selection at the end of the loop. May be a pointer to your own node type, etc.
                CImGui.PushStyleVar(CImGui.ImGuiStyleVar_IndentSpacing, CImGui.GetFontSize()*3) # increase spacing to differentiate leaves from expanded contents.
                for i = 0:5
                    # disable the default open on single-click behavior and pass in Selected flag according to our selection state.
                    node_flags = CImGui.ImGuiTreeNodeFlags_OpenOnArrow | CImGui.ImGuiTreeNodeFlags_OpenOnDoubleClick | ((selection_mask & (1 << i)) != 0 ? CImGui.ImGuiTreeNodeFlags_Selected : 0)
                    if i < 3
                        # Node
                        node_open = CImGui.TreeNodeEx(Ptr{Cvoid}(i), node_flags, "Selectable Node $i")
                        CImGui.IsItemClicked() && (node_clicked = i;)
                        node_open && (CImGui.Text("Blah blah\nBlah Blah"); CImGui.TreePop();)
                    else
                        # Leaf: The only reason we have a TreeNode at all is to allow selection of the leaf. Otherwise we can use BulletText() or TreeAdvanceToLabelPos()+Text().
                        node_flags |= CImGui.ImGuiTreeNodeFlags_Leaf | CImGui.ImGuiTreeNodeFlags_NoTreePushOnOpen # CImGui.ImGuiTreeNodeFlags_Bullet
                        CImGui.TreeNodeEx(Ptr{Cvoid}(i), node_flags, "Selectable Leaf $i")
                        CImGui.IsItemClicked() && (node_clicked = i;)
                    end
                end
                if node_clicked != -1
                    # update selection state. Process outside of tree loop to avoid visual inconsistencies during the clicking-frame.
                    if CImGui.GetIO().KeyCtrl
                        selection_mask ⊻= 1 << node_clicked           # CTRL+click to toggle
                    else #if (!(selection_mask & (1 << node_clicked))) # Depending on selection behavior you want, this commented bit preserve selection when clicking on item that is part of the selection
                        selection_mask = 1 << node_clicked            # Click to single-select
                    end
                end
                CImGui.PopStyleVar()
            end # @cstatic
            align_label_with_current_x_position && CImGui.Indent(CImGui.GetTreeNodeToLabelSpacing())
            CImGui.TreePop()
        end
        CImGui.TreePop()
    end

    if CImGui.TreeNode("Collapsing Headers")
        @cstatic closable_group=true begin
            @c CImGui.Checkbox("Enable extra group", &closable_group)
            if CImGui.CollapsingHeader("Header")
                CImGui.Text("IsItemHovered: $(CImGui.IsItemHovered())")
                foreach(i->CImGui.Text("Some content $i"), 0:4)
            end
            if @c CImGui.CollapsingHeader("Header with a close button", &closable_group)
                CImGui.Text("IsItemHovered: $(CImGui.IsItemHovered())")
                foreach(i->CImGui.Text("More content $i"), 0:4)
            end
        end
        CImGui.TreePop()
    end

    if CImGui.TreeNode("Bullets")
        CImGui.BulletText("Bullet point 1")
        CImGui.BulletText("Bullet point 2\nOn multiple lines")
        CImGui.Bullet()
        CImGui.Text("Bullet point 3 (two calls)")
        CImGui.Bullet()
        CImGui.SmallButton("Button") && @info "Trigger `Bullets`'s Button | find me here: $(@__FILE__) at line $(@__LINE__)"
        CImGui.TreePop()
    end

    if CImGui.TreeNode("Text")
        if CImGui.TreeNode("Colored Text")
            # using shortcut. You can use PushStyleColor()/PopStyleColor() for more flexibility.
            CImGui.TextColored(ImVec4(1.0,0.0,1.0,1.0), "Pink")
            CImGui.TextColored(ImVec4(1.0,1.0,0.0,1.0), "Yellow")
            CImGui.TextDisabled("Disabled")
            CImGui.SameLine()
            ShowHelpMarker("The TextDisabled color is stored in ImGuiStyle.")
            CImGui.TreePop()
        end

        if CImGui.TreeNode("Word Wrapping")
            # using shortcut. You can use PushTextWrapPos()/PopTextWrapPos() for more flexibility.
            CImGui.TextWrapped("This text should automatically wrap on the edge of the window. The current implementation for text wrapping follows simple rules suitable for English and possibly other languages.")
            CImGui.Spacing()

            @cstatic wrap_width = Cfloat(200.0) begin
                @c CImGui.SliderFloat("Wrap width", &wrap_width, -20, 600, "%.0f")

                CImGui.Text("Test paragraph 1:")
                pos = CImGui.GetCursorScreenPos()
                draw_list = CImGui.GetWindowDrawList()
                CImGui.AddRectFilled(draw_list, ImVec2(pos.x + wrap_width, pos.y), ImVec2(pos.x + wrap_width + 10, pos.y + CImGui.GetTextLineHeight()), IM_COL32(255,0,255,255))
                CImGui.PushTextWrapPos(CImGui.GetCursorPos().x + wrap_width)
                CImGui.Text("The lazy dog is a good dog. This paragraph is made to fit within $wrap_width pixels. Testing a 1 character word. The quick brown fox jumps over the lazy dog.")
                CImGui.AddRect(draw_list, CImGui.GetItemRectMin(), CImGui.GetItemRectMax(), IM_COL32(255,255,0,255))
                CImGui.PopTextWrapPos()

                CImGui.Text("Test paragraph 2:")
                pos = CImGui.GetCursorScreenPos()
                CImGui.AddRectFilled(draw_list, ImVec2(pos.x + wrap_width, pos.y), ImVec2(pos.x + wrap_width + 10, pos.y + CImGui.GetTextLineHeight()), IM_COL32(255,0,255,255))
                CImGui.PushTextWrapPos(CImGui.GetCursorPos().x + wrap_width)
                CImGui.Text("aaaaaaaa bbbbbbbb, c cccccccc,dddddddd. d eeeeeeee   ffffffff. gggggggg!hhhhhhhh")
                CImGui.AddRect(draw_list, CImGui.GetItemRectMin(), CImGui.GetItemRectMax(), IM_COL32(255,255,0,255))
                CImGui.PopTextWrapPos()
            end
            CImGui.TreePop()
        end

        # if CImGui.TreeNode("UTF-8 Text")
        #     # UTF-8 test with Japanese characters
        #     # (Needs a suitable font, try Noto, or Arial Unicode, or M+ fonts. Read misc/fonts/README.txt for details.)
        #     # - From C++11 you can use the u8"my text" syntax to encode literal strings as UTF-8
        #     # - For earlier compiler, you may be able to encode your sources as UTF-8 (e.g. Visual Studio save your file as 'UTF-8 without signature')
        #     # - FOR THIS DEMO FILE ONLY, BECAUSE WE WANT TO SUPPORT OLD COMPILERS, WE ARE *NOT* INCLUDING RAW UTF-8 CHARACTERS IN THIS SOURCE FILE.
        #     #   Instead we are encoding a few strings with hexadecimal constants. Don't do this in your application!
        #     #   Please use u8"text in any language" in your application!
        #     # Note that characters values are preserved even by InputText() if the font cannot be displayed, so you can safely copy & paste garbled characters into another application.
        #     CImGui.TextWrapped("CJK text will only appears if the font was loaded with the appropriate CJK character ranges. Call io.Font->AddFontFromFileTTF() manually to load extra character ranges. Read misc/fonts/README.txt for details.")
        #     CImGui.Text("Hiragana: \xe3\x81\x8b\xe3\x81\x8d\xe3\x81\x8f\xe3\x81\x91\xe3\x81\x93 (kakikukeko)") # Normally we would use u8"blah blah" with the proper characters directly in the string.
        #     CImGui.Text("Kanjis: \xe6\x97\xa5\xe6\x9c\xac\xe8\xaa\x9e (nihongo)")
        #     static char buf[32] = "\xe6\x97\xa5\xe6\x9c\xac\xe8\xaa\x9e"
        #     CImGui.InputText("UTF-8 input", buf, IM_ARRAYSIZE(buf))
        #     CImGui.TreePop()
        # end
        CImGui.TreePop()
    end

    if CImGui.TreeNode("Images")
        io = CImGui.GetIO()
        CImGui.TextWrapped("Below we are displaying the font texture (which is the only texture we have access to in this demo). Use the 'ImTextureID' type as storage to pass pointers or identifier to your own texture data. Hover the texture for a zoomed view!")

        # Here we are grabbing the font texture because that's the only one we have access to inside the demo code.
        # Remember that ImTextureID is just storage for whatever you want it to be, it is essentially a value that will be passed to the render function inside the ImDrawCmd structure.
        # If you use one of the default imgui_impl_XXXX.cpp renderer, they all have comments at the top of their file to specify what they expect to be stored in ImTextureID.
        # (for example, the imgui_impl_dx11.cpp renderer expect a 'ID3D11ShaderResourceView*' pointer. The imgui_impl_glfw_gl3.cpp renderer expect a GLuint OpenGL texture identifier etc.)
        # If you decided that ImTextureID = MyEngineTexture*, then you can pass your MyEngineTexture* pointers to CImGui.Image(), and gather width/height through your own functions, etc.
        # Using ShowMetricsWindow() as a "debugger" to inspect the draw data that are being passed to your render will help you debug issues if you are confused about this.
        # Consider using the lower-level ImDrawList::AddImage() API, via CImGui.GetWindowDrawList()->AddImage().
        my_tex_id = io.Fonts.TexID
        my_tex_w = io.Fonts.TexWidth
        my_tex_h = io.Fonts.TexHeight

        CImGui.Text(@sprintf("%.0fx%.0f", my_tex_w, my_tex_h))
        pos = CImGui.GetCursorScreenPos()
        CImGui.Image(my_tex_id, ImVec2(my_tex_w, my_tex_h), (0,0), (1,1), (255,255,255,255), (255,255,255,128))
        if CImGui.IsItemHovered()
            CImGui.BeginTooltip()
            region_sz = 32.0
            region_x = io.MousePos.x - pos.x - region_sz * 0.5
            if region_x < 0.0
                region_x = 0.0
            elseif region_x > my_tex_w - region_sz
                region_x = my_tex_w - region_sz
            end
            region_y = io.MousePos.y - pos.y - region_sz * 0.5
            if region_y < 0.0
                region_y = 0.0
            elseif region_y > my_tex_h - region_sz
                region_y = my_tex_h - region_sz
            end
            zoom = 4.0
            CImGui.Text(@sprintf("Min: (%.2f, %.2f)", region_x, region_y))
            CImGui.Text(@sprintf("Max: (%.2f, %.2f)", region_x + region_sz, region_y + region_sz))
            uv0 = ImVec2((region_x) / my_tex_w, (region_y) / my_tex_h)
            uv1 = ImVec2((region_x + region_sz) / my_tex_w, (region_y + region_sz) / my_tex_h)
            CImGui.Image(my_tex_id, ImVec2(region_sz * zoom, region_sz * zoom), uv0, uv1, (255,255,255,255), (255,255,255,128))
            CImGui.EndTooltip()
        end
        CImGui.TextWrapped("And now some textured buttons..")
        @cstatic pressed_count=Cint(0) begin
            for i = 0:8-1
                CImGui.PushID(i)
                frame_padding = -1 + i     # -1 = uses default padding
                if CImGui.ImageButton(my_tex_id, (32,32), (0,0), ImVec2(32.0/my_tex_w,32/my_tex_h), frame_padding, (0,0,0,255))
                    pressed_count += 1
                end
                CImGui.PopID()
                CImGui.SameLine()
            end
            CImGui.NewLine()
            CImGui.Text("Pressed $pressed_count times.")
        end
        CImGui.TreePop()
    end

    if CImGui.TreeNode("Combo")
        # expose flags as checkbox for the demo
        flags = @cstatic flags=Cint(0) begin
            @c CImGui.CheckboxFlags("ImGuiComboFlags_PopupAlignLeft", &flags, CImGui.ImGuiComboFlags_PopupAlignLeft)
            if @c(CImGui.CheckboxFlags("ImGuiComboFlags_NoArrowButton", &flags, CImGui.ImGuiComboFlags_NoArrowButton)) != 0
                flags &= ~CImGui.ImGuiComboFlags_NoPreview # clear the other flag, as we cannot combine both
            end
            if @c(CImGui.CheckboxFlags("ImGuiComboFlags_NoPreview", &flags, CImGui.ImGuiComboFlags_NoPreview)) != 0
                flags &= ~CImGui.ImGuiComboFlags_NoArrowButton # clear the other flag, as we cannot combine both
            end
        end

        # general BeginCombo() API, you have full control over your selection data and display type.
        # (your selection data could be an index, a pointer to the object, an id for the object, a flag stored in the object itself, etc.)
        items = ["AAAA", "BBBB", "CCCC", "DDDD", "EEEE", "FFFF", "GGGG", "HHHH", "IIII", "JJJJ", "KKKK", "LLLLLLL", "MMMM", "OOOOOOO"]
        @cstatic item_current="AAAA" begin
            # here our selection is a single pointer stored outside the object.
            if CImGui.BeginCombo("combo 1", item_current, flags) # the second parameter is the label previewed before opening the combo.
                for n = 0:length(items)-1
                    is_selected = item_current == items[n+1]
                    CImGui.Selectable(items[n+1], is_selected) && (item_current = items[n+1];)
                    is_selected && CImGui.SetItemDefaultFocus() # set the initial focus when opening the combo (scrolling + for keyboard navigation support in the upcoming navigation branch)
                end
                CImGui.EndCombo()
            end
        end

        # simplified one-liner Combo() API, using values packed in a single constant string
        @cstatic item_current_2=Cint(0) begin
            @c CImGui.Combo("combo 2 (one-liner)", &item_current_2, "aaaa\0bbbb\0cccc\0dddd\0eeee\0\0")
        end

        # simplified one-liner Combo() using an array of const char*
        @cstatic item_current_3=Cint(-1) begin
            # if the selection isn't within 0..count, Combo won't display a preview
            @c CImGui.Combo("combo 3 (array)", &item_current_3, items, length(items))
        end

        # simplified one-liner Combo() using an accessor function
        function ItemGetter(data::Ptr{Ptr{Cchar}}, idx::Cint, out_str::Ptr{Ptr{Cchar}})::Bool
            unsafe_store!(out_str, unsafe_load(data, idx+1), idx+1)  # FIXME
            return true
        end
        FuncHolder = @cfunction($ItemGetter, Bool, (Ptr{Ptr{Cchar}},Cint,Ptr{Ptr{Cchar}}))
        @cstatic item_current_4=Cint(0) begin
            @c CImGui.Combo("combo 4 (function)", &item_current_4, FuncHolder, items, length(items))
        end

        CImGui.TreePop()
    end

    if CImGui.TreeNode("Selectables")
        # Selectable() has 2 overloads:
        # - The one taking "bool selected" as a read-only selection information. When Selectable() has been clicked is returns true and you can alter selection state accordingly.
        # - The one taking "bool* p_selected" as a read-write selection information (convenient in some cases)
        #  The earlier is more flexible, as in real application your selection may be stored in a different manner (in flags within objects, as an external list, etc).
        if CImGui.TreeNode("Basic")
            @cstatic selection = [false, true, false, false, false] begin
                CImGui.Selectable("1. I am selectable", pointer(selection))
                CImGui.Selectable("2. I am selectable", pointer(selection)+sizeof(Bool))
                CImGui.Text("3. I am not selectable")
                CImGui.Selectable("4. I am selectable", pointer(selection)+3*sizeof(Bool))
                if CImGui.Selectable("5. I am double clickable", pointer(selection)+4*sizeof(Bool), CImGui.ImGuiSelectableFlags_AllowDoubleClick)
                    CImGui.IsMouseDoubleClicked(0) && (selection[5] = !selection[5];)
                end
            end
            CImGui.TreePop()
        end
        if CImGui.TreeNode("Selection State: Single Selection")
            @cstatic selected = Cint(-1) begin
                for n = 0:4
                    buf = @sprintf "Object %d" n
                    CImGui.Selectable(buf, selected == n) && (selected = n;)
                end
            end
            CImGui.TreePop()
        end
        if CImGui.TreeNode("Selection State: Multiple Selection")
            ShowHelpMarker("Hold CTRL and click to select multiple items.")
            @cstatic selection=[false, false, false, false, false] begin
                for n = 0:4
                    buf = @sprintf "Object %d" n
                    if CImGui.Selectable(buf, selection[n+1])
                        # clear selection when CTRL is not held
                        !CImGui.GetIO().KeyCtrl && fill!(selection, false)
                        selection[n+1] ⊻= 1
                    end
                end
            end
            CImGui.TreePop()
        end
        if CImGui.TreeNode("Rendering more text into the same line")
            # using the Selectable() override that takes "bool* p_selected" parameter and toggle your booleans automatically.
            @cstatic selected=[false, false, false] begin
                CImGui.Selectable("main.c", pointer(selected))
                CImGui.SameLine(300)
                CImGui.Text(" 2,345 bytes")
                CImGui.Selectable("Hello.cpp", pointer(selected)+sizeof(Bool))
                CImGui.SameLine(300)
                CImGui.Text("12,345 bytes")
                CImGui.Selectable("Hello.h", pointer(selected)+2sizeof(Bool))
                CImGui.SameLine(300)
                CImGui.Text(" 2,345 bytes")
            end
            CImGui.TreePop()
        end
        if CImGui.TreeNode("In columns")
            CImGui.Columns(3, C_NULL, false)
            @cstatic selected=[false for i = 1:16] begin
                for i = 0:16-1
                    label = @sprintf("Item %d", i)
                    CImGui.Selectable(label, pointer(selected)+i*sizeof(Bool)) && @info "Trigger | find me here: $(@__FILE__) at line $(@__LINE__)"
                    CImGui.NextColumn()
                end
                CImGui.Columns(1)
            end
            CImGui.TreePop()
        end
        if CImGui.TreeNode("Grid")
            @cstatic selected=[true, false, false, false, false, true, false, false, false, false, true, false, false, false, false, true] begin
                for i = 0:4*4-1
                    CImGui.PushID(i)
                    if CImGui.Selectable("Sailor", pointer(selected)+i*sizeof(Bool), 0, ImVec2(50,50))
                        # note: We _unnecessarily_ test for both x/y and i here only to silence some static analyzer. The second part of each test is unnecessary.
                        x = i % 4
                        y = i / 4
                        x > 0 && (selected[i] ⊻= 1;)
                        (x < 3 && i < 15) && (selected[i + 2] ⊻= 1;)
                        (y > 0 && i > 3) && (selected[i - 3] ⊻= 1;)
                        (y < 3 && i < 12) && (selected[i + 5] ⊻= 1;)
                    end
                    (i % 4) < 3 && CImGui.SameLine()
                    CImGui.PopID()
                end
            end
            CImGui.TreePop()
        end
        if CImGui.TreeNode("Alignment")
            ShowHelpMarker("Alignment applies when a selectable is larger than its text content.\nBy default, Selectables uses style.SelectableTextAlign but it can be overriden on a per-item basis using PushStyleVar().");
            @cstatic selected=[true, false, true, false, true, false, true, false, true] begin
                for y = 0:3-1
                    for x = 0:3-1
                        alignment = ImVec2(x / 2.0, y / 2.0)
                        name = @sprintf("(%.1f,%.1f)", alignment.x, alignment.y)
                        x > 0 && CImGui.SameLine()
                        CImGui.PushStyleVar(CImGui.ImGuiStyleVar_SelectableTextAlign, alignment)
                        CImGui.Selectable(name, pointer(selected)+(3*y+x)*sizeof(Bool), CImGui.ImGuiSelectableFlags_None, ImVec2(80,80))
                        CImGui.PopStyleVar()
                    end
                end
            end
            CImGui.TreePop()
        end
        CImGui.TreePop()
    end

    if CImGui.TreeNode("Filtered Text Input")
        @cstatic buf1="\0"^64 CImGui.InputText("default", buf1, 64)
        @cstatic buf2="\0"^64 CImGui.InputText("decimal", buf2, 64, CImGui.ImGuiInputTextFlags_CharsDecimal)
        @cstatic buf3="\0"^64 CImGui.InputText("hexadecimal", buf3, 64, CImGui.ImGuiInputTextFlags_CharsHexadecimal | CImGui.ImGuiInputTextFlags_CharsUppercase)
        @cstatic buf4="\0"^64 CImGui.InputText("uppercase", buf4, 64, CImGui.ImGuiInputTextFlags_CharsUppercase)
        @cstatic buf5="\0"^64 CImGui.InputText("no blank", buf5, 64, CImGui.ImGuiInputTextFlags_CharsNoBlank)

        # FIXME
        # function FilterImGuiLetters(Ptr{CImGui.ImGuiInputTextCallbackData} data)::Cint
        #     if data->EventChar < 256 && strchr("imgui", (char)data->EventChar)
        #         return 0
        #     else
        #         return 1
        #     end
        # end
        # funcptr = @cfunction($FilterImGuiLetters, Cvoid, (Ptr{CImGui.ImGuiInputTextCallbackData},))
        # @cstatic buf6="\0"^64 CImGui.InputText("\"imgui\" letters", buf6, 64, CImGui.ImGuiInputTextFlags_CallbackCharFilter, funcptr)

        CImGui.Text("Password input")
        @cstatic bufpass="password123"*"\0"^53 begin
            CImGui.InputText("password", bufpass, 64, CImGui.ImGuiInputTextFlags_Password | CImGui.ImGuiInputTextFlags_CharsNoBlank)
            CImGui.SameLine()
            ShowHelpMarker("Display all characters as '*'.\nDisable clipboard cut and copy.\nDisable logging.\n")
            CImGui.InputText("password (clear)", bufpass, 64, CImGui.ImGuiInputTextFlags_CharsNoBlank)
        end
        CImGui.TreePop()
    end

    if CImGui.TreeNode("Multi-line Text Input")
        # note: we are using a fixed-sized buffer for simplicity here. See ImGuiInputTextFlags_CallbackResize
        # and the code in misc/cpp/imgui_stdlib.h for how to setup InputText() for dynamically resizing strings.
        @cstatic read_only=false (text="/*\n"*
                                       " The Pentium F00F bug, shorthand for F0 0F C7 C8,\n"*
                                       " more formally, the invalid operand with locked CMPXCHG8B\n"*
                                       " instruction bug, is a design flaw in the majority of\n"*
                                       " Intel Pentium, Pentium MMX, and Pentium OverDrive\n"*
                                       " processors (all in the P5 microarchitecture).\n"*
                                       "*/\n\n"*
                                       "label:\n"*
                                       "\tlock cmpxchg8b eax\n"*"\0"^(1024*16-249)) begin
            ShowHelpMarker("You can use the ImGuiInputTextFlags_CallbackResize facility if you need to wire InputTextMultiline() to a dynamic string type. See misc/cpp/imgui_stdlib.h for an example. (This is not demonstrated in imgui_demo.cpp)")
            @c CImGui.Checkbox("Read-only", &read_only)
            flags = CImGui.ImGuiInputTextFlags_AllowTabInput | (read_only ? CImGui.ImGuiInputTextFlags_ReadOnly : 0)
            CImGui.InputTextMultiline("##source", text, length(text), ImVec2(-1.0, CImGui.GetTextLineHeight() * 16), flags)
            CImGui.TreePop()
        end
    end

    if CImGui.TreeNode("Plots Widgets")
        animate, _ = @cstatic animate=true arr=Cfloat[0.6, 0.1, 1.0, 0.5, 0.92, 0.1, 0.2] begin
            @c CImGui.Checkbox("Animate", &animate)
            CImGui.PlotLines("Frame Times", arr, length(arr))
            # create a dummy array of contiguous float values to plot
            # Tip: If your float aren't contiguous but part of a structure, you can pass a pointer to your first float and the sizeof() of your structure in the Stride parameter.
            @cstatic values=fill(Cfloat(0),90) values_offset=Cint(0) refresh_time=Cdouble(0) begin
                (!animate || refresh_time == 0.0) && (refresh_time = CImGui.GetTime();)

                while refresh_time < CImGui.GetTime() # create dummy data at fixed 60 hz rate for the demo
                    @cstatic phase=Cfloat(0) begin
                        values[values_offset+1] = cos(phase)
                        values_offset = (values_offset+1) % length(values)
                        phase += 0.10*values_offset
                        refresh_time += 1.0/60.0
                    end
                end
                CImGui.PlotLines("Lines", values, length(values), values_offset, "avg 0.0", -1.0, 1.0, (0,80))
                CImGui.PlotHistogram("Histogram", arr, length(arr), 0, C_NULL, 0.0, 1.0, (0,80))
            end
        end # @cstatic
        # use functions to generate output
        # FIXME: This is rather awkward because current plot API only pass in indices. We probably want an API passing floats and user provide sample rate/count.
        Sin(::Ptr{Cvoid}, i::Cint) = Cfloat(sin(i * 0.1))
        Saw(::Ptr{Cvoid}, i::Cint) = Cfloat((i & 1) != 0 ? 1.0 : -1.0)
        Sin_ptr = @cfunction($Sin, Cfloat, (Ptr{Cvoid}, Cint))
        Saw_ptr = @cfunction($Saw, Cfloat, (Ptr{Cvoid}, Cint))

        @cstatic func_type=Cint(0) display_count=Cint(70) begin
            CImGui.Separator()
            CImGui.PushItemWidth(100)
            @c CImGui.Combo("func", &func_type, "Sin\0Saw\0")
            CImGui.PopItemWidth()
            CImGui.SameLine()
            @c CImGui.SliderInt("Sample count", &display_count, 1, 400)
            func = func_type == 0 ? Sin_ptr : Saw_ptr
            CImGui.PlotLines("Lines", func, C_NULL, display_count, 0, C_NULL, -1.0, 1.0, (0,80))
            CImGui.PlotHistogram("Histogram", func, C_NULL, display_count, 0, C_NULL, -1.0, 1.0, (0,80))
            CImGui.Separator()
        end

        # animate a simple progress bar
        @cstatic progress=Cfloat(0) progress_dir=Cfloat(1) begin
            if animate
                progress += progress_dir * 0.4 * CImGui.GetIO().DeltaTime
                progress ≥ 1.1 && (progress = 1.1; progress_dir *= -1.0;)
                progress ≤ -0.1 && (progress = -0.1; progress_dir *= -1.0;)
            end

            # typically we would use ImVec2(-1.0,0.0) to use all available width, or ImVec2(width,0.0) for a specified width. ImVec2(0.0,0.0) uses ItemWidth.
            CImGui.ProgressBar(progress, ImVec2(0.0,0.0))
            CImGui.SameLine(0.0, CImGui.GetStyle().ItemInnerSpacing.x)
            CImGui.Text("Progress Bar")

            progress_saturated = (progress < 0.0) ? 0.0 : (progress > 1.0) ? 1.0 : progress
            buf = @sprintf("%d/%d", progress_saturated*1753, 1753)
            CImGui.ProgressBar(progress, ImVec2(0,0), buf)
        end
        CImGui.TreePop()
    end

    if CImGui.TreeNode("Color/Picker Widgets")
        @cstatic color=Cfloat[114/255, 144/255, 154/255, 200/255] backup_color=Cfloat[0,0,0,0] saved_palette_init=true saved_palette=fill(ImVec4(0,0,0,0), 32) alpha_preview=true alpha_half_preview=false drag_and_drop=true options_menu=true hdr=false begin
            @c CImGui.Checkbox("With Alpha Preview", &alpha_preview)
            @c CImGui.Checkbox("With Half Alpha Preview", &alpha_half_preview)
            @c CImGui.Checkbox("With Drag and Drop", &drag_and_drop)
            @c CImGui.Checkbox("With Options Menu", &options_menu)
            CImGui.SameLine()
            ShowHelpMarker("Right-click on the individual color widget to show options.")
            @c CImGui.Checkbox("With HDR", &hdr)
            CImGui.SameLine()
            ShowHelpMarker("Currently all this does is to lift the 0..1 limits on dragging widgets.")
            misc_flags = (hdr ? CImGui.ImGuiColorEditFlags_HDR : 0) | (drag_and_drop ? 0 : CImGui.ImGuiColorEditFlags_NoDragDrop) | (alpha_half_preview ? CImGui.ImGuiColorEditFlags_AlphaPreviewHalf : (alpha_preview ? CImGui.ImGuiColorEditFlags_AlphaPreview : 0)) | (options_menu ? 0 : CImGui.ImGuiColorEditFlags_NoOptions)

            CImGui.Text("Color widget:")
            CImGui.SameLine()
            ShowHelpMarker("Click on the colored square to open a color picker.\nCTRL+click on individual component to input value.\n")
            CImGui.ColorEdit3("MyColor##1", color, misc_flags)

            CImGui.Text("Color widget HSV with Alpha:")
            CImGui.ColorEdit4("MyColor##2", color, CImGui.ImGuiColorEditFlags_HSV | misc_flags)

            CImGui.Text("Color widget with Float Display:")
            CImGui.ColorEdit4("MyColor##2f", color, CImGui.ImGuiColorEditFlags_Float | misc_flags)

            CImGui.Text("Color button with Picker:")
            CImGui.SameLine()
            ShowHelpMarker("With the ImGuiColorEditFlags_NoInputs flag you can hide all the slider/text inputs.\nWith the ImGuiColorEditFlags_NoLabel flag you can pass a non-empty label which will only be used for the tooltip and picker popup.")
            CImGui.ColorEdit4("MyColor##3", color, CImGui.ImGuiColorEditFlags_NoInputs | CImGui.ImGuiColorEditFlags_NoLabel | misc_flags)
            CImGui.Text("Color button with Custom Picker Popup:")

            # generate a dummy default palette. The palette will persist and can be edited.
            if saved_palette_init
                for n = 0:length(saved_palette)-1
                    tmp = saved_palette[n+1]
                    x, y, z = tmp.x, tmp.y, tmp.z
                    @c CImGui.ColorConvertHSVtoRGB(n/31, 0.8, 0.8, &x, &y, &z)
                    tmp = saved_palette[n+1]
                    saved_palette[n+1] = ImVec4(x, y, z, 1.0) # alpha
                end
                saved_palette_init = false
            end

            open_popup = CImGui.ColorButton("MyColor##3b", ImVec4(color...), misc_flags)
            CImGui.SameLine()
            open_popup |= CImGui.Button("Palette")
            if open_popup
                CImGui.OpenPopup("mypicker")
                backup_color = color
            end

            if CImGui.BeginPopup("mypicker")
                CImGui.Text("MY CUSTOM COLOR PICKER WITH AN AMAZING PALETTE!")
                CImGui.Separator()
                CImGui.ColorPicker4("##picker", color, misc_flags | CImGui.ImGuiColorEditFlags_NoSidePreview | CImGui.ImGuiColorEditFlags_NoSmallPreview)
                CImGui.SameLine()

                CImGui.BeginGroup() # Lock X position
                CImGui.Text("Current")
                CImGui.ColorButton("##current", ImVec4(color...), CImGui.ImGuiColorEditFlags_NoPicker | CImGui.ImGuiColorEditFlags_AlphaPreviewHalf, (60,40))
                CImGui.Text("Previous")
                CImGui.ColorButton("##previous", ImVec4(backup_color...), CImGui.ImGuiColorEditFlags_NoPicker | CImGui.ImGuiColorEditFlags_AlphaPreviewHalf, (60,40)) && (color = backup_color;)
                CImGui.Separator()
                CImGui.Text("Palette")
                for n = 0:length(saved_palette)-1
                    CImGui.PushID(n)
                    (n % 8) != 0 && CImGui.SameLine(0.0, CImGui.GetStyle().ItemSpacing.y)
                    if CImGui.ColorButton("##palette", saved_palette[n+1], CImGui.ImGuiColorEditFlags_NoAlpha | CImGui.ImGuiColorEditFlags_NoPicker | CImGui.ImGuiColorEditFlags_NoTooltip, (20,20))
                        tmp = saved_palette[n+1]
                        x, y, z = tmp.z, tmp.y, tmp.z
                        color = [x, y, z, color[4]] # preserve alpha!
                    end

                    # allow user to drop colors into each palette entry
                    # (Note that ColorButton is already a drag source by default, unless using ImGuiColorEditFlags_NoDragDrop)
                    if CImGui.BeginDragDropTarget()
                        payload = CImGui.AcceptDragDropPayload(CImGui.IMGUI_PAYLOAD_TYPE_COLOR_3F)
                        if payload != C_NULL
                            ptr = CImGui.Get(payload, :Data)
                            x = unsafe_load(Ptr{Cfloat}(ptr), 1)
                            y = unsafe_load(Ptr{Cfloat}(ptr), 2)
                            z = unsafe_load(Ptr{Cfloat}(ptr), 3)
                            w = saved_palette[n].w
                            saved_palette[n+1] = ImVec4(x,y,z,w)
                        end
                        payload = CImGui.AcceptDragDropPayload(CImGui.IMGUI_PAYLOAD_TYPE_COLOR_4F)
                        if payload != C_NULL
                            ptr = CImGui.Get(payload, :Data)
                            x = unsafe_load(Ptr{Cfloat}(ptr), 1)
                            y = unsafe_load(Ptr{Cfloat}(ptr), 2)
                            z = unsafe_load(Ptr{Cfloat}(ptr), 3)
                            w = unsafe_load(Ptr{Cfloat}(ptr), 4)
                            saved_palette[n+1] = ImVec4(x,y,z,w)
                        end
                        CImGui.EndDragDropTarget()
                    end
                    CImGui.PopID()
                end
                CImGui.EndGroup()
                CImGui.EndPopup()
            end

            CImGui.Text("Color button only:")
            CImGui.ColorButton("MyColor##3c", ImVec4(color...), misc_flags, (80,80))

            CImGui.Text("Color picker:")
            @cstatic alpha=true alpha_bar=true side_preview=true ref_color=true ref_color_v=Cfloat[1.0,0.0,1.0,0.5] inputs_mode=Cint(2) picker_mode=Cint(0) begin
                @c CImGui.Checkbox("With Alpha", &alpha)
                @c CImGui.Checkbox("With Alpha Bar", &alpha_bar)
                @c CImGui.Checkbox("With Side Preview", &side_preview)
                if side_preview
                    CImGui.SameLine()
                    @c CImGui.Checkbox("With Ref Color", &ref_color)
                    if ref_color
                        CImGui.SameLine()
                        CImGui.ColorEdit4("##RefColor", pointer(ref_color_v), CImGui.ImGuiColorEditFlags_NoInputs | misc_flags)
                    end
                end
                @c CImGui.Combo("Inputs Mode", &inputs_mode, "All Inputs\0No Inputs\0RGB Input\0HSV Input\0HEX Input\0");
                @c CImGui.Combo("Picker Mode", &picker_mode, "Auto/Current\0Hue bar + SV rect\0Hue wheel + SV triangle\0");
                CImGui.SameLine()
                ShowHelpMarker("User can right-click the picker to change mode.")
                flags = misc_flags
                !alpha && (flags |= CImGui.ImGuiColorEditFlags_NoAlpha;) # this is by default if you call ColorPicker3() instead of ColorPicker4()
                alpha_bar && (flags |= CImGui.ImGuiColorEditFlags_AlphaBar;)
                !side_preview && (flags |= CImGui.ImGuiColorEditFlags_NoSidePreview;)
                picker_mode == 1 && (flags |= CImGui.ImGuiColorEditFlags_PickerHueBar;)
                picker_mode == 2 && (flags |= CImGui.ImGuiColorEditFlags_PickerHueWheel;)
                inputs_mode == 1 && (flags |= CImGui.ImGuiColorEditFlags_NoInputs;)
                inputs_mode == 2 && (flags |= CImGui.ImGuiColorEditFlags_RGB;)
                inputs_mode == 3 && (flags |= CImGui.ImGuiColorEditFlags_HSV;)
                inputs_mode == 4 && (flags |= CImGui.ImGuiColorEditFlags_HEX;)
                CImGui.ColorPicker4("MyColor##4", color, flags, ref_color ? pointer(ref_color_v) : C_NULL)
            end
            CImGui.Text("Programmatically set defaults:")
            CImGui.SameLine()
            ShowHelpMarker("SetColorEditOptions() is designed to allow you to set boot-time default.\nWe don't have Push/Pop functions because you can force options on a per-widget basis if needed, and the user can change non-forced ones with the options menu.\nWe don't have a getter to avoid encouraging you to persistently save values that aren't forward-compatible.")
            if CImGui.Button("Default: Uint8 + HSV + Hue Bar")
                CImGui.SetColorEditOptions(CImGui.ImGuiColorEditFlags_Uint8 | CImGui.ImGuiColorEditFlags_HSV | CImGui.ImGuiColorEditFlags_PickerHueBar)
            end
            if CImGui.Button("Default: Float + HDR + Hue Wheel")
                CImGui.SetColorEditOptions(CImGui.ImGuiColorEditFlags_Float | CImGui.ImGuiColorEditFlags_HDR | CImGui.ImGuiColorEditFlags_PickerHueWheel)
            end
        end # @cstatic
        CImGui.TreePop()
    end

    if CImGui.TreeNode("Range Widgets")
        @cstatic _begin=Cfloat(10) _end=Cfloat(90) begin_i=Cint(100) end_i=Cint(1000) begin
            @c CImGui.DragFloatRange2("range", &_begin, &_end, 0.25, 0.0, 100.0, "Min: %.1f %%", "Max: %.1f %%")
            @c CImGui.DragIntRange2("range int (no bounds)", &begin_i, &end_i, 5, 0, 0, "Min: %d units", "Max: %d units")
        end
        CImGui.TreePop()
    end

    # FIXME
    # if CImGui.TreeNode("Data Types")
        # The DragScalar/InputScalar/SliderScalar functions allow various data types: signed/unsigned int/long long and float/double
        # To avoid polluting the public API with all possible combinations, we use the ImGuiDataType enum to pass the type,
        # and passing all arguments by address.
        # This is the reason the test code below creates local variables to hold "zero" "one" etc. for each types.
        # In practice, if you frequently use a given type that is not covered by the normal API entry points, you can wrap it
        # yourself inside a 1 line function which can take typed argument as value instead of void*, and then pass their address
        # to the generic function. For example:
        #   bool MySliderU64(const char *label, u64* value, u64 min = 0, u64 max = 0, const char* format = "%lld")
        #   {
        #      return SliderScalar(label, ImGuiDataType_U64, value, &min, &max, format);
        #   }

        # Limits (as helper variables that we can take the address of)
        # Note that the SliderScalar function has a maximum usable range of half the natural type maximum, hence the /2 below.
        # s32_zero = ImS32(0); s32_one = ImS32(1); s32_fifty = ImS32(50); s32_min = ImS32(typemin(Cint)/2);  s32_max = ImS32(1073741824);   s32_hi_a = ImS32(1073741724);   s32_hi_b = ImS32(1073741824)
        # u32_zero = ImU32(0); u32_one = ImU32(1); u32_fifty = ImU32(50); u32_min = ImU32(0);                u32_max = ImU32(0x7fffffff);  u32_hi_a = ImU32(0x7fffffff - 100);  u32_hi_b = ImU32(0x7fffffff)
        # s64_zero = ImS64(0); s64_one = ImS64(1); s64_fifty = ImS64(50); s64_min = ImS64(typemin(Int64)/2); s64_max = ImS64(typemax(Int64)/2);  s64_hi_a = ImS64(typemax(Int64)/2 - 100);  s64_hi_b = ImS64(typemax(Int64)/2)
        # u64_zero = ImU64(0); u64_one = ImU64(1); u64_fifty = ImU64(50); u64_min = ImU64(0);                u64_max = ImU64(typemax(UInt64)/2); u64_hi_a = ImU64(typemax(UInt64)/2 - 100); u64_hi_b = ImU64(typemax(UInt64)/2)
        # f32_zero = Cfloat(0); f32_one = Cfloat(1); f32_lo_a = Cfloat(-10000000000.0); f32_hi_a = Cfloat(10000000000.0);
        # f64_zero = Cdouble(0); f64_one = Cdouble(1); f64_lo_a = Cdouble(-1000000000000000.0); f64_hi_a = Cdouble(1000000000000000.0);

        # State
        # drag_speed = Cfloat(0.2)
        # @cstatic s32_v=ImS32(-1) u32_v=ImU32(0xffffffff) s64_v=ImS64(-1) u64_v=ImU64(0xffffffffffffffff) f32_v=Cfloat(0.123) f64_v=Cdouble(90000.01234567890123456789) drag_clamp=false begin
        #     CImGui.Text("Drags:")
        #     @c CImGui.Checkbox("Clamp integers to 0..50", &drag_clamp)
        #     CImGui.SameLine()
        #     ShowHelpMarker("As with every widgets in dear imgui, we never modify values unless there is a user interaction.\nYou can override the clamping limits by using CTRL+Click to input a value.")
        #     if drag_clamp
        #         @c CImGui.DragScalar("drag s32", CImGui.ImGuiDataType_S32, &s32_v, drag_speed, &s32_zero, &s32_fifty)
        #         @c CImGui.DragScalar("drag u32", CImGui.ImGuiDataType_U32, &u32_v, drag_speed, &u32_zero, &u32_fifty, "%u ms")
        #         @c CImGui.DragScalar("drag s64", CImGui.ImGuiDataType_S64, &s64_v, drag_speed, &s64_zero, &s64_fifty)
        #         @c CImGui.DragScalar("drag u64", CImGui.ImGuiDataType_U64, &u64_v, drag_speed, &u64_zero, &u64_fifty)
        #     else
        #         @c CImGui.DragScalar("drag s32", CImGui.ImGuiDataType_S32, &s32_v, drag_speed, C_NULL, C_NULL)
        #         @c CImGui.DragScalar("drag u32", CImGui.ImGuiDataType_U32, &u32_v, drag_speed, C_NULL, C_NULL, "%u ms")
        #         @c CImGui.DragScalar("drag s64", CImGui.ImGuiDataType_S64, &s64_v, drag_speed, C_NULL, C_NULL)
        #         @c CImGui.DragScalar("drag u64", CImGui.ImGuiDataType_U64, &u64_v, drag_speed, C_NULL, C_NULL)
        #     end
        #     @c CImGui.DragScalar("drag float", CImGui.ImGuiDataType_Float, &f32_v, 0.005, &f32_zero, &f32_one, "%f", 1.0)
        #     @c CImGui.DragScalar("drag float ^2", CImGui.ImGuiDataType_Float, &f32_v, 0.005, &f32_zero, &f32_one, "%f", 2.0)
        #     CImGui.SameLine()
        #     ShowHelpMarker("You can use the 'power' parameter to increase tweaking precision on one side of the range.")
        #     @c CImGui.DragScalar("drag double", CImGui.ImGuiDataType_Double, &f64_v, 0.0005, &f64_zero, C_NULL, "%.10f grams", 1.0)
        #     @c CImGui.DragScalar("drag double ^2", CImGui.ImGuiDataType_Double, &f64_v, 0.0005, &f64_zero, &f64_one, "0 < %.10f < 1", 2.0)
        #
        #     CImGui.Text("Sliders")
        #     @c CImGui.SliderScalar("slider s32 low",     CImGui.ImGuiDataType_S32,    &s32_v, &s32_zero, &s32_fifty,"%d")
        #     @c CImGui.SliderScalar("slider s32 high",    CImGui.ImGuiDataType_S32,    &s32_v, &s32_hi_a, &s32_hi_b, "%d")
        #     @c CImGui.SliderScalar("slider s32 full",    CImGui.ImGuiDataType_S32,    &s32_v, &s32_min,  &s32_max,  "%d")
        #     @c CImGui.SliderScalar("slider u32 low",     CImGui.ImGuiDataType_U32,    &u32_v, &u32_zero, &u32_fifty,"%u")
        #     @c CImGui.SliderScalar("slider u32 high",    CImGui.ImGuiDataType_U32,    &u32_v, &u32_hi_a, &u32_hi_b, "%u")
        #     @c CImGui.SliderScalar("slider u32 full",    CImGui.ImGuiDataType_U32,    &u32_v, &u32_min,  &u32_max,  "%u")
        #     @c CImGui.SliderScalar("slider s64 low",     CImGui.ImGuiDataType_S64,    &s64_v, &s64_zero, &s64_fifty,"%I64d")
        #     @c CImGui.SliderScalar("slider s64 high",    CImGui.ImGuiDataType_S64,    &s64_v, &s64_hi_a, &s64_hi_b, "%I64d")
        #     @c CImGui.SliderScalar("slider s64 full",    CImGui.ImGuiDataType_S64,    &s64_v, &s64_min,  &s64_max,  "%I64d")
        #     @c CImGui.SliderScalar("slider u64 low",     CImGui.ImGuiDataType_U64,    &u64_v, &u64_zero, &u64_fifty,"%I64u ms")
        #     @c CImGui.SliderScalar("slider u64 high",    CImGui.ImGuiDataType_U64,    &u64_v, &u64_hi_a, &u64_hi_b, "%I64u ms")
        #     @c CImGui.SliderScalar("slider u64 full",    CImGui.ImGuiDataType_U64,    &u64_v, &u64_min,  &u64_max,  "%I64u ms")
        #     @c CImGui.SliderScalar("slider float low",   CImGui.ImGuiDataType_Float,  &f32_v, &f32_zero, &f32_one)
        #     @c CImGui.SliderScalar("slider float low^2", CImGui.ImGuiDataType_Float,  &f32_v, &f32_zero, &f32_one,  "%.10f", 2.0)
        #     @c CImGui.SliderScalar("slider float high",  CImGui.ImGuiDataType_Float,  &f32_v, &f32_lo_a, &f32_hi_a, "%e")
        #     @c CImGui.SliderScalar("slider double low",  CImGui.ImGuiDataType_Double, &f64_v, &f64_zero, &f64_one,  "%.10f grams", 1.0)
        #     @c CImGui.SliderScalar("slider double low^2",CImGui.ImGuiDataType_Double, &f64_v, &f64_zero, &f64_one,  "%.10f", 2.0)
        #     @c CImGui.SliderScalar("slider double high", CImGui.ImGuiDataType_Double, &f64_v, &f64_lo_a, &f64_hi_a, "%e grams", 1.0)
        #
        #     @cstatic inputs_step=true begin
        #         CImGui.Text("Inputs")
        #         @c CImGui.Checkbox("Show step buttons", &inputs_step)
        #         if inputs_step
        #             @c CImGui.InputScalar("input s32",     CImGui.ImGuiDataType_S32,    &s32_v, &s32_one, C_NULL, "%d")
        #             @c CImGui.InputScalar("input s32 hex", CImGui.ImGuiDataType_S32,    &s32_v, &s32_one, C_NULL, C_NULL, "%08X", CImGui.ImGuiInputTextFlags_CharsHexadecimal)
        #             @c CImGui.InputScalar("input u32",     CImGui.ImGuiDataType_U32,    &u32_v, &u32_one, C_NULL, C_NULL, "%u")
        #             @c CImGui.InputScalar("input u32 hex", CImGui.ImGuiDataType_U32,    &u32_v, &u32_one, C_NULL, C_NULL, "%08X", CImGui.ImGuiInputTextFlags_CharsHexadecimal)
        #             @c CImGui.InputScalar("input s64",     CImGui.ImGuiDataType_S64,    &s64_v, &s64_one, C_NULL)
        #             @c CImGui.InputScalar("input u64",     CImGui.ImGuiDataType_U64,    &u64_v, &u64_one, C_NULL)
        #             @c CImGui.InputScalar("input float",   CImGui.ImGuiDataType_Float,  &f32_v, &f32_one, C_NULL)
        #             @c CImGui.InputScalar("input double",  CImGui.ImGuiDataType_Double, &f64_v, &f64_one, C_NULL)
        #         else
        #             @c CImGui.InputScalar("input s32",     CImGui.ImGuiDataType_S32,    &s32_v, &s32_one, C_NULL, C_NULL, "%d")
        #             @c CImGui.InputScalar("input s32 hex", CImGui.ImGuiDataType_S32,    &s32_v, &s32_one, C_NULL, C_NULL, "%08X", CImGui.ImGuiInputTextFlags_CharsHexadecimal)
        #             @c CImGui.InputScalar("input u32",     CImGui.ImGuiDataType_U32,    &u32_v, &u32_one, C_NULL, C_NULL, "%u")
        #             @c CImGui.InputScalar("input u32 hex", CImGui.ImGuiDataType_U32,    &u32_v, &u32_one, C_NULL, C_NULL, "%08X", CImGui.ImGuiInputTextFlags_CharsHexadecimal)
        #             @c CImGui.InputScalar("input s64",     CImGui.ImGuiDataType_S64,    &s64_v, &s64_one, C_NULL)
        #             @c CImGui.InputScalar("input u64",     CImGui.ImGuiDataType_U64,    &u64_v, &u64_one, C_NULL)
        #             @c CImGui.InputScalar("input float",   CImGui.ImGuiDataType_Float,  &f32_v, &f32_one, C_NULL)
        #             @c CImGui.InputScalar("input double",  CImGui.ImGuiDataType_Double, &f64_v, &f64_one, C_NULL)
        #         end
        #     end
        # end # @cstatic
        # CImGui.TreePop()
    # end

    if CImGui.TreeNode("Multi-component Widgets")
        @cstatic vec4f=Cfloat[0.10, 0.20, 0.30, 0.44] vec4i=Cint[1, 5, 100, 255] begin
            CImGui.InputFloat2("input float2", vec4f)
            CImGui.DragFloat2("drag float2", vec4f, 0.01, 0.0, 1.0)
            CImGui.SliderFloat2("slider float2", vec4f, 0.0, 1.0)
            CImGui.InputInt2("input int2", vec4i)
            CImGui.DragInt2("drag int2", vec4i, 1, 0, 255)
            CImGui.SliderInt2("slider int2", vec4i, 0, 255)
            CImGui.Spacing()

            CImGui.InputFloat3("input float3", vec4f)
            CImGui.DragFloat3("drag float3", vec4f, 0.01, 0.0, 1.0)
            CImGui.SliderFloat3("slider float3", vec4f, 0.0, 1.0)
            CImGui.InputInt3("input int3", vec4i)
            CImGui.DragInt3("drag int3", vec4i, 1, 0, 255)
            CImGui.SliderInt3("slider int3", vec4i, 0, 255)
            CImGui.Spacing()

            CImGui.InputFloat4("input float4", vec4f)
            CImGui.DragFloat4("drag float4", vec4f, 0.01, 0.0, 1.0)
            CImGui.SliderFloat4("slider float4", vec4f, 0.0, 1.0)
            CImGui.InputInt4("input int4", vec4i)
            CImGui.DragInt4("drag int4", vec4i, 1, 0, 255)
            CImGui.SliderInt4("slider int4", vec4i, 0, 255)
        end
        CImGui.TreePop()
    end

    if CImGui.TreeNode("Vertical Sliders")
        spacing = 4
        CImGui.PushStyleVar(CImGui.ImGuiStyleVar_ItemSpacing, ImVec2(spacing, spacing))

        @cstatic int_value=Cint(0) begin
            @c CImGui.VSliderInt("##int", ImVec2(18,160), &int_value, 0, 5)
            CImGui.SameLine()
        end

        @cstatic values=Cfloat[0.0, 0.60, 0.35, 0.9, 0.70, 0.20, 0.0] values2=Cfloat[0.20, 0.80, 0.40, 0.25] begin
            CImGui.PushID("set1")
            for i = 0:7-1
                i > 0 && CImGui.SameLine()
                CImGui.PushID(i)
                CImGui.PushStyleColor(CImGui.ImGuiCol_FrameBg, CImGui.HSV(i/7.0, 0.5, 0.5))
                CImGui.PushStyleColor(CImGui.ImGuiCol_FrameBgHovered, CImGui.HSV(i/7.0, 0.6, 0.5))
                CImGui.PushStyleColor(CImGui.ImGuiCol_FrameBgActive, CImGui.HSV(i/7.0, 0.7, 0.5))
                CImGui.PushStyleColor(CImGui.ImGuiCol_SliderGrab, CImGui.HSV(i/7.0, 0.9, 0.9))
                CImGui.VSliderFloat("##v", (18,160), pointer(values)+i*sizeof(Cfloat), 0.0, 1.0, "")
                if CImGui.IsItemActive() || CImGui.IsItemHovered()
                    CImGui.SetTooltip(@sprintf("%.3f", values[i+1]))
                end
                CImGui.PopStyleColor(4)
                CImGui.PopID()
            end
            CImGui.PopID()

            CImGui.SameLine()
            CImGui.PushID("set2")

            rows = Cint(3)
            small_slider_size = ImVec2(18, (160.0-(rows-1)*spacing)/rows)
            for nx = 0:4-1
                nx > 0 && CImGui.SameLine()
                CImGui.BeginGroup()
                for ny = 0:rows-1
                    CImGui.PushID(nx*rows+ny)
                    CImGui.VSliderFloat("##v", small_slider_size, pointer(values2)+nx*sizeof(Cfloat), 0.0, 1.0, "")
                    if CImGui.IsItemActive() || CImGui.IsItemHovered()
                        CImGui.SetTooltip(@sprintf("%.3f", values2[nx+1]))
                    end
                    CImGui.PopID()
                end
                CImGui.EndGroup()
            end
            CImGui.PopID()

            CImGui.SameLine()
            CImGui.PushID("set3")
            for i = 0:4-1
                i > 0 && CImGui.SameLine()
                CImGui.PushID(i)
                CImGui.PushStyleVar(CImGui.ImGuiStyleVar_GrabMinSize, 40)
                CImGui.VSliderFloat("##v", ImVec2(40,160), pointer(values)+i*sizeof(Cfloat), 0.0, 1.0, "%.2f\nsec")
                CImGui.PopStyleVar()
                CImGui.PopID()
            end
            CImGui.PopID()
            CImGui.PopStyleVar()
        end # @cstatic
        CImGui.TreePop()
    end

    if CImGui.TreeNode("Drag and Drop")
        # ColorEdit widgets automatically act as drag source and drag target.
        # They are using standardized payload strings IMGUI_PAYLOAD_TYPE_COLOR_3F and IMGUI_PAYLOAD_TYPE_COLOR_4F to allow your own widgets
        # to use colors in their drag and drop interaction. Also see the demo in Color Picker -> Palette demo.
        CImGui.BulletText("Drag and drop in standard widgets")
        CImGui.Indent()
        @cstatic col1=Cfloat[1.0,0.0,0.2] col2=Cfloat[0.4,0.7,0.0,0.5] begin
            CImGui.ColorEdit3("color 1", col1)
            CImGui.ColorEdit4("color 2", col2)
            CImGui.Unindent()
        end

        @cstatic mode=Cint(0) names=["Bobby", "Beatrice", "Betty", "Brianna", "Barry", "Bernard", "Bibi", "Blaine", "Bryn"] begin
            CImGui.BulletText("Drag and drop to copy/swap items")
            CImGui.Indent()
            Mode_Copy, Mode_Move, Mode_Swap = 0, 1, 2
            CImGui.RadioButton("Copy", mode == Mode_Copy) && (mode = Mode_Copy;)
            CImGui.SameLine()
            CImGui.RadioButton("Move", mode == Mode_Move) && (mode = Mode_Move;)
            CImGui.SameLine()
            CImGui.RadioButton("Swap", mode == Mode_Swap) && (mode = Mode_Swap;)
            for n = 0:length(names)-1
                CImGui.PushID(n)
                (n % 3) != 0 && CImGui.SameLine()
                CImGui.Button(names[n+1], (60,60))

                # our buttons are both drag sources and drag targets here!
                if CImGui.BeginDragDropSource(CImGui.ImGuiDragDropFlags_None)
                    @c CImGui.SetDragDropPayload("DND_DEMO_CELL", &n, sizeof(Cint)) # set payload to carry the index of our item (could be anything)
                    mode == Mode_Copy && CImGui.Text("Copy $(names[n+1])") # display preview (could be anything, e.g. when dragging an image we could decide to display the filename and a small preview of the image, etc.)
                    mode == Mode_Move && CImGui.Text("Move $(names[n+1])")
                    mode == Mode_Swap && CImGui.Text("Swap $(names[n+1])")
                    CImGui.EndDragDropSource()
                end
                if CImGui.BeginDragDropTarget()
                    payload = CImGui.AcceptDragDropPayload("DND_DEMO_CELL")
                    if payload != C_NULL
                        @assert CImGui.Get(payload, :DataSize) == sizeof(Cint)
                        payload_n = unsafe_load(Ptr{Cint}(CImGui.Get(payload, :Data)))
                        if mode == Mode_Copy
                            names[n+1] = names[payload_n+1]
                        end
                        if mode == Mode_Move
                            names[n+1] = names[payload_n+1]
                            names[payload_n+1] = ""
                        end
                        if mode == Mode_Swap
                            tmp = names[n+1]
                            names[n+1] = names[payload_n+1]
                            names[payload_n+1] = tmp
                        end
                    end
                    CImGui.EndDragDropTarget()
                end
                CImGui.PopID()
            end
            CImGui.Unindent()
        end # @cstatic
        CImGui.TreePop()
    end

    if CImGui.TreeNode("Querying Status (Active/Focused/Hovered etc.)")
        # Display the value of IsItemHovered() and other common item state functions. Note that the flags can be combined.
        # (because BulletText is an item itself and that would affect the output of IsItemHovered() we pass all state in a single call to simplify the code).
        @cstatic item_type=Cint(1) b=false col4f=Cfloat[1.0, 0.5, 0.0, 1.0] begin
            @c CImGui.RadioButton("Text", &item_type, 0)
            @c CImGui.RadioButton("Button", &item_type, 1)
            @c CImGui.RadioButton("Checkbox", &item_type, 2)
            @c CImGui.RadioButton("SliderFloat", &item_type, 3)
            @c CImGui.RadioButton("ColorEdit4", &item_type, 4)
            @c CImGui.RadioButton("ListBox", &item_type, 5)
            @c CImGui.Separator()
            ret = false;
            item_type == 0 && CImGui.Text("ITEM: Text") # testing text items with no identifier/interaction
            item_type == 1 && (ret = CImGui.Button("ITEM: Button");) # testing button
            item_type == 2 && (ret = @c CImGui.Checkbox("ITEM: Checkbox", &b);) # testing checkbox
            item_type == 3 && (ret = CImGui.SliderFloat("ITEM: SliderFloat", pointer(col4f), 0.0, 1.0);) # testing basic item
            item_type == 4 && (ret = CImGui.ColorEdit4("ITEM: ColorEdit4", col4f);) # testing multi-component items (IsItemXXX flags are reported merged)
            @cstatic current=Cint(1) begin
                if item_type == 5
                    items = ["Apple", "Banana", "Cherry", "Kiwi"]
                    ret = @c CImGui.ListBox("ITEM: ListBox", &current, items, length(items), length(items))
                end
            end
            CImGui.BulletText(
                "Return value = $ret\n"*
                "IsItemFocused() = $(CImGui.IsItemFocused())\n"*
                "IsItemHovered() = $(CImGui.IsItemHovered())\n"*
                "IsItemHovered(_AllowWhenBlockedByPopup) = $(CImGui.IsItemHovered(CImGui.ImGuiHoveredFlags_AllowWhenBlockedByPopup))\n"*
                "IsItemHovered(_AllowWhenBlockedByActiveItem) = $(CImGui.IsItemHovered(CImGui.ImGuiHoveredFlags_AllowWhenBlockedByActiveItem))\n"*
                "IsItemHovered(_AllowWhenOverlapped) = $(CImGui.IsItemHovered(CImGui.ImGuiHoveredFlags_AllowWhenOverlapped))\n"*
                "IsItemHovered(_RectOnly) = $(CImGui.IsItemHovered(CImGui.ImGuiHoveredFlags_RectOnly))\n"*
                "IsItemActive() = $(CImGui.IsItemActive())\n"*
                "IsItemEdited() = $(CImGui.IsItemEdited())\n"*
                "IsItemActivated() = $(CImGui.IsItemActivated())\n"*
                "IsItemDeactivated() = $(CImGui.IsItemDeactivated())\n"*
                "IsItemDeactivatedEdit() = $(CImGui.IsItemDeactivatedAfterEdit())\n"*
                "IsItemVisible() = $(CImGui.IsItemVisible())\n"*
                "GetItemRectMin() = ($(CImGui.GetItemRectMin().x), $(CImGui.GetItemRectMin().y))\n"*
                "GetItemRectMax() = ($(CImGui.GetItemRectMax().x), $(CImGui.GetItemRectMax().y))\n"*
                "GetItemRectSize() = ($(CImGui.GetItemRectSize().x), $(CImGui.GetItemRectSize().y))")
        end

        @cstatic embed_all_inside_a_child_window=false begin
            @c CImGui.Checkbox("Embed everything inside a child window (for additional testing)", &embed_all_inside_a_child_window)
            embed_all_inside_a_child_window && CImGui.BeginChild("outer_child", ImVec2(0, CImGui.GetFontSize() * 20), true)

            # testing IsWindowFocused() function with its various flags. Note that the flags can be combined.
            CImGui.BulletText(
                "IsWindowFocused() = $(CImGui.IsWindowFocused())\n"*
                "IsWindowFocused(_ChildWindows) = $(CImGui.IsWindowFocused(CImGui.ImGuiFocusedFlags_ChildWindows))\n"*
                "IsWindowFocused(_ChildWindows|_RootWindow) = $(CImGui.IsWindowFocused(CImGui.ImGuiFocusedFlags_ChildWindows | CImGui.ImGuiFocusedFlags_RootWindow))\n"*
                "IsWindowFocused(_RootWindow) = $(CImGui.IsWindowFocused(CImGui.ImGuiFocusedFlags_RootWindow))\n"*
                "IsWindowFocused(_AnyWindow) = $(CImGui.IsWindowFocused(CImGui.ImGuiFocusedFlags_AnyWindow))\n")

            # testing IsWindowHovered() function with its various flags. Note that the flags can be combined.
            CImGui.BulletText(
                "IsWindowHovered() = $(CImGui.IsWindowHovered())\n"*
                "IsWindowHovered(_AllowWhenBlockedByPopup) = $(CImGui.IsWindowHovered(CImGui.ImGuiHoveredFlags_AllowWhenBlockedByPopup))\n"*
                "IsWindowHovered(_AllowWhenBlockedByActiveItem) = $(CImGui.IsWindowHovered(CImGui.ImGuiHoveredFlags_AllowWhenBlockedByActiveItem))\n"*
                "IsWindowHovered(_ChildWindows) = $(CImGui.IsWindowHovered(CImGui.ImGuiHoveredFlags_ChildWindows))\n"*
                "IsWindowHovered(_ChildWindows|_RootWindow) = $(CImGui.IsWindowHovered(CImGui.ImGuiHoveredFlags_ChildWindows | CImGui.ImGuiHoveredFlags_RootWindow))\n"*
                "IsWindowHovered(_RootWindow) = $(CImGui.IsWindowHovered(CImGui.ImGuiHoveredFlags_RootWindow))\n"*
                "IsWindowHovered(_AnyWindow) = $(CImGui.IsWindowHovered(CImGui.ImGuiHoveredFlags_AnyWindow))\n")

            CImGui.BeginChild("child", (0, 50), true)
            CImGui.Text("This is another child window for testing the _ChildWindows flag.")
            CImGui.EndChild()
            embed_all_inside_a_child_window && CImGui.EndChild()
        end

        # calling IsItemHovered() after begin returns the hovered status of the title bar.
        # this is useful in particular if you want to create a context menu (with BeginPopupContextItem) associated to the title bar of a window.
        @cstatic test_window=false begin
            @c CImGui.Checkbox("Hovered/Active tests after Begin() for title bar testing", &test_window)
            if test_window
                @c CImGui.Begin("Title bar Hovered/Active tests", &test_window)
                if CImGui.BeginPopupContextItem() # <-- this is using IsItemHovered()
                    CImGui.MenuItem("Close") && (test_window = false;)
                    CImGui.EndPopup()
                end
                CImGui.Text("IsItemHovered() after begin = $(CImGui.IsItemHovered()) (== is title bar hovered)\n"*
                            "IsItemActive() after begin = $(CImGui.IsItemActive()) (== is window being clicked/moved)\n")
                CImGui.End()
            end
        end
        CImGui.TreePop()
    end
end
