# helper convertion functions
Base.convert(::Type{ImVec2}, x::NTuple{2}) = ImVec2(x...)
Base.convert(::Type{ImVec2}, x::Vector) = ImVec2(x...)
Base.convert(::Type{ImVec4}, x::NTuple{4}) = ImVec4(x...)
Base.convert(::Type{ImVec4}, x::Vector) = ImVec4(x...)
Base.convert(::Type{ImVec4}, x::ImU32) = ColorConvertU32ToFloat4(x)
Base.convert(::Type{ImU32}, x::ImVec4) = ColorConvertFloat4ToU32(x)

# TODO: put these in CEnum.jl
Base.:~(x::Cenum{UInt32}) = ~UInt32(x)
Base.:(:)(a::T, b::Cenum) where {T<:Integer} = a:T(b)
Base.:(:)(a::Cenum, b::T) where {T<:Integer} = T(a):b

function ShowFlags(::Type{T}) where {T<:Cenum}
    io = IOBuffer()
    s = "```\n"
    for (n,v) in name_value_pairs(T)
        s *= string(n)*" $v \n"
    end
    s*"\n```"
end
GetFlags(::Type{T}) where {T<:Cenum} = name_value_pairs(T) |> collect

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

# emulate ImGui::GetIO().xxx ImGuiBackendFlags
function Base.getproperty(io::Ptr{ImGuiIO}, x::Symbol)
    x === :ConfigFlags && return Ptr{ImGuiConfigFlags}(io + fieldoffset(ImGuiIO, 1))
    x === :BackendFlags && return Ptr{ImGuiBackendFlags}(io + fieldoffset(ImGuiIO, 2))
    x === :DisplaySize && return Ptr{ImVec2}(io + fieldoffset(ImGuiIO, 3))
    x === :DeltaTime && return Ptr{Cfloat}(io + fieldoffset(ImGuiIO, 4))
    x === :IniSavingRate && return Ptr{Cfloat}(io + fieldoffset(ImGuiIO, 5))
    x === :IniFilename && return Ptr{Ptr{Cchar}}(io + fieldoffset(ImGuiIO, 6))
    x === :LogFilename && return Ptr{Ptr{Cchar}}(io + fieldoffset(ImGuiIO, 7))
    x === :MouseDoubleClickTime && return Ptr{Cfloat}(io + fieldoffset(ImGuiIO, 8))
    x === :MouseDoubleClickMaxDist && return Ptr{Cfloat}(io + fieldoffset(ImGuiIO, 9))
    x === :MouseDragThreshold && return Ptr{Cfloat}(io + fieldoffset(ImGuiIO, 10))
    x === :KeyMap && return Ptr{NTuple{22, Cint}}(io + fieldoffset(ImGuiIO, 11))
    x === :KeyRepeatDelay && return Ptr{Cfloat}(io + fieldoffset(ImGuiIO, 12))
    x === :KeyRepeatRate && return Ptr{Cfloat}(io + fieldoffset(ImGuiIO, 13))
    x === :UserData && return Ptr{Ptr{Cvoid}}(io + fieldoffset(ImGuiIO, 14))
    x === :Fonts && return Ptr{Ptr{ImFontAtlas}}(io + fieldoffset(ImGuiIO, 15))
    x === :FontGlobalScale && return Ptr{Cfloat}(io + fieldoffset(ImGuiIO, 16))
    x === :FontAllowUserScaling && return Ptr{Bool}(io + fieldoffset(ImGuiIO, 17))
    x === :FontDefault && return Ptr{Ptr{ImFont}}(io + fieldoffset(ImGuiIO, 18))
    x === :DisplayFramebufferScale && return Ptr{ImVec2}(io + fieldoffset(ImGuiIO, 19))
    x === :MouseDrawCursor && return Ptr{Bool}(io + fieldoffset(ImGuiIO, 20))
    x === :ConfigMacOSXBehaviors && return Ptr{Bool}(io + fieldoffset(ImGuiIO, 21))
    x === :ConfigInputTextCursorBlink && return Ptr{Bool}(io + fieldoffset(ImGuiIO, 22))
    x === :ConfigWindowsResizeFromEdges && return Ptr{Bool}(io + fieldoffset(ImGuiIO, 23))
    x === :ConfigWindowsMoveFromTitleBarOnly && return Ptr{Bool}(io + fieldoffset(ImGuiIO, 24))
    x === :ConfigWindowsMemoryCompactTimer && return Ptr{Cfloat}(io + fieldoffset(ImGuiIO, 25))
    x === :BackendPlatformName && return Ptr{Ptr{Cchar}}(io + fieldoffset(ImGuiIO, 26))
    x === :BackendRendererName && return Ptr{Ptr{Cchar}}(io + fieldoffset(ImGuiIO, 27))
    x === :BackendPlatformUserData && return Ptr{Ptr{Cvoid}}(io + fieldoffset(ImGuiIO, 28))
    x === :BackendRendererUserData && return Ptr{Ptr{Cvoid}}(io + fieldoffset(ImGuiIO, 29))
    x === :BackendLanguageUserData && return Ptr{Ptr{Cvoid}}(io + fieldoffset(ImGuiIO, 30))
    x === :GetClipboardTextFn && return Ptr{Ptr{Cvoid}}(io + fieldoffset(ImGuiIO, 31))
    x === :SetClipboardTextFn && return Ptr{Ptr{Cvoid}}(io + fieldoffset(ImGuiIO, 32))
    x === :ClipboardUserData && return Ptr{Ptr{Cvoid}}(io + fieldoffset(ImGuiIO, 33))
    x === :ImeSetInputScreenPosFn && return Ptr{Ptr{Cvoid}}(io + fieldoffset(ImGuiIO, 34))
    x === :ImeWindowHandle && return Ptr{Ptr{Cvoid}}(io + fieldoffset(ImGuiIO, 35))
    x === :RenderDrawListsFnUnused && return Ptr{Ptr{Cvoid}}(io + fieldoffset(ImGuiIO, 36))
    x === :MousePos && return Ptr{ImVec2}(io + fieldoffset(ImGuiIO, 37))
    # MouseDown 38
    x === :MouseWheel && return Ptr{Cfloat}(io + fieldoffset(ImGuiIO, 39))
    x === :MouseWheelH && return Ptr{Cfloat}(io + fieldoffset(ImGuiIO, 40))
    x === :KeyCtrl && return Ptr{Bool}(io + fieldoffset(ImGuiIO, 41))
    x === :KeyShift && return Ptr{Bool}(io + fieldoffset(ImGuiIO, 42))
    x === :KeyAlt && return Ptr{Bool}(io + fieldoffset(ImGuiIO, 43))
    x === :KeySuper && return Ptr{Bool}(io + fieldoffset(ImGuiIO, 44))
    # KeysDown
    # NavInputs
    x === :WantCaptureMouse && return Ptr{Bool}(io + fieldoffset(ImGuiIO, 47))
    x === :WantCaptureKeyboard && return Ptr{Bool}(io + fieldoffset(ImGuiIO, 48))
    x === :WantTextInput && return Ptr{Bool}(io + fieldoffset(ImGuiIO, 49))
    x === :WantSetMousePos && return Ptr{Bool}(io + fieldoffset(ImGuiIO, 50))
    x === :WantSaveIniSettings && return Ptr{Bool}(io + fieldoffset(ImGuiIO, 51))
    x === :NavActive && return Ptr{Bool}(io + fieldoffset(ImGuiIO, 52))
    x === :NavVisible && return Ptr{Bool}(io + fieldoffset(ImGuiIO, 53))
    x === :Framerate && return Ptr{Cfloat}(io + fieldoffset(ImGuiIO, 54))
    x === :MetricsRenderVertices && return Ptr{Cint}(io + fieldoffset(ImGuiIO, 55))
    x === :MetricsRenderIndices && return Ptr{Cint}(io + fieldoffset(ImGuiIO, 56))
    x === :MetricsRenderWindows && return Ptr{Cint}(io + fieldoffset(ImGuiIO, 57))
    x === :MetricsActiveWindows && return Ptr{Cint}(io + fieldoffset(ImGuiIO, 58))
    x === :MetricsActiveAllocations && return Ptr{Cint}(io + fieldoffset(ImGuiIO, 59))
    x === :MouseDelta && return Ptr{ImVec2}(io + fieldoffset(ImGuiIO, 60))
    # KeyMods
    x === :MousePosPrev && return Ptr{ImVec2}(io + fieldoffset(ImGuiIO, 62))
    throw(ArgumentError("field $x is not supported to be used like this, please use `Get_$x` instead."))
