using CImGui
using CImGui.CSyntax
using CImGui.CSyntax.CSwitch
using CImGui.CSyntax.CStatic
using Printf

"""
    ShowExampleAppLongText(p_open::Ref{Bool})
Test rendering huge amount of text, and the incidence of clipping.
"""
function ShowExampleAppLongText(p_open::Ref{Bool})
    CImGui.SetNextWindowSize((520,600), CImGui.ImGuiCond_FirstUseEver)
    CImGui.Begin("Example: Long text display", p_open) || (CImGui.End(); return)

@cstatic test_type=Cint(0) lines=0 log=CImGui.TextBuffer() begin
    CImGui.Text("Printing unusually long amount of text.")
    @c CImGui.Combo("Test type", &test_type, "Single call to TextUnformatted()\0Multiple calls to Text(), clipped manually\0Multiple calls to Text(), not clipped (slow)\0")
    CImGui.Text("Buffer contents: $lines lines, $(CImGui.Size(log)) bytes")
    if CImGui.Button("Clear")
        @info "Trigger Clear | find me here: $(@__FILE__) at line $(@__LINE__)"
        CImGui.Clear(log)
        lines = 0
    end
    CImGui.SameLine()
    if CImGui.Button("Add 1000 lines")
        @info "Trigger Add 1000 lines | find me here: $(@__FILE__) at line $(@__LINE__)"
        foreach(i->CImGui.Append(log, "$(lines+i) The quick brown fox jumps over the lazy dog\n"), 1:1000)
        lines += 1000
    end
    CImGui.BeginChild("Log")
        @cswitch test_type begin
            @case 0
                # single call to TextUnformatted() with a big buffer
                CImGui.TextUnformatted(CImGui.Begin(log), CImGui.End(log))
                break
            @case 1
                # multiple calls to Text(), manually coarsely clipped - demonstrate how to use the ImGuiListClipper helper.
                CImGui.PushStyleVar(CImGui.ImGuiStyleVar_ItemSpacing, (0,0))
                clipper = CImGui.Clipper(lines)
                while CImGui.Step(clipper)
                    s = CImGui.Get(clipper, :DisplayStart)
                    e = CImGui.Get(clipper, :DisplayEnd)-1
                    foreach(i->CImGui.Text("$i The quick brown fox jumps over the lazy dog"), s:e)
                end
                CImGui.PopStyleVar()
                CImGui.Destroy(clipper)
                break
            @case 2
                # multiple calls to Text(), not clipped (slow)
                CImGui.PushStyleVar(CImGui.ImGuiStyleVar_ItemSpacing, (0,0))
                foreach(i->CImGui.Text("$i The quick brown fox jumps over the lazy dog"), 1:lines)
                CImGui.PopStyleVar()
                break
        end
        CImGui.EndChild()
    CImGui.End()
end # @cstatic

end
