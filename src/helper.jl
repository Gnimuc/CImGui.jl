# helper convertion functions
Base.convert(::Type{ImVec2}, x::NTuple{2}) = ImVec2(x...)
Base.convert(::Type{ImVec2}, x::Vector) = ImVec2(x...)
Base.convert(::Type{ImVec4}, x::NTuple{4}) = ImVec4(x...)
Base.convert(::Type{ImVec4}, x::Vector) = ImVec4(x...)
Base.convert(::Type{ImVec4}, x::ImU32) = ColorConvertU32ToFloat4(x)
Base.convert(::Type{ImU32}, x::ImVec4) = ColorConvertFloat4ToU32(x)

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

function c_get(x::Ptr{NTuple{N,T}}, i) where {N,T}
    unsafe_load(Ptr{T}(x), Integer(i)+1)
end

function c_set!(x::Ptr{NTuple{N,T}}, i, v) where {N,T}
    unsafe_store!(Ptr{T}(x), v, Integer(i)+1)
end

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
    x === :MouseDown && return Ptr{NTuple{5, Bool}}(io + fieldoffset(ImGuiIO, 38))
    x === :MouseWheel && return Ptr{Cfloat}(io + fieldoffset(ImGuiIO, 39))
    x === :MouseWheelH && return Ptr{Cfloat}(io + fieldoffset(ImGuiIO, 40))
    x === :KeyCtrl && return Ptr{Bool}(io + fieldoffset(ImGuiIO, 41))
    x === :KeyShift && return Ptr{Bool}(io + fieldoffset(ImGuiIO, 42))
    x === :KeyAlt && return Ptr{Bool}(io + fieldoffset(ImGuiIO, 43))
    x === :KeySuper && return Ptr{Bool}(io + fieldoffset(ImGuiIO, 44))
    x === :KeysDown && return Ptr{NTuple{512, Bool}}(io + fieldoffset(ImGuiIO, 45))
    x === :NavInputs && return Ptr{NTuple{21, Cfloat}}(io + fieldoffset(ImGuiIO, 46))
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
    x === :KeyMods && return Ptr{ImGuiKeyModFlags}(io + fieldoffset(ImGuiIO, 61))
    # MousePosPrev::ImVec2
    # MouseClickedPos::NTuple{5, ImVec2}
    # MouseClickedTime::NTuple{5, Cdouble}
    # MouseClicked::NTuple{5, Bool}
    # MouseDoubleClicked::NTuple{5, Bool}
    # MouseReleased::NTuple{5, Bool}
    # MouseDownOwned::NTuple{5, Bool}
    # MouseDownWasDoubleClick::NTuple{5, Bool}
    x === :MouseDownDuration && return Ptr{NTuple{5, Cfloat}}(io + fieldoffset(ImGuiIO, 70))
    # MouseDownDurationPrev::NTuple{5, Cfloat}
    # MouseDragMaxDistanceAbs::NTuple{5, ImVec2}
    # MouseDragMaxDistanceSqr::NTuple{5, Cfloat}
    x === :KeysDownDuration && return Ptr{NTuple{512, Cfloat}}(io + fieldoffset(ImGuiIO, 74))
    # KeysDownDurationPrev::NTuple{512, Cfloat}
    # NavInputsDownDuration::NTuple{21, Cfloat}
    # NavInputsDownDurationPrev::NTuple{21, Cfloat}
    # PenPressure::Cfloat
    # InputQueueSurrogate::ImWchar16
    # InputQueueCharacters::ImVector_ImWchar
    return getfield(io, x)
end

function Base.setproperty!(io::Ptr{ImGuiIO}, x::Symbol, v)
    unsafe_store!(getproperty(io, x), v)
end

function Base.getproperty(x::Ptr{ImDrawList}, f::Symbol)
    f === :CmdBuffer && return Ptr{ImVector_ImDrawCmd}(x + fieldoffset(ImDrawList, 1))
    f === :IdxBuffer && return Ptr{ImVector_ImDrawIdx}(x + fieldoffset(ImDrawList, 2))
    f === :VtxBuffer && return Ptr{ImVector_ImDrawVert}(x + fieldoffset(ImDrawList, 3))
    f === :Flags && return Ptr{ImDrawListFlags}(x + fieldoffset(ImDrawList, 4))
    return getfield(x, f)
end

function Base.getproperty(x::Ptr{ImDrawData}, f::Symbol)
    f === :Valid && return Ptr{Bool}(x + fieldoffset(ImDrawData, 1))
    f === :CmdLists && return Ptr{Ptr{Ptr{ImDrawList}}}(x + fieldoffset(ImDrawData, 2))
    f === :CmdListsCount && return Ptr{Cint}(x + fieldoffset(ImDrawData, 3))
    f === :TotalIdxCount && return Ptr{Cint}(x + fieldoffset(ImDrawData, 4))
    f === :TotalVtxCount && return Ptr{Cint}(x + fieldoffset(ImDrawData, 5))
    f === :DisplayPos && return Ptr{ImVec2}(x + fieldoffset(ImDrawData, 6))
    f === :DisplaySize && return Ptr{ImVec2}(x + fieldoffset(ImDrawData, 7))
    f === :FramebufferScale && return Ptr{ImVec2}(x + fieldoffset(ImDrawData, 8))
    return getfield(x, f)
end

function Base.getproperty(x::Ptr{ImDrawCmd}, f::Symbol)
    f === :ClipRect && return Ptr{ImVec4}(x + fieldoffset(ImDrawCmd, 1))
    f === :TextureId && return Ptr{ImTextureID}(x + fieldoffset(ImDrawCmd, 2))
    f === :VtxOffset && return Ptr{Cuint}(x + fieldoffset(ImDrawCmd, 3))
    f === :IdxOffset && return Ptr{Cuint}(x + fieldoffset(ImDrawCmd, 4))
    f === :ElemCount && return Ptr{Cuint}(x + fieldoffset(ImDrawCmd, 5))
    f === :UserCallback && return Ptr{ImDrawCallback}(x + fieldoffset(ImDrawCmd, 6))
    f === :UserCallbackData && return Ptr{Ptr{Cvoid}}(x + fieldoffset(ImDrawCmd, 7))
    return getfield(x, f)
end

function Base.getproperty(x::Ptr{ImFontAtlas}, f::Symbol)
    f === :TexID && return Ptr{ImTextureID}(x + fieldoffset(ImFontAtlas, 3))
    f === :TexWidth && return Ptr{Cint}(x + fieldoffset(ImFontAtlas, 8))
    f === :TexHeight && return Ptr{Cint}(x + fieldoffset(ImFontAtlas, 9))
    return getfield(x, f)
end

function Base.getproperty(x::Ptr{ImGuiSizeCallbackData}, f::Symbol)
    f === :UserData && return Ptr{Ptr{Cvoid}}(x + fieldoffset(ImGuiSizeCallbackData, 1))
    f === :Pos && return Ptr{ImVec2}(x + fieldoffset(ImGuiSizeCallbackData, 2))
    f === :CurrentSize && return Ptr{ImVec2}(x + fieldoffset(ImGuiSizeCallbackData, 3))
    f === :DesiredSize && return Ptr{ImVec2}(x + fieldoffset(ImGuiSizeCallbackData, 4))
    return getfield(x, f)
end

function Base.setproperty!(io::Ptr{ImGuiSizeCallbackData}, x::Symbol, v)
    unsafe_store!(getproperty(io, x), v)
end