end

function Base.setproperty!(io::Ptr{ImGuiIO}, x::Symbol, v)
    unsafe_store!(getproperty(io, x), v)
end

# emulate ImGui::GetStyle().xxx
function Base.getproperty(s::Ptr{ImGuiStyle}, x::Symbol)
    x == :Alpha && return ImGuiStyle_Get_Alpha(s)
    x == :WindowPadding && return ImGuiStyle_Get_WindowPadding(s)
    x == :WindowRounding && return ImGuiStyle_Get_WindowRounding(s)
    x == :WindowBorderSize && return ImGuiStyle_Get_WindowBorderSize(s)
    x == :WindowMinSize && return ImGuiStyle_Get_WindowMinSize(s)
    x == :WindowTitleAlign && return ImGuiStyle_Get_WindowTitleAlign(s)
    x == :ChildRounding && return ImGuiStyle_Get_ChildRounding(s)
    x == :ChildBorderSize && return ImGuiStyle_Get_ChildBorderSize(s)
    x == :PopupRounding && return ImGuiStyle_Get_PopupRounding(s)
    x == :PopupBorderSize && return ImGuiStyle_Get_PopupBorderSize(s)
    x == :FramePadding && return ImGuiStyle_Get_FramePadding(s)
    x == :FrameRounding && return ImGuiStyle_Get_FrameRounding(s)
    x == :FrameBorderSize && return ImGuiStyle_Get_FrameBorderSize(s)
    x == :ItemSpacing && return ImGuiStyle_Get_ItemSpacing(s)
    x == :ItemInnerSpacing && return ImGuiStyle_Get_ItemInnerSpacing(s)
    x == :TouchExtraPadding && return ImGuiStyle_Get_TouchExtraPadding(s)
    x == :IndentSpacing && return ImGuiStyle_Get_IndentSpacing(s)
    x == :ColumnsMinSpacing && return ImGuiStyle_Get_ColumnsMinSpacing(s)
    x == :ScrollbarSize && return ImGuiStyle_Get_ScrollbarSize(s)
    x == :ScrollbarRounding && return ImGuiStyle_Get_ScrollbarRounding(s)
    x == :GrabMinSize && return ImGuiStyle_Get_GrabMinSize(s)
    x == :GrabRounding && return ImGuiStyle_Get_GrabRounding(s)
    x == :TabRounding && return ImGuiStyle_Get_TabRounding(s)
    x == :TabBorderSize && return ImGuiStyle_Get_TabBorderSize(s)
    x == :ButtonTextAlign && return ImGuiStyle_Get_ButtonTextAlign(s)
    x == :SelectableTextAlign && return ImGuiStyle_Get_SelectableTextAlign(s)
    x == :DisplayWindowPadding && return ImGuiStyle_Get_DisplayWindowPadding(s)
    x == :DisplaySafeAreaPadding && return ImGuiStyle_Get_DisplaySafeAreaPadding(s)
    x == :MouseCursorScale && return ImGuiStyle_Get_MouseCursorScale(s)
    x == :AntiAliasedLines && return ImGuiStyle_Get_AntiAliasedLines(s)
    x == :AntiAliasedFill && return ImGuiStyle_Get_AntiAliasedFill(s)
    x == :CurveTessellationTol && return ImGuiStyle_Get_CurveTessellationTol(s)
    throw(ArgumentError("field $x is not supported to be used like this, please use `Get_$x` instead."))
