# helper convertion functions
Base.convert(::Type{ImVec2}, x::NTuple{2}) = ImVec2(x...)
Base.convert(::Type{ImVec4}, x::NTuple{4}) = ImVec4(x...)
Base.convert(::Type{ImVec4}, x::ImU32) = ColorConvertU32ToFloat4(x)
Base.convert(::Type{ImU32}, x::ImVec4) = ColorConvertFloat4ToU32(x)

# put this in CEnum.jl?
using CSyntax.CEnum: Cenum, enum_names, enum_values

Base.:|(a::T, b::Integer) where {T<:Cenum{UInt32}} = UInt32(a) | UInt32(b)
Base.:|(a::Integer, b::T) where {T<:Cenum{UInt32}} = UInt32(b) | UInt32(a)

Base.:&(a::T, b::Integer) where {T<:Cenum{UInt32}} = UInt32(a) & UInt32(b)
Base.:&(a::Integer, b::T) where {T<:Cenum{UInt32}} = UInt32(b) & UInt32(a)

Base.:(:)(a::T, b::Cenum) where {T<:Integer} = a:T(b)
Base.:(:)(a::Cenum, b::T) where {T<:Integer} = T(a):b

ShowFlags(::Type{T}) where {T<:Cenum} = foreach(x->println(x), zip(enum_names(T), enum_values(T)))
GetFlags(::Type{T}) where {T<:Cenum} = zip(enum_names(T), enum_values(T)) |> collect

# simple unsafe destruction helper
function UnsafeGetPtr(x::Ptr{T}, name::Symbol) where {T}
    offset = x
    type = T
    flag = false
    for i = 1:fieldcount(T)
        name == fieldname(T, i) || continue
        flag = true
        type = fieldtype(T, i)
        offset += fieldoffset(T, i)
        break
    end
    flag || throw(ArgumentError("$T has no field named $name."))
    return Ptr{type}(offset)
end

function Get(x::Ptr{T}, name::Symbol) where {T}
    GC.@preserve x begin
        value = unsafe_load(UnsafeGetPtr(x, name))
    end
    return value
end

function Set(x::Ptr{T}, name::Symbol, value::S) where {T,S}
    GC.@preserve x value begin
        unsafe_store!(UnsafeGetPtr(x, name), value)
    end
    return value
end

