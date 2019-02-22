using CImGui
using Printf

"""
    ShowExampleAppWindowTitles(p_open::Ref{Bool})
Demonstrate using "##" and "###" in identifiers to manipulate ID generation.
This apply to all regular items as well. Read [FAQ](https://github.com/ocornut/imgui/blob/801645d35092c8da0eeabe71d7c1997c47aa3648/imgui.cpp#L521)
section "How can I have multiple widgets with the same label?
Can I have widget without a label? (Yes). A primer on the purpose of labels/IDs." for details.
"""
function ShowExampleAppWindowTitles(p_open::Ref{Bool})
    # by default, Windows are uniquely identified by their title.
    # you can use the "##" and "###" markers to manipulate the display/ID.

    # using "##" to display same title but have unique identifier.
    CImGui.SetNextWindowPos((100, 100), CImGui.ImGuiCond_FirstUseEver)
    CImGui.Begin("Same title as another window##1")
    CImGui.Text("This is window 1.\nMy title is the same as window 2, but my identifier is unique.")
    CImGui.End()

    CImGui.SetNextWindowPos((100, 200), CImGui.ImGuiCond_FirstUseEver)
    CImGui.Begin("Same title as another window##2")
    CImGui.Text("This is window 2.\nMy title is the same as window 1, but my identifier is unique.")
    CImGui.End()

    # using "###" to display a changing title but keep a static identifier "AnimatedTitle"
    idx = trunc(Int, CImGui.GetTime() / 0.25) & 3 + 1
    buf = @sprintf("Animated title %c %d###AnimatedTitle", "|/-\\"[idx], CImGui.GetFrameCount())
    CImGui.SetNextWindowPos(ImVec2(100, 300), CImGui.ImGuiCond_FirstUseEver)
    CImGui.Begin(buf)
    CImGui.Text("This window has a changing title.")
    CImGui.End()
end