end

function Base.setproperty!(s::Ptr{ImGuiStyle}, x::Symbol, v)
    x == :Alpha && return ImGuiStyle_Get_Alpha(s, v)
    x == :WindowPadding && return ImGuiStyle_Get_WindowPadding(s, v)
    x == :WindowRounding && return ImGuiStyle_Get_WindowRounding(s, v)
    x == :WindowBorderSize && return ImGuiStyle_Get_WindowBorderSize(s, v)
    x == :WindowMinSize && return ImGuiStyle_Get_WindowMinSize(s, v)
    x == :WindowTitleAlign && return ImGuiStyle_Get_WindowTitleAlign(s, v)
    x == :ChildRounding && return ImGuiStyle_Get_ChildRounding(s, v)
    x == :ChildBorderSize && return ImGuiStyle_Get_ChildBorderSize(s, v)
    x == :PopupRounding && return ImGuiStyle_Get_PopupRounding(s, v)
    x == :PopupBorderSize && return ImGuiStyle_Get_PopupBorderSize(s, v)
    x == :FramePadding && return ImGuiStyle_Get_FramePadding(s, v)
    x == :FrameRounding && return ImGuiStyle_Get_FrameRounding(s, v)
    x == :FrameBorderSize && return ImGuiStyle_Get_FrameBorderSize(s, v)
    x == :ItemSpacing && return ImGuiStyle_Get_ItemSpacing(s, v)
    x == :ItemInnerSpacing && return ImGuiStyle_Get_ItemInnerSpacing(s, v)
    x == :TouchExtraPadding && return ImGuiStyle_Get_TouchExtraPadding(s, v)
    x == :IndentSpacing && return ImGuiStyle_Get_IndentSpacing(s, v)
    x == :ColumnsMinSpacing && return ImGuiStyle_Get_ColumnsMinSpacing(s, v)
    x == :ScrollbarSize && return ImGuiStyle_Get_ScrollbarSize(s, v)
    x == :ScrollbarRounding && return ImGuiStyle_Get_ScrollbarRounding(s, v)
    x == :GrabMinSize && return ImGuiStyle_Get_GrabMinSize(s, v)
    x == :GrabRounding && return ImGuiStyle_Get_GrabRounding(s, v)
    x == :TabRounding && return ImGuiStyle_Get_TabRounding(s, v)
    x == :TabBorderSize && return ImGuiStyle_Get_TabBorderSize(s, v)
    x == :ButtonTextAlign && return ImGuiStyle_Get_ButtonTextAlign(s, v)
    x == :SelectableTextAlign && return ImGuiStyle_Get_SelectableTextAlign(s, v)
    x == :DisplayWindowPadding && return ImGuiStyle_Get_DisplayWindowPadding(s, v)
    x == :DisplaySafeAreaPadding && return ImGuiStyle_Get_DisplaySafeAreaPadding(s, v)
    x == :MouseCursorScale && return ImGuiStyle_Get_MouseCursorScale(s, v)
    x == :AntiAliasedLines && return ImGuiStyle_Get_AntiAliasedLines(s, v)
    x == :AntiAliasedFill && return ImGuiStyle_Get_AntiAliasedFill(s, v)
    x == :CurveTessellationTol && return ImGuiStyle_Get_CurveTessellationTol(s, v)
    throw(ArgumentError("field $x is not supported to be used like this!"))
