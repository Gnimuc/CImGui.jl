using CImGui
using CImGui.CSyntax
using CImGui.CSyntax.CStatic

"""
    ShowDemoWindowPopups()
The properties of popups windows are:
- they block normal mouse hovering detection outside them. (*)
- unless modal, they can be closed by clicking anywhere outside them, or by pressing ESCAPE.
- their visibility state (~bool) is held internally by imgui instead of being held by the
    programmer as we are used to with regular Begin() calls.
User can manipulate the visibility state by calling OpenPopup().

(*) One can use IsItemHovered(ImGuiHoveredFlags_AllowWhenBlockedByPopup) to bypass it and detect hovering even when normally blocked by a popup.
Those three properties are connected. The library needs to hold their visibility state because it can close popups at any time.

Typical use for regular windows:
  bool my_tool_is_active = false; if (CImGui.Button("Open")) my_tool_is_active = true; [...] if (my_tool_is_active) Begin("My Tool", &my_tool_is_active) { [...] } End();
Typical use for popups:
  if (CImGui.Button("Open")) CImGui.OpenPopup("MyPopup"); if (CImGui.BeginPopup("MyPopup") { [...] EndPopup(); }

With popups we have to go through a library call (here OpenPopup) to manipulate the visibility state.
This may be a bit confusing at first but it should quickly make sense. Follow on the examples below.
"""
function ShowDemoWindowPopups()
    CImGui.CollapsingHeader("Popups & Modal windows") || return

    if CImGui.TreeNode("Popups")
        CImGui.TextWrapped("When a popup is active, it inhibits interacting with windows that are behind the popup. Clicking outside the popup closes it.")

        @cstatic selected_fish=Cint(-1) names=["Bream", "Haddock", "Mackerel", "Pollock", "Tilefish"] toggles=[true, false, false, false, false] begin
            # simple selection popup
            # (If you want to show the current selection inside the Button itself, you may want to build a string using the "###" operator to preserve a constant ID with a variable label)
            CImGui.Button("Select..") && CImGui.OpenPopup("my_select_popup")
            CImGui.SameLine()
            CImGui.TextUnformatted(selected_fish == -1 ? "<None>" : names[selected_fish])
            if CImGui.BeginPopup("my_select_popup")
                CImGui.Text("Aquarium")
                CImGui.Separator()
                for i = 1:length(names)
                    CImGui.Selectable(names[i]) && (selected_fish = i;)
                end
                CImGui.EndPopup()
            end

            # showing a menu with toggles
            CImGui.Button("Toggle..") && CImGui.OpenPopup("my_toggle_popup")
            if CImGui.BeginPopup("my_toggle_popup")
                for i = 1:length(names)
                    CImGui.MenuItem(names[i], "", pointer(toggles)+(i-1)*sizeof(Bool))
                end
                if CImGui.BeginMenu("Sub-menu")
                    CImGui.MenuItem("Click me") && @info "Trigger `Click me` | find me here: $(@__FILE__) at line $(@__LINE__)"
                    CImGui.EndMenu()
                end

                CImGui.Separator()
                CImGui.Text("Tooltip here")
                CImGui.IsItemHovered() && CImGui.SetTooltip("I am a tooltip over a popup")

                CImGui.Button("Stacked Popup") && CImGui.OpenPopup("another popup")
                if CImGui.BeginPopup("another popup")
                    for i = 1:length(names)
                        CImGui.MenuItem(names[i], "", pointer(toggles)+(i-1)*sizeof(Bool))
                    end
                    if CImGui.BeginMenu("Sub-menu")
                        CImGui.MenuItem("Click me") && @info "Trigger `Click me` | find me here: $(@__FILE__) at line $(@__LINE__)"
                        CImGui.EndMenu()
                    end
                    CImGui.EndPopup()
                end
                CImGui.EndPopup()
            end
        end # @cstatic
        # call the more complete ShowExampleMenuFile which we use in various places of this demo
        CImGui.Button("File Menu..") && CImGui.OpenPopup("my_file_popup")
        if CImGui.BeginPopup("my_file_popup")
            ShowExampleMenuFile()
            CImGui.EndPopup()
        end

        CImGui.TreePop()
    end

    if CImGui.TreeNode("Context menus")
        # BeginPopupContextItem() is a helper to provide common/simple popup behavior of essentially doing:
        #    if (IsItemHovered() && IsMouseReleased(0))
        #       OpenPopup(id);
        #    return BeginPopup(id);
        # For more advanced uses you may want to replicate and cuztomize this code. This the comments inside BeginPopupContextItem() implementation.
        @cstatic value = Cfloat(0.5) begin
            CImGui.Text(@sprintf("Value = %.3f (<-- right-click here)", value))
            if CImGui.BeginPopupContextItem("item context menu")
                CImGui.Selectable("Set to zero") && (value = 0.0;)
                CImGui.Selectable("Set to PI") && (value = 3.1415;)
                CImGui.PushItemWidth(-1)
                @c CImGui.DragFloat("##Value", &value, 0.1, 0.0, 0.0)
                CImGui.PopItemWidth()
                CImGui.EndPopup()
            end
        end

        # We can also use OpenPopupOnItemClick() which is the same as BeginPopupContextItem() but without the Begin call.
        # So here we will make it that clicking on the text field with the right mouse button (1) will toggle the visibility of the popup above.
        CImGui.Text("(You can also right-click me to the same popup as above.)")
        CImGui.OpenPopupOnItemClick("item context menu", 1)

        # When used after an item that has an ID (here the Button), we can skip providing an ID to BeginPopupContextItem().
        # BeginPopupContextItem() will use the last item ID as the popup ID.
        # In addition here, we want to include your editable label inside the button label. We use the ### operator to override the ID (read FAQ about ID for details)
        @cstatic name="Label1"*"\0"^26 begin
            buf = @sprintf("Button: %s###Button", strip(name, '\0')) # `###` operator override ID ignoring the preceding label
            CImGui.Button(buf)
            if CImGui.BeginPopupContextItem()
                CImGui.Text("Edit name:")
                CImGui.InputText("##edit", name, length(name))
                CImGui.Button("Close") && CImGui.CloseCurrentPopup()
                CImGui.EndPopup()
            end
        end
        CImGui.SameLine()
        CImGui.Text("(<-- right-click here)")

        CImGui.TreePop()
    end

    if CImGui.TreeNode("Modals")
        CImGui.TextWrapped("Modal windows are like popups but the user cannot close them by clicking outside the window.")

        CImGui.Button("Delete..") && CImGui.OpenPopup("Delete?")

        if CImGui.BeginPopupModal("Delete?", C_NULL, CImGui.ImGuiWindowFlags_AlwaysAutoResize)
            CImGui.Text("All those beautiful files will be deleted.\nThis operation cannot be undone!\n\n")
            CImGui.Separator()

            # @cstatic dummy_i=Cint(0) @c CImGui.Combo("Combo", &dummy_i, "Delete\0Delete harder\0")

            @cstatic dont_ask_me_next_time=false begin
                CImGui.PushStyleVar(CImGui.ImGuiStyleVar_FramePadding, (0, 0))
                @c CImGui.Checkbox("Don't ask me next time", &dont_ask_me_next_time)
                CImGui.PopStyleVar()
            end

            CImGui.Button("OK", (120, 0)) && CImGui.CloseCurrentPopup()
            CImGui.SetItemDefaultFocus()
            CImGui.SameLine()
            CImGui.Button("Cancel",(120, 0)) && CImGui.CloseCurrentPopup()
            CImGui.EndPopup()
        end

        CImGui.Button("Stacked modals..") && CImGui.OpenPopup("Stacked 1")
        if CImGui.BeginPopupModal("Stacked 1", C_NULL, CImGui.ImGuiWindowFlags_MenuBar)
            if CImGui.BeginMenuBar()
                if CImGui.BeginMenu("File")
                    CImGui.MenuItem("Dummy menu item") && @info "Trigger `Dummy menu item` | find me here: $(@__FILE__) at line $(@__LINE__)"
                    CImGui.EndMenu()
                end
                CImGui.EndMenuBar()
            end
            CImGui.Text("Hello from Stacked The First\nUsing style.Colors[ImGuiCol_ModalWindowDimBg] behind it.");

            # testing behavior of widgets stacking their own regular popups over the modal.
            @cstatic item=Cint(1) color=Cfloat[0.4,0.7,0.0,0.5] begin
                @c CImGui.Combo("Combo", &item, "aaaa\0bbbb\0cccc\0dddd\0eeee\0\0")
                CImGui.ColorEdit4("color", color)
            end
            CImGui.Button("Add another modal..") && CImGui.OpenPopup("Stacked 2")

            # Also demonstrate passing a bool* to BeginPopupModal(), this will create a regular close button which will close the popup.
            # Note that the visibility state of popups is owned by imgui, so the input value of the bool actually doesn't matter here.
            dummy_open = true
            if @c CImGui.BeginPopupModal("Stacked 2", &dummy_open)
                CImGui.Text("Hello from Stacked The Second!")
                CImGui.Button("Close") && CImGui.CloseCurrentPopup()
                CImGui.EndPopup()
            end

            CImGui.Button("Close") && CImGui.CloseCurrentPopup()
            CImGui.EndPopup()
        end

        CImGui.TreePop()
    end

    if CImGui.TreeNode("Menus inside a regular window")
        CImGui.TextWrapped("Below we are testing adding menu items to a regular window. It's rather unusual but should work!")
        CImGui.Separator()
        # NB: As a quirk in this very specific example, we want to differentiate the parent of this menu from the parent of the various popup menus above.
        # To do so we are encloding the items in a PushID()/PopID() block to make them two different menusets. If we don't, opening any popup above and hovering our menu here
        # would open it. This is because once a menu is active, we allow to switch to a sibling menu by just hovering on it, which is the desired behavior for regular menus.
        CImGui.PushID("foo")
        CImGui.MenuItem("Menu item", "CTRL+M")
        if CImGui.BeginMenu("Menu inside a regular window")
            ShowExampleMenuFile()
            CImGui.EndMenu()
        end
        CImGui.PopID()
        CImGui.Separator()
        CImGui.TreePop()
    end
end
