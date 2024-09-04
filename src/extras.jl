"""
    HelpMarker(msg::AbstractString)

A port of the `HelpMarker()` function from the Dear ImGui demo. This will draw a
grayed out '(?)' text on the screen with `msg` as the tooltip.
"""
function HelpMarker(msg::AbstractString)
    TextDisabled("(?)")

    if IsItemHovered() && BeginTooltip()
        PushTextWrapPos(GetFontSize() * 35.0)
        TextUnformatted(msg)
        PopTextWrapPos()
        EndTooltip()
    end
end

"""
$(TYPEDSIGNATURES)

Convenience wrapper for [`Dummy()`](@ref).
"""
Dummy(width, height) = Dummy((width, height))

# Aliases for the sake of backwards compatibility
const TextBuffer = lib.ImGuiTextBuffer
const Clipper = lib.ImGuiListClipper

## Manual wrappers

"""
    PlotLines(label, values, values_count::Integer, values_offset=0, overlay_text=C_NULL, scale_min=FLT_MAX, scale_max=FLT_MAX, graph_size=(0,0), stride=sizeof(Cfloat))
"""
function PlotLines(label,
                   values, values_count, values_offset=0,
                   overlay_text=C_NULL,
                   scale_min=FLT_MAX, scale_max=FLT_MAX,
                   graph_size=ImVec2(0,0),
                   stride=sizeof(Cfloat))
    igPlotLines_FloatPtr(label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride)
end

"""
    PlotLines(label, values_getter::Ptr, data::Ptr, values_count, values_offset=0, overlay_text=C_NULL, scale_min=FLT_MAX, scale_max=FLT_MAX, graph_size=(0,0))
"""
function PlotLines(label,
                   values_getter, data::Ptr, values_count, values_offset=0,
                   overlay_text=C_NULL,
                   scale_min=FLT_MAX, scale_max=FLT_MAX,
                   graph_size=ImVec2(0,0))
    igPlotLines_FnFloatPtr(label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size)
end

"""
    PlotHistogram(label, values, values_count, values_offset=0, overlay_text=C_NULL, scale_min=FLT_MAX, scale_max=FLT_MAX, graph_size=(0,0), stride=sizeof(Cfloat))
"""
function PlotHistogram(label,
                       values, values_count, values_offset=0,
                       overlay_text=C_NULL,
                       scale_min=FLT_MAX, scale_max=FLT_MAX,
                       graph_size=ImVec2(0,0), stride=sizeof(Cfloat))
    igPlotHistogram_FloatPtr(label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride)
end

"""
    PlotHistogram(label, values_getter::Ptr, data::Ptr, values_count, values_offset=0, overlay_text=C_NULL, scale_min=FLT_MAX, scale_max=FLT_MAX, graph_size=ImVec2(0,0))
"""
function PlotHistogram(label,
                       values_getter, data::Ptr, values_count, values_offset=0,
                       overlay_text=C_NULL,
                       scale_min=FLT_MAX, scale_max=FLT_MAX,
                       graph_size=ImVec2(0,0))
    igPlotHistogram_FnFloatPtr(label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size)
end