end

# emulate draw_data->xxx
function Base.getproperty(data::Ptr{ImDrawData}, x::Symbol)
    x == :Valid && return ImDrawData_Get_Valid(data)
    x == :CmdListsCount && return ImDrawData_Get_CmdListsCount(data)
    x == :TotalIdxCount && return ImDrawData_Get_TotalIdxCount(data)
    x == :TotalVtxCount && return ImDrawData_Get_TotalVtxCount(data)
    x == :DisplayPos && return ImDrawData_Get_DisplayPos(data)
    x == :DisplaySize && return ImDrawData_Get_DisplaySize(data)
    x == :FramebufferScale && return ImDrawData_Get_FramebufferScale(data)
    throw(ArgumentError("field $x is not supported to be used like this, please use `Get_$x` instead."))
end

# emulate cmd.xxx
function Base.getproperty(cmd::Ptr{ImDrawCmd}, x::Symbol)
    x == :ElemCount && return ImDrawCmd_Get_ElemCount(cmd)
    x == :ClipRect && return ImDrawCmd_Get_ClipRect(cmd)
    x == :TextureId && return ImDrawCmd_Get_TextureId(cmd)
    x == :VtxOffset && return ImDrawCmd_Get_VtxOffset(cmd)
    x == :IdxOffset && return ImDrawCmd_Get_IdxOffset(cmd)
    x == :UserCallback && return ImDrawCmd_Get_UserCallback(cmd)
    x == :UserCallbackData && return ImDrawCmd_Get_UserCallbackData(cmd)
    throw(ArgumentError("field $x is not supported to be used like this, please use `Get_$x` instead."))
end

# emulate io.Fonts->.xxx
function Base.getproperty(f::Ptr{ImFontAtlas}, x::Symbol)
    x === :TexID && return Ptr{ImTextureID}(io + fieldoffset(ImFontAtlas, 3))
    x === :TexWidth && return Ptr{Cint}(io + fieldoffset(ImFontAtlas, 8))
    x === :TexHeight && return Ptr{Cint}(io + fieldoffset(ImFontAtlas, 9))
    throw(ArgumentError("field $x is not supported to be used like this, please use `Get_$x` instead."))
end