# emulate ImGui::GetIO().xxx
function Base.getproperty(io::Ptr{ImGuiIO}, x::Symbol)
    x == :ConfigFlags && return ImGuiIO_Get_ConfigFlags(io)
    x == :BackendFlags && return ImGuiIO_Get_BackendFlags(io)
    x == :DisplaySize && return ImGuiIO_Get_DisplaySize(io)
    x == :DeltaTime && return ImGuiIO_Get_DeltaTime(io)
    x == :IniSavingRate && return ImGuiIO_Get_IniSavingRate(io)
    x == :IniFilename && return ImGuiIO_Get_IniFilename(io)
    x == :LogFilename && return ImGuiIO_Get_LogFilename(io)
    x == :MouseDoubleClickTime && return ImGuiIO_MouseDoubleClickTime(io)
    x == :MouseDoubleClickMaxDist && return ImGuiIO_Get_MouseDoubleClickMaxDist(io)
    x == :MouseDragThreshold && return ImGuiIO_MouseDragThreshold(io)
    x == :KeyRepeatDelay && return ImGuiIO_Get_KeyRepeatDelay(io)
    x == :KeyRepeatRate && return ImGuiIO_Get_KeyRepeatRate(io)
    x == :UserData && return ImGuiIO_Get_UserData(io)
    x == :Fonts && return ImGuiIO_Get_Fonts(io)
    x == :FontGlobalScale && return ImGuiIO_Get_FontGlobalScale(io)
    x == :FontAllowUserScaling && return ImGuiIO_Get_FontAllowUserScaling(io)
    x == :FontDefault && return ImGuiIO_Get_FontDefault(io)
    x == :DisplayFramebufferScale && return ImGuiIO_Get_DisplayFramebufferScale(io)
    x == :MouseDrawCursor && return ImGuiIO_Get_MouseDrawCursor(io)
    x == :ConfigMacOSXBehaviors && return ImGuiIO_Get_ConfigMacOSXBehaviors(io)
    x == :ConfigInputTextCursorBlink && return ImGuiIO_Get_ConfigInputTextCursorBlink(io)
    x == :ConfigWindowsResizeFromEdges && return ImGuiIO_Get_ConfigWindowsResizeFromEdges(io)
    x == :ConfigWindowsMoveFromTitleBarOnly && return ImGuiIO_Get_ConfigWindowsMoveFromTitleBarOnly(io)
    x == :BackendPlatformName && return ImGuiIO_Get_BackendPlatformName(io)
    x == :BackendRendererName && return ImGuiIO_Get_BackendRendererName(io)
    x == :ImeWindowHandle && return ImGuiIO_Get_ImeWindowHandle(io)
    x == :MousePos && return ImGuiIO_Get_MousePos(io)
    x == :MouseWheel && return ImGuiIO_Get_MouseWheel(io)
    x == :MouseWheelH && return ImGuiIO_Get_MouseWheelH(io)
    x == :KeyCtrl && return ImGuiIO_Get_KeyCtrl(io)
    x == :KeyShift && return ImGuiIO_Get_KeyShift(io)
    x == :KeyAlt && return ImGuiIO_Get_KeyAlt(io)
    x == :KeySuper && return ImGuiIO_Get_KeySuper(io)
    x == :WantCaptureMouse && return ImGuiIO_Get_WantCaptureMouse(io)
    x == :WantCaptureKeyboard && return ImGuiIO_Get_WantCaptureKeyboard(io)
    x == :WantTextInput && return ImGuiIO_Get_WantTextInput(io)
    x == :WantSetMousePos && return ImGuiIO_Get_WantSetMousePos(io)
    x == :WantSaveIniSettings && return ImGuiIO_Get_WantSaveIniSettings(io)
    x == :NavActive && return ImGuiIO_Get_NavActive(io)
    x == :NavVisible && return ImGuiIO_Get_NavVisible(io)
    x == :Framerate && return ImGuiIO_Get_Framerate(io)
    x == :MetricsRenderVertices && return ImGuiIO_Get_MetricsRenderVertices(io)
    x == :MetricsRenderIndices && return ImGuiIO_Get_MetricsRenderIndices(io)
    x == :MetricsRenderWindows && return ImGuiIO_Get_MetricsRenderWindows(io)
    x == :MetricsActiveWindows && return ImGuiIO_Get_MetricsActiveWindows(io)
    x == :MetricsActiveAllocations && return ImGuiIO_Get_MetricsActiveAllocations(io)
    x == :MouseDelta && return ImGuiIO_Get_MouseDelta(io)
    x == :MousePosPrev && return ImGuiIO_Get_MousePosPrev(io)
    throw(ArgumentError("field $x is not supported to be used like this, please use `Get_$x` instead."))
end

