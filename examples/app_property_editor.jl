using CImGui
using CImGui.CSyntax.CStatic

function ShowDummyObject(prefix, uid)
    CImGui.PushID(uid) # use object uid as identifier. most commonly you could also use the object pointer as a base ID.
    CImGui.AlignTextToFramePadding()  # Text and Tree nodes are less high than regular widgets, here we add vertical spacing to make the tree lines equal high.
    node_open = CImGui.TreeNode("Object", "$(prefix)_$(uid)")
    CImGui.NextColumn()
    CImGui.AlignTextToFramePadding()
    CImGui.Text("my sailor is rich")
    CImGui.NextColumn()
    if node_open
        @cstatic dummy_members=Cfloat[0.0, 0.0, 1.0, 3.1416, 100.0, 999.0, 0.0, 0.0] begin
            for i = 0:8-1
                CImGui.PushID(i) # use field index as identifier
                if i < 2
                    ShowDummyObject("Child", 424242)
                else
                    # here we use a TreeNode to highlight on hover (we could use e.g. Selectable as well)
                    CImGui.AlignTextToFramePadding()
                    flag = CImGui.ImGuiTreeNodeFlags_Leaf | CImGui.ImGuiTreeNodeFlags_NoTreePushOnOpen | CImGui.ImGuiTreeNodeFlags_Bullet
                    CImGui.TreeNodeEx("Field", flag, "Field_$i")
                    CImGui.NextColumn()
                    CImGui.PushItemWidth(-1)
                    if i >= 5
                        CImGui.InputFloat("##value", pointer(dummy_members) + i * sizeof(Cfloat), 1.0)
                    else
                        CImGui.DragFloat("##value", pointer(dummy_members) + i * sizeof(Cfloat), 0.01)
                    end
                    CImGui.PopItemWidth()
                    CImGui.NextColumn()
                end
                CImGui.PopID()
            end
            CImGui.TreePop()
        end
    end
    CImGui.PopID()
end

"""
    ShowExampleAppPropertyEditor(p_open::Ref{Bool})
Create a simple property editor.
"""
function ShowExampleAppPropertyEditor(p_open::Ref{Bool})
    CImGui.SetNextWindowSize((430,450), CImGui.ImGuiCond_FirstUseEver)
    CImGui.Begin("Example: Property editor", p_open) || (CImGui.End(); return)

    # ShowHelpMarker("This example shows how you may implement a property editor using two columns.\nAll objects/fields data are dummies here.\nRemember that in many simple cases, you can use CImGui.SameLine(xxx) to position\nyour cursor horizontally instead of using the Columns() API.");

    CImGui.PushStyleVar(CImGui.ImGuiStyleVar_FramePadding, (2,2))
    CImGui.Columns(2)
    CImGui.Separator()

    # iterate dummy objects with dummy members (all the same data)
    foreach(obj_i->ShowDummyObject("Object", obj_i), 0:2)

    CImGui.Columns(1)
    CImGui.Separator()
    CImGui.PopStyleVar()
    CImGui.End()
end
