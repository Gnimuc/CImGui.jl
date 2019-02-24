using CImGui
using CImGui.CSyntax
using CImGui.CSyntax.CStatic

include(joinpath(@__DIR__, "app_main_menu_bar.jl"))
include(joinpath(@__DIR__, "app_simple_layout.jl"))
include(joinpath(@__DIR__, "app_property_editor.jl"))
include(joinpath(@__DIR__, "app_long_text.jl"))
include(joinpath(@__DIR__, "app_auto_resize.jl"))
include(joinpath(@__DIR__, "app_constrained_resize.jl"))
include(joinpath(@__DIR__, "app_simple_overlay.jl"))
include(joinpath(@__DIR__, "app_window_titles.jl"))
include(joinpath(@__DIR__, "app_custom_rendering.jl"))
include(joinpath(@__DIR__, "demo_helper.jl"))
include(joinpath(@__DIR__, "demo_widgets.jl"))
include(joinpath(@__DIR__, "demo_layout.jl"))
include(joinpath(@__DIR__, "demo_popups.jl"))
include(joinpath(@__DIR__, "demo_columns.jl"))
include(joinpath(@__DIR__, "demo_misc.jl"))

let
# examples Apps (accessible from the "Examples" menu)
show_app_documents=false
show_app_main_menu_bar=false
show_app_console=false
show_app_log=false
show_app_layout=false
show_app_property_editor=false
show_app_long_text=false
show_app_auto_resize=false
show_app_constrained_resize=false
show_app_simple_overlay=false
show_app_window_titles=false
show_app_custom_rendering=false
# Dear ImGui apps (accessible from the "Help" menu)
show_app_metrics = false
show_app_style_editor = false
show_app_about = false
# demonstrate the various window flags. typically you would just use the default!
no_titlebar = false
no_scrollbar = false
no_menu = false
no_move = false
no_resize = false
no_collapse = false
no_close = false
no_nav = false
no_background = false
no_bring_to_front = false
"""
    ShowDemoWindow(p_open::Ref{Bool})
Demonstrate most Dear ImGui features.
You may execute this function to experiment with the UI and understand what it does.
You may then search for keywords in the code when you are interested by a specific feature.
"""
global function ShowDemoWindow(p_open::Ref{Bool})
    # examples Apps (accessible from the "Examples" menu)
    # show_app_documents           && @c ShowExampleAppDocuments(&show_app_documents) # process the Document app next, as it may also use a DockSpace()
    show_app_main_menu_bar       && @c ShowExampleAppMainMenuBar(&show_app_main_menu_bar)
    # show_app_console             && @c ShowExampleAppConsole(&show_app_console)
    # show_app_log                 && @c ShowExampleAppLog(&show_app_log)
    show_app_layout              && @c ShowExampleAppLayout(&show_app_layout)
    show_app_property_editor     && @c ShowExampleAppPropertyEditor(&show_app_property_editor)
    show_app_long_text           && @c ShowExampleAppLongText(&show_app_long_text)
    show_app_auto_resize         && @c ShowExampleAppAutoResize(&show_app_auto_resize)
    show_app_constrained_resize  && @c ShowExampleAppConstrainedResize(&show_app_constrained_resize)
    show_app_simple_overlay      && @c ShowExampleAppSimpleOverlay(&show_app_simple_overlay)
    show_app_window_titles       && @c ShowExampleAppWindowTitles(&show_app_window_titles)
    show_app_custom_rendering    && @c ShowExampleAppCustomRendering(&show_app_custom_rendering)

    # Dear ImGui apps (accessible from the "Help" menu)
    show_app_metrics && @c CImGui.ShowMetricsWindow(&show_app_metrics)
    if show_app_style_editor
        @c CImGui.Begin("Style Editor", &show_app_style_editor)
        CImGui.ShowStyleEditor()
        CImGui.End()
    end
    show_app_about && @c ShowAboutWindow(&show_app_about)

    # demonstrate the various window flags. typically you would just use the default!
    window_flags = CImGui.ImGuiWindowFlags(0)
    no_titlebar       && (window_flags |= CImGui.ImGuiWindowFlags_NoTitleBar;)
    no_scrollbar      && (window_flags |= CImGui.ImGuiWindowFlags_NoScrollbar;)
    !no_menu          && (window_flags |= CImGui.ImGuiWindowFlags_MenuBar;)
    no_move           && (window_flags |= CImGui.ImGuiWindowFlags_NoMove;)
    no_resize         && (window_flags |= CImGui.ImGuiWindowFlags_NoResize;)
    no_collapse       && (window_flags |= CImGui.ImGuiWindowFlags_NoCollapse;)
    no_nav            && (window_flags |= CImGui.ImGuiWindowFlags_NoNav;)
    no_background     && (window_flags |= CImGui.ImGuiWindowFlags_NoBackground;)
    no_bring_to_front && (window_flags |= CImGui.ImGuiWindowFlags_NoBringToFrontOnFocus;)
    no_close && (p_open = C_NULL;) # don't pass our bool* to Begin

    # specify a default position/size in case there's no data in the .ini file.
    # typically this isn't required! we only do it to make the Demo applications a little more welcoming.
    CImGui.SetNextWindowPos((650, 20), CImGui.ImGuiCond_FirstUseEver)
    CImGui.SetNextWindowSize((550, 680), CImGui.ImGuiCond_FirstUseEver)

    # main body of the Demo window starts here.
    CImGui.Begin("ImGui Demo", p_open, window_flags) || (CImGui.End(); return)
    CImGui.Text("dear imgui says hello. $(CImGui.IMGUI_VERSION)")

    # most "big" widgets share a common width settings by default.
    # CImGui.PushItemWidth(CImGui.GetWindowWidth() * 0.65)    # use 2/3 of the space for widgets and 1/3 for labels (default)
    CImGui.PushItemWidth(CImGui.GetFontSize() * -12)        # use fixed width for labels (by passing a negative value), the rest goes to widgets. We choose a width proportional to our font size.

    # menu
    if CImGui.BeginMenuBar()
        if CImGui.BeginMenu("Menu")
            ShowExampleMenuFile()
            CImGui.EndMenu()
        end
        if CImGui.BeginMenu("Examples")
            @c CImGui.MenuItem("Main menu bar", C_NULL, &show_app_main_menu_bar)
            # @c CImGui.MenuItem("Console", C_NULL, &show_app_console)
            # @c CImGui.MenuItem("Log", C_NULL, &show_app_
            @c CImGui.MenuItem("Simple layout", C_NULL, &show_app_layout)
            @c CImGui.MenuItem("Property editor", C_NULL, &show_app_property_editor)
            @c CImGui.MenuItem("Long text display", C_NULL, &show_app_long_text)
            @c CImGui.MenuItem("Auto-resizing window", C_NULL, &show_app_auto_resize)
            @c CImGui.MenuItem("Constrained-resizing window", C_NULL, &show_app_constrained_resize)
            @c CImGui.MenuItem("Simple overlay", C_NULL, &show_app_simple_overlay)
            @c CImGui.MenuItem("Manipulating window titles", C_NULL, &show_app_window_titles)
            @c CImGui.MenuItem("Custom rendering", C_NULL, &show_app_custom_rendering)
            CImGui.EndMenu()
        end
        if CImGui.BeginMenu("Help")
            @c CImGui.MenuItem("Metrics", C_NULL, &show_app_metrics)
            @c CImGui.MenuItem("Style Editor", C_NULL, &show_app_style_editor)
            @c CImGui.MenuItem("About Dear ImGui", C_NULL, &show_app_about)
            CImGui.EndMenu()
        end
        CImGui.EndMenuBar()
    end

    CImGui.Spacing()
    if CImGui.CollapsingHeader("Help")
        CImGui.Text("PROGRAMMER GUIDE:")
        CImGui.BulletText("Please see the ShowDemoWindow() code in imgui_demo.cpp. <- you are here!")
        CImGui.BulletText("Please see the comments in imgui.cpp.")
        CImGui.BulletText("Please see the examples/ in application.")
        CImGui.BulletText("Enable 'io.ConfigFlags |= NavEnableKeyboard' for keyboard controls.")
        CImGui.BulletText("Enable 'io.ConfigFlags |= NavEnableGamepad' for gamepad controls.")
        CImGui.Separator()
        CImGui.Text("USER GUIDE:")
        CImGui.ShowUserGuide()
    end

    if CImGui.CollapsingHeader("Configuration")
        io = CImGui.GetIO()
        if CImGui.TreeNode("Configuration##2")
            @c CImGui.CheckboxFlags("io.ConfigFlags: NavEnableKeyboard", &io.ConfigFlags, CImGui.ImGuiConfigFlags_NavEnableKeyboard)
            @c CImGui.CheckboxFlags("io.ConfigFlags: NavEnableGamepad", &io.ConfigFlags, CImGui.ImGuiConfigFlags_NavEnableGamepad)
            CImGui.SameLine()
            ShowHelpMarker("Required back-end to feed in gamepad inputs in io.NavInputs[] and set io.BackendFlags |= ImGuiBackendFlags_HasGamepad.\n\nRead instructions in imgui.cpp for details.");
            @c CImGui.CheckboxFlags("io.ConfigFlags: NavEnableSetMousePos", &io.ConfigFlags, CImGui.ImGuiConfigFlags_NavEnableSetMousePos)
            CImGui.SameLine()
            ShowHelpMarker("Instruct navigation to move the mouse cursor. See comment for ImGuiConfigFlags_NavEnableSetMousePos.")
            @c CImGui.CheckboxFlags("io.ConfigFlags: NoMouse", &io.ConfigFlags, CImGui.ImGuiConfigFlags_NoMouse)
            if io.ConfigFlags & CImGui.ImGuiConfigFlags_NoMouse != 0 # create a way to restore this flag otherwise we could be stuck completely!
                if mod(CImGui.GetTime(), 0.4) < 0.2
                    CImGui.SameLine()
                    CImGui.Text("<<PRESS SPACE TO DISABLE>>")
                end
                if CImGui.IsKeyPressed(CImGui.GetKeyIndex(CImGui.ImGuiKey_Space))
                    io.ConfigFlags &= ~Cuint(CImGui.ImGuiConfigFlags_NoMouse)
                end
            end
            @c CImGui.CheckboxFlags("io.ConfigFlags: NoMouseCursorChange", &io.ConfigFlags, CImGui.ImGuiConfigFlags_NoMouseCursorChange)
            CImGui.SameLine()
            ShowHelpMarker("Instruct back-end to not alter mouse cursor shape and visibility.")
            @c CImGui.Checkbox("io.ConfigInputTextCursorBlink", &io.ConfigInputTextCursorBlink)
            CImGui.SameLine()
            ShowHelpMarker("Set to false to disable blinking cursor, for users who consider it distracting")
            @c CImGui.Checkbox("io.ConfigWindowsResizeFromEdges", &io.ConfigWindowsResizeFromEdges)
            CImGui.SameLine()
            ShowHelpMarker("Enable resizing of windows from their edges and from the lower-left corner.\nThis requires (io.BackendFlags & ImGuiBackendFlags_HasMouseCursors) because it needs mouse cursor feedback.")
            @c CImGui.Checkbox("io.ConfigWindowsMoveFromTitleBarOnly", &io.ConfigWindowsMoveFromTitleBarOnly)
            @c CImGui.Checkbox("io.MouseDrawCursor", &io.MouseDrawCursor)
            CImGui.SameLine()
            ShowHelpMarker("Instruct Dear ImGui to render a mouse cursor for you. Note that a mouse cursor rendered via your application GPU rendering path will feel more laggy than hardware cursor, but will be more in sync with your other visuals.\n\nSome desktop applications may use both kinds of cursors (e.g. enable software cursor only when resizing/dragging something).")
            CImGui.TreePop()
            CImGui.Separator()
        end

        if CImGui.TreeNode("Backend Flags")
            ShowHelpMarker("Those flags are set by the back-ends (imgui_impl_xxx files) to specify their capabilities.")
            backend_flags = io.BackendFlags # make a local copy to avoid modifying the back-end flags.
            @c CImGui.CheckboxFlags("io.BackendFlags: HasGamepad", &backend_flags, CImGui.ImGuiBackendFlags_HasGamepad)
            @c CImGui.CheckboxFlags("io.BackendFlags: HasMouseCursors", &backend_flags, CImGui.ImGuiBackendFlags_HasMouseCursors)
            @c CImGui.CheckboxFlags("io.BackendFlags: HasSetMousePos", &backend_flags, CImGui.ImGuiBackendFlags_HasSetMousePos)
            CImGui.TreePop()
            CImGui.Separator()
        end

        if CImGui.TreeNode("Style")
            CImGui.ShowStyleEditor()
            CImGui.TreePop()
            CImGui.Separator()
        end

        if CImGui.TreeNode("Capture/Logging")
            CImGui.TextWrapped("The logging API redirects all text output so you can easily capture the content of a window or a block. Tree nodes can be automatically expanded.");
            ShowHelpMarker("Try opening any of the contents below in this window and then click one of the \"Log To\" button.");
            CImGui.LogButtons()
            CImGui.TextWrapped("You can also call CImGui.LogText() to output directly to the log without a visual output.");
            if (CImGui.Button("Copy \"Hello, world!\" to clipboard"))
                CImGui.LogToClipboard()
                CImGui.LogText("Hello, world!")
                CImGui.LogFinish()
            end
            CImGui.TreePop()
        end
    end

    if CImGui.CollapsingHeader("Window options")
        @c CImGui.Checkbox("No titlebar", &no_titlebar)
        CImGui.SameLine(150)
        @c CImGui.Checkbox("No scrollbar", &no_scrollbar)
        CImGui.SameLine(300)
        @c CImGui.Checkbox("No menu", &no_menu)
        @c CImGui.Checkbox("No move", &no_move)
        CImGui.SameLine(150)
        @c CImGui.Checkbox("No resize", &no_resize)
        CImGui.SameLine(300)
        @c CImGui.Checkbox("No collapse", &no_collapse)
        @c CImGui.Checkbox("No close", &no_close)
        CImGui.SameLine(150)
        @c CImGui.Checkbox("No nav", &no_nav)
        CImGui.SameLine(300)
        @c CImGui.Checkbox("No background", &no_background)
        @c CImGui.Checkbox("No bring to front", &no_bring_to_front)
    end

    # all demo contents
    ShowDemoWindowWidgets()
    ShowDemoWindowLayout()
    ShowDemoWindowPopups()
    ShowDemoWindowColumns()
    ShowDemoWindowMisc()

    CImGui.End() # demo
end

end # let