function Base.setproperty!(io::Ptr{ImGuiIO}, x::Symbol, v)
    x == :ConfigFlags && return ImGuiIO_Set_ConfigFlags(io, v)
    x == :BackendFlags && return ImGuiIO_Set_BackendFlags(io, v)
    x == :DisplaySize && return ImGuiIO_Set_DisplaySize(io, v)
    x == :DeltaTime && return ImGuiIO_Set_DeltaTime(io, v)
    x == :IniSavingRate && return ImGuiIO_Set_IniSavingRate(io, v)
    x == :IniFilename && return ImGuiIO_Set_IniFilename(io, v)
    x == :LogFilename && return ImGuiIO_Set_LogFilename(io, v)
    x == :MouseDoubleClickTime && return ImGuiIO_MouseDoubleClickTime(io, v)
    x == :MouseDoubleClickMaxDist && return ImGuiIO_Set_MouseDoubleClickMaxDist(io, v)
    x == :MouseDragThreshold && return ImGuiIO_MouseDragThreshold(io, v)
    x == :KeyRepeatDelay && return ImGuiIO_Set_KeyRepeatDelay(io, v)
    x == :KeyRepeatRate && return ImGuiIO_Set_KeyRepeatRate(io, v)
    x == :UserData && return ImGuiIO_Set_UserData(io, v)
    x == :Fonts && return ImGuiIO_Set_Fonts(io, v)
    x == :FontGlobalScale && return ImGuiIO_Set_FontGlobalScale(io, v)
    x == :FontAllowUserScaling && return ImGuiIO_Set_FontAllowUserScaling(io, v)
    x == :FontDefault && return ImGuiIO_Set_FontDefault(io, v)
    x == :DisplayFramebufferScale && return ImGuiIO_Set_DisplayFramebufferScale(io, v)
    x == :MouseDrawCursor && return ImGuiIO_Set_MouseDrawCursor(io, v)
    x == :ConfigMacOSXBehaviors && return ImGuiIO_Set_ConfigMacOSXBehaviors(io, v)
    x == :ConfigInputTextCursorBlink && return ImGuiIO_Set_ConfigInputTextCursorBlink(io, v)
    x == :ConfigWindowsResizeFromEdges && return ImGuiIO_Set_ConfigWindowsResizeFromEdges(io, v)
    x == :ConfigWindowsMoveFromTitleBarOnly && return ImGuiIO_Set_ConfigWindowsMoveFromTitleBarOnly(io, v)
    x == :BackendPlatformName && return ImGuiIO_Set_BackendPlatformName(io, v)
    x == :BackendRendererName && return ImGuiIO_Set_BackendRendererName(io, v)
    x == :GetClipboardTextFn && return ImGuiIO_Set_GetClipboardTextFn(io, v)
    x == :SetClipboardTextFn && return ImGuiIO_Set_SetClipboardTextFn(io, v)
    x == :ClipboardUserData && return ImGuiIO_Set_ClipboardUserData(io, v)
    x == :ImeWindowHandle && return ImGuiIO_Set_ImeWindowHandle(io, v)
    x == :MousePos && return ImGuiIO_Set_MousePos(io, v)
    x == :MouseWheel && return ImGuiIO_Set_MouseWheel(io, v)
    x == :MouseWheelH && return ImGuiIO_Set_MouseWheelH(io, v)
    x == :KeyCtrl && return ImGuiIO_Set_KeyCtrl(io, v)
    x == :KeyShift && return ImGuiIO_Set_KeyShift(io, v)
    x == :KeyAlt && return ImGuiIO_Set_KeyAlt(io, v)
    x == :KeySuper && return ImGuiIO_Set_KeySuper(io, v)
    throw(ArgumentError("field $x is not supported to be used like this!"))
end

# emulate draw_data.xxx
function Base.getproperty(data::Ptr{ImDrawData}, x::Symbol)
    x == :Valid && return ImDrawData_Get_Valid(data)
    x == :CmdListsCount && return ImDrawData_Get_CmdListsCount(data)
    x == :TotalIdxCount && return ImDrawData_Get_TotalIdxCount(data)
    x == :TotalVtxCount && return ImDrawData_Get_TotalVtxCount(data)
    x == :DisplayPos && return ImDrawData_Get_DisplayPos(data)
    x == :DisplaySize && return ImDrawData_Get_DisplaySize(data)
    x == :FramebufferScale && return ImDrawData_Get_FramebufferScale(data)
end

# emulate cmd.xxx
function Base.getproperty(cmd::Ptr{ImDrawCmd}, x::Symbol)
    x == :ElemCount && return ImDrawCmd_Get_ElemCount(cmd)
    x == :ClipRect && return ImDrawCmd_Get_ClipRect(cmd)
    x == :TextureId && return ImDrawCmd_Get_TextureId(cmd)
    x == :UserCallback && return ImDrawCmd_Get_UserCallback(cmd)
    x == :UserCallbackData && return ImDrawCmd_Get_UserCallbackData(cmd)
end
