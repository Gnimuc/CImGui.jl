# this example demonstrates creating a fullscreen menu bar and populating it.
using CSyntax

function show_app_main_menubar()
    if CImGui.BeginMainMenuBar()
        if CImGui.BeginMenu("File")
            show_menu_file()
            CImGui.EndMenu()
        end
        if CImGui.BeginMenu("Edit")
            if CImGui.MenuItem("Undo", "CTRL+Z")
                @info "Undo"
            end
            if CImGui.MenuItem("Redo", "CTRL+Y", false, false)  # disabled
                @info "Redo"
            end
            CImGui.Separator()
            if CImGui.MenuItem("Cut", "CTRL+X")
                @info "Cut"
            end
            if CImGui.MenuItem("Copy", "CTRL+C")
                @info "Copy"
            end
            if CImGui.MenuItem("Paste", "CTRL+V")
                @info "Paste"
            end
            CImGui.EndMenu()
        end
        CImGui.EndMainMenuBar()
    end
end

let
enabled = true
f = Cfloat(0.5)
n = Cint(0)
b = true
global function show_menu_file()
    CImGui.MenuItem("(dummy menu)", C_NULL, false, false)
    if CImGui.MenuItem("New")
        @info "New"
    end
    if CImGui.MenuItem("Open", "Ctrl+O")
        @info "Open"
    end
    if CImGui.BeginMenu("Open Recent")
        CImGui.MenuItem("fish_hat.c")
        CImGui.MenuItem("fish_hat.inl")
        CImGui.MenuItem("fish_hat.h")
        if CImGui.BeginMenu("More..")
            CImGui.MenuItem("Hello")
            CImGui.MenuItem("Sailor")
            if CImGui.BeginMenu("Recurse..")
                show_menu_file()
                CImGui.EndMenu()
            end
            CImGui.EndMenu()
        end
        CImGui.EndMenu()
    end
    if CImGui.MenuItem("Save", "Ctrl+S")
        @info "Save"
    end
    if CImGui.MenuItem("Save As..")
        @info "Save As.."
    end
    CImGui.Separator()
    if CImGui.BeginMenu("Options")
        @c CImGui.MenuItem("Enabled", "", &enabled)
        CImGui.BeginChild("child", ImVec2(0, 60), true)
        foreach(i->CImGui.Text("Scrolling Text $i"), 0:9)
        CImGui.EndChild()
        @c CImGui.SliderFloat("Value", &f, 0.0, 1.0)
        @c CImGui.InputFloat("Input", &f, 0.1)
        # @c CImGui.Combo("Combo", &n, "Yes\0No\0Maybe\0\0")
        @c CImGui.Checkbox("Check", &b)
        CImGui.EndMenu()
    end
    if CImGui.BeginMenu("Colors")
        sz = CImGui.GetTextLineHeight()
        for i = 0:Int(ImGuiCol_COUNT-1)
            @show i
            name = CImGui.GetStyleColorName(ImGuiCol(i))
            p = CImGui.GetCursorScreenPos()
            # CImGui.GetWindowDrawList()->AddRectFilled(p, ImVec2(p.x+sz, p.y+sz), CImGui.GetColorU32((ImGuiCol)i));
            CImGui.Dummy(sz, sz)
            CImGui.SameLine()
            CImGui.MenuItem(name)
        end
        CImGui.EndMenu()
    end
    if CImGui.BeginMenu("Disabled", false)  # disabled
        throw(AssertionError("unreachable reached."))
    end
    CImGui.MenuItem("Checked", "", true) && @info "Checked"
    CImGui.MenuItem("Quit", "Alt+F4") && @info "Quit"
end

end # let
