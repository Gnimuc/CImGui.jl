using CImGui
using CImGui.CSyntax
using CImGui.CSyntax.CStatic
using Printf

"""
    ShowExampleAppAutoResize(p_open::Ref{Bool})
Create a window which gets auto-resized according to its content.
"""
function ShowExampleAppAutoResize(p_open::Ref{Bool})
    CImGui.Begin("Example: Auto-resizing window", p_open, CImGui.ImGuiWindowFlags_AlwaysAutoResize) || (CImGui.End(); return)

    @cstatic lines=Cint(10) begin
        CImGui.Text("Window will resize every-frame to the size of its content.\nNote that you probably don't want to query the window size to\noutput your content because that would create a feedback loop.")
        @c CImGui.SliderInt("Number of lines", &lines, 1, 20)
        for i = 1:lines
            # pad with space to extend size horizontally
            CImGui.Text("$(" "^4i)This is line $i")
        end
        CImGui.End()
    end # @cstatic
end
