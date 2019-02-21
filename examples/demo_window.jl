using CImGui
using CSyntax

include(joinpath(@__DIR__, "app_main_menu_bar.jl"))
include(joinpath(@__DIR__, "app_simple_layout.jl"))
include(joinpath(@__DIR__, "app_property_editor.jl"))
include(joinpath(@__DIR__, "app_long_text.jl"))
include(joinpath(@__DIR__, "app_auto_resize.jl"))
include(joinpath(@__DIR__, "app_constrained_resize.jl"))
include(joinpath(@__DIR__, "simple_overlay.jl"))
include(joinpath(@__DIR__, "window_titles.jl"))
include(joinpath(@__DIR__, "custom_rendering.jl"))

let
# example apps
show_main_menubar = false
show_layout = false
show_property_editor = false
show_long_text = false
show_auto_resize = false
show_constrained_resize = false
show_simple_overlay = false
show_window_titles = false
show_custom_rendering = false
# Dear ImGui apps
show_app_metrics = false
show_app_style_editor = false
show_app_about = false
# window flags
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
global function demo(p_open::Ref{Bool})
    # examples
    show_main_menubar && @c show_app_main_menubar(&show_main_menubar)
    show_layout && @c show_app_layout(&show_layout)
    show_property_editor && @c show_app_property_editor(&show_property_editor)
    show_long_text && @c show_app_long_text(&show_long_text)
    show_auto_resize && @c show_app_auto_resize(&show_auto_resize)
    show_constrained_resize && @c show_app_constrained_resize(&show_constrained_resize)
    show_simple_overlay && @c show_app_simple_overlay(&show_simple_overlay)
    show_window_titles && @c show_app_window_titles(&show_window_titles)
    show_custom_rendering && @c show_app_custom_rendering(&show_custom_rendering)

    # Dear ImGui apps
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
    !no_menu          && (window_flags |= CImGui.CImGui.ImGuiWindowFlags_MenuBar;)
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
            show_menu_file()
            CImGui.EndMenu()
        end
        if CImGui.BeginMenu("Examples")
            @c CImGui.MenuItem("Main menu bar", C_NULL, &show_main_menubar)
            # @c CImGui.MenuItem("Console", C_NULL, &show_app_console)
            # @c CImGui.MenuItem("Log", C_NULL, &show_app_
            @c CImGui.MenuItem("Simple layout", C_NULL, &show_layout)
            @c CImGui.MenuItem("Property editor", C_NULL, &show_property_editor)
            @c CImGui.MenuItem("Long text display", C_NULL, &show_long_text)
            @c CImGui.MenuItem("Auto-resizing window", C_NULL, &show_auto_resize)
            @c CImGui.MenuItem("Constrained-resizing window", C_NULL, &show_constrained_resize)
            @c CImGui.MenuItem("Simple overlay", C_NULL, &show_simple_overlay)
            @c CImGui.MenuItem("Manipulating window titles", C_NULL, &show_window_titles)
            @c CImGui.MenuItem("Custom rendering", C_NULL, &show_custom_rendering)
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
    # ShowDemoWindowWidgets()
    # ShowDemoWindowLayout()
    # ShowDemoWindowPopups()
    # ShowDemoWindowColumns()
    # ShowDemoWindowMisc()

    CImGui.End() # demo
end

end # let
