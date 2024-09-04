using CEnum

to_c_type(t::Type) = t
to_c_type_pairs(va_list) = map(enumerate(to_c_type.(va_list))) do (ind, type)
    :(va_list[$ind]::$type)
end

const time_t = Clong

struct tm
    tm_sec::Cint
    tm_min::Cint
    tm_hour::Cint
    tm_mday::Cint
    tm_mon::Cint
    tm_year::Cint
    tm_wday::Cint
    tm_yday::Cint
    tm_isdst::Cint
    tm_gmtoff::Clong
    tm_zone::Ptr{Cchar}
end

# typedef void ( * ImDrawCallback ) ( const ImDrawList * parent_list , const ImDrawCmd * cmd )
const ImDrawCallback = Ptr{Cvoid}

struct ImVec4
    x::Cfloat
    y::Cfloat
    z::Cfloat
    w::Cfloat
end
function Base.getproperty(x::Ptr{ImVec4}, f::Symbol)
    f === :x && return Ptr{Cfloat}(x + 0)
    f === :y && return Ptr{Cfloat}(x + 4)
    f === :z && return Ptr{Cfloat}(x + 8)
    f === :w && return Ptr{Cfloat}(x + 12)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{ImVec4}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


const ImTextureID = Ptr{Cvoid}

struct ImDrawCmd
    ClipRect::ImVec4
    TextureId::ImTextureID
    VtxOffset::Cuint
    IdxOffset::Cuint
    ElemCount::Cuint
    UserCallback::ImDrawCallback
    UserCallbackData::Ptr{Cvoid}
end
function Base.getproperty(x::Ptr{ImDrawCmd}, f::Symbol)
    f === :ClipRect && return Ptr{ImVec4}(x + 0)
    f === :TextureId && return Ptr{ImTextureID}(x + 16)
    f === :VtxOffset && return Ptr{Cuint}(x + 24)
    f === :IdxOffset && return Ptr{Cuint}(x + 28)
    f === :ElemCount && return Ptr{Cuint}(x + 32)
    f === :UserCallback && return Ptr{ImDrawCallback}(x + 40)
    f === :UserCallbackData && return Ptr{Ptr{Cvoid}}(x + 48)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{ImDrawCmd}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct ImVector_ImDrawCmd
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImDrawCmd}
end

const ImDrawIdx = Cushort

struct ImVector_ImDrawIdx
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImDrawIdx}
end

struct ImDrawChannel
    _CmdBuffer::ImVector_ImDrawCmd
    _IdxBuffer::ImVector_ImDrawIdx
end

struct ImVec2
    x::Cfloat
    y::Cfloat
end
function Base.getproperty(x::Ptr{ImVec2}, f::Symbol)
    f === :x && return Ptr{Cfloat}(x + 0)
    f === :y && return Ptr{Cfloat}(x + 4)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{ImVec2}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


const ImU32 = Cuint

struct ImDrawVert
    pos::ImVec2
    uv::ImVec2
    col::ImU32
end

struct ImVector_ImDrawVert
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImDrawVert}
end

const ImDrawListFlags = Cint

struct ImVector_float
    Size::Cint
    Capacity::Cint
    Data::Ptr{Cfloat}
end

const ImWchar16 = Cushort

const ImWchar = ImWchar16

struct ImVector_ImWchar
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImWchar}
end

struct ImFontGlyph
    data::NTuple{40, UInt8}
end

function Base.getproperty(x::Ptr{ImFontGlyph}, f::Symbol)
    f === :Colored && return (Ptr{Cuint}(x + 0), 0, 1)
    f === :Visible && return (Ptr{Cuint}(x + 0), 1, 1)
    f === :Codepoint && return (Ptr{Cuint}(x + 0), 2, 30)
    f === :AdvanceX && return Ptr{Cfloat}(x + 4)
    f === :X0 && return Ptr{Cfloat}(x + 8)
    f === :Y0 && return Ptr{Cfloat}(x + 12)
    f === :X1 && return Ptr{Cfloat}(x + 16)
    f === :Y1 && return Ptr{Cfloat}(x + 20)
    f === :U0 && return Ptr{Cfloat}(x + 24)
    f === :V0 && return Ptr{Cfloat}(x + 28)
    f === :U1 && return Ptr{Cfloat}(x + 32)
    f === :V1 && return Ptr{Cfloat}(x + 36)
    return getfield(x, f)
end

function Base.getproperty(x::ImFontGlyph, f::Symbol)
    r = Ref{ImFontGlyph}(x)
    ptr = Base.unsafe_convert(Ptr{ImFontGlyph}, r)
    fptr = getproperty(ptr, f)
    begin
        if fptr isa Ptr
            return GC.@preserve(r, unsafe_load(fptr))
        else
            (baseptr, offset, width) = fptr
            ty = eltype(baseptr)
            baseptr32 = convert(Ptr{UInt32}, baseptr)
            u64 = GC.@preserve(r, unsafe_load(baseptr32))
            if offset + width > 32
                u64 |= GC.@preserve(r, unsafe_load(baseptr32 + 4)) << 32
            end
            u64 = u64 >> offset & (1 << width - 1)
            return u64 % ty
        end
    end
end

function Base.setproperty!(x::Ptr{ImFontGlyph}, f::Symbol, v)
    fptr = getproperty(x, f)
    if fptr isa Ptr
        unsafe_store!(getproperty(x, f), v)
    else
        (baseptr, offset, width) = fptr
        baseptr32 = convert(Ptr{UInt32}, baseptr)
        u64 = unsafe_load(baseptr32)
        straddle = offset + width > 32
        if straddle
            u64 |= unsafe_load(baseptr32 + 4) << 32
        end
        mask = 1 << width - 1
        u64 &= ~(mask << offset)
        u64 |= (unsigned(v) & mask) << offset
        unsafe_store!(baseptr32, u64 & typemax(UInt32))
        if straddle
            unsafe_store!(baseptr32 + 4, u64 >> 32)
        end
    end
end

struct ImVector_ImFontGlyph
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImFontGlyph}
end

const ImFontAtlasFlags = Cint

struct ImVector_ImFontPtr
    Size::Cint
    Capacity::Cint
    Data::Ptr{Ptr{Cvoid}} # Data::Ptr{Ptr{ImFont}}
end

function Base.getproperty(x::ImVector_ImFontPtr, f::Symbol)
    f === :Data && return Ptr{Ptr{ImFont}}(getfield(x, f))
    return getfield(x, f)
end

struct ImFontAtlasCustomRect
    Width::Cushort
    Height::Cushort
    X::Cushort
    Y::Cushort
    GlyphID::Cuint
    GlyphAdvanceX::Cfloat
    GlyphOffset::ImVec2
    Font::Ptr{Cvoid} # Font::Ptr{ImFont}
end

function Base.getproperty(x::ImFontAtlasCustomRect, f::Symbol)
    f === :Font && return Ptr{ImFont}(getfield(x, f))
    return getfield(x, f)
end

struct ImVector_ImFontAtlasCustomRect
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImFontAtlasCustomRect}
end

struct ImFontConfig
    FontData::Ptr{Cvoid}
    FontDataSize::Cint
    FontDataOwnedByAtlas::Bool
    FontNo::Cint
    SizePixels::Cfloat
    OversampleH::Cint
    OversampleV::Cint
    PixelSnapH::Bool
    GlyphExtraSpacing::ImVec2
    GlyphOffset::ImVec2
    GlyphRanges::Ptr{ImWchar}
    GlyphMinAdvanceX::Cfloat
    GlyphMaxAdvanceX::Cfloat
    MergeMode::Bool
    FontBuilderFlags::Cuint
    RasterizerMultiply::Cfloat
    RasterizerDensity::Cfloat
    EllipsisChar::ImWchar
    Name::NTuple{40, Cchar}
    DstFont::Ptr{Cvoid} # DstFont::Ptr{ImFont}
end

function Base.getproperty(x::ImFontConfig, f::Symbol)
    f === :DstFont && return Ptr{ImFont}(getfield(x, f))
    return getfield(x, f)
end

function Base.getproperty(x::Ptr{ImFontConfig}, f::Symbol)
    f === :FontData && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :FontDataSize && return Ptr{Cint}(x + 8)
    f === :FontDataOwnedByAtlas && return Ptr{Bool}(x + 12)
    f === :FontNo && return Ptr{Cint}(x + 16)
    f === :SizePixels && return Ptr{Cfloat}(x + 20)
    f === :OversampleH && return Ptr{Cint}(x + 24)
    f === :OversampleV && return Ptr{Cint}(x + 28)
    f === :PixelSnapH && return Ptr{Bool}(x + 32)
    f === :GlyphExtraSpacing && return Ptr{ImVec2}(x + 36)
    f === :GlyphOffset && return Ptr{ImVec2}(x + 44)
    f === :GlyphRanges && return Ptr{Ptr{ImWchar}}(x + 56)
    f === :GlyphMinAdvanceX && return Ptr{Cfloat}(x + 64)
    f === :GlyphMaxAdvanceX && return Ptr{Cfloat}(x + 68)
    f === :MergeMode && return Ptr{Bool}(x + 72)
    f === :FontBuilderFlags && return Ptr{Cuint}(x + 76)
    f === :RasterizerMultiply && return Ptr{Cfloat}(x + 80)
    f === :RasterizerDensity && return Ptr{Cfloat}(x + 84)
    f === :EllipsisChar && return Ptr{ImWchar}(x + 88)
    f === :Name && return Ptr{NTuple{40, Cchar}}(x + 90)
    f === :DstFont && return Ptr{Ptr{ImFont}}(x + 136)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{ImFontConfig}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct ImVector_ImFontConfig
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImFontConfig}
end

struct ImFontBuilderIO
    FontBuilder_Build::Ptr{Cvoid}
end

struct ImFontAtlas
    Flags::ImFontAtlasFlags
    TexID::ImTextureID
    TexDesiredWidth::Cint
    TexGlyphPadding::Cint
    Locked::Bool
    UserData::Ptr{Cvoid}
    TexReady::Bool
    TexPixelsUseColors::Bool
    TexPixelsAlpha8::Ptr{Cuchar}
    TexPixelsRGBA32::Ptr{Cuint}
    TexWidth::Cint
    TexHeight::Cint
    TexUvScale::ImVec2
    TexUvWhitePixel::ImVec2
    Fonts::ImVector_ImFontPtr
    CustomRects::ImVector_ImFontAtlasCustomRect
    ConfigData::ImVector_ImFontConfig
    TexUvLines::NTuple{64, ImVec4}
    FontBuilderIO::Ptr{ImFontBuilderIO}
    FontBuilderFlags::Cuint
    PackIdMouseCursors::Cint
    PackIdLines::Cint
end
function Base.getproperty(x::Ptr{ImFontAtlas}, f::Symbol)
    f === :Flags && return Ptr{ImFontAtlasFlags}(x + 0)
    f === :TexID && return Ptr{ImTextureID}(x + 8)
    f === :TexDesiredWidth && return Ptr{Cint}(x + 16)
    f === :TexGlyphPadding && return Ptr{Cint}(x + 20)
    f === :Locked && return Ptr{Bool}(x + 24)
    f === :UserData && return Ptr{Ptr{Cvoid}}(x + 32)
    f === :TexReady && return Ptr{Bool}(x + 40)
    f === :TexPixelsUseColors && return Ptr{Bool}(x + 41)
    f === :TexPixelsAlpha8 && return Ptr{Ptr{Cuchar}}(x + 48)
    f === :TexPixelsRGBA32 && return Ptr{Ptr{Cuint}}(x + 56)
    f === :TexWidth && return Ptr{Cint}(x + 64)
    f === :TexHeight && return Ptr{Cint}(x + 68)
    f === :TexUvScale && return Ptr{ImVec2}(x + 72)
    f === :TexUvWhitePixel && return Ptr{ImVec2}(x + 80)
    f === :Fonts && return Ptr{ImVector_ImFontPtr}(x + 88)
    f === :CustomRects && return Ptr{ImVector_ImFontAtlasCustomRect}(x + 104)
    f === :ConfigData && return Ptr{ImVector_ImFontConfig}(x + 120)
    f === :TexUvLines && return Ptr{NTuple{64, ImVec4}}(x + 136)
    f === :FontBuilderIO && return Ptr{Ptr{ImFontBuilderIO}}(x + 1160)
    f === :FontBuilderFlags && return Ptr{Cuint}(x + 1168)
    f === :PackIdMouseCursors && return Ptr{Cint}(x + 1172)
    f === :PackIdLines && return Ptr{Cint}(x + 1176)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{ImFontAtlas}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


const ImU8 = Cuchar

struct ImFont
    IndexAdvanceX::ImVector_float
    FallbackAdvanceX::Cfloat
    FontSize::Cfloat
    IndexLookup::ImVector_ImWchar
    Glyphs::ImVector_ImFontGlyph
    FallbackGlyph::Ptr{ImFontGlyph}
    ContainerAtlas::Ptr{ImFontAtlas}
    ConfigData::Ptr{ImFontConfig}
    ConfigDataCount::Cshort
    FallbackChar::ImWchar
    EllipsisChar::ImWchar
    EllipsisCharCount::Cshort
    EllipsisWidth::Cfloat
    EllipsisCharStep::Cfloat
    DirtyLookupTables::Bool
    Scale::Cfloat
    Ascent::Cfloat
    Descent::Cfloat
    MetricsTotalSurface::Cint
    Used4kPagesMap::NTuple{2, ImU8}
end

struct ImVector_ImVec2
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImVec2}
end

struct ImDrawListSharedData
    TexUvWhitePixel::ImVec2
    Font::Ptr{ImFont}
    FontSize::Cfloat
    FontScale::Cfloat
    CurveTessellationTol::Cfloat
    CircleSegmentMaxError::Cfloat
    ClipRectFullscreen::ImVec4
    InitialFlags::ImDrawListFlags
    TempBuffer::ImVector_ImVec2
    ArcFastVtx::NTuple{48, ImVec2}
    ArcFastRadiusCutoff::Cfloat
    CircleSegmentCounts::NTuple{64, ImU8}
    TexUvLines::Ptr{ImVec4}
end

struct ImDrawCmdHeader
    ClipRect::ImVec4
    TextureId::ImTextureID
    VtxOffset::Cuint
end

struct ImVector_ImDrawChannel
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImDrawChannel}
end

struct ImDrawListSplitter
    _Current::Cint
    _Count::Cint
    _Channels::ImVector_ImDrawChannel
end

struct ImVector_ImVec4
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImVec4}
end

struct ImVector_ImTextureID
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImTextureID}
end

struct ImDrawList
    CmdBuffer::ImVector_ImDrawCmd
    IdxBuffer::ImVector_ImDrawIdx
    VtxBuffer::ImVector_ImDrawVert
    Flags::ImDrawListFlags
    _VtxCurrentIdx::Cuint
    _Data::Ptr{ImDrawListSharedData}
    _VtxWritePtr::Ptr{ImDrawVert}
    _IdxWritePtr::Ptr{ImDrawIdx}
    _Path::ImVector_ImVec2
    _CmdHeader::ImDrawCmdHeader
    _Splitter::ImDrawListSplitter
    _ClipRectStack::ImVector_ImVec4
    _TextureIdStack::ImVector_ImTextureID
    _FringeScale::Cfloat
    _OwnerName::Ptr{Cchar}
end
function Base.getproperty(x::Ptr{ImDrawList}, f::Symbol)
    f === :CmdBuffer && return Ptr{ImVector_ImDrawCmd}(x + 0)
    f === :IdxBuffer && return Ptr{ImVector_ImDrawIdx}(x + 16)
    f === :VtxBuffer && return Ptr{ImVector_ImDrawVert}(x + 32)
    f === :Flags && return Ptr{ImDrawListFlags}(x + 48)
    f === :_VtxCurrentIdx && return Ptr{Cuint}(x + 52)
    f === :_Data && return Ptr{Ptr{ImDrawListSharedData}}(x + 56)
    f === :_VtxWritePtr && return Ptr{Ptr{ImDrawVert}}(x + 64)
    f === :_IdxWritePtr && return Ptr{Ptr{ImDrawIdx}}(x + 72)
    f === :_Path && return Ptr{ImVector_ImVec2}(x + 80)
    f === :_CmdHeader && return Ptr{ImDrawCmdHeader}(x + 96)
    f === :_Splitter && return Ptr{ImDrawListSplitter}(x + 128)
    f === :_ClipRectStack && return Ptr{ImVector_ImVec4}(x + 152)
    f === :_TextureIdStack && return Ptr{ImVector_ImTextureID}(x + 168)
    f === :_FringeScale && return Ptr{Cfloat}(x + 184)
    f === :_OwnerName && return Ptr{Ptr{Cchar}}(x + 192)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{ImDrawList}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct ImVector_ImDrawListPtr
    Size::Cint
    Capacity::Cint
    Data::Ptr{Ptr{ImDrawList}}
end

const ImGuiID = Cuint

const ImGuiViewportFlags = Cint

struct ImGuiViewport
    ID::ImGuiID
    Flags::ImGuiViewportFlags
    Pos::ImVec2
    Size::ImVec2
    WorkPos::ImVec2
    WorkSize::ImVec2
    DpiScale::Cfloat
    ParentViewportId::ImGuiID
    DrawData::Ptr{Cvoid} # DrawData::Ptr{ImDrawData}
    RendererUserData::Ptr{Cvoid}
    PlatformUserData::Ptr{Cvoid}
    PlatformHandle::Ptr{Cvoid}
    PlatformHandleRaw::Ptr{Cvoid}
    PlatformWindowCreated::Bool
    PlatformRequestMove::Bool
    PlatformRequestResize::Bool
    PlatformRequestClose::Bool
end

function Base.getproperty(x::ImGuiViewport, f::Symbol)
    f === :DrawData && return Ptr{ImDrawData}(getfield(x, f))
    return getfield(x, f)
end

function Base.getproperty(x::Ptr{ImGuiViewport}, f::Symbol)
    f === :ID && return Ptr{ImGuiID}(x + 0)
    f === :Flags && return Ptr{ImGuiViewportFlags}(x + 4)
    f === :Pos && return Ptr{ImVec2}(x + 8)
    f === :Size && return Ptr{ImVec2}(x + 16)
    f === :WorkPos && return Ptr{ImVec2}(x + 24)
    f === :WorkSize && return Ptr{ImVec2}(x + 32)
    f === :DpiScale && return Ptr{Cfloat}(x + 40)
    f === :ParentViewportId && return Ptr{ImGuiID}(x + 44)
    f === :DrawData && return Ptr{Ptr{ImDrawData}}(x + 48)
    f === :RendererUserData && return Ptr{Ptr{Cvoid}}(x + 56)
    f === :PlatformUserData && return Ptr{Ptr{Cvoid}}(x + 64)
    f === :PlatformHandle && return Ptr{Ptr{Cvoid}}(x + 72)
    f === :PlatformHandleRaw && return Ptr{Ptr{Cvoid}}(x + 80)
    f === :PlatformWindowCreated && return Ptr{Bool}(x + 88)
    f === :PlatformRequestMove && return Ptr{Bool}(x + 89)
    f === :PlatformRequestResize && return Ptr{Bool}(x + 90)
    f === :PlatformRequestClose && return Ptr{Bool}(x + 91)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{ImGuiViewport}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct ImDrawData
    Valid::Bool
    CmdListsCount::Cint
    TotalIdxCount::Cint
    TotalVtxCount::Cint
    CmdLists::ImVector_ImDrawListPtr
    DisplayPos::ImVec2
    DisplaySize::ImVec2
    FramebufferScale::ImVec2
    OwnerViewport::Ptr{ImGuiViewport}
end
function Base.getproperty(x::Ptr{ImDrawData}, f::Symbol)
    f === :Valid && return Ptr{Bool}(x + 0)
    f === :CmdListsCount && return Ptr{Cint}(x + 4)
    f === :TotalIdxCount && return Ptr{Cint}(x + 8)
    f === :TotalVtxCount && return Ptr{Cint}(x + 12)
    f === :CmdLists && return Ptr{ImVector_ImDrawListPtr}(x + 16)
    f === :DisplayPos && return Ptr{ImVec2}(x + 32)
    f === :DisplaySize && return Ptr{ImVec2}(x + 40)
    f === :FramebufferScale && return Ptr{ImVec2}(x + 48)
    f === :OwnerViewport && return Ptr{Ptr{ImGuiViewport}}(x + 56)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{ImDrawData}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct ImVector_ImU32
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImU32}
end

struct ImFontGlyphRangesBuilder
    UsedChars::ImVector_ImU32
end

struct ImColor
    Value::ImVec4
end

const ImGuiConfigFlags = Cint

const ImGuiBackendFlags = Cint

@cenum ImGuiMouseSource::UInt32 begin
    ImGuiMouseSource_Mouse = 0
    ImGuiMouseSource_TouchScreen = 1
    ImGuiMouseSource_Pen = 2
    ImGuiMouseSource_COUNT = 3
end

const ImGuiKeyChord = Cint

struct ImGuiKeyData
    Down::Bool
    DownDuration::Cfloat
    DownDurationPrev::Cfloat
    AnalogValue::Cfloat
end

const ImU16 = Cushort

const ImS8 = Int8

struct ImGuiIO
    ConfigFlags::ImGuiConfigFlags
    BackendFlags::ImGuiBackendFlags
    DisplaySize::ImVec2
    DeltaTime::Cfloat
    IniSavingRate::Cfloat
    IniFilename::Ptr{Cchar}
    LogFilename::Ptr{Cchar}
    UserData::Ptr{Cvoid}
    Fonts::Ptr{ImFontAtlas}
    FontGlobalScale::Cfloat
    FontAllowUserScaling::Bool
    FontDefault::Ptr{ImFont}
    DisplayFramebufferScale::ImVec2
    ConfigDockingNoSplit::Bool
    ConfigDockingWithShift::Bool
    ConfigDockingAlwaysTabBar::Bool
    ConfigDockingTransparentPayload::Bool
    ConfigViewportsNoAutoMerge::Bool
    ConfigViewportsNoTaskBarIcon::Bool
    ConfigViewportsNoDecoration::Bool
    ConfigViewportsNoDefaultParent::Bool
    MouseDrawCursor::Bool
    ConfigMacOSXBehaviors::Bool
    ConfigNavSwapGamepadButtons::Bool
    ConfigInputTrickleEventQueue::Bool
    ConfigInputTextCursorBlink::Bool
    ConfigInputTextEnterKeepActive::Bool
    ConfigDragClickToInputText::Bool
    ConfigWindowsResizeFromEdges::Bool
    ConfigWindowsMoveFromTitleBarOnly::Bool
    ConfigMemoryCompactTimer::Cfloat
    MouseDoubleClickTime::Cfloat
    MouseDoubleClickMaxDist::Cfloat
    MouseDragThreshold::Cfloat
    KeyRepeatDelay::Cfloat
    KeyRepeatRate::Cfloat
    ConfigDebugIsDebuggerPresent::Bool
    ConfigDebugBeginReturnValueOnce::Bool
    ConfigDebugBeginReturnValueLoop::Bool
    ConfigDebugIgnoreFocusLoss::Bool
    ConfigDebugIniSettings::Bool
    BackendPlatformName::Ptr{Cchar}
    BackendRendererName::Ptr{Cchar}
    BackendPlatformUserData::Ptr{Cvoid}
    BackendRendererUserData::Ptr{Cvoid}
    BackendLanguageUserData::Ptr{Cvoid}
    GetClipboardTextFn::Ptr{Cvoid}
    SetClipboardTextFn::Ptr{Cvoid}
    ClipboardUserData::Ptr{Cvoid}
    PlatformOpenInShellFn::Ptr{Cvoid}
    PlatformOpenInShellUserData::Ptr{Cvoid}
    PlatformSetImeDataFn::Ptr{Cvoid}
    PlatformLocaleDecimalPoint::ImWchar
    WantCaptureMouse::Bool
    WantCaptureKeyboard::Bool
    WantTextInput::Bool
    WantSetMousePos::Bool
    WantSaveIniSettings::Bool
    NavActive::Bool
    NavVisible::Bool
    Framerate::Cfloat
    MetricsRenderVertices::Cint
    MetricsRenderIndices::Cint
    MetricsRenderWindows::Cint
    MetricsActiveWindows::Cint
    MouseDelta::ImVec2
    Ctx::Ptr{Cvoid} # Ctx::Ptr{ImGuiContext}
    MousePos::ImVec2
    MouseDown::NTuple{5, Bool}
    MouseWheel::Cfloat
    MouseWheelH::Cfloat
    MouseSource::ImGuiMouseSource
    MouseHoveredViewport::ImGuiID
    KeyCtrl::Bool
    KeyShift::Bool
    KeyAlt::Bool
    KeySuper::Bool
    KeyMods::ImGuiKeyChord
    KeysData::NTuple{154, ImGuiKeyData}
    WantCaptureMouseUnlessPopupClose::Bool
    MousePosPrev::ImVec2
    MouseClickedPos::NTuple{5, ImVec2}
    MouseClickedTime::NTuple{5, Cdouble}
    MouseClicked::NTuple{5, Bool}
    MouseDoubleClicked::NTuple{5, Bool}
    MouseClickedCount::NTuple{5, ImU16}
    MouseClickedLastCount::NTuple{5, ImU16}
    MouseReleased::NTuple{5, Bool}
    MouseDownOwned::NTuple{5, Bool}
    MouseDownOwnedUnlessPopupClose::NTuple{5, Bool}
    MouseWheelRequestAxisSwap::Bool
    MouseCtrlLeftAsRightClick::Bool
    MouseDownDuration::NTuple{5, Cfloat}
    MouseDownDurationPrev::NTuple{5, Cfloat}
    MouseDragMaxDistanceAbs::NTuple{5, ImVec2}
    MouseDragMaxDistanceSqr::NTuple{5, Cfloat}
    PenPressure::Cfloat
    AppFocusLost::Bool
    AppAcceptingEvents::Bool
    BackendUsingLegacyKeyArrays::ImS8
    BackendUsingLegacyNavInputArray::Bool
    InputQueueSurrogate::ImWchar16
    InputQueueCharacters::ImVector_ImWchar
end

function Base.getproperty(x::ImGuiIO, f::Symbol)
    f === :Ctx && return Ptr{ImGuiContext}(getfield(x, f))
    return getfield(x, f)
end

function Base.getproperty(x::Ptr{ImGuiIO}, f::Symbol)
    f === :ConfigFlags && return Ptr{ImGuiConfigFlags}(x + 0)
    f === :BackendFlags && return Ptr{ImGuiBackendFlags}(x + 4)
    f === :DisplaySize && return Ptr{ImVec2}(x + 8)
    f === :DeltaTime && return Ptr{Cfloat}(x + 16)
    f === :IniSavingRate && return Ptr{Cfloat}(x + 20)
    f === :IniFilename && return Ptr{Ptr{Cchar}}(x + 24)
    f === :LogFilename && return Ptr{Ptr{Cchar}}(x + 32)
    f === :UserData && return Ptr{Ptr{Cvoid}}(x + 40)
    f === :Fonts && return Ptr{Ptr{ImFontAtlas}}(x + 48)
    f === :FontGlobalScale && return Ptr{Cfloat}(x + 56)
    f === :FontAllowUserScaling && return Ptr{Bool}(x + 60)
    f === :FontDefault && return Ptr{Ptr{ImFont}}(x + 64)
    f === :DisplayFramebufferScale && return Ptr{ImVec2}(x + 72)
    f === :ConfigDockingNoSplit && return Ptr{Bool}(x + 80)
    f === :ConfigDockingWithShift && return Ptr{Bool}(x + 81)
    f === :ConfigDockingAlwaysTabBar && return Ptr{Bool}(x + 82)
    f === :ConfigDockingTransparentPayload && return Ptr{Bool}(x + 83)
    f === :ConfigViewportsNoAutoMerge && return Ptr{Bool}(x + 84)
    f === :ConfigViewportsNoTaskBarIcon && return Ptr{Bool}(x + 85)
    f === :ConfigViewportsNoDecoration && return Ptr{Bool}(x + 86)
    f === :ConfigViewportsNoDefaultParent && return Ptr{Bool}(x + 87)
    f === :MouseDrawCursor && return Ptr{Bool}(x + 88)
    f === :ConfigMacOSXBehaviors && return Ptr{Bool}(x + 89)
    f === :ConfigNavSwapGamepadButtons && return Ptr{Bool}(x + 90)
    f === :ConfigInputTrickleEventQueue && return Ptr{Bool}(x + 91)
    f === :ConfigInputTextCursorBlink && return Ptr{Bool}(x + 92)
    f === :ConfigInputTextEnterKeepActive && return Ptr{Bool}(x + 93)
    f === :ConfigDragClickToInputText && return Ptr{Bool}(x + 94)
    f === :ConfigWindowsResizeFromEdges && return Ptr{Bool}(x + 95)
    f === :ConfigWindowsMoveFromTitleBarOnly && return Ptr{Bool}(x + 96)
    f === :ConfigMemoryCompactTimer && return Ptr{Cfloat}(x + 100)
    f === :MouseDoubleClickTime && return Ptr{Cfloat}(x + 104)
    f === :MouseDoubleClickMaxDist && return Ptr{Cfloat}(x + 108)
    f === :MouseDragThreshold && return Ptr{Cfloat}(x + 112)
    f === :KeyRepeatDelay && return Ptr{Cfloat}(x + 116)
    f === :KeyRepeatRate && return Ptr{Cfloat}(x + 120)
    f === :ConfigDebugIsDebuggerPresent && return Ptr{Bool}(x + 124)
    f === :ConfigDebugBeginReturnValueOnce && return Ptr{Bool}(x + 125)
    f === :ConfigDebugBeginReturnValueLoop && return Ptr{Bool}(x + 126)
    f === :ConfigDebugIgnoreFocusLoss && return Ptr{Bool}(x + 127)
    f === :ConfigDebugIniSettings && return Ptr{Bool}(x + 128)
    f === :BackendPlatformName && return Ptr{Ptr{Cchar}}(x + 136)
    f === :BackendRendererName && return Ptr{Ptr{Cchar}}(x + 144)
    f === :BackendPlatformUserData && return Ptr{Ptr{Cvoid}}(x + 152)
    f === :BackendRendererUserData && return Ptr{Ptr{Cvoid}}(x + 160)
    f === :BackendLanguageUserData && return Ptr{Ptr{Cvoid}}(x + 168)
    f === :GetClipboardTextFn && return Ptr{Ptr{Cvoid}}(x + 176)
    f === :SetClipboardTextFn && return Ptr{Ptr{Cvoid}}(x + 184)
    f === :ClipboardUserData && return Ptr{Ptr{Cvoid}}(x + 192)
    f === :PlatformOpenInShellFn && return Ptr{Ptr{Cvoid}}(x + 200)
    f === :PlatformOpenInShellUserData && return Ptr{Ptr{Cvoid}}(x + 208)
    f === :PlatformSetImeDataFn && return Ptr{Ptr{Cvoid}}(x + 216)
    f === :PlatformLocaleDecimalPoint && return Ptr{ImWchar}(x + 224)
    f === :WantCaptureMouse && return Ptr{Bool}(x + 226)
    f === :WantCaptureKeyboard && return Ptr{Bool}(x + 227)
    f === :WantTextInput && return Ptr{Bool}(x + 228)
    f === :WantSetMousePos && return Ptr{Bool}(x + 229)
    f === :WantSaveIniSettings && return Ptr{Bool}(x + 230)
    f === :NavActive && return Ptr{Bool}(x + 231)
    f === :NavVisible && return Ptr{Bool}(x + 232)
    f === :Framerate && return Ptr{Cfloat}(x + 236)
    f === :MetricsRenderVertices && return Ptr{Cint}(x + 240)
    f === :MetricsRenderIndices && return Ptr{Cint}(x + 244)
    f === :MetricsRenderWindows && return Ptr{Cint}(x + 248)
    f === :MetricsActiveWindows && return Ptr{Cint}(x + 252)
    f === :MouseDelta && return Ptr{ImVec2}(x + 256)
    f === :Ctx && return Ptr{Ptr{ImGuiContext}}(x + 264)
    f === :MousePos && return Ptr{ImVec2}(x + 272)
    f === :MouseDown && return Ptr{NTuple{5, Bool}}(x + 280)
    f === :MouseWheel && return Ptr{Cfloat}(x + 288)
    f === :MouseWheelH && return Ptr{Cfloat}(x + 292)
    f === :MouseSource && return Ptr{ImGuiMouseSource}(x + 296)
    f === :MouseHoveredViewport && return Ptr{ImGuiID}(x + 300)
    f === :KeyCtrl && return Ptr{Bool}(x + 304)
    f === :KeyShift && return Ptr{Bool}(x + 305)
    f === :KeyAlt && return Ptr{Bool}(x + 306)
    f === :KeySuper && return Ptr{Bool}(x + 307)
    f === :KeyMods && return Ptr{ImGuiKeyChord}(x + 308)
    f === :KeysData && return Ptr{NTuple{154, ImGuiKeyData}}(x + 312)
    f === :WantCaptureMouseUnlessPopupClose && return Ptr{Bool}(x + 2776)
    f === :MousePosPrev && return Ptr{ImVec2}(x + 2780)
    f === :MouseClickedPos && return Ptr{NTuple{5, ImVec2}}(x + 2788)
    f === :MouseClickedTime && return Ptr{NTuple{5, Cdouble}}(x + 2832)
    f === :MouseClicked && return Ptr{NTuple{5, Bool}}(x + 2872)
    f === :MouseDoubleClicked && return Ptr{NTuple{5, Bool}}(x + 2877)
    f === :MouseClickedCount && return Ptr{NTuple{5, ImU16}}(x + 2882)
    f === :MouseClickedLastCount && return Ptr{NTuple{5, ImU16}}(x + 2892)
    f === :MouseReleased && return Ptr{NTuple{5, Bool}}(x + 2902)
    f === :MouseDownOwned && return Ptr{NTuple{5, Bool}}(x + 2907)
    f === :MouseDownOwnedUnlessPopupClose && return Ptr{NTuple{5, Bool}}(x + 2912)
    f === :MouseWheelRequestAxisSwap && return Ptr{Bool}(x + 2917)
    f === :MouseCtrlLeftAsRightClick && return Ptr{Bool}(x + 2918)
    f === :MouseDownDuration && return Ptr{NTuple{5, Cfloat}}(x + 2920)
    f === :MouseDownDurationPrev && return Ptr{NTuple{5, Cfloat}}(x + 2940)
    f === :MouseDragMaxDistanceAbs && return Ptr{NTuple{5, ImVec2}}(x + 2960)
    f === :MouseDragMaxDistanceSqr && return Ptr{NTuple{5, Cfloat}}(x + 3000)
    f === :PenPressure && return Ptr{Cfloat}(x + 3020)
    f === :AppFocusLost && return Ptr{Bool}(x + 3024)
    f === :AppAcceptingEvents && return Ptr{Bool}(x + 3025)
    f === :BackendUsingLegacyKeyArrays && return Ptr{ImS8}(x + 3026)
    f === :BackendUsingLegacyNavInputArray && return Ptr{Bool}(x + 3027)
    f === :InputQueueSurrogate && return Ptr{ImWchar16}(x + 3028)
    f === :InputQueueCharacters && return Ptr{ImVector_ImWchar}(x + 3032)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{ImGuiIO}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct ImGuiPlatformMonitor
    MainPos::ImVec2
    MainSize::ImVec2
    WorkPos::ImVec2
    WorkSize::ImVec2
    DpiScale::Cfloat
    PlatformHandle::Ptr{Cvoid}
end
function Base.getproperty(x::Ptr{ImGuiPlatformMonitor}, f::Symbol)
    f === :MainPos && return Ptr{ImVec2}(x + 0)
    f === :MainSize && return Ptr{ImVec2}(x + 8)
    f === :WorkPos && return Ptr{ImVec2}(x + 16)
    f === :WorkSize && return Ptr{ImVec2}(x + 24)
    f === :DpiScale && return Ptr{Cfloat}(x + 32)
    f === :PlatformHandle && return Ptr{Ptr{Cvoid}}(x + 40)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{ImGuiPlatformMonitor}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct ImVector_ImGuiPlatformMonitor
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiPlatformMonitor}
end

struct ImVector_ImGuiViewportPtr
    Size::Cint
    Capacity::Cint
    Data::Ptr{Ptr{ImGuiViewport}}
end

struct ImGuiPlatformIO
    Platform_CreateWindow::Ptr{Cvoid}
    Platform_DestroyWindow::Ptr{Cvoid}
    Platform_ShowWindow::Ptr{Cvoid}
    Platform_SetWindowPos::Ptr{Cvoid}
    Platform_GetWindowPos::Ptr{Cvoid}
    Platform_SetWindowSize::Ptr{Cvoid}
    Platform_GetWindowSize::Ptr{Cvoid}
    Platform_SetWindowFocus::Ptr{Cvoid}
    Platform_GetWindowFocus::Ptr{Cvoid}
    Platform_GetWindowMinimized::Ptr{Cvoid}
    Platform_SetWindowTitle::Ptr{Cvoid}
    Platform_SetWindowAlpha::Ptr{Cvoid}
    Platform_UpdateWindow::Ptr{Cvoid}
    Platform_RenderWindow::Ptr{Cvoid}
    Platform_SwapBuffers::Ptr{Cvoid}
    Platform_GetWindowDpiScale::Ptr{Cvoid}
    Platform_OnChangedViewport::Ptr{Cvoid}
    Platform_CreateVkSurface::Ptr{Cvoid}
    Renderer_CreateWindow::Ptr{Cvoid}
    Renderer_DestroyWindow::Ptr{Cvoid}
    Renderer_SetWindowSize::Ptr{Cvoid}
    Renderer_RenderWindow::Ptr{Cvoid}
    Renderer_SwapBuffers::Ptr{Cvoid}
    Monitors::ImVector_ImGuiPlatformMonitor
    Viewports::ImVector_ImGuiViewportPtr
end
function Base.getproperty(x::Ptr{ImGuiPlatformIO}, f::Symbol)
    f === :Platform_CreateWindow && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :Platform_DestroyWindow && return Ptr{Ptr{Cvoid}}(x + 8)
    f === :Platform_ShowWindow && return Ptr{Ptr{Cvoid}}(x + 16)
    f === :Platform_SetWindowPos && return Ptr{Ptr{Cvoid}}(x + 24)
    f === :Platform_GetWindowPos && return Ptr{Ptr{Cvoid}}(x + 32)
    f === :Platform_SetWindowSize && return Ptr{Ptr{Cvoid}}(x + 40)
    f === :Platform_GetWindowSize && return Ptr{Ptr{Cvoid}}(x + 48)
    f === :Platform_SetWindowFocus && return Ptr{Ptr{Cvoid}}(x + 56)
    f === :Platform_GetWindowFocus && return Ptr{Ptr{Cvoid}}(x + 64)
    f === :Platform_GetWindowMinimized && return Ptr{Ptr{Cvoid}}(x + 72)
    f === :Platform_SetWindowTitle && return Ptr{Ptr{Cvoid}}(x + 80)
    f === :Platform_SetWindowAlpha && return Ptr{Ptr{Cvoid}}(x + 88)
    f === :Platform_UpdateWindow && return Ptr{Ptr{Cvoid}}(x + 96)
    f === :Platform_RenderWindow && return Ptr{Ptr{Cvoid}}(x + 104)
    f === :Platform_SwapBuffers && return Ptr{Ptr{Cvoid}}(x + 112)
    f === :Platform_GetWindowDpiScale && return Ptr{Ptr{Cvoid}}(x + 120)
    f === :Platform_OnChangedViewport && return Ptr{Ptr{Cvoid}}(x + 128)
    f === :Platform_CreateVkSurface && return Ptr{Ptr{Cvoid}}(x + 136)
    f === :Renderer_CreateWindow && return Ptr{Ptr{Cvoid}}(x + 144)
    f === :Renderer_DestroyWindow && return Ptr{Ptr{Cvoid}}(x + 152)
    f === :Renderer_SetWindowSize && return Ptr{Ptr{Cvoid}}(x + 160)
    f === :Renderer_RenderWindow && return Ptr{Ptr{Cvoid}}(x + 168)
    f === :Renderer_SwapBuffers && return Ptr{Ptr{Cvoid}}(x + 176)
    f === :Monitors && return Ptr{ImVector_ImGuiPlatformMonitor}(x + 184)
    f === :Viewports && return Ptr{ImVector_ImGuiViewportPtr}(x + 200)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{ImGuiPlatformIO}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


@cenum ImGuiDir::Int32 begin
    ImGuiDir_None = -1
    ImGuiDir_Left = 0
    ImGuiDir_Right = 1
    ImGuiDir_Up = 2
    ImGuiDir_Down = 3
    ImGuiDir_COUNT = 4
end

const ImGuiHoveredFlags = Cint

struct ImGuiStyle
    Alpha::Cfloat
    DisabledAlpha::Cfloat
    WindowPadding::ImVec2
    WindowRounding::Cfloat
    WindowBorderSize::Cfloat
    WindowMinSize::ImVec2
    WindowTitleAlign::ImVec2
    WindowMenuButtonPosition::ImGuiDir
    ChildRounding::Cfloat
    ChildBorderSize::Cfloat
    PopupRounding::Cfloat
    PopupBorderSize::Cfloat
    FramePadding::ImVec2
    FrameRounding::Cfloat
    FrameBorderSize::Cfloat
    ItemSpacing::ImVec2
    ItemInnerSpacing::ImVec2
    CellPadding::ImVec2
    TouchExtraPadding::ImVec2
    IndentSpacing::Cfloat
    ColumnsMinSpacing::Cfloat
    ScrollbarSize::Cfloat
    ScrollbarRounding::Cfloat
    GrabMinSize::Cfloat
    GrabRounding::Cfloat
    LogSliderDeadzone::Cfloat
    TabRounding::Cfloat
    TabBorderSize::Cfloat
    TabMinWidthForCloseButton::Cfloat
    TabBarBorderSize::Cfloat
    TabBarOverlineSize::Cfloat
    TableAngledHeadersAngle::Cfloat
    TableAngledHeadersTextAlign::ImVec2
    ColorButtonPosition::ImGuiDir
    ButtonTextAlign::ImVec2
    SelectableTextAlign::ImVec2
    SeparatorTextBorderSize::Cfloat
    SeparatorTextAlign::ImVec2
    SeparatorTextPadding::ImVec2
    DisplayWindowPadding::ImVec2
    DisplaySafeAreaPadding::ImVec2
    DockingSeparatorSize::Cfloat
    MouseCursorScale::Cfloat
    AntiAliasedLines::Bool
    AntiAliasedLinesUseTex::Bool
    AntiAliasedFill::Bool
    CurveTessellationTol::Cfloat
    CircleTessellationMaxError::Cfloat
    Colors::NTuple{58, ImVec4}
    HoverStationaryDelay::Cfloat
    HoverDelayShort::Cfloat
    HoverDelayNormal::Cfloat
    HoverFlagsForTooltipMouse::ImGuiHoveredFlags
    HoverFlagsForTooltipNav::ImGuiHoveredFlags
end
function Base.getproperty(x::Ptr{ImGuiStyle}, f::Symbol)
    f === :Alpha && return Ptr{Cfloat}(x + 0)
    f === :DisabledAlpha && return Ptr{Cfloat}(x + 4)
    f === :WindowPadding && return Ptr{ImVec2}(x + 8)
    f === :WindowRounding && return Ptr{Cfloat}(x + 16)
    f === :WindowBorderSize && return Ptr{Cfloat}(x + 20)
    f === :WindowMinSize && return Ptr{ImVec2}(x + 24)
    f === :WindowTitleAlign && return Ptr{ImVec2}(x + 32)
    f === :WindowMenuButtonPosition && return Ptr{ImGuiDir}(x + 40)
    f === :ChildRounding && return Ptr{Cfloat}(x + 44)
    f === :ChildBorderSize && return Ptr{Cfloat}(x + 48)
    f === :PopupRounding && return Ptr{Cfloat}(x + 52)
    f === :PopupBorderSize && return Ptr{Cfloat}(x + 56)
    f === :FramePadding && return Ptr{ImVec2}(x + 60)
    f === :FrameRounding && return Ptr{Cfloat}(x + 68)
    f === :FrameBorderSize && return Ptr{Cfloat}(x + 72)
    f === :ItemSpacing && return Ptr{ImVec2}(x + 76)
    f === :ItemInnerSpacing && return Ptr{ImVec2}(x + 84)
    f === :CellPadding && return Ptr{ImVec2}(x + 92)
    f === :TouchExtraPadding && return Ptr{ImVec2}(x + 100)
    f === :IndentSpacing && return Ptr{Cfloat}(x + 108)
    f === :ColumnsMinSpacing && return Ptr{Cfloat}(x + 112)
    f === :ScrollbarSize && return Ptr{Cfloat}(x + 116)
    f === :ScrollbarRounding && return Ptr{Cfloat}(x + 120)
    f === :GrabMinSize && return Ptr{Cfloat}(x + 124)
    f === :GrabRounding && return Ptr{Cfloat}(x + 128)
    f === :LogSliderDeadzone && return Ptr{Cfloat}(x + 132)
    f === :TabRounding && return Ptr{Cfloat}(x + 136)
    f === :TabBorderSize && return Ptr{Cfloat}(x + 140)
    f === :TabMinWidthForCloseButton && return Ptr{Cfloat}(x + 144)
    f === :TabBarBorderSize && return Ptr{Cfloat}(x + 148)
    f === :TabBarOverlineSize && return Ptr{Cfloat}(x + 152)
    f === :TableAngledHeadersAngle && return Ptr{Cfloat}(x + 156)
    f === :TableAngledHeadersTextAlign && return Ptr{ImVec2}(x + 160)
    f === :ColorButtonPosition && return Ptr{ImGuiDir}(x + 168)
    f === :ButtonTextAlign && return Ptr{ImVec2}(x + 172)
    f === :SelectableTextAlign && return Ptr{ImVec2}(x + 180)
    f === :SeparatorTextBorderSize && return Ptr{Cfloat}(x + 188)
    f === :SeparatorTextAlign && return Ptr{ImVec2}(x + 192)
    f === :SeparatorTextPadding && return Ptr{ImVec2}(x + 200)
    f === :DisplayWindowPadding && return Ptr{ImVec2}(x + 208)
    f === :DisplaySafeAreaPadding && return Ptr{ImVec2}(x + 216)
    f === :DockingSeparatorSize && return Ptr{Cfloat}(x + 224)
    f === :MouseCursorScale && return Ptr{Cfloat}(x + 228)
    f === :AntiAliasedLines && return Ptr{Bool}(x + 232)
    f === :AntiAliasedLinesUseTex && return Ptr{Bool}(x + 233)
    f === :AntiAliasedFill && return Ptr{Bool}(x + 234)
    f === :CurveTessellationTol && return Ptr{Cfloat}(x + 236)
    f === :CircleTessellationMaxError && return Ptr{Cfloat}(x + 240)
    f === :Colors && return Ptr{NTuple{58, ImVec4}}(x + 244)
    f === :HoverStationaryDelay && return Ptr{Cfloat}(x + 1172)
    f === :HoverDelayShort && return Ptr{Cfloat}(x + 1176)
    f === :HoverDelayNormal && return Ptr{Cfloat}(x + 1180)
    f === :HoverFlagsForTooltipMouse && return Ptr{ImGuiHoveredFlags}(x + 1184)
    f === :HoverFlagsForTooltipNav && return Ptr{ImGuiHoveredFlags}(x + 1188)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{ImGuiStyle}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


@cenum ImGuiInputEventType::UInt32 begin
    ImGuiInputEventType_None = 0
    ImGuiInputEventType_MousePos = 1
    ImGuiInputEventType_MouseWheel = 2
    ImGuiInputEventType_MouseButton = 3
    ImGuiInputEventType_MouseViewport = 4
    ImGuiInputEventType_Key = 5
    ImGuiInputEventType_Text = 6
    ImGuiInputEventType_Focus = 7
    ImGuiInputEventType_COUNT = 8
end

@cenum ImGuiInputSource::UInt32 begin
    ImGuiInputSource_None = 0
    ImGuiInputSource_Mouse = 1
    ImGuiInputSource_Keyboard = 2
    ImGuiInputSource_Gamepad = 3
    ImGuiInputSource_COUNT = 4
end

struct ImGuiInputEvent
    data::NTuple{28, UInt8}
end

function Base.getproperty(x::Ptr{ImGuiInputEvent}, f::Symbol)
    f === :Type && return Ptr{ImGuiInputEventType}(x + 0)
    f === :Source && return Ptr{ImGuiInputSource}(x + 4)
    f === :EventId && return Ptr{ImU32}(x + 8)
    f === :MousePos && return Ptr{ImGuiInputEventMousePos}(x + 12)
    f === :MouseWheel && return Ptr{ImGuiInputEventMouseWheel}(x + 12)
    f === :MouseButton && return Ptr{ImGuiInputEventMouseButton}(x + 12)
    f === :MouseViewport && return Ptr{ImGuiInputEventMouseViewport}(x + 12)
    f === :Key && return Ptr{ImGuiInputEventKey}(x + 12)
    f === :Text && return Ptr{ImGuiInputEventText}(x + 12)
    f === :AppFocused && return Ptr{ImGuiInputEventAppFocused}(x + 12)
    f === :AddedByTestEngine && return Ptr{Bool}(x + 24)
    return getfield(x, f)
end

function Base.getproperty(x::ImGuiInputEvent, f::Symbol)
    r = Ref{ImGuiInputEvent}(x)
    ptr = Base.unsafe_convert(Ptr{ImGuiInputEvent}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{ImGuiInputEvent}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct ImVector_ImGuiInputEvent
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiInputEvent}
end

struct ImVector_ImGuiWindowPtr
    Size::Cint
    Capacity::Cint
    Data::Ptr{Ptr{Cvoid}} # Data::Ptr{Ptr{ImGuiWindow}}
end

function Base.getproperty(x::ImVector_ImGuiWindowPtr, f::Symbol)
    f === :Data && return Ptr{Ptr{ImGuiWindow}}(getfield(x, f))
    return getfield(x, f)
end

const ImGuiWindowFlags = Cint

const ImGuiChildFlags = Cint

const ImGuiTabItemFlags = Cint

const ImGuiDockNodeFlags = Cint

struct ImGuiWindowClass
    ClassId::ImGuiID
    ParentViewportId::ImGuiID
    FocusRouteParentWindowId::ImGuiID
    ViewportFlagsOverrideSet::ImGuiViewportFlags
    ViewportFlagsOverrideClear::ImGuiViewportFlags
    TabItemFlagsOverrideSet::ImGuiTabItemFlags
    DockNodeFlagsOverrideSet::ImGuiDockNodeFlags
    DockingAlwaysTabBar::Bool
    DockingAllowUnclassed::Bool
end

struct ImDrawDataBuilder
    Layers::NTuple{2, Ptr{ImVector_ImDrawListPtr}}
    LayerData1::ImVector_ImDrawListPtr
end

struct ImGuiViewportP
    _ImGuiViewport::ImGuiViewport
    Window::Ptr{Cvoid} # Window::Ptr{ImGuiWindow}
    Idx::Cint
    LastFrameActive::Cint
    LastFocusedStampCount::Cint
    LastNameHash::ImGuiID
    LastPos::ImVec2
    Alpha::Cfloat
    LastAlpha::Cfloat
    LastFocusedHadNavWindow::Bool
    PlatformMonitor::Cshort
    BgFgDrawListsLastFrame::NTuple{2, Cint}
    BgFgDrawLists::NTuple{2, Ptr{ImDrawList}}
    DrawDataP::ImDrawData
    DrawDataBuilder::ImDrawDataBuilder
    LastPlatformPos::ImVec2
    LastPlatformSize::ImVec2
    LastRendererSize::ImVec2
    WorkOffsetMin::ImVec2
    WorkOffsetMax::ImVec2
    BuildWorkOffsetMin::ImVec2
    BuildWorkOffsetMax::ImVec2
end

function Base.getproperty(x::ImGuiViewportP, f::Symbol)
    f === :Window && return Ptr{ImGuiWindow}(getfield(x, f))
    return getfield(x, f)
end

const ImGuiCond = Cint

struct ImVector_ImGuiID
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiID}
end

struct ImVec1
    x::Cfloat
end

@cenum ImGuiNavLayer::UInt32 begin
    ImGuiNavLayer_Main = 0
    ImGuiNavLayer_Menu = 1
    ImGuiNavLayer_COUNT = 2
end

struct ImGuiMenuColumns
    TotalWidth::ImU32
    NextTotalWidth::ImU32
    Spacing::ImU16
    OffsetIcon::ImU16
    OffsetLabel::ImU16
    OffsetShortcut::ImU16
    OffsetMark::ImU16
    Widths::NTuple{4, ImU16}
end

struct ImGuiStoragePair
    data::NTuple{16, UInt8}
end

function Base.getproperty(x::Ptr{ImGuiStoragePair}, f::Symbol)
    f === :key && return Ptr{ImGuiID}(x + 0)
    f === :val_i && return Ptr{Cint}(x + 8)
    f === :val_f && return Ptr{Cfloat}(x + 8)
    f === :val_p && return Ptr{Ptr{Cvoid}}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::ImGuiStoragePair, f::Symbol)
    r = Ref{ImGuiStoragePair}(x)
    ptr = Base.unsafe_convert(Ptr{ImGuiStoragePair}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{ImGuiStoragePair}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct ImVector_ImGuiStoragePair
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiStoragePair}
end

struct ImGuiStorage
    Data::ImVector_ImGuiStoragePair
end

const ImGuiOldColumnFlags = Cint

struct ImRect
    Min::ImVec2
    Max::ImVec2
end

struct ImGuiOldColumnData
    OffsetNorm::Cfloat
    OffsetNormBeforeResize::Cfloat
    Flags::ImGuiOldColumnFlags
    ClipRect::ImRect
end

struct ImVector_ImGuiOldColumnData
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiOldColumnData}
end

struct ImGuiOldColumns
    ID::ImGuiID
    Flags::ImGuiOldColumnFlags
    IsFirstFrame::Bool
    IsBeingResized::Bool
    Current::Cint
    Count::Cint
    OffMinX::Cfloat
    OffMaxX::Cfloat
    LineMinY::Cfloat
    LineMaxY::Cfloat
    HostCursorPosY::Cfloat
    HostCursorMaxPosX::Cfloat
    HostInitialClipRect::ImRect
    HostBackupClipRect::ImRect
    HostBackupParentWorkRect::ImRect
    Columns::ImVector_ImGuiOldColumnData
    Splitter::ImDrawListSplitter
end

const ImGuiLayoutType = Cint

struct ImGuiWindowTempData
    CursorPos::ImVec2
    CursorPosPrevLine::ImVec2
    CursorStartPos::ImVec2
    CursorMaxPos::ImVec2
    IdealMaxPos::ImVec2
    CurrLineSize::ImVec2
    PrevLineSize::ImVec2
    CurrLineTextBaseOffset::Cfloat
    PrevLineTextBaseOffset::Cfloat
    IsSameLine::Bool
    IsSetPos::Bool
    Indent::ImVec1
    ColumnsOffset::ImVec1
    GroupOffset::ImVec1
    CursorStartPosLossyness::ImVec2
    NavLayerCurrent::ImGuiNavLayer
    NavLayersActiveMask::Cshort
    NavLayersActiveMaskNext::Cshort
    NavIsScrollPushableX::Bool
    NavHideHighlightOneFrame::Bool
    NavWindowHasScrollY::Bool
    MenuBarAppending::Bool
    MenuBarOffset::ImVec2
    MenuColumns::ImGuiMenuColumns
    TreeDepth::Cint
    TreeHasStackDataDepthMask::ImU32
    ChildWindows::ImVector_ImGuiWindowPtr
    StateStorage::Ptr{ImGuiStorage}
    CurrentColumns::Ptr{ImGuiOldColumns}
    CurrentTableIdx::Cint
    LayoutType::ImGuiLayoutType
    ParentLayoutType::ImGuiLayoutType
    ModalDimBgColor::ImU32
    ItemWidth::Cfloat
    TextWrapPos::Cfloat
    ItemWidthStack::ImVector_float
    TextWrapPosStack::ImVector_float
end

struct ImVec2ih
    x::Cshort
    y::Cshort
end

struct ImVector_ImGuiOldColumns
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiOldColumns}
end

struct ImGuiWindowDockStyle
    Colors::NTuple{8, ImU32}
end

@cenum ImGuiDockNodeState::UInt32 begin
    ImGuiDockNodeState_Unknown = 0
    ImGuiDockNodeState_HostWindowHiddenBecauseSingleWindow = 1
    ImGuiDockNodeState_HostWindowHiddenBecauseWindowsAreResizing = 2
    ImGuiDockNodeState_HostWindowVisible = 3
end

const ImS32 = Cint

const ImS16 = Cshort

struct ImGuiTabItem
    ID::ImGuiID
    Flags::ImGuiTabItemFlags
    Window::Ptr{Cvoid} # Window::Ptr{ImGuiWindow}
    LastFrameVisible::Cint
    LastFrameSelected::Cint
    Offset::Cfloat
    Width::Cfloat
    ContentWidth::Cfloat
    RequestedWidth::Cfloat
    NameOffset::ImS32
    BeginOrder::ImS16
    IndexDuringLayout::ImS16
    WantClose::Bool
end

function Base.getproperty(x::ImGuiTabItem, f::Symbol)
    f === :Window && return Ptr{ImGuiWindow}(getfield(x, f))
    return getfield(x, f)
end

struct ImVector_ImGuiTabItem
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiTabItem}
end

const ImGuiTabBarFlags = Cint

struct ImVector_char
    Size::Cint
    Capacity::Cint
    Data::Ptr{Cchar}
end

struct ImGuiTextBuffer
    Buf::ImVector_char
end

struct ImGuiTabBar
    Tabs::ImVector_ImGuiTabItem
    Flags::ImGuiTabBarFlags
    ID::ImGuiID
    SelectedTabId::ImGuiID
    NextSelectedTabId::ImGuiID
    VisibleTabId::ImGuiID
    CurrFrameVisible::Cint
    PrevFrameVisible::Cint
    BarRect::ImRect
    CurrTabsContentsHeight::Cfloat
    PrevTabsContentsHeight::Cfloat
    WidthAllTabs::Cfloat
    WidthAllTabsIdeal::Cfloat
    ScrollingAnim::Cfloat
    ScrollingTarget::Cfloat
    ScrollingTargetDistToVisibility::Cfloat
    ScrollingSpeed::Cfloat
    ScrollingRectMinX::Cfloat
    ScrollingRectMaxX::Cfloat
    SeparatorMinX::Cfloat
    SeparatorMaxX::Cfloat
    ReorderRequestTabId::ImGuiID
    ReorderRequestOffset::ImS16
    BeginCount::ImS8
    WantLayout::Bool
    VisibleTabWasSubmitted::Bool
    TabsAddedNew::Bool
    TabsActiveCount::ImS16
    LastTabItemIdx::ImS16
    ItemSpacingY::Cfloat
    FramePadding::ImVec2
    BackupCursorPos::ImVec2
    TabsNames::ImGuiTextBuffer
end

@cenum ImGuiAxis::Int32 begin
    ImGuiAxis_None = -1
    ImGuiAxis_X = 0
    ImGuiAxis_Y = 1
end

const ImGuiDataAuthority = Cint

struct ImGuiDockNode
    data::NTuple{208, UInt8}
end

function Base.getproperty(x::Ptr{ImGuiDockNode}, f::Symbol)
    f === :ID && return Ptr{ImGuiID}(x + 0)
    f === :SharedFlags && return Ptr{ImGuiDockNodeFlags}(x + 4)
    f === :LocalFlags && return Ptr{ImGuiDockNodeFlags}(x + 8)
    f === :LocalFlagsInWindows && return Ptr{ImGuiDockNodeFlags}(x + 12)
    f === :MergedFlags && return Ptr{ImGuiDockNodeFlags}(x + 16)
    f === :State && return Ptr{ImGuiDockNodeState}(x + 20)
    f === :ParentNode && return Ptr{Ptr{ImGuiDockNode}}(x + 24)
    f === :ChildNodes && return Ptr{NTuple{2, Ptr{ImGuiDockNode}}}(x + 32)
    f === :Windows && return Ptr{ImVector_ImGuiWindowPtr}(x + 48)
    f === :TabBar && return Ptr{Ptr{ImGuiTabBar}}(x + 64)
    f === :Pos && return Ptr{ImVec2}(x + 72)
    f === :Size && return Ptr{ImVec2}(x + 80)
    f === :SizeRef && return Ptr{ImVec2}(x + 88)
    f === :SplitAxis && return Ptr{ImGuiAxis}(x + 96)
    f === :WindowClass && return Ptr{ImGuiWindowClass}(x + 100)
    f === :LastBgColor && return Ptr{ImU32}(x + 132)
    f === :HostWindow && return Ptr{Ptr{ImGuiWindow}}(x + 136)
    f === :VisibleWindow && return Ptr{Ptr{ImGuiWindow}}(x + 144)
    f === :CentralNode && return Ptr{Ptr{ImGuiDockNode}}(x + 152)
    f === :OnlyNodeWithWindows && return Ptr{Ptr{ImGuiDockNode}}(x + 160)
    f === :CountNodeWithWindows && return Ptr{Cint}(x + 168)
    f === :LastFrameAlive && return Ptr{Cint}(x + 172)
    f === :LastFrameActive && return Ptr{Cint}(x + 176)
    f === :LastFrameFocused && return Ptr{Cint}(x + 180)
    f === :LastFocusedNodeId && return Ptr{ImGuiID}(x + 184)
    f === :SelectedTabId && return Ptr{ImGuiID}(x + 188)
    f === :WantCloseTabId && return Ptr{ImGuiID}(x + 192)
    f === :RefViewportId && return Ptr{ImGuiID}(x + 196)
    f === :AuthorityForPos && return (Ptr{ImGuiDataAuthority}(x + 200), 0, 3)
    f === :AuthorityForSize && return (Ptr{ImGuiDataAuthority}(x + 200), 3, 3)
    f === :AuthorityForViewport && return (Ptr{ImGuiDataAuthority}(x + 200), 6, 3)
    f === :IsVisible && return (Ptr{Bool}(x + 200), 9, 1)
    f === :IsFocused && return (Ptr{Bool}(x + 200), 10, 1)
    f === :IsBgDrawnThisFrame && return (Ptr{Bool}(x + 200), 11, 1)
    f === :HasCloseButton && return (Ptr{Bool}(x + 200), 12, 1)
    f === :HasWindowMenuButton && return (Ptr{Bool}(x + 200), 13, 1)
    f === :HasCentralNodeChild && return (Ptr{Bool}(x + 200), 14, 1)
    f === :WantCloseAll && return (Ptr{Bool}(x + 200), 15, 1)
    f === :WantLockSizeOnce && return (Ptr{Bool}(x + 200), 16, 1)
    f === :WantMouseMove && return (Ptr{Bool}(x + 200), 17, 1)
    f === :WantHiddenTabBarUpdate && return (Ptr{Bool}(x + 200), 18, 1)
    f === :WantHiddenTabBarToggle && return (Ptr{Bool}(x + 200), 19, 1)
    return getfield(x, f)
end

function Base.getproperty(x::ImGuiDockNode, f::Symbol)
    r = Ref{ImGuiDockNode}(x)
    ptr = Base.unsafe_convert(Ptr{ImGuiDockNode}, r)
    fptr = getproperty(ptr, f)
    begin
        if fptr isa Ptr
            return GC.@preserve(r, unsafe_load(fptr))
        else
            (baseptr, offset, width) = fptr
            ty = eltype(baseptr)
            baseptr32 = convert(Ptr{UInt32}, baseptr)
            u64 = GC.@preserve(r, unsafe_load(baseptr32))
            if offset + width > 32
                u64 |= GC.@preserve(r, unsafe_load(baseptr32 + 4)) << 32
            end
            u64 = u64 >> offset & (1 << width - 1)
            return u64 % ty
        end
    end
end

function Base.setproperty!(x::Ptr{ImGuiDockNode}, f::Symbol, v)
    fptr = getproperty(x, f)
    if fptr isa Ptr
        unsafe_store!(getproperty(x, f), v)
    else
        (baseptr, offset, width) = fptr
        baseptr32 = convert(Ptr{UInt32}, baseptr)
        u64 = unsafe_load(baseptr32)
        straddle = offset + width > 32
        if straddle
            u64 |= unsafe_load(baseptr32 + 4) << 32
        end
        mask = 1 << width - 1
        u64 &= ~(mask << offset)
        u64 |= (unsigned(v) & mask) << offset
        unsafe_store!(baseptr32, u64 & typemax(UInt32))
        if straddle
            unsafe_store!(baseptr32 + 4, u64 >> 32)
        end
    end
end

const ImGuiItemStatusFlags = Cint

struct ImGuiWindow
    data::NTuple{1168, UInt8}
end

function Base.getproperty(x::Ptr{ImGuiWindow}, f::Symbol)
    f === :Ctx && return Ptr{Ptr{ImGuiContext}}(x + 0)
    f === :Name && return Ptr{Ptr{Cchar}}(x + 8)
    f === :ID && return Ptr{ImGuiID}(x + 16)
    f === :Flags && return Ptr{ImGuiWindowFlags}(x + 20)
    f === :FlagsPreviousFrame && return Ptr{ImGuiWindowFlags}(x + 24)
    f === :ChildFlags && return Ptr{ImGuiChildFlags}(x + 28)
    f === :WindowClass && return Ptr{ImGuiWindowClass}(x + 32)
    f === :Viewport && return Ptr{Ptr{ImGuiViewportP}}(x + 64)
    f === :ViewportId && return Ptr{ImGuiID}(x + 72)
    f === :ViewportPos && return Ptr{ImVec2}(x + 76)
    f === :ViewportAllowPlatformMonitorExtend && return Ptr{Cint}(x + 84)
    f === :Pos && return Ptr{ImVec2}(x + 88)
    f === :Size && return Ptr{ImVec2}(x + 96)
    f === :SizeFull && return Ptr{ImVec2}(x + 104)
    f === :ContentSize && return Ptr{ImVec2}(x + 112)
    f === :ContentSizeIdeal && return Ptr{ImVec2}(x + 120)
    f === :ContentSizeExplicit && return Ptr{ImVec2}(x + 128)
    f === :WindowPadding && return Ptr{ImVec2}(x + 136)
    f === :WindowRounding && return Ptr{Cfloat}(x + 144)
    f === :WindowBorderSize && return Ptr{Cfloat}(x + 148)
    f === :TitleBarHeight && return Ptr{Cfloat}(x + 152)
    f === :MenuBarHeight && return Ptr{Cfloat}(x + 156)
    f === :DecoOuterSizeX1 && return Ptr{Cfloat}(x + 160)
    f === :DecoOuterSizeY1 && return Ptr{Cfloat}(x + 164)
    f === :DecoOuterSizeX2 && return Ptr{Cfloat}(x + 168)
    f === :DecoOuterSizeY2 && return Ptr{Cfloat}(x + 172)
    f === :DecoInnerSizeX1 && return Ptr{Cfloat}(x + 176)
    f === :DecoInnerSizeY1 && return Ptr{Cfloat}(x + 180)
    f === :NameBufLen && return Ptr{Cint}(x + 184)
    f === :MoveId && return Ptr{ImGuiID}(x + 188)
    f === :TabId && return Ptr{ImGuiID}(x + 192)
    f === :ChildId && return Ptr{ImGuiID}(x + 196)
    f === :PopupId && return Ptr{ImGuiID}(x + 200)
    f === :Scroll && return Ptr{ImVec2}(x + 204)
    f === :ScrollMax && return Ptr{ImVec2}(x + 212)
    f === :ScrollTarget && return Ptr{ImVec2}(x + 220)
    f === :ScrollTargetCenterRatio && return Ptr{ImVec2}(x + 228)
    f === :ScrollTargetEdgeSnapDist && return Ptr{ImVec2}(x + 236)
    f === :ScrollbarSizes && return Ptr{ImVec2}(x + 244)
    f === :ScrollbarX && return Ptr{Bool}(x + 252)
    f === :ScrollbarY && return Ptr{Bool}(x + 253)
    f === :ViewportOwned && return Ptr{Bool}(x + 254)
    f === :Active && return Ptr{Bool}(x + 255)
    f === :WasActive && return Ptr{Bool}(x + 256)
    f === :WriteAccessed && return Ptr{Bool}(x + 257)
    f === :Collapsed && return Ptr{Bool}(x + 258)
    f === :WantCollapseToggle && return Ptr{Bool}(x + 259)
    f === :SkipItems && return Ptr{Bool}(x + 260)
    f === :SkipRefresh && return Ptr{Bool}(x + 261)
    f === :Appearing && return Ptr{Bool}(x + 262)
    f === :Hidden && return Ptr{Bool}(x + 263)
    f === :IsFallbackWindow && return Ptr{Bool}(x + 264)
    f === :IsExplicitChild && return Ptr{Bool}(x + 265)
    f === :HasCloseButton && return Ptr{Bool}(x + 266)
    f === :ResizeBorderHovered && return Ptr{Int8}(x + 267)
    f === :ResizeBorderHeld && return Ptr{Int8}(x + 268)
    f === :BeginCount && return Ptr{Cshort}(x + 270)
    f === :BeginCountPreviousFrame && return Ptr{Cshort}(x + 272)
    f === :BeginOrderWithinParent && return Ptr{Cshort}(x + 274)
    f === :BeginOrderWithinContext && return Ptr{Cshort}(x + 276)
    f === :FocusOrder && return Ptr{Cshort}(x + 278)
    f === :AutoFitFramesX && return Ptr{ImS8}(x + 280)
    f === :AutoFitFramesY && return Ptr{ImS8}(x + 281)
    f === :AutoFitOnlyGrows && return Ptr{Bool}(x + 282)
    f === :AutoPosLastDirection && return Ptr{ImGuiDir}(x + 284)
    f === :HiddenFramesCanSkipItems && return Ptr{ImS8}(x + 288)
    f === :HiddenFramesCannotSkipItems && return Ptr{ImS8}(x + 289)
    f === :HiddenFramesForRenderOnly && return Ptr{ImS8}(x + 290)
    f === :DisableInputsFrames && return Ptr{ImS8}(x + 291)
    f === :SetWindowPosAllowFlags && return (Ptr{ImGuiCond}(x + 292), 0, 8)
    f === :SetWindowSizeAllowFlags && return (Ptr{ImGuiCond}(x + 292), 8, 8)
    f === :SetWindowCollapsedAllowFlags && return (Ptr{ImGuiCond}(x + 292), 16, 8)
    f === :SetWindowDockAllowFlags && return (Ptr{ImGuiCond}(x + 292), 24, 8)
    f === :SetWindowPosVal && return Ptr{ImVec2}(x + 296)
    f === :SetWindowPosPivot && return Ptr{ImVec2}(x + 304)
    f === :IDStack && return Ptr{ImVector_ImGuiID}(x + 312)
    f === :DC && return Ptr{ImGuiWindowTempData}(x + 328)
    f === :OuterRectClipped && return Ptr{ImRect}(x + 560)
    f === :InnerRect && return Ptr{ImRect}(x + 576)
    f === :InnerClipRect && return Ptr{ImRect}(x + 592)
    f === :WorkRect && return Ptr{ImRect}(x + 608)
    f === :ParentWorkRect && return Ptr{ImRect}(x + 624)
    f === :ClipRect && return Ptr{ImRect}(x + 640)
    f === :ContentRegionRect && return Ptr{ImRect}(x + 656)
    f === :HitTestHoleSize && return Ptr{ImVec2ih}(x + 672)
    f === :HitTestHoleOffset && return Ptr{ImVec2ih}(x + 676)
    f === :LastFrameActive && return Ptr{Cint}(x + 680)
    f === :LastFrameJustFocused && return Ptr{Cint}(x + 684)
    f === :LastTimeActive && return Ptr{Cfloat}(x + 688)
    f === :ItemWidthDefault && return Ptr{Cfloat}(x + 692)
    f === :StateStorage && return Ptr{ImGuiStorage}(x + 696)
    f === :ColumnsStorage && return Ptr{ImVector_ImGuiOldColumns}(x + 712)
    f === :FontWindowScale && return Ptr{Cfloat}(x + 728)
    f === :FontDpiScale && return Ptr{Cfloat}(x + 732)
    f === :SettingsOffset && return Ptr{Cint}(x + 736)
    f === :DrawList && return Ptr{Ptr{ImDrawList}}(x + 744)
    f === :DrawListInst && return Ptr{ImDrawList}(x + 752)
    f === :ParentWindow && return Ptr{Ptr{ImGuiWindow}}(x + 952)
    f === :ParentWindowInBeginStack && return Ptr{Ptr{ImGuiWindow}}(x + 960)
    f === :RootWindow && return Ptr{Ptr{ImGuiWindow}}(x + 968)
    f === :RootWindowPopupTree && return Ptr{Ptr{ImGuiWindow}}(x + 976)
    f === :RootWindowDockTree && return Ptr{Ptr{ImGuiWindow}}(x + 984)
    f === :RootWindowForTitleBarHighlight && return Ptr{Ptr{ImGuiWindow}}(x + 992)
    f === :RootWindowForNav && return Ptr{Ptr{ImGuiWindow}}(x + 1000)
    f === :ParentWindowForFocusRoute && return Ptr{Ptr{ImGuiWindow}}(x + 1008)
    f === :NavLastChildNavWindow && return Ptr{Ptr{ImGuiWindow}}(x + 1016)
    f === :NavLastIds && return Ptr{NTuple{2, ImGuiID}}(x + 1024)
    f === :NavRectRel && return Ptr{NTuple{2, ImRect}}(x + 1032)
    f === :NavPreferredScoringPosRel && return Ptr{NTuple{2, ImVec2}}(x + 1064)
    f === :NavRootFocusScopeId && return Ptr{ImGuiID}(x + 1080)
    f === :MemoryDrawListIdxCapacity && return Ptr{Cint}(x + 1084)
    f === :MemoryDrawListVtxCapacity && return Ptr{Cint}(x + 1088)
    f === :MemoryCompacted && return Ptr{Bool}(x + 1092)
    f === :DockIsActive && return (Ptr{Bool}(x + 1092), 8, 1)
    f === :DockNodeIsVisible && return (Ptr{Bool}(x + 1092), 9, 1)
    f === :DockTabIsVisible && return (Ptr{Bool}(x + 1092), 10, 1)
    f === :DockTabWantClose && return (Ptr{Bool}(x + 1092), 11, 1)
    f === :DockOrder && return Ptr{Cshort}(x + 1094)
    f === :DockStyle && return Ptr{ImGuiWindowDockStyle}(x + 1096)
    f === :DockNode && return Ptr{Ptr{ImGuiDockNode}}(x + 1128)
    f === :DockNodeAsHost && return Ptr{Ptr{ImGuiDockNode}}(x + 1136)
    f === :DockId && return Ptr{ImGuiID}(x + 1144)
    f === :DockTabItemStatusFlags && return Ptr{ImGuiItemStatusFlags}(x + 1148)
    f === :DockTabItemRect && return Ptr{ImRect}(x + 1152)
    return getfield(x, f)
end

function Base.getproperty(x::ImGuiWindow, f::Symbol)
    r = Ref{ImGuiWindow}(x)
    ptr = Base.unsafe_convert(Ptr{ImGuiWindow}, r)
    fptr = getproperty(ptr, f)
    begin
        if fptr isa Ptr
            return GC.@preserve(r, unsafe_load(fptr))
        else
            (baseptr, offset, width) = fptr
            ty = eltype(baseptr)
            baseptr32 = convert(Ptr{UInt32}, baseptr)
            u64 = GC.@preserve(r, unsafe_load(baseptr32))
            if offset + width > 32
                u64 |= GC.@preserve(r, unsafe_load(baseptr32 + 4)) << 32
            end
            u64 = u64 >> offset & (1 << width - 1)
            return u64 % ty
        end
    end
end

function Base.setproperty!(x::Ptr{ImGuiWindow}, f::Symbol, v)
    fptr = getproperty(x, f)
    if fptr isa Ptr
        unsafe_store!(getproperty(x, f), v)
    else
        (baseptr, offset, width) = fptr
        baseptr32 = convert(Ptr{UInt32}, baseptr)
        u64 = unsafe_load(baseptr32)
        straddle = offset + width > 32
        if straddle
            u64 |= unsafe_load(baseptr32 + 4) << 32
        end
        mask = 1 << width - 1
        u64 &= ~(mask << offset)
        u64 |= (unsigned(v) & mask) << offset
        unsafe_store!(baseptr32, u64 & typemax(UInt32))
        if straddle
            unsafe_store!(baseptr32 + 4, u64 >> 32)
        end
    end
end

const ImGuiItemFlags = Cint

struct ImGuiLastItemData
    ID::ImGuiID
    InFlags::ImGuiItemFlags
    StatusFlags::ImGuiItemStatusFlags
    Rect::ImRect
    NavRect::ImRect
    DisplayRect::ImRect
    ClipRect::ImRect
    Shortcut::ImGuiKeyChord
end

struct ImGuiStackSizes
    SizeOfIDStack::Cshort
    SizeOfColorStack::Cshort
    SizeOfStyleVarStack::Cshort
    SizeOfFontStack::Cshort
    SizeOfFocusScopeStack::Cshort
    SizeOfGroupStack::Cshort
    SizeOfItemFlagsStack::Cshort
    SizeOfBeginPopupStack::Cshort
    SizeOfDisabledStack::Cshort
end

struct ImGuiWindowStackData
    Window::Ptr{ImGuiWindow}
    ParentLastItemDataBackup::ImGuiLastItemData
    StackSizesOnBegin::ImGuiStackSizes
    DisabledOverrideReenable::Bool
end

struct ImVector_ImGuiWindowStackData
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiWindowStackData}
end

struct ImBitArray_ImGuiKey_NamedKey_COUNT__lessImGuiKey_NamedKey_BEGIN
    Storage::NTuple{5, ImU32}
end

const ImBitArrayForNamedKeys = ImBitArray_ImGuiKey_NamedKey_COUNT__lessImGuiKey_NamedKey_BEGIN

struct ImGuiKeyOwnerData
    OwnerCurr::ImGuiID
    OwnerNext::ImGuiID
    LockThisFrame::Bool
    LockUntilRelease::Bool
end

const ImGuiKeyRoutingIndex = ImS16

struct ImGuiKeyRoutingData
    NextEntryIndex::ImGuiKeyRoutingIndex
    Mods::ImU16
    RoutingCurrScore::ImU8
    RoutingNextScore::ImU8
    RoutingCurr::ImGuiID
    RoutingNext::ImGuiID
end

struct ImVector_ImGuiKeyRoutingData
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiKeyRoutingData}
end

struct ImGuiKeyRoutingTable
    Index::NTuple{154, ImGuiKeyRoutingIndex}
    Entries::ImVector_ImGuiKeyRoutingData
    EntriesNext::ImVector_ImGuiKeyRoutingData
end

const ImGuiNextItemDataFlags = Cint

const ImS64 = Clonglong

const ImGuiSelectionUserData = ImS64

const ImGuiInputFlags = Cint

struct ImGuiDataTypeStorage
    Data::NTuple{8, ImU8}
end

struct ImGuiNextItemData
    Flags::ImGuiNextItemDataFlags
    ItemFlags::ImGuiItemFlags
    FocusScopeId::ImGuiID
    SelectionUserData::ImGuiSelectionUserData
    Width::Cfloat
    Shortcut::ImGuiKeyChord
    ShortcutFlags::ImGuiInputFlags
    OpenVal::Bool
    OpenCond::ImU8
    RefVal::ImGuiDataTypeStorage
    StorageId::ImGuiID
end

const ImGuiNextWindowDataFlags = Cint

# typedef void ( * ImGuiSizeCallback ) ( ImGuiSizeCallbackData * data )
const ImGuiSizeCallback = Ptr{Cvoid}

const ImGuiWindowRefreshFlags = Cint

struct ImGuiNextWindowData
    Flags::ImGuiNextWindowDataFlags
    PosCond::ImGuiCond
    SizeCond::ImGuiCond
    CollapsedCond::ImGuiCond
    DockCond::ImGuiCond
    PosVal::ImVec2
    PosPivotVal::ImVec2
    SizeVal::ImVec2
    ContentSizeVal::ImVec2
    ScrollVal::ImVec2
    ChildFlags::ImGuiChildFlags
    PosUndock::Bool
    CollapsedVal::Bool
    SizeConstraintRect::ImRect
    SizeCallback::ImGuiSizeCallback
    SizeCallbackUserData::Ptr{Cvoid}
    BgAlphaVal::Cfloat
    ViewportId::ImGuiID
    DockId::ImGuiID
    WindowClass::ImGuiWindowClass
    MenuBarOffsetMinVal::ImVec2
    RefreshFlagsVal::ImGuiWindowRefreshFlags
end

const ImGuiCol = Cint

struct ImGuiColorMod
    Col::ImGuiCol
    BackupValue::ImVec4
end

struct ImVector_ImGuiColorMod
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiColorMod}
end

const ImGuiStyleVar = Cint

struct ImGuiStyleMod
    data::NTuple{12, UInt8}
end

function Base.getproperty(x::Ptr{ImGuiStyleMod}, f::Symbol)
    f === :VarIdx && return Ptr{ImGuiStyleVar}(x + 0)
    f === :BackupInt && return Ptr{NTuple{2, Cint}}(x + 4)
    f === :BackupFloat && return Ptr{NTuple{2, Cfloat}}(x + 4)
    return getfield(x, f)
end

function Base.getproperty(x::ImGuiStyleMod, f::Symbol)
    r = Ref{ImGuiStyleMod}(x)
    ptr = Base.unsafe_convert(Ptr{ImGuiStyleMod}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{ImGuiStyleMod}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct ImVector_ImGuiStyleMod
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiStyleMod}
end

struct ImGuiFocusScopeData
    ID::ImGuiID
    WindowID::ImGuiID
end

struct ImVector_ImGuiFocusScopeData
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiFocusScopeData}
end

struct ImVector_ImGuiItemFlags
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiItemFlags}
end

struct ImGuiGroupData
    WindowID::ImGuiID
    BackupCursorPos::ImVec2
    BackupCursorMaxPos::ImVec2
    BackupCursorPosPrevLine::ImVec2
    BackupIndent::ImVec1
    BackupGroupOffset::ImVec1
    BackupCurrLineSize::ImVec2
    BackupCurrLineTextBaseOffset::Cfloat
    BackupActiveIdIsAlive::ImGuiID
    BackupActiveIdPreviousFrameIsAlive::Bool
    BackupHoveredIdIsAlive::Bool
    BackupIsSameLine::Bool
    EmitItem::Bool
end

struct ImVector_ImGuiGroupData
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiGroupData}
end

struct ImGuiPopupData
    PopupId::ImGuiID
    Window::Ptr{ImGuiWindow}
    RestoreNavWindow::Ptr{ImGuiWindow}
    ParentNavLayer::Cint
    OpenFrameCount::Cint
    OpenParentId::ImGuiID
    OpenPopupPos::ImVec2
    OpenMousePos::ImVec2
end

struct ImVector_ImGuiPopupData
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiPopupData}
end

const ImGuiTreeNodeFlags = Cint

struct ImGuiTreeNodeStackData
    ID::ImGuiID
    TreeFlags::ImGuiTreeNodeFlags
    InFlags::ImGuiItemFlags
    NavRect::ImRect
end

struct ImVector_ImGuiTreeNodeStackData
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiTreeNodeStackData}
end

struct ImVector_ImGuiViewportPPtr
    Size::Cint
    Capacity::Cint
    Data::Ptr{Ptr{ImGuiViewportP}}
end

const ImGuiActivateFlags = Cint

struct ImGuiNavItemData
    Window::Ptr{ImGuiWindow}
    ID::ImGuiID
    FocusScopeId::ImGuiID
    RectRel::ImRect
    InFlags::ImGuiItemFlags
    DistBox::Cfloat
    DistCenter::Cfloat
    DistAxial::Cfloat
    SelectionUserData::ImGuiSelectionUserData
end

const ImGuiNavMoveFlags = Cint

const ImGuiScrollFlags = Cint

@cenum ImGuiKey::UInt32 begin
    ImGuiKey_None = 0
    ImGuiKey_Tab = 512
    ImGuiKey_LeftArrow = 513
    ImGuiKey_RightArrow = 514
    ImGuiKey_UpArrow = 515
    ImGuiKey_DownArrow = 516
    ImGuiKey_PageUp = 517
    ImGuiKey_PageDown = 518
    ImGuiKey_Home = 519
    ImGuiKey_End = 520
    ImGuiKey_Insert = 521
    ImGuiKey_Delete = 522
    ImGuiKey_Backspace = 523
    ImGuiKey_Space = 524
    ImGuiKey_Enter = 525
    ImGuiKey_Escape = 526
    ImGuiKey_LeftCtrl = 527
    ImGuiKey_LeftShift = 528
    ImGuiKey_LeftAlt = 529
    ImGuiKey_LeftSuper = 530
    ImGuiKey_RightCtrl = 531
    ImGuiKey_RightShift = 532
    ImGuiKey_RightAlt = 533
    ImGuiKey_RightSuper = 534
    ImGuiKey_Menu = 535
    ImGuiKey_0 = 536
    ImGuiKey_1 = 537
    ImGuiKey_2 = 538
    ImGuiKey_3 = 539
    ImGuiKey_4 = 540
    ImGuiKey_5 = 541
    ImGuiKey_6 = 542
    ImGuiKey_7 = 543
    ImGuiKey_8 = 544
    ImGuiKey_9 = 545
    ImGuiKey_A = 546
    ImGuiKey_B = 547
    ImGuiKey_C = 548
    ImGuiKey_D = 549
    ImGuiKey_E = 550
    ImGuiKey_F = 551
    ImGuiKey_G = 552
    ImGuiKey_H = 553
    ImGuiKey_I = 554
    ImGuiKey_J = 555
    ImGuiKey_K = 556
    ImGuiKey_L = 557
    ImGuiKey_M = 558
    ImGuiKey_N = 559
    ImGuiKey_O = 560
    ImGuiKey_P = 561
    ImGuiKey_Q = 562
    ImGuiKey_R = 563
    ImGuiKey_S = 564
    ImGuiKey_T = 565
    ImGuiKey_U = 566
    ImGuiKey_V = 567
    ImGuiKey_W = 568
    ImGuiKey_X = 569
    ImGuiKey_Y = 570
    ImGuiKey_Z = 571
    ImGuiKey_F1 = 572
    ImGuiKey_F2 = 573
    ImGuiKey_F3 = 574
    ImGuiKey_F4 = 575
    ImGuiKey_F5 = 576
    ImGuiKey_F6 = 577
    ImGuiKey_F7 = 578
    ImGuiKey_F8 = 579
    ImGuiKey_F9 = 580
    ImGuiKey_F10 = 581
    ImGuiKey_F11 = 582
    ImGuiKey_F12 = 583
    ImGuiKey_F13 = 584
    ImGuiKey_F14 = 585
    ImGuiKey_F15 = 586
    ImGuiKey_F16 = 587
    ImGuiKey_F17 = 588
    ImGuiKey_F18 = 589
    ImGuiKey_F19 = 590
    ImGuiKey_F20 = 591
    ImGuiKey_F21 = 592
    ImGuiKey_F22 = 593
    ImGuiKey_F23 = 594
    ImGuiKey_F24 = 595
    ImGuiKey_Apostrophe = 596
    ImGuiKey_Comma = 597
    ImGuiKey_Minus = 598
    ImGuiKey_Period = 599
    ImGuiKey_Slash = 600
    ImGuiKey_Semicolon = 601
    ImGuiKey_Equal = 602
    ImGuiKey_LeftBracket = 603
    ImGuiKey_Backslash = 604
    ImGuiKey_RightBracket = 605
    ImGuiKey_GraveAccent = 606
    ImGuiKey_CapsLock = 607
    ImGuiKey_ScrollLock = 608
    ImGuiKey_NumLock = 609
    ImGuiKey_PrintScreen = 610
    ImGuiKey_Pause = 611
    ImGuiKey_Keypad0 = 612
    ImGuiKey_Keypad1 = 613
    ImGuiKey_Keypad2 = 614
    ImGuiKey_Keypad3 = 615
    ImGuiKey_Keypad4 = 616
    ImGuiKey_Keypad5 = 617
    ImGuiKey_Keypad6 = 618
    ImGuiKey_Keypad7 = 619
    ImGuiKey_Keypad8 = 620
    ImGuiKey_Keypad9 = 621
    ImGuiKey_KeypadDecimal = 622
    ImGuiKey_KeypadDivide = 623
    ImGuiKey_KeypadMultiply = 624
    ImGuiKey_KeypadSubtract = 625
    ImGuiKey_KeypadAdd = 626
    ImGuiKey_KeypadEnter = 627
    ImGuiKey_KeypadEqual = 628
    ImGuiKey_AppBack = 629
    ImGuiKey_AppForward = 630
    ImGuiKey_GamepadStart = 631
    ImGuiKey_GamepadBack = 632
    ImGuiKey_GamepadFaceLeft = 633
    ImGuiKey_GamepadFaceRight = 634
    ImGuiKey_GamepadFaceUp = 635
    ImGuiKey_GamepadFaceDown = 636
    ImGuiKey_GamepadDpadLeft = 637
    ImGuiKey_GamepadDpadRight = 638
    ImGuiKey_GamepadDpadUp = 639
    ImGuiKey_GamepadDpadDown = 640
    ImGuiKey_GamepadL1 = 641
    ImGuiKey_GamepadR1 = 642
    ImGuiKey_GamepadL2 = 643
    ImGuiKey_GamepadR2 = 644
    ImGuiKey_GamepadL3 = 645
    ImGuiKey_GamepadR3 = 646
    ImGuiKey_GamepadLStickLeft = 647
    ImGuiKey_GamepadLStickRight = 648
    ImGuiKey_GamepadLStickUp = 649
    ImGuiKey_GamepadLStickDown = 650
    ImGuiKey_GamepadRStickLeft = 651
    ImGuiKey_GamepadRStickRight = 652
    ImGuiKey_GamepadRStickUp = 653
    ImGuiKey_GamepadRStickDown = 654
    ImGuiKey_MouseLeft = 655
    ImGuiKey_MouseRight = 656
    ImGuiKey_MouseMiddle = 657
    ImGuiKey_MouseX1 = 658
    ImGuiKey_MouseX2 = 659
    ImGuiKey_MouseWheelX = 660
    ImGuiKey_MouseWheelY = 661
    ImGuiKey_ReservedForModCtrl = 662
    ImGuiKey_ReservedForModShift = 663
    ImGuiKey_ReservedForModAlt = 664
    ImGuiKey_ReservedForModSuper = 665
    ImGuiKey_COUNT = 666
    ImGuiMod_None = 0
    ImGuiMod_Ctrl = 4096
    ImGuiMod_Shift = 8192
    ImGuiMod_Alt = 16384
    ImGuiMod_Super = 32768
    ImGuiMod_Mask_ = 61440
    ImGuiKey_NamedKey_BEGIN = 512
    ImGuiKey_NamedKey_END = 666
    ImGuiKey_NamedKey_COUNT = 154
    ImGuiKey_KeysData_SIZE = 154
    ImGuiKey_KeysData_OFFSET = 512
end

const ImGuiDragDropFlags = Cint

struct ImGuiPayload
    Data::Ptr{Cvoid}
    DataSize::Cint
    SourceId::ImGuiID
    SourceParentId::ImGuiID
    DataFrameCount::Cint
    DataType::NTuple{33, Cchar}
    Preview::Bool
    Delivery::Bool
end

struct ImVector_unsigned_char
    Size::Cint
    Capacity::Cint
    Data::Ptr{Cuchar}
end

struct ImGuiListClipper
    Ctx::Ptr{Cvoid} # Ctx::Ptr{ImGuiContext}
    DisplayStart::Cint
    DisplayEnd::Cint
    ItemsCount::Cint
    ItemsHeight::Cfloat
    StartPosY::Cfloat
    StartSeekOffsetY::Cdouble
    TempData::Ptr{Cvoid}
end

function Base.getproperty(x::ImGuiListClipper, f::Symbol)
    f === :Ctx && return Ptr{ImGuiContext}(getfield(x, f))
    return getfield(x, f)
end

function Base.getproperty(x::Ptr{ImGuiListClipper}, f::Symbol)
    f === :Ctx && return Ptr{Ptr{ImGuiContext}}(x + 0)
    f === :DisplayStart && return Ptr{Cint}(x + 8)
    f === :DisplayEnd && return Ptr{Cint}(x + 12)
    f === :ItemsCount && return Ptr{Cint}(x + 16)
    f === :ItemsHeight && return Ptr{Cfloat}(x + 20)
    f === :StartPosY && return Ptr{Cfloat}(x + 24)
    f === :StartSeekOffsetY && return Ptr{Cdouble}(x + 32)
    f === :TempData && return Ptr{Ptr{Cvoid}}(x + 40)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{ImGuiListClipper}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct ImGuiListClipperRange
    Min::Cint
    Max::Cint
    PosToIndexConvert::Bool
    PosToIndexOffsetMin::ImS8
    PosToIndexOffsetMax::ImS8
end

struct ImVector_ImGuiListClipperRange
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiListClipperRange}
end

struct ImGuiListClipperData
    ListClipper::Ptr{ImGuiListClipper}
    LossynessOffset::Cfloat
    StepNo::Cint
    ItemsFrozen::Cint
    Ranges::ImVector_ImGuiListClipperRange
end

struct ImVector_ImGuiListClipperData
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiListClipperData}
end

const ImGuiTableFlags = Cint

const ImGuiTableColumnIdx = ImS16

struct ImGuiTableHeaderData
    Index::ImGuiTableColumnIdx
    TextColor::ImU32
    BgColor0::ImU32
    BgColor1::ImU32
end

struct ImVector_ImGuiTableHeaderData
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiTableHeaderData}
end

struct ImGuiTableTempData
    TableIndex::Cint
    LastTimeActive::Cfloat
    AngledHeadersExtraWidth::Cfloat
    AngledHeadersRequests::ImVector_ImGuiTableHeaderData
    UserOuterSize::ImVec2
    DrawSplitter::ImDrawListSplitter
    HostBackupWorkRect::ImRect
    HostBackupParentWorkRect::ImRect
    HostBackupPrevLineSize::ImVec2
    HostBackupCurrLineSize::ImVec2
    HostBackupCursorMaxPos::ImVec2
    HostBackupColumnsOffset::ImVec1
    HostBackupItemWidth::Cfloat
    HostBackupItemWidthStackSize::Cint
end

const ImGuiTableColumnFlags = Cint

const ImGuiTableDrawChannelIdx = ImU16

struct ImGuiTableColumn
    data::NTuple{112, UInt8}
end

function Base.getproperty(x::Ptr{ImGuiTableColumn}, f::Symbol)
    f === :Flags && return Ptr{ImGuiTableColumnFlags}(x + 0)
    f === :WidthGiven && return Ptr{Cfloat}(x + 4)
    f === :MinX && return Ptr{Cfloat}(x + 8)
    f === :MaxX && return Ptr{Cfloat}(x + 12)
    f === :WidthRequest && return Ptr{Cfloat}(x + 16)
    f === :WidthAuto && return Ptr{Cfloat}(x + 20)
    f === :StretchWeight && return Ptr{Cfloat}(x + 24)
    f === :InitStretchWeightOrWidth && return Ptr{Cfloat}(x + 28)
    f === :ClipRect && return Ptr{ImRect}(x + 32)
    f === :UserID && return Ptr{ImGuiID}(x + 48)
    f === :WorkMinX && return Ptr{Cfloat}(x + 52)
    f === :WorkMaxX && return Ptr{Cfloat}(x + 56)
    f === :ItemWidth && return Ptr{Cfloat}(x + 60)
    f === :ContentMaxXFrozen && return Ptr{Cfloat}(x + 64)
    f === :ContentMaxXUnfrozen && return Ptr{Cfloat}(x + 68)
    f === :ContentMaxXHeadersUsed && return Ptr{Cfloat}(x + 72)
    f === :ContentMaxXHeadersIdeal && return Ptr{Cfloat}(x + 76)
    f === :NameOffset && return Ptr{ImS16}(x + 80)
    f === :DisplayOrder && return Ptr{ImGuiTableColumnIdx}(x + 82)
    f === :IndexWithinEnabledSet && return Ptr{ImGuiTableColumnIdx}(x + 84)
    f === :PrevEnabledColumn && return Ptr{ImGuiTableColumnIdx}(x + 86)
    f === :NextEnabledColumn && return Ptr{ImGuiTableColumnIdx}(x + 88)
    f === :SortOrder && return Ptr{ImGuiTableColumnIdx}(x + 90)
    f === :DrawChannelCurrent && return Ptr{ImGuiTableDrawChannelIdx}(x + 92)
    f === :DrawChannelFrozen && return Ptr{ImGuiTableDrawChannelIdx}(x + 94)
    f === :DrawChannelUnfrozen && return Ptr{ImGuiTableDrawChannelIdx}(x + 96)
    f === :IsEnabled && return Ptr{Bool}(x + 98)
    f === :IsUserEnabled && return Ptr{Bool}(x + 99)
    f === :IsUserEnabledNextFrame && return Ptr{Bool}(x + 100)
    f === :IsVisibleX && return Ptr{Bool}(x + 101)
    f === :IsVisibleY && return Ptr{Bool}(x + 102)
    f === :IsRequestOutput && return Ptr{Bool}(x + 103)
    f === :IsSkipItems && return Ptr{Bool}(x + 104)
    f === :IsPreserveWidthAuto && return Ptr{Bool}(x + 105)
    f === :NavLayerCurrent && return Ptr{ImS8}(x + 106)
    f === :AutoFitQueue && return Ptr{ImU8}(x + 107)
    f === :CannotSkipItemsQueue && return Ptr{ImU8}(x + 108)
    f === :SortDirection && return (Ptr{ImU8}(x + 108), 8, 2)
    f === :SortDirectionsAvailCount && return (Ptr{ImU8}(x + 108), 10, 2)
    f === :SortDirectionsAvailMask && return (Ptr{ImU8}(x + 108), 12, 4)
    f === :SortDirectionsAvailList && return Ptr{ImU8}(x + 110)
    return getfield(x, f)
end

function Base.getproperty(x::ImGuiTableColumn, f::Symbol)
    r = Ref{ImGuiTableColumn}(x)
    ptr = Base.unsafe_convert(Ptr{ImGuiTableColumn}, r)
    fptr = getproperty(ptr, f)
    begin
        if fptr isa Ptr
            return GC.@preserve(r, unsafe_load(fptr))
        else
            (baseptr, offset, width) = fptr
            ty = eltype(baseptr)
            baseptr32 = convert(Ptr{UInt32}, baseptr)
            u64 = GC.@preserve(r, unsafe_load(baseptr32))
            if offset + width > 32
                u64 |= GC.@preserve(r, unsafe_load(baseptr32 + 4)) << 32
            end
            u64 = u64 >> offset & (1 << width - 1)
            return u64 % ty
        end
    end
end

function Base.setproperty!(x::Ptr{ImGuiTableColumn}, f::Symbol, v)
    fptr = getproperty(x, f)
    if fptr isa Ptr
        unsafe_store!(getproperty(x, f), v)
    else
        (baseptr, offset, width) = fptr
        baseptr32 = convert(Ptr{UInt32}, baseptr)
        u64 = unsafe_load(baseptr32)
        straddle = offset + width > 32
        if straddle
            u64 |= unsafe_load(baseptr32 + 4) << 32
        end
        mask = 1 << width - 1
        u64 &= ~(mask << offset)
        u64 |= (unsigned(v) & mask) << offset
        unsafe_store!(baseptr32, u64 & typemax(UInt32))
        if straddle
            unsafe_store!(baseptr32 + 4, u64 >> 32)
        end
    end
end

struct ImSpan_ImGuiTableColumn
    Data::Ptr{ImGuiTableColumn}
    DataEnd::Ptr{ImGuiTableColumn}
end

struct ImSpan_ImGuiTableColumnIdx
    Data::Ptr{ImGuiTableColumnIdx}
    DataEnd::Ptr{ImGuiTableColumnIdx}
end

struct ImGuiTableCellData
    BgColor::ImU32
    Column::ImGuiTableColumnIdx
end

struct ImSpan_ImGuiTableCellData
    Data::Ptr{ImGuiTableCellData}
    DataEnd::Ptr{ImGuiTableCellData}
end

const ImBitArrayPtr = Ptr{ImU32}

const ImGuiTableRowFlags = Cint

struct ImGuiTableInstanceData
    TableInstanceID::ImGuiID
    LastOuterHeight::Cfloat
    LastTopHeadersRowHeight::Cfloat
    LastFrozenHeight::Cfloat
    HoveredRowLast::Cint
    HoveredRowNext::Cint
end

struct ImVector_ImGuiTableInstanceData
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiTableInstanceData}
end

@cenum ImGuiSortDirection::UInt32 begin
    ImGuiSortDirection_None = 0
    ImGuiSortDirection_Ascending = 1
    ImGuiSortDirection_Descending = 2
end

struct ImGuiTableColumnSortSpecs
    ColumnUserID::ImGuiID
    ColumnIndex::ImS16
    SortOrder::ImS16
    SortDirection::ImGuiSortDirection
end

struct ImVector_ImGuiTableColumnSortSpecs
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiTableColumnSortSpecs}
end

struct ImGuiTableSortSpecs
    Specs::Ptr{ImGuiTableColumnSortSpecs}
    SpecsCount::Cint
    SpecsDirty::Bool
end

struct ImGuiTable
    data::NTuple{592, UInt8}
end

function Base.getproperty(x::Ptr{ImGuiTable}, f::Symbol)
    f === :ID && return Ptr{ImGuiID}(x + 0)
    f === :Flags && return Ptr{ImGuiTableFlags}(x + 4)
    f === :RawData && return Ptr{Ptr{Cvoid}}(x + 8)
    f === :TempData && return Ptr{Ptr{ImGuiTableTempData}}(x + 16)
    f === :Columns && return Ptr{ImSpan_ImGuiTableColumn}(x + 24)
    f === :DisplayOrderToIndex && return Ptr{ImSpan_ImGuiTableColumnIdx}(x + 40)
    f === :RowCellData && return Ptr{ImSpan_ImGuiTableCellData}(x + 56)
    f === :EnabledMaskByDisplayOrder && return Ptr{ImBitArrayPtr}(x + 72)
    f === :EnabledMaskByIndex && return Ptr{ImBitArrayPtr}(x + 80)
    f === :VisibleMaskByIndex && return Ptr{ImBitArrayPtr}(x + 88)
    f === :SettingsLoadedFlags && return Ptr{ImGuiTableFlags}(x + 96)
    f === :SettingsOffset && return Ptr{Cint}(x + 100)
    f === :LastFrameActive && return Ptr{Cint}(x + 104)
    f === :ColumnsCount && return Ptr{Cint}(x + 108)
    f === :CurrentRow && return Ptr{Cint}(x + 112)
    f === :CurrentColumn && return Ptr{Cint}(x + 116)
    f === :InstanceCurrent && return Ptr{ImS16}(x + 120)
    f === :InstanceInteracted && return Ptr{ImS16}(x + 122)
    f === :RowPosY1 && return Ptr{Cfloat}(x + 124)
    f === :RowPosY2 && return Ptr{Cfloat}(x + 128)
    f === :RowMinHeight && return Ptr{Cfloat}(x + 132)
    f === :RowCellPaddingY && return Ptr{Cfloat}(x + 136)
    f === :RowTextBaseline && return Ptr{Cfloat}(x + 140)
    f === :RowIndentOffsetX && return Ptr{Cfloat}(x + 144)
    f === :RowFlags && return (Ptr{ImGuiTableRowFlags}(x + 148), 0, 16)
    f === :LastRowFlags && return (Ptr{ImGuiTableRowFlags}(x + 148), 16, 16)
    f === :RowBgColorCounter && return Ptr{Cint}(x + 152)
    f === :RowBgColor && return Ptr{NTuple{2, ImU32}}(x + 156)
    f === :BorderColorStrong && return Ptr{ImU32}(x + 164)
    f === :BorderColorLight && return Ptr{ImU32}(x + 168)
    f === :BorderX1 && return Ptr{Cfloat}(x + 172)
    f === :BorderX2 && return Ptr{Cfloat}(x + 176)
    f === :HostIndentX && return Ptr{Cfloat}(x + 180)
    f === :MinColumnWidth && return Ptr{Cfloat}(x + 184)
    f === :OuterPaddingX && return Ptr{Cfloat}(x + 188)
    f === :CellPaddingX && return Ptr{Cfloat}(x + 192)
    f === :CellSpacingX1 && return Ptr{Cfloat}(x + 196)
    f === :CellSpacingX2 && return Ptr{Cfloat}(x + 200)
    f === :InnerWidth && return Ptr{Cfloat}(x + 204)
    f === :ColumnsGivenWidth && return Ptr{Cfloat}(x + 208)
    f === :ColumnsAutoFitWidth && return Ptr{Cfloat}(x + 212)
    f === :ColumnsStretchSumWeights && return Ptr{Cfloat}(x + 216)
    f === :ResizedColumnNextWidth && return Ptr{Cfloat}(x + 220)
    f === :ResizeLockMinContentsX2 && return Ptr{Cfloat}(x + 224)
    f === :RefScale && return Ptr{Cfloat}(x + 228)
    f === :AngledHeadersHeight && return Ptr{Cfloat}(x + 232)
    f === :AngledHeadersSlope && return Ptr{Cfloat}(x + 236)
    f === :OuterRect && return Ptr{ImRect}(x + 240)
    f === :InnerRect && return Ptr{ImRect}(x + 256)
    f === :WorkRect && return Ptr{ImRect}(x + 272)
    f === :InnerClipRect && return Ptr{ImRect}(x + 288)
    f === :BgClipRect && return Ptr{ImRect}(x + 304)
    f === :Bg0ClipRectForDrawCmd && return Ptr{ImRect}(x + 320)
    f === :Bg2ClipRectForDrawCmd && return Ptr{ImRect}(x + 336)
    f === :HostClipRect && return Ptr{ImRect}(x + 352)
    f === :HostBackupInnerClipRect && return Ptr{ImRect}(x + 368)
    f === :OuterWindow && return Ptr{Ptr{ImGuiWindow}}(x + 384)
    f === :InnerWindow && return Ptr{Ptr{ImGuiWindow}}(x + 392)
    f === :ColumnsNames && return Ptr{ImGuiTextBuffer}(x + 400)
    f === :DrawSplitter && return Ptr{Ptr{ImDrawListSplitter}}(x + 416)
    f === :InstanceDataFirst && return Ptr{ImGuiTableInstanceData}(x + 424)
    f === :InstanceDataExtra && return Ptr{ImVector_ImGuiTableInstanceData}(x + 448)
    f === :SortSpecsSingle && return Ptr{ImGuiTableColumnSortSpecs}(x + 464)
    f === :SortSpecsMulti && return Ptr{ImVector_ImGuiTableColumnSortSpecs}(x + 480)
    f === :SortSpecs && return Ptr{ImGuiTableSortSpecs}(x + 496)
    f === :SortSpecsCount && return Ptr{ImGuiTableColumnIdx}(x + 512)
    f === :ColumnsEnabledCount && return Ptr{ImGuiTableColumnIdx}(x + 514)
    f === :ColumnsEnabledFixedCount && return Ptr{ImGuiTableColumnIdx}(x + 516)
    f === :DeclColumnsCount && return Ptr{ImGuiTableColumnIdx}(x + 518)
    f === :AngledHeadersCount && return Ptr{ImGuiTableColumnIdx}(x + 520)
    f === :HoveredColumnBody && return Ptr{ImGuiTableColumnIdx}(x + 522)
    f === :HoveredColumnBorder && return Ptr{ImGuiTableColumnIdx}(x + 524)
    f === :HighlightColumnHeader && return Ptr{ImGuiTableColumnIdx}(x + 526)
    f === :AutoFitSingleColumn && return Ptr{ImGuiTableColumnIdx}(x + 528)
    f === :ResizedColumn && return Ptr{ImGuiTableColumnIdx}(x + 530)
    f === :LastResizedColumn && return Ptr{ImGuiTableColumnIdx}(x + 532)
    f === :HeldHeaderColumn && return Ptr{ImGuiTableColumnIdx}(x + 534)
    f === :ReorderColumn && return Ptr{ImGuiTableColumnIdx}(x + 536)
    f === :ReorderColumnDir && return Ptr{ImGuiTableColumnIdx}(x + 538)
    f === :LeftMostEnabledColumn && return Ptr{ImGuiTableColumnIdx}(x + 540)
    f === :RightMostEnabledColumn && return Ptr{ImGuiTableColumnIdx}(x + 542)
    f === :LeftMostStretchedColumn && return Ptr{ImGuiTableColumnIdx}(x + 544)
    f === :RightMostStretchedColumn && return Ptr{ImGuiTableColumnIdx}(x + 546)
    f === :ContextPopupColumn && return Ptr{ImGuiTableColumnIdx}(x + 548)
    f === :FreezeRowsRequest && return Ptr{ImGuiTableColumnIdx}(x + 550)
    f === :FreezeRowsCount && return Ptr{ImGuiTableColumnIdx}(x + 552)
    f === :FreezeColumnsRequest && return Ptr{ImGuiTableColumnIdx}(x + 554)
    f === :FreezeColumnsCount && return Ptr{ImGuiTableColumnIdx}(x + 556)
    f === :RowCellDataCurrent && return Ptr{ImGuiTableColumnIdx}(x + 558)
    f === :DummyDrawChannel && return Ptr{ImGuiTableDrawChannelIdx}(x + 560)
    f === :Bg2DrawChannelCurrent && return Ptr{ImGuiTableDrawChannelIdx}(x + 562)
    f === :Bg2DrawChannelUnfrozen && return Ptr{ImGuiTableDrawChannelIdx}(x + 564)
    f === :IsLayoutLocked && return Ptr{Bool}(x + 566)
    f === :IsInsideRow && return Ptr{Bool}(x + 567)
    f === :IsInitializing && return Ptr{Bool}(x + 568)
    f === :IsSortSpecsDirty && return Ptr{Bool}(x + 569)
    f === :IsUsingHeaders && return Ptr{Bool}(x + 570)
    f === :IsContextPopupOpen && return Ptr{Bool}(x + 571)
    f === :DisableDefaultContextMenu && return Ptr{Bool}(x + 572)
    f === :IsSettingsRequestLoad && return Ptr{Bool}(x + 573)
    f === :IsSettingsDirty && return Ptr{Bool}(x + 574)
    f === :IsDefaultDisplayOrder && return Ptr{Bool}(x + 575)
    f === :IsResetAllRequest && return Ptr{Bool}(x + 576)
    f === :IsResetDisplayOrderRequest && return Ptr{Bool}(x + 577)
    f === :IsUnfrozenRows && return Ptr{Bool}(x + 578)
    f === :IsDefaultSizingPolicy && return Ptr{Bool}(x + 579)
    f === :IsActiveIdAliveBeforeTable && return Ptr{Bool}(x + 580)
    f === :IsActiveIdInTable && return Ptr{Bool}(x + 581)
    f === :HasScrollbarYCurr && return Ptr{Bool}(x + 582)
    f === :HasScrollbarYPrev && return Ptr{Bool}(x + 583)
    f === :MemoryCompacted && return Ptr{Bool}(x + 584)
    f === :HostSkipItems && return Ptr{Bool}(x + 585)
    return getfield(x, f)
end

function Base.getproperty(x::ImGuiTable, f::Symbol)
    r = Ref{ImGuiTable}(x)
    ptr = Base.unsafe_convert(Ptr{ImGuiTable}, r)
    fptr = getproperty(ptr, f)
    begin
        if fptr isa Ptr
            return GC.@preserve(r, unsafe_load(fptr))
        else
            (baseptr, offset, width) = fptr
            ty = eltype(baseptr)
            baseptr32 = convert(Ptr{UInt32}, baseptr)
            u64 = GC.@preserve(r, unsafe_load(baseptr32))
            if offset + width > 32
                u64 |= GC.@preserve(r, unsafe_load(baseptr32 + 4)) << 32
            end
            u64 = u64 >> offset & (1 << width - 1)
            return u64 % ty
        end
    end
end

function Base.setproperty!(x::Ptr{ImGuiTable}, f::Symbol, v)
    fptr = getproperty(x, f)
    if fptr isa Ptr
        unsafe_store!(getproperty(x, f), v)
    else
        (baseptr, offset, width) = fptr
        baseptr32 = convert(Ptr{UInt32}, baseptr)
        u64 = unsafe_load(baseptr32)
        straddle = offset + width > 32
        if straddle
            u64 |= unsafe_load(baseptr32 + 4) << 32
        end
        mask = 1 << width - 1
        u64 &= ~(mask << offset)
        u64 |= (unsigned(v) & mask) << offset
        unsafe_store!(baseptr32, u64 & typemax(UInt32))
        if straddle
            unsafe_store!(baseptr32 + 4, u64 >> 32)
        end
    end
end

struct ImVector_ImGuiTableTempData
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiTableTempData}
end

struct ImVector_ImGuiTable
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiTable}
end

const ImPoolIdx = Cint

struct ImPool_ImGuiTable
    Buf::ImVector_ImGuiTable
    Map::ImGuiStorage
    FreeIdx::ImPoolIdx
    AliveCount::ImPoolIdx
end

struct ImVector_ImGuiTabBar
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiTabBar}
end

struct ImPool_ImGuiTabBar
    Buf::ImVector_ImGuiTabBar
    Map::ImGuiStorage
    FreeIdx::ImPoolIdx
    AliveCount::ImPoolIdx
end

struct ImGuiPtrOrIndex
    Ptr::Ptr{Cvoid}
    Index::Cint
end

struct ImVector_ImGuiPtrOrIndex
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiPtrOrIndex}
end

struct ImGuiShrinkWidthItem
    Index::Cint
    Width::Cfloat
    InitialWidth::Cfloat
end

struct ImVector_ImGuiShrinkWidthItem
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiShrinkWidthItem}
end

struct ImGuiBoxSelectState
    data::NTuple{104, UInt8}
end

function Base.getproperty(x::Ptr{ImGuiBoxSelectState}, f::Symbol)
    f === :ID && return Ptr{ImGuiID}(x + 0)
    f === :IsActive && return Ptr{Bool}(x + 4)
    f === :IsStarting && return Ptr{Bool}(x + 5)
    f === :IsStartedFromVoid && return Ptr{Bool}(x + 6)
    f === :IsStartedSetNavIdOnce && return Ptr{Bool}(x + 7)
    f === :RequestClear && return Ptr{Bool}(x + 8)
    f === :KeyMods && return (Ptr{ImGuiKeyChord}(x + 8), 8, 16)
    f === :StartPosRel && return Ptr{ImVec2}(x + 12)
    f === :EndPosRel && return Ptr{ImVec2}(x + 20)
    f === :ScrollAccum && return Ptr{ImVec2}(x + 28)
    f === :Window && return Ptr{Ptr{ImGuiWindow}}(x + 40)
    f === :UnclipMode && return Ptr{Bool}(x + 48)
    f === :UnclipRect && return Ptr{ImRect}(x + 52)
    f === :BoxSelectRectPrev && return Ptr{ImRect}(x + 68)
    f === :BoxSelectRectCurr && return Ptr{ImRect}(x + 84)
    return getfield(x, f)
end

function Base.getproperty(x::ImGuiBoxSelectState, f::Symbol)
    r = Ref{ImGuiBoxSelectState}(x)
    ptr = Base.unsafe_convert(Ptr{ImGuiBoxSelectState}, r)
    fptr = getproperty(ptr, f)
    begin
        if fptr isa Ptr
            return GC.@preserve(r, unsafe_load(fptr))
        else
            (baseptr, offset, width) = fptr
            ty = eltype(baseptr)
            baseptr32 = convert(Ptr{UInt32}, baseptr)
            u64 = GC.@preserve(r, unsafe_load(baseptr32))
            if offset + width > 32
                u64 |= GC.@preserve(r, unsafe_load(baseptr32 + 4)) << 32
            end
            u64 = u64 >> offset & (1 << width - 1)
            return u64 % ty
        end
    end
end

function Base.setproperty!(x::Ptr{ImGuiBoxSelectState}, f::Symbol, v)
    fptr = getproperty(x, f)
    if fptr isa Ptr
        unsafe_store!(getproperty(x, f), v)
    else
        (baseptr, offset, width) = fptr
        baseptr32 = convert(Ptr{UInt32}, baseptr)
        u64 = unsafe_load(baseptr32)
        straddle = offset + width > 32
        if straddle
            u64 |= unsafe_load(baseptr32 + 4) << 32
        end
        mask = 1 << width - 1
        u64 &= ~(mask << offset)
        u64 |= (unsigned(v) & mask) << offset
        unsafe_store!(baseptr32, u64 & typemax(UInt32))
        if straddle
            unsafe_store!(baseptr32 + 4, u64 >> 32)
        end
    end
end

@cenum ImGuiSelectionRequestType::UInt32 begin
    ImGuiSelectionRequestType_None = 0
    ImGuiSelectionRequestType_SetAll = 1
    ImGuiSelectionRequestType_SetRange = 2
end

struct ImGuiSelectionRequest
    Type::ImGuiSelectionRequestType
    Selected::Bool
    RangeDirection::ImS8
    RangeFirstItem::ImGuiSelectionUserData
    RangeLastItem::ImGuiSelectionUserData
end

struct ImVector_ImGuiSelectionRequest
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiSelectionRequest}
end

struct ImGuiMultiSelectIO
    Requests::ImVector_ImGuiSelectionRequest
    RangeSrcItem::ImGuiSelectionUserData
    NavIdItem::ImGuiSelectionUserData
    NavIdSelected::Bool
    RangeSrcReset::Bool
    ItemsCount::Cint
end

struct ImGuiMultiSelectState
    Window::Ptr{ImGuiWindow}
    ID::ImGuiID
    LastFrameActive::Cint
    LastSelectionSize::Cint
    RangeSelected::ImS8
    NavIdSelected::ImS8
    RangeSrcItem::ImGuiSelectionUserData
    NavIdItem::ImGuiSelectionUserData
end

const ImGuiMultiSelectFlags = Cint

struct ImGuiMultiSelectTempData
    IO::ImGuiMultiSelectIO
    Storage::Ptr{ImGuiMultiSelectState}
    FocusScopeId::ImGuiID
    Flags::ImGuiMultiSelectFlags
    ScopeRectMin::ImVec2
    BackupCursorMaxPos::ImVec2
    LastSubmittedItem::ImGuiSelectionUserData
    BoxSelectId::ImGuiID
    KeyMods::ImGuiKeyChord
    LoopRequestSetAll::ImS8
    IsEndIO::Bool
    IsFocused::Bool
    IsKeyboardSetRange::Bool
    NavIdPassedBy::Bool
    RangeSrcPassedBy::Bool
    RangeDstPassedBy::Bool
end

struct ImVector_ImGuiMultiSelectTempData
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiMultiSelectTempData}
end

struct ImVector_ImGuiMultiSelectState
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiMultiSelectState}
end

struct ImPool_ImGuiMultiSelectState
    Buf::ImVector_ImGuiMultiSelectState
    Map::ImGuiStorage
    FreeIdx::ImPoolIdx
    AliveCount::ImPoolIdx
end

const ImGuiMouseCursor = Cint

struct StbUndoRecord
    where::Cint
    insert_length::Cint
    delete_length::Cint
    char_storage::Cint
end

struct StbUndoState
    undo_rec::NTuple{99, StbUndoRecord}
    undo_char::NTuple{999, ImWchar}
    undo_point::Cshort
    redo_point::Cshort
    undo_char_point::Cint
    redo_char_point::Cint
end

struct STB_TexteditState
    cursor::Cint
    select_start::Cint
    select_end::Cint
    insert_mode::Cuchar
    row_count_per_page::Cint
    cursor_at_end_of_line::Cuchar
    initialized::Cuchar
    has_preferred_x::Cuchar
    single_line::Cuchar
    padding1::Cuchar
    padding2::Cuchar
    padding3::Cuchar
    preferred_x::Cfloat
    undostate::StbUndoState
end

const ImGuiInputTextFlags = Cint

struct ImGuiInputTextState
    Ctx::Ptr{Cvoid} # Ctx::Ptr{ImGuiContext}
    ID::ImGuiID
    CurLenW::Cint
    CurLenA::Cint
    TextW::ImVector_ImWchar
    TextA::ImVector_char
    InitialTextA::ImVector_char
    TextAIsValid::Bool
    BufCapacityA::Cint
    ScrollX::Cfloat
    Stb::STB_TexteditState
    CursorAnim::Cfloat
    CursorFollow::Bool
    SelectedAllMouseLock::Bool
    Edited::Bool
    Flags::ImGuiInputTextFlags
    ReloadUserBuf::Bool
    ReloadSelectionStart::Cint
    ReloadSelectionEnd::Cint
end

function Base.getproperty(x::ImGuiInputTextState, f::Symbol)
    f === :Ctx && return Ptr{ImGuiContext}(getfield(x, f))
    return getfield(x, f)
end

struct ImGuiInputTextDeactivatedState
    ID::ImGuiID
    TextA::ImVector_char
end

const ImGuiColorEditFlags = Cint

struct ImGuiComboPreviewData
    PreviewRect::ImRect
    BackupCursorPos::ImVec2
    BackupCursorMaxPos::ImVec2
    BackupCursorPosPrevLine::ImVec2
    BackupPrevLineTextBaseOffset::Cfloat
    BackupLayout::ImGuiLayoutType
end

const ImGuiTypingSelectFlags = Cint

struct ImGuiTypingSelectRequest
    Flags::ImGuiTypingSelectFlags
    SearchBufferLen::Cint
    SearchBuffer::Ptr{Cchar}
    SelectRequest::Bool
    SingleCharMode::Bool
    SingleCharSize::ImS8
end

struct ImGuiTypingSelectState
    Request::ImGuiTypingSelectRequest
    SearchBuffer::NTuple{64, Cchar}
    FocusScope::ImGuiID
    LastRequestFrame::Cint
    LastRequestTime::Cfloat
    SingleCharModeLock::Bool
end

struct ImGuiPlatformImeData
    WantVisible::Bool
    InputPos::ImVec2
    InputLineHeight::Cfloat
end

mutable struct ImGuiDockRequest end

struct ImVector_ImGuiDockRequest
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiDockRequest}
end

mutable struct ImGuiDockNodeSettings end

struct ImVector_ImGuiDockNodeSettings
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiDockNodeSettings}
end

struct ImGuiDockContext
    Nodes::ImGuiStorage
    Requests::ImVector_ImGuiDockRequest
    NodesSettings::ImVector_ImGuiDockNodeSettings
    WantFullRebuild::Bool
end

struct ImGuiSettingsHandler
    TypeName::Ptr{Cchar}
    TypeHash::ImGuiID
    ClearAllFn::Ptr{Cvoid}
    ReadInitFn::Ptr{Cvoid}
    ReadOpenFn::Ptr{Cvoid}
    ReadLineFn::Ptr{Cvoid}
    ApplyAllFn::Ptr{Cvoid}
    WriteAllFn::Ptr{Cvoid}
    UserData::Ptr{Cvoid}
end

struct ImVector_ImGuiSettingsHandler
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiSettingsHandler}
end

struct ImChunkStream_ImGuiWindowSettings
    Buf::ImVector_char
end

struct ImChunkStream_ImGuiTableSettings
    Buf::ImVector_char
end

@cenum ImGuiContextHookType::UInt32 begin
    ImGuiContextHookType_NewFramePre = 0
    ImGuiContextHookType_NewFramePost = 1
    ImGuiContextHookType_EndFramePre = 2
    ImGuiContextHookType_EndFramePost = 3
    ImGuiContextHookType_RenderPre = 4
    ImGuiContextHookType_RenderPost = 5
    ImGuiContextHookType_Shutdown = 6
    ImGuiContextHookType_PendingRemoval_ = 7
end

# typedef void ( * ImGuiContextHookCallback ) ( ImGuiContext * ctx , ImGuiContextHook * hook )
const ImGuiContextHookCallback = Ptr{Cvoid}

struct ImGuiContextHook
    HookId::ImGuiID
    Type::ImGuiContextHookType
    Owner::ImGuiID
    Callback::ImGuiContextHookCallback
    UserData::Ptr{Cvoid}
end

struct ImVector_ImGuiContextHook
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiContextHook}
end

@cenum ImGuiLogType::UInt32 begin
    ImGuiLogType_None = 0
    ImGuiLogType_TTY = 1
    ImGuiLogType_File = 2
    ImGuiLogType_Buffer = 3
    ImGuiLogType_Clipboard = 4
end

const ImFileHandle = Ptr{Libc.FILE}

const ImGuiDebugLogFlags = Cint

struct ImVector_int
    Size::Cint
    Capacity::Cint
    Data::Ptr{Cint}
end

struct ImGuiTextIndex
    LineOffsets::ImVector_int
    EndOffset::Cint
end

struct ImGuiMetricsConfig
    ShowDebugLog::Bool
    ShowIDStackTool::Bool
    ShowWindowsRects::Bool
    ShowWindowsBeginOrder::Bool
    ShowTablesRects::Bool
    ShowDrawCmdMesh::Bool
    ShowDrawCmdBoundingBoxes::Bool
    ShowTextEncodingViewer::Bool
    ShowAtlasTintedWithTextColor::Bool
    ShowDockingNodes::Bool
    ShowWindowsRectsType::Cint
    ShowTablesRectsType::Cint
    HighlightMonitorIdx::Cint
    HighlightViewportID::ImGuiID
end

const ImGuiDataType = Cint

struct ImGuiStackLevelInfo
    data::NTuple{64, UInt8}
end

function Base.getproperty(x::Ptr{ImGuiStackLevelInfo}, f::Symbol)
    f === :ID && return Ptr{ImGuiID}(x + 0)
    f === :QueryFrameCount && return Ptr{ImS8}(x + 4)
    f === :QuerySuccess && return Ptr{Bool}(x + 5)
    f === :DataType && return (Ptr{ImGuiDataType}(x + 4), 16, 8)
    f === :Desc && return Ptr{NTuple{57, Cchar}}(x + 7)
    return getfield(x, f)
end

function Base.getproperty(x::ImGuiStackLevelInfo, f::Symbol)
    r = Ref{ImGuiStackLevelInfo}(x)
    ptr = Base.unsafe_convert(Ptr{ImGuiStackLevelInfo}, r)
    fptr = getproperty(ptr, f)
    begin
        if fptr isa Ptr
            return GC.@preserve(r, unsafe_load(fptr))
        else
            (baseptr, offset, width) = fptr
            ty = eltype(baseptr)
            baseptr32 = convert(Ptr{UInt32}, baseptr)
            u64 = GC.@preserve(r, unsafe_load(baseptr32))
            if offset + width > 32
                u64 |= GC.@preserve(r, unsafe_load(baseptr32 + 4)) << 32
            end
            u64 = u64 >> offset & (1 << width - 1)
            return u64 % ty
        end
    end
end

function Base.setproperty!(x::Ptr{ImGuiStackLevelInfo}, f::Symbol, v)
    fptr = getproperty(x, f)
    if fptr isa Ptr
        unsafe_store!(getproperty(x, f), v)
    else
        (baseptr, offset, width) = fptr
        baseptr32 = convert(Ptr{UInt32}, baseptr)
        u64 = unsafe_load(baseptr32)
        straddle = offset + width > 32
        if straddle
            u64 |= unsafe_load(baseptr32 + 4) << 32
        end
        mask = 1 << width - 1
        u64 &= ~(mask << offset)
        u64 |= (unsigned(v) & mask) << offset
        unsafe_store!(baseptr32, u64 & typemax(UInt32))
        if straddle
            unsafe_store!(baseptr32 + 4, u64 >> 32)
        end
    end
end

struct ImVector_ImGuiStackLevelInfo
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiStackLevelInfo}
end

struct ImGuiIDStackTool
    LastActiveFrame::Cint
    StackLevel::Cint
    QueryId::ImGuiID
    Results::ImVector_ImGuiStackLevelInfo
    CopyToClipboardOnCtrlC::Bool
    CopyToClipboardLastTime::Cfloat
end

struct ImGuiDebugAllocEntry
    FrameCount::Cint
    AllocCount::ImS16
    FreeCount::ImS16
end

struct ImGuiDebugAllocInfo
    TotalAllocCount::Cint
    TotalFreeCount::Cint
    LastEntriesIdx::ImS16
    LastEntriesBuf::NTuple{6, ImGuiDebugAllocEntry}
end

struct ImGuiContext
    data::NTuple{14504, UInt8}
end

function Base.getproperty(x::Ptr{ImGuiContext}, f::Symbol)
    f === :Initialized && return Ptr{Bool}(x + 0)
    f === :FontAtlasOwnedByContext && return Ptr{Bool}(x + 1)
    f === :IO && return Ptr{ImGuiIO}(x + 8)
    f === :PlatformIO && return Ptr{ImGuiPlatformIO}(x + 3056)
    f === :Style && return Ptr{ImGuiStyle}(x + 3272)
    f === :ConfigFlagsCurrFrame && return Ptr{ImGuiConfigFlags}(x + 4464)
    f === :ConfigFlagsLastFrame && return Ptr{ImGuiConfigFlags}(x + 4468)
    f === :Font && return Ptr{Ptr{ImFont}}(x + 4472)
    f === :FontSize && return Ptr{Cfloat}(x + 4480)
    f === :FontBaseSize && return Ptr{Cfloat}(x + 4484)
    f === :FontScale && return Ptr{Cfloat}(x + 4488)
    f === :CurrentDpiScale && return Ptr{Cfloat}(x + 4492)
    f === :DrawListSharedData && return Ptr{ImDrawListSharedData}(x + 4496)
    f === :Time && return Ptr{Cdouble}(x + 5032)
    f === :FrameCount && return Ptr{Cint}(x + 5040)
    f === :FrameCountEnded && return Ptr{Cint}(x + 5044)
    f === :FrameCountPlatformEnded && return Ptr{Cint}(x + 5048)
    f === :FrameCountRendered && return Ptr{Cint}(x + 5052)
    f === :WithinFrameScope && return Ptr{Bool}(x + 5056)
    f === :WithinFrameScopeWithImplicitWindow && return Ptr{Bool}(x + 5057)
    f === :WithinEndChild && return Ptr{Bool}(x + 5058)
    f === :GcCompactAll && return Ptr{Bool}(x + 5059)
    f === :TestEngineHookItems && return Ptr{Bool}(x + 5060)
    f === :TestEngine && return Ptr{Ptr{Cvoid}}(x + 5064)
    f === :ContextName && return Ptr{NTuple{16, Cchar}}(x + 5072)
    f === :InputEventsQueue && return Ptr{ImVector_ImGuiInputEvent}(x + 5088)
    f === :InputEventsTrail && return Ptr{ImVector_ImGuiInputEvent}(x + 5104)
    f === :InputEventsNextMouseSource && return Ptr{ImGuiMouseSource}(x + 5120)
    f === :InputEventsNextEventId && return Ptr{ImU32}(x + 5124)
    f === :Windows && return Ptr{ImVector_ImGuiWindowPtr}(x + 5128)
    f === :WindowsFocusOrder && return Ptr{ImVector_ImGuiWindowPtr}(x + 5144)
    f === :WindowsTempSortBuffer && return Ptr{ImVector_ImGuiWindowPtr}(x + 5160)
    f === :CurrentWindowStack && return Ptr{ImVector_ImGuiWindowStackData}(x + 5176)
    f === :WindowsById && return Ptr{ImGuiStorage}(x + 5192)
    f === :WindowsActiveCount && return Ptr{Cint}(x + 5208)
    f === :WindowsHoverPadding && return Ptr{ImVec2}(x + 5212)
    f === :DebugBreakInWindow && return Ptr{ImGuiID}(x + 5220)
    f === :CurrentWindow && return Ptr{Ptr{ImGuiWindow}}(x + 5224)
    f === :HoveredWindow && return Ptr{Ptr{ImGuiWindow}}(x + 5232)
    f === :HoveredWindowUnderMovingWindow && return Ptr{Ptr{ImGuiWindow}}(x + 5240)
    f === :HoveredWindowBeforeClear && return Ptr{Ptr{ImGuiWindow}}(x + 5248)
    f === :MovingWindow && return Ptr{Ptr{ImGuiWindow}}(x + 5256)
    f === :WheelingWindow && return Ptr{Ptr{ImGuiWindow}}(x + 5264)
    f === :WheelingWindowRefMousePos && return Ptr{ImVec2}(x + 5272)
    f === :WheelingWindowStartFrame && return Ptr{Cint}(x + 5280)
    f === :WheelingWindowScrolledFrame && return Ptr{Cint}(x + 5284)
    f === :WheelingWindowReleaseTimer && return Ptr{Cfloat}(x + 5288)
    f === :WheelingWindowWheelRemainder && return Ptr{ImVec2}(x + 5292)
    f === :WheelingAxisAvg && return Ptr{ImVec2}(x + 5300)
    f === :DebugHookIdInfo && return Ptr{ImGuiID}(x + 5308)
    f === :HoveredId && return Ptr{ImGuiID}(x + 5312)
    f === :HoveredIdPreviousFrame && return Ptr{ImGuiID}(x + 5316)
    f === :HoveredIdTimer && return Ptr{Cfloat}(x + 5320)
    f === :HoveredIdNotActiveTimer && return Ptr{Cfloat}(x + 5324)
    f === :HoveredIdAllowOverlap && return Ptr{Bool}(x + 5328)
    f === :HoveredIdIsDisabled && return Ptr{Bool}(x + 5329)
    f === :ItemUnclipByLog && return Ptr{Bool}(x + 5330)
    f === :ActiveId && return Ptr{ImGuiID}(x + 5332)
    f === :ActiveIdIsAlive && return Ptr{ImGuiID}(x + 5336)
    f === :ActiveIdTimer && return Ptr{Cfloat}(x + 5340)
    f === :ActiveIdIsJustActivated && return Ptr{Bool}(x + 5344)
    f === :ActiveIdAllowOverlap && return Ptr{Bool}(x + 5345)
    f === :ActiveIdNoClearOnFocusLoss && return Ptr{Bool}(x + 5346)
    f === :ActiveIdHasBeenPressedBefore && return Ptr{Bool}(x + 5347)
    f === :ActiveIdHasBeenEditedBefore && return Ptr{Bool}(x + 5348)
    f === :ActiveIdHasBeenEditedThisFrame && return Ptr{Bool}(x + 5349)
    f === :ActiveIdFromShortcut && return Ptr{Bool}(x + 5350)
    f === :ActiveIdMouseButton && return (Ptr{Cint}(x + 5348), 24, 8)
    f === :ActiveIdClickOffset && return Ptr{ImVec2}(x + 5352)
    f === :ActiveIdWindow && return Ptr{Ptr{ImGuiWindow}}(x + 5360)
    f === :ActiveIdSource && return Ptr{ImGuiInputSource}(x + 5368)
    f === :ActiveIdPreviousFrame && return Ptr{ImGuiID}(x + 5372)
    f === :ActiveIdPreviousFrameIsAlive && return Ptr{Bool}(x + 5376)
    f === :ActiveIdPreviousFrameHasBeenEditedBefore && return Ptr{Bool}(x + 5377)
    f === :ActiveIdPreviousFrameWindow && return Ptr{Ptr{ImGuiWindow}}(x + 5384)
    f === :LastActiveId && return Ptr{ImGuiID}(x + 5392)
    f === :LastActiveIdTimer && return Ptr{Cfloat}(x + 5396)
    f === :LastKeyModsChangeTime && return Ptr{Cdouble}(x + 5400)
    f === :LastKeyModsChangeFromNoneTime && return Ptr{Cdouble}(x + 5408)
    f === :LastKeyboardKeyPressTime && return Ptr{Cdouble}(x + 5416)
    f === :KeysMayBeCharInput && return Ptr{ImBitArrayForNamedKeys}(x + 5424)
    f === :KeysOwnerData && return Ptr{NTuple{154, ImGuiKeyOwnerData}}(x + 5444)
    f === :KeysRoutingTable && return Ptr{ImGuiKeyRoutingTable}(x + 7296)
    f === :ActiveIdUsingNavDirMask && return Ptr{ImU32}(x + 7640)
    f === :ActiveIdUsingAllKeyboardKeys && return Ptr{Bool}(x + 7644)
    f === :DebugBreakInShortcutRouting && return Ptr{ImGuiKeyChord}(x + 7648)
    f === :CurrentFocusScopeId && return Ptr{ImGuiID}(x + 7652)
    f === :CurrentItemFlags && return Ptr{ImGuiItemFlags}(x + 7656)
    f === :DebugLocateId && return Ptr{ImGuiID}(x + 7660)
    f === :NextItemData && return Ptr{ImGuiNextItemData}(x + 7664)
    f === :LastItemData && return Ptr{ImGuiLastItemData}(x + 7720)
    f === :NextWindowData && return Ptr{ImGuiNextWindowData}(x + 7800)
    f === :DebugShowGroupRects && return Ptr{Bool}(x + 7960)
    f === :DebugFlashStyleColorIdx && return Ptr{ImGuiCol}(x + 7964)
    f === :ColorStack && return Ptr{ImVector_ImGuiColorMod}(x + 7968)
    f === :StyleVarStack && return Ptr{ImVector_ImGuiStyleMod}(x + 7984)
    f === :FontStack && return Ptr{ImVector_ImFontPtr}(x + 8000)
    f === :FocusScopeStack && return Ptr{ImVector_ImGuiFocusScopeData}(x + 8016)
    f === :ItemFlagsStack && return Ptr{ImVector_ImGuiItemFlags}(x + 8032)
    f === :GroupStack && return Ptr{ImVector_ImGuiGroupData}(x + 8048)
    f === :OpenPopupStack && return Ptr{ImVector_ImGuiPopupData}(x + 8064)
    f === :BeginPopupStack && return Ptr{ImVector_ImGuiPopupData}(x + 8080)
    f === :TreeNodeStack && return Ptr{ImVector_ImGuiTreeNodeStackData}(x + 8096)
    f === :Viewports && return Ptr{ImVector_ImGuiViewportPPtr}(x + 8112)
    f === :CurrentViewport && return Ptr{Ptr{ImGuiViewportP}}(x + 8128)
    f === :MouseViewport && return Ptr{Ptr{ImGuiViewportP}}(x + 8136)
    f === :MouseLastHoveredViewport && return Ptr{Ptr{ImGuiViewportP}}(x + 8144)
    f === :PlatformLastFocusedViewportId && return Ptr{ImGuiID}(x + 8152)
    f === :FallbackMonitor && return Ptr{ImGuiPlatformMonitor}(x + 8160)
    f === :PlatformMonitorsFullWorkRect && return Ptr{ImRect}(x + 8208)
    f === :ViewportCreatedCount && return Ptr{Cint}(x + 8224)
    f === :PlatformWindowsCreatedCount && return Ptr{Cint}(x + 8228)
    f === :ViewportFocusedStampCount && return Ptr{Cint}(x + 8232)
    f === :NavWindow && return Ptr{Ptr{ImGuiWindow}}(x + 8240)
    f === :NavId && return Ptr{ImGuiID}(x + 8248)
    f === :NavFocusScopeId && return Ptr{ImGuiID}(x + 8252)
    f === :NavLayer && return Ptr{ImGuiNavLayer}(x + 8256)
    f === :NavActivateId && return Ptr{ImGuiID}(x + 8260)
    f === :NavActivateDownId && return Ptr{ImGuiID}(x + 8264)
    f === :NavActivatePressedId && return Ptr{ImGuiID}(x + 8268)
    f === :NavActivateFlags && return Ptr{ImGuiActivateFlags}(x + 8272)
    f === :NavFocusRoute && return Ptr{ImVector_ImGuiFocusScopeData}(x + 8280)
    f === :NavHighlightActivatedId && return Ptr{ImGuiID}(x + 8296)
    f === :NavHighlightActivatedTimer && return Ptr{Cfloat}(x + 8300)
    f === :NavNextActivateId && return Ptr{ImGuiID}(x + 8304)
    f === :NavNextActivateFlags && return Ptr{ImGuiActivateFlags}(x + 8308)
    f === :NavInputSource && return Ptr{ImGuiInputSource}(x + 8312)
    f === :NavLastValidSelectionUserData && return Ptr{ImGuiSelectionUserData}(x + 8320)
    f === :NavIdIsAlive && return Ptr{Bool}(x + 8328)
    f === :NavMousePosDirty && return Ptr{Bool}(x + 8329)
    f === :NavDisableHighlight && return Ptr{Bool}(x + 8330)
    f === :NavDisableMouseHover && return Ptr{Bool}(x + 8331)
    f === :NavAnyRequest && return Ptr{Bool}(x + 8332)
    f === :NavInitRequest && return Ptr{Bool}(x + 8333)
    f === :NavInitRequestFromMove && return Ptr{Bool}(x + 8334)
    f === :NavInitResult && return Ptr{ImGuiNavItemData}(x + 8336)
    f === :NavMoveSubmitted && return Ptr{Bool}(x + 8392)
    f === :NavMoveScoringItems && return Ptr{Bool}(x + 8393)
    f === :NavMoveForwardToNextFrame && return Ptr{Bool}(x + 8394)
    f === :NavMoveFlags && return Ptr{ImGuiNavMoveFlags}(x + 8396)
    f === :NavMoveScrollFlags && return Ptr{ImGuiScrollFlags}(x + 8400)
    f === :NavMoveKeyMods && return Ptr{ImGuiKeyChord}(x + 8404)
    f === :NavMoveDir && return Ptr{ImGuiDir}(x + 8408)
    f === :NavMoveDirForDebug && return Ptr{ImGuiDir}(x + 8412)
    f === :NavMoveClipDir && return Ptr{ImGuiDir}(x + 8416)
    f === :NavScoringRect && return Ptr{ImRect}(x + 8420)
    f === :NavScoringNoClipRect && return Ptr{ImRect}(x + 8436)
    f === :NavScoringDebugCount && return Ptr{Cint}(x + 8452)
    f === :NavTabbingDir && return Ptr{Cint}(x + 8456)
    f === :NavTabbingCounter && return Ptr{Cint}(x + 8460)
    f === :NavMoveResultLocal && return Ptr{ImGuiNavItemData}(x + 8464)
    f === :NavMoveResultLocalVisible && return Ptr{ImGuiNavItemData}(x + 8520)
    f === :NavMoveResultOther && return Ptr{ImGuiNavItemData}(x + 8576)
    f === :NavTabbingResultFirst && return Ptr{ImGuiNavItemData}(x + 8632)
    f === :NavJustMovedFromFocusScopeId && return Ptr{ImGuiID}(x + 8688)
    f === :NavJustMovedToId && return Ptr{ImGuiID}(x + 8692)
    f === :NavJustMovedToFocusScopeId && return Ptr{ImGuiID}(x + 8696)
    f === :NavJustMovedToKeyMods && return Ptr{ImGuiKeyChord}(x + 8700)
    f === :NavJustMovedToIsTabbing && return Ptr{Bool}(x + 8704)
    f === :NavJustMovedToHasSelectionData && return Ptr{Bool}(x + 8705)
    f === :ConfigNavWindowingKeyNext && return Ptr{ImGuiKeyChord}(x + 8708)
    f === :ConfigNavWindowingKeyPrev && return Ptr{ImGuiKeyChord}(x + 8712)
    f === :NavWindowingTarget && return Ptr{Ptr{ImGuiWindow}}(x + 8720)
    f === :NavWindowingTargetAnim && return Ptr{Ptr{ImGuiWindow}}(x + 8728)
    f === :NavWindowingListWindow && return Ptr{Ptr{ImGuiWindow}}(x + 8736)
    f === :NavWindowingTimer && return Ptr{Cfloat}(x + 8744)
    f === :NavWindowingHighlightAlpha && return Ptr{Cfloat}(x + 8748)
    f === :NavWindowingToggleLayer && return Ptr{Bool}(x + 8752)
    f === :NavWindowingToggleKey && return Ptr{ImGuiKey}(x + 8756)
    f === :NavWindowingAccumDeltaPos && return Ptr{ImVec2}(x + 8760)
    f === :NavWindowingAccumDeltaSize && return Ptr{ImVec2}(x + 8768)
    f === :DimBgRatio && return Ptr{Cfloat}(x + 8776)
    f === :DragDropActive && return Ptr{Bool}(x + 8780)
    f === :DragDropWithinSource && return Ptr{Bool}(x + 8781)
    f === :DragDropWithinTarget && return Ptr{Bool}(x + 8782)
    f === :DragDropSourceFlags && return Ptr{ImGuiDragDropFlags}(x + 8784)
    f === :DragDropSourceFrameCount && return Ptr{Cint}(x + 8788)
    f === :DragDropMouseButton && return Ptr{Cint}(x + 8792)
    f === :DragDropPayload && return Ptr{ImGuiPayload}(x + 8800)
    f === :DragDropTargetRect && return Ptr{ImRect}(x + 8864)
    f === :DragDropTargetClipRect && return Ptr{ImRect}(x + 8880)
    f === :DragDropTargetId && return Ptr{ImGuiID}(x + 8896)
    f === :DragDropAcceptFlags && return Ptr{ImGuiDragDropFlags}(x + 8900)
    f === :DragDropAcceptIdCurrRectSurface && return Ptr{Cfloat}(x + 8904)
    f === :DragDropAcceptIdCurr && return Ptr{ImGuiID}(x + 8908)
    f === :DragDropAcceptIdPrev && return Ptr{ImGuiID}(x + 8912)
    f === :DragDropAcceptFrameCount && return Ptr{Cint}(x + 8916)
    f === :DragDropHoldJustPressedId && return Ptr{ImGuiID}(x + 8920)
    f === :DragDropPayloadBufHeap && return Ptr{ImVector_unsigned_char}(x + 8928)
    f === :DragDropPayloadBufLocal && return Ptr{NTuple{16, Cuchar}}(x + 8944)
    f === :ClipperTempDataStacked && return Ptr{Cint}(x + 8960)
    f === :ClipperTempData && return Ptr{ImVector_ImGuiListClipperData}(x + 8968)
    f === :CurrentTable && return Ptr{Ptr{ImGuiTable}}(x + 8984)
    f === :DebugBreakInTable && return Ptr{ImGuiID}(x + 8992)
    f === :TablesTempDataStacked && return Ptr{Cint}(x + 8996)
    f === :TablesTempData && return Ptr{ImVector_ImGuiTableTempData}(x + 9000)
    f === :Tables && return Ptr{ImPool_ImGuiTable}(x + 9016)
    f === :TablesLastTimeActive && return Ptr{ImVector_float}(x + 9056)
    f === :DrawChannelsTempMergeBuffer && return Ptr{ImVector_ImDrawChannel}(x + 9072)
    f === :CurrentTabBar && return Ptr{Ptr{ImGuiTabBar}}(x + 9088)
    f === :TabBars && return Ptr{ImPool_ImGuiTabBar}(x + 9096)
    f === :CurrentTabBarStack && return Ptr{ImVector_ImGuiPtrOrIndex}(x + 9136)
    f === :ShrinkWidthBuffer && return Ptr{ImVector_ImGuiShrinkWidthItem}(x + 9152)
    f === :BoxSelectState && return Ptr{ImGuiBoxSelectState}(x + 9168)
    f === :CurrentMultiSelect && return Ptr{Ptr{ImGuiMultiSelectTempData}}(x + 9272)
    f === :MultiSelectTempDataStacked && return Ptr{Cint}(x + 9280)
    f === :MultiSelectTempData && return Ptr{ImVector_ImGuiMultiSelectTempData}(x + 9288)
    f === :MultiSelectStorage && return Ptr{ImPool_ImGuiMultiSelectState}(x + 9304)
    f === :HoverItemDelayId && return Ptr{ImGuiID}(x + 9344)
    f === :HoverItemDelayIdPreviousFrame && return Ptr{ImGuiID}(x + 9348)
    f === :HoverItemDelayTimer && return Ptr{Cfloat}(x + 9352)
    f === :HoverItemDelayClearTimer && return Ptr{Cfloat}(x + 9356)
    f === :HoverItemUnlockedStationaryId && return Ptr{ImGuiID}(x + 9360)
    f === :HoverWindowUnlockedStationaryId && return Ptr{ImGuiID}(x + 9364)
    f === :MouseCursor && return Ptr{ImGuiMouseCursor}(x + 9368)
    f === :MouseStationaryTimer && return Ptr{Cfloat}(x + 9372)
    f === :MouseLastValidPos && return Ptr{ImVec2}(x + 9376)
    f === :InputTextState && return Ptr{ImGuiInputTextState}(x + 9384)
    f === :InputTextDeactivatedState && return Ptr{ImGuiInputTextDeactivatedState}(x + 13120)
    f === :InputTextPasswordFont && return Ptr{ImFont}(x + 13144)
    f === :TempInputId && return Ptr{ImGuiID}(x + 13264)
    f === :DataTypeZeroValue && return Ptr{ImGuiDataTypeStorage}(x + 13268)
    f === :BeginMenuDepth && return Ptr{Cint}(x + 13276)
    f === :BeginComboDepth && return Ptr{Cint}(x + 13280)
    f === :ColorEditOptions && return Ptr{ImGuiColorEditFlags}(x + 13284)
    f === :ColorEditCurrentID && return Ptr{ImGuiID}(x + 13288)
    f === :ColorEditSavedID && return Ptr{ImGuiID}(x + 13292)
    f === :ColorEditSavedHue && return Ptr{Cfloat}(x + 13296)
    f === :ColorEditSavedSat && return Ptr{Cfloat}(x + 13300)
    f === :ColorEditSavedColor && return Ptr{ImU32}(x + 13304)
    f === :ColorPickerRef && return Ptr{ImVec4}(x + 13308)
    f === :ComboPreviewData && return Ptr{ImGuiComboPreviewData}(x + 13324)
    f === :WindowResizeBorderExpectedRect && return Ptr{ImRect}(x + 13372)
    f === :WindowResizeRelativeMode && return Ptr{Bool}(x + 13388)
    f === :ScrollbarSeekMode && return Ptr{Cshort}(x + 13390)
    f === :ScrollbarClickDeltaToGrabCenter && return Ptr{Cfloat}(x + 13392)
    f === :SliderGrabClickOffset && return Ptr{Cfloat}(x + 13396)
    f === :SliderCurrentAccum && return Ptr{Cfloat}(x + 13400)
    f === :SliderCurrentAccumDirty && return Ptr{Bool}(x + 13404)
    f === :DragCurrentAccumDirty && return Ptr{Bool}(x + 13405)
    f === :DragCurrentAccum && return Ptr{Cfloat}(x + 13408)
    f === :DragSpeedDefaultRatio && return Ptr{Cfloat}(x + 13412)
    f === :DisabledAlphaBackup && return Ptr{Cfloat}(x + 13416)
    f === :DisabledStackSize && return Ptr{Cshort}(x + 13420)
    f === :LockMarkEdited && return Ptr{Cshort}(x + 13422)
    f === :TooltipOverrideCount && return Ptr{Cshort}(x + 13424)
    f === :ClipboardHandlerData && return Ptr{ImVector_char}(x + 13432)
    f === :MenusIdSubmittedThisFrame && return Ptr{ImVector_ImGuiID}(x + 13448)
    f === :TypingSelectState && return Ptr{ImGuiTypingSelectState}(x + 13464)
    f === :PlatformImeData && return Ptr{ImGuiPlatformImeData}(x + 13568)
    f === :PlatformImeDataPrev && return Ptr{ImGuiPlatformImeData}(x + 13584)
    f === :PlatformImeViewport && return Ptr{ImGuiID}(x + 13600)
    f === :DockContext && return Ptr{ImGuiDockContext}(x + 13608)
    f === :DockNodeWindowMenuHandler && return Ptr{Ptr{Cvoid}}(x + 13664)
    f === :SettingsLoaded && return Ptr{Bool}(x + 13672)
    f === :SettingsDirtyTimer && return Ptr{Cfloat}(x + 13676)
    f === :SettingsIniData && return Ptr{ImGuiTextBuffer}(x + 13680)
    f === :SettingsHandlers && return Ptr{ImVector_ImGuiSettingsHandler}(x + 13696)
    f === :SettingsWindows && return Ptr{ImChunkStream_ImGuiWindowSettings}(x + 13712)
    f === :SettingsTables && return Ptr{ImChunkStream_ImGuiTableSettings}(x + 13728)
    f === :Hooks && return Ptr{ImVector_ImGuiContextHook}(x + 13744)
    f === :HookIdNext && return Ptr{ImGuiID}(x + 13760)
    f === :LocalizationTable && return Ptr{NTuple{12, Ptr{Cchar}}}(x + 13768)
    f === :LogEnabled && return Ptr{Bool}(x + 13864)
    f === :LogType && return Ptr{ImGuiLogType}(x + 13868)
    f === :LogFile && return Ptr{ImFileHandle}(x + 13872)
    f === :LogBuffer && return Ptr{ImGuiTextBuffer}(x + 13880)
    f === :LogNextPrefix && return Ptr{Ptr{Cchar}}(x + 13896)
    f === :LogNextSuffix && return Ptr{Ptr{Cchar}}(x + 13904)
    f === :LogLinePosY && return Ptr{Cfloat}(x + 13912)
    f === :LogLineFirstItem && return Ptr{Bool}(x + 13916)
    f === :LogDepthRef && return Ptr{Cint}(x + 13920)
    f === :LogDepthToExpand && return Ptr{Cint}(x + 13924)
    f === :LogDepthToExpandDefault && return Ptr{Cint}(x + 13928)
    f === :DebugLogFlags && return Ptr{ImGuiDebugLogFlags}(x + 13932)
    f === :DebugLogBuf && return Ptr{ImGuiTextBuffer}(x + 13936)
    f === :DebugLogIndex && return Ptr{ImGuiTextIndex}(x + 13952)
    f === :DebugLogAutoDisableFlags && return Ptr{ImGuiDebugLogFlags}(x + 13976)
    f === :DebugLogAutoDisableFrames && return Ptr{ImU8}(x + 13980)
    f === :DebugLocateFrames && return Ptr{ImU8}(x + 13981)
    f === :DebugBreakInLocateId && return Ptr{Bool}(x + 13982)
    f === :DebugBreakKeyChord && return Ptr{ImGuiKeyChord}(x + 13984)
    f === :DebugBeginReturnValueCullDepth && return Ptr{ImS8}(x + 13988)
    f === :DebugItemPickerActive && return Ptr{Bool}(x + 13989)
    f === :DebugItemPickerMouseButton && return Ptr{ImU8}(x + 13990)
    f === :DebugItemPickerBreakId && return Ptr{ImGuiID}(x + 13992)
    f === :DebugFlashStyleColorTime && return Ptr{Cfloat}(x + 13996)
    f === :DebugFlashStyleColorBackup && return Ptr{ImVec4}(x + 14000)
    f === :DebugMetricsConfig && return Ptr{ImGuiMetricsConfig}(x + 14016)
    f === :DebugIDStackTool && return Ptr{ImGuiIDStackTool}(x + 14048)
    f === :DebugAllocInfo && return Ptr{ImGuiDebugAllocInfo}(x + 14088)
    f === :DebugHoveredDockNode && return Ptr{Ptr{ImGuiDockNode}}(x + 14152)
    f === :FramerateSecPerFrame && return Ptr{NTuple{60, Cfloat}}(x + 14160)
    f === :FramerateSecPerFrameIdx && return Ptr{Cint}(x + 14400)
    f === :FramerateSecPerFrameCount && return Ptr{Cint}(x + 14404)
    f === :FramerateSecPerFrameAccum && return Ptr{Cfloat}(x + 14408)
    f === :WantCaptureMouseNextFrame && return Ptr{Cint}(x + 14412)
    f === :WantCaptureKeyboardNextFrame && return Ptr{Cint}(x + 14416)
    f === :WantTextInputNextFrame && return Ptr{Cint}(x + 14420)
    f === :TempBuffer && return Ptr{ImVector_char}(x + 14424)
    f === :TempKeychordName && return Ptr{NTuple{64, Cchar}}(x + 14440)
    return getfield(x, f)
end

function Base.getproperty(x::ImGuiContext, f::Symbol)
    r = Ref{ImGuiContext}(x)
    ptr = Base.unsafe_convert(Ptr{ImGuiContext}, r)
    fptr = getproperty(ptr, f)
    begin
        if fptr isa Ptr
            return GC.@preserve(r, unsafe_load(fptr))
        else
            (baseptr, offset, width) = fptr
            ty = eltype(baseptr)
            baseptr32 = convert(Ptr{UInt32}, baseptr)
            u64 = GC.@preserve(r, unsafe_load(baseptr32))
            if offset + width > 32
                u64 |= GC.@preserve(r, unsafe_load(baseptr32 + 4)) << 32
            end
            u64 = u64 >> offset & (1 << width - 1)
            return u64 % ty
        end
    end
end

function Base.setproperty!(x::Ptr{ImGuiContext}, f::Symbol, v)
    fptr = getproperty(x, f)
    if fptr isa Ptr
        unsafe_store!(getproperty(x, f), v)
    else
        (baseptr, offset, width) = fptr
        baseptr32 = convert(Ptr{UInt32}, baseptr)
        u64 = unsafe_load(baseptr32)
        straddle = offset + width > 32
        if straddle
            u64 |= unsafe_load(baseptr32 + 4) << 32
        end
        mask = 1 << width - 1
        u64 &= ~(mask << offset)
        u64 |= (unsigned(v) & mask) << offset
        unsafe_store!(baseptr32, u64 & typemax(UInt32))
        if straddle
            unsafe_store!(baseptr32 + 4, u64 >> 32)
        end
    end
end

struct ImGuiInputTextCallbackData
    Ctx::Ptr{ImGuiContext}
    EventFlag::ImGuiInputTextFlags
    Flags::ImGuiInputTextFlags
    UserData::Ptr{Cvoid}
    EventChar::ImWchar
    EventKey::ImGuiKey
    Buf::Ptr{Cchar}
    BufTextLen::Cint
    BufSize::Cint
    BufDirty::Bool
    CursorPos::Cint
    SelectionStart::Cint
    SelectionEnd::Cint
end

struct ImGuiOnceUponAFrame
    RefFrame::Cint
end

struct ImGuiSelectionBasicStorage
    Size::Cint
    PreserveOrder::Bool
    UserData::Ptr{Cvoid}
    AdapterIndexToStorageId::Ptr{Cvoid}
    _SelectionOrder::Cint
    _Storage::ImGuiStorage
end

struct ImGuiSelectionExternalStorage
    UserData::Ptr{Cvoid}
    AdapterSetItemSelected::Ptr{Cvoid}
end

struct ImGuiSizeCallbackData
    UserData::Ptr{Cvoid}
    Pos::ImVec2
    CurrentSize::ImVec2
    DesiredSize::ImVec2
end
function Base.getproperty(x::Ptr{ImGuiSizeCallbackData}, f::Symbol)
    f === :UserData && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :Pos && return Ptr{ImVec2}(x + 8)
    f === :CurrentSize && return Ptr{ImVec2}(x + 16)
    f === :DesiredSize && return Ptr{ImVec2}(x + 24)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{ImGuiSizeCallbackData}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end


struct ImGuiTextRange
    b::Ptr{Cchar}
    e::Ptr{Cchar}
end

struct ImVector_ImGuiTextRange
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiTextRange}
end

struct ImGuiTextFilter
    InputBuf::NTuple{256, Cchar}
    Filters::ImVector_ImGuiTextRange
    CountGrep::Cint
end

struct ImBitVector
    Storage::ImVector_ImU32
end

struct ImGuiDataVarInfo
    Type::ImGuiDataType
    Count::ImU32
    Offset::ImU32
end

struct ImGuiDataTypeInfo
    Size::Csize_t
    Name::Ptr{Cchar}
    PrintFmt::Ptr{Cchar}
    ScanFmt::Ptr{Cchar}
end

mutable struct ImGuiInputTextDeactivateData end

@cenum ImGuiLocKey::UInt32 begin
    ImGuiLocKey_VersionStr = 0
    ImGuiLocKey_TableSizeOne = 1
    ImGuiLocKey_TableSizeAllFit = 2
    ImGuiLocKey_TableSizeAllDefault = 3
    ImGuiLocKey_TableResetOrder = 4
    ImGuiLocKey_WindowingMainMenuBar = 5
    ImGuiLocKey_WindowingPopup = 6
    ImGuiLocKey_WindowingUntitled = 7
    ImGuiLocKey_CopyLink = 8
    ImGuiLocKey_DockingHideTabBar = 9
    ImGuiLocKey_DockingHoldShiftToDock = 10
    ImGuiLocKey_DockingDragToUndockOrMoveNode = 11
    ImGuiLocKey_COUNT = 12
end

struct ImGuiLocEntry
    Key::ImGuiLocKey
    Text::Ptr{Cchar}
end

struct ImGuiTableSettings
    ID::ImGuiID
    SaveFlags::ImGuiTableFlags
    RefScale::Cfloat
    ColumnsCount::ImGuiTableColumnIdx
    ColumnsCountMax::ImGuiTableColumnIdx
    WantApply::Bool
end

mutable struct ImGuiTableColumnsSettings end

struct ImGuiWindowSettings
    ID::ImGuiID
    Pos::ImVec2ih
    Size::ImVec2ih
    ViewportPos::ImVec2ih
    ViewportId::ImGuiID
    DockId::ImGuiID
    ClassId::ImGuiID
    DockOrder::Cshort
    Collapsed::Bool
    IsChild::Bool
    WantApply::Bool
    WantDelete::Bool
end

struct ImVector_const_charPtr
    Size::Cint
    Capacity::Cint
    Data::Ptr{Ptr{Cchar}}
end

const ImU64 = Culonglong

const ImGuiMouseButton = Cint

const ImGuiTableBgTarget = Cint

const ImDrawFlags = Cint

const ImGuiButtonFlags = Cint

const ImGuiComboFlags = Cint

const ImGuiFocusedFlags = Cint

const ImGuiPopupFlags = Cint

const ImGuiSelectableFlags = Cint

const ImGuiSliderFlags = Cint

const ImWchar32 = Cuint

# typedef int ( * ImGuiInputTextCallback ) ( ImGuiInputTextCallbackData * data )
const ImGuiInputTextCallback = Ptr{Cvoid}

# typedef void * ( * ImGuiMemAllocFunc ) ( size_t sz , void * user_data )
const ImGuiMemAllocFunc = Ptr{Cvoid}

# typedef void ( * ImGuiMemFreeFunc ) ( void * ptr , void * user_data )
const ImGuiMemFreeFunc = Ptr{Cvoid}

@cenum ImGuiWindowFlags_::UInt32 begin
    ImGuiWindowFlags_None = 0
    ImGuiWindowFlags_NoTitleBar = 1
    ImGuiWindowFlags_NoResize = 2
    ImGuiWindowFlags_NoMove = 4
    ImGuiWindowFlags_NoScrollbar = 8
    ImGuiWindowFlags_NoScrollWithMouse = 16
    ImGuiWindowFlags_NoCollapse = 32
    ImGuiWindowFlags_AlwaysAutoResize = 64
    ImGuiWindowFlags_NoBackground = 128
    ImGuiWindowFlags_NoSavedSettings = 256
    ImGuiWindowFlags_NoMouseInputs = 512
    ImGuiWindowFlags_MenuBar = 1024
    ImGuiWindowFlags_HorizontalScrollbar = 2048
    ImGuiWindowFlags_NoFocusOnAppearing = 4096
    ImGuiWindowFlags_NoBringToFrontOnFocus = 8192
    ImGuiWindowFlags_AlwaysVerticalScrollbar = 16384
    ImGuiWindowFlags_AlwaysHorizontalScrollbar = 32768
    ImGuiWindowFlags_NoNavInputs = 65536
    ImGuiWindowFlags_NoNavFocus = 131072
    ImGuiWindowFlags_UnsavedDocument = 262144
    ImGuiWindowFlags_NoDocking = 524288
    ImGuiWindowFlags_NoNav = 196608
    ImGuiWindowFlags_NoDecoration = 43
    ImGuiWindowFlags_NoInputs = 197120
    ImGuiWindowFlags_ChildWindow = 16777216
    ImGuiWindowFlags_Tooltip = 33554432
    ImGuiWindowFlags_Popup = 67108864
    ImGuiWindowFlags_Modal = 134217728
    ImGuiWindowFlags_ChildMenu = 268435456
    ImGuiWindowFlags_DockNodeHost = 536870912
end

@cenum ImGuiChildFlags_::UInt32 begin
    ImGuiChildFlags_None = 0
    ImGuiChildFlags_Border = 1
    ImGuiChildFlags_AlwaysUseWindowPadding = 2
    ImGuiChildFlags_ResizeX = 4
    ImGuiChildFlags_ResizeY = 8
    ImGuiChildFlags_AutoResizeX = 16
    ImGuiChildFlags_AutoResizeY = 32
    ImGuiChildFlags_AlwaysAutoResize = 64
    ImGuiChildFlags_FrameStyle = 128
    ImGuiChildFlags_NavFlattened = 256
end

@cenum ImGuiItemFlags_::UInt32 begin
    ImGuiItemFlags_None = 0
    ImGuiItemFlags_NoTabStop = 1
    ImGuiItemFlags_NoNav = 2
    ImGuiItemFlags_NoNavDefaultFocus = 4
    ImGuiItemFlags_ButtonRepeat = 8
    ImGuiItemFlags_AutoClosePopups = 16
end

@cenum ImGuiInputTextFlags_::UInt32 begin
    ImGuiInputTextFlags_None = 0
    ImGuiInputTextFlags_CharsDecimal = 1
    ImGuiInputTextFlags_CharsHexadecimal = 2
    ImGuiInputTextFlags_CharsScientific = 4
    ImGuiInputTextFlags_CharsUppercase = 8
    ImGuiInputTextFlags_CharsNoBlank = 16
    ImGuiInputTextFlags_AllowTabInput = 32
    ImGuiInputTextFlags_EnterReturnsTrue = 64
    ImGuiInputTextFlags_EscapeClearsAll = 128
    ImGuiInputTextFlags_CtrlEnterForNewLine = 256
    ImGuiInputTextFlags_ReadOnly = 512
    ImGuiInputTextFlags_Password = 1024
    ImGuiInputTextFlags_AlwaysOverwrite = 2048
    ImGuiInputTextFlags_AutoSelectAll = 4096
    ImGuiInputTextFlags_ParseEmptyRefVal = 8192
    ImGuiInputTextFlags_DisplayEmptyRefVal = 16384
    ImGuiInputTextFlags_NoHorizontalScroll = 32768
    ImGuiInputTextFlags_NoUndoRedo = 65536
    ImGuiInputTextFlags_CallbackCompletion = 131072
    ImGuiInputTextFlags_CallbackHistory = 262144
    ImGuiInputTextFlags_CallbackAlways = 524288
    ImGuiInputTextFlags_CallbackCharFilter = 1048576
    ImGuiInputTextFlags_CallbackResize = 2097152
    ImGuiInputTextFlags_CallbackEdit = 4194304
end

@cenum ImGuiTreeNodeFlags_::UInt32 begin
    ImGuiTreeNodeFlags_None = 0
    ImGuiTreeNodeFlags_Selected = 1
    ImGuiTreeNodeFlags_Framed = 2
    ImGuiTreeNodeFlags_AllowOverlap = 4
    ImGuiTreeNodeFlags_NoTreePushOnOpen = 8
    ImGuiTreeNodeFlags_NoAutoOpenOnLog = 16
    ImGuiTreeNodeFlags_DefaultOpen = 32
    ImGuiTreeNodeFlags_OpenOnDoubleClick = 64
    ImGuiTreeNodeFlags_OpenOnArrow = 128
    ImGuiTreeNodeFlags_Leaf = 256
    ImGuiTreeNodeFlags_Bullet = 512
    ImGuiTreeNodeFlags_FramePadding = 1024
    ImGuiTreeNodeFlags_SpanAvailWidth = 2048
    ImGuiTreeNodeFlags_SpanFullWidth = 4096
    ImGuiTreeNodeFlags_SpanTextWidth = 8192
    ImGuiTreeNodeFlags_SpanAllColumns = 16384
    ImGuiTreeNodeFlags_NavLeftJumpsBackHere = 32768
    ImGuiTreeNodeFlags_CollapsingHeader = 26
end

@cenum ImGuiPopupFlags_::UInt32 begin
    ImGuiPopupFlags_None = 0
    ImGuiPopupFlags_MouseButtonLeft = 0
    ImGuiPopupFlags_MouseButtonRight = 1
    ImGuiPopupFlags_MouseButtonMiddle = 2
    ImGuiPopupFlags_MouseButtonMask_ = 31
    ImGuiPopupFlags_MouseButtonDefault_ = 1
    ImGuiPopupFlags_NoReopen = 32
    ImGuiPopupFlags_NoOpenOverExistingPopup = 128
    ImGuiPopupFlags_NoOpenOverItems = 256
    ImGuiPopupFlags_AnyPopupId = 1024
    ImGuiPopupFlags_AnyPopupLevel = 2048
    ImGuiPopupFlags_AnyPopup = 3072
end

@cenum ImGuiSelectableFlags_::UInt32 begin
    ImGuiSelectableFlags_None = 0
    ImGuiSelectableFlags_NoAutoClosePopups = 1
    ImGuiSelectableFlags_SpanAllColumns = 2
    ImGuiSelectableFlags_AllowDoubleClick = 4
    ImGuiSelectableFlags_Disabled = 8
    ImGuiSelectableFlags_AllowOverlap = 16
    ImGuiSelectableFlags_Highlight = 32
end

@cenum ImGuiComboFlags_::UInt32 begin
    ImGuiComboFlags_None = 0
    ImGuiComboFlags_PopupAlignLeft = 1
    ImGuiComboFlags_HeightSmall = 2
    ImGuiComboFlags_HeightRegular = 4
    ImGuiComboFlags_HeightLarge = 8
    ImGuiComboFlags_HeightLargest = 16
    ImGuiComboFlags_NoArrowButton = 32
    ImGuiComboFlags_NoPreview = 64
    ImGuiComboFlags_WidthFitPreview = 128
    ImGuiComboFlags_HeightMask_ = 30
end

@cenum ImGuiTabBarFlags_::UInt32 begin
    ImGuiTabBarFlags_None = 0
    ImGuiTabBarFlags_Reorderable = 1
    ImGuiTabBarFlags_AutoSelectNewTabs = 2
    ImGuiTabBarFlags_TabListPopupButton = 4
    ImGuiTabBarFlags_NoCloseWithMiddleMouseButton = 8
    ImGuiTabBarFlags_NoTabListScrollingButtons = 16
    ImGuiTabBarFlags_NoTooltip = 32
    ImGuiTabBarFlags_DrawSelectedOverline = 64
    ImGuiTabBarFlags_FittingPolicyResizeDown = 128
    ImGuiTabBarFlags_FittingPolicyScroll = 256
    ImGuiTabBarFlags_FittingPolicyMask_ = 384
    ImGuiTabBarFlags_FittingPolicyDefault_ = 128
end

@cenum ImGuiTabItemFlags_::UInt32 begin
    ImGuiTabItemFlags_None = 0
    ImGuiTabItemFlags_UnsavedDocument = 1
    ImGuiTabItemFlags_SetSelected = 2
    ImGuiTabItemFlags_NoCloseWithMiddleMouseButton = 4
    ImGuiTabItemFlags_NoPushId = 8
    ImGuiTabItemFlags_NoTooltip = 16
    ImGuiTabItemFlags_NoReorder = 32
    ImGuiTabItemFlags_Leading = 64
    ImGuiTabItemFlags_Trailing = 128
    ImGuiTabItemFlags_NoAssumedClosure = 256
end

@cenum ImGuiFocusedFlags_::UInt32 begin
    ImGuiFocusedFlags_None = 0
    ImGuiFocusedFlags_ChildWindows = 1
    ImGuiFocusedFlags_RootWindow = 2
    ImGuiFocusedFlags_AnyWindow = 4
    ImGuiFocusedFlags_NoPopupHierarchy = 8
    ImGuiFocusedFlags_DockHierarchy = 16
    ImGuiFocusedFlags_RootAndChildWindows = 3
end

@cenum ImGuiHoveredFlags_::UInt32 begin
    ImGuiHoveredFlags_None = 0
    ImGuiHoveredFlags_ChildWindows = 1
    ImGuiHoveredFlags_RootWindow = 2
    ImGuiHoveredFlags_AnyWindow = 4
    ImGuiHoveredFlags_NoPopupHierarchy = 8
    ImGuiHoveredFlags_DockHierarchy = 16
    ImGuiHoveredFlags_AllowWhenBlockedByPopup = 32
    ImGuiHoveredFlags_AllowWhenBlockedByActiveItem = 128
    ImGuiHoveredFlags_AllowWhenOverlappedByItem = 256
    ImGuiHoveredFlags_AllowWhenOverlappedByWindow = 512
    ImGuiHoveredFlags_AllowWhenDisabled = 1024
    ImGuiHoveredFlags_NoNavOverride = 2048
    ImGuiHoveredFlags_AllowWhenOverlapped = 768
    ImGuiHoveredFlags_RectOnly = 928
    ImGuiHoveredFlags_RootAndChildWindows = 3
    ImGuiHoveredFlags_ForTooltip = 4096
    ImGuiHoveredFlags_Stationary = 8192
    ImGuiHoveredFlags_DelayNone = 16384
    ImGuiHoveredFlags_DelayShort = 32768
    ImGuiHoveredFlags_DelayNormal = 65536
    ImGuiHoveredFlags_NoSharedDelay = 131072
end

@cenum ImGuiDockNodeFlags_::UInt32 begin
    ImGuiDockNodeFlags_None = 0
    ImGuiDockNodeFlags_KeepAliveOnly = 1
    ImGuiDockNodeFlags_NoDockingOverCentralNode = 4
    ImGuiDockNodeFlags_PassthruCentralNode = 8
    ImGuiDockNodeFlags_NoDockingSplit = 16
    ImGuiDockNodeFlags_NoResize = 32
    ImGuiDockNodeFlags_AutoHideTabBar = 64
    ImGuiDockNodeFlags_NoUndocking = 128
end

@cenum ImGuiDragDropFlags_::UInt32 begin
    ImGuiDragDropFlags_None = 0
    ImGuiDragDropFlags_SourceNoPreviewTooltip = 1
    ImGuiDragDropFlags_SourceNoDisableHover = 2
    ImGuiDragDropFlags_SourceNoHoldToOpenOthers = 4
    ImGuiDragDropFlags_SourceAllowNullID = 8
    ImGuiDragDropFlags_SourceExtern = 16
    ImGuiDragDropFlags_PayloadAutoExpire = 32
    ImGuiDragDropFlags_PayloadNoCrossContext = 64
    ImGuiDragDropFlags_PayloadNoCrossProcess = 128
    ImGuiDragDropFlags_AcceptBeforeDelivery = 1024
    ImGuiDragDropFlags_AcceptNoDrawDefaultRect = 2048
    ImGuiDragDropFlags_AcceptNoPreviewTooltip = 4096
    ImGuiDragDropFlags_AcceptPeekOnly = 3072
end

@cenum ImGuiDataType_::UInt32 begin
    ImGuiDataType_S8 = 0
    ImGuiDataType_U8 = 1
    ImGuiDataType_S16 = 2
    ImGuiDataType_U16 = 3
    ImGuiDataType_S32 = 4
    ImGuiDataType_U32 = 5
    ImGuiDataType_S64 = 6
    ImGuiDataType_U64 = 7
    ImGuiDataType_Float = 8
    ImGuiDataType_Double = 9
    ImGuiDataType_Bool = 10
    ImGuiDataType_COUNT = 11
end

@cenum ImGuiInputFlags_::UInt32 begin
    ImGuiInputFlags_None = 0
    ImGuiInputFlags_Repeat = 1
    ImGuiInputFlags_RouteActive = 1024
    ImGuiInputFlags_RouteFocused = 2048
    ImGuiInputFlags_RouteGlobal = 4096
    ImGuiInputFlags_RouteAlways = 8192
    ImGuiInputFlags_RouteOverFocused = 16384
    ImGuiInputFlags_RouteOverActive = 32768
    ImGuiInputFlags_RouteUnlessBgFocused = 65536
    ImGuiInputFlags_RouteFromRootWindow = 131072
    ImGuiInputFlags_Tooltip = 262144
end

@cenum ImGuiConfigFlags_::UInt32 begin
    ImGuiConfigFlags_None = 0
    ImGuiConfigFlags_NavEnableKeyboard = 1
    ImGuiConfigFlags_NavEnableGamepad = 2
    ImGuiConfigFlags_NavEnableSetMousePos = 4
    ImGuiConfigFlags_NavNoCaptureKeyboard = 8
    ImGuiConfigFlags_NoMouse = 16
    ImGuiConfigFlags_NoMouseCursorChange = 32
    ImGuiConfigFlags_NoKeyboard = 64
    ImGuiConfigFlags_DockingEnable = 128
    ImGuiConfigFlags_ViewportsEnable = 1024
    ImGuiConfigFlags_DpiEnableScaleViewports = 16384
    ImGuiConfigFlags_DpiEnableScaleFonts = 32768
    ImGuiConfigFlags_IsSRGB = 1048576
    ImGuiConfigFlags_IsTouchScreen = 2097152
end

@cenum ImGuiBackendFlags_::UInt32 begin
    ImGuiBackendFlags_None = 0
    ImGuiBackendFlags_HasGamepad = 1
    ImGuiBackendFlags_HasMouseCursors = 2
    ImGuiBackendFlags_HasSetMousePos = 4
    ImGuiBackendFlags_RendererHasVtxOffset = 8
    ImGuiBackendFlags_PlatformHasViewports = 1024
    ImGuiBackendFlags_HasMouseHoveredViewport = 2048
    ImGuiBackendFlags_RendererHasViewports = 4096
end

@cenum ImGuiCol_::UInt32 begin
    ImGuiCol_Text = 0
    ImGuiCol_TextDisabled = 1
    ImGuiCol_WindowBg = 2
    ImGuiCol_ChildBg = 3
    ImGuiCol_PopupBg = 4
    ImGuiCol_Border = 5
    ImGuiCol_BorderShadow = 6
    ImGuiCol_FrameBg = 7
    ImGuiCol_FrameBgHovered = 8
    ImGuiCol_FrameBgActive = 9
    ImGuiCol_TitleBg = 10
    ImGuiCol_TitleBgActive = 11
    ImGuiCol_TitleBgCollapsed = 12
    ImGuiCol_MenuBarBg = 13
    ImGuiCol_ScrollbarBg = 14
    ImGuiCol_ScrollbarGrab = 15
    ImGuiCol_ScrollbarGrabHovered = 16
    ImGuiCol_ScrollbarGrabActive = 17
    ImGuiCol_CheckMark = 18
    ImGuiCol_SliderGrab = 19
    ImGuiCol_SliderGrabActive = 20
    ImGuiCol_Button = 21
    ImGuiCol_ButtonHovered = 22
    ImGuiCol_ButtonActive = 23
    ImGuiCol_Header = 24
    ImGuiCol_HeaderHovered = 25
    ImGuiCol_HeaderActive = 26
    ImGuiCol_Separator = 27
    ImGuiCol_SeparatorHovered = 28
    ImGuiCol_SeparatorActive = 29
    ImGuiCol_ResizeGrip = 30
    ImGuiCol_ResizeGripHovered = 31
    ImGuiCol_ResizeGripActive = 32
    ImGuiCol_TabHovered = 33
    ImGuiCol_Tab = 34
    ImGuiCol_TabSelected = 35
    ImGuiCol_TabSelectedOverline = 36
    ImGuiCol_TabDimmed = 37
    ImGuiCol_TabDimmedSelected = 38
    ImGuiCol_TabDimmedSelectedOverline = 39
    ImGuiCol_DockingPreview = 40
    ImGuiCol_DockingEmptyBg = 41
    ImGuiCol_PlotLines = 42
    ImGuiCol_PlotLinesHovered = 43
    ImGuiCol_PlotHistogram = 44
    ImGuiCol_PlotHistogramHovered = 45
    ImGuiCol_TableHeaderBg = 46
    ImGuiCol_TableBorderStrong = 47
    ImGuiCol_TableBorderLight = 48
    ImGuiCol_TableRowBg = 49
    ImGuiCol_TableRowBgAlt = 50
    ImGuiCol_TextLink = 51
    ImGuiCol_TextSelectedBg = 52
    ImGuiCol_DragDropTarget = 53
    ImGuiCol_NavHighlight = 54
    ImGuiCol_NavWindowingHighlight = 55
    ImGuiCol_NavWindowingDimBg = 56
    ImGuiCol_ModalWindowDimBg = 57
    ImGuiCol_COUNT = 58
end

@cenum ImGuiStyleVar_::UInt32 begin
    ImGuiStyleVar_Alpha = 0
    ImGuiStyleVar_DisabledAlpha = 1
    ImGuiStyleVar_WindowPadding = 2
    ImGuiStyleVar_WindowRounding = 3
    ImGuiStyleVar_WindowBorderSize = 4
    ImGuiStyleVar_WindowMinSize = 5
    ImGuiStyleVar_WindowTitleAlign = 6
    ImGuiStyleVar_ChildRounding = 7
    ImGuiStyleVar_ChildBorderSize = 8
    ImGuiStyleVar_PopupRounding = 9
    ImGuiStyleVar_PopupBorderSize = 10
    ImGuiStyleVar_FramePadding = 11
    ImGuiStyleVar_FrameRounding = 12
    ImGuiStyleVar_FrameBorderSize = 13
    ImGuiStyleVar_ItemSpacing = 14
    ImGuiStyleVar_ItemInnerSpacing = 15
    ImGuiStyleVar_IndentSpacing = 16
    ImGuiStyleVar_CellPadding = 17
    ImGuiStyleVar_ScrollbarSize = 18
    ImGuiStyleVar_ScrollbarRounding = 19
    ImGuiStyleVar_GrabMinSize = 20
    ImGuiStyleVar_GrabRounding = 21
    ImGuiStyleVar_TabRounding = 22
    ImGuiStyleVar_TabBorderSize = 23
    ImGuiStyleVar_TabBarBorderSize = 24
    ImGuiStyleVar_TabBarOverlineSize = 25
    ImGuiStyleVar_TableAngledHeadersAngle = 26
    ImGuiStyleVar_TableAngledHeadersTextAlign = 27
    ImGuiStyleVar_ButtonTextAlign = 28
    ImGuiStyleVar_SelectableTextAlign = 29
    ImGuiStyleVar_SeparatorTextBorderSize = 30
    ImGuiStyleVar_SeparatorTextAlign = 31
    ImGuiStyleVar_SeparatorTextPadding = 32
    ImGuiStyleVar_DockingSeparatorSize = 33
    ImGuiStyleVar_COUNT = 34
end

@cenum ImGuiButtonFlags_::UInt32 begin
    ImGuiButtonFlags_None = 0
    ImGuiButtonFlags_MouseButtonLeft = 1
    ImGuiButtonFlags_MouseButtonRight = 2
    ImGuiButtonFlags_MouseButtonMiddle = 4
    ImGuiButtonFlags_MouseButtonMask_ = 7
end

@cenum ImGuiColorEditFlags_::UInt32 begin
    ImGuiColorEditFlags_None = 0
    ImGuiColorEditFlags_NoAlpha = 2
    ImGuiColorEditFlags_NoPicker = 4
    ImGuiColorEditFlags_NoOptions = 8
    ImGuiColorEditFlags_NoSmallPreview = 16
    ImGuiColorEditFlags_NoInputs = 32
    ImGuiColorEditFlags_NoTooltip = 64
    ImGuiColorEditFlags_NoLabel = 128
    ImGuiColorEditFlags_NoSidePreview = 256
    ImGuiColorEditFlags_NoDragDrop = 512
    ImGuiColorEditFlags_NoBorder = 1024
    ImGuiColorEditFlags_AlphaBar = 65536
    ImGuiColorEditFlags_AlphaPreview = 131072
    ImGuiColorEditFlags_AlphaPreviewHalf = 262144
    ImGuiColorEditFlags_HDR = 524288
    ImGuiColorEditFlags_DisplayRGB = 1048576
    ImGuiColorEditFlags_DisplayHSV = 2097152
    ImGuiColorEditFlags_DisplayHex = 4194304
    ImGuiColorEditFlags_Uint8 = 8388608
    ImGuiColorEditFlags_Float = 16777216
    ImGuiColorEditFlags_PickerHueBar = 33554432
    ImGuiColorEditFlags_PickerHueWheel = 67108864
    ImGuiColorEditFlags_InputRGB = 134217728
    ImGuiColorEditFlags_InputHSV = 268435456
    ImGuiColorEditFlags_DefaultOptions_ = 177209344
    ImGuiColorEditFlags_DisplayMask_ = 7340032
    ImGuiColorEditFlags_DataTypeMask_ = 25165824
    ImGuiColorEditFlags_PickerMask_ = 100663296
    ImGuiColorEditFlags_InputMask_ = 402653184
end

@cenum ImGuiSliderFlags_::UInt32 begin
    ImGuiSliderFlags_None = 0
    ImGuiSliderFlags_AlwaysClamp = 16
    ImGuiSliderFlags_Logarithmic = 32
    ImGuiSliderFlags_NoRoundToFormat = 64
    ImGuiSliderFlags_NoInput = 128
    ImGuiSliderFlags_WrapAround = 256
    ImGuiSliderFlags_InvalidMask_ = 1879048207
end

@cenum ImGuiMouseButton_::UInt32 begin
    ImGuiMouseButton_Left = 0
    ImGuiMouseButton_Right = 1
    ImGuiMouseButton_Middle = 2
    ImGuiMouseButton_COUNT = 5
end

@cenum ImGuiMouseCursor_::Int32 begin
    ImGuiMouseCursor_None = -1
    ImGuiMouseCursor_Arrow = 0
    ImGuiMouseCursor_TextInput = 1
    ImGuiMouseCursor_ResizeAll = 2
    ImGuiMouseCursor_ResizeNS = 3
    ImGuiMouseCursor_ResizeEW = 4
    ImGuiMouseCursor_ResizeNESW = 5
    ImGuiMouseCursor_ResizeNWSE = 6
    ImGuiMouseCursor_Hand = 7
    ImGuiMouseCursor_NotAllowed = 8
    ImGuiMouseCursor_COUNT = 9
end

@cenum ImGuiCond_::UInt32 begin
    ImGuiCond_None = 0
    ImGuiCond_Always = 1
    ImGuiCond_Once = 2
    ImGuiCond_FirstUseEver = 4
    ImGuiCond_Appearing = 8
end

@cenum ImGuiTableFlags_::UInt32 begin
    ImGuiTableFlags_None = 0
    ImGuiTableFlags_Resizable = 1
    ImGuiTableFlags_Reorderable = 2
    ImGuiTableFlags_Hideable = 4
    ImGuiTableFlags_Sortable = 8
    ImGuiTableFlags_NoSavedSettings = 16
    ImGuiTableFlags_ContextMenuInBody = 32
    ImGuiTableFlags_RowBg = 64
    ImGuiTableFlags_BordersInnerH = 128
    ImGuiTableFlags_BordersOuterH = 256
    ImGuiTableFlags_BordersInnerV = 512
    ImGuiTableFlags_BordersOuterV = 1024
    ImGuiTableFlags_BordersH = 384
    ImGuiTableFlags_BordersV = 1536
    ImGuiTableFlags_BordersInner = 640
    ImGuiTableFlags_BordersOuter = 1280
    ImGuiTableFlags_Borders = 1920
    ImGuiTableFlags_NoBordersInBody = 2048
    ImGuiTableFlags_NoBordersInBodyUntilResize = 4096
    ImGuiTableFlags_SizingFixedFit = 8192
    ImGuiTableFlags_SizingFixedSame = 16384
    ImGuiTableFlags_SizingStretchProp = 24576
    ImGuiTableFlags_SizingStretchSame = 32768
    ImGuiTableFlags_NoHostExtendX = 65536
    ImGuiTableFlags_NoHostExtendY = 131072
    ImGuiTableFlags_NoKeepColumnsVisible = 262144
    ImGuiTableFlags_PreciseWidths = 524288
    ImGuiTableFlags_NoClip = 1048576
    ImGuiTableFlags_PadOuterX = 2097152
    ImGuiTableFlags_NoPadOuterX = 4194304
    ImGuiTableFlags_NoPadInnerX = 8388608
    ImGuiTableFlags_ScrollX = 16777216
    ImGuiTableFlags_ScrollY = 33554432
    ImGuiTableFlags_SortMulti = 67108864
    ImGuiTableFlags_SortTristate = 134217728
    ImGuiTableFlags_HighlightHoveredColumn = 268435456
    ImGuiTableFlags_SizingMask_ = 57344
end

@cenum ImGuiTableColumnFlags_::UInt32 begin
    ImGuiTableColumnFlags_None = 0
    ImGuiTableColumnFlags_Disabled = 1
    ImGuiTableColumnFlags_DefaultHide = 2
    ImGuiTableColumnFlags_DefaultSort = 4
    ImGuiTableColumnFlags_WidthStretch = 8
    ImGuiTableColumnFlags_WidthFixed = 16
    ImGuiTableColumnFlags_NoResize = 32
    ImGuiTableColumnFlags_NoReorder = 64
    ImGuiTableColumnFlags_NoHide = 128
    ImGuiTableColumnFlags_NoClip = 256
    ImGuiTableColumnFlags_NoSort = 512
    ImGuiTableColumnFlags_NoSortAscending = 1024
    ImGuiTableColumnFlags_NoSortDescending = 2048
    ImGuiTableColumnFlags_NoHeaderLabel = 4096
    ImGuiTableColumnFlags_NoHeaderWidth = 8192
    ImGuiTableColumnFlags_PreferSortAscending = 16384
    ImGuiTableColumnFlags_PreferSortDescending = 32768
    ImGuiTableColumnFlags_IndentEnable = 65536
    ImGuiTableColumnFlags_IndentDisable = 131072
    ImGuiTableColumnFlags_AngledHeader = 262144
    ImGuiTableColumnFlags_IsEnabled = 16777216
    ImGuiTableColumnFlags_IsVisible = 33554432
    ImGuiTableColumnFlags_IsSorted = 67108864
    ImGuiTableColumnFlags_IsHovered = 134217728
    ImGuiTableColumnFlags_WidthMask_ = 24
    ImGuiTableColumnFlags_IndentMask_ = 196608
    ImGuiTableColumnFlags_StatusMask_ = 251658240
    ImGuiTableColumnFlags_NoDirectResize_ = 1073741824
end

@cenum ImGuiTableRowFlags_::UInt32 begin
    ImGuiTableRowFlags_None = 0
    ImGuiTableRowFlags_Headers = 1
end

@cenum ImGuiTableBgTarget_::UInt32 begin
    ImGuiTableBgTarget_None = 0
    ImGuiTableBgTarget_RowBg0 = 1
    ImGuiTableBgTarget_RowBg1 = 2
    ImGuiTableBgTarget_CellBg = 3
end

@cenum ImGuiMultiSelectFlags_::UInt32 begin
    ImGuiMultiSelectFlags_None = 0
    ImGuiMultiSelectFlags_SingleSelect = 1
    ImGuiMultiSelectFlags_NoSelectAll = 2
    ImGuiMultiSelectFlags_NoRangeSelect = 4
    ImGuiMultiSelectFlags_NoAutoSelect = 8
    ImGuiMultiSelectFlags_NoAutoClear = 16
    ImGuiMultiSelectFlags_NoAutoClearOnReselect = 32
    ImGuiMultiSelectFlags_BoxSelect1d = 64
    ImGuiMultiSelectFlags_BoxSelect2d = 128
    ImGuiMultiSelectFlags_BoxSelectNoScroll = 256
    ImGuiMultiSelectFlags_ClearOnEscape = 512
    ImGuiMultiSelectFlags_ClearOnClickVoid = 1024
    ImGuiMultiSelectFlags_ScopeWindow = 2048
    ImGuiMultiSelectFlags_ScopeRect = 4096
    ImGuiMultiSelectFlags_SelectOnClick = 8192
    ImGuiMultiSelectFlags_SelectOnClickRelease = 16384
    ImGuiMultiSelectFlags_NavWrapX = 65536
end

@cenum ImDrawFlags_::UInt32 begin
    ImDrawFlags_None = 0
    ImDrawFlags_Closed = 1
    ImDrawFlags_RoundCornersTopLeft = 16
    ImDrawFlags_RoundCornersTopRight = 32
    ImDrawFlags_RoundCornersBottomLeft = 64
    ImDrawFlags_RoundCornersBottomRight = 128
    ImDrawFlags_RoundCornersNone = 256
    ImDrawFlags_RoundCornersTop = 48
    ImDrawFlags_RoundCornersBottom = 192
    ImDrawFlags_RoundCornersLeft = 80
    ImDrawFlags_RoundCornersRight = 160
    ImDrawFlags_RoundCornersAll = 240
    ImDrawFlags_RoundCornersDefault_ = 240
    ImDrawFlags_RoundCornersMask_ = 496
end

@cenum ImDrawListFlags_::UInt32 begin
    ImDrawListFlags_None = 0
    ImDrawListFlags_AntiAliasedLines = 1
    ImDrawListFlags_AntiAliasedLinesUseTex = 2
    ImDrawListFlags_AntiAliasedFill = 4
    ImDrawListFlags_AllowVtxOffset = 8
end

@cenum ImFontAtlasFlags_::UInt32 begin
    ImFontAtlasFlags_None = 0
    ImFontAtlasFlags_NoPowerOfTwoHeight = 1
    ImFontAtlasFlags_NoMouseCursors = 2
    ImFontAtlasFlags_NoBakedLines = 4
end

@cenum ImGuiViewportFlags_::UInt32 begin
    ImGuiViewportFlags_None = 0
    ImGuiViewportFlags_IsPlatformWindow = 1
    ImGuiViewportFlags_IsPlatformMonitor = 2
    ImGuiViewportFlags_OwnedByApp = 4
    ImGuiViewportFlags_NoDecoration = 8
    ImGuiViewportFlags_NoTaskBarIcon = 16
    ImGuiViewportFlags_NoFocusOnAppearing = 32
    ImGuiViewportFlags_NoFocusOnClick = 64
    ImGuiViewportFlags_NoInputs = 128
    ImGuiViewportFlags_NoRendererClear = 256
    ImGuiViewportFlags_NoAutoMerge = 512
    ImGuiViewportFlags_TopMost = 1024
    ImGuiViewportFlags_CanHostOtherWindows = 2048
    ImGuiViewportFlags_IsMinimized = 4096
    ImGuiViewportFlags_IsFocused = 8192
end

const ImGuiFocusRequestFlags = Cint

const ImGuiNavHighlightFlags = Cint

const ImGuiSeparatorFlags = Cint

const ImGuiTextFlags = Cint

const ImGuiTooltipFlags = Cint

# typedef void ( * ImGuiErrorLogCallback ) ( void * user_data , const char * fmt , ... )
const ImGuiErrorLogCallback = Ptr{Cvoid}

struct StbTexteditRow
    x0::Cfloat
    x1::Cfloat
    baseline_y_delta::Cfloat
    ymin::Cfloat
    ymax::Cfloat
    num_chars::Cint
end

@cenum ImGuiDataTypePrivate_::UInt32 begin
    ImGuiDataType_String = 12
    ImGuiDataType_Pointer = 13
    ImGuiDataType_ID = 14
end

@cenum ImGuiItemFlagsPrivate_::UInt32 begin
    ImGuiItemFlags_Disabled = 1024
    ImGuiItemFlags_ReadOnly = 2048
    ImGuiItemFlags_MixedValue = 4096
    ImGuiItemFlags_NoWindowHoverableCheck = 8192
    ImGuiItemFlags_AllowOverlap = 16384
    ImGuiItemFlags_Inputable = 1048576
    ImGuiItemFlags_HasSelectionUserData = 2097152
    ImGuiItemFlags_IsMultiSelect = 4194304
    ImGuiItemFlags_Default_ = 16
end

@cenum ImGuiItemStatusFlags_::UInt32 begin
    ImGuiItemStatusFlags_None = 0
    ImGuiItemStatusFlags_HoveredRect = 1
    ImGuiItemStatusFlags_HasDisplayRect = 2
    ImGuiItemStatusFlags_Edited = 4
    ImGuiItemStatusFlags_ToggledSelection = 8
    ImGuiItemStatusFlags_ToggledOpen = 16
    ImGuiItemStatusFlags_HasDeactivated = 32
    ImGuiItemStatusFlags_Deactivated = 64
    ImGuiItemStatusFlags_HoveredWindow = 128
    ImGuiItemStatusFlags_Visible = 256
    ImGuiItemStatusFlags_HasClipRect = 512
    ImGuiItemStatusFlags_HasShortcut = 1024
end

@cenum ImGuiHoveredFlagsPrivate_::UInt32 begin
    ImGuiHoveredFlags_DelayMask_ = 245760
    ImGuiHoveredFlags_AllowedMaskForIsWindowHovered = 12479
    ImGuiHoveredFlags_AllowedMaskForIsItemHovered = 262048
end

@cenum ImGuiInputTextFlagsPrivate_::UInt32 begin
    ImGuiInputTextFlags_Multiline = 67108864
    ImGuiInputTextFlags_NoMarkEdited = 134217728
    ImGuiInputTextFlags_MergedItem = 268435456
    ImGuiInputTextFlags_LocalizeDecimalPoint = 536870912
end

@cenum ImGuiButtonFlagsPrivate_::UInt32 begin
    ImGuiButtonFlags_PressedOnClick = 16
    ImGuiButtonFlags_PressedOnClickRelease = 32
    ImGuiButtonFlags_PressedOnClickReleaseAnywhere = 64
    ImGuiButtonFlags_PressedOnRelease = 128
    ImGuiButtonFlags_PressedOnDoubleClick = 256
    ImGuiButtonFlags_PressedOnDragDropHold = 512
    ImGuiButtonFlags_Repeat = 1024
    ImGuiButtonFlags_FlattenChildren = 2048
    ImGuiButtonFlags_AllowOverlap = 4096
    ImGuiButtonFlags_DontClosePopups = 8192
    ImGuiButtonFlags_AlignTextBaseLine = 32768
    ImGuiButtonFlags_NoKeyModifiers = 65536
    ImGuiButtonFlags_NoHoldingActiveId = 131072
    ImGuiButtonFlags_NoNavFocus = 262144
    ImGuiButtonFlags_NoHoveredOnFocus = 524288
    ImGuiButtonFlags_NoSetKeyOwner = 1048576
    ImGuiButtonFlags_NoTestKeyOwner = 2097152
    ImGuiButtonFlags_PressedOnMask_ = 1008
    ImGuiButtonFlags_PressedOnDefault_ = 32
end

@cenum ImGuiComboFlagsPrivate_::UInt32 begin
    ImGuiComboFlags_CustomPreview = 1048576
end

@cenum ImGuiSliderFlagsPrivate_::UInt32 begin
    ImGuiSliderFlags_Vertical = 1048576
    ImGuiSliderFlags_ReadOnly = 2097152
end

@cenum ImGuiSelectableFlagsPrivate_::UInt32 begin
    ImGuiSelectableFlags_NoHoldingActiveID = 1048576
    ImGuiSelectableFlags_SelectOnNav = 2097152
    ImGuiSelectableFlags_SelectOnClick = 4194304
    ImGuiSelectableFlags_SelectOnRelease = 8388608
    ImGuiSelectableFlags_SpanAvailWidth = 16777216
    ImGuiSelectableFlags_SetNavIdOnHover = 33554432
    ImGuiSelectableFlags_NoPadWithHalfSpacing = 67108864
    ImGuiSelectableFlags_NoSetKeyOwner = 134217728
end

@cenum ImGuiTreeNodeFlagsPrivate_::UInt32 begin
    ImGuiTreeNodeFlags_ClipLabelForTrailingButton = 268435456
    ImGuiTreeNodeFlags_UpsideDownArrow = 536870912
end

@cenum ImGuiSeparatorFlags_::UInt32 begin
    ImGuiSeparatorFlags_None = 0
    ImGuiSeparatorFlags_Horizontal = 1
    ImGuiSeparatorFlags_Vertical = 2
    ImGuiSeparatorFlags_SpanAllColumns = 4
end

@cenum ImGuiFocusRequestFlags_::UInt32 begin
    ImGuiFocusRequestFlags_None = 0
    ImGuiFocusRequestFlags_RestoreFocusedChild = 1
    ImGuiFocusRequestFlags_UnlessBelowModal = 2
end

@cenum ImGuiTextFlags_::UInt32 begin
    ImGuiTextFlags_None = 0
    ImGuiTextFlags_NoWidthForLargeClippedText = 1
end

@cenum ImGuiTooltipFlags_::UInt32 begin
    ImGuiTooltipFlags_None = 0
    ImGuiTooltipFlags_OverridePrevious = 2
end

@cenum ImGuiLayoutType_::UInt32 begin
    ImGuiLayoutType_Horizontal = 0
    ImGuiLayoutType_Vertical = 1
end

@cenum ImGuiPlotType::UInt32 begin
    ImGuiPlotType_Lines = 0
    ImGuiPlotType_Histogram = 1
end

@cenum ImGuiWindowRefreshFlags_::UInt32 begin
    ImGuiWindowRefreshFlags_None = 0
    ImGuiWindowRefreshFlags_TryToAvoidRefresh = 1
    ImGuiWindowRefreshFlags_RefreshOnHover = 2
    ImGuiWindowRefreshFlags_RefreshOnFocus = 4
end

@cenum ImGuiNextWindowDataFlags_::UInt32 begin
    ImGuiNextWindowDataFlags_None = 0
    ImGuiNextWindowDataFlags_HasPos = 1
    ImGuiNextWindowDataFlags_HasSize = 2
    ImGuiNextWindowDataFlags_HasContentSize = 4
    ImGuiNextWindowDataFlags_HasCollapsed = 8
    ImGuiNextWindowDataFlags_HasSizeConstraint = 16
    ImGuiNextWindowDataFlags_HasFocus = 32
    ImGuiNextWindowDataFlags_HasBgAlpha = 64
    ImGuiNextWindowDataFlags_HasScroll = 128
    ImGuiNextWindowDataFlags_HasChildFlags = 256
    ImGuiNextWindowDataFlags_HasRefreshPolicy = 512
    ImGuiNextWindowDataFlags_HasViewport = 1024
    ImGuiNextWindowDataFlags_HasDock = 2048
    ImGuiNextWindowDataFlags_HasWindowClass = 4096
end

@cenum ImGuiNextItemDataFlags_::UInt32 begin
    ImGuiNextItemDataFlags_None = 0
    ImGuiNextItemDataFlags_HasWidth = 1
    ImGuiNextItemDataFlags_HasOpen = 2
    ImGuiNextItemDataFlags_HasShortcut = 4
    ImGuiNextItemDataFlags_HasRefVal = 8
    ImGuiNextItemDataFlags_HasStorageID = 16
end

@cenum ImGuiPopupPositionPolicy::UInt32 begin
    ImGuiPopupPositionPolicy_Default = 0
    ImGuiPopupPositionPolicy_ComboBox = 1
    ImGuiPopupPositionPolicy_Tooltip = 2
end

struct ImGuiInputEventMousePos
    PosX::Cfloat
    PosY::Cfloat
    MouseSource::ImGuiMouseSource
end

struct ImGuiInputEventMouseWheel
    WheelX::Cfloat
    WheelY::Cfloat
    MouseSource::ImGuiMouseSource
end

struct ImGuiInputEventMouseButton
    Button::Cint
    Down::Bool
    MouseSource::ImGuiMouseSource
end

struct ImGuiInputEventMouseViewport
    HoveredViewportID::ImGuiID
end

struct ImGuiInputEventKey
    Key::ImGuiKey
    Down::Bool
    AnalogValue::Cfloat
end

struct ImGuiInputEventText
    Char::Cuint
end

struct ImGuiInputEventAppFocused
    Focused::Bool
end

@cenum ImGuiInputFlagsPrivate_::UInt32 begin
    ImGuiInputFlags_RepeatRateDefault = 2
    ImGuiInputFlags_RepeatRateNavMove = 4
    ImGuiInputFlags_RepeatRateNavTweak = 8
    ImGuiInputFlags_RepeatUntilRelease = 16
    ImGuiInputFlags_RepeatUntilKeyModsChange = 32
    ImGuiInputFlags_RepeatUntilKeyModsChangeFromNone = 64
    ImGuiInputFlags_RepeatUntilOtherKeyPress = 128
    ImGuiInputFlags_LockThisFrame = 1048576
    ImGuiInputFlags_LockUntilRelease = 2097152
    ImGuiInputFlags_CondHovered = 4194304
    ImGuiInputFlags_CondActive = 8388608
    ImGuiInputFlags_CondDefault_ = 12582912
    ImGuiInputFlags_RepeatRateMask_ = 14
    ImGuiInputFlags_RepeatUntilMask_ = 240
    ImGuiInputFlags_RepeatMask_ = 255
    ImGuiInputFlags_CondMask_ = 12582912
    ImGuiInputFlags_RouteTypeMask_ = 15360
    ImGuiInputFlags_RouteOptionsMask_ = 245760
    ImGuiInputFlags_SupportedByIsKeyPressed = 255
    ImGuiInputFlags_SupportedByIsMouseClicked = 1
    ImGuiInputFlags_SupportedByShortcut = 261375
    ImGuiInputFlags_SupportedBySetNextItemShortcut = 523519
    ImGuiInputFlags_SupportedBySetKeyOwner = 3145728
    ImGuiInputFlags_SupportedBySetItemKeyOwner = 15728640
end

@cenum ImGuiActivateFlags_::UInt32 begin
    ImGuiActivateFlags_None = 0
    ImGuiActivateFlags_PreferInput = 1
    ImGuiActivateFlags_PreferTweak = 2
    ImGuiActivateFlags_TryToPreserveState = 4
    ImGuiActivateFlags_FromTabbing = 8
    ImGuiActivateFlags_FromShortcut = 16
end

@cenum ImGuiScrollFlags_::UInt32 begin
    ImGuiScrollFlags_None = 0
    ImGuiScrollFlags_KeepVisibleEdgeX = 1
    ImGuiScrollFlags_KeepVisibleEdgeY = 2
    ImGuiScrollFlags_KeepVisibleCenterX = 4
    ImGuiScrollFlags_KeepVisibleCenterY = 8
    ImGuiScrollFlags_AlwaysCenterX = 16
    ImGuiScrollFlags_AlwaysCenterY = 32
    ImGuiScrollFlags_NoScrollParent = 64
    ImGuiScrollFlags_MaskX_ = 21
    ImGuiScrollFlags_MaskY_ = 42
end

@cenum ImGuiNavHighlightFlags_::UInt32 begin
    ImGuiNavHighlightFlags_None = 0
    ImGuiNavHighlightFlags_Compact = 2
    ImGuiNavHighlightFlags_AlwaysDraw = 4
    ImGuiNavHighlightFlags_NoRounding = 8
end

@cenum ImGuiNavMoveFlags_::UInt32 begin
    ImGuiNavMoveFlags_None = 0
    ImGuiNavMoveFlags_LoopX = 1
    ImGuiNavMoveFlags_LoopY = 2
    ImGuiNavMoveFlags_WrapX = 4
    ImGuiNavMoveFlags_WrapY = 8
    ImGuiNavMoveFlags_WrapMask_ = 15
    ImGuiNavMoveFlags_AllowCurrentNavId = 16
    ImGuiNavMoveFlags_AlsoScoreVisibleSet = 32
    ImGuiNavMoveFlags_ScrollToEdgeY = 64
    ImGuiNavMoveFlags_Forwarded = 128
    ImGuiNavMoveFlags_DebugNoResult = 256
    ImGuiNavMoveFlags_FocusApi = 512
    ImGuiNavMoveFlags_IsTabbing = 1024
    ImGuiNavMoveFlags_IsPageMove = 2048
    ImGuiNavMoveFlags_Activate = 4096
    ImGuiNavMoveFlags_NoSelect = 8192
    ImGuiNavMoveFlags_NoSetNavHighlight = 16384
    ImGuiNavMoveFlags_NoClearActiveId = 32768
end

@cenum ImGuiTypingSelectFlags_::UInt32 begin
    ImGuiTypingSelectFlags_None = 0
    ImGuiTypingSelectFlags_AllowBackspace = 1
    ImGuiTypingSelectFlags_AllowSingleCharMode = 2
end

@cenum ImGuiOldColumnFlags_::UInt32 begin
    ImGuiOldColumnFlags_None = 0
    ImGuiOldColumnFlags_NoBorder = 1
    ImGuiOldColumnFlags_NoResize = 2
    ImGuiOldColumnFlags_NoPreserveWidths = 4
    ImGuiOldColumnFlags_NoForceWithinWindow = 8
    ImGuiOldColumnFlags_GrowParentContentsSize = 16
end

@cenum ImGuiDockNodeFlagsPrivate_::Int32 begin
    ImGuiDockNodeFlags_DockSpace = 1024
    ImGuiDockNodeFlags_CentralNode = 2048
    ImGuiDockNodeFlags_NoTabBar = 4096
    ImGuiDockNodeFlags_HiddenTabBar = 8192
    ImGuiDockNodeFlags_NoWindowMenuButton = 16384
    ImGuiDockNodeFlags_NoCloseButton = 32768
    ImGuiDockNodeFlags_NoResizeX = 65536
    ImGuiDockNodeFlags_NoResizeY = 131072
    ImGuiDockNodeFlags_DockedWindowsInFocusRoute = 262144
    ImGuiDockNodeFlags_NoDockingSplitOther = 524288
    ImGuiDockNodeFlags_NoDockingOverMe = 1048576
    ImGuiDockNodeFlags_NoDockingOverOther = 2097152
    ImGuiDockNodeFlags_NoDockingOverEmpty = 4194304
    ImGuiDockNodeFlags_NoDocking = 7864336
    ImGuiDockNodeFlags_SharedFlagsInheritMask_ = -1
    ImGuiDockNodeFlags_NoResizeFlagsMask_ = 196640
    ImGuiDockNodeFlags_LocalFlagsTransferMask_ = 260208
    ImGuiDockNodeFlags_SavedFlagsMask_ = 261152
end

@cenum ImGuiDataAuthority_::UInt32 begin
    ImGuiDataAuthority_Auto = 0
    ImGuiDataAuthority_DockNode = 1
    ImGuiDataAuthority_Window = 2
end

@cenum ImGuiWindowDockStyleCol::UInt32 begin
    ImGuiWindowDockStyleCol_Text = 0
    ImGuiWindowDockStyleCol_TabHovered = 1
    ImGuiWindowDockStyleCol_TabFocused = 2
    ImGuiWindowDockStyleCol_TabSelected = 3
    ImGuiWindowDockStyleCol_TabSelectedOverline = 4
    ImGuiWindowDockStyleCol_TabDimmed = 5
    ImGuiWindowDockStyleCol_TabDimmedSelected = 6
    ImGuiWindowDockStyleCol_TabDimmedSelectedOverline = 7
    ImGuiWindowDockStyleCol_COUNT = 8
end

@cenum ImGuiDebugLogFlags_::UInt32 begin
    ImGuiDebugLogFlags_None = 0
    ImGuiDebugLogFlags_EventActiveId = 1
    ImGuiDebugLogFlags_EventFocus = 2
    ImGuiDebugLogFlags_EventPopup = 4
    ImGuiDebugLogFlags_EventNav = 8
    ImGuiDebugLogFlags_EventClipper = 16
    ImGuiDebugLogFlags_EventSelection = 32
    ImGuiDebugLogFlags_EventIO = 64
    ImGuiDebugLogFlags_EventInputRouting = 128
    ImGuiDebugLogFlags_EventDocking = 256
    ImGuiDebugLogFlags_EventViewport = 512
    ImGuiDebugLogFlags_EventMask_ = 1023
    ImGuiDebugLogFlags_OutputToTTY = 1048576
    ImGuiDebugLogFlags_OutputToTestEngine = 2097152
end

@cenum ImGuiTabBarFlagsPrivate_::UInt32 begin
    ImGuiTabBarFlags_DockNode = 1048576
    ImGuiTabBarFlags_IsFocused = 2097152
    ImGuiTabBarFlags_SaveSettings = 4194304
end

@cenum ImGuiTabItemFlagsPrivate_::UInt32 begin
    ImGuiTabItemFlags_SectionMask_ = 192
    ImGuiTabItemFlags_NoCloseButton = 1048576
    ImGuiTabItemFlags_Button = 2097152
    ImGuiTabItemFlags_Unsorted = 4194304
end

struct ImGuiTableColumnSettings
    data::NTuple{16, UInt8}
end

function Base.getproperty(x::Ptr{ImGuiTableColumnSettings}, f::Symbol)
    f === :WidthOrWeight && return Ptr{Cfloat}(x + 0)
    f === :UserID && return Ptr{ImGuiID}(x + 4)
    f === :Index && return Ptr{ImGuiTableColumnIdx}(x + 8)
    f === :DisplayOrder && return Ptr{ImGuiTableColumnIdx}(x + 10)
    f === :SortOrder && return Ptr{ImGuiTableColumnIdx}(x + 12)
    f === :SortDirection && return (Ptr{ImU8}(x + 12), 16, 2)
    f === :IsEnabled && return (Ptr{ImU8}(x + 12), 18, 1)
    f === :IsStretch && return (Ptr{ImU8}(x + 12), 19, 1)
    return getfield(x, f)
end

function Base.getproperty(x::ImGuiTableColumnSettings, f::Symbol)
    r = Ref{ImGuiTableColumnSettings}(x)
    ptr = Base.unsafe_convert(Ptr{ImGuiTableColumnSettings}, r)
    fptr = getproperty(ptr, f)
    begin
        if fptr isa Ptr
            return GC.@preserve(r, unsafe_load(fptr))
        else
            (baseptr, offset, width) = fptr
            ty = eltype(baseptr)
            baseptr32 = convert(Ptr{UInt32}, baseptr)
            u64 = GC.@preserve(r, unsafe_load(baseptr32))
            if offset + width > 32
                u64 |= GC.@preserve(r, unsafe_load(baseptr32 + 4)) << 32
            end
            u64 = u64 >> offset & (1 << width - 1)
            return u64 % ty
        end
    end
end

function Base.setproperty!(x::Ptr{ImGuiTableColumnSettings}, f::Symbol, v)
    fptr = getproperty(x, f)
    if fptr isa Ptr
        unsafe_store!(getproperty(x, f), v)
    else
        (baseptr, offset, width) = fptr
        baseptr32 = convert(Ptr{UInt32}, baseptr)
        u64 = unsafe_load(baseptr32)
        straddle = offset + width > 32
        if straddle
            u64 |= unsafe_load(baseptr32 + 4) << 32
        end
        mask = 1 << width - 1
        u64 &= ~(mask << offset)
        u64 |= (unsigned(v) & mask) << offset
        unsafe_store!(baseptr32, u64 & typemax(UInt32))
        if straddle
            unsafe_store!(baseptr32 + 4, u64 >> 32)
        end
    end
end

function ImVec2_ImVec2_Nil()
    ccall((:ImVec2_ImVec2_Nil, libcimgui), Ptr{ImVec2}, ())
end

function ImVec2_destroy(self)
    ccall((:ImVec2_destroy, libcimgui), Cvoid, (Ptr{ImVec2},), self)
end

function ImVec2_ImVec2_Float(_x, _y)
    ccall((:ImVec2_ImVec2_Float, libcimgui), Ptr{ImVec2}, (Cfloat, Cfloat), _x, _y)
end

function ImVec4_ImVec4_Nil()
    ccall((:ImVec4_ImVec4_Nil, libcimgui), Ptr{ImVec4}, ())
end

function ImVec4_destroy(self)
    ccall((:ImVec4_destroy, libcimgui), Cvoid, (Ptr{ImVec4},), self)
end

function ImVec4_ImVec4_Float(_x, _y, _z, _w)
    ccall((:ImVec4_ImVec4_Float, libcimgui), Ptr{ImVec4}, (Cfloat, Cfloat, Cfloat, Cfloat), _x, _y, _z, _w)
end

function igCreateContext(shared_font_atlas)
    ccall((:igCreateContext, libcimgui), Ptr{ImGuiContext}, (Ptr{ImFontAtlas},), shared_font_atlas)
end

function igDestroyContext(ctx)
    ccall((:igDestroyContext, libcimgui), Cvoid, (Ptr{ImGuiContext},), ctx)
end

function igGetCurrentContext()
    ccall((:igGetCurrentContext, libcimgui), Ptr{ImGuiContext}, ())
end

function igSetCurrentContext(ctx)
    ccall((:igSetCurrentContext, libcimgui), Cvoid, (Ptr{ImGuiContext},), ctx)
end

function igGetIO()
    ccall((:igGetIO, libcimgui), Ptr{ImGuiIO}, ())
end

function igGetStyle()
    ccall((:igGetStyle, libcimgui), Ptr{ImGuiStyle}, ())
end

function igNewFrame()
    ccall((:igNewFrame, libcimgui), Cvoid, ())
end

function igEndFrame()
    ccall((:igEndFrame, libcimgui), Cvoid, ())
end

function igRender()
    ccall((:igRender, libcimgui), Cvoid, ())
end

function igGetDrawData()
    ccall((:igGetDrawData, libcimgui), Ptr{ImDrawData}, ())
end

function igShowDemoWindow(p_open)
    ccall((:igShowDemoWindow, libcimgui), Cvoid, (Ptr{Bool},), p_open)
end

function igShowMetricsWindow(p_open)
    ccall((:igShowMetricsWindow, libcimgui), Cvoid, (Ptr{Bool},), p_open)
end

function igShowDebugLogWindow(p_open)
    ccall((:igShowDebugLogWindow, libcimgui), Cvoid, (Ptr{Bool},), p_open)
end

function igShowIDStackToolWindow(p_open)
    ccall((:igShowIDStackToolWindow, libcimgui), Cvoid, (Ptr{Bool},), p_open)
end

function igShowAboutWindow(p_open)
    ccall((:igShowAboutWindow, libcimgui), Cvoid, (Ptr{Bool},), p_open)
end

function igShowStyleEditor(ref)
    ccall((:igShowStyleEditor, libcimgui), Cvoid, (Ptr{ImGuiStyle},), ref)
end

function igShowStyleSelector(label)
    ccall((:igShowStyleSelector, libcimgui), Bool, (Ptr{Cchar},), label)
end

function igShowFontSelector(label)
    ccall((:igShowFontSelector, libcimgui), Cvoid, (Ptr{Cchar},), label)
end

function igShowUserGuide()
    ccall((:igShowUserGuide, libcimgui), Cvoid, ())
end

function igGetVersion()
    ccall((:igGetVersion, libcimgui), Ptr{Cchar}, ())
end

function igStyleColorsDark(dst)
    ccall((:igStyleColorsDark, libcimgui), Cvoid, (Ptr{ImGuiStyle},), dst)
end

function igStyleColorsLight(dst)
    ccall((:igStyleColorsLight, libcimgui), Cvoid, (Ptr{ImGuiStyle},), dst)
end

function igStyleColorsClassic(dst)
    ccall((:igStyleColorsClassic, libcimgui), Cvoid, (Ptr{ImGuiStyle},), dst)
end

function igBegin(name, p_open, flags)
    ccall((:igBegin, libcimgui), Bool, (Ptr{Cchar}, Ptr{Bool}, ImGuiWindowFlags), name, p_open, flags)
end

function igEnd()
    ccall((:igEnd, libcimgui), Cvoid, ())
end

function igBeginChild_Str(str_id, size, child_flags, window_flags)
    ccall((:igBeginChild_Str, libcimgui), Bool, (Ptr{Cchar}, ImVec2, ImGuiChildFlags, ImGuiWindowFlags), str_id, size, child_flags, window_flags)
end

function igBeginChild_ID(id, size, child_flags, window_flags)
    ccall((:igBeginChild_ID, libcimgui), Bool, (ImGuiID, ImVec2, ImGuiChildFlags, ImGuiWindowFlags), id, size, child_flags, window_flags)
end

function igEndChild()
    ccall((:igEndChild, libcimgui), Cvoid, ())
end

function igIsWindowAppearing()
    ccall((:igIsWindowAppearing, libcimgui), Bool, ())
end

function igIsWindowCollapsed()
    ccall((:igIsWindowCollapsed, libcimgui), Bool, ())
end

function igIsWindowFocused(flags)
    ccall((:igIsWindowFocused, libcimgui), Bool, (ImGuiFocusedFlags,), flags)
end

function igIsWindowHovered(flags)
    ccall((:igIsWindowHovered, libcimgui), Bool, (ImGuiHoveredFlags,), flags)
end

function igGetWindowDrawList()
    ccall((:igGetWindowDrawList, libcimgui), Ptr{ImDrawList}, ())
end

function igGetWindowDpiScale()
    ccall((:igGetWindowDpiScale, libcimgui), Cfloat, ())
end

function igGetWindowPos(pOut)
    ccall((:igGetWindowPos, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetWindowSize(pOut)
    ccall((:igGetWindowSize, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetWindowWidth()
    ccall((:igGetWindowWidth, libcimgui), Cfloat, ())
end

function igGetWindowHeight()
    ccall((:igGetWindowHeight, libcimgui), Cfloat, ())
end

function igGetWindowViewport()
    ccall((:igGetWindowViewport, libcimgui), Ptr{ImGuiViewport}, ())
end

function igSetNextWindowPos(pos, cond, pivot)
    ccall((:igSetNextWindowPos, libcimgui), Cvoid, (ImVec2, ImGuiCond, ImVec2), pos, cond, pivot)
end

function igSetNextWindowSize(size, cond)
    ccall((:igSetNextWindowSize, libcimgui), Cvoid, (ImVec2, ImGuiCond), size, cond)
end

function igSetNextWindowSizeConstraints(size_min, size_max, custom_callback, custom_callback_data)
    ccall((:igSetNextWindowSizeConstraints, libcimgui), Cvoid, (ImVec2, ImVec2, ImGuiSizeCallback, Ptr{Cvoid}), size_min, size_max, custom_callback, custom_callback_data)
end

function igSetNextWindowContentSize(size)
    ccall((:igSetNextWindowContentSize, libcimgui), Cvoid, (ImVec2,), size)
end

function igSetNextWindowCollapsed(collapsed, cond)
    ccall((:igSetNextWindowCollapsed, libcimgui), Cvoid, (Bool, ImGuiCond), collapsed, cond)
end

function igSetNextWindowFocus()
    ccall((:igSetNextWindowFocus, libcimgui), Cvoid, ())
end

function igSetNextWindowScroll(scroll)
    ccall((:igSetNextWindowScroll, libcimgui), Cvoid, (ImVec2,), scroll)
end

function igSetNextWindowBgAlpha(alpha)
    ccall((:igSetNextWindowBgAlpha, libcimgui), Cvoid, (Cfloat,), alpha)
end

function igSetNextWindowViewport(viewport_id)
    ccall((:igSetNextWindowViewport, libcimgui), Cvoid, (ImGuiID,), viewport_id)
end

function igSetWindowPos_Vec2(pos, cond)
    ccall((:igSetWindowPos_Vec2, libcimgui), Cvoid, (ImVec2, ImGuiCond), pos, cond)
end

function igSetWindowSize_Vec2(size, cond)
    ccall((:igSetWindowSize_Vec2, libcimgui), Cvoid, (ImVec2, ImGuiCond), size, cond)
end

function igSetWindowCollapsed_Bool(collapsed, cond)
    ccall((:igSetWindowCollapsed_Bool, libcimgui), Cvoid, (Bool, ImGuiCond), collapsed, cond)
end

function igSetWindowFocus_Nil()
    ccall((:igSetWindowFocus_Nil, libcimgui), Cvoid, ())
end

function igSetWindowFontScale(scale)
    ccall((:igSetWindowFontScale, libcimgui), Cvoid, (Cfloat,), scale)
end

function igSetWindowPos_Str(name, pos, cond)
    ccall((:igSetWindowPos_Str, libcimgui), Cvoid, (Ptr{Cchar}, ImVec2, ImGuiCond), name, pos, cond)
end

function igSetWindowSize_Str(name, size, cond)
    ccall((:igSetWindowSize_Str, libcimgui), Cvoid, (Ptr{Cchar}, ImVec2, ImGuiCond), name, size, cond)
end

function igSetWindowCollapsed_Str(name, collapsed, cond)
    ccall((:igSetWindowCollapsed_Str, libcimgui), Cvoid, (Ptr{Cchar}, Bool, ImGuiCond), name, collapsed, cond)
end

function igSetWindowFocus_Str(name)
    ccall((:igSetWindowFocus_Str, libcimgui), Cvoid, (Ptr{Cchar},), name)
end

function igGetScrollX()
    ccall((:igGetScrollX, libcimgui), Cfloat, ())
end

function igGetScrollY()
    ccall((:igGetScrollY, libcimgui), Cfloat, ())
end

function igSetScrollX_Float(scroll_x)
    ccall((:igSetScrollX_Float, libcimgui), Cvoid, (Cfloat,), scroll_x)
end

function igSetScrollY_Float(scroll_y)
    ccall((:igSetScrollY_Float, libcimgui), Cvoid, (Cfloat,), scroll_y)
end

function igGetScrollMaxX()
    ccall((:igGetScrollMaxX, libcimgui), Cfloat, ())
end

function igGetScrollMaxY()
    ccall((:igGetScrollMaxY, libcimgui), Cfloat, ())
end

function igSetScrollHereX(center_x_ratio)
    ccall((:igSetScrollHereX, libcimgui), Cvoid, (Cfloat,), center_x_ratio)
end

function igSetScrollHereY(center_y_ratio)
    ccall((:igSetScrollHereY, libcimgui), Cvoid, (Cfloat,), center_y_ratio)
end

function igSetScrollFromPosX_Float(local_x, center_x_ratio)
    ccall((:igSetScrollFromPosX_Float, libcimgui), Cvoid, (Cfloat, Cfloat), local_x, center_x_ratio)
end

function igSetScrollFromPosY_Float(local_y, center_y_ratio)
    ccall((:igSetScrollFromPosY_Float, libcimgui), Cvoid, (Cfloat, Cfloat), local_y, center_y_ratio)
end

function igPushFont(font)
    ccall((:igPushFont, libcimgui), Cvoid, (Ptr{ImFont},), font)
end

function igPopFont()
    ccall((:igPopFont, libcimgui), Cvoid, ())
end

function igPushStyleColor_U32(idx, col)
    ccall((:igPushStyleColor_U32, libcimgui), Cvoid, (ImGuiCol, ImU32), idx, col)
end

function igPushStyleColor_Vec4(idx, col)
    ccall((:igPushStyleColor_Vec4, libcimgui), Cvoid, (ImGuiCol, ImVec4), idx, col)
end

function igPopStyleColor(count)
    ccall((:igPopStyleColor, libcimgui), Cvoid, (Cint,), count)
end

function igPushStyleVar_Float(idx, val)
    ccall((:igPushStyleVar_Float, libcimgui), Cvoid, (ImGuiStyleVar, Cfloat), idx, val)
end

function igPushStyleVar_Vec2(idx, val)
    ccall((:igPushStyleVar_Vec2, libcimgui), Cvoid, (ImGuiStyleVar, ImVec2), idx, val)
end

function igPopStyleVar(count)
    ccall((:igPopStyleVar, libcimgui), Cvoid, (Cint,), count)
end

function igPushItemFlag(option, enabled)
    ccall((:igPushItemFlag, libcimgui), Cvoid, (ImGuiItemFlags, Bool), option, enabled)
end

function igPopItemFlag()
    ccall((:igPopItemFlag, libcimgui), Cvoid, ())
end

function igPushItemWidth(item_width)
    ccall((:igPushItemWidth, libcimgui), Cvoid, (Cfloat,), item_width)
end

function igPopItemWidth()
    ccall((:igPopItemWidth, libcimgui), Cvoid, ())
end

function igSetNextItemWidth(item_width)
    ccall((:igSetNextItemWidth, libcimgui), Cvoid, (Cfloat,), item_width)
end

function igCalcItemWidth()
    ccall((:igCalcItemWidth, libcimgui), Cfloat, ())
end

function igPushTextWrapPos(wrap_local_pos_x)
    ccall((:igPushTextWrapPos, libcimgui), Cvoid, (Cfloat,), wrap_local_pos_x)
end

function igPopTextWrapPos()
    ccall((:igPopTextWrapPos, libcimgui), Cvoid, ())
end

function igGetFont()
    ccall((:igGetFont, libcimgui), Ptr{ImFont}, ())
end

function igGetFontSize()
    ccall((:igGetFontSize, libcimgui), Cfloat, ())
end

function igGetFontTexUvWhitePixel(pOut)
    ccall((:igGetFontTexUvWhitePixel, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetColorU32_Col(idx, alpha_mul)
    ccall((:igGetColorU32_Col, libcimgui), ImU32, (ImGuiCol, Cfloat), idx, alpha_mul)
end

function igGetColorU32_Vec4(col)
    ccall((:igGetColorU32_Vec4, libcimgui), ImU32, (ImVec4,), col)
end

function igGetColorU32_U32(col, alpha_mul)
    ccall((:igGetColorU32_U32, libcimgui), ImU32, (ImU32, Cfloat), col, alpha_mul)
end

function igGetStyleColorVec4(idx)
    ccall((:igGetStyleColorVec4, libcimgui), Ptr{ImVec4}, (ImGuiCol,), idx)
end

function igGetCursorScreenPos(pOut)
    ccall((:igGetCursorScreenPos, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igSetCursorScreenPos(pos)
    ccall((:igSetCursorScreenPos, libcimgui), Cvoid, (ImVec2,), pos)
end

function igGetContentRegionAvail(pOut)
    ccall((:igGetContentRegionAvail, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetCursorPos(pOut)
    ccall((:igGetCursorPos, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetCursorPosX()
    ccall((:igGetCursorPosX, libcimgui), Cfloat, ())
end

function igGetCursorPosY()
    ccall((:igGetCursorPosY, libcimgui), Cfloat, ())
end

function igSetCursorPos(local_pos)
    ccall((:igSetCursorPos, libcimgui), Cvoid, (ImVec2,), local_pos)
end

function igSetCursorPosX(local_x)
    ccall((:igSetCursorPosX, libcimgui), Cvoid, (Cfloat,), local_x)
end

function igSetCursorPosY(local_y)
    ccall((:igSetCursorPosY, libcimgui), Cvoid, (Cfloat,), local_y)
end

function igGetCursorStartPos(pOut)
    ccall((:igGetCursorStartPos, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igSeparator()
    ccall((:igSeparator, libcimgui), Cvoid, ())
end

function igSameLine(offset_from_start_x, spacing)
    ccall((:igSameLine, libcimgui), Cvoid, (Cfloat, Cfloat), offset_from_start_x, spacing)
end

function igNewLine()
    ccall((:igNewLine, libcimgui), Cvoid, ())
end

function igSpacing()
    ccall((:igSpacing, libcimgui), Cvoid, ())
end

function igDummy(size)
    ccall((:igDummy, libcimgui), Cvoid, (ImVec2,), size)
end

function igIndent(indent_w)
    ccall((:igIndent, libcimgui), Cvoid, (Cfloat,), indent_w)
end

function igUnindent(indent_w)
    ccall((:igUnindent, libcimgui), Cvoid, (Cfloat,), indent_w)
end

function igBeginGroup()
    ccall((:igBeginGroup, libcimgui), Cvoid, ())
end

function igEndGroup()
    ccall((:igEndGroup, libcimgui), Cvoid, ())
end

function igAlignTextToFramePadding()
    ccall((:igAlignTextToFramePadding, libcimgui), Cvoid, ())
end

function igGetTextLineHeight()
    ccall((:igGetTextLineHeight, libcimgui), Cfloat, ())
end

function igGetTextLineHeightWithSpacing()
    ccall((:igGetTextLineHeightWithSpacing, libcimgui), Cfloat, ())
end

function igGetFrameHeight()
    ccall((:igGetFrameHeight, libcimgui), Cfloat, ())
end

function igGetFrameHeightWithSpacing()
    ccall((:igGetFrameHeightWithSpacing, libcimgui), Cfloat, ())
end

function igPushID_Str(str_id)
    ccall((:igPushID_Str, libcimgui), Cvoid, (Ptr{Cchar},), str_id)
end

function igPushID_StrStr(str_id_begin, str_id_end)
    ccall((:igPushID_StrStr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cchar}), str_id_begin, str_id_end)
end

function igPushID_Ptr(ptr_id)
    ccall((:igPushID_Ptr, libcimgui), Cvoid, (Ptr{Cvoid},), ptr_id)
end

function igPushID_Int(int_id)
    ccall((:igPushID_Int, libcimgui), Cvoid, (Cint,), int_id)
end

function igPopID()
    ccall((:igPopID, libcimgui), Cvoid, ())
end

function igGetID_Str(str_id)
    ccall((:igGetID_Str, libcimgui), ImGuiID, (Ptr{Cchar},), str_id)
end

function igGetID_StrStr(str_id_begin, str_id_end)
    ccall((:igGetID_StrStr, libcimgui), ImGuiID, (Ptr{Cchar}, Ptr{Cchar}), str_id_begin, str_id_end)
end

function igGetID_Ptr(ptr_id)
    ccall((:igGetID_Ptr, libcimgui), ImGuiID, (Ptr{Cvoid},), ptr_id)
end

function igGetID_Int(int_id)
    ccall((:igGetID_Int, libcimgui), ImGuiID, (Cint,), int_id)
end

function igTextUnformatted(text, text_end)
    ccall((:igTextUnformatted, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cchar}), text, text_end)
end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function igText(fmt, va_list...)
        :(@ccall(libcimgui.igText(fmt::Ptr{Cchar}; $(to_c_type_pairs(va_list)...))::Cvoid))
    end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function igTextColored(col, fmt, va_list...)
        :(@ccall(libcimgui.igTextColored(col::ImVec4, fmt::Ptr{Cchar}; $(to_c_type_pairs(va_list)...))::Cvoid))
    end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function igTextDisabled(fmt, va_list...)
        :(@ccall(libcimgui.igTextDisabled(fmt::Ptr{Cchar}; $(to_c_type_pairs(va_list)...))::Cvoid))
    end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function igTextWrapped(fmt, va_list...)
        :(@ccall(libcimgui.igTextWrapped(fmt::Ptr{Cchar}; $(to_c_type_pairs(va_list)...))::Cvoid))
    end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function igLabelText(label, fmt, va_list...)
        :(@ccall(libcimgui.igLabelText(label::Ptr{Cchar}, fmt::Ptr{Cchar}; $(to_c_type_pairs(va_list)...))::Cvoid))
    end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function igBulletText(fmt, va_list...)
        :(@ccall(libcimgui.igBulletText(fmt::Ptr{Cchar}; $(to_c_type_pairs(va_list)...))::Cvoid))
    end

function igSeparatorText(label)
    ccall((:igSeparatorText, libcimgui), Cvoid, (Ptr{Cchar},), label)
end

function igButton(label, size)
    ccall((:igButton, libcimgui), Bool, (Ptr{Cchar}, ImVec2), label, size)
end

function igSmallButton(label)
    ccall((:igSmallButton, libcimgui), Bool, (Ptr{Cchar},), label)
end

function igInvisibleButton(str_id, size, flags)
    ccall((:igInvisibleButton, libcimgui), Bool, (Ptr{Cchar}, ImVec2, ImGuiButtonFlags), str_id, size, flags)
end

function igArrowButton(str_id, dir)
    ccall((:igArrowButton, libcimgui), Bool, (Ptr{Cchar}, ImGuiDir), str_id, dir)
end

function igCheckbox(label, v)
    ccall((:igCheckbox, libcimgui), Bool, (Ptr{Cchar}, Ptr{Bool}), label, v)
end

function igCheckboxFlags_IntPtr(label, flags, flags_value)
    ccall((:igCheckboxFlags_IntPtr, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, Cint), label, flags, flags_value)
end

function igCheckboxFlags_UintPtr(label, flags, flags_value)
    ccall((:igCheckboxFlags_UintPtr, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cuint}, Cuint), label, flags, flags_value)
end

function igRadioButton_Bool(label, active)
    ccall((:igRadioButton_Bool, libcimgui), Bool, (Ptr{Cchar}, Bool), label, active)
end

function igRadioButton_IntPtr(label, v, v_button)
    ccall((:igRadioButton_IntPtr, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, Cint), label, v, v_button)
end

function igProgressBar(fraction, size_arg, overlay)
    ccall((:igProgressBar, libcimgui), Cvoid, (Cfloat, ImVec2, Ptr{Cchar}), fraction, size_arg, overlay)
end

function igBullet()
    ccall((:igBullet, libcimgui), Cvoid, ())
end

function igTextLink(label)
    ccall((:igTextLink, libcimgui), Bool, (Ptr{Cchar},), label)
end

function igTextLinkOpenURL(label, url)
    ccall((:igTextLinkOpenURL, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cchar}), label, url)
end

function igImage(user_texture_id, image_size, uv0, uv1, tint_col, border_col)
    ccall((:igImage, libcimgui), Cvoid, (ImTextureID, ImVec2, ImVec2, ImVec2, ImVec4, ImVec4), user_texture_id, image_size, uv0, uv1, tint_col, border_col)
end

function igImageButton(str_id, user_texture_id, image_size, uv0, uv1, bg_col, tint_col)
    ccall((:igImageButton, libcimgui), Bool, (Ptr{Cchar}, ImTextureID, ImVec2, ImVec2, ImVec2, ImVec4, ImVec4), str_id, user_texture_id, image_size, uv0, uv1, bg_col, tint_col)
end

function igBeginCombo(label, preview_value, flags)
    ccall((:igBeginCombo, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cchar}, ImGuiComboFlags), label, preview_value, flags)
end

function igEndCombo()
    ccall((:igEndCombo, libcimgui), Cvoid, ())
end

function igCombo_Str_arr(label, current_item, items, items_count, popup_max_height_in_items)
    ccall((:igCombo_Str_arr, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, Ptr{Ptr{Cchar}}, Cint, Cint), label, current_item, items, items_count, popup_max_height_in_items)
end

function igCombo_Str(label, current_item, items_separated_by_zeros, popup_max_height_in_items)
    ccall((:igCombo_Str, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, Ptr{Cchar}, Cint), label, current_item, items_separated_by_zeros, popup_max_height_in_items)
end

function igCombo_FnStrPtr(label, current_item, getter, user_data, items_count, popup_max_height_in_items)
    ccall((:igCombo_FnStrPtr, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, Ptr{Cvoid}, Ptr{Cvoid}, Cint, Cint), label, current_item, getter, user_data, items_count, popup_max_height_in_items)
end

function igDragFloat(label, v, v_speed, v_min, v_max, format, flags)
    ccall((:igDragFloat, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cfloat}, Cfloat, Cfloat, Cfloat, Ptr{Cchar}, ImGuiSliderFlags), label, v, v_speed, v_min, v_max, format, flags)
end

function igDragFloat2(label, v, v_speed, v_min, v_max, format, flags)
    ccall((:igDragFloat2, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cfloat}, Cfloat, Cfloat, Cfloat, Ptr{Cchar}, ImGuiSliderFlags), label, v, v_speed, v_min, v_max, format, flags)
end

function igDragFloat3(label, v, v_speed, v_min, v_max, format, flags)
    ccall((:igDragFloat3, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cfloat}, Cfloat, Cfloat, Cfloat, Ptr{Cchar}, ImGuiSliderFlags), label, v, v_speed, v_min, v_max, format, flags)
end

function igDragFloat4(label, v, v_speed, v_min, v_max, format, flags)
    ccall((:igDragFloat4, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cfloat}, Cfloat, Cfloat, Cfloat, Ptr{Cchar}, ImGuiSliderFlags), label, v, v_speed, v_min, v_max, format, flags)
end

function igDragFloatRange2(label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max, flags)
    ccall((:igDragFloatRange2, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cfloat}, Ptr{Cfloat}, Cfloat, Cfloat, Cfloat, Ptr{Cchar}, Ptr{Cchar}, ImGuiSliderFlags), label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max, flags)
end

function igDragInt(label, v, v_speed, v_min, v_max, format, flags)
    ccall((:igDragInt, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, Cfloat, Cint, Cint, Ptr{Cchar}, ImGuiSliderFlags), label, v, v_speed, v_min, v_max, format, flags)
end

function igDragInt2(label, v, v_speed, v_min, v_max, format, flags)
    ccall((:igDragInt2, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, Cfloat, Cint, Cint, Ptr{Cchar}, ImGuiSliderFlags), label, v, v_speed, v_min, v_max, format, flags)
end

function igDragInt3(label, v, v_speed, v_min, v_max, format, flags)
    ccall((:igDragInt3, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, Cfloat, Cint, Cint, Ptr{Cchar}, ImGuiSliderFlags), label, v, v_speed, v_min, v_max, format, flags)
end

function igDragInt4(label, v, v_speed, v_min, v_max, format, flags)
    ccall((:igDragInt4, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, Cfloat, Cint, Cint, Ptr{Cchar}, ImGuiSliderFlags), label, v, v_speed, v_min, v_max, format, flags)
end

function igDragIntRange2(label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max, flags)
    ccall((:igDragIntRange2, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, Ptr{Cint}, Cfloat, Cint, Cint, Ptr{Cchar}, Ptr{Cchar}, ImGuiSliderFlags), label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max, flags)
end

function igDragScalar(label, data_type, p_data, v_speed, p_min, p_max, format, flags)
    ccall((:igDragScalar, libcimgui), Bool, (Ptr{Cchar}, ImGuiDataType, Ptr{Cvoid}, Cfloat, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cchar}, ImGuiSliderFlags), label, data_type, p_data, v_speed, p_min, p_max, format, flags)
end

function igDragScalarN(label, data_type, p_data, components, v_speed, p_min, p_max, format, flags)
    ccall((:igDragScalarN, libcimgui), Bool, (Ptr{Cchar}, ImGuiDataType, Ptr{Cvoid}, Cint, Cfloat, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cchar}, ImGuiSliderFlags), label, data_type, p_data, components, v_speed, p_min, p_max, format, flags)
end

function igSliderFloat(label, v, v_min, v_max, format, flags)
    ccall((:igSliderFloat, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cfloat}, Cfloat, Cfloat, Ptr{Cchar}, ImGuiSliderFlags), label, v, v_min, v_max, format, flags)
end

function igSliderFloat2(label, v, v_min, v_max, format, flags)
    ccall((:igSliderFloat2, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cfloat}, Cfloat, Cfloat, Ptr{Cchar}, ImGuiSliderFlags), label, v, v_min, v_max, format, flags)
end

function igSliderFloat3(label, v, v_min, v_max, format, flags)
    ccall((:igSliderFloat3, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cfloat}, Cfloat, Cfloat, Ptr{Cchar}, ImGuiSliderFlags), label, v, v_min, v_max, format, flags)
end

function igSliderFloat4(label, v, v_min, v_max, format, flags)
    ccall((:igSliderFloat4, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cfloat}, Cfloat, Cfloat, Ptr{Cchar}, ImGuiSliderFlags), label, v, v_min, v_max, format, flags)
end

function igSliderAngle(label, v_rad, v_degrees_min, v_degrees_max, format, flags)
    ccall((:igSliderAngle, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cfloat}, Cfloat, Cfloat, Ptr{Cchar}, ImGuiSliderFlags), label, v_rad, v_degrees_min, v_degrees_max, format, flags)
end

function igSliderInt(label, v, v_min, v_max, format, flags)
    ccall((:igSliderInt, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, Cint, Cint, Ptr{Cchar}, ImGuiSliderFlags), label, v, v_min, v_max, format, flags)
end

function igSliderInt2(label, v, v_min, v_max, format, flags)
    ccall((:igSliderInt2, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, Cint, Cint, Ptr{Cchar}, ImGuiSliderFlags), label, v, v_min, v_max, format, flags)
end

function igSliderInt3(label, v, v_min, v_max, format, flags)
    ccall((:igSliderInt3, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, Cint, Cint, Ptr{Cchar}, ImGuiSliderFlags), label, v, v_min, v_max, format, flags)
end

function igSliderInt4(label, v, v_min, v_max, format, flags)
    ccall((:igSliderInt4, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, Cint, Cint, Ptr{Cchar}, ImGuiSliderFlags), label, v, v_min, v_max, format, flags)
end

function igSliderScalar(label, data_type, p_data, p_min, p_max, format, flags)
    ccall((:igSliderScalar, libcimgui), Bool, (Ptr{Cchar}, ImGuiDataType, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cchar}, ImGuiSliderFlags), label, data_type, p_data, p_min, p_max, format, flags)
end

function igSliderScalarN(label, data_type, p_data, components, p_min, p_max, format, flags)
    ccall((:igSliderScalarN, libcimgui), Bool, (Ptr{Cchar}, ImGuiDataType, Ptr{Cvoid}, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cchar}, ImGuiSliderFlags), label, data_type, p_data, components, p_min, p_max, format, flags)
end

function igVSliderFloat(label, size, v, v_min, v_max, format, flags)
    ccall((:igVSliderFloat, libcimgui), Bool, (Ptr{Cchar}, ImVec2, Ptr{Cfloat}, Cfloat, Cfloat, Ptr{Cchar}, ImGuiSliderFlags), label, size, v, v_min, v_max, format, flags)
end

function igVSliderInt(label, size, v, v_min, v_max, format, flags)
    ccall((:igVSliderInt, libcimgui), Bool, (Ptr{Cchar}, ImVec2, Ptr{Cint}, Cint, Cint, Ptr{Cchar}, ImGuiSliderFlags), label, size, v, v_min, v_max, format, flags)
end

function igVSliderScalar(label, size, data_type, p_data, p_min, p_max, format, flags)
    ccall((:igVSliderScalar, libcimgui), Bool, (Ptr{Cchar}, ImVec2, ImGuiDataType, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cchar}, ImGuiSliderFlags), label, size, data_type, p_data, p_min, p_max, format, flags)
end

function igInputText(label, buf, buf_size, flags, callback, user_data)
    ccall((:igInputText, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cchar}, Csize_t, ImGuiInputTextFlags, ImGuiInputTextCallback, Ptr{Cvoid}), label, buf, buf_size, flags, callback, user_data)
end

function igInputTextMultiline(label, buf, buf_size, size, flags, callback, user_data)
    ccall((:igInputTextMultiline, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cchar}, Csize_t, ImVec2, ImGuiInputTextFlags, ImGuiInputTextCallback, Ptr{Cvoid}), label, buf, buf_size, size, flags, callback, user_data)
end

function igInputTextWithHint(label, hint, buf, buf_size, flags, callback, user_data)
    ccall((:igInputTextWithHint, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cchar}, Ptr{Cchar}, Csize_t, ImGuiInputTextFlags, ImGuiInputTextCallback, Ptr{Cvoid}), label, hint, buf, buf_size, flags, callback, user_data)
end

function igInputFloat(label, v, step, step_fast, format, flags)
    ccall((:igInputFloat, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cfloat}, Cfloat, Cfloat, Ptr{Cchar}, ImGuiInputTextFlags), label, v, step, step_fast, format, flags)
end

function igInputFloat2(label, v, format, flags)
    ccall((:igInputFloat2, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cfloat}, Ptr{Cchar}, ImGuiInputTextFlags), label, v, format, flags)
end

function igInputFloat3(label, v, format, flags)
    ccall((:igInputFloat3, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cfloat}, Ptr{Cchar}, ImGuiInputTextFlags), label, v, format, flags)
end

function igInputFloat4(label, v, format, flags)
    ccall((:igInputFloat4, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cfloat}, Ptr{Cchar}, ImGuiInputTextFlags), label, v, format, flags)
end

function igInputInt(label, v, step, step_fast, flags)
    ccall((:igInputInt, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, Cint, Cint, ImGuiInputTextFlags), label, v, step, step_fast, flags)
end

function igInputInt2(label, v, flags)
    ccall((:igInputInt2, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, ImGuiInputTextFlags), label, v, flags)
end

function igInputInt3(label, v, flags)
    ccall((:igInputInt3, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, ImGuiInputTextFlags), label, v, flags)
end

function igInputInt4(label, v, flags)
    ccall((:igInputInt4, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, ImGuiInputTextFlags), label, v, flags)
end

function igInputDouble(label, v, step, step_fast, format, flags)
    ccall((:igInputDouble, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cdouble}, Cdouble, Cdouble, Ptr{Cchar}, ImGuiInputTextFlags), label, v, step, step_fast, format, flags)
end

function igInputScalar(label, data_type, p_data, p_step, p_step_fast, format, flags)
    ccall((:igInputScalar, libcimgui), Bool, (Ptr{Cchar}, ImGuiDataType, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cchar}, ImGuiInputTextFlags), label, data_type, p_data, p_step, p_step_fast, format, flags)
end

function igInputScalarN(label, data_type, p_data, components, p_step, p_step_fast, format, flags)
    ccall((:igInputScalarN, libcimgui), Bool, (Ptr{Cchar}, ImGuiDataType, Ptr{Cvoid}, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cchar}, ImGuiInputTextFlags), label, data_type, p_data, components, p_step, p_step_fast, format, flags)
end

function igColorEdit3(label, col, flags)
    ccall((:igColorEdit3, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cfloat}, ImGuiColorEditFlags), label, col, flags)
end

function igColorEdit4(label, col, flags)
    ccall((:igColorEdit4, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cfloat}, ImGuiColorEditFlags), label, col, flags)
end

function igColorPicker3(label, col, flags)
    ccall((:igColorPicker3, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cfloat}, ImGuiColorEditFlags), label, col, flags)
end

function igColorPicker4(label, col, flags, ref_col)
    ccall((:igColorPicker4, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cfloat}, ImGuiColorEditFlags, Ptr{Cfloat}), label, col, flags, ref_col)
end

function igColorButton(desc_id, col, flags, size)
    ccall((:igColorButton, libcimgui), Bool, (Ptr{Cchar}, ImVec4, ImGuiColorEditFlags, ImVec2), desc_id, col, flags, size)
end

function igSetColorEditOptions(flags)
    ccall((:igSetColorEditOptions, libcimgui), Cvoid, (ImGuiColorEditFlags,), flags)
end

function igTreeNode_Str(label)
    ccall((:igTreeNode_Str, libcimgui), Bool, (Ptr{Cchar},), label)
end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function igTreeNode_StrStr(str_id, fmt, va_list...)
        :(@ccall(libcimgui.igTreeNode_StrStr(str_id::Ptr{Cchar}, fmt::Ptr{Cchar}; $(to_c_type_pairs(va_list)...))::Bool))
    end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function igTreeNode_Ptr(ptr_id, fmt, va_list...)
        :(@ccall(libcimgui.igTreeNode_Ptr(ptr_id::Ptr{Cvoid}, fmt::Ptr{Cchar}; $(to_c_type_pairs(va_list)...))::Bool))
    end

function igTreeNodeEx_Str(label, flags)
    ccall((:igTreeNodeEx_Str, libcimgui), Bool, (Ptr{Cchar}, ImGuiTreeNodeFlags), label, flags)
end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function igTreeNodeEx_StrStr(str_id, flags, fmt, va_list...)
        :(@ccall(libcimgui.igTreeNodeEx_StrStr(str_id::Ptr{Cchar}, flags::ImGuiTreeNodeFlags, fmt::Ptr{Cchar}; $(to_c_type_pairs(va_list)...))::Bool))
    end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function igTreeNodeEx_Ptr(ptr_id, flags, fmt, va_list...)
        :(@ccall(libcimgui.igTreeNodeEx_Ptr(ptr_id::Ptr{Cvoid}, flags::ImGuiTreeNodeFlags, fmt::Ptr{Cchar}; $(to_c_type_pairs(va_list)...))::Bool))
    end

function igTreePush_Str(str_id)
    ccall((:igTreePush_Str, libcimgui), Cvoid, (Ptr{Cchar},), str_id)
end

function igTreePush_Ptr(ptr_id)
    ccall((:igTreePush_Ptr, libcimgui), Cvoid, (Ptr{Cvoid},), ptr_id)
end

function igTreePop()
    ccall((:igTreePop, libcimgui), Cvoid, ())
end

function igGetTreeNodeToLabelSpacing()
    ccall((:igGetTreeNodeToLabelSpacing, libcimgui), Cfloat, ())
end

function igCollapsingHeader_TreeNodeFlags(label, flags)
    ccall((:igCollapsingHeader_TreeNodeFlags, libcimgui), Bool, (Ptr{Cchar}, ImGuiTreeNodeFlags), label, flags)
end

function igCollapsingHeader_BoolPtr(label, p_visible, flags)
    ccall((:igCollapsingHeader_BoolPtr, libcimgui), Bool, (Ptr{Cchar}, Ptr{Bool}, ImGuiTreeNodeFlags), label, p_visible, flags)
end

function igSetNextItemOpen(is_open, cond)
    ccall((:igSetNextItemOpen, libcimgui), Cvoid, (Bool, ImGuiCond), is_open, cond)
end

function igSetNextItemStorageID(storage_id)
    ccall((:igSetNextItemStorageID, libcimgui), Cvoid, (ImGuiID,), storage_id)
end

function igSelectable_Bool(label, selected, flags, size)
    ccall((:igSelectable_Bool, libcimgui), Bool, (Ptr{Cchar}, Bool, ImGuiSelectableFlags, ImVec2), label, selected, flags, size)
end

function igSelectable_BoolPtr(label, p_selected, flags, size)
    ccall((:igSelectable_BoolPtr, libcimgui), Bool, (Ptr{Cchar}, Ptr{Bool}, ImGuiSelectableFlags, ImVec2), label, p_selected, flags, size)
end

function igBeginMultiSelect(flags, selection_size, items_count)
    ccall((:igBeginMultiSelect, libcimgui), Ptr{ImGuiMultiSelectIO}, (ImGuiMultiSelectFlags, Cint, Cint), flags, selection_size, items_count)
end

function igEndMultiSelect()
    ccall((:igEndMultiSelect, libcimgui), Ptr{ImGuiMultiSelectIO}, ())
end

function igSetNextItemSelectionUserData(selection_user_data)
    ccall((:igSetNextItemSelectionUserData, libcimgui), Cvoid, (ImGuiSelectionUserData,), selection_user_data)
end

function igIsItemToggledSelection()
    ccall((:igIsItemToggledSelection, libcimgui), Bool, ())
end

function igBeginListBox(label, size)
    ccall((:igBeginListBox, libcimgui), Bool, (Ptr{Cchar}, ImVec2), label, size)
end

function igEndListBox()
    ccall((:igEndListBox, libcimgui), Cvoid, ())
end

function igListBox_Str_arr(label, current_item, items, items_count, height_in_items)
    ccall((:igListBox_Str_arr, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, Ptr{Ptr{Cchar}}, Cint, Cint), label, current_item, items, items_count, height_in_items)
end

function igListBox_FnStrPtr(label, current_item, getter, user_data, items_count, height_in_items)
    ccall((:igListBox_FnStrPtr, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, Ptr{Cvoid}, Ptr{Cvoid}, Cint, Cint), label, current_item, getter, user_data, items_count, height_in_items)
end

function igPlotLines_FloatPtr(label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride)
    ccall((:igPlotLines_FloatPtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cfloat}, Cint, Cint, Ptr{Cchar}, Cfloat, Cfloat, ImVec2, Cint), label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride)
end

function igPlotLines_FnFloatPtr(label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size)
    ccall((:igPlotLines_FnFloatPtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cvoid}, Ptr{Cvoid}, Cint, Cint, Ptr{Cchar}, Cfloat, Cfloat, ImVec2), label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size)
end

function igPlotHistogram_FloatPtr(label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride)
    ccall((:igPlotHistogram_FloatPtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cfloat}, Cint, Cint, Ptr{Cchar}, Cfloat, Cfloat, ImVec2, Cint), label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride)
end

function igPlotHistogram_FnFloatPtr(label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size)
    ccall((:igPlotHistogram_FnFloatPtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cvoid}, Ptr{Cvoid}, Cint, Cint, Ptr{Cchar}, Cfloat, Cfloat, ImVec2), label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size)
end

function igValue_Bool(prefix, b)
    ccall((:igValue_Bool, libcimgui), Cvoid, (Ptr{Cchar}, Bool), prefix, b)
end

function igValue_Int(prefix, v)
    ccall((:igValue_Int, libcimgui), Cvoid, (Ptr{Cchar}, Cint), prefix, v)
end

function igValue_Uint(prefix, v)
    ccall((:igValue_Uint, libcimgui), Cvoid, (Ptr{Cchar}, Cuint), prefix, v)
end

function igValue_Float(prefix, v, float_format)
    ccall((:igValue_Float, libcimgui), Cvoid, (Ptr{Cchar}, Cfloat, Ptr{Cchar}), prefix, v, float_format)
end

function igBeginMenuBar()
    ccall((:igBeginMenuBar, libcimgui), Bool, ())
end

function igEndMenuBar()
    ccall((:igEndMenuBar, libcimgui), Cvoid, ())
end

function igBeginMainMenuBar()
    ccall((:igBeginMainMenuBar, libcimgui), Bool, ())
end

function igEndMainMenuBar()
    ccall((:igEndMainMenuBar, libcimgui), Cvoid, ())
end

function igBeginMenu(label, enabled)
    ccall((:igBeginMenu, libcimgui), Bool, (Ptr{Cchar}, Bool), label, enabled)
end

function igEndMenu()
    ccall((:igEndMenu, libcimgui), Cvoid, ())
end

function igMenuItem_Bool(label, shortcut, selected, enabled)
    ccall((:igMenuItem_Bool, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cchar}, Bool, Bool), label, shortcut, selected, enabled)
end

function igMenuItem_BoolPtr(label, shortcut, p_selected, enabled)
    ccall((:igMenuItem_BoolPtr, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cchar}, Ptr{Bool}, Bool), label, shortcut, p_selected, enabled)
end

function igBeginTooltip()
    ccall((:igBeginTooltip, libcimgui), Bool, ())
end

function igEndTooltip()
    ccall((:igEndTooltip, libcimgui), Cvoid, ())
end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function igSetTooltip(fmt, va_list...)
        :(@ccall(libcimgui.igSetTooltip(fmt::Ptr{Cchar}; $(to_c_type_pairs(va_list)...))::Cvoid))
    end

function igBeginItemTooltip()
    ccall((:igBeginItemTooltip, libcimgui), Bool, ())
end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function igSetItemTooltip(fmt, va_list...)
        :(@ccall(libcimgui.igSetItemTooltip(fmt::Ptr{Cchar}; $(to_c_type_pairs(va_list)...))::Cvoid))
    end

function igBeginPopup(str_id, flags)
    ccall((:igBeginPopup, libcimgui), Bool, (Ptr{Cchar}, ImGuiWindowFlags), str_id, flags)
end

function igBeginPopupModal(name, p_open, flags)
    ccall((:igBeginPopupModal, libcimgui), Bool, (Ptr{Cchar}, Ptr{Bool}, ImGuiWindowFlags), name, p_open, flags)
end

function igEndPopup()
    ccall((:igEndPopup, libcimgui), Cvoid, ())
end

function igOpenPopup_Str(str_id, popup_flags)
    ccall((:igOpenPopup_Str, libcimgui), Cvoid, (Ptr{Cchar}, ImGuiPopupFlags), str_id, popup_flags)
end

function igOpenPopup_ID(id, popup_flags)
    ccall((:igOpenPopup_ID, libcimgui), Cvoid, (ImGuiID, ImGuiPopupFlags), id, popup_flags)
end

function igOpenPopupOnItemClick(str_id, popup_flags)
    ccall((:igOpenPopupOnItemClick, libcimgui), Cvoid, (Ptr{Cchar}, ImGuiPopupFlags), str_id, popup_flags)
end

function igCloseCurrentPopup()
    ccall((:igCloseCurrentPopup, libcimgui), Cvoid, ())
end

function igBeginPopupContextItem(str_id, popup_flags)
    ccall((:igBeginPopupContextItem, libcimgui), Bool, (Ptr{Cchar}, ImGuiPopupFlags), str_id, popup_flags)
end

function igBeginPopupContextWindow(str_id, popup_flags)
    ccall((:igBeginPopupContextWindow, libcimgui), Bool, (Ptr{Cchar}, ImGuiPopupFlags), str_id, popup_flags)
end

function igBeginPopupContextVoid(str_id, popup_flags)
    ccall((:igBeginPopupContextVoid, libcimgui), Bool, (Ptr{Cchar}, ImGuiPopupFlags), str_id, popup_flags)
end

function igIsPopupOpen_Str(str_id, flags)
    ccall((:igIsPopupOpen_Str, libcimgui), Bool, (Ptr{Cchar}, ImGuiPopupFlags), str_id, flags)
end

function igBeginTable(str_id, columns, flags, outer_size, inner_width)
    ccall((:igBeginTable, libcimgui), Bool, (Ptr{Cchar}, Cint, ImGuiTableFlags, ImVec2, Cfloat), str_id, columns, flags, outer_size, inner_width)
end

function igEndTable()
    ccall((:igEndTable, libcimgui), Cvoid, ())
end

function igTableNextRow(row_flags, min_row_height)
    ccall((:igTableNextRow, libcimgui), Cvoid, (ImGuiTableRowFlags, Cfloat), row_flags, min_row_height)
end

function igTableNextColumn()
    ccall((:igTableNextColumn, libcimgui), Bool, ())
end

function igTableSetColumnIndex(column_n)
    ccall((:igTableSetColumnIndex, libcimgui), Bool, (Cint,), column_n)
end

function igTableSetupColumn(label, flags, init_width_or_weight, user_id)
    ccall((:igTableSetupColumn, libcimgui), Cvoid, (Ptr{Cchar}, ImGuiTableColumnFlags, Cfloat, ImGuiID), label, flags, init_width_or_weight, user_id)
end

function igTableSetupScrollFreeze(cols, rows)
    ccall((:igTableSetupScrollFreeze, libcimgui), Cvoid, (Cint, Cint), cols, rows)
end

function igTableHeader(label)
    ccall((:igTableHeader, libcimgui), Cvoid, (Ptr{Cchar},), label)
end

function igTableHeadersRow()
    ccall((:igTableHeadersRow, libcimgui), Cvoid, ())
end

function igTableAngledHeadersRow()
    ccall((:igTableAngledHeadersRow, libcimgui), Cvoid, ())
end

function igTableGetSortSpecs()
    ccall((:igTableGetSortSpecs, libcimgui), Ptr{ImGuiTableSortSpecs}, ())
end

function igTableGetColumnCount()
    ccall((:igTableGetColumnCount, libcimgui), Cint, ())
end

function igTableGetColumnIndex()
    ccall((:igTableGetColumnIndex, libcimgui), Cint, ())
end

function igTableGetRowIndex()
    ccall((:igTableGetRowIndex, libcimgui), Cint, ())
end

function igTableGetColumnName_Int(column_n)
    ccall((:igTableGetColumnName_Int, libcimgui), Ptr{Cchar}, (Cint,), column_n)
end

function igTableGetColumnFlags(column_n)
    ccall((:igTableGetColumnFlags, libcimgui), ImGuiTableColumnFlags, (Cint,), column_n)
end

function igTableSetColumnEnabled(column_n, v)
    ccall((:igTableSetColumnEnabled, libcimgui), Cvoid, (Cint, Bool), column_n, v)
end

function igTableGetHoveredColumn()
    ccall((:igTableGetHoveredColumn, libcimgui), Cint, ())
end

function igTableSetBgColor(target, color, column_n)
    ccall((:igTableSetBgColor, libcimgui), Cvoid, (ImGuiTableBgTarget, ImU32, Cint), target, color, column_n)
end

function igColumns(count, id, border)
    ccall((:igColumns, libcimgui), Cvoid, (Cint, Ptr{Cchar}, Bool), count, id, border)
end

function igNextColumn()
    ccall((:igNextColumn, libcimgui), Cvoid, ())
end

function igGetColumnIndex()
    ccall((:igGetColumnIndex, libcimgui), Cint, ())
end

function igGetColumnWidth(column_index)
    ccall((:igGetColumnWidth, libcimgui), Cfloat, (Cint,), column_index)
end

function igSetColumnWidth(column_index, width)
    ccall((:igSetColumnWidth, libcimgui), Cvoid, (Cint, Cfloat), column_index, width)
end

function igGetColumnOffset(column_index)
    ccall((:igGetColumnOffset, libcimgui), Cfloat, (Cint,), column_index)
end

function igSetColumnOffset(column_index, offset_x)
    ccall((:igSetColumnOffset, libcimgui), Cvoid, (Cint, Cfloat), column_index, offset_x)
end

function igGetColumnsCount()
    ccall((:igGetColumnsCount, libcimgui), Cint, ())
end

function igBeginTabBar(str_id, flags)
    ccall((:igBeginTabBar, libcimgui), Bool, (Ptr{Cchar}, ImGuiTabBarFlags), str_id, flags)
end

function igEndTabBar()
    ccall((:igEndTabBar, libcimgui), Cvoid, ())
end

function igBeginTabItem(label, p_open, flags)
    ccall((:igBeginTabItem, libcimgui), Bool, (Ptr{Cchar}, Ptr{Bool}, ImGuiTabItemFlags), label, p_open, flags)
end

function igEndTabItem()
    ccall((:igEndTabItem, libcimgui), Cvoid, ())
end

function igTabItemButton(label, flags)
    ccall((:igTabItemButton, libcimgui), Bool, (Ptr{Cchar}, ImGuiTabItemFlags), label, flags)
end

function igSetTabItemClosed(tab_or_docked_window_label)
    ccall((:igSetTabItemClosed, libcimgui), Cvoid, (Ptr{Cchar},), tab_or_docked_window_label)
end

function igDockSpace(dockspace_id, size, flags, window_class)
    ccall((:igDockSpace, libcimgui), ImGuiID, (ImGuiID, ImVec2, ImGuiDockNodeFlags, Ptr{ImGuiWindowClass}), dockspace_id, size, flags, window_class)
end

function igDockSpaceOverViewport(dockspace_id, viewport, flags, window_class)
    ccall((:igDockSpaceOverViewport, libcimgui), ImGuiID, (ImGuiID, Ptr{ImGuiViewport}, ImGuiDockNodeFlags, Ptr{ImGuiWindowClass}), dockspace_id, viewport, flags, window_class)
end

function igSetNextWindowDockID(dock_id, cond)
    ccall((:igSetNextWindowDockID, libcimgui), Cvoid, (ImGuiID, ImGuiCond), dock_id, cond)
end

function igSetNextWindowClass(window_class)
    ccall((:igSetNextWindowClass, libcimgui), Cvoid, (Ptr{ImGuiWindowClass},), window_class)
end

function igGetWindowDockID()
    ccall((:igGetWindowDockID, libcimgui), ImGuiID, ())
end

function igIsWindowDocked()
    ccall((:igIsWindowDocked, libcimgui), Bool, ())
end

function igLogToTTY(auto_open_depth)
    ccall((:igLogToTTY, libcimgui), Cvoid, (Cint,), auto_open_depth)
end

function igLogToFile(auto_open_depth, filename)
    ccall((:igLogToFile, libcimgui), Cvoid, (Cint, Ptr{Cchar}), auto_open_depth, filename)
end

function igLogToClipboard(auto_open_depth)
    ccall((:igLogToClipboard, libcimgui), Cvoid, (Cint,), auto_open_depth)
end

function igLogFinish()
    ccall((:igLogFinish, libcimgui), Cvoid, ())
end

function igLogButtons()
    ccall((:igLogButtons, libcimgui), Cvoid, ())
end

function igBeginDragDropSource(flags)
    ccall((:igBeginDragDropSource, libcimgui), Bool, (ImGuiDragDropFlags,), flags)
end

function igSetDragDropPayload(type, data, sz, cond)
    ccall((:igSetDragDropPayload, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cvoid}, Csize_t, ImGuiCond), type, data, sz, cond)
end

function igEndDragDropSource()
    ccall((:igEndDragDropSource, libcimgui), Cvoid, ())
end

function igBeginDragDropTarget()
    ccall((:igBeginDragDropTarget, libcimgui), Bool, ())
end

function igAcceptDragDropPayload(type, flags)
    ccall((:igAcceptDragDropPayload, libcimgui), Ptr{ImGuiPayload}, (Ptr{Cchar}, ImGuiDragDropFlags), type, flags)
end

function igEndDragDropTarget()
    ccall((:igEndDragDropTarget, libcimgui), Cvoid, ())
end

function igGetDragDropPayload()
    ccall((:igGetDragDropPayload, libcimgui), Ptr{ImGuiPayload}, ())
end

function igBeginDisabled(disabled)
    ccall((:igBeginDisabled, libcimgui), Cvoid, (Bool,), disabled)
end

function igEndDisabled()
    ccall((:igEndDisabled, libcimgui), Cvoid, ())
end

function igPushClipRect(clip_rect_min, clip_rect_max, intersect_with_current_clip_rect)
    ccall((:igPushClipRect, libcimgui), Cvoid, (ImVec2, ImVec2, Bool), clip_rect_min, clip_rect_max, intersect_with_current_clip_rect)
end

function igPopClipRect()
    ccall((:igPopClipRect, libcimgui), Cvoid, ())
end

function igSetItemDefaultFocus()
    ccall((:igSetItemDefaultFocus, libcimgui), Cvoid, ())
end

function igSetKeyboardFocusHere(offset)
    ccall((:igSetKeyboardFocusHere, libcimgui), Cvoid, (Cint,), offset)
end

function igSetNextItemAllowOverlap()
    ccall((:igSetNextItemAllowOverlap, libcimgui), Cvoid, ())
end

function igIsItemHovered(flags)
    ccall((:igIsItemHovered, libcimgui), Bool, (ImGuiHoveredFlags,), flags)
end

function igIsItemActive()
    ccall((:igIsItemActive, libcimgui), Bool, ())
end

function igIsItemFocused()
    ccall((:igIsItemFocused, libcimgui), Bool, ())
end

function igIsItemClicked(mouse_button)
    ccall((:igIsItemClicked, libcimgui), Bool, (ImGuiMouseButton,), mouse_button)
end

function igIsItemVisible()
    ccall((:igIsItemVisible, libcimgui), Bool, ())
end

function igIsItemEdited()
    ccall((:igIsItemEdited, libcimgui), Bool, ())
end

function igIsItemActivated()
    ccall((:igIsItemActivated, libcimgui), Bool, ())
end

function igIsItemDeactivated()
    ccall((:igIsItemDeactivated, libcimgui), Bool, ())
end

function igIsItemDeactivatedAfterEdit()
    ccall((:igIsItemDeactivatedAfterEdit, libcimgui), Bool, ())
end

function igIsItemToggledOpen()
    ccall((:igIsItemToggledOpen, libcimgui), Bool, ())
end

function igIsAnyItemHovered()
    ccall((:igIsAnyItemHovered, libcimgui), Bool, ())
end

function igIsAnyItemActive()
    ccall((:igIsAnyItemActive, libcimgui), Bool, ())
end

function igIsAnyItemFocused()
    ccall((:igIsAnyItemFocused, libcimgui), Bool, ())
end

function igGetItemID()
    ccall((:igGetItemID, libcimgui), ImGuiID, ())
end

function igGetItemRectMin(pOut)
    ccall((:igGetItemRectMin, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetItemRectMax(pOut)
    ccall((:igGetItemRectMax, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetItemRectSize(pOut)
    ccall((:igGetItemRectSize, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetMainViewport()
    ccall((:igGetMainViewport, libcimgui), Ptr{ImGuiViewport}, ())
end

function igGetBackgroundDrawList(viewport)
    ccall((:igGetBackgroundDrawList, libcimgui), Ptr{ImDrawList}, (Ptr{ImGuiViewport},), viewport)
end

function igGetForegroundDrawList_ViewportPtr(viewport)
    ccall((:igGetForegroundDrawList_ViewportPtr, libcimgui), Ptr{ImDrawList}, (Ptr{ImGuiViewport},), viewport)
end

function igIsRectVisible_Nil(size)
    ccall((:igIsRectVisible_Nil, libcimgui), Bool, (ImVec2,), size)
end

function igIsRectVisible_Vec2(rect_min, rect_max)
    ccall((:igIsRectVisible_Vec2, libcimgui), Bool, (ImVec2, ImVec2), rect_min, rect_max)
end

function igGetTime()
    ccall((:igGetTime, libcimgui), Cdouble, ())
end

function igGetFrameCount()
    ccall((:igGetFrameCount, libcimgui), Cint, ())
end

function igGetDrawListSharedData()
    ccall((:igGetDrawListSharedData, libcimgui), Ptr{ImDrawListSharedData}, ())
end

function igGetStyleColorName(idx)
    ccall((:igGetStyleColorName, libcimgui), Ptr{Cchar}, (ImGuiCol,), idx)
end

function igSetStateStorage(storage)
    ccall((:igSetStateStorage, libcimgui), Cvoid, (Ptr{ImGuiStorage},), storage)
end

function igGetStateStorage()
    ccall((:igGetStateStorage, libcimgui), Ptr{ImGuiStorage}, ())
end

function igCalcTextSize(pOut, text, text_end, hide_text_after_double_hash, wrap_width)
    ccall((:igCalcTextSize, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{Cchar}, Ptr{Cchar}, Bool, Cfloat), pOut, text, text_end, hide_text_after_double_hash, wrap_width)
end

function igColorConvertU32ToFloat4(pOut, in)
    ccall((:igColorConvertU32ToFloat4, libcimgui), Cvoid, (Ptr{ImVec4}, ImU32), pOut, in)
end

function igColorConvertFloat4ToU32(in)
    ccall((:igColorConvertFloat4ToU32, libcimgui), ImU32, (ImVec4,), in)
end

function igColorConvertRGBtoHSV(r, g, b, out_h, out_s, out_v)
    ccall((:igColorConvertRGBtoHSV, libcimgui), Cvoid, (Cfloat, Cfloat, Cfloat, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}), r, g, b, out_h, out_s, out_v)
end

function igColorConvertHSVtoRGB(h, s, v, out_r, out_g, out_b)
    ccall((:igColorConvertHSVtoRGB, libcimgui), Cvoid, (Cfloat, Cfloat, Cfloat, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}), h, s, v, out_r, out_g, out_b)
end

function igIsKeyDown_Nil(key)
    ccall((:igIsKeyDown_Nil, libcimgui), Bool, (ImGuiKey,), key)
end

function igIsKeyPressed_Bool(key, repeat)
    ccall((:igIsKeyPressed_Bool, libcimgui), Bool, (ImGuiKey, Bool), key, repeat)
end

function igIsKeyReleased_Nil(key)
    ccall((:igIsKeyReleased_Nil, libcimgui), Bool, (ImGuiKey,), key)
end

function igIsKeyChordPressed_Nil(key_chord)
    ccall((:igIsKeyChordPressed_Nil, libcimgui), Bool, (ImGuiKeyChord,), key_chord)
end

function igGetKeyPressedAmount(key, repeat_delay, rate)
    ccall((:igGetKeyPressedAmount, libcimgui), Cint, (ImGuiKey, Cfloat, Cfloat), key, repeat_delay, rate)
end

function igGetKeyName(key)
    ccall((:igGetKeyName, libcimgui), Ptr{Cchar}, (ImGuiKey,), key)
end

function igSetNextFrameWantCaptureKeyboard(want_capture_keyboard)
    ccall((:igSetNextFrameWantCaptureKeyboard, libcimgui), Cvoid, (Bool,), want_capture_keyboard)
end

function igShortcut_Nil(key_chord, flags)
    ccall((:igShortcut_Nil, libcimgui), Bool, (ImGuiKeyChord, ImGuiInputFlags), key_chord, flags)
end

function igSetNextItemShortcut(key_chord, flags)
    ccall((:igSetNextItemShortcut, libcimgui), Cvoid, (ImGuiKeyChord, ImGuiInputFlags), key_chord, flags)
end

function igSetItemKeyOwner_Nil(key)
    ccall((:igSetItemKeyOwner_Nil, libcimgui), Cvoid, (ImGuiKey,), key)
end

function igIsMouseDown_Nil(button)
    ccall((:igIsMouseDown_Nil, libcimgui), Bool, (ImGuiMouseButton,), button)
end

function igIsMouseClicked_Bool(button, repeat)
    ccall((:igIsMouseClicked_Bool, libcimgui), Bool, (ImGuiMouseButton, Bool), button, repeat)
end

function igIsMouseReleased_Nil(button)
    ccall((:igIsMouseReleased_Nil, libcimgui), Bool, (ImGuiMouseButton,), button)
end

function igIsMouseDoubleClicked_Nil(button)
    ccall((:igIsMouseDoubleClicked_Nil, libcimgui), Bool, (ImGuiMouseButton,), button)
end

function igGetMouseClickedCount(button)
    ccall((:igGetMouseClickedCount, libcimgui), Cint, (ImGuiMouseButton,), button)
end

function igIsMouseHoveringRect(r_min, r_max, clip)
    ccall((:igIsMouseHoveringRect, libcimgui), Bool, (ImVec2, ImVec2, Bool), r_min, r_max, clip)
end

function igIsMousePosValid(mouse_pos)
    ccall((:igIsMousePosValid, libcimgui), Bool, (Ptr{ImVec2},), mouse_pos)
end

function igIsAnyMouseDown()
    ccall((:igIsAnyMouseDown, libcimgui), Bool, ())
end

function igGetMousePos(pOut)
    ccall((:igGetMousePos, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetMousePosOnOpeningCurrentPopup(pOut)
    ccall((:igGetMousePosOnOpeningCurrentPopup, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igIsMouseDragging(button, lock_threshold)
    ccall((:igIsMouseDragging, libcimgui), Bool, (ImGuiMouseButton, Cfloat), button, lock_threshold)
end

function igGetMouseDragDelta(pOut, button, lock_threshold)
    ccall((:igGetMouseDragDelta, libcimgui), Cvoid, (Ptr{ImVec2}, ImGuiMouseButton, Cfloat), pOut, button, lock_threshold)
end

function igResetMouseDragDelta(button)
    ccall((:igResetMouseDragDelta, libcimgui), Cvoid, (ImGuiMouseButton,), button)
end

function igGetMouseCursor()
    ccall((:igGetMouseCursor, libcimgui), ImGuiMouseCursor, ())
end

function igSetMouseCursor(cursor_type)
    ccall((:igSetMouseCursor, libcimgui), Cvoid, (ImGuiMouseCursor,), cursor_type)
end

function igSetNextFrameWantCaptureMouse(want_capture_mouse)
    ccall((:igSetNextFrameWantCaptureMouse, libcimgui), Cvoid, (Bool,), want_capture_mouse)
end

function igGetClipboardText()
    ccall((:igGetClipboardText, libcimgui), Ptr{Cchar}, ())
end

function igSetClipboardText(text)
    ccall((:igSetClipboardText, libcimgui), Cvoid, (Ptr{Cchar},), text)
end

function igLoadIniSettingsFromDisk(ini_filename)
    ccall((:igLoadIniSettingsFromDisk, libcimgui), Cvoid, (Ptr{Cchar},), ini_filename)
end

function igLoadIniSettingsFromMemory(ini_data, ini_size)
    ccall((:igLoadIniSettingsFromMemory, libcimgui), Cvoid, (Ptr{Cchar}, Csize_t), ini_data, ini_size)
end

function igSaveIniSettingsToDisk(ini_filename)
    ccall((:igSaveIniSettingsToDisk, libcimgui), Cvoid, (Ptr{Cchar},), ini_filename)
end

function igSaveIniSettingsToMemory(out_ini_size)
    ccall((:igSaveIniSettingsToMemory, libcimgui), Ptr{Cchar}, (Ptr{Csize_t},), out_ini_size)
end

function igDebugTextEncoding(text)
    ccall((:igDebugTextEncoding, libcimgui), Cvoid, (Ptr{Cchar},), text)
end

function igDebugFlashStyleColor(idx)
    ccall((:igDebugFlashStyleColor, libcimgui), Cvoid, (ImGuiCol,), idx)
end

function igDebugStartItemPicker()
    ccall((:igDebugStartItemPicker, libcimgui), Cvoid, ())
end

function igDebugCheckVersionAndDataLayout(version_str, sz_io, sz_style, sz_vec2, sz_vec4, sz_drawvert, sz_drawidx)
    ccall((:igDebugCheckVersionAndDataLayout, libcimgui), Bool, (Ptr{Cchar}, Csize_t, Csize_t, Csize_t, Csize_t, Csize_t, Csize_t), version_str, sz_io, sz_style, sz_vec2, sz_vec4, sz_drawvert, sz_drawidx)
end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function igDebugLog(fmt, va_list...)
        :(@ccall(libcimgui.igDebugLog(fmt::Ptr{Cchar}; $(to_c_type_pairs(va_list)...))::Cvoid))
    end

function igSetAllocatorFunctions(alloc_func, free_func, user_data)
    ccall((:igSetAllocatorFunctions, libcimgui), Cvoid, (ImGuiMemAllocFunc, ImGuiMemFreeFunc, Ptr{Cvoid}), alloc_func, free_func, user_data)
end

function igGetAllocatorFunctions(p_alloc_func, p_free_func, p_user_data)
    ccall((:igGetAllocatorFunctions, libcimgui), Cvoid, (Ptr{ImGuiMemAllocFunc}, Ptr{ImGuiMemFreeFunc}, Ptr{Ptr{Cvoid}}), p_alloc_func, p_free_func, p_user_data)
end

function igMemAlloc(size)
    ccall((:igMemAlloc, libcimgui), Ptr{Cvoid}, (Csize_t,), size)
end

function igMemFree(ptr)
    ccall((:igMemFree, libcimgui), Cvoid, (Ptr{Cvoid},), ptr)
end

function igGetPlatformIO()
    ccall((:igGetPlatformIO, libcimgui), Ptr{ImGuiPlatformIO}, ())
end

function igUpdatePlatformWindows()
    ccall((:igUpdatePlatformWindows, libcimgui), Cvoid, ())
end

function igRenderPlatformWindowsDefault(platform_render_arg, renderer_render_arg)
    ccall((:igRenderPlatformWindowsDefault, libcimgui), Cvoid, (Ptr{Cvoid}, Ptr{Cvoid}), platform_render_arg, renderer_render_arg)
end

function igDestroyPlatformWindows()
    ccall((:igDestroyPlatformWindows, libcimgui), Cvoid, ())
end

function igFindViewportByID(id)
    ccall((:igFindViewportByID, libcimgui), Ptr{ImGuiViewport}, (ImGuiID,), id)
end

function igFindViewportByPlatformHandle(platform_handle)
    ccall((:igFindViewportByPlatformHandle, libcimgui), Ptr{ImGuiViewport}, (Ptr{Cvoid},), platform_handle)
end

function ImGuiTableSortSpecs_ImGuiTableSortSpecs()
    ccall((:ImGuiTableSortSpecs_ImGuiTableSortSpecs, libcimgui), Ptr{ImGuiTableSortSpecs}, ())
end

function ImGuiTableSortSpecs_destroy(self)
    ccall((:ImGuiTableSortSpecs_destroy, libcimgui), Cvoid, (Ptr{ImGuiTableSortSpecs},), self)
end

function ImGuiTableColumnSortSpecs_ImGuiTableColumnSortSpecs()
    ccall((:ImGuiTableColumnSortSpecs_ImGuiTableColumnSortSpecs, libcimgui), Ptr{ImGuiTableColumnSortSpecs}, ())
end

function ImGuiTableColumnSortSpecs_destroy(self)
    ccall((:ImGuiTableColumnSortSpecs_destroy, libcimgui), Cvoid, (Ptr{ImGuiTableColumnSortSpecs},), self)
end

function ImGuiStyle_ImGuiStyle()
    ccall((:ImGuiStyle_ImGuiStyle, libcimgui), Ptr{ImGuiStyle}, ())
end

function ImGuiStyle_destroy(self)
    ccall((:ImGuiStyle_destroy, libcimgui), Cvoid, (Ptr{ImGuiStyle},), self)
end

function ImGuiStyle_ScaleAllSizes(self, scale_factor)
    ccall((:ImGuiStyle_ScaleAllSizes, libcimgui), Cvoid, (Ptr{ImGuiStyle}, Cfloat), self, scale_factor)
end

function ImGuiIO_AddKeyEvent(self, key, down)
    ccall((:ImGuiIO_AddKeyEvent, libcimgui), Cvoid, (Ptr{ImGuiIO}, ImGuiKey, Bool), self, key, down)
end

function ImGuiIO_AddKeyAnalogEvent(self, key, down, v)
    ccall((:ImGuiIO_AddKeyAnalogEvent, libcimgui), Cvoid, (Ptr{ImGuiIO}, ImGuiKey, Bool, Cfloat), self, key, down, v)
end

function ImGuiIO_AddMousePosEvent(self, x, y)
    ccall((:ImGuiIO_AddMousePosEvent, libcimgui), Cvoid, (Ptr{ImGuiIO}, Cfloat, Cfloat), self, x, y)
end

function ImGuiIO_AddMouseButtonEvent(self, button, down)
    ccall((:ImGuiIO_AddMouseButtonEvent, libcimgui), Cvoid, (Ptr{ImGuiIO}, Cint, Bool), self, button, down)
end

function ImGuiIO_AddMouseWheelEvent(self, wheel_x, wheel_y)
    ccall((:ImGuiIO_AddMouseWheelEvent, libcimgui), Cvoid, (Ptr{ImGuiIO}, Cfloat, Cfloat), self, wheel_x, wheel_y)
end

function ImGuiIO_AddMouseSourceEvent(self, source)
    ccall((:ImGuiIO_AddMouseSourceEvent, libcimgui), Cvoid, (Ptr{ImGuiIO}, ImGuiMouseSource), self, source)
end

function ImGuiIO_AddMouseViewportEvent(self, id)
    ccall((:ImGuiIO_AddMouseViewportEvent, libcimgui), Cvoid, (Ptr{ImGuiIO}, ImGuiID), self, id)
end

function ImGuiIO_AddFocusEvent(self, focused)
    ccall((:ImGuiIO_AddFocusEvent, libcimgui), Cvoid, (Ptr{ImGuiIO}, Bool), self, focused)
end

function ImGuiIO_AddInputCharacter(self, c)
    ccall((:ImGuiIO_AddInputCharacter, libcimgui), Cvoid, (Ptr{ImGuiIO}, Cuint), self, c)
end

function ImGuiIO_AddInputCharacterUTF16(self, c)
    ccall((:ImGuiIO_AddInputCharacterUTF16, libcimgui), Cvoid, (Ptr{ImGuiIO}, ImWchar16), self, c)
end

function ImGuiIO_AddInputCharactersUTF8(self, str)
    ccall((:ImGuiIO_AddInputCharactersUTF8, libcimgui), Cvoid, (Ptr{ImGuiIO}, Ptr{Cchar}), self, str)
end

function ImGuiIO_SetKeyEventNativeData(self, key, native_keycode, native_scancode, native_legacy_index)
    ccall((:ImGuiIO_SetKeyEventNativeData, libcimgui), Cvoid, (Ptr{ImGuiIO}, ImGuiKey, Cint, Cint, Cint), self, key, native_keycode, native_scancode, native_legacy_index)
end

function ImGuiIO_SetAppAcceptingEvents(self, accepting_events)
    ccall((:ImGuiIO_SetAppAcceptingEvents, libcimgui), Cvoid, (Ptr{ImGuiIO}, Bool), self, accepting_events)
end

function ImGuiIO_ClearEventsQueue(self)
    ccall((:ImGuiIO_ClearEventsQueue, libcimgui), Cvoid, (Ptr{ImGuiIO},), self)
end

function ImGuiIO_ClearInputKeys(self)
    ccall((:ImGuiIO_ClearInputKeys, libcimgui), Cvoid, (Ptr{ImGuiIO},), self)
end

function ImGuiIO_ClearInputMouse(self)
    ccall((:ImGuiIO_ClearInputMouse, libcimgui), Cvoid, (Ptr{ImGuiIO},), self)
end

function ImGuiIO_ImGuiIO()
    ccall((:ImGuiIO_ImGuiIO, libcimgui), Ptr{ImGuiIO}, ())
end

function ImGuiIO_destroy(self)
    ccall((:ImGuiIO_destroy, libcimgui), Cvoid, (Ptr{ImGuiIO},), self)
end

function ImGuiInputTextCallbackData_ImGuiInputTextCallbackData()
    ccall((:ImGuiInputTextCallbackData_ImGuiInputTextCallbackData, libcimgui), Ptr{ImGuiInputTextCallbackData}, ())
end

function ImGuiInputTextCallbackData_destroy(self)
    ccall((:ImGuiInputTextCallbackData_destroy, libcimgui), Cvoid, (Ptr{ImGuiInputTextCallbackData},), self)
end

function ImGuiInputTextCallbackData_DeleteChars(self, pos, bytes_count)
    ccall((:ImGuiInputTextCallbackData_DeleteChars, libcimgui), Cvoid, (Ptr{ImGuiInputTextCallbackData}, Cint, Cint), self, pos, bytes_count)
end

function ImGuiInputTextCallbackData_InsertChars(self, pos, text, text_end)
    ccall((:ImGuiInputTextCallbackData_InsertChars, libcimgui), Cvoid, (Ptr{ImGuiInputTextCallbackData}, Cint, Ptr{Cchar}, Ptr{Cchar}), self, pos, text, text_end)
end

function ImGuiInputTextCallbackData_SelectAll(self)
    ccall((:ImGuiInputTextCallbackData_SelectAll, libcimgui), Cvoid, (Ptr{ImGuiInputTextCallbackData},), self)
end

function ImGuiInputTextCallbackData_ClearSelection(self)
    ccall((:ImGuiInputTextCallbackData_ClearSelection, libcimgui), Cvoid, (Ptr{ImGuiInputTextCallbackData},), self)
end

function ImGuiInputTextCallbackData_HasSelection(self)
    ccall((:ImGuiInputTextCallbackData_HasSelection, libcimgui), Bool, (Ptr{ImGuiInputTextCallbackData},), self)
end

function ImGuiWindowClass_ImGuiWindowClass()
    ccall((:ImGuiWindowClass_ImGuiWindowClass, libcimgui), Ptr{ImGuiWindowClass}, ())
end

function ImGuiWindowClass_destroy(self)
    ccall((:ImGuiWindowClass_destroy, libcimgui), Cvoid, (Ptr{ImGuiWindowClass},), self)
end

function ImGuiPayload_ImGuiPayload()
    ccall((:ImGuiPayload_ImGuiPayload, libcimgui), Ptr{ImGuiPayload}, ())
end

function ImGuiPayload_destroy(self)
    ccall((:ImGuiPayload_destroy, libcimgui), Cvoid, (Ptr{ImGuiPayload},), self)
end

function ImGuiPayload_Clear(self)
    ccall((:ImGuiPayload_Clear, libcimgui), Cvoid, (Ptr{ImGuiPayload},), self)
end

function ImGuiPayload_IsDataType(self, type)
    ccall((:ImGuiPayload_IsDataType, libcimgui), Bool, (Ptr{ImGuiPayload}, Ptr{Cchar}), self, type)
end

function ImGuiPayload_IsPreview(self)
    ccall((:ImGuiPayload_IsPreview, libcimgui), Bool, (Ptr{ImGuiPayload},), self)
end

function ImGuiPayload_IsDelivery(self)
    ccall((:ImGuiPayload_IsDelivery, libcimgui), Bool, (Ptr{ImGuiPayload},), self)
end

function ImGuiOnceUponAFrame_ImGuiOnceUponAFrame()
    ccall((:ImGuiOnceUponAFrame_ImGuiOnceUponAFrame, libcimgui), Ptr{ImGuiOnceUponAFrame}, ())
end

function ImGuiOnceUponAFrame_destroy(self)
    ccall((:ImGuiOnceUponAFrame_destroy, libcimgui), Cvoid, (Ptr{ImGuiOnceUponAFrame},), self)
end

function ImGuiTextFilter_ImGuiTextFilter(default_filter)
    ccall((:ImGuiTextFilter_ImGuiTextFilter, libcimgui), Ptr{ImGuiTextFilter}, (Ptr{Cchar},), default_filter)
end

function ImGuiTextFilter_destroy(self)
    ccall((:ImGuiTextFilter_destroy, libcimgui), Cvoid, (Ptr{ImGuiTextFilter},), self)
end

function ImGuiTextFilter_Draw(self, label, width)
    ccall((:ImGuiTextFilter_Draw, libcimgui), Bool, (Ptr{ImGuiTextFilter}, Ptr{Cchar}, Cfloat), self, label, width)
end

function ImGuiTextFilter_PassFilter(self, text, text_end)
    ccall((:ImGuiTextFilter_PassFilter, libcimgui), Bool, (Ptr{ImGuiTextFilter}, Ptr{Cchar}, Ptr{Cchar}), self, text, text_end)
end

function ImGuiTextFilter_Build(self)
    ccall((:ImGuiTextFilter_Build, libcimgui), Cvoid, (Ptr{ImGuiTextFilter},), self)
end

function ImGuiTextFilter_Clear(self)
    ccall((:ImGuiTextFilter_Clear, libcimgui), Cvoid, (Ptr{ImGuiTextFilter},), self)
end

function ImGuiTextFilter_IsActive(self)
    ccall((:ImGuiTextFilter_IsActive, libcimgui), Bool, (Ptr{ImGuiTextFilter},), self)
end

function ImGuiTextRange_ImGuiTextRange_Nil()
    ccall((:ImGuiTextRange_ImGuiTextRange_Nil, libcimgui), Ptr{ImGuiTextRange}, ())
end

function ImGuiTextRange_destroy(self)
    ccall((:ImGuiTextRange_destroy, libcimgui), Cvoid, (Ptr{ImGuiTextRange},), self)
end

function ImGuiTextRange_ImGuiTextRange_Str(_b, _e)
    ccall((:ImGuiTextRange_ImGuiTextRange_Str, libcimgui), Ptr{ImGuiTextRange}, (Ptr{Cchar}, Ptr{Cchar}), _b, _e)
end

function ImGuiTextRange_empty(self)
    ccall((:ImGuiTextRange_empty, libcimgui), Bool, (Ptr{ImGuiTextRange},), self)
end

function ImGuiTextRange_split(self, separator, out)
    ccall((:ImGuiTextRange_split, libcimgui), Cvoid, (Ptr{ImGuiTextRange}, Cchar, Ptr{ImVector_ImGuiTextRange}), self, separator, out)
end

function ImGuiTextBuffer_ImGuiTextBuffer()
    ccall((:ImGuiTextBuffer_ImGuiTextBuffer, libcimgui), Ptr{ImGuiTextBuffer}, ())
end

function ImGuiTextBuffer_destroy(self)
    ccall((:ImGuiTextBuffer_destroy, libcimgui), Cvoid, (Ptr{ImGuiTextBuffer},), self)
end

function ImGuiTextBuffer_begin(self)
    ccall((:ImGuiTextBuffer_begin, libcimgui), Ptr{Cchar}, (Ptr{ImGuiTextBuffer},), self)
end

function ImGuiTextBuffer_end(self)
    ccall((:ImGuiTextBuffer_end, libcimgui), Ptr{Cchar}, (Ptr{ImGuiTextBuffer},), self)
end

function ImGuiTextBuffer_size(self)
    ccall((:ImGuiTextBuffer_size, libcimgui), Cint, (Ptr{ImGuiTextBuffer},), self)
end

function ImGuiTextBuffer_empty(self)
    ccall((:ImGuiTextBuffer_empty, libcimgui), Bool, (Ptr{ImGuiTextBuffer},), self)
end

function ImGuiTextBuffer_clear(self)
    ccall((:ImGuiTextBuffer_clear, libcimgui), Cvoid, (Ptr{ImGuiTextBuffer},), self)
end

function ImGuiTextBuffer_reserve(self, capacity)
    ccall((:ImGuiTextBuffer_reserve, libcimgui), Cvoid, (Ptr{ImGuiTextBuffer}, Cint), self, capacity)
end

function ImGuiTextBuffer_c_str(self)
    ccall((:ImGuiTextBuffer_c_str, libcimgui), Ptr{Cchar}, (Ptr{ImGuiTextBuffer},), self)
end

function ImGuiTextBuffer_append(self, str, str_end)
    ccall((:ImGuiTextBuffer_append, libcimgui), Cvoid, (Ptr{ImGuiTextBuffer}, Ptr{Cchar}, Ptr{Cchar}), self, str, str_end)
end

function ImGuiStoragePair_ImGuiStoragePair_Int(_key, _val)
    ccall((:ImGuiStoragePair_ImGuiStoragePair_Int, libcimgui), Ptr{ImGuiStoragePair}, (ImGuiID, Cint), _key, _val)
end

function ImGuiStoragePair_destroy(self)
    ccall((:ImGuiStoragePair_destroy, libcimgui), Cvoid, (Ptr{ImGuiStoragePair},), self)
end

function ImGuiStoragePair_ImGuiStoragePair_Float(_key, _val)
    ccall((:ImGuiStoragePair_ImGuiStoragePair_Float, libcimgui), Ptr{ImGuiStoragePair}, (ImGuiID, Cfloat), _key, _val)
end

function ImGuiStoragePair_ImGuiStoragePair_Ptr(_key, _val)
    ccall((:ImGuiStoragePair_ImGuiStoragePair_Ptr, libcimgui), Ptr{ImGuiStoragePair}, (ImGuiID, Ptr{Cvoid}), _key, _val)
end

function ImGuiStorage_Clear(self)
    ccall((:ImGuiStorage_Clear, libcimgui), Cvoid, (Ptr{ImGuiStorage},), self)
end

function ImGuiStorage_GetInt(self, key, default_val)
    ccall((:ImGuiStorage_GetInt, libcimgui), Cint, (Ptr{ImGuiStorage}, ImGuiID, Cint), self, key, default_val)
end

function ImGuiStorage_SetInt(self, key, val)
    ccall((:ImGuiStorage_SetInt, libcimgui), Cvoid, (Ptr{ImGuiStorage}, ImGuiID, Cint), self, key, val)
end

function ImGuiStorage_GetBool(self, key, default_val)
    ccall((:ImGuiStorage_GetBool, libcimgui), Bool, (Ptr{ImGuiStorage}, ImGuiID, Bool), self, key, default_val)
end

function ImGuiStorage_SetBool(self, key, val)
    ccall((:ImGuiStorage_SetBool, libcimgui), Cvoid, (Ptr{ImGuiStorage}, ImGuiID, Bool), self, key, val)
end

function ImGuiStorage_GetFloat(self, key, default_val)
    ccall((:ImGuiStorage_GetFloat, libcimgui), Cfloat, (Ptr{ImGuiStorage}, ImGuiID, Cfloat), self, key, default_val)
end

function ImGuiStorage_SetFloat(self, key, val)
    ccall((:ImGuiStorage_SetFloat, libcimgui), Cvoid, (Ptr{ImGuiStorage}, ImGuiID, Cfloat), self, key, val)
end

function ImGuiStorage_GetVoidPtr(self, key)
    ccall((:ImGuiStorage_GetVoidPtr, libcimgui), Ptr{Cvoid}, (Ptr{ImGuiStorage}, ImGuiID), self, key)
end

function ImGuiStorage_SetVoidPtr(self, key, val)
    ccall((:ImGuiStorage_SetVoidPtr, libcimgui), Cvoid, (Ptr{ImGuiStorage}, ImGuiID, Ptr{Cvoid}), self, key, val)
end

function ImGuiStorage_GetIntRef(self, key, default_val)
    ccall((:ImGuiStorage_GetIntRef, libcimgui), Ptr{Cint}, (Ptr{ImGuiStorage}, ImGuiID, Cint), self, key, default_val)
end

function ImGuiStorage_GetBoolRef(self, key, default_val)
    ccall((:ImGuiStorage_GetBoolRef, libcimgui), Ptr{Bool}, (Ptr{ImGuiStorage}, ImGuiID, Bool), self, key, default_val)
end

function ImGuiStorage_GetFloatRef(self, key, default_val)
    ccall((:ImGuiStorage_GetFloatRef, libcimgui), Ptr{Cfloat}, (Ptr{ImGuiStorage}, ImGuiID, Cfloat), self, key, default_val)
end

function ImGuiStorage_GetVoidPtrRef(self, key, default_val)
    ccall((:ImGuiStorage_GetVoidPtrRef, libcimgui), Ptr{Ptr{Cvoid}}, (Ptr{ImGuiStorage}, ImGuiID, Ptr{Cvoid}), self, key, default_val)
end

function ImGuiStorage_BuildSortByKey(self)
    ccall((:ImGuiStorage_BuildSortByKey, libcimgui), Cvoid, (Ptr{ImGuiStorage},), self)
end

function ImGuiStorage_SetAllInt(self, val)
    ccall((:ImGuiStorage_SetAllInt, libcimgui), Cvoid, (Ptr{ImGuiStorage}, Cint), self, val)
end

function ImGuiListClipper_ImGuiListClipper()
    ccall((:ImGuiListClipper_ImGuiListClipper, libcimgui), Ptr{ImGuiListClipper}, ())
end

function ImGuiListClipper_destroy(self)
    ccall((:ImGuiListClipper_destroy, libcimgui), Cvoid, (Ptr{ImGuiListClipper},), self)
end

function ImGuiListClipper_Begin(self, items_count, items_height)
    ccall((:ImGuiListClipper_Begin, libcimgui), Cvoid, (Ptr{ImGuiListClipper}, Cint, Cfloat), self, items_count, items_height)
end

function ImGuiListClipper_End(self)
    ccall((:ImGuiListClipper_End, libcimgui), Cvoid, (Ptr{ImGuiListClipper},), self)
end

function ImGuiListClipper_Step(self)
    ccall((:ImGuiListClipper_Step, libcimgui), Bool, (Ptr{ImGuiListClipper},), self)
end

function ImGuiListClipper_IncludeItemByIndex(self, item_index)
    ccall((:ImGuiListClipper_IncludeItemByIndex, libcimgui), Cvoid, (Ptr{ImGuiListClipper}, Cint), self, item_index)
end

function ImGuiListClipper_IncludeItemsByIndex(self, item_begin, item_end)
    ccall((:ImGuiListClipper_IncludeItemsByIndex, libcimgui), Cvoid, (Ptr{ImGuiListClipper}, Cint, Cint), self, item_begin, item_end)
end

function ImGuiListClipper_SeekCursorForItem(self, item_index)
    ccall((:ImGuiListClipper_SeekCursorForItem, libcimgui), Cvoid, (Ptr{ImGuiListClipper}, Cint), self, item_index)
end

function ImColor_ImColor_Nil()
    ccall((:ImColor_ImColor_Nil, libcimgui), Ptr{ImColor}, ())
end

function ImColor_destroy(self)
    ccall((:ImColor_destroy, libcimgui), Cvoid, (Ptr{ImColor},), self)
end

function ImColor_ImColor_Float(r, g, b, a)
    ccall((:ImColor_ImColor_Float, libcimgui), Ptr{ImColor}, (Cfloat, Cfloat, Cfloat, Cfloat), r, g, b, a)
end

function ImColor_ImColor_Vec4(col)
    ccall((:ImColor_ImColor_Vec4, libcimgui), Ptr{ImColor}, (ImVec4,), col)
end

function ImColor_ImColor_Int(r, g, b, a)
    ccall((:ImColor_ImColor_Int, libcimgui), Ptr{ImColor}, (Cint, Cint, Cint, Cint), r, g, b, a)
end

function ImColor_ImColor_U32(rgba)
    ccall((:ImColor_ImColor_U32, libcimgui), Ptr{ImColor}, (ImU32,), rgba)
end

function ImColor_SetHSV(self, h, s, v, a)
    ccall((:ImColor_SetHSV, libcimgui), Cvoid, (Ptr{ImColor}, Cfloat, Cfloat, Cfloat, Cfloat), self, h, s, v, a)
end

function ImColor_HSV(pOut, h, s, v, a)
    ccall((:ImColor_HSV, libcimgui), Cvoid, (Ptr{ImColor}, Cfloat, Cfloat, Cfloat, Cfloat), pOut, h, s, v, a)
end

function ImGuiSelectionBasicStorage_ImGuiSelectionBasicStorage()
    ccall((:ImGuiSelectionBasicStorage_ImGuiSelectionBasicStorage, libcimgui), Ptr{ImGuiSelectionBasicStorage}, ())
end

function ImGuiSelectionBasicStorage_destroy(self)
    ccall((:ImGuiSelectionBasicStorage_destroy, libcimgui), Cvoid, (Ptr{ImGuiSelectionBasicStorage},), self)
end

function ImGuiSelectionBasicStorage_ApplyRequests(self, ms_io)
    ccall((:ImGuiSelectionBasicStorage_ApplyRequests, libcimgui), Cvoid, (Ptr{ImGuiSelectionBasicStorage}, Ptr{ImGuiMultiSelectIO}), self, ms_io)
end

function ImGuiSelectionBasicStorage_Contains(self, id)
    ccall((:ImGuiSelectionBasicStorage_Contains, libcimgui), Bool, (Ptr{ImGuiSelectionBasicStorage}, ImGuiID), self, id)
end

function ImGuiSelectionBasicStorage_Clear(self)
    ccall((:ImGuiSelectionBasicStorage_Clear, libcimgui), Cvoid, (Ptr{ImGuiSelectionBasicStorage},), self)
end

function ImGuiSelectionBasicStorage_Swap(self, r)
    ccall((:ImGuiSelectionBasicStorage_Swap, libcimgui), Cvoid, (Ptr{ImGuiSelectionBasicStorage}, Ptr{ImGuiSelectionBasicStorage}), self, r)
end

function ImGuiSelectionBasicStorage_SetItemSelected(self, id, selected)
    ccall((:ImGuiSelectionBasicStorage_SetItemSelected, libcimgui), Cvoid, (Ptr{ImGuiSelectionBasicStorage}, ImGuiID, Bool), self, id, selected)
end

function ImGuiSelectionBasicStorage_GetNextSelectedItem(self, opaque_it, out_id)
    ccall((:ImGuiSelectionBasicStorage_GetNextSelectedItem, libcimgui), Bool, (Ptr{ImGuiSelectionBasicStorage}, Ptr{Ptr{Cvoid}}, Ptr{ImGuiID}), self, opaque_it, out_id)
end

function ImGuiSelectionBasicStorage_GetStorageIdFromIndex(self, idx)
    ccall((:ImGuiSelectionBasicStorage_GetStorageIdFromIndex, libcimgui), ImGuiID, (Ptr{ImGuiSelectionBasicStorage}, Cint), self, idx)
end

function ImGuiSelectionExternalStorage_ImGuiSelectionExternalStorage()
    ccall((:ImGuiSelectionExternalStorage_ImGuiSelectionExternalStorage, libcimgui), Ptr{ImGuiSelectionExternalStorage}, ())
end

function ImGuiSelectionExternalStorage_destroy(self)
    ccall((:ImGuiSelectionExternalStorage_destroy, libcimgui), Cvoid, (Ptr{ImGuiSelectionExternalStorage},), self)
end

function ImGuiSelectionExternalStorage_ApplyRequests(self, ms_io)
    ccall((:ImGuiSelectionExternalStorage_ApplyRequests, libcimgui), Cvoid, (Ptr{ImGuiSelectionExternalStorage}, Ptr{ImGuiMultiSelectIO}), self, ms_io)
end

function ImDrawCmd_ImDrawCmd()
    ccall((:ImDrawCmd_ImDrawCmd, libcimgui), Ptr{ImDrawCmd}, ())
end

function ImDrawCmd_destroy(self)
    ccall((:ImDrawCmd_destroy, libcimgui), Cvoid, (Ptr{ImDrawCmd},), self)
end

function ImDrawCmd_GetTexID(self)
    ccall((:ImDrawCmd_GetTexID, libcimgui), ImTextureID, (Ptr{ImDrawCmd},), self)
end

function ImDrawListSplitter_ImDrawListSplitter()
    ccall((:ImDrawListSplitter_ImDrawListSplitter, libcimgui), Ptr{ImDrawListSplitter}, ())
end

function ImDrawListSplitter_destroy(self)
    ccall((:ImDrawListSplitter_destroy, libcimgui), Cvoid, (Ptr{ImDrawListSplitter},), self)
end

function ImDrawListSplitter_Clear(self)
    ccall((:ImDrawListSplitter_Clear, libcimgui), Cvoid, (Ptr{ImDrawListSplitter},), self)
end

function ImDrawListSplitter_ClearFreeMemory(self)
    ccall((:ImDrawListSplitter_ClearFreeMemory, libcimgui), Cvoid, (Ptr{ImDrawListSplitter},), self)
end

function ImDrawListSplitter_Split(self, draw_list, count)
    ccall((:ImDrawListSplitter_Split, libcimgui), Cvoid, (Ptr{ImDrawListSplitter}, Ptr{ImDrawList}, Cint), self, draw_list, count)
end

function ImDrawListSplitter_Merge(self, draw_list)
    ccall((:ImDrawListSplitter_Merge, libcimgui), Cvoid, (Ptr{ImDrawListSplitter}, Ptr{ImDrawList}), self, draw_list)
end

function ImDrawListSplitter_SetCurrentChannel(self, draw_list, channel_idx)
    ccall((:ImDrawListSplitter_SetCurrentChannel, libcimgui), Cvoid, (Ptr{ImDrawListSplitter}, Ptr{ImDrawList}, Cint), self, draw_list, channel_idx)
end

function ImDrawList_ImDrawList(shared_data)
    ccall((:ImDrawList_ImDrawList, libcimgui), Ptr{ImDrawList}, (Ptr{ImDrawListSharedData},), shared_data)
end

function ImDrawList_destroy(self)
    ccall((:ImDrawList_destroy, libcimgui), Cvoid, (Ptr{ImDrawList},), self)
end

function ImDrawList_PushClipRect(self, clip_rect_min, clip_rect_max, intersect_with_current_clip_rect)
    ccall((:ImDrawList_PushClipRect, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, Bool), self, clip_rect_min, clip_rect_max, intersect_with_current_clip_rect)
end

function ImDrawList_PushClipRectFullScreen(self)
    ccall((:ImDrawList_PushClipRectFullScreen, libcimgui), Cvoid, (Ptr{ImDrawList},), self)
end

function ImDrawList_PopClipRect(self)
    ccall((:ImDrawList_PopClipRect, libcimgui), Cvoid, (Ptr{ImDrawList},), self)
end

function ImDrawList_PushTextureID(self, texture_id)
    ccall((:ImDrawList_PushTextureID, libcimgui), Cvoid, (Ptr{ImDrawList}, ImTextureID), self, texture_id)
end

function ImDrawList_PopTextureID(self)
    ccall((:ImDrawList_PopTextureID, libcimgui), Cvoid, (Ptr{ImDrawList},), self)
end

function ImDrawList_GetClipRectMin(pOut, self)
    ccall((:ImDrawList_GetClipRectMin, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImDrawList}), pOut, self)
end

function ImDrawList_GetClipRectMax(pOut, self)
    ccall((:ImDrawList_GetClipRectMax, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImDrawList}), pOut, self)
end

function ImDrawList_AddLine(self, p1, p2, col, thickness)
    ccall((:ImDrawList_AddLine, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImU32, Cfloat), self, p1, p2, col, thickness)
end

function ImDrawList_AddRect(self, p_min, p_max, col, rounding, flags, thickness)
    ccall((:ImDrawList_AddRect, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImU32, Cfloat, ImDrawFlags, Cfloat), self, p_min, p_max, col, rounding, flags, thickness)
end

function ImDrawList_AddRectFilled(self, p_min, p_max, col, rounding, flags)
    ccall((:ImDrawList_AddRectFilled, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImU32, Cfloat, ImDrawFlags), self, p_min, p_max, col, rounding, flags)
end

function ImDrawList_AddRectFilledMultiColor(self, p_min, p_max, col_upr_left, col_upr_right, col_bot_right, col_bot_left)
    ccall((:ImDrawList_AddRectFilledMultiColor, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImU32, ImU32, ImU32, ImU32), self, p_min, p_max, col_upr_left, col_upr_right, col_bot_right, col_bot_left)
end

function ImDrawList_AddQuad(self, p1, p2, p3, p4, col, thickness)
    ccall((:ImDrawList_AddQuad, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImVec2, ImVec2, ImU32, Cfloat), self, p1, p2, p3, p4, col, thickness)
end

function ImDrawList_AddQuadFilled(self, p1, p2, p3, p4, col)
    ccall((:ImDrawList_AddQuadFilled, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImVec2, ImVec2, ImU32), self, p1, p2, p3, p4, col)
end

function ImDrawList_AddTriangle(self, p1, p2, p3, col, thickness)
    ccall((:ImDrawList_AddTriangle, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImVec2, ImU32, Cfloat), self, p1, p2, p3, col, thickness)
end

function ImDrawList_AddTriangleFilled(self, p1, p2, p3, col)
    ccall((:ImDrawList_AddTriangleFilled, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImVec2, ImU32), self, p1, p2, p3, col)
end

function ImDrawList_AddCircle(self, center, radius, col, num_segments, thickness)
    ccall((:ImDrawList_AddCircle, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, Cfloat, ImU32, Cint, Cfloat), self, center, radius, col, num_segments, thickness)
end

function ImDrawList_AddCircleFilled(self, center, radius, col, num_segments)
    ccall((:ImDrawList_AddCircleFilled, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, Cfloat, ImU32, Cint), self, center, radius, col, num_segments)
end

function ImDrawList_AddNgon(self, center, radius, col, num_segments, thickness)
    ccall((:ImDrawList_AddNgon, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, Cfloat, ImU32, Cint, Cfloat), self, center, radius, col, num_segments, thickness)
end

function ImDrawList_AddNgonFilled(self, center, radius, col, num_segments)
    ccall((:ImDrawList_AddNgonFilled, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, Cfloat, ImU32, Cint), self, center, radius, col, num_segments)
end

function ImDrawList_AddEllipse(self, center, radius, col, rot, num_segments, thickness)
    ccall((:ImDrawList_AddEllipse, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImU32, Cfloat, Cint, Cfloat), self, center, radius, col, rot, num_segments, thickness)
end

function ImDrawList_AddEllipseFilled(self, center, radius, col, rot, num_segments)
    ccall((:ImDrawList_AddEllipseFilled, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImU32, Cfloat, Cint), self, center, radius, col, rot, num_segments)
end

function ImDrawList_AddText_Vec2(self, pos, col, text_begin, text_end)
    ccall((:ImDrawList_AddText_Vec2, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImU32, Ptr{Cchar}, Ptr{Cchar}), self, pos, col, text_begin, text_end)
end

function ImDrawList_AddText_FontPtr(self, font, font_size, pos, col, text_begin, text_end, wrap_width, cpu_fine_clip_rect)
    ccall((:ImDrawList_AddText_FontPtr, libcimgui), Cvoid, (Ptr{ImDrawList}, Ptr{ImFont}, Cfloat, ImVec2, ImU32, Ptr{Cchar}, Ptr{Cchar}, Cfloat, Ptr{ImVec4}), self, font, font_size, pos, col, text_begin, text_end, wrap_width, cpu_fine_clip_rect)
end

function ImDrawList_AddBezierCubic(self, p1, p2, p3, p4, col, thickness, num_segments)
    ccall((:ImDrawList_AddBezierCubic, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImVec2, ImVec2, ImU32, Cfloat, Cint), self, p1, p2, p3, p4, col, thickness, num_segments)
end

function ImDrawList_AddBezierQuadratic(self, p1, p2, p3, col, thickness, num_segments)
    ccall((:ImDrawList_AddBezierQuadratic, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImVec2, ImU32, Cfloat, Cint), self, p1, p2, p3, col, thickness, num_segments)
end

function ImDrawList_AddPolyline(self, points, num_points, col, flags, thickness)
    ccall((:ImDrawList_AddPolyline, libcimgui), Cvoid, (Ptr{ImDrawList}, Ptr{ImVec2}, Cint, ImU32, ImDrawFlags, Cfloat), self, points, num_points, col, flags, thickness)
end

function ImDrawList_AddConvexPolyFilled(self, points, num_points, col)
    ccall((:ImDrawList_AddConvexPolyFilled, libcimgui), Cvoid, (Ptr{ImDrawList}, Ptr{ImVec2}, Cint, ImU32), self, points, num_points, col)
end

function ImDrawList_AddConcavePolyFilled(self, points, num_points, col)
    ccall((:ImDrawList_AddConcavePolyFilled, libcimgui), Cvoid, (Ptr{ImDrawList}, Ptr{ImVec2}, Cint, ImU32), self, points, num_points, col)
end

function ImDrawList_AddImage(self, user_texture_id, p_min, p_max, uv_min, uv_max, col)
    ccall((:ImDrawList_AddImage, libcimgui), Cvoid, (Ptr{ImDrawList}, ImTextureID, ImVec2, ImVec2, ImVec2, ImVec2, ImU32), self, user_texture_id, p_min, p_max, uv_min, uv_max, col)
end

function ImDrawList_AddImageQuad(self, user_texture_id, p1, p2, p3, p4, uv1, uv2, uv3, uv4, col)
    ccall((:ImDrawList_AddImageQuad, libcimgui), Cvoid, (Ptr{ImDrawList}, ImTextureID, ImVec2, ImVec2, ImVec2, ImVec2, ImVec2, ImVec2, ImVec2, ImVec2, ImU32), self, user_texture_id, p1, p2, p3, p4, uv1, uv2, uv3, uv4, col)
end

function ImDrawList_AddImageRounded(self, user_texture_id, p_min, p_max, uv_min, uv_max, col, rounding, flags)
    ccall((:ImDrawList_AddImageRounded, libcimgui), Cvoid, (Ptr{ImDrawList}, ImTextureID, ImVec2, ImVec2, ImVec2, ImVec2, ImU32, Cfloat, ImDrawFlags), self, user_texture_id, p_min, p_max, uv_min, uv_max, col, rounding, flags)
end

function ImDrawList_PathClear(self)
    ccall((:ImDrawList_PathClear, libcimgui), Cvoid, (Ptr{ImDrawList},), self)
end

function ImDrawList_PathLineTo(self, pos)
    ccall((:ImDrawList_PathLineTo, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2), self, pos)
end

function ImDrawList_PathLineToMergeDuplicate(self, pos)
    ccall((:ImDrawList_PathLineToMergeDuplicate, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2), self, pos)
end

function ImDrawList_PathFillConvex(self, col)
    ccall((:ImDrawList_PathFillConvex, libcimgui), Cvoid, (Ptr{ImDrawList}, ImU32), self, col)
end

function ImDrawList_PathFillConcave(self, col)
    ccall((:ImDrawList_PathFillConcave, libcimgui), Cvoid, (Ptr{ImDrawList}, ImU32), self, col)
end

function ImDrawList_PathStroke(self, col, flags, thickness)
    ccall((:ImDrawList_PathStroke, libcimgui), Cvoid, (Ptr{ImDrawList}, ImU32, ImDrawFlags, Cfloat), self, col, flags, thickness)
end

function ImDrawList_PathArcTo(self, center, radius, a_min, a_max, num_segments)
    ccall((:ImDrawList_PathArcTo, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, Cfloat, Cfloat, Cfloat, Cint), self, center, radius, a_min, a_max, num_segments)
end

function ImDrawList_PathArcToFast(self, center, radius, a_min_of_12, a_max_of_12)
    ccall((:ImDrawList_PathArcToFast, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, Cfloat, Cint, Cint), self, center, radius, a_min_of_12, a_max_of_12)
end

function ImDrawList_PathEllipticalArcTo(self, center, radius, rot, a_min, a_max, num_segments)
    ccall((:ImDrawList_PathEllipticalArcTo, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, Cfloat, Cfloat, Cfloat, Cint), self, center, radius, rot, a_min, a_max, num_segments)
end

function ImDrawList_PathBezierCubicCurveTo(self, p2, p3, p4, num_segments)
    ccall((:ImDrawList_PathBezierCubicCurveTo, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImVec2, Cint), self, p2, p3, p4, num_segments)
end

function ImDrawList_PathBezierQuadraticCurveTo(self, p2, p3, num_segments)
    ccall((:ImDrawList_PathBezierQuadraticCurveTo, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, Cint), self, p2, p3, num_segments)
end

function ImDrawList_PathRect(self, rect_min, rect_max, rounding, flags)
    ccall((:ImDrawList_PathRect, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, Cfloat, ImDrawFlags), self, rect_min, rect_max, rounding, flags)
end

function ImDrawList_AddCallback(self, callback, callback_data)
    ccall((:ImDrawList_AddCallback, libcimgui), Cvoid, (Ptr{ImDrawList}, ImDrawCallback, Ptr{Cvoid}), self, callback, callback_data)
end

function ImDrawList_AddDrawCmd(self)
    ccall((:ImDrawList_AddDrawCmd, libcimgui), Cvoid, (Ptr{ImDrawList},), self)
end

function ImDrawList_CloneOutput(self)
    ccall((:ImDrawList_CloneOutput, libcimgui), Ptr{ImDrawList}, (Ptr{ImDrawList},), self)
end

function ImDrawList_ChannelsSplit(self, count)
    ccall((:ImDrawList_ChannelsSplit, libcimgui), Cvoid, (Ptr{ImDrawList}, Cint), self, count)
end

function ImDrawList_ChannelsMerge(self)
    ccall((:ImDrawList_ChannelsMerge, libcimgui), Cvoid, (Ptr{ImDrawList},), self)
end

function ImDrawList_ChannelsSetCurrent(self, n)
    ccall((:ImDrawList_ChannelsSetCurrent, libcimgui), Cvoid, (Ptr{ImDrawList}, Cint), self, n)
end

function ImDrawList_PrimReserve(self, idx_count, vtx_count)
    ccall((:ImDrawList_PrimReserve, libcimgui), Cvoid, (Ptr{ImDrawList}, Cint, Cint), self, idx_count, vtx_count)
end

function ImDrawList_PrimUnreserve(self, idx_count, vtx_count)
    ccall((:ImDrawList_PrimUnreserve, libcimgui), Cvoid, (Ptr{ImDrawList}, Cint, Cint), self, idx_count, vtx_count)
end

function ImDrawList_PrimRect(self, a, b, col)
    ccall((:ImDrawList_PrimRect, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImU32), self, a, b, col)
end

function ImDrawList_PrimRectUV(self, a, b, uv_a, uv_b, col)
    ccall((:ImDrawList_PrimRectUV, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImVec2, ImVec2, ImU32), self, a, b, uv_a, uv_b, col)
end

function ImDrawList_PrimQuadUV(self, a, b, c, d, uv_a, uv_b, uv_c, uv_d, col)
    ccall((:ImDrawList_PrimQuadUV, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImVec2, ImVec2, ImVec2, ImVec2, ImVec2, ImVec2, ImU32), self, a, b, c, d, uv_a, uv_b, uv_c, uv_d, col)
end

function ImDrawList_PrimWriteVtx(self, pos, uv, col)
    ccall((:ImDrawList_PrimWriteVtx, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImU32), self, pos, uv, col)
end

function ImDrawList_PrimWriteIdx(self, idx)
    ccall((:ImDrawList_PrimWriteIdx, libcimgui), Cvoid, (Ptr{ImDrawList}, ImDrawIdx), self, idx)
end

function ImDrawList_PrimVtx(self, pos, uv, col)
    ccall((:ImDrawList_PrimVtx, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImU32), self, pos, uv, col)
end

function ImDrawList__ResetForNewFrame(self)
    ccall((:ImDrawList__ResetForNewFrame, libcimgui), Cvoid, (Ptr{ImDrawList},), self)
end

function ImDrawList__ClearFreeMemory(self)
    ccall((:ImDrawList__ClearFreeMemory, libcimgui), Cvoid, (Ptr{ImDrawList},), self)
end

function ImDrawList__PopUnusedDrawCmd(self)
    ccall((:ImDrawList__PopUnusedDrawCmd, libcimgui), Cvoid, (Ptr{ImDrawList},), self)
end

function ImDrawList__TryMergeDrawCmds(self)
    ccall((:ImDrawList__TryMergeDrawCmds, libcimgui), Cvoid, (Ptr{ImDrawList},), self)
end

function ImDrawList__OnChangedClipRect(self)
    ccall((:ImDrawList__OnChangedClipRect, libcimgui), Cvoid, (Ptr{ImDrawList},), self)
end

function ImDrawList__OnChangedTextureID(self)
    ccall((:ImDrawList__OnChangedTextureID, libcimgui), Cvoid, (Ptr{ImDrawList},), self)
end

function ImDrawList__OnChangedVtxOffset(self)
    ccall((:ImDrawList__OnChangedVtxOffset, libcimgui), Cvoid, (Ptr{ImDrawList},), self)
end

function ImDrawList__CalcCircleAutoSegmentCount(self, radius)
    ccall((:ImDrawList__CalcCircleAutoSegmentCount, libcimgui), Cint, (Ptr{ImDrawList}, Cfloat), self, radius)
end

function ImDrawList__PathArcToFastEx(self, center, radius, a_min_sample, a_max_sample, a_step)
    ccall((:ImDrawList__PathArcToFastEx, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, Cfloat, Cint, Cint, Cint), self, center, radius, a_min_sample, a_max_sample, a_step)
end

function ImDrawList__PathArcToN(self, center, radius, a_min, a_max, num_segments)
    ccall((:ImDrawList__PathArcToN, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, Cfloat, Cfloat, Cfloat, Cint), self, center, radius, a_min, a_max, num_segments)
end

function ImDrawData_ImDrawData()
    ccall((:ImDrawData_ImDrawData, libcimgui), Ptr{ImDrawData}, ())
end

function ImDrawData_destroy(self)
    ccall((:ImDrawData_destroy, libcimgui), Cvoid, (Ptr{ImDrawData},), self)
end

function ImDrawData_Clear(self)
    ccall((:ImDrawData_Clear, libcimgui), Cvoid, (Ptr{ImDrawData},), self)
end

function ImDrawData_AddDrawList(self, draw_list)
    ccall((:ImDrawData_AddDrawList, libcimgui), Cvoid, (Ptr{ImDrawData}, Ptr{ImDrawList}), self, draw_list)
end

function ImDrawData_DeIndexAllBuffers(self)
    ccall((:ImDrawData_DeIndexAllBuffers, libcimgui), Cvoid, (Ptr{ImDrawData},), self)
end

function ImDrawData_ScaleClipRects(self, fb_scale)
    ccall((:ImDrawData_ScaleClipRects, libcimgui), Cvoid, (Ptr{ImDrawData}, ImVec2), self, fb_scale)
end

function ImFontConfig_ImFontConfig()
    ccall((:ImFontConfig_ImFontConfig, libcimgui), Ptr{ImFontConfig}, ())
end

function ImFontConfig_destroy(self)
    ccall((:ImFontConfig_destroy, libcimgui), Cvoid, (Ptr{ImFontConfig},), self)
end

function ImFontGlyphRangesBuilder_ImFontGlyphRangesBuilder()
    ccall((:ImFontGlyphRangesBuilder_ImFontGlyphRangesBuilder, libcimgui), Ptr{ImFontGlyphRangesBuilder}, ())
end

function ImFontGlyphRangesBuilder_destroy(self)
    ccall((:ImFontGlyphRangesBuilder_destroy, libcimgui), Cvoid, (Ptr{ImFontGlyphRangesBuilder},), self)
end

function ImFontGlyphRangesBuilder_Clear(self)
    ccall((:ImFontGlyphRangesBuilder_Clear, libcimgui), Cvoid, (Ptr{ImFontGlyphRangesBuilder},), self)
end

function ImFontGlyphRangesBuilder_GetBit(self, n)
    ccall((:ImFontGlyphRangesBuilder_GetBit, libcimgui), Bool, (Ptr{ImFontGlyphRangesBuilder}, Csize_t), self, n)
end

function ImFontGlyphRangesBuilder_SetBit(self, n)
    ccall((:ImFontGlyphRangesBuilder_SetBit, libcimgui), Cvoid, (Ptr{ImFontGlyphRangesBuilder}, Csize_t), self, n)
end

function ImFontGlyphRangesBuilder_AddChar(self, c)
    ccall((:ImFontGlyphRangesBuilder_AddChar, libcimgui), Cvoid, (Ptr{ImFontGlyphRangesBuilder}, ImWchar), self, c)
end

function ImFontGlyphRangesBuilder_AddText(self, text, text_end)
    ccall((:ImFontGlyphRangesBuilder_AddText, libcimgui), Cvoid, (Ptr{ImFontGlyphRangesBuilder}, Ptr{Cchar}, Ptr{Cchar}), self, text, text_end)
end

function ImFontGlyphRangesBuilder_AddRanges(self, ranges)
    ccall((:ImFontGlyphRangesBuilder_AddRanges, libcimgui), Cvoid, (Ptr{ImFontGlyphRangesBuilder}, Ptr{ImWchar}), self, ranges)
end

function ImFontGlyphRangesBuilder_BuildRanges(self, out_ranges)
    ccall((:ImFontGlyphRangesBuilder_BuildRanges, libcimgui), Cvoid, (Ptr{ImFontGlyphRangesBuilder}, Ptr{ImVector_ImWchar}), self, out_ranges)
end

function ImFontAtlasCustomRect_ImFontAtlasCustomRect()
    ccall((:ImFontAtlasCustomRect_ImFontAtlasCustomRect, libcimgui), Ptr{ImFontAtlasCustomRect}, ())
end

function ImFontAtlasCustomRect_destroy(self)
    ccall((:ImFontAtlasCustomRect_destroy, libcimgui), Cvoid, (Ptr{ImFontAtlasCustomRect},), self)
end

function ImFontAtlasCustomRect_IsPacked(self)
    ccall((:ImFontAtlasCustomRect_IsPacked, libcimgui), Bool, (Ptr{ImFontAtlasCustomRect},), self)
end

function ImFontAtlas_ImFontAtlas()
    ccall((:ImFontAtlas_ImFontAtlas, libcimgui), Ptr{ImFontAtlas}, ())
end

function ImFontAtlas_destroy(self)
    ccall((:ImFontAtlas_destroy, libcimgui), Cvoid, (Ptr{ImFontAtlas},), self)
end

function ImFontAtlas_AddFont(self, font_cfg)
    ccall((:ImFontAtlas_AddFont, libcimgui), Ptr{ImFont}, (Ptr{ImFontAtlas}, Ptr{ImFontConfig}), self, font_cfg)
end

function ImFontAtlas_AddFontDefault(self, font_cfg)
    ccall((:ImFontAtlas_AddFontDefault, libcimgui), Ptr{ImFont}, (Ptr{ImFontAtlas}, Ptr{ImFontConfig}), self, font_cfg)
end

function ImFontAtlas_AddFontFromFileTTF(self, filename, size_pixels, font_cfg, glyph_ranges)
    ccall((:ImFontAtlas_AddFontFromFileTTF, libcimgui), Ptr{ImFont}, (Ptr{ImFontAtlas}, Ptr{Cchar}, Cfloat, Ptr{ImFontConfig}, Ptr{ImWchar}), self, filename, size_pixels, font_cfg, glyph_ranges)
end

function ImFontAtlas_AddFontFromMemoryTTF(self, font_data, font_data_size, size_pixels, font_cfg, glyph_ranges)
    ccall((:ImFontAtlas_AddFontFromMemoryTTF, libcimgui), Ptr{ImFont}, (Ptr{ImFontAtlas}, Ptr{Cvoid}, Cint, Cfloat, Ptr{ImFontConfig}, Ptr{ImWchar}), self, font_data, font_data_size, size_pixels, font_cfg, glyph_ranges)
end

function ImFontAtlas_AddFontFromMemoryCompressedTTF(self, compressed_font_data, compressed_font_data_size, size_pixels, font_cfg, glyph_ranges)
    ccall((:ImFontAtlas_AddFontFromMemoryCompressedTTF, libcimgui), Ptr{ImFont}, (Ptr{ImFontAtlas}, Ptr{Cvoid}, Cint, Cfloat, Ptr{ImFontConfig}, Ptr{ImWchar}), self, compressed_font_data, compressed_font_data_size, size_pixels, font_cfg, glyph_ranges)
end

function ImFontAtlas_AddFontFromMemoryCompressedBase85TTF(self, compressed_font_data_base85, size_pixels, font_cfg, glyph_ranges)
    ccall((:ImFontAtlas_AddFontFromMemoryCompressedBase85TTF, libcimgui), Ptr{ImFont}, (Ptr{ImFontAtlas}, Ptr{Cchar}, Cfloat, Ptr{ImFontConfig}, Ptr{ImWchar}), self, compressed_font_data_base85, size_pixels, font_cfg, glyph_ranges)
end

function ImFontAtlas_ClearInputData(self)
    ccall((:ImFontAtlas_ClearInputData, libcimgui), Cvoid, (Ptr{ImFontAtlas},), self)
end

function ImFontAtlas_ClearTexData(self)
    ccall((:ImFontAtlas_ClearTexData, libcimgui), Cvoid, (Ptr{ImFontAtlas},), self)
end

function ImFontAtlas_ClearFonts(self)
    ccall((:ImFontAtlas_ClearFonts, libcimgui), Cvoid, (Ptr{ImFontAtlas},), self)
end

function ImFontAtlas_Clear(self)
    ccall((:ImFontAtlas_Clear, libcimgui), Cvoid, (Ptr{ImFontAtlas},), self)
end

function ImFontAtlas_Build(self)
    ccall((:ImFontAtlas_Build, libcimgui), Bool, (Ptr{ImFontAtlas},), self)
end

function ImFontAtlas_GetTexDataAsAlpha8(self, out_pixels, out_width, out_height, out_bytes_per_pixel)
    ccall((:ImFontAtlas_GetTexDataAsAlpha8, libcimgui), Cvoid, (Ptr{ImFontAtlas}, Ptr{Ptr{Cuchar}}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), self, out_pixels, out_width, out_height, out_bytes_per_pixel)
end

function ImFontAtlas_GetTexDataAsRGBA32(self, out_pixels, out_width, out_height, out_bytes_per_pixel)
    ccall((:ImFontAtlas_GetTexDataAsRGBA32, libcimgui), Cvoid, (Ptr{ImFontAtlas}, Ptr{Ptr{Cuchar}}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), self, out_pixels, out_width, out_height, out_bytes_per_pixel)
end

function ImFontAtlas_IsBuilt(self)
    ccall((:ImFontAtlas_IsBuilt, libcimgui), Bool, (Ptr{ImFontAtlas},), self)
end

function ImFontAtlas_SetTexID(self, id)
    ccall((:ImFontAtlas_SetTexID, libcimgui), Cvoid, (Ptr{ImFontAtlas}, ImTextureID), self, id)
end

function ImFontAtlas_GetGlyphRangesDefault(self)
    ccall((:ImFontAtlas_GetGlyphRangesDefault, libcimgui), Ptr{ImWchar}, (Ptr{ImFontAtlas},), self)
end

function ImFontAtlas_GetGlyphRangesGreek(self)
    ccall((:ImFontAtlas_GetGlyphRangesGreek, libcimgui), Ptr{ImWchar}, (Ptr{ImFontAtlas},), self)
end

function ImFontAtlas_GetGlyphRangesKorean(self)
    ccall((:ImFontAtlas_GetGlyphRangesKorean, libcimgui), Ptr{ImWchar}, (Ptr{ImFontAtlas},), self)
end

function ImFontAtlas_GetGlyphRangesJapanese(self)
    ccall((:ImFontAtlas_GetGlyphRangesJapanese, libcimgui), Ptr{ImWchar}, (Ptr{ImFontAtlas},), self)
end

function ImFontAtlas_GetGlyphRangesChineseFull(self)
    ccall((:ImFontAtlas_GetGlyphRangesChineseFull, libcimgui), Ptr{ImWchar}, (Ptr{ImFontAtlas},), self)
end

function ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon(self)
    ccall((:ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon, libcimgui), Ptr{ImWchar}, (Ptr{ImFontAtlas},), self)
end

function ImFontAtlas_GetGlyphRangesCyrillic(self)
    ccall((:ImFontAtlas_GetGlyphRangesCyrillic, libcimgui), Ptr{ImWchar}, (Ptr{ImFontAtlas},), self)
end

function ImFontAtlas_GetGlyphRangesThai(self)
    ccall((:ImFontAtlas_GetGlyphRangesThai, libcimgui), Ptr{ImWchar}, (Ptr{ImFontAtlas},), self)
end

function ImFontAtlas_GetGlyphRangesVietnamese(self)
    ccall((:ImFontAtlas_GetGlyphRangesVietnamese, libcimgui), Ptr{ImWchar}, (Ptr{ImFontAtlas},), self)
end

function ImFontAtlas_AddCustomRectRegular(self, width, height)
    ccall((:ImFontAtlas_AddCustomRectRegular, libcimgui), Cint, (Ptr{ImFontAtlas}, Cint, Cint), self, width, height)
end

function ImFontAtlas_AddCustomRectFontGlyph(self, font, id, width, height, advance_x, offset)
    ccall((:ImFontAtlas_AddCustomRectFontGlyph, libcimgui), Cint, (Ptr{ImFontAtlas}, Ptr{ImFont}, ImWchar, Cint, Cint, Cfloat, ImVec2), self, font, id, width, height, advance_x, offset)
end

function ImFontAtlas_GetCustomRectByIndex(self, index)
    ccall((:ImFontAtlas_GetCustomRectByIndex, libcimgui), Ptr{ImFontAtlasCustomRect}, (Ptr{ImFontAtlas}, Cint), self, index)
end

function ImFontAtlas_CalcCustomRectUV(self, rect, out_uv_min, out_uv_max)
    ccall((:ImFontAtlas_CalcCustomRectUV, libcimgui), Cvoid, (Ptr{ImFontAtlas}, Ptr{ImFontAtlasCustomRect}, Ptr{ImVec2}, Ptr{ImVec2}), self, rect, out_uv_min, out_uv_max)
end

function ImFontAtlas_GetMouseCursorTexData(self, cursor, out_offset, out_size, out_uv_border, out_uv_fill)
    ccall((:ImFontAtlas_GetMouseCursorTexData, libcimgui), Bool, (Ptr{ImFontAtlas}, ImGuiMouseCursor, Ptr{ImVec2}, Ptr{ImVec2}, Ptr{ImVec2}, Ptr{ImVec2}), self, cursor, out_offset, out_size, out_uv_border, out_uv_fill)
end

function ImFont_ImFont()
    ccall((:ImFont_ImFont, libcimgui), Ptr{ImFont}, ())
end

function ImFont_destroy(self)
    ccall((:ImFont_destroy, libcimgui), Cvoid, (Ptr{ImFont},), self)
end

function ImFont_FindGlyph(self, c)
    ccall((:ImFont_FindGlyph, libcimgui), Ptr{ImFontGlyph}, (Ptr{ImFont}, ImWchar), self, c)
end

function ImFont_FindGlyphNoFallback(self, c)
    ccall((:ImFont_FindGlyphNoFallback, libcimgui), Ptr{ImFontGlyph}, (Ptr{ImFont}, ImWchar), self, c)
end

function ImFont_GetCharAdvance(self, c)
    ccall((:ImFont_GetCharAdvance, libcimgui), Cfloat, (Ptr{ImFont}, ImWchar), self, c)
end

function ImFont_IsLoaded(self)
    ccall((:ImFont_IsLoaded, libcimgui), Bool, (Ptr{ImFont},), self)
end

function ImFont_GetDebugName(self)
    ccall((:ImFont_GetDebugName, libcimgui), Ptr{Cchar}, (Ptr{ImFont},), self)
end

function ImFont_CalcTextSizeA(pOut, self, size, max_width, wrap_width, text_begin, text_end, remaining)
    ccall((:ImFont_CalcTextSizeA, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImFont}, Cfloat, Cfloat, Cfloat, Ptr{Cchar}, Ptr{Cchar}, Ptr{Ptr{Cchar}}), pOut, self, size, max_width, wrap_width, text_begin, text_end, remaining)
end

function ImFont_CalcWordWrapPositionA(self, scale, text, text_end, wrap_width)
    ccall((:ImFont_CalcWordWrapPositionA, libcimgui), Ptr{Cchar}, (Ptr{ImFont}, Cfloat, Ptr{Cchar}, Ptr{Cchar}, Cfloat), self, scale, text, text_end, wrap_width)
end

function ImFont_RenderChar(self, draw_list, size, pos, col, c)
    ccall((:ImFont_RenderChar, libcimgui), Cvoid, (Ptr{ImFont}, Ptr{ImDrawList}, Cfloat, ImVec2, ImU32, ImWchar), self, draw_list, size, pos, col, c)
end

function ImFont_RenderText(self, draw_list, size, pos, col, clip_rect, text_begin, text_end, wrap_width, cpu_fine_clip)
    ccall((:ImFont_RenderText, libcimgui), Cvoid, (Ptr{ImFont}, Ptr{ImDrawList}, Cfloat, ImVec2, ImU32, ImVec4, Ptr{Cchar}, Ptr{Cchar}, Cfloat, Bool), self, draw_list, size, pos, col, clip_rect, text_begin, text_end, wrap_width, cpu_fine_clip)
end

function ImFont_BuildLookupTable(self)
    ccall((:ImFont_BuildLookupTable, libcimgui), Cvoid, (Ptr{ImFont},), self)
end

function ImFont_ClearOutputData(self)
    ccall((:ImFont_ClearOutputData, libcimgui), Cvoid, (Ptr{ImFont},), self)
end

function ImFont_GrowIndex(self, new_size)
    ccall((:ImFont_GrowIndex, libcimgui), Cvoid, (Ptr{ImFont}, Cint), self, new_size)
end

function ImFont_AddGlyph(self, src_cfg, c, x0, y0, x1, y1, u0, v0, u1, v1, advance_x)
    ccall((:ImFont_AddGlyph, libcimgui), Cvoid, (Ptr{ImFont}, Ptr{ImFontConfig}, ImWchar, Cfloat, Cfloat, Cfloat, Cfloat, Cfloat, Cfloat, Cfloat, Cfloat, Cfloat), self, src_cfg, c, x0, y0, x1, y1, u0, v0, u1, v1, advance_x)
end

function ImFont_AddRemapChar(self, dst, src, overwrite_dst)
    ccall((:ImFont_AddRemapChar, libcimgui), Cvoid, (Ptr{ImFont}, ImWchar, ImWchar, Bool), self, dst, src, overwrite_dst)
end

function ImFont_SetGlyphVisible(self, c, visible)
    ccall((:ImFont_SetGlyphVisible, libcimgui), Cvoid, (Ptr{ImFont}, ImWchar, Bool), self, c, visible)
end

function ImFont_IsGlyphRangeUnused(self, c_begin, c_last)
    ccall((:ImFont_IsGlyphRangeUnused, libcimgui), Bool, (Ptr{ImFont}, Cuint, Cuint), self, c_begin, c_last)
end

function ImGuiViewport_ImGuiViewport()
    ccall((:ImGuiViewport_ImGuiViewport, libcimgui), Ptr{ImGuiViewport}, ())
end

function ImGuiViewport_destroy(self)
    ccall((:ImGuiViewport_destroy, libcimgui), Cvoid, (Ptr{ImGuiViewport},), self)
end

function ImGuiViewport_GetCenter(pOut, self)
    ccall((:ImGuiViewport_GetCenter, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImGuiViewport}), pOut, self)
end

function ImGuiViewport_GetWorkCenter(pOut, self)
    ccall((:ImGuiViewport_GetWorkCenter, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImGuiViewport}), pOut, self)
end

function ImGuiPlatformIO_ImGuiPlatformIO()
    ccall((:ImGuiPlatformIO_ImGuiPlatformIO, libcimgui), Ptr{ImGuiPlatformIO}, ())
end

function ImGuiPlatformIO_destroy(self)
    ccall((:ImGuiPlatformIO_destroy, libcimgui), Cvoid, (Ptr{ImGuiPlatformIO},), self)
end

function ImGuiPlatformMonitor_ImGuiPlatformMonitor()
    ccall((:ImGuiPlatformMonitor_ImGuiPlatformMonitor, libcimgui), Ptr{ImGuiPlatformMonitor}, ())
end

function ImGuiPlatformMonitor_destroy(self)
    ccall((:ImGuiPlatformMonitor_destroy, libcimgui), Cvoid, (Ptr{ImGuiPlatformMonitor},), self)
end

function ImGuiPlatformImeData_ImGuiPlatformImeData()
    ccall((:ImGuiPlatformImeData_ImGuiPlatformImeData, libcimgui), Ptr{ImGuiPlatformImeData}, ())
end

function ImGuiPlatformImeData_destroy(self)
    ccall((:ImGuiPlatformImeData_destroy, libcimgui), Cvoid, (Ptr{ImGuiPlatformImeData},), self)
end

function igImHashData(data, data_size, seed)
    ccall((:igImHashData, libcimgui), ImGuiID, (Ptr{Cvoid}, Csize_t, ImGuiID), data, data_size, seed)
end

function igImHashStr(data, data_size, seed)
    ccall((:igImHashStr, libcimgui), ImGuiID, (Ptr{Cchar}, Csize_t, ImGuiID), data, data_size, seed)
end

function igImQsort(base, count, size_of_element, compare_func)
    ccall((:igImQsort, libcimgui), Cvoid, (Ptr{Cvoid}, Csize_t, Csize_t, Ptr{Cvoid}), base, count, size_of_element, compare_func)
end

function igImAlphaBlendColors(col_a, col_b)
    ccall((:igImAlphaBlendColors, libcimgui), ImU32, (ImU32, ImU32), col_a, col_b)
end

function igImIsPowerOfTwo_Int(v)
    ccall((:igImIsPowerOfTwo_Int, libcimgui), Bool, (Cint,), v)
end

function igImIsPowerOfTwo_U64(v)
    ccall((:igImIsPowerOfTwo_U64, libcimgui), Bool, (ImU64,), v)
end

function igImUpperPowerOfTwo(v)
    ccall((:igImUpperPowerOfTwo, libcimgui), Cint, (Cint,), v)
end

function igImStricmp(str1, str2)
    ccall((:igImStricmp, libcimgui), Cint, (Ptr{Cchar}, Ptr{Cchar}), str1, str2)
end

function igImStrnicmp(str1, str2, count)
    ccall((:igImStrnicmp, libcimgui), Cint, (Ptr{Cchar}, Ptr{Cchar}, Csize_t), str1, str2, count)
end

function igImStrncpy(dst, src, count)
    ccall((:igImStrncpy, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cchar}, Csize_t), dst, src, count)
end

function igImStrdup(str)
    ccall((:igImStrdup, libcimgui), Ptr{Cchar}, (Ptr{Cchar},), str)
end

function igImStrdupcpy(dst, p_dst_size, str)
    ccall((:igImStrdupcpy, libcimgui), Ptr{Cchar}, (Ptr{Cchar}, Ptr{Csize_t}, Ptr{Cchar}), dst, p_dst_size, str)
end

function igImStrchrRange(str_begin, str_end, c)
    ccall((:igImStrchrRange, libcimgui), Ptr{Cchar}, (Ptr{Cchar}, Ptr{Cchar}, Cchar), str_begin, str_end, c)
end

function igImStreolRange(str, str_end)
    ccall((:igImStreolRange, libcimgui), Ptr{Cchar}, (Ptr{Cchar}, Ptr{Cchar}), str, str_end)
end

function igImStristr(haystack, haystack_end, needle, needle_end)
    ccall((:igImStristr, libcimgui), Ptr{Cchar}, (Ptr{Cchar}, Ptr{Cchar}, Ptr{Cchar}, Ptr{Cchar}), haystack, haystack_end, needle, needle_end)
end

function igImStrTrimBlanks(str)
    ccall((:igImStrTrimBlanks, libcimgui), Cvoid, (Ptr{Cchar},), str)
end

function igImStrSkipBlank(str)
    ccall((:igImStrSkipBlank, libcimgui), Ptr{Cchar}, (Ptr{Cchar},), str)
end

function igImStrlenW(str)
    ccall((:igImStrlenW, libcimgui), Cint, (Ptr{ImWchar},), str)
end

function igImStrbolW(buf_mid_line, buf_begin)
    ccall((:igImStrbolW, libcimgui), Ptr{ImWchar}, (Ptr{ImWchar}, Ptr{ImWchar}), buf_mid_line, buf_begin)
end

function igImToUpper(c)
    ccall((:igImToUpper, libcimgui), Cchar, (Cchar,), c)
end

function igImCharIsBlankA(c)
    ccall((:igImCharIsBlankA, libcimgui), Bool, (Cchar,), c)
end

function igImCharIsBlankW(c)
    ccall((:igImCharIsBlankW, libcimgui), Bool, (Cuint,), c)
end

function igImCharIsXdigitA(c)
    ccall((:igImCharIsXdigitA, libcimgui), Bool, (Cchar,), c)
end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function igImFormatString(buf, buf_size, fmt, va_list...)
        :(@ccall(libcimgui.igImFormatString(buf::Ptr{Cchar}, buf_size::Csize_t, fmt::Ptr{Cchar}; $(to_c_type_pairs(va_list)...))::Cint))
    end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function igImFormatStringToTempBuffer(out_buf, out_buf_end, fmt, va_list...)
        :(@ccall(libcimgui.igImFormatStringToTempBuffer(out_buf::Ptr{Ptr{Cchar}}, out_buf_end::Ptr{Ptr{Cchar}}, fmt::Ptr{Cchar}; $(to_c_type_pairs(va_list)...))::Cvoid))
    end

function igImParseFormatFindStart(format)
    ccall((:igImParseFormatFindStart, libcimgui), Ptr{Cchar}, (Ptr{Cchar},), format)
end

function igImParseFormatFindEnd(format)
    ccall((:igImParseFormatFindEnd, libcimgui), Ptr{Cchar}, (Ptr{Cchar},), format)
end

function igImParseFormatTrimDecorations(format, buf, buf_size)
    ccall((:igImParseFormatTrimDecorations, libcimgui), Ptr{Cchar}, (Ptr{Cchar}, Ptr{Cchar}, Csize_t), format, buf, buf_size)
end

function igImParseFormatSanitizeForPrinting(fmt_in, fmt_out, fmt_out_size)
    ccall((:igImParseFormatSanitizeForPrinting, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cchar}, Csize_t), fmt_in, fmt_out, fmt_out_size)
end

function igImParseFormatSanitizeForScanning(fmt_in, fmt_out, fmt_out_size)
    ccall((:igImParseFormatSanitizeForScanning, libcimgui), Ptr{Cchar}, (Ptr{Cchar}, Ptr{Cchar}, Csize_t), fmt_in, fmt_out, fmt_out_size)
end

function igImParseFormatPrecision(format, default_value)
    ccall((:igImParseFormatPrecision, libcimgui), Cint, (Ptr{Cchar}, Cint), format, default_value)
end

function igImTextCharToUtf8(out_buf, c)
    ccall((:igImTextCharToUtf8, libcimgui), Ptr{Cchar}, (Ptr{Cchar}, Cuint), out_buf, c)
end

function igImTextStrToUtf8(out_buf, out_buf_size, in_text, in_text_end)
    ccall((:igImTextStrToUtf8, libcimgui), Cint, (Ptr{Cchar}, Cint, Ptr{ImWchar}, Ptr{ImWchar}), out_buf, out_buf_size, in_text, in_text_end)
end

function igImTextCharFromUtf8(out_char, in_text, in_text_end)
    ccall((:igImTextCharFromUtf8, libcimgui), Cint, (Ptr{Cuint}, Ptr{Cchar}, Ptr{Cchar}), out_char, in_text, in_text_end)
end

function igImTextStrFromUtf8(out_buf, out_buf_size, in_text, in_text_end, in_remaining)
    ccall((:igImTextStrFromUtf8, libcimgui), Cint, (Ptr{ImWchar}, Cint, Ptr{Cchar}, Ptr{Cchar}, Ptr{Ptr{Cchar}}), out_buf, out_buf_size, in_text, in_text_end, in_remaining)
end

function igImTextCountCharsFromUtf8(in_text, in_text_end)
    ccall((:igImTextCountCharsFromUtf8, libcimgui), Cint, (Ptr{Cchar}, Ptr{Cchar}), in_text, in_text_end)
end

function igImTextCountUtf8BytesFromChar(in_text, in_text_end)
    ccall((:igImTextCountUtf8BytesFromChar, libcimgui), Cint, (Ptr{Cchar}, Ptr{Cchar}), in_text, in_text_end)
end

function igImTextCountUtf8BytesFromStr(in_text, in_text_end)
    ccall((:igImTextCountUtf8BytesFromStr, libcimgui), Cint, (Ptr{ImWchar}, Ptr{ImWchar}), in_text, in_text_end)
end

function igImTextFindPreviousUtf8Codepoint(in_text_start, in_text_curr)
    ccall((:igImTextFindPreviousUtf8Codepoint, libcimgui), Ptr{Cchar}, (Ptr{Cchar}, Ptr{Cchar}), in_text_start, in_text_curr)
end

function igImTextCountLines(in_text, in_text_end)
    ccall((:igImTextCountLines, libcimgui), Cint, (Ptr{Cchar}, Ptr{Cchar}), in_text, in_text_end)
end

function igImFileOpen(filename, mode)
    ccall((:igImFileOpen, libcimgui), ImFileHandle, (Ptr{Cchar}, Ptr{Cchar}), filename, mode)
end

function igImFileClose(file)
    ccall((:igImFileClose, libcimgui), Bool, (ImFileHandle,), file)
end

function igImFileGetSize(file)
    ccall((:igImFileGetSize, libcimgui), ImU64, (ImFileHandle,), file)
end

function igImFileRead(data, size, count, file)
    ccall((:igImFileRead, libcimgui), ImU64, (Ptr{Cvoid}, ImU64, ImU64, ImFileHandle), data, size, count, file)
end

function igImFileWrite(data, size, count, file)
    ccall((:igImFileWrite, libcimgui), ImU64, (Ptr{Cvoid}, ImU64, ImU64, ImFileHandle), data, size, count, file)
end

function igImFileLoadToMemory(filename, mode, out_file_size, padding_bytes)
    ccall((:igImFileLoadToMemory, libcimgui), Ptr{Cvoid}, (Ptr{Cchar}, Ptr{Cchar}, Ptr{Csize_t}, Cint), filename, mode, out_file_size, padding_bytes)
end

function igImPow_Float(x, y)
    ccall((:igImPow_Float, libcimgui), Cfloat, (Cfloat, Cfloat), x, y)
end

function igImPow_double(x, y)
    ccall((:igImPow_double, libcimgui), Cdouble, (Cdouble, Cdouble), x, y)
end

function igImLog_Float(x)
    ccall((:igImLog_Float, libcimgui), Cfloat, (Cfloat,), x)
end

function igImLog_double(x)
    ccall((:igImLog_double, libcimgui), Cdouble, (Cdouble,), x)
end

function igImAbs_Int(x)
    ccall((:igImAbs_Int, libcimgui), Cint, (Cint,), x)
end

function igImAbs_Float(x)
    ccall((:igImAbs_Float, libcimgui), Cfloat, (Cfloat,), x)
end

function igImAbs_double(x)
    ccall((:igImAbs_double, libcimgui), Cdouble, (Cdouble,), x)
end

function igImSign_Float(x)
    ccall((:igImSign_Float, libcimgui), Cfloat, (Cfloat,), x)
end

function igImSign_double(x)
    ccall((:igImSign_double, libcimgui), Cdouble, (Cdouble,), x)
end

function igImRsqrt_Float(x)
    ccall((:igImRsqrt_Float, libcimgui), Cfloat, (Cfloat,), x)
end

function igImRsqrt_double(x)
    ccall((:igImRsqrt_double, libcimgui), Cdouble, (Cdouble,), x)
end

function igImMin(pOut, lhs, rhs)
    ccall((:igImMin, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2, ImVec2), pOut, lhs, rhs)
end

function igImMax(pOut, lhs, rhs)
    ccall((:igImMax, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2, ImVec2), pOut, lhs, rhs)
end

function igImClamp(pOut, v, mn, mx)
    ccall((:igImClamp, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2, ImVec2, ImVec2), pOut, v, mn, mx)
end

function igImLerp_Vec2Float(pOut, a, b, t)
    ccall((:igImLerp_Vec2Float, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2, ImVec2, Cfloat), pOut, a, b, t)
end

function igImLerp_Vec2Vec2(pOut, a, b, t)
    ccall((:igImLerp_Vec2Vec2, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2, ImVec2, ImVec2), pOut, a, b, t)
end

function igImLerp_Vec4(pOut, a, b, t)
    ccall((:igImLerp_Vec4, libcimgui), Cvoid, (Ptr{ImVec4}, ImVec4, ImVec4, Cfloat), pOut, a, b, t)
end

function igImSaturate(f)
    ccall((:igImSaturate, libcimgui), Cfloat, (Cfloat,), f)
end

function igImLengthSqr_Vec2(lhs)
    ccall((:igImLengthSqr_Vec2, libcimgui), Cfloat, (ImVec2,), lhs)
end

function igImLengthSqr_Vec4(lhs)
    ccall((:igImLengthSqr_Vec4, libcimgui), Cfloat, (ImVec4,), lhs)
end

function igImInvLength(lhs, fail_value)
    ccall((:igImInvLength, libcimgui), Cfloat, (ImVec2, Cfloat), lhs, fail_value)
end

function igImTrunc_Float(f)
    ccall((:igImTrunc_Float, libcimgui), Cfloat, (Cfloat,), f)
end

function igImTrunc_Vec2(pOut, v)
    ccall((:igImTrunc_Vec2, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2), pOut, v)
end

function igImFloor_Float(f)
    ccall((:igImFloor_Float, libcimgui), Cfloat, (Cfloat,), f)
end

function igImFloor_Vec2(pOut, v)
    ccall((:igImFloor_Vec2, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2), pOut, v)
end

function igImModPositive(a, b)
    ccall((:igImModPositive, libcimgui), Cint, (Cint, Cint), a, b)
end

function igImDot(a, b)
    ccall((:igImDot, libcimgui), Cfloat, (ImVec2, ImVec2), a, b)
end

function igImRotate(pOut, v, cos_a, sin_a)
    ccall((:igImRotate, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2, Cfloat, Cfloat), pOut, v, cos_a, sin_a)
end

function igImLinearSweep(current, target, speed)
    ccall((:igImLinearSweep, libcimgui), Cfloat, (Cfloat, Cfloat, Cfloat), current, target, speed)
end

function igImLinearRemapClamp(s0, s1, d0, d1, x)
    ccall((:igImLinearRemapClamp, libcimgui), Cfloat, (Cfloat, Cfloat, Cfloat, Cfloat, Cfloat), s0, s1, d0, d1, x)
end

function igImMul(pOut, lhs, rhs)
    ccall((:igImMul, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2, ImVec2), pOut, lhs, rhs)
end

function igImIsFloatAboveGuaranteedIntegerPrecision(f)
    ccall((:igImIsFloatAboveGuaranteedIntegerPrecision, libcimgui), Bool, (Cfloat,), f)
end

function igImExponentialMovingAverage(avg, sample, n)
    ccall((:igImExponentialMovingAverage, libcimgui), Cfloat, (Cfloat, Cfloat, Cint), avg, sample, n)
end

function igImBezierCubicCalc(pOut, p1, p2, p3, p4, t)
    ccall((:igImBezierCubicCalc, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2, ImVec2, ImVec2, ImVec2, Cfloat), pOut, p1, p2, p3, p4, t)
end

function igImBezierCubicClosestPoint(pOut, p1, p2, p3, p4, p, num_segments)
    ccall((:igImBezierCubicClosestPoint, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2, ImVec2, ImVec2, ImVec2, ImVec2, Cint), pOut, p1, p2, p3, p4, p, num_segments)
end

function igImBezierCubicClosestPointCasteljau(pOut, p1, p2, p3, p4, p, tess_tol)
    ccall((:igImBezierCubicClosestPointCasteljau, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2, ImVec2, ImVec2, ImVec2, ImVec2, Cfloat), pOut, p1, p2, p3, p4, p, tess_tol)
end

function igImBezierQuadraticCalc(pOut, p1, p2, p3, t)
    ccall((:igImBezierQuadraticCalc, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2, ImVec2, ImVec2, Cfloat), pOut, p1, p2, p3, t)
end

function igImLineClosestPoint(pOut, a, b, p)
    ccall((:igImLineClosestPoint, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2, ImVec2, ImVec2), pOut, a, b, p)
end

function igImTriangleContainsPoint(a, b, c, p)
    ccall((:igImTriangleContainsPoint, libcimgui), Bool, (ImVec2, ImVec2, ImVec2, ImVec2), a, b, c, p)
end

function igImTriangleClosestPoint(pOut, a, b, c, p)
    ccall((:igImTriangleClosestPoint, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2, ImVec2, ImVec2, ImVec2), pOut, a, b, c, p)
end

function igImTriangleBarycentricCoords(a, b, c, p, out_u, out_v, out_w)
    ccall((:igImTriangleBarycentricCoords, libcimgui), Cvoid, (ImVec2, ImVec2, ImVec2, ImVec2, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}), a, b, c, p, out_u, out_v, out_w)
end

function igImTriangleArea(a, b, c)
    ccall((:igImTriangleArea, libcimgui), Cfloat, (ImVec2, ImVec2, ImVec2), a, b, c)
end

function igImTriangleIsClockwise(a, b, c)
    ccall((:igImTriangleIsClockwise, libcimgui), Bool, (ImVec2, ImVec2, ImVec2), a, b, c)
end

function ImVec1_ImVec1_Nil()
    ccall((:ImVec1_ImVec1_Nil, libcimgui), Ptr{ImVec1}, ())
end

function ImVec1_destroy(self)
    ccall((:ImVec1_destroy, libcimgui), Cvoid, (Ptr{ImVec1},), self)
end

function ImVec1_ImVec1_Float(_x)
    ccall((:ImVec1_ImVec1_Float, libcimgui), Ptr{ImVec1}, (Cfloat,), _x)
end

function ImVec2ih_ImVec2ih_Nil()
    ccall((:ImVec2ih_ImVec2ih_Nil, libcimgui), Ptr{ImVec2ih}, ())
end

function ImVec2ih_destroy(self)
    ccall((:ImVec2ih_destroy, libcimgui), Cvoid, (Ptr{ImVec2ih},), self)
end

function ImVec2ih_ImVec2ih_short(_x, _y)
    ccall((:ImVec2ih_ImVec2ih_short, libcimgui), Ptr{ImVec2ih}, (Cshort, Cshort), _x, _y)
end

function ImVec2ih_ImVec2ih_Vec2(rhs)
    ccall((:ImVec2ih_ImVec2ih_Vec2, libcimgui), Ptr{ImVec2ih}, (ImVec2,), rhs)
end

function ImRect_ImRect_Nil()
    ccall((:ImRect_ImRect_Nil, libcimgui), Ptr{ImRect}, ())
end

function ImRect_destroy(self)
    ccall((:ImRect_destroy, libcimgui), Cvoid, (Ptr{ImRect},), self)
end

function ImRect_ImRect_Vec2(min, max)
    ccall((:ImRect_ImRect_Vec2, libcimgui), Ptr{ImRect}, (ImVec2, ImVec2), min, max)
end

function ImRect_ImRect_Vec4(v)
    ccall((:ImRect_ImRect_Vec4, libcimgui), Ptr{ImRect}, (ImVec4,), v)
end

function ImRect_ImRect_Float(x1, y1, x2, y2)
    ccall((:ImRect_ImRect_Float, libcimgui), Ptr{ImRect}, (Cfloat, Cfloat, Cfloat, Cfloat), x1, y1, x2, y2)
end

function ImRect_GetCenter(pOut, self)
    ccall((:ImRect_GetCenter, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImRect}), pOut, self)
end

function ImRect_GetSize(pOut, self)
    ccall((:ImRect_GetSize, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImRect}), pOut, self)
end

function ImRect_GetWidth(self)
    ccall((:ImRect_GetWidth, libcimgui), Cfloat, (Ptr{ImRect},), self)
end

function ImRect_GetHeight(self)
    ccall((:ImRect_GetHeight, libcimgui), Cfloat, (Ptr{ImRect},), self)
end

function ImRect_GetArea(self)
    ccall((:ImRect_GetArea, libcimgui), Cfloat, (Ptr{ImRect},), self)
end

function ImRect_GetTL(pOut, self)
    ccall((:ImRect_GetTL, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImRect}), pOut, self)
end

function ImRect_GetTR(pOut, self)
    ccall((:ImRect_GetTR, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImRect}), pOut, self)
end

function ImRect_GetBL(pOut, self)
    ccall((:ImRect_GetBL, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImRect}), pOut, self)
end

function ImRect_GetBR(pOut, self)
    ccall((:ImRect_GetBR, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImRect}), pOut, self)
end

function ImRect_Contains_Vec2(self, p)
    ccall((:ImRect_Contains_Vec2, libcimgui), Bool, (Ptr{ImRect}, ImVec2), self, p)
end

function ImRect_Contains_Rect(self, r)
    ccall((:ImRect_Contains_Rect, libcimgui), Bool, (Ptr{ImRect}, ImRect), self, r)
end

function ImRect_ContainsWithPad(self, p, pad)
    ccall((:ImRect_ContainsWithPad, libcimgui), Bool, (Ptr{ImRect}, ImVec2, ImVec2), self, p, pad)
end

function ImRect_Overlaps(self, r)
    ccall((:ImRect_Overlaps, libcimgui), Bool, (Ptr{ImRect}, ImRect), self, r)
end

function ImRect_Add_Vec2(self, p)
    ccall((:ImRect_Add_Vec2, libcimgui), Cvoid, (Ptr{ImRect}, ImVec2), self, p)
end

function ImRect_Add_Rect(self, r)
    ccall((:ImRect_Add_Rect, libcimgui), Cvoid, (Ptr{ImRect}, ImRect), self, r)
end

function ImRect_Expand_Float(self, amount)
    ccall((:ImRect_Expand_Float, libcimgui), Cvoid, (Ptr{ImRect}, Cfloat), self, amount)
end

function ImRect_Expand_Vec2(self, amount)
    ccall((:ImRect_Expand_Vec2, libcimgui), Cvoid, (Ptr{ImRect}, ImVec2), self, amount)
end

function ImRect_Translate(self, d)
    ccall((:ImRect_Translate, libcimgui), Cvoid, (Ptr{ImRect}, ImVec2), self, d)
end

function ImRect_TranslateX(self, dx)
    ccall((:ImRect_TranslateX, libcimgui), Cvoid, (Ptr{ImRect}, Cfloat), self, dx)
end

function ImRect_TranslateY(self, dy)
    ccall((:ImRect_TranslateY, libcimgui), Cvoid, (Ptr{ImRect}, Cfloat), self, dy)
end

function ImRect_ClipWith(self, r)
    ccall((:ImRect_ClipWith, libcimgui), Cvoid, (Ptr{ImRect}, ImRect), self, r)
end

function ImRect_ClipWithFull(self, r)
    ccall((:ImRect_ClipWithFull, libcimgui), Cvoid, (Ptr{ImRect}, ImRect), self, r)
end

function ImRect_Floor(self)
    ccall((:ImRect_Floor, libcimgui), Cvoid, (Ptr{ImRect},), self)
end

function ImRect_IsInverted(self)
    ccall((:ImRect_IsInverted, libcimgui), Bool, (Ptr{ImRect},), self)
end

function ImRect_ToVec4(pOut, self)
    ccall((:ImRect_ToVec4, libcimgui), Cvoid, (Ptr{ImVec4}, Ptr{ImRect}), pOut, self)
end

function igImBitArrayGetStorageSizeInBytes(bitcount)
    ccall((:igImBitArrayGetStorageSizeInBytes, libcimgui), Csize_t, (Cint,), bitcount)
end

function igImBitArrayClearAllBits(arr, bitcount)
    ccall((:igImBitArrayClearAllBits, libcimgui), Cvoid, (Ptr{ImU32}, Cint), arr, bitcount)
end

function igImBitArrayTestBit(arr, n)
    ccall((:igImBitArrayTestBit, libcimgui), Bool, (Ptr{ImU32}, Cint), arr, n)
end

function igImBitArrayClearBit(arr, n)
    ccall((:igImBitArrayClearBit, libcimgui), Cvoid, (Ptr{ImU32}, Cint), arr, n)
end

function igImBitArraySetBit(arr, n)
    ccall((:igImBitArraySetBit, libcimgui), Cvoid, (Ptr{ImU32}, Cint), arr, n)
end

function igImBitArraySetBitRange(arr, n, n2)
    ccall((:igImBitArraySetBitRange, libcimgui), Cvoid, (Ptr{ImU32}, Cint, Cint), arr, n, n2)
end

function ImBitVector_Create(self, sz)
    ccall((:ImBitVector_Create, libcimgui), Cvoid, (Ptr{ImBitVector}, Cint), self, sz)
end

function ImBitVector_Clear(self)
    ccall((:ImBitVector_Clear, libcimgui), Cvoid, (Ptr{ImBitVector},), self)
end

function ImBitVector_TestBit(self, n)
    ccall((:ImBitVector_TestBit, libcimgui), Bool, (Ptr{ImBitVector}, Cint), self, n)
end

function ImBitVector_SetBit(self, n)
    ccall((:ImBitVector_SetBit, libcimgui), Cvoid, (Ptr{ImBitVector}, Cint), self, n)
end

function ImBitVector_ClearBit(self, n)
    ccall((:ImBitVector_ClearBit, libcimgui), Cvoid, (Ptr{ImBitVector}, Cint), self, n)
end

function ImGuiTextIndex_clear(self)
    ccall((:ImGuiTextIndex_clear, libcimgui), Cvoid, (Ptr{ImGuiTextIndex},), self)
end

function ImGuiTextIndex_size(self)
    ccall((:ImGuiTextIndex_size, libcimgui), Cint, (Ptr{ImGuiTextIndex},), self)
end

function ImGuiTextIndex_get_line_begin(self, base, n)
    ccall((:ImGuiTextIndex_get_line_begin, libcimgui), Ptr{Cchar}, (Ptr{ImGuiTextIndex}, Ptr{Cchar}, Cint), self, base, n)
end

function ImGuiTextIndex_get_line_end(self, base, n)
    ccall((:ImGuiTextIndex_get_line_end, libcimgui), Ptr{Cchar}, (Ptr{ImGuiTextIndex}, Ptr{Cchar}, Cint), self, base, n)
end

function ImGuiTextIndex_append(self, base, old_size, new_size)
    ccall((:ImGuiTextIndex_append, libcimgui), Cvoid, (Ptr{ImGuiTextIndex}, Ptr{Cchar}, Cint, Cint), self, base, old_size, new_size)
end

function igImLowerBound(in_begin, in_end, key)
    ccall((:igImLowerBound, libcimgui), Ptr{ImGuiStoragePair}, (Ptr{ImGuiStoragePair}, Ptr{ImGuiStoragePair}, ImGuiID), in_begin, in_end, key)
end

function ImDrawListSharedData_ImDrawListSharedData()
    ccall((:ImDrawListSharedData_ImDrawListSharedData, libcimgui), Ptr{ImDrawListSharedData}, ())
end

function ImDrawListSharedData_destroy(self)
    ccall((:ImDrawListSharedData_destroy, libcimgui), Cvoid, (Ptr{ImDrawListSharedData},), self)
end

function ImDrawListSharedData_SetCircleTessellationMaxError(self, max_error)
    ccall((:ImDrawListSharedData_SetCircleTessellationMaxError, libcimgui), Cvoid, (Ptr{ImDrawListSharedData}, Cfloat), self, max_error)
end

function ImDrawDataBuilder_ImDrawDataBuilder()
    ccall((:ImDrawDataBuilder_ImDrawDataBuilder, libcimgui), Ptr{ImDrawDataBuilder}, ())
end

function ImDrawDataBuilder_destroy(self)
    ccall((:ImDrawDataBuilder_destroy, libcimgui), Cvoid, (Ptr{ImDrawDataBuilder},), self)
end

function ImGuiDataVarInfo_GetVarPtr(self, parent)
    ccall((:ImGuiDataVarInfo_GetVarPtr, libcimgui), Ptr{Cvoid}, (Ptr{ImGuiDataVarInfo}, Ptr{Cvoid}), self, parent)
end

function ImGuiStyleMod_ImGuiStyleMod_Int(idx, v)
    ccall((:ImGuiStyleMod_ImGuiStyleMod_Int, libcimgui), Ptr{ImGuiStyleMod}, (ImGuiStyleVar, Cint), idx, v)
end

function ImGuiStyleMod_destroy(self)
    ccall((:ImGuiStyleMod_destroy, libcimgui), Cvoid, (Ptr{ImGuiStyleMod},), self)
end

function ImGuiStyleMod_ImGuiStyleMod_Float(idx, v)
    ccall((:ImGuiStyleMod_ImGuiStyleMod_Float, libcimgui), Ptr{ImGuiStyleMod}, (ImGuiStyleVar, Cfloat), idx, v)
end

function ImGuiStyleMod_ImGuiStyleMod_Vec2(idx, v)
    ccall((:ImGuiStyleMod_ImGuiStyleMod_Vec2, libcimgui), Ptr{ImGuiStyleMod}, (ImGuiStyleVar, ImVec2), idx, v)
end

function ImGuiComboPreviewData_ImGuiComboPreviewData()
    ccall((:ImGuiComboPreviewData_ImGuiComboPreviewData, libcimgui), Ptr{ImGuiComboPreviewData}, ())
end

function ImGuiComboPreviewData_destroy(self)
    ccall((:ImGuiComboPreviewData_destroy, libcimgui), Cvoid, (Ptr{ImGuiComboPreviewData},), self)
end

function ImGuiMenuColumns_ImGuiMenuColumns()
    ccall((:ImGuiMenuColumns_ImGuiMenuColumns, libcimgui), Ptr{ImGuiMenuColumns}, ())
end

function ImGuiMenuColumns_destroy(self)
    ccall((:ImGuiMenuColumns_destroy, libcimgui), Cvoid, (Ptr{ImGuiMenuColumns},), self)
end

function ImGuiMenuColumns_Update(self, spacing, window_reappearing)
    ccall((:ImGuiMenuColumns_Update, libcimgui), Cvoid, (Ptr{ImGuiMenuColumns}, Cfloat, Bool), self, spacing, window_reappearing)
end

function ImGuiMenuColumns_DeclColumns(self, w_icon, w_label, w_shortcut, w_mark)
    ccall((:ImGuiMenuColumns_DeclColumns, libcimgui), Cfloat, (Ptr{ImGuiMenuColumns}, Cfloat, Cfloat, Cfloat, Cfloat), self, w_icon, w_label, w_shortcut, w_mark)
end

function ImGuiMenuColumns_CalcNextTotalWidth(self, update_offsets)
    ccall((:ImGuiMenuColumns_CalcNextTotalWidth, libcimgui), Cvoid, (Ptr{ImGuiMenuColumns}, Bool), self, update_offsets)
end

function ImGuiInputTextDeactivatedState_ImGuiInputTextDeactivatedState()
    ccall((:ImGuiInputTextDeactivatedState_ImGuiInputTextDeactivatedState, libcimgui), Ptr{ImGuiInputTextDeactivatedState}, ())
end

function ImGuiInputTextDeactivatedState_destroy(self)
    ccall((:ImGuiInputTextDeactivatedState_destroy, libcimgui), Cvoid, (Ptr{ImGuiInputTextDeactivatedState},), self)
end

function ImGuiInputTextDeactivatedState_ClearFreeMemory(self)
    ccall((:ImGuiInputTextDeactivatedState_ClearFreeMemory, libcimgui), Cvoid, (Ptr{ImGuiInputTextDeactivatedState},), self)
end

function ImGuiInputTextState_ImGuiInputTextState()
    ccall((:ImGuiInputTextState_ImGuiInputTextState, libcimgui), Ptr{ImGuiInputTextState}, ())
end

function ImGuiInputTextState_destroy(self)
    ccall((:ImGuiInputTextState_destroy, libcimgui), Cvoid, (Ptr{ImGuiInputTextState},), self)
end

function ImGuiInputTextState_ClearText(self)
    ccall((:ImGuiInputTextState_ClearText, libcimgui), Cvoid, (Ptr{ImGuiInputTextState},), self)
end

function ImGuiInputTextState_ClearFreeMemory(self)
    ccall((:ImGuiInputTextState_ClearFreeMemory, libcimgui), Cvoid, (Ptr{ImGuiInputTextState},), self)
end

function ImGuiInputTextState_GetUndoAvailCount(self)
    ccall((:ImGuiInputTextState_GetUndoAvailCount, libcimgui), Cint, (Ptr{ImGuiInputTextState},), self)
end

function ImGuiInputTextState_GetRedoAvailCount(self)
    ccall((:ImGuiInputTextState_GetRedoAvailCount, libcimgui), Cint, (Ptr{ImGuiInputTextState},), self)
end

function ImGuiInputTextState_OnKeyPressed(self, key)
    ccall((:ImGuiInputTextState_OnKeyPressed, libcimgui), Cvoid, (Ptr{ImGuiInputTextState}, Cint), self, key)
end

function ImGuiInputTextState_CursorAnimReset(self)
    ccall((:ImGuiInputTextState_CursorAnimReset, libcimgui), Cvoid, (Ptr{ImGuiInputTextState},), self)
end

function ImGuiInputTextState_CursorClamp(self)
    ccall((:ImGuiInputTextState_CursorClamp, libcimgui), Cvoid, (Ptr{ImGuiInputTextState},), self)
end

function ImGuiInputTextState_HasSelection(self)
    ccall((:ImGuiInputTextState_HasSelection, libcimgui), Bool, (Ptr{ImGuiInputTextState},), self)
end

function ImGuiInputTextState_ClearSelection(self)
    ccall((:ImGuiInputTextState_ClearSelection, libcimgui), Cvoid, (Ptr{ImGuiInputTextState},), self)
end

function ImGuiInputTextState_GetCursorPos(self)
    ccall((:ImGuiInputTextState_GetCursorPos, libcimgui), Cint, (Ptr{ImGuiInputTextState},), self)
end

function ImGuiInputTextState_GetSelectionStart(self)
    ccall((:ImGuiInputTextState_GetSelectionStart, libcimgui), Cint, (Ptr{ImGuiInputTextState},), self)
end

function ImGuiInputTextState_GetSelectionEnd(self)
    ccall((:ImGuiInputTextState_GetSelectionEnd, libcimgui), Cint, (Ptr{ImGuiInputTextState},), self)
end

function ImGuiInputTextState_SelectAll(self)
    ccall((:ImGuiInputTextState_SelectAll, libcimgui), Cvoid, (Ptr{ImGuiInputTextState},), self)
end

function ImGuiInputTextState_ReloadUserBufAndSelectAll(self)
    ccall((:ImGuiInputTextState_ReloadUserBufAndSelectAll, libcimgui), Cvoid, (Ptr{ImGuiInputTextState},), self)
end

function ImGuiInputTextState_ReloadUserBufAndKeepSelection(self)
    ccall((:ImGuiInputTextState_ReloadUserBufAndKeepSelection, libcimgui), Cvoid, (Ptr{ImGuiInputTextState},), self)
end

function ImGuiInputTextState_ReloadUserBufAndMoveToEnd(self)
    ccall((:ImGuiInputTextState_ReloadUserBufAndMoveToEnd, libcimgui), Cvoid, (Ptr{ImGuiInputTextState},), self)
end

function ImGuiNextWindowData_ImGuiNextWindowData()
    ccall((:ImGuiNextWindowData_ImGuiNextWindowData, libcimgui), Ptr{ImGuiNextWindowData}, ())
end

function ImGuiNextWindowData_destroy(self)
    ccall((:ImGuiNextWindowData_destroy, libcimgui), Cvoid, (Ptr{ImGuiNextWindowData},), self)
end

function ImGuiNextWindowData_ClearFlags(self)
    ccall((:ImGuiNextWindowData_ClearFlags, libcimgui), Cvoid, (Ptr{ImGuiNextWindowData},), self)
end

function ImGuiNextItemData_ImGuiNextItemData()
    ccall((:ImGuiNextItemData_ImGuiNextItemData, libcimgui), Ptr{ImGuiNextItemData}, ())
end

function ImGuiNextItemData_destroy(self)
    ccall((:ImGuiNextItemData_destroy, libcimgui), Cvoid, (Ptr{ImGuiNextItemData},), self)
end

function ImGuiNextItemData_ClearFlags(self)
    ccall((:ImGuiNextItemData_ClearFlags, libcimgui), Cvoid, (Ptr{ImGuiNextItemData},), self)
end

function ImGuiLastItemData_ImGuiLastItemData()
    ccall((:ImGuiLastItemData_ImGuiLastItemData, libcimgui), Ptr{ImGuiLastItemData}, ())
end

function ImGuiLastItemData_destroy(self)
    ccall((:ImGuiLastItemData_destroy, libcimgui), Cvoid, (Ptr{ImGuiLastItemData},), self)
end

function ImGuiStackSizes_ImGuiStackSizes()
    ccall((:ImGuiStackSizes_ImGuiStackSizes, libcimgui), Ptr{ImGuiStackSizes}, ())
end

function ImGuiStackSizes_destroy(self)
    ccall((:ImGuiStackSizes_destroy, libcimgui), Cvoid, (Ptr{ImGuiStackSizes},), self)
end

function ImGuiStackSizes_SetToContextState(self, ctx)
    ccall((:ImGuiStackSizes_SetToContextState, libcimgui), Cvoid, (Ptr{ImGuiStackSizes}, Ptr{ImGuiContext}), self, ctx)
end

function ImGuiStackSizes_CompareWithContextState(self, ctx)
    ccall((:ImGuiStackSizes_CompareWithContextState, libcimgui), Cvoid, (Ptr{ImGuiStackSizes}, Ptr{ImGuiContext}), self, ctx)
end

function ImGuiPtrOrIndex_ImGuiPtrOrIndex_Ptr(ptr)
    ccall((:ImGuiPtrOrIndex_ImGuiPtrOrIndex_Ptr, libcimgui), Ptr{ImGuiPtrOrIndex}, (Ptr{Cvoid},), ptr)
end

function ImGuiPtrOrIndex_destroy(self)
    ccall((:ImGuiPtrOrIndex_destroy, libcimgui), Cvoid, (Ptr{ImGuiPtrOrIndex},), self)
end

function ImGuiPtrOrIndex_ImGuiPtrOrIndex_Int(index)
    ccall((:ImGuiPtrOrIndex_ImGuiPtrOrIndex_Int, libcimgui), Ptr{ImGuiPtrOrIndex}, (Cint,), index)
end

function ImGuiPopupData_ImGuiPopupData()
    ccall((:ImGuiPopupData_ImGuiPopupData, libcimgui), Ptr{ImGuiPopupData}, ())
end

function ImGuiPopupData_destroy(self)
    ccall((:ImGuiPopupData_destroy, libcimgui), Cvoid, (Ptr{ImGuiPopupData},), self)
end

function ImGuiInputEvent_ImGuiInputEvent()
    ccall((:ImGuiInputEvent_ImGuiInputEvent, libcimgui), Ptr{ImGuiInputEvent}, ())
end

function ImGuiInputEvent_destroy(self)
    ccall((:ImGuiInputEvent_destroy, libcimgui), Cvoid, (Ptr{ImGuiInputEvent},), self)
end

function ImGuiKeyRoutingData_ImGuiKeyRoutingData()
    ccall((:ImGuiKeyRoutingData_ImGuiKeyRoutingData, libcimgui), Ptr{ImGuiKeyRoutingData}, ())
end

function ImGuiKeyRoutingData_destroy(self)
    ccall((:ImGuiKeyRoutingData_destroy, libcimgui), Cvoid, (Ptr{ImGuiKeyRoutingData},), self)
end

function ImGuiKeyRoutingTable_ImGuiKeyRoutingTable()
    ccall((:ImGuiKeyRoutingTable_ImGuiKeyRoutingTable, libcimgui), Ptr{ImGuiKeyRoutingTable}, ())
end

function ImGuiKeyRoutingTable_destroy(self)
    ccall((:ImGuiKeyRoutingTable_destroy, libcimgui), Cvoid, (Ptr{ImGuiKeyRoutingTable},), self)
end

function ImGuiKeyRoutingTable_Clear(self)
    ccall((:ImGuiKeyRoutingTable_Clear, libcimgui), Cvoid, (Ptr{ImGuiKeyRoutingTable},), self)
end

function ImGuiKeyOwnerData_ImGuiKeyOwnerData()
    ccall((:ImGuiKeyOwnerData_ImGuiKeyOwnerData, libcimgui), Ptr{ImGuiKeyOwnerData}, ())
end

function ImGuiKeyOwnerData_destroy(self)
    ccall((:ImGuiKeyOwnerData_destroy, libcimgui), Cvoid, (Ptr{ImGuiKeyOwnerData},), self)
end

function ImGuiListClipperRange_FromIndices(min, max)
    ccall((:ImGuiListClipperRange_FromIndices, libcimgui), ImGuiListClipperRange, (Cint, Cint), min, max)
end

function ImGuiListClipperRange_FromPositions(y1, y2, off_min, off_max)
    ccall((:ImGuiListClipperRange_FromPositions, libcimgui), ImGuiListClipperRange, (Cfloat, Cfloat, Cint, Cint), y1, y2, off_min, off_max)
end

function ImGuiListClipperData_ImGuiListClipperData()
    ccall((:ImGuiListClipperData_ImGuiListClipperData, libcimgui), Ptr{ImGuiListClipperData}, ())
end

function ImGuiListClipperData_destroy(self)
    ccall((:ImGuiListClipperData_destroy, libcimgui), Cvoid, (Ptr{ImGuiListClipperData},), self)
end

function ImGuiListClipperData_Reset(self, clipper)
    ccall((:ImGuiListClipperData_Reset, libcimgui), Cvoid, (Ptr{ImGuiListClipperData}, Ptr{ImGuiListClipper}), self, clipper)
end

function ImGuiNavItemData_ImGuiNavItemData()
    ccall((:ImGuiNavItemData_ImGuiNavItemData, libcimgui), Ptr{ImGuiNavItemData}, ())
end

function ImGuiNavItemData_destroy(self)
    ccall((:ImGuiNavItemData_destroy, libcimgui), Cvoid, (Ptr{ImGuiNavItemData},), self)
end

function ImGuiNavItemData_Clear(self)
    ccall((:ImGuiNavItemData_Clear, libcimgui), Cvoid, (Ptr{ImGuiNavItemData},), self)
end

function ImGuiTypingSelectState_ImGuiTypingSelectState()
    ccall((:ImGuiTypingSelectState_ImGuiTypingSelectState, libcimgui), Ptr{ImGuiTypingSelectState}, ())
end

function ImGuiTypingSelectState_destroy(self)
    ccall((:ImGuiTypingSelectState_destroy, libcimgui), Cvoid, (Ptr{ImGuiTypingSelectState},), self)
end

function ImGuiTypingSelectState_Clear(self)
    ccall((:ImGuiTypingSelectState_Clear, libcimgui), Cvoid, (Ptr{ImGuiTypingSelectState},), self)
end

function ImGuiOldColumnData_ImGuiOldColumnData()
    ccall((:ImGuiOldColumnData_ImGuiOldColumnData, libcimgui), Ptr{ImGuiOldColumnData}, ())
end

function ImGuiOldColumnData_destroy(self)
    ccall((:ImGuiOldColumnData_destroy, libcimgui), Cvoid, (Ptr{ImGuiOldColumnData},), self)
end

function ImGuiOldColumns_ImGuiOldColumns()
    ccall((:ImGuiOldColumns_ImGuiOldColumns, libcimgui), Ptr{ImGuiOldColumns}, ())
end

function ImGuiOldColumns_destroy(self)
    ccall((:ImGuiOldColumns_destroy, libcimgui), Cvoid, (Ptr{ImGuiOldColumns},), self)
end

function ImGuiBoxSelectState_ImGuiBoxSelectState()
    ccall((:ImGuiBoxSelectState_ImGuiBoxSelectState, libcimgui), Ptr{ImGuiBoxSelectState}, ())
end

function ImGuiBoxSelectState_destroy(self)
    ccall((:ImGuiBoxSelectState_destroy, libcimgui), Cvoid, (Ptr{ImGuiBoxSelectState},), self)
end

function ImGuiMultiSelectTempData_ImGuiMultiSelectTempData()
    ccall((:ImGuiMultiSelectTempData_ImGuiMultiSelectTempData, libcimgui), Ptr{ImGuiMultiSelectTempData}, ())
end

function ImGuiMultiSelectTempData_destroy(self)
    ccall((:ImGuiMultiSelectTempData_destroy, libcimgui), Cvoid, (Ptr{ImGuiMultiSelectTempData},), self)
end

function ImGuiMultiSelectTempData_Clear(self)
    ccall((:ImGuiMultiSelectTempData_Clear, libcimgui), Cvoid, (Ptr{ImGuiMultiSelectTempData},), self)
end

function ImGuiMultiSelectTempData_ClearIO(self)
    ccall((:ImGuiMultiSelectTempData_ClearIO, libcimgui), Cvoid, (Ptr{ImGuiMultiSelectTempData},), self)
end

function ImGuiMultiSelectState_ImGuiMultiSelectState()
    ccall((:ImGuiMultiSelectState_ImGuiMultiSelectState, libcimgui), Ptr{ImGuiMultiSelectState}, ())
end

function ImGuiMultiSelectState_destroy(self)
    ccall((:ImGuiMultiSelectState_destroy, libcimgui), Cvoid, (Ptr{ImGuiMultiSelectState},), self)
end

function ImGuiDockNode_ImGuiDockNode(id)
    ccall((:ImGuiDockNode_ImGuiDockNode, libcimgui), Ptr{ImGuiDockNode}, (ImGuiID,), id)
end

function ImGuiDockNode_destroy(self)
    ccall((:ImGuiDockNode_destroy, libcimgui), Cvoid, (Ptr{ImGuiDockNode},), self)
end

function ImGuiDockNode_IsRootNode(self)
    ccall((:ImGuiDockNode_IsRootNode, libcimgui), Bool, (Ptr{ImGuiDockNode},), self)
end

function ImGuiDockNode_IsDockSpace(self)
    ccall((:ImGuiDockNode_IsDockSpace, libcimgui), Bool, (Ptr{ImGuiDockNode},), self)
end

function ImGuiDockNode_IsFloatingNode(self)
    ccall((:ImGuiDockNode_IsFloatingNode, libcimgui), Bool, (Ptr{ImGuiDockNode},), self)
end

function ImGuiDockNode_IsCentralNode(self)
    ccall((:ImGuiDockNode_IsCentralNode, libcimgui), Bool, (Ptr{ImGuiDockNode},), self)
end

function ImGuiDockNode_IsHiddenTabBar(self)
    ccall((:ImGuiDockNode_IsHiddenTabBar, libcimgui), Bool, (Ptr{ImGuiDockNode},), self)
end

function ImGuiDockNode_IsNoTabBar(self)
    ccall((:ImGuiDockNode_IsNoTabBar, libcimgui), Bool, (Ptr{ImGuiDockNode},), self)
end

function ImGuiDockNode_IsSplitNode(self)
    ccall((:ImGuiDockNode_IsSplitNode, libcimgui), Bool, (Ptr{ImGuiDockNode},), self)
end

function ImGuiDockNode_IsLeafNode(self)
    ccall((:ImGuiDockNode_IsLeafNode, libcimgui), Bool, (Ptr{ImGuiDockNode},), self)
end

function ImGuiDockNode_IsEmpty(self)
    ccall((:ImGuiDockNode_IsEmpty, libcimgui), Bool, (Ptr{ImGuiDockNode},), self)
end

function ImGuiDockNode_Rect(pOut, self)
    ccall((:ImGuiDockNode_Rect, libcimgui), Cvoid, (Ptr{ImRect}, Ptr{ImGuiDockNode}), pOut, self)
end

function ImGuiDockNode_SetLocalFlags(self, flags)
    ccall((:ImGuiDockNode_SetLocalFlags, libcimgui), Cvoid, (Ptr{ImGuiDockNode}, ImGuiDockNodeFlags), self, flags)
end

function ImGuiDockNode_UpdateMergedFlags(self)
    ccall((:ImGuiDockNode_UpdateMergedFlags, libcimgui), Cvoid, (Ptr{ImGuiDockNode},), self)
end

function ImGuiDockContext_ImGuiDockContext()
    ccall((:ImGuiDockContext_ImGuiDockContext, libcimgui), Ptr{ImGuiDockContext}, ())
end

function ImGuiDockContext_destroy(self)
    ccall((:ImGuiDockContext_destroy, libcimgui), Cvoid, (Ptr{ImGuiDockContext},), self)
end

function ImGuiViewportP_ImGuiViewportP()
    ccall((:ImGuiViewportP_ImGuiViewportP, libcimgui), Ptr{ImGuiViewportP}, ())
end

function ImGuiViewportP_destroy(self)
    ccall((:ImGuiViewportP_destroy, libcimgui), Cvoid, (Ptr{ImGuiViewportP},), self)
end

function ImGuiViewportP_ClearRequestFlags(self)
    ccall((:ImGuiViewportP_ClearRequestFlags, libcimgui), Cvoid, (Ptr{ImGuiViewportP},), self)
end

function ImGuiViewportP_CalcWorkRectPos(pOut, self, off_min)
    ccall((:ImGuiViewportP_CalcWorkRectPos, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImGuiViewportP}, ImVec2), pOut, self, off_min)
end

function ImGuiViewportP_CalcWorkRectSize(pOut, self, off_min, off_max)
    ccall((:ImGuiViewportP_CalcWorkRectSize, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImGuiViewportP}, ImVec2, ImVec2), pOut, self, off_min, off_max)
end

function ImGuiViewportP_UpdateWorkRect(self)
    ccall((:ImGuiViewportP_UpdateWorkRect, libcimgui), Cvoid, (Ptr{ImGuiViewportP},), self)
end

function ImGuiViewportP_GetMainRect(pOut, self)
    ccall((:ImGuiViewportP_GetMainRect, libcimgui), Cvoid, (Ptr{ImRect}, Ptr{ImGuiViewportP}), pOut, self)
end

function ImGuiViewportP_GetWorkRect(pOut, self)
    ccall((:ImGuiViewportP_GetWorkRect, libcimgui), Cvoid, (Ptr{ImRect}, Ptr{ImGuiViewportP}), pOut, self)
end

function ImGuiViewportP_GetBuildWorkRect(pOut, self)
    ccall((:ImGuiViewportP_GetBuildWorkRect, libcimgui), Cvoid, (Ptr{ImRect}, Ptr{ImGuiViewportP}), pOut, self)
end

function ImGuiWindowSettings_ImGuiWindowSettings()
    ccall((:ImGuiWindowSettings_ImGuiWindowSettings, libcimgui), Ptr{ImGuiWindowSettings}, ())
end

function ImGuiWindowSettings_destroy(self)
    ccall((:ImGuiWindowSettings_destroy, libcimgui), Cvoid, (Ptr{ImGuiWindowSettings},), self)
end

function ImGuiWindowSettings_GetName(self)
    ccall((:ImGuiWindowSettings_GetName, libcimgui), Ptr{Cchar}, (Ptr{ImGuiWindowSettings},), self)
end

function ImGuiSettingsHandler_ImGuiSettingsHandler()
    ccall((:ImGuiSettingsHandler_ImGuiSettingsHandler, libcimgui), Ptr{ImGuiSettingsHandler}, ())
end

function ImGuiSettingsHandler_destroy(self)
    ccall((:ImGuiSettingsHandler_destroy, libcimgui), Cvoid, (Ptr{ImGuiSettingsHandler},), self)
end

function ImGuiDebugAllocInfo_ImGuiDebugAllocInfo()
    ccall((:ImGuiDebugAllocInfo_ImGuiDebugAllocInfo, libcimgui), Ptr{ImGuiDebugAllocInfo}, ())
end

function ImGuiDebugAllocInfo_destroy(self)
    ccall((:ImGuiDebugAllocInfo_destroy, libcimgui), Cvoid, (Ptr{ImGuiDebugAllocInfo},), self)
end

function ImGuiStackLevelInfo_ImGuiStackLevelInfo()
    ccall((:ImGuiStackLevelInfo_ImGuiStackLevelInfo, libcimgui), Ptr{ImGuiStackLevelInfo}, ())
end

function ImGuiStackLevelInfo_destroy(self)
    ccall((:ImGuiStackLevelInfo_destroy, libcimgui), Cvoid, (Ptr{ImGuiStackLevelInfo},), self)
end

function ImGuiIDStackTool_ImGuiIDStackTool()
    ccall((:ImGuiIDStackTool_ImGuiIDStackTool, libcimgui), Ptr{ImGuiIDStackTool}, ())
end

function ImGuiIDStackTool_destroy(self)
    ccall((:ImGuiIDStackTool_destroy, libcimgui), Cvoid, (Ptr{ImGuiIDStackTool},), self)
end

function ImGuiContextHook_ImGuiContextHook()
    ccall((:ImGuiContextHook_ImGuiContextHook, libcimgui), Ptr{ImGuiContextHook}, ())
end

function ImGuiContextHook_destroy(self)
    ccall((:ImGuiContextHook_destroy, libcimgui), Cvoid, (Ptr{ImGuiContextHook},), self)
end

function ImGuiContext_ImGuiContext(shared_font_atlas)
    ccall((:ImGuiContext_ImGuiContext, libcimgui), Ptr{ImGuiContext}, (Ptr{ImFontAtlas},), shared_font_atlas)
end

function ImGuiContext_destroy(self)
    ccall((:ImGuiContext_destroy, libcimgui), Cvoid, (Ptr{ImGuiContext},), self)
end

function ImGuiWindow_ImGuiWindow(context, name)
    ccall((:ImGuiWindow_ImGuiWindow, libcimgui), Ptr{ImGuiWindow}, (Ptr{ImGuiContext}, Ptr{Cchar}), context, name)
end

function ImGuiWindow_destroy(self)
    ccall((:ImGuiWindow_destroy, libcimgui), Cvoid, (Ptr{ImGuiWindow},), self)
end

function ImGuiWindow_GetID_Str(self, str, str_end)
    ccall((:ImGuiWindow_GetID_Str, libcimgui), ImGuiID, (Ptr{ImGuiWindow}, Ptr{Cchar}, Ptr{Cchar}), self, str, str_end)
end

function ImGuiWindow_GetID_Ptr(self, ptr)
    ccall((:ImGuiWindow_GetID_Ptr, libcimgui), ImGuiID, (Ptr{ImGuiWindow}, Ptr{Cvoid}), self, ptr)
end

function ImGuiWindow_GetID_Int(self, n)
    ccall((:ImGuiWindow_GetID_Int, libcimgui), ImGuiID, (Ptr{ImGuiWindow}, Cint), self, n)
end

function ImGuiWindow_GetIDFromRectangle(self, r_abs)
    ccall((:ImGuiWindow_GetIDFromRectangle, libcimgui), ImGuiID, (Ptr{ImGuiWindow}, ImRect), self, r_abs)
end

function ImGuiWindow_Rect(pOut, self)
    ccall((:ImGuiWindow_Rect, libcimgui), Cvoid, (Ptr{ImRect}, Ptr{ImGuiWindow}), pOut, self)
end

function ImGuiWindow_CalcFontSize(self)
    ccall((:ImGuiWindow_CalcFontSize, libcimgui), Cfloat, (Ptr{ImGuiWindow},), self)
end

function ImGuiWindow_TitleBarRect(pOut, self)
    ccall((:ImGuiWindow_TitleBarRect, libcimgui), Cvoid, (Ptr{ImRect}, Ptr{ImGuiWindow}), pOut, self)
end

function ImGuiWindow_MenuBarRect(pOut, self)
    ccall((:ImGuiWindow_MenuBarRect, libcimgui), Cvoid, (Ptr{ImRect}, Ptr{ImGuiWindow}), pOut, self)
end

function ImGuiTabItem_ImGuiTabItem()
    ccall((:ImGuiTabItem_ImGuiTabItem, libcimgui), Ptr{ImGuiTabItem}, ())
end

function ImGuiTabItem_destroy(self)
    ccall((:ImGuiTabItem_destroy, libcimgui), Cvoid, (Ptr{ImGuiTabItem},), self)
end

function ImGuiTabBar_ImGuiTabBar()
    ccall((:ImGuiTabBar_ImGuiTabBar, libcimgui), Ptr{ImGuiTabBar}, ())
end

function ImGuiTabBar_destroy(self)
    ccall((:ImGuiTabBar_destroy, libcimgui), Cvoid, (Ptr{ImGuiTabBar},), self)
end

function ImGuiTableColumn_ImGuiTableColumn()
    ccall((:ImGuiTableColumn_ImGuiTableColumn, libcimgui), Ptr{ImGuiTableColumn}, ())
end

function ImGuiTableColumn_destroy(self)
    ccall((:ImGuiTableColumn_destroy, libcimgui), Cvoid, (Ptr{ImGuiTableColumn},), self)
end

function ImGuiTableInstanceData_ImGuiTableInstanceData()
    ccall((:ImGuiTableInstanceData_ImGuiTableInstanceData, libcimgui), Ptr{ImGuiTableInstanceData}, ())
end

function ImGuiTableInstanceData_destroy(self)
    ccall((:ImGuiTableInstanceData_destroy, libcimgui), Cvoid, (Ptr{ImGuiTableInstanceData},), self)
end

function ImGuiTable_ImGuiTable()
    ccall((:ImGuiTable_ImGuiTable, libcimgui), Ptr{ImGuiTable}, ())
end

function ImGuiTable_destroy(self)
    ccall((:ImGuiTable_destroy, libcimgui), Cvoid, (Ptr{ImGuiTable},), self)
end

function ImGuiTableTempData_ImGuiTableTempData()
    ccall((:ImGuiTableTempData_ImGuiTableTempData, libcimgui), Ptr{ImGuiTableTempData}, ())
end

function ImGuiTableTempData_destroy(self)
    ccall((:ImGuiTableTempData_destroy, libcimgui), Cvoid, (Ptr{ImGuiTableTempData},), self)
end

function ImGuiTableColumnSettings_ImGuiTableColumnSettings()
    ccall((:ImGuiTableColumnSettings_ImGuiTableColumnSettings, libcimgui), Ptr{ImGuiTableColumnSettings}, ())
end

function ImGuiTableColumnSettings_destroy(self)
    ccall((:ImGuiTableColumnSettings_destroy, libcimgui), Cvoid, (Ptr{ImGuiTableColumnSettings},), self)
end

function ImGuiTableSettings_ImGuiTableSettings()
    ccall((:ImGuiTableSettings_ImGuiTableSettings, libcimgui), Ptr{ImGuiTableSettings}, ())
end

function ImGuiTableSettings_destroy(self)
    ccall((:ImGuiTableSettings_destroy, libcimgui), Cvoid, (Ptr{ImGuiTableSettings},), self)
end

function ImGuiTableSettings_GetColumnSettings(self)
    ccall((:ImGuiTableSettings_GetColumnSettings, libcimgui), Ptr{ImGuiTableColumnSettings}, (Ptr{ImGuiTableSettings},), self)
end

function igGetCurrentWindowRead()
    ccall((:igGetCurrentWindowRead, libcimgui), Ptr{ImGuiWindow}, ())
end

function igGetCurrentWindow()
    ccall((:igGetCurrentWindow, libcimgui), Ptr{ImGuiWindow}, ())
end

function igFindWindowByID(id)
    ccall((:igFindWindowByID, libcimgui), Ptr{ImGuiWindow}, (ImGuiID,), id)
end

function igFindWindowByName(name)
    ccall((:igFindWindowByName, libcimgui), Ptr{ImGuiWindow}, (Ptr{Cchar},), name)
end

function igUpdateWindowParentAndRootLinks(window, flags, parent_window)
    ccall((:igUpdateWindowParentAndRootLinks, libcimgui), Cvoid, (Ptr{ImGuiWindow}, ImGuiWindowFlags, Ptr{ImGuiWindow}), window, flags, parent_window)
end

function igUpdateWindowSkipRefresh(window)
    ccall((:igUpdateWindowSkipRefresh, libcimgui), Cvoid, (Ptr{ImGuiWindow},), window)
end

function igCalcWindowNextAutoFitSize(pOut, window)
    ccall((:igCalcWindowNextAutoFitSize, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImGuiWindow}), pOut, window)
end

function igIsWindowChildOf(window, potential_parent, popup_hierarchy, dock_hierarchy)
    ccall((:igIsWindowChildOf, libcimgui), Bool, (Ptr{ImGuiWindow}, Ptr{ImGuiWindow}, Bool, Bool), window, potential_parent, popup_hierarchy, dock_hierarchy)
end

function igIsWindowWithinBeginStackOf(window, potential_parent)
    ccall((:igIsWindowWithinBeginStackOf, libcimgui), Bool, (Ptr{ImGuiWindow}, Ptr{ImGuiWindow}), window, potential_parent)
end

function igIsWindowAbove(potential_above, potential_below)
    ccall((:igIsWindowAbove, libcimgui), Bool, (Ptr{ImGuiWindow}, Ptr{ImGuiWindow}), potential_above, potential_below)
end

function igIsWindowNavFocusable(window)
    ccall((:igIsWindowNavFocusable, libcimgui), Bool, (Ptr{ImGuiWindow},), window)
end

function igSetWindowPos_WindowPtr(window, pos, cond)
    ccall((:igSetWindowPos_WindowPtr, libcimgui), Cvoid, (Ptr{ImGuiWindow}, ImVec2, ImGuiCond), window, pos, cond)
end

function igSetWindowSize_WindowPtr(window, size, cond)
    ccall((:igSetWindowSize_WindowPtr, libcimgui), Cvoid, (Ptr{ImGuiWindow}, ImVec2, ImGuiCond), window, size, cond)
end

function igSetWindowCollapsed_WindowPtr(window, collapsed, cond)
    ccall((:igSetWindowCollapsed_WindowPtr, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Bool, ImGuiCond), window, collapsed, cond)
end

function igSetWindowHitTestHole(window, pos, size)
    ccall((:igSetWindowHitTestHole, libcimgui), Cvoid, (Ptr{ImGuiWindow}, ImVec2, ImVec2), window, pos, size)
end

function igSetWindowHiddenAndSkipItemsForCurrentFrame(window)
    ccall((:igSetWindowHiddenAndSkipItemsForCurrentFrame, libcimgui), Cvoid, (Ptr{ImGuiWindow},), window)
end

function igSetWindowParentWindowForFocusRoute(window, parent_window)
    ccall((:igSetWindowParentWindowForFocusRoute, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Ptr{ImGuiWindow}), window, parent_window)
end

function igWindowRectAbsToRel(pOut, window, r)
    ccall((:igWindowRectAbsToRel, libcimgui), Cvoid, (Ptr{ImRect}, Ptr{ImGuiWindow}, ImRect), pOut, window, r)
end

function igWindowRectRelToAbs(pOut, window, r)
    ccall((:igWindowRectRelToAbs, libcimgui), Cvoid, (Ptr{ImRect}, Ptr{ImGuiWindow}, ImRect), pOut, window, r)
end

function igWindowPosRelToAbs(pOut, window, p)
    ccall((:igWindowPosRelToAbs, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImGuiWindow}, ImVec2), pOut, window, p)
end

function igWindowPosAbsToRel(pOut, window, p)
    ccall((:igWindowPosAbsToRel, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImGuiWindow}, ImVec2), pOut, window, p)
end

function igFocusWindow(window, flags)
    ccall((:igFocusWindow, libcimgui), Cvoid, (Ptr{ImGuiWindow}, ImGuiFocusRequestFlags), window, flags)
end

function igFocusTopMostWindowUnderOne(under_this_window, ignore_window, filter_viewport, flags)
    ccall((:igFocusTopMostWindowUnderOne, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Ptr{ImGuiWindow}, Ptr{ImGuiViewport}, ImGuiFocusRequestFlags), under_this_window, ignore_window, filter_viewport, flags)
end

function igBringWindowToFocusFront(window)
    ccall((:igBringWindowToFocusFront, libcimgui), Cvoid, (Ptr{ImGuiWindow},), window)
end

function igBringWindowToDisplayFront(window)
    ccall((:igBringWindowToDisplayFront, libcimgui), Cvoid, (Ptr{ImGuiWindow},), window)
end

function igBringWindowToDisplayBack(window)
    ccall((:igBringWindowToDisplayBack, libcimgui), Cvoid, (Ptr{ImGuiWindow},), window)
end

function igBringWindowToDisplayBehind(window, above_window)
    ccall((:igBringWindowToDisplayBehind, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Ptr{ImGuiWindow}), window, above_window)
end

function igFindWindowDisplayIndex(window)
    ccall((:igFindWindowDisplayIndex, libcimgui), Cint, (Ptr{ImGuiWindow},), window)
end

function igFindBottomMostVisibleWindowWithinBeginStack(window)
    ccall((:igFindBottomMostVisibleWindowWithinBeginStack, libcimgui), Ptr{ImGuiWindow}, (Ptr{ImGuiWindow},), window)
end

function igSetNextWindowRefreshPolicy(flags)
    ccall((:igSetNextWindowRefreshPolicy, libcimgui), Cvoid, (ImGuiWindowRefreshFlags,), flags)
end

function igSetCurrentFont(font)
    ccall((:igSetCurrentFont, libcimgui), Cvoid, (Ptr{ImFont},), font)
end

function igGetDefaultFont()
    ccall((:igGetDefaultFont, libcimgui), Ptr{ImFont}, ())
end

function igGetForegroundDrawList_WindowPtr(window)
    ccall((:igGetForegroundDrawList_WindowPtr, libcimgui), Ptr{ImDrawList}, (Ptr{ImGuiWindow},), window)
end

function igAddDrawListToDrawDataEx(draw_data, out_list, draw_list)
    ccall((:igAddDrawListToDrawDataEx, libcimgui), Cvoid, (Ptr{ImDrawData}, Ptr{ImVector_ImDrawListPtr}, Ptr{ImDrawList}), draw_data, out_list, draw_list)
end

function igInitialize()
    ccall((:igInitialize, libcimgui), Cvoid, ())
end

function igShutdown()
    ccall((:igShutdown, libcimgui), Cvoid, ())
end

function igUpdateInputEvents(trickle_fast_inputs)
    ccall((:igUpdateInputEvents, libcimgui), Cvoid, (Bool,), trickle_fast_inputs)
end

function igUpdateHoveredWindowAndCaptureFlags()
    ccall((:igUpdateHoveredWindowAndCaptureFlags, libcimgui), Cvoid, ())
end

function igFindHoveredWindowEx(pos, find_first_and_in_any_viewport, out_hovered_window, out_hovered_window_under_moving_window)
    ccall((:igFindHoveredWindowEx, libcimgui), Cvoid, (ImVec2, Bool, Ptr{Ptr{ImGuiWindow}}, Ptr{Ptr{ImGuiWindow}}), pos, find_first_and_in_any_viewport, out_hovered_window, out_hovered_window_under_moving_window)
end

function igStartMouseMovingWindow(window)
    ccall((:igStartMouseMovingWindow, libcimgui), Cvoid, (Ptr{ImGuiWindow},), window)
end

function igStartMouseMovingWindowOrNode(window, node, undock)
    ccall((:igStartMouseMovingWindowOrNode, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Ptr{ImGuiDockNode}, Bool), window, node, undock)
end

function igUpdateMouseMovingWindowNewFrame()
    ccall((:igUpdateMouseMovingWindowNewFrame, libcimgui), Cvoid, ())
end

function igUpdateMouseMovingWindowEndFrame()
    ccall((:igUpdateMouseMovingWindowEndFrame, libcimgui), Cvoid, ())
end

function igAddContextHook(context, hook)
    ccall((:igAddContextHook, libcimgui), ImGuiID, (Ptr{ImGuiContext}, Ptr{ImGuiContextHook}), context, hook)
end

function igRemoveContextHook(context, hook_to_remove)
    ccall((:igRemoveContextHook, libcimgui), Cvoid, (Ptr{ImGuiContext}, ImGuiID), context, hook_to_remove)
end

function igCallContextHooks(context, type)
    ccall((:igCallContextHooks, libcimgui), Cvoid, (Ptr{ImGuiContext}, ImGuiContextHookType), context, type)
end

function igTranslateWindowsInViewport(viewport, old_pos, new_pos)
    ccall((:igTranslateWindowsInViewport, libcimgui), Cvoid, (Ptr{ImGuiViewportP}, ImVec2, ImVec2), viewport, old_pos, new_pos)
end

function igScaleWindowsInViewport(viewport, scale)
    ccall((:igScaleWindowsInViewport, libcimgui), Cvoid, (Ptr{ImGuiViewportP}, Cfloat), viewport, scale)
end

function igDestroyPlatformWindow(viewport)
    ccall((:igDestroyPlatformWindow, libcimgui), Cvoid, (Ptr{ImGuiViewportP},), viewport)
end

function igSetWindowViewport(window, viewport)
    ccall((:igSetWindowViewport, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Ptr{ImGuiViewportP}), window, viewport)
end

function igSetCurrentViewport(window, viewport)
    ccall((:igSetCurrentViewport, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Ptr{ImGuiViewportP}), window, viewport)
end

function igGetViewportPlatformMonitor(viewport)
    ccall((:igGetViewportPlatformMonitor, libcimgui), Ptr{ImGuiPlatformMonitor}, (Ptr{ImGuiViewport},), viewport)
end

function igFindHoveredViewportFromPlatformWindowStack(mouse_platform_pos)
    ccall((:igFindHoveredViewportFromPlatformWindowStack, libcimgui), Ptr{ImGuiViewportP}, (ImVec2,), mouse_platform_pos)
end

function igMarkIniSettingsDirty_Nil()
    ccall((:igMarkIniSettingsDirty_Nil, libcimgui), Cvoid, ())
end

function igMarkIniSettingsDirty_WindowPtr(window)
    ccall((:igMarkIniSettingsDirty_WindowPtr, libcimgui), Cvoid, (Ptr{ImGuiWindow},), window)
end

function igClearIniSettings()
    ccall((:igClearIniSettings, libcimgui), Cvoid, ())
end

function igAddSettingsHandler(handler)
    ccall((:igAddSettingsHandler, libcimgui), Cvoid, (Ptr{ImGuiSettingsHandler},), handler)
end

function igRemoveSettingsHandler(type_name)
    ccall((:igRemoveSettingsHandler, libcimgui), Cvoid, (Ptr{Cchar},), type_name)
end

function igFindSettingsHandler(type_name)
    ccall((:igFindSettingsHandler, libcimgui), Ptr{ImGuiSettingsHandler}, (Ptr{Cchar},), type_name)
end

function igCreateNewWindowSettings(name)
    ccall((:igCreateNewWindowSettings, libcimgui), Ptr{ImGuiWindowSettings}, (Ptr{Cchar},), name)
end

function igFindWindowSettingsByID(id)
    ccall((:igFindWindowSettingsByID, libcimgui), Ptr{ImGuiWindowSettings}, (ImGuiID,), id)
end

function igFindWindowSettingsByWindow(window)
    ccall((:igFindWindowSettingsByWindow, libcimgui), Ptr{ImGuiWindowSettings}, (Ptr{ImGuiWindow},), window)
end

function igClearWindowSettings(name)
    ccall((:igClearWindowSettings, libcimgui), Cvoid, (Ptr{Cchar},), name)
end

function igLocalizeRegisterEntries(entries, count)
    ccall((:igLocalizeRegisterEntries, libcimgui), Cvoid, (Ptr{ImGuiLocEntry}, Cint), entries, count)
end

function igLocalizeGetMsg(key)
    ccall((:igLocalizeGetMsg, libcimgui), Ptr{Cchar}, (ImGuiLocKey,), key)
end

function igSetScrollX_WindowPtr(window, scroll_x)
    ccall((:igSetScrollX_WindowPtr, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Cfloat), window, scroll_x)
end

function igSetScrollY_WindowPtr(window, scroll_y)
    ccall((:igSetScrollY_WindowPtr, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Cfloat), window, scroll_y)
end

function igSetScrollFromPosX_WindowPtr(window, local_x, center_x_ratio)
    ccall((:igSetScrollFromPosX_WindowPtr, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Cfloat, Cfloat), window, local_x, center_x_ratio)
end

function igSetScrollFromPosY_WindowPtr(window, local_y, center_y_ratio)
    ccall((:igSetScrollFromPosY_WindowPtr, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Cfloat, Cfloat), window, local_y, center_y_ratio)
end

function igScrollToItem(flags)
    ccall((:igScrollToItem, libcimgui), Cvoid, (ImGuiScrollFlags,), flags)
end

function igScrollToRect(window, rect, flags)
    ccall((:igScrollToRect, libcimgui), Cvoid, (Ptr{ImGuiWindow}, ImRect, ImGuiScrollFlags), window, rect, flags)
end

function igScrollToRectEx(pOut, window, rect, flags)
    ccall((:igScrollToRectEx, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImGuiWindow}, ImRect, ImGuiScrollFlags), pOut, window, rect, flags)
end

function igScrollToBringRectIntoView(window, rect)
    ccall((:igScrollToBringRectIntoView, libcimgui), Cvoid, (Ptr{ImGuiWindow}, ImRect), window, rect)
end

function igGetItemStatusFlags()
    ccall((:igGetItemStatusFlags, libcimgui), ImGuiItemStatusFlags, ())
end

function igGetItemFlags()
    ccall((:igGetItemFlags, libcimgui), ImGuiItemFlags, ())
end

function igGetActiveID()
    ccall((:igGetActiveID, libcimgui), ImGuiID, ())
end

function igGetFocusID()
    ccall((:igGetFocusID, libcimgui), ImGuiID, ())
end

function igSetActiveID(id, window)
    ccall((:igSetActiveID, libcimgui), Cvoid, (ImGuiID, Ptr{ImGuiWindow}), id, window)
end

function igSetFocusID(id, window)
    ccall((:igSetFocusID, libcimgui), Cvoid, (ImGuiID, Ptr{ImGuiWindow}), id, window)
end

function igClearActiveID()
    ccall((:igClearActiveID, libcimgui), Cvoid, ())
end

function igGetHoveredID()
    ccall((:igGetHoveredID, libcimgui), ImGuiID, ())
end

function igSetHoveredID(id)
    ccall((:igSetHoveredID, libcimgui), Cvoid, (ImGuiID,), id)
end

function igKeepAliveID(id)
    ccall((:igKeepAliveID, libcimgui), Cvoid, (ImGuiID,), id)
end

function igMarkItemEdited(id)
    ccall((:igMarkItemEdited, libcimgui), Cvoid, (ImGuiID,), id)
end

function igPushOverrideID(id)
    ccall((:igPushOverrideID, libcimgui), Cvoid, (ImGuiID,), id)
end

function igGetIDWithSeed_Str(str_id_begin, str_id_end, seed)
    ccall((:igGetIDWithSeed_Str, libcimgui), ImGuiID, (Ptr{Cchar}, Ptr{Cchar}, ImGuiID), str_id_begin, str_id_end, seed)
end

function igGetIDWithSeed_Int(n, seed)
    ccall((:igGetIDWithSeed_Int, libcimgui), ImGuiID, (Cint, ImGuiID), n, seed)
end

function igItemSize_Vec2(size, text_baseline_y)
    ccall((:igItemSize_Vec2, libcimgui), Cvoid, (ImVec2, Cfloat), size, text_baseline_y)
end

function igItemSize_Rect(bb, text_baseline_y)
    ccall((:igItemSize_Rect, libcimgui), Cvoid, (ImRect, Cfloat), bb, text_baseline_y)
end

function igItemAdd(bb, id, nav_bb, extra_flags)
    ccall((:igItemAdd, libcimgui), Bool, (ImRect, ImGuiID, Ptr{ImRect}, ImGuiItemFlags), bb, id, nav_bb, extra_flags)
end

function igItemHoverable(bb, id, item_flags)
    ccall((:igItemHoverable, libcimgui), Bool, (ImRect, ImGuiID, ImGuiItemFlags), bb, id, item_flags)
end

function igIsWindowContentHoverable(window, flags)
    ccall((:igIsWindowContentHoverable, libcimgui), Bool, (Ptr{ImGuiWindow}, ImGuiHoveredFlags), window, flags)
end

function igIsClippedEx(bb, id)
    ccall((:igIsClippedEx, libcimgui), Bool, (ImRect, ImGuiID), bb, id)
end

function igSetLastItemData(item_id, in_flags, status_flags, item_rect)
    ccall((:igSetLastItemData, libcimgui), Cvoid, (ImGuiID, ImGuiItemFlags, ImGuiItemStatusFlags, ImRect), item_id, in_flags, status_flags, item_rect)
end

function igCalcItemSize(pOut, size, default_w, default_h)
    ccall((:igCalcItemSize, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2, Cfloat, Cfloat), pOut, size, default_w, default_h)
end

function igCalcWrapWidthForPos(pos, wrap_pos_x)
    ccall((:igCalcWrapWidthForPos, libcimgui), Cfloat, (ImVec2, Cfloat), pos, wrap_pos_x)
end

function igPushMultiItemsWidths(components, width_full)
    ccall((:igPushMultiItemsWidths, libcimgui), Cvoid, (Cint, Cfloat), components, width_full)
end

function igShrinkWidths(items, count, width_excess)
    ccall((:igShrinkWidths, libcimgui), Cvoid, (Ptr{ImGuiShrinkWidthItem}, Cint, Cfloat), items, count, width_excess)
end

function igGetStyleVarInfo(idx)
    ccall((:igGetStyleVarInfo, libcimgui), Ptr{ImGuiDataVarInfo}, (ImGuiStyleVar,), idx)
end

function igBeginDisabledOverrideReenable()
    ccall((:igBeginDisabledOverrideReenable, libcimgui), Cvoid, ())
end

function igEndDisabledOverrideReenable()
    ccall((:igEndDisabledOverrideReenable, libcimgui), Cvoid, ())
end

function igLogBegin(type, auto_open_depth)
    ccall((:igLogBegin, libcimgui), Cvoid, (ImGuiLogType, Cint), type, auto_open_depth)
end

function igLogToBuffer(auto_open_depth)
    ccall((:igLogToBuffer, libcimgui), Cvoid, (Cint,), auto_open_depth)
end

function igLogRenderedText(ref_pos, text, text_end)
    ccall((:igLogRenderedText, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{Cchar}, Ptr{Cchar}), ref_pos, text, text_end)
end

function igLogSetNextTextDecoration(prefix, suffix)
    ccall((:igLogSetNextTextDecoration, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cchar}), prefix, suffix)
end

function igBeginChildEx(name, id, size_arg, child_flags, window_flags)
    ccall((:igBeginChildEx, libcimgui), Bool, (Ptr{Cchar}, ImGuiID, ImVec2, ImGuiChildFlags, ImGuiWindowFlags), name, id, size_arg, child_flags, window_flags)
end

function igBeginPopupEx(id, extra_window_flags)
    ccall((:igBeginPopupEx, libcimgui), Bool, (ImGuiID, ImGuiWindowFlags), id, extra_window_flags)
end

function igOpenPopupEx(id, popup_flags)
    ccall((:igOpenPopupEx, libcimgui), Cvoid, (ImGuiID, ImGuiPopupFlags), id, popup_flags)
end

function igClosePopupToLevel(remaining, restore_focus_to_window_under_popup)
    ccall((:igClosePopupToLevel, libcimgui), Cvoid, (Cint, Bool), remaining, restore_focus_to_window_under_popup)
end

function igClosePopupsOverWindow(ref_window, restore_focus_to_window_under_popup)
    ccall((:igClosePopupsOverWindow, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Bool), ref_window, restore_focus_to_window_under_popup)
end

function igClosePopupsExceptModals()
    ccall((:igClosePopupsExceptModals, libcimgui), Cvoid, ())
end

function igIsPopupOpen_ID(id, popup_flags)
    ccall((:igIsPopupOpen_ID, libcimgui), Bool, (ImGuiID, ImGuiPopupFlags), id, popup_flags)
end

function igGetPopupAllowedExtentRect(pOut, window)
    ccall((:igGetPopupAllowedExtentRect, libcimgui), Cvoid, (Ptr{ImRect}, Ptr{ImGuiWindow}), pOut, window)
end

function igGetTopMostPopupModal()
    ccall((:igGetTopMostPopupModal, libcimgui), Ptr{ImGuiWindow}, ())
end

function igGetTopMostAndVisiblePopupModal()
    ccall((:igGetTopMostAndVisiblePopupModal, libcimgui), Ptr{ImGuiWindow}, ())
end

function igFindBlockingModal(window)
    ccall((:igFindBlockingModal, libcimgui), Ptr{ImGuiWindow}, (Ptr{ImGuiWindow},), window)
end

function igFindBestWindowPosForPopup(pOut, window)
    ccall((:igFindBestWindowPosForPopup, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImGuiWindow}), pOut, window)
end

function igFindBestWindowPosForPopupEx(pOut, ref_pos, size, last_dir, r_outer, r_avoid, policy)
    ccall((:igFindBestWindowPosForPopupEx, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2, ImVec2, Ptr{ImGuiDir}, ImRect, ImRect, ImGuiPopupPositionPolicy), pOut, ref_pos, size, last_dir, r_outer, r_avoid, policy)
end

function igBeginTooltipEx(tooltip_flags, extra_window_flags)
    ccall((:igBeginTooltipEx, libcimgui), Bool, (ImGuiTooltipFlags, ImGuiWindowFlags), tooltip_flags, extra_window_flags)
end

function igBeginTooltipHidden()
    ccall((:igBeginTooltipHidden, libcimgui), Bool, ())
end

function igBeginViewportSideBar(name, viewport, dir, size, window_flags)
    ccall((:igBeginViewportSideBar, libcimgui), Bool, (Ptr{Cchar}, Ptr{ImGuiViewport}, ImGuiDir, Cfloat, ImGuiWindowFlags), name, viewport, dir, size, window_flags)
end

function igBeginMenuEx(label, icon, enabled)
    ccall((:igBeginMenuEx, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cchar}, Bool), label, icon, enabled)
end

function igMenuItemEx(label, icon, shortcut, selected, enabled)
    ccall((:igMenuItemEx, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cchar}, Ptr{Cchar}, Bool, Bool), label, icon, shortcut, selected, enabled)
end

function igBeginComboPopup(popup_id, bb, flags)
    ccall((:igBeginComboPopup, libcimgui), Bool, (ImGuiID, ImRect, ImGuiComboFlags), popup_id, bb, flags)
end

function igBeginComboPreview()
    ccall((:igBeginComboPreview, libcimgui), Bool, ())
end

function igEndComboPreview()
    ccall((:igEndComboPreview, libcimgui), Cvoid, ())
end

function igNavInitWindow(window, force_reinit)
    ccall((:igNavInitWindow, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Bool), window, force_reinit)
end

function igNavInitRequestApplyResult()
    ccall((:igNavInitRequestApplyResult, libcimgui), Cvoid, ())
end

function igNavMoveRequestButNoResultYet()
    ccall((:igNavMoveRequestButNoResultYet, libcimgui), Bool, ())
end

function igNavMoveRequestSubmit(move_dir, clip_dir, move_flags, scroll_flags)
    ccall((:igNavMoveRequestSubmit, libcimgui), Cvoid, (ImGuiDir, ImGuiDir, ImGuiNavMoveFlags, ImGuiScrollFlags), move_dir, clip_dir, move_flags, scroll_flags)
end

function igNavMoveRequestForward(move_dir, clip_dir, move_flags, scroll_flags)
    ccall((:igNavMoveRequestForward, libcimgui), Cvoid, (ImGuiDir, ImGuiDir, ImGuiNavMoveFlags, ImGuiScrollFlags), move_dir, clip_dir, move_flags, scroll_flags)
end

function igNavMoveRequestResolveWithLastItem(result)
    ccall((:igNavMoveRequestResolveWithLastItem, libcimgui), Cvoid, (Ptr{ImGuiNavItemData},), result)
end

function igNavMoveRequestResolveWithPastTreeNode(result, tree_node_data)
    ccall((:igNavMoveRequestResolveWithPastTreeNode, libcimgui), Cvoid, (Ptr{ImGuiNavItemData}, Ptr{ImGuiTreeNodeStackData}), result, tree_node_data)
end

function igNavMoveRequestCancel()
    ccall((:igNavMoveRequestCancel, libcimgui), Cvoid, ())
end

function igNavMoveRequestApplyResult()
    ccall((:igNavMoveRequestApplyResult, libcimgui), Cvoid, ())
end

function igNavMoveRequestTryWrapping(window, move_flags)
    ccall((:igNavMoveRequestTryWrapping, libcimgui), Cvoid, (Ptr{ImGuiWindow}, ImGuiNavMoveFlags), window, move_flags)
end

function igNavHighlightActivated(id)
    ccall((:igNavHighlightActivated, libcimgui), Cvoid, (ImGuiID,), id)
end

function igNavClearPreferredPosForAxis(axis)
    ccall((:igNavClearPreferredPosForAxis, libcimgui), Cvoid, (ImGuiAxis,), axis)
end

function igNavRestoreHighlightAfterMove()
    ccall((:igNavRestoreHighlightAfterMove, libcimgui), Cvoid, ())
end

function igNavUpdateCurrentWindowIsScrollPushableX()
    ccall((:igNavUpdateCurrentWindowIsScrollPushableX, libcimgui), Cvoid, ())
end

function igSetNavWindow(window)
    ccall((:igSetNavWindow, libcimgui), Cvoid, (Ptr{ImGuiWindow},), window)
end

function igSetNavID(id, nav_layer, focus_scope_id, rect_rel)
    ccall((:igSetNavID, libcimgui), Cvoid, (ImGuiID, ImGuiNavLayer, ImGuiID, ImRect), id, nav_layer, focus_scope_id, rect_rel)
end

function igSetNavFocusScope(focus_scope_id)
    ccall((:igSetNavFocusScope, libcimgui), Cvoid, (ImGuiID,), focus_scope_id)
end

function igFocusItem()
    ccall((:igFocusItem, libcimgui), Cvoid, ())
end

function igActivateItemByID(id)
    ccall((:igActivateItemByID, libcimgui), Cvoid, (ImGuiID,), id)
end

function igIsNamedKey(key)
    ccall((:igIsNamedKey, libcimgui), Bool, (ImGuiKey,), key)
end

function igIsNamedKeyOrMod(key)
    ccall((:igIsNamedKeyOrMod, libcimgui), Bool, (ImGuiKey,), key)
end

function igIsLegacyKey(key)
    ccall((:igIsLegacyKey, libcimgui), Bool, (ImGuiKey,), key)
end

function igIsKeyboardKey(key)
    ccall((:igIsKeyboardKey, libcimgui), Bool, (ImGuiKey,), key)
end

function igIsGamepadKey(key)
    ccall((:igIsGamepadKey, libcimgui), Bool, (ImGuiKey,), key)
end

function igIsMouseKey(key)
    ccall((:igIsMouseKey, libcimgui), Bool, (ImGuiKey,), key)
end

function igIsAliasKey(key)
    ccall((:igIsAliasKey, libcimgui), Bool, (ImGuiKey,), key)
end

function igIsModKey(key)
    ccall((:igIsModKey, libcimgui), Bool, (ImGuiKey,), key)
end

function igFixupKeyChord(key_chord)
    ccall((:igFixupKeyChord, libcimgui), ImGuiKeyChord, (ImGuiKeyChord,), key_chord)
end

function igConvertSingleModFlagToKey(key)
    ccall((:igConvertSingleModFlagToKey, libcimgui), ImGuiKey, (ImGuiKey,), key)
end

function igGetKeyData_ContextPtr(ctx, key)
    ccall((:igGetKeyData_ContextPtr, libcimgui), Ptr{ImGuiKeyData}, (Ptr{ImGuiContext}, ImGuiKey), ctx, key)
end

function igGetKeyData_Key(key)
    ccall((:igGetKeyData_Key, libcimgui), Ptr{ImGuiKeyData}, (ImGuiKey,), key)
end

function igGetKeyChordName(key_chord)
    ccall((:igGetKeyChordName, libcimgui), Ptr{Cchar}, (ImGuiKeyChord,), key_chord)
end

function igMouseButtonToKey(button)
    ccall((:igMouseButtonToKey, libcimgui), ImGuiKey, (ImGuiMouseButton,), button)
end

function igIsMouseDragPastThreshold(button, lock_threshold)
    ccall((:igIsMouseDragPastThreshold, libcimgui), Bool, (ImGuiMouseButton, Cfloat), button, lock_threshold)
end

function igGetKeyMagnitude2d(pOut, key_left, key_right, key_up, key_down)
    ccall((:igGetKeyMagnitude2d, libcimgui), Cvoid, (Ptr{ImVec2}, ImGuiKey, ImGuiKey, ImGuiKey, ImGuiKey), pOut, key_left, key_right, key_up, key_down)
end

function igGetNavTweakPressedAmount(axis)
    ccall((:igGetNavTweakPressedAmount, libcimgui), Cfloat, (ImGuiAxis,), axis)
end

function igCalcTypematicRepeatAmount(t0, t1, repeat_delay, repeat_rate)
    ccall((:igCalcTypematicRepeatAmount, libcimgui), Cint, (Cfloat, Cfloat, Cfloat, Cfloat), t0, t1, repeat_delay, repeat_rate)
end

function igGetTypematicRepeatRate(flags, repeat_delay, repeat_rate)
    ccall((:igGetTypematicRepeatRate, libcimgui), Cvoid, (ImGuiInputFlags, Ptr{Cfloat}, Ptr{Cfloat}), flags, repeat_delay, repeat_rate)
end

function igTeleportMousePos(pos)
    ccall((:igTeleportMousePos, libcimgui), Cvoid, (ImVec2,), pos)
end

function igSetActiveIdUsingAllKeyboardKeys()
    ccall((:igSetActiveIdUsingAllKeyboardKeys, libcimgui), Cvoid, ())
end

function igIsActiveIdUsingNavDir(dir)
    ccall((:igIsActiveIdUsingNavDir, libcimgui), Bool, (ImGuiDir,), dir)
end

function igGetKeyOwner(key)
    ccall((:igGetKeyOwner, libcimgui), ImGuiID, (ImGuiKey,), key)
end

function igSetKeyOwner(key, owner_id, flags)
    ccall((:igSetKeyOwner, libcimgui), Cvoid, (ImGuiKey, ImGuiID, ImGuiInputFlags), key, owner_id, flags)
end

function igSetKeyOwnersForKeyChord(key, owner_id, flags)
    ccall((:igSetKeyOwnersForKeyChord, libcimgui), Cvoid, (ImGuiKeyChord, ImGuiID, ImGuiInputFlags), key, owner_id, flags)
end

function igSetItemKeyOwner_InputFlags(key, flags)
    ccall((:igSetItemKeyOwner_InputFlags, libcimgui), Cvoid, (ImGuiKey, ImGuiInputFlags), key, flags)
end

function igTestKeyOwner(key, owner_id)
    ccall((:igTestKeyOwner, libcimgui), Bool, (ImGuiKey, ImGuiID), key, owner_id)
end

function igGetKeyOwnerData(ctx, key)
    ccall((:igGetKeyOwnerData, libcimgui), Ptr{ImGuiKeyOwnerData}, (Ptr{ImGuiContext}, ImGuiKey), ctx, key)
end

function igIsKeyDown_ID(key, owner_id)
    ccall((:igIsKeyDown_ID, libcimgui), Bool, (ImGuiKey, ImGuiID), key, owner_id)
end

function igIsKeyPressed_InputFlags(key, flags, owner_id)
    ccall((:igIsKeyPressed_InputFlags, libcimgui), Bool, (ImGuiKey, ImGuiInputFlags, ImGuiID), key, flags, owner_id)
end

function igIsKeyReleased_ID(key, owner_id)
    ccall((:igIsKeyReleased_ID, libcimgui), Bool, (ImGuiKey, ImGuiID), key, owner_id)
end

function igIsKeyChordPressed_InputFlags(key_chord, flags, owner_id)
    ccall((:igIsKeyChordPressed_InputFlags, libcimgui), Bool, (ImGuiKeyChord, ImGuiInputFlags, ImGuiID), key_chord, flags, owner_id)
end

function igIsMouseDown_ID(button, owner_id)
    ccall((:igIsMouseDown_ID, libcimgui), Bool, (ImGuiMouseButton, ImGuiID), button, owner_id)
end

function igIsMouseClicked_InputFlags(button, flags, owner_id)
    ccall((:igIsMouseClicked_InputFlags, libcimgui), Bool, (ImGuiMouseButton, ImGuiInputFlags, ImGuiID), button, flags, owner_id)
end

function igIsMouseReleased_ID(button, owner_id)
    ccall((:igIsMouseReleased_ID, libcimgui), Bool, (ImGuiMouseButton, ImGuiID), button, owner_id)
end

function igIsMouseDoubleClicked_ID(button, owner_id)
    ccall((:igIsMouseDoubleClicked_ID, libcimgui), Bool, (ImGuiMouseButton, ImGuiID), button, owner_id)
end

function igShortcut_ID(key_chord, flags, owner_id)
    ccall((:igShortcut_ID, libcimgui), Bool, (ImGuiKeyChord, ImGuiInputFlags, ImGuiID), key_chord, flags, owner_id)
end

function igSetShortcutRouting(key_chord, flags, owner_id)
    ccall((:igSetShortcutRouting, libcimgui), Bool, (ImGuiKeyChord, ImGuiInputFlags, ImGuiID), key_chord, flags, owner_id)
end

function igTestShortcutRouting(key_chord, owner_id)
    ccall((:igTestShortcutRouting, libcimgui), Bool, (ImGuiKeyChord, ImGuiID), key_chord, owner_id)
end

function igGetShortcutRoutingData(key_chord)
    ccall((:igGetShortcutRoutingData, libcimgui), Ptr{ImGuiKeyRoutingData}, (ImGuiKeyChord,), key_chord)
end

function igDockContextInitialize(ctx)
    ccall((:igDockContextInitialize, libcimgui), Cvoid, (Ptr{ImGuiContext},), ctx)
end

function igDockContextShutdown(ctx)
    ccall((:igDockContextShutdown, libcimgui), Cvoid, (Ptr{ImGuiContext},), ctx)
end

function igDockContextClearNodes(ctx, root_id, clear_settings_refs)
    ccall((:igDockContextClearNodes, libcimgui), Cvoid, (Ptr{ImGuiContext}, ImGuiID, Bool), ctx, root_id, clear_settings_refs)
end

function igDockContextRebuildNodes(ctx)
    ccall((:igDockContextRebuildNodes, libcimgui), Cvoid, (Ptr{ImGuiContext},), ctx)
end

function igDockContextNewFrameUpdateUndocking(ctx)
    ccall((:igDockContextNewFrameUpdateUndocking, libcimgui), Cvoid, (Ptr{ImGuiContext},), ctx)
end

function igDockContextNewFrameUpdateDocking(ctx)
    ccall((:igDockContextNewFrameUpdateDocking, libcimgui), Cvoid, (Ptr{ImGuiContext},), ctx)
end

function igDockContextEndFrame(ctx)
    ccall((:igDockContextEndFrame, libcimgui), Cvoid, (Ptr{ImGuiContext},), ctx)
end

function igDockContextGenNodeID(ctx)
    ccall((:igDockContextGenNodeID, libcimgui), ImGuiID, (Ptr{ImGuiContext},), ctx)
end

function igDockContextQueueDock(ctx, target, target_node, payload, split_dir, split_ratio, split_outer)
    ccall((:igDockContextQueueDock, libcimgui), Cvoid, (Ptr{ImGuiContext}, Ptr{ImGuiWindow}, Ptr{ImGuiDockNode}, Ptr{ImGuiWindow}, ImGuiDir, Cfloat, Bool), ctx, target, target_node, payload, split_dir, split_ratio, split_outer)
end

function igDockContextQueueUndockWindow(ctx, window)
    ccall((:igDockContextQueueUndockWindow, libcimgui), Cvoid, (Ptr{ImGuiContext}, Ptr{ImGuiWindow}), ctx, window)
end

function igDockContextQueueUndockNode(ctx, node)
    ccall((:igDockContextQueueUndockNode, libcimgui), Cvoid, (Ptr{ImGuiContext}, Ptr{ImGuiDockNode}), ctx, node)
end

function igDockContextProcessUndockWindow(ctx, window, clear_persistent_docking_ref)
    ccall((:igDockContextProcessUndockWindow, libcimgui), Cvoid, (Ptr{ImGuiContext}, Ptr{ImGuiWindow}, Bool), ctx, window, clear_persistent_docking_ref)
end

function igDockContextProcessUndockNode(ctx, node)
    ccall((:igDockContextProcessUndockNode, libcimgui), Cvoid, (Ptr{ImGuiContext}, Ptr{ImGuiDockNode}), ctx, node)
end

function igDockContextCalcDropPosForDocking(target, target_node, payload_window, payload_node, split_dir, split_outer, out_pos)
    ccall((:igDockContextCalcDropPosForDocking, libcimgui), Bool, (Ptr{ImGuiWindow}, Ptr{ImGuiDockNode}, Ptr{ImGuiWindow}, Ptr{ImGuiDockNode}, ImGuiDir, Bool, Ptr{ImVec2}), target, target_node, payload_window, payload_node, split_dir, split_outer, out_pos)
end

function igDockContextFindNodeByID(ctx, id)
    ccall((:igDockContextFindNodeByID, libcimgui), Ptr{ImGuiDockNode}, (Ptr{ImGuiContext}, ImGuiID), ctx, id)
end

function igDockNodeWindowMenuHandler_Default(ctx, node, tab_bar)
    ccall((:igDockNodeWindowMenuHandler_Default, libcimgui), Cvoid, (Ptr{ImGuiContext}, Ptr{ImGuiDockNode}, Ptr{ImGuiTabBar}), ctx, node, tab_bar)
end

function igDockNodeBeginAmendTabBar(node)
    ccall((:igDockNodeBeginAmendTabBar, libcimgui), Bool, (Ptr{ImGuiDockNode},), node)
end

function igDockNodeEndAmendTabBar()
    ccall((:igDockNodeEndAmendTabBar, libcimgui), Cvoid, ())
end

function igDockNodeGetRootNode(node)
    ccall((:igDockNodeGetRootNode, libcimgui), Ptr{ImGuiDockNode}, (Ptr{ImGuiDockNode},), node)
end

function igDockNodeIsInHierarchyOf(node, parent)
    ccall((:igDockNodeIsInHierarchyOf, libcimgui), Bool, (Ptr{ImGuiDockNode}, Ptr{ImGuiDockNode}), node, parent)
end

function igDockNodeGetDepth(node)
    ccall((:igDockNodeGetDepth, libcimgui), Cint, (Ptr{ImGuiDockNode},), node)
end

function igDockNodeGetWindowMenuButtonId(node)
    ccall((:igDockNodeGetWindowMenuButtonId, libcimgui), ImGuiID, (Ptr{ImGuiDockNode},), node)
end

function igGetWindowDockNode()
    ccall((:igGetWindowDockNode, libcimgui), Ptr{ImGuiDockNode}, ())
end

function igGetWindowAlwaysWantOwnTabBar(window)
    ccall((:igGetWindowAlwaysWantOwnTabBar, libcimgui), Bool, (Ptr{ImGuiWindow},), window)
end

function igBeginDocked(window, p_open)
    ccall((:igBeginDocked, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Ptr{Bool}), window, p_open)
end

function igBeginDockableDragDropSource(window)
    ccall((:igBeginDockableDragDropSource, libcimgui), Cvoid, (Ptr{ImGuiWindow},), window)
end

function igBeginDockableDragDropTarget(window)
    ccall((:igBeginDockableDragDropTarget, libcimgui), Cvoid, (Ptr{ImGuiWindow},), window)
end

function igSetWindowDock(window, dock_id, cond)
    ccall((:igSetWindowDock, libcimgui), Cvoid, (Ptr{ImGuiWindow}, ImGuiID, ImGuiCond), window, dock_id, cond)
end

function igDockBuilderDockWindow(window_name, node_id)
    ccall((:igDockBuilderDockWindow, libcimgui), Cvoid, (Ptr{Cchar}, ImGuiID), window_name, node_id)
end

function igDockBuilderGetNode(node_id)
    ccall((:igDockBuilderGetNode, libcimgui), Ptr{ImGuiDockNode}, (ImGuiID,), node_id)
end

function igDockBuilderGetCentralNode(node_id)
    ccall((:igDockBuilderGetCentralNode, libcimgui), Ptr{ImGuiDockNode}, (ImGuiID,), node_id)
end

function igDockBuilderAddNode(node_id, flags)
    ccall((:igDockBuilderAddNode, libcimgui), ImGuiID, (ImGuiID, ImGuiDockNodeFlags), node_id, flags)
end

function igDockBuilderRemoveNode(node_id)
    ccall((:igDockBuilderRemoveNode, libcimgui), Cvoid, (ImGuiID,), node_id)
end

function igDockBuilderRemoveNodeDockedWindows(node_id, clear_settings_refs)
    ccall((:igDockBuilderRemoveNodeDockedWindows, libcimgui), Cvoid, (ImGuiID, Bool), node_id, clear_settings_refs)
end

function igDockBuilderRemoveNodeChildNodes(node_id)
    ccall((:igDockBuilderRemoveNodeChildNodes, libcimgui), Cvoid, (ImGuiID,), node_id)
end

function igDockBuilderSetNodePos(node_id, pos)
    ccall((:igDockBuilderSetNodePos, libcimgui), Cvoid, (ImGuiID, ImVec2), node_id, pos)
end

function igDockBuilderSetNodeSize(node_id, size)
    ccall((:igDockBuilderSetNodeSize, libcimgui), Cvoid, (ImGuiID, ImVec2), node_id, size)
end

function igDockBuilderSplitNode(node_id, split_dir, size_ratio_for_node_at_dir, out_id_at_dir, out_id_at_opposite_dir)
    ccall((:igDockBuilderSplitNode, libcimgui), ImGuiID, (ImGuiID, ImGuiDir, Cfloat, Ptr{ImGuiID}, Ptr{ImGuiID}), node_id, split_dir, size_ratio_for_node_at_dir, out_id_at_dir, out_id_at_opposite_dir)
end

function igDockBuilderCopyDockSpace(src_dockspace_id, dst_dockspace_id, in_window_remap_pairs)
    ccall((:igDockBuilderCopyDockSpace, libcimgui), Cvoid, (ImGuiID, ImGuiID, Ptr{ImVector_const_charPtr}), src_dockspace_id, dst_dockspace_id, in_window_remap_pairs)
end

function igDockBuilderCopyNode(src_node_id, dst_node_id, out_node_remap_pairs)
    ccall((:igDockBuilderCopyNode, libcimgui), Cvoid, (ImGuiID, ImGuiID, Ptr{ImVector_ImGuiID}), src_node_id, dst_node_id, out_node_remap_pairs)
end

function igDockBuilderCopyWindowSettings(src_name, dst_name)
    ccall((:igDockBuilderCopyWindowSettings, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cchar}), src_name, dst_name)
end

function igDockBuilderFinish(node_id)
    ccall((:igDockBuilderFinish, libcimgui), Cvoid, (ImGuiID,), node_id)
end

function igPushFocusScope(id)
    ccall((:igPushFocusScope, libcimgui), Cvoid, (ImGuiID,), id)
end

function igPopFocusScope()
    ccall((:igPopFocusScope, libcimgui), Cvoid, ())
end

function igGetCurrentFocusScope()
    ccall((:igGetCurrentFocusScope, libcimgui), ImGuiID, ())
end

function igIsDragDropActive()
    ccall((:igIsDragDropActive, libcimgui), Bool, ())
end

function igBeginDragDropTargetCustom(bb, id)
    ccall((:igBeginDragDropTargetCustom, libcimgui), Bool, (ImRect, ImGuiID), bb, id)
end

function igClearDragDrop()
    ccall((:igClearDragDrop, libcimgui), Cvoid, ())
end

function igIsDragDropPayloadBeingAccepted()
    ccall((:igIsDragDropPayloadBeingAccepted, libcimgui), Bool, ())
end

function igRenderDragDropTargetRect(bb, item_clip_rect)
    ccall((:igRenderDragDropTargetRect, libcimgui), Cvoid, (ImRect, ImRect), bb, item_clip_rect)
end

function igGetTypingSelectRequest(flags)
    ccall((:igGetTypingSelectRequest, libcimgui), Ptr{ImGuiTypingSelectRequest}, (ImGuiTypingSelectFlags,), flags)
end

function igTypingSelectFindMatch(req, items_count, get_item_name_func, user_data, nav_item_idx)
    ccall((:igTypingSelectFindMatch, libcimgui), Cint, (Ptr{ImGuiTypingSelectRequest}, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Cint), req, items_count, get_item_name_func, user_data, nav_item_idx)
end

function igTypingSelectFindNextSingleCharMatch(req, items_count, get_item_name_func, user_data, nav_item_idx)
    ccall((:igTypingSelectFindNextSingleCharMatch, libcimgui), Cint, (Ptr{ImGuiTypingSelectRequest}, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Cint), req, items_count, get_item_name_func, user_data, nav_item_idx)
end

function igTypingSelectFindBestLeadingMatch(req, items_count, get_item_name_func, user_data)
    ccall((:igTypingSelectFindBestLeadingMatch, libcimgui), Cint, (Ptr{ImGuiTypingSelectRequest}, Cint, Ptr{Cvoid}, Ptr{Cvoid}), req, items_count, get_item_name_func, user_data)
end

function igBeginBoxSelect(scope_rect, window, box_select_id, ms_flags)
    ccall((:igBeginBoxSelect, libcimgui), Bool, (ImRect, Ptr{ImGuiWindow}, ImGuiID, ImGuiMultiSelectFlags), scope_rect, window, box_select_id, ms_flags)
end

function igEndBoxSelect(scope_rect, ms_flags)
    ccall((:igEndBoxSelect, libcimgui), Cvoid, (ImRect, ImGuiMultiSelectFlags), scope_rect, ms_flags)
end

function igMultiSelectItemHeader(id, p_selected, p_button_flags)
    ccall((:igMultiSelectItemHeader, libcimgui), Cvoid, (ImGuiID, Ptr{Bool}, Ptr{ImGuiButtonFlags}), id, p_selected, p_button_flags)
end

function igMultiSelectItemFooter(id, p_selected, p_pressed)
    ccall((:igMultiSelectItemFooter, libcimgui), Cvoid, (ImGuiID, Ptr{Bool}, Ptr{Bool}), id, p_selected, p_pressed)
end

function igMultiSelectAddSetAll(ms, selected)
    ccall((:igMultiSelectAddSetAll, libcimgui), Cvoid, (Ptr{ImGuiMultiSelectTempData}, Bool), ms, selected)
end

function igMultiSelectAddSetRange(ms, selected, range_dir, first_item, last_item)
    ccall((:igMultiSelectAddSetRange, libcimgui), Cvoid, (Ptr{ImGuiMultiSelectTempData}, Bool, Cint, ImGuiSelectionUserData, ImGuiSelectionUserData), ms, selected, range_dir, first_item, last_item)
end

function igGetBoxSelectState(id)
    ccall((:igGetBoxSelectState, libcimgui), Ptr{ImGuiBoxSelectState}, (ImGuiID,), id)
end

function igGetMultiSelectState(id)
    ccall((:igGetMultiSelectState, libcimgui), Ptr{ImGuiMultiSelectState}, (ImGuiID,), id)
end

function igSetWindowClipRectBeforeSetChannel(window, clip_rect)
    ccall((:igSetWindowClipRectBeforeSetChannel, libcimgui), Cvoid, (Ptr{ImGuiWindow}, ImRect), window, clip_rect)
end

function igBeginColumns(str_id, count, flags)
    ccall((:igBeginColumns, libcimgui), Cvoid, (Ptr{Cchar}, Cint, ImGuiOldColumnFlags), str_id, count, flags)
end

function igEndColumns()
    ccall((:igEndColumns, libcimgui), Cvoid, ())
end

function igPushColumnClipRect(column_index)
    ccall((:igPushColumnClipRect, libcimgui), Cvoid, (Cint,), column_index)
end

function igPushColumnsBackground()
    ccall((:igPushColumnsBackground, libcimgui), Cvoid, ())
end

function igPopColumnsBackground()
    ccall((:igPopColumnsBackground, libcimgui), Cvoid, ())
end

function igGetColumnsID(str_id, count)
    ccall((:igGetColumnsID, libcimgui), ImGuiID, (Ptr{Cchar}, Cint), str_id, count)
end

function igFindOrCreateColumns(window, id)
    ccall((:igFindOrCreateColumns, libcimgui), Ptr{ImGuiOldColumns}, (Ptr{ImGuiWindow}, ImGuiID), window, id)
end

function igGetColumnOffsetFromNorm(columns, offset_norm)
    ccall((:igGetColumnOffsetFromNorm, libcimgui), Cfloat, (Ptr{ImGuiOldColumns}, Cfloat), columns, offset_norm)
end

function igGetColumnNormFromOffset(columns, offset)
    ccall((:igGetColumnNormFromOffset, libcimgui), Cfloat, (Ptr{ImGuiOldColumns}, Cfloat), columns, offset)
end

function igTableOpenContextMenu(column_n)
    ccall((:igTableOpenContextMenu, libcimgui), Cvoid, (Cint,), column_n)
end

function igTableSetColumnWidth(column_n, width)
    ccall((:igTableSetColumnWidth, libcimgui), Cvoid, (Cint, Cfloat), column_n, width)
end

function igTableSetColumnSortDirection(column_n, sort_direction, append_to_sort_specs)
    ccall((:igTableSetColumnSortDirection, libcimgui), Cvoid, (Cint, ImGuiSortDirection, Bool), column_n, sort_direction, append_to_sort_specs)
end

function igTableGetHoveredRow()
    ccall((:igTableGetHoveredRow, libcimgui), Cint, ())
end

function igTableGetHeaderRowHeight()
    ccall((:igTableGetHeaderRowHeight, libcimgui), Cfloat, ())
end

function igTableGetHeaderAngledMaxLabelWidth()
    ccall((:igTableGetHeaderAngledMaxLabelWidth, libcimgui), Cfloat, ())
end

function igTablePushBackgroundChannel()
    ccall((:igTablePushBackgroundChannel, libcimgui), Cvoid, ())
end

function igTablePopBackgroundChannel()
    ccall((:igTablePopBackgroundChannel, libcimgui), Cvoid, ())
end

function igTableAngledHeadersRowEx(row_id, angle, max_label_width, data, data_count)
    ccall((:igTableAngledHeadersRowEx, libcimgui), Cvoid, (ImGuiID, Cfloat, Cfloat, Ptr{ImGuiTableHeaderData}, Cint), row_id, angle, max_label_width, data, data_count)
end

function igGetCurrentTable()
    ccall((:igGetCurrentTable, libcimgui), Ptr{ImGuiTable}, ())
end

function igTableFindByID(id)
    ccall((:igTableFindByID, libcimgui), Ptr{ImGuiTable}, (ImGuiID,), id)
end

function igBeginTableEx(name, id, columns_count, flags, outer_size, inner_width)
    ccall((:igBeginTableEx, libcimgui), Bool, (Ptr{Cchar}, ImGuiID, Cint, ImGuiTableFlags, ImVec2, Cfloat), name, id, columns_count, flags, outer_size, inner_width)
end

function igTableBeginInitMemory(table, columns_count)
    ccall((:igTableBeginInitMemory, libcimgui), Cvoid, (Ptr{ImGuiTable}, Cint), table, columns_count)
end

function igTableBeginApplyRequests(table)
    ccall((:igTableBeginApplyRequests, libcimgui), Cvoid, (Ptr{ImGuiTable},), table)
end

function igTableSetupDrawChannels(table)
    ccall((:igTableSetupDrawChannels, libcimgui), Cvoid, (Ptr{ImGuiTable},), table)
end

function igTableUpdateLayout(table)
    ccall((:igTableUpdateLayout, libcimgui), Cvoid, (Ptr{ImGuiTable},), table)
end

function igTableUpdateBorders(table)
    ccall((:igTableUpdateBorders, libcimgui), Cvoid, (Ptr{ImGuiTable},), table)
end

function igTableUpdateColumnsWeightFromWidth(table)
    ccall((:igTableUpdateColumnsWeightFromWidth, libcimgui), Cvoid, (Ptr{ImGuiTable},), table)
end

function igTableDrawBorders(table)
    ccall((:igTableDrawBorders, libcimgui), Cvoid, (Ptr{ImGuiTable},), table)
end

function igTableDrawDefaultContextMenu(table, flags_for_section_to_display)
    ccall((:igTableDrawDefaultContextMenu, libcimgui), Cvoid, (Ptr{ImGuiTable}, ImGuiTableFlags), table, flags_for_section_to_display)
end

function igTableBeginContextMenuPopup(table)
    ccall((:igTableBeginContextMenuPopup, libcimgui), Bool, (Ptr{ImGuiTable},), table)
end

function igTableMergeDrawChannels(table)
    ccall((:igTableMergeDrawChannels, libcimgui), Cvoid, (Ptr{ImGuiTable},), table)
end

function igTableGetInstanceData(table, instance_no)
    ccall((:igTableGetInstanceData, libcimgui), Ptr{ImGuiTableInstanceData}, (Ptr{ImGuiTable}, Cint), table, instance_no)
end

function igTableGetInstanceID(table, instance_no)
    ccall((:igTableGetInstanceID, libcimgui), ImGuiID, (Ptr{ImGuiTable}, Cint), table, instance_no)
end

function igTableSortSpecsSanitize(table)
    ccall((:igTableSortSpecsSanitize, libcimgui), Cvoid, (Ptr{ImGuiTable},), table)
end

function igTableSortSpecsBuild(table)
    ccall((:igTableSortSpecsBuild, libcimgui), Cvoid, (Ptr{ImGuiTable},), table)
end

function igTableGetColumnNextSortDirection(column)
    ccall((:igTableGetColumnNextSortDirection, libcimgui), ImGuiSortDirection, (Ptr{ImGuiTableColumn},), column)
end

function igTableFixColumnSortDirection(table, column)
    ccall((:igTableFixColumnSortDirection, libcimgui), Cvoid, (Ptr{ImGuiTable}, Ptr{ImGuiTableColumn}), table, column)
end

function igTableGetColumnWidthAuto(table, column)
    ccall((:igTableGetColumnWidthAuto, libcimgui), Cfloat, (Ptr{ImGuiTable}, Ptr{ImGuiTableColumn}), table, column)
end

function igTableBeginRow(table)
    ccall((:igTableBeginRow, libcimgui), Cvoid, (Ptr{ImGuiTable},), table)
end

function igTableEndRow(table)
    ccall((:igTableEndRow, libcimgui), Cvoid, (Ptr{ImGuiTable},), table)
end

function igTableBeginCell(table, column_n)
    ccall((:igTableBeginCell, libcimgui), Cvoid, (Ptr{ImGuiTable}, Cint), table, column_n)
end

function igTableEndCell(table)
    ccall((:igTableEndCell, libcimgui), Cvoid, (Ptr{ImGuiTable},), table)
end

function igTableGetCellBgRect(pOut, table, column_n)
    ccall((:igTableGetCellBgRect, libcimgui), Cvoid, (Ptr{ImRect}, Ptr{ImGuiTable}, Cint), pOut, table, column_n)
end

function igTableGetColumnName_TablePtr(table, column_n)
    ccall((:igTableGetColumnName_TablePtr, libcimgui), Ptr{Cchar}, (Ptr{ImGuiTable}, Cint), table, column_n)
end

function igTableGetColumnResizeID(table, column_n, instance_no)
    ccall((:igTableGetColumnResizeID, libcimgui), ImGuiID, (Ptr{ImGuiTable}, Cint, Cint), table, column_n, instance_no)
end

function igTableGetMaxColumnWidth(table, column_n)
    ccall((:igTableGetMaxColumnWidth, libcimgui), Cfloat, (Ptr{ImGuiTable}, Cint), table, column_n)
end

function igTableSetColumnWidthAutoSingle(table, column_n)
    ccall((:igTableSetColumnWidthAutoSingle, libcimgui), Cvoid, (Ptr{ImGuiTable}, Cint), table, column_n)
end

function igTableSetColumnWidthAutoAll(table)
    ccall((:igTableSetColumnWidthAutoAll, libcimgui), Cvoid, (Ptr{ImGuiTable},), table)
end

function igTableRemove(table)
    ccall((:igTableRemove, libcimgui), Cvoid, (Ptr{ImGuiTable},), table)
end

function igTableGcCompactTransientBuffers_TablePtr(table)
    ccall((:igTableGcCompactTransientBuffers_TablePtr, libcimgui), Cvoid, (Ptr{ImGuiTable},), table)
end

function igTableGcCompactTransientBuffers_TableTempDataPtr(table)
    ccall((:igTableGcCompactTransientBuffers_TableTempDataPtr, libcimgui), Cvoid, (Ptr{ImGuiTableTempData},), table)
end

function igTableGcCompactSettings()
    ccall((:igTableGcCompactSettings, libcimgui), Cvoid, ())
end

function igTableLoadSettings(table)
    ccall((:igTableLoadSettings, libcimgui), Cvoid, (Ptr{ImGuiTable},), table)
end

function igTableSaveSettings(table)
    ccall((:igTableSaveSettings, libcimgui), Cvoid, (Ptr{ImGuiTable},), table)
end

function igTableResetSettings(table)
    ccall((:igTableResetSettings, libcimgui), Cvoid, (Ptr{ImGuiTable},), table)
end

function igTableGetBoundSettings(table)
    ccall((:igTableGetBoundSettings, libcimgui), Ptr{ImGuiTableSettings}, (Ptr{ImGuiTable},), table)
end

function igTableSettingsAddSettingsHandler()
    ccall((:igTableSettingsAddSettingsHandler, libcimgui), Cvoid, ())
end

function igTableSettingsCreate(id, columns_count)
    ccall((:igTableSettingsCreate, libcimgui), Ptr{ImGuiTableSettings}, (ImGuiID, Cint), id, columns_count)
end

function igTableSettingsFindByID(id)
    ccall((:igTableSettingsFindByID, libcimgui), Ptr{ImGuiTableSettings}, (ImGuiID,), id)
end

function igGetCurrentTabBar()
    ccall((:igGetCurrentTabBar, libcimgui), Ptr{ImGuiTabBar}, ())
end

function igBeginTabBarEx(tab_bar, bb, flags)
    ccall((:igBeginTabBarEx, libcimgui), Bool, (Ptr{ImGuiTabBar}, ImRect, ImGuiTabBarFlags), tab_bar, bb, flags)
end

function igTabBarFindTabByID(tab_bar, tab_id)
    ccall((:igTabBarFindTabByID, libcimgui), Ptr{ImGuiTabItem}, (Ptr{ImGuiTabBar}, ImGuiID), tab_bar, tab_id)
end

function igTabBarFindTabByOrder(tab_bar, order)
    ccall((:igTabBarFindTabByOrder, libcimgui), Ptr{ImGuiTabItem}, (Ptr{ImGuiTabBar}, Cint), tab_bar, order)
end

function igTabBarFindMostRecentlySelectedTabForActiveWindow(tab_bar)
    ccall((:igTabBarFindMostRecentlySelectedTabForActiveWindow, libcimgui), Ptr{ImGuiTabItem}, (Ptr{ImGuiTabBar},), tab_bar)
end

function igTabBarGetCurrentTab(tab_bar)
    ccall((:igTabBarGetCurrentTab, libcimgui), Ptr{ImGuiTabItem}, (Ptr{ImGuiTabBar},), tab_bar)
end

function igTabBarGetTabOrder(tab_bar, tab)
    ccall((:igTabBarGetTabOrder, libcimgui), Cint, (Ptr{ImGuiTabBar}, Ptr{ImGuiTabItem}), tab_bar, tab)
end

function igTabBarGetTabName(tab_bar, tab)
    ccall((:igTabBarGetTabName, libcimgui), Ptr{Cchar}, (Ptr{ImGuiTabBar}, Ptr{ImGuiTabItem}), tab_bar, tab)
end

function igTabBarAddTab(tab_bar, tab_flags, window)
    ccall((:igTabBarAddTab, libcimgui), Cvoid, (Ptr{ImGuiTabBar}, ImGuiTabItemFlags, Ptr{ImGuiWindow}), tab_bar, tab_flags, window)
end

function igTabBarRemoveTab(tab_bar, tab_id)
    ccall((:igTabBarRemoveTab, libcimgui), Cvoid, (Ptr{ImGuiTabBar}, ImGuiID), tab_bar, tab_id)
end

function igTabBarCloseTab(tab_bar, tab)
    ccall((:igTabBarCloseTab, libcimgui), Cvoid, (Ptr{ImGuiTabBar}, Ptr{ImGuiTabItem}), tab_bar, tab)
end

function igTabBarQueueFocus(tab_bar, tab)
    ccall((:igTabBarQueueFocus, libcimgui), Cvoid, (Ptr{ImGuiTabBar}, Ptr{ImGuiTabItem}), tab_bar, tab)
end

function igTabBarQueueReorder(tab_bar, tab, offset)
    ccall((:igTabBarQueueReorder, libcimgui), Cvoid, (Ptr{ImGuiTabBar}, Ptr{ImGuiTabItem}, Cint), tab_bar, tab, offset)
end

function igTabBarQueueReorderFromMousePos(tab_bar, tab, mouse_pos)
    ccall((:igTabBarQueueReorderFromMousePos, libcimgui), Cvoid, (Ptr{ImGuiTabBar}, Ptr{ImGuiTabItem}, ImVec2), tab_bar, tab, mouse_pos)
end

function igTabBarProcessReorder(tab_bar)
    ccall((:igTabBarProcessReorder, libcimgui), Bool, (Ptr{ImGuiTabBar},), tab_bar)
end

function igTabItemEx(tab_bar, label, p_open, flags, docked_window)
    ccall((:igTabItemEx, libcimgui), Bool, (Ptr{ImGuiTabBar}, Ptr{Cchar}, Ptr{Bool}, ImGuiTabItemFlags, Ptr{ImGuiWindow}), tab_bar, label, p_open, flags, docked_window)
end

function igTabItemCalcSize_Str(pOut, label, has_close_button_or_unsaved_marker)
    ccall((:igTabItemCalcSize_Str, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{Cchar}, Bool), pOut, label, has_close_button_or_unsaved_marker)
end

function igTabItemCalcSize_WindowPtr(pOut, window)
    ccall((:igTabItemCalcSize_WindowPtr, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImGuiWindow}), pOut, window)
end

function igTabItemBackground(draw_list, bb, flags, col)
    ccall((:igTabItemBackground, libcimgui), Cvoid, (Ptr{ImDrawList}, ImRect, ImGuiTabItemFlags, ImU32), draw_list, bb, flags, col)
end

function igTabItemLabelAndCloseButton(draw_list, bb, flags, frame_padding, label, tab_id, close_button_id, is_contents_visible, out_just_closed, out_text_clipped)
    ccall((:igTabItemLabelAndCloseButton, libcimgui), Cvoid, (Ptr{ImDrawList}, ImRect, ImGuiTabItemFlags, ImVec2, Ptr{Cchar}, ImGuiID, ImGuiID, Bool, Ptr{Bool}, Ptr{Bool}), draw_list, bb, flags, frame_padding, label, tab_id, close_button_id, is_contents_visible, out_just_closed, out_text_clipped)
end

function igRenderText(pos, text, text_end, hide_text_after_hash)
    ccall((:igRenderText, libcimgui), Cvoid, (ImVec2, Ptr{Cchar}, Ptr{Cchar}, Bool), pos, text, text_end, hide_text_after_hash)
end

function igRenderTextWrapped(pos, text, text_end, wrap_width)
    ccall((:igRenderTextWrapped, libcimgui), Cvoid, (ImVec2, Ptr{Cchar}, Ptr{Cchar}, Cfloat), pos, text, text_end, wrap_width)
end

function igRenderTextClipped(pos_min, pos_max, text, text_end, text_size_if_known, align, clip_rect)
    ccall((:igRenderTextClipped, libcimgui), Cvoid, (ImVec2, ImVec2, Ptr{Cchar}, Ptr{Cchar}, Ptr{ImVec2}, ImVec2, Ptr{ImRect}), pos_min, pos_max, text, text_end, text_size_if_known, align, clip_rect)
end

function igRenderTextClippedEx(draw_list, pos_min, pos_max, text, text_end, text_size_if_known, align, clip_rect)
    ccall((:igRenderTextClippedEx, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, Ptr{Cchar}, Ptr{Cchar}, Ptr{ImVec2}, ImVec2, Ptr{ImRect}), draw_list, pos_min, pos_max, text, text_end, text_size_if_known, align, clip_rect)
end

function igRenderTextEllipsis(draw_list, pos_min, pos_max, clip_max_x, ellipsis_max_x, text, text_end, text_size_if_known)
    ccall((:igRenderTextEllipsis, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, Cfloat, Cfloat, Ptr{Cchar}, Ptr{Cchar}, Ptr{ImVec2}), draw_list, pos_min, pos_max, clip_max_x, ellipsis_max_x, text, text_end, text_size_if_known)
end

function igRenderFrame(p_min, p_max, fill_col, border, rounding)
    ccall((:igRenderFrame, libcimgui), Cvoid, (ImVec2, ImVec2, ImU32, Bool, Cfloat), p_min, p_max, fill_col, border, rounding)
end

function igRenderFrameBorder(p_min, p_max, rounding)
    ccall((:igRenderFrameBorder, libcimgui), Cvoid, (ImVec2, ImVec2, Cfloat), p_min, p_max, rounding)
end

function igRenderColorRectWithAlphaCheckerboard(draw_list, p_min, p_max, fill_col, grid_step, grid_off, rounding, flags)
    ccall((:igRenderColorRectWithAlphaCheckerboard, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImU32, Cfloat, ImVec2, Cfloat, ImDrawFlags), draw_list, p_min, p_max, fill_col, grid_step, grid_off, rounding, flags)
end

function igRenderNavHighlight(bb, id, flags)
    ccall((:igRenderNavHighlight, libcimgui), Cvoid, (ImRect, ImGuiID, ImGuiNavHighlightFlags), bb, id, flags)
end

function igFindRenderedTextEnd(text, text_end)
    ccall((:igFindRenderedTextEnd, libcimgui), Ptr{Cchar}, (Ptr{Cchar}, Ptr{Cchar}), text, text_end)
end

function igRenderMouseCursor(pos, scale, mouse_cursor, col_fill, col_border, col_shadow)
    ccall((:igRenderMouseCursor, libcimgui), Cvoid, (ImVec2, Cfloat, ImGuiMouseCursor, ImU32, ImU32, ImU32), pos, scale, mouse_cursor, col_fill, col_border, col_shadow)
end

function igRenderArrow(draw_list, pos, col, dir, scale)
    ccall((:igRenderArrow, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImU32, ImGuiDir, Cfloat), draw_list, pos, col, dir, scale)
end

function igRenderBullet(draw_list, pos, col)
    ccall((:igRenderBullet, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImU32), draw_list, pos, col)
end

function igRenderCheckMark(draw_list, pos, col, sz)
    ccall((:igRenderCheckMark, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImU32, Cfloat), draw_list, pos, col, sz)
end

function igRenderArrowPointingAt(draw_list, pos, half_sz, direction, col)
    ccall((:igRenderArrowPointingAt, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImGuiDir, ImU32), draw_list, pos, half_sz, direction, col)
end

function igRenderArrowDockMenu(draw_list, p_min, sz, col)
    ccall((:igRenderArrowDockMenu, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, Cfloat, ImU32), draw_list, p_min, sz, col)
end

function igRenderRectFilledRangeH(draw_list, rect, col, x_start_norm, x_end_norm, rounding)
    ccall((:igRenderRectFilledRangeH, libcimgui), Cvoid, (Ptr{ImDrawList}, ImRect, ImU32, Cfloat, Cfloat, Cfloat), draw_list, rect, col, x_start_norm, x_end_norm, rounding)
end

function igRenderRectFilledWithHole(draw_list, outer, inner, col, rounding)
    ccall((:igRenderRectFilledWithHole, libcimgui), Cvoid, (Ptr{ImDrawList}, ImRect, ImRect, ImU32, Cfloat), draw_list, outer, inner, col, rounding)
end

function igCalcRoundingFlagsForRectInRect(r_in, r_outer, threshold)
    ccall((:igCalcRoundingFlagsForRectInRect, libcimgui), ImDrawFlags, (ImRect, ImRect, Cfloat), r_in, r_outer, threshold)
end

function igTextEx(text, text_end, flags)
    ccall((:igTextEx, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cchar}, ImGuiTextFlags), text, text_end, flags)
end

function igButtonEx(label, size_arg, flags)
    ccall((:igButtonEx, libcimgui), Bool, (Ptr{Cchar}, ImVec2, ImGuiButtonFlags), label, size_arg, flags)
end

function igArrowButtonEx(str_id, dir, size_arg, flags)
    ccall((:igArrowButtonEx, libcimgui), Bool, (Ptr{Cchar}, ImGuiDir, ImVec2, ImGuiButtonFlags), str_id, dir, size_arg, flags)
end

function igImageButtonEx(id, texture_id, image_size, uv0, uv1, bg_col, tint_col, flags)
    ccall((:igImageButtonEx, libcimgui), Bool, (ImGuiID, ImTextureID, ImVec2, ImVec2, ImVec2, ImVec4, ImVec4, ImGuiButtonFlags), id, texture_id, image_size, uv0, uv1, bg_col, tint_col, flags)
end

function igSeparatorEx(flags, thickness)
    ccall((:igSeparatorEx, libcimgui), Cvoid, (ImGuiSeparatorFlags, Cfloat), flags, thickness)
end

function igSeparatorTextEx(id, label, label_end, extra_width)
    ccall((:igSeparatorTextEx, libcimgui), Cvoid, (ImGuiID, Ptr{Cchar}, Ptr{Cchar}, Cfloat), id, label, label_end, extra_width)
end

function igCheckboxFlags_S64Ptr(label, flags, flags_value)
    ccall((:igCheckboxFlags_S64Ptr, libcimgui), Bool, (Ptr{Cchar}, Ptr{ImS64}, ImS64), label, flags, flags_value)
end

function igCheckboxFlags_U64Ptr(label, flags, flags_value)
    ccall((:igCheckboxFlags_U64Ptr, libcimgui), Bool, (Ptr{Cchar}, Ptr{ImU64}, ImU64), label, flags, flags_value)
end

function igCloseButton(id, pos)
    ccall((:igCloseButton, libcimgui), Bool, (ImGuiID, ImVec2), id, pos)
end

function igCollapseButton(id, pos, dock_node)
    ccall((:igCollapseButton, libcimgui), Bool, (ImGuiID, ImVec2, Ptr{ImGuiDockNode}), id, pos, dock_node)
end

function igScrollbar(axis)
    ccall((:igScrollbar, libcimgui), Cvoid, (ImGuiAxis,), axis)
end

function igScrollbarEx(bb, id, axis, p_scroll_v, avail_v, contents_v, flags)
    ccall((:igScrollbarEx, libcimgui), Bool, (ImRect, ImGuiID, ImGuiAxis, Ptr{ImS64}, ImS64, ImS64, ImDrawFlags), bb, id, axis, p_scroll_v, avail_v, contents_v, flags)
end

function igGetWindowScrollbarRect(pOut, window, axis)
    ccall((:igGetWindowScrollbarRect, libcimgui), Cvoid, (Ptr{ImRect}, Ptr{ImGuiWindow}, ImGuiAxis), pOut, window, axis)
end

function igGetWindowScrollbarID(window, axis)
    ccall((:igGetWindowScrollbarID, libcimgui), ImGuiID, (Ptr{ImGuiWindow}, ImGuiAxis), window, axis)
end

function igGetWindowResizeCornerID(window, n)
    ccall((:igGetWindowResizeCornerID, libcimgui), ImGuiID, (Ptr{ImGuiWindow}, Cint), window, n)
end

function igGetWindowResizeBorderID(window, dir)
    ccall((:igGetWindowResizeBorderID, libcimgui), ImGuiID, (Ptr{ImGuiWindow}, ImGuiDir), window, dir)
end

function igButtonBehavior(bb, id, out_hovered, out_held, flags)
    ccall((:igButtonBehavior, libcimgui), Bool, (ImRect, ImGuiID, Ptr{Bool}, Ptr{Bool}, ImGuiButtonFlags), bb, id, out_hovered, out_held, flags)
end

function igDragBehavior(id, data_type, p_v, v_speed, p_min, p_max, format, flags)
    ccall((:igDragBehavior, libcimgui), Bool, (ImGuiID, ImGuiDataType, Ptr{Cvoid}, Cfloat, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cchar}, ImGuiSliderFlags), id, data_type, p_v, v_speed, p_min, p_max, format, flags)
end

function igSliderBehavior(bb, id, data_type, p_v, p_min, p_max, format, flags, out_grab_bb)
    ccall((:igSliderBehavior, libcimgui), Bool, (ImRect, ImGuiID, ImGuiDataType, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cchar}, ImGuiSliderFlags, Ptr{ImRect}), bb, id, data_type, p_v, p_min, p_max, format, flags, out_grab_bb)
end

function igSplitterBehavior(bb, id, axis, size1, size2, min_size1, min_size2, hover_extend, hover_visibility_delay, bg_col)
    ccall((:igSplitterBehavior, libcimgui), Bool, (ImRect, ImGuiID, ImGuiAxis, Ptr{Cfloat}, Ptr{Cfloat}, Cfloat, Cfloat, Cfloat, Cfloat, ImU32), bb, id, axis, size1, size2, min_size1, min_size2, hover_extend, hover_visibility_delay, bg_col)
end

function igTreeNodeBehavior(id, flags, label, label_end)
    ccall((:igTreeNodeBehavior, libcimgui), Bool, (ImGuiID, ImGuiTreeNodeFlags, Ptr{Cchar}, Ptr{Cchar}), id, flags, label, label_end)
end

function igTreePushOverrideID(id)
    ccall((:igTreePushOverrideID, libcimgui), Cvoid, (ImGuiID,), id)
end

function igTreeNodeGetOpen(storage_id)
    ccall((:igTreeNodeGetOpen, libcimgui), Bool, (ImGuiID,), storage_id)
end

function igTreeNodeSetOpen(storage_id, open)
    ccall((:igTreeNodeSetOpen, libcimgui), Cvoid, (ImGuiID, Bool), storage_id, open)
end

function igTreeNodeUpdateNextOpen(storage_id, flags)
    ccall((:igTreeNodeUpdateNextOpen, libcimgui), Bool, (ImGuiID, ImGuiTreeNodeFlags), storage_id, flags)
end

function igDataTypeGetInfo(data_type)
    ccall((:igDataTypeGetInfo, libcimgui), Ptr{ImGuiDataTypeInfo}, (ImGuiDataType,), data_type)
end

function igDataTypeFormatString(buf, buf_size, data_type, p_data, format)
    ccall((:igDataTypeFormatString, libcimgui), Cint, (Ptr{Cchar}, Cint, ImGuiDataType, Ptr{Cvoid}, Ptr{Cchar}), buf, buf_size, data_type, p_data, format)
end

function igDataTypeApplyOp(data_type, op, output, arg_1, arg_2)
    ccall((:igDataTypeApplyOp, libcimgui), Cvoid, (ImGuiDataType, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}), data_type, op, output, arg_1, arg_2)
end

function igDataTypeApplyFromText(buf, data_type, p_data, format, p_data_when_empty)
    ccall((:igDataTypeApplyFromText, libcimgui), Bool, (Ptr{Cchar}, ImGuiDataType, Ptr{Cvoid}, Ptr{Cchar}, Ptr{Cvoid}), buf, data_type, p_data, format, p_data_when_empty)
end

function igDataTypeCompare(data_type, arg_1, arg_2)
    ccall((:igDataTypeCompare, libcimgui), Cint, (ImGuiDataType, Ptr{Cvoid}, Ptr{Cvoid}), data_type, arg_1, arg_2)
end

function igDataTypeClamp(data_type, p_data, p_min, p_max)
    ccall((:igDataTypeClamp, libcimgui), Bool, (ImGuiDataType, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}), data_type, p_data, p_min, p_max)
end

function igInputTextEx(label, hint, buf, buf_size, size_arg, flags, callback, user_data)
    ccall((:igInputTextEx, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cchar}, Ptr{Cchar}, Cint, ImVec2, ImGuiInputTextFlags, ImGuiInputTextCallback, Ptr{Cvoid}), label, hint, buf, buf_size, size_arg, flags, callback, user_data)
end

function igInputTextDeactivateHook(id)
    ccall((:igInputTextDeactivateHook, libcimgui), Cvoid, (ImGuiID,), id)
end

function igTempInputText(bb, id, label, buf, buf_size, flags)
    ccall((:igTempInputText, libcimgui), Bool, (ImRect, ImGuiID, Ptr{Cchar}, Ptr{Cchar}, Cint, ImGuiInputTextFlags), bb, id, label, buf, buf_size, flags)
end

function igTempInputScalar(bb, id, label, data_type, p_data, format, p_clamp_min, p_clamp_max)
    ccall((:igTempInputScalar, libcimgui), Bool, (ImRect, ImGuiID, Ptr{Cchar}, ImGuiDataType, Ptr{Cvoid}, Ptr{Cchar}, Ptr{Cvoid}, Ptr{Cvoid}), bb, id, label, data_type, p_data, format, p_clamp_min, p_clamp_max)
end

function igTempInputIsActive(id)
    ccall((:igTempInputIsActive, libcimgui), Bool, (ImGuiID,), id)
end

function igGetInputTextState(id)
    ccall((:igGetInputTextState, libcimgui), Ptr{ImGuiInputTextState}, (ImGuiID,), id)
end

function igSetNextItemRefVal(data_type, p_data)
    ccall((:igSetNextItemRefVal, libcimgui), Cvoid, (ImGuiDataType, Ptr{Cvoid}), data_type, p_data)
end

function igColorTooltip(text, col, flags)
    ccall((:igColorTooltip, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cfloat}, ImGuiColorEditFlags), text, col, flags)
end

function igColorEditOptionsPopup(col, flags)
    ccall((:igColorEditOptionsPopup, libcimgui), Cvoid, (Ptr{Cfloat}, ImGuiColorEditFlags), col, flags)
end

function igColorPickerOptionsPopup(ref_col, flags)
    ccall((:igColorPickerOptionsPopup, libcimgui), Cvoid, (Ptr{Cfloat}, ImGuiColorEditFlags), ref_col, flags)
end

function igPlotEx(plot_type, label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, size_arg)
    ccall((:igPlotEx, libcimgui), Cint, (ImGuiPlotType, Ptr{Cchar}, Ptr{Cvoid}, Ptr{Cvoid}, Cint, Cint, Ptr{Cchar}, Cfloat, Cfloat, ImVec2), plot_type, label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, size_arg)
end

function igShadeVertsLinearColorGradientKeepAlpha(draw_list, vert_start_idx, vert_end_idx, gradient_p0, gradient_p1, col0, col1)
    ccall((:igShadeVertsLinearColorGradientKeepAlpha, libcimgui), Cvoid, (Ptr{ImDrawList}, Cint, Cint, ImVec2, ImVec2, ImU32, ImU32), draw_list, vert_start_idx, vert_end_idx, gradient_p0, gradient_p1, col0, col1)
end

function igShadeVertsLinearUV(draw_list, vert_start_idx, vert_end_idx, a, b, uv_a, uv_b, clamp)
    ccall((:igShadeVertsLinearUV, libcimgui), Cvoid, (Ptr{ImDrawList}, Cint, Cint, ImVec2, ImVec2, ImVec2, ImVec2, Bool), draw_list, vert_start_idx, vert_end_idx, a, b, uv_a, uv_b, clamp)
end

function igShadeVertsTransformPos(draw_list, vert_start_idx, vert_end_idx, pivot_in, cos_a, sin_a, pivot_out)
    ccall((:igShadeVertsTransformPos, libcimgui), Cvoid, (Ptr{ImDrawList}, Cint, Cint, ImVec2, Cfloat, Cfloat, ImVec2), draw_list, vert_start_idx, vert_end_idx, pivot_in, cos_a, sin_a, pivot_out)
end

function igGcCompactTransientMiscBuffers()
    ccall((:igGcCompactTransientMiscBuffers, libcimgui), Cvoid, ())
end

function igGcCompactTransientWindowBuffers(window)
    ccall((:igGcCompactTransientWindowBuffers, libcimgui), Cvoid, (Ptr{ImGuiWindow},), window)
end

function igGcAwakeTransientWindowBuffers(window)
    ccall((:igGcAwakeTransientWindowBuffers, libcimgui), Cvoid, (Ptr{ImGuiWindow},), window)
end

function igDebugAllocHook(info, frame_count, ptr, size)
    ccall((:igDebugAllocHook, libcimgui), Cvoid, (Ptr{ImGuiDebugAllocInfo}, Cint, Ptr{Cvoid}, Csize_t), info, frame_count, ptr, size)
end

function igErrorCheckEndFrameRecover(log_callback, user_data)
    ccall((:igErrorCheckEndFrameRecover, libcimgui), Cvoid, (ImGuiErrorLogCallback, Ptr{Cvoid}), log_callback, user_data)
end

function igErrorCheckEndWindowRecover(log_callback, user_data)
    ccall((:igErrorCheckEndWindowRecover, libcimgui), Cvoid, (ImGuiErrorLogCallback, Ptr{Cvoid}), log_callback, user_data)
end

function igErrorCheckUsingSetCursorPosToExtendParentBoundaries()
    ccall((:igErrorCheckUsingSetCursorPosToExtendParentBoundaries, libcimgui), Cvoid, ())
end

function igDebugDrawCursorPos(col)
    ccall((:igDebugDrawCursorPos, libcimgui), Cvoid, (ImU32,), col)
end

function igDebugDrawLineExtents(col)
    ccall((:igDebugDrawLineExtents, libcimgui), Cvoid, (ImU32,), col)
end

function igDebugDrawItemRect(col)
    ccall((:igDebugDrawItemRect, libcimgui), Cvoid, (ImU32,), col)
end

function igDebugTextUnformattedWithLocateItem(line_begin, line_end)
    ccall((:igDebugTextUnformattedWithLocateItem, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cchar}), line_begin, line_end)
end

function igDebugLocateItem(target_id)
    ccall((:igDebugLocateItem, libcimgui), Cvoid, (ImGuiID,), target_id)
end

function igDebugLocateItemOnHover(target_id)
    ccall((:igDebugLocateItemOnHover, libcimgui), Cvoid, (ImGuiID,), target_id)
end

function igDebugLocateItemResolveWithLastItem()
    ccall((:igDebugLocateItemResolveWithLastItem, libcimgui), Cvoid, ())
end

function igDebugBreakClearData()
    ccall((:igDebugBreakClearData, libcimgui), Cvoid, ())
end

function igDebugBreakButton(label, description_of_location)
    ccall((:igDebugBreakButton, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cchar}), label, description_of_location)
end

function igDebugBreakButtonTooltip(keyboard_only, description_of_location)
    ccall((:igDebugBreakButtonTooltip, libcimgui), Cvoid, (Bool, Ptr{Cchar}), keyboard_only, description_of_location)
end

function igShowFontAtlas(atlas)
    ccall((:igShowFontAtlas, libcimgui), Cvoid, (Ptr{ImFontAtlas},), atlas)
end

function igDebugHookIdInfo(id, data_type, data_id, data_id_end)
    ccall((:igDebugHookIdInfo, libcimgui), Cvoid, (ImGuiID, ImGuiDataType, Ptr{Cvoid}, Ptr{Cvoid}), id, data_type, data_id, data_id_end)
end

function igDebugNodeColumns(columns)
    ccall((:igDebugNodeColumns, libcimgui), Cvoid, (Ptr{ImGuiOldColumns},), columns)
end

function igDebugNodeDockNode(node, label)
    ccall((:igDebugNodeDockNode, libcimgui), Cvoid, (Ptr{ImGuiDockNode}, Ptr{Cchar}), node, label)
end

function igDebugNodeDrawList(window, viewport, draw_list, label)
    ccall((:igDebugNodeDrawList, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Ptr{ImGuiViewportP}, Ptr{ImDrawList}, Ptr{Cchar}), window, viewport, draw_list, label)
end

function igDebugNodeDrawCmdShowMeshAndBoundingBox(out_draw_list, draw_list, draw_cmd, show_mesh, show_aabb)
    ccall((:igDebugNodeDrawCmdShowMeshAndBoundingBox, libcimgui), Cvoid, (Ptr{ImDrawList}, Ptr{ImDrawList}, Ptr{ImDrawCmd}, Bool, Bool), out_draw_list, draw_list, draw_cmd, show_mesh, show_aabb)
end

function igDebugNodeFont(font)
    ccall((:igDebugNodeFont, libcimgui), Cvoid, (Ptr{ImFont},), font)
end

function igDebugNodeFontGlyph(font, glyph)
    ccall((:igDebugNodeFontGlyph, libcimgui), Cvoid, (Ptr{ImFont}, Ptr{ImFontGlyph}), font, glyph)
end

function igDebugNodeStorage(storage, label)
    ccall((:igDebugNodeStorage, libcimgui), Cvoid, (Ptr{ImGuiStorage}, Ptr{Cchar}), storage, label)
end

function igDebugNodeTabBar(tab_bar, label)
    ccall((:igDebugNodeTabBar, libcimgui), Cvoid, (Ptr{ImGuiTabBar}, Ptr{Cchar}), tab_bar, label)
end

function igDebugNodeTable(table)
    ccall((:igDebugNodeTable, libcimgui), Cvoid, (Ptr{ImGuiTable},), table)
end

function igDebugNodeTableSettings(settings)
    ccall((:igDebugNodeTableSettings, libcimgui), Cvoid, (Ptr{ImGuiTableSettings},), settings)
end

function igDebugNodeInputTextState(state)
    ccall((:igDebugNodeInputTextState, libcimgui), Cvoid, (Ptr{ImGuiInputTextState},), state)
end

function igDebugNodeTypingSelectState(state)
    ccall((:igDebugNodeTypingSelectState, libcimgui), Cvoid, (Ptr{ImGuiTypingSelectState},), state)
end

function igDebugNodeMultiSelectState(state)
    ccall((:igDebugNodeMultiSelectState, libcimgui), Cvoid, (Ptr{ImGuiMultiSelectState},), state)
end

function igDebugNodeWindow(window, label)
    ccall((:igDebugNodeWindow, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Ptr{Cchar}), window, label)
end

function igDebugNodeWindowSettings(settings)
    ccall((:igDebugNodeWindowSettings, libcimgui), Cvoid, (Ptr{ImGuiWindowSettings},), settings)
end

function igDebugNodeWindowsList(windows, label)
    ccall((:igDebugNodeWindowsList, libcimgui), Cvoid, (Ptr{ImVector_ImGuiWindowPtr}, Ptr{Cchar}), windows, label)
end

function igDebugNodeWindowsListByBeginStackParent(windows, windows_size, parent_in_begin_stack)
    ccall((:igDebugNodeWindowsListByBeginStackParent, libcimgui), Cvoid, (Ptr{Ptr{ImGuiWindow}}, Cint, Ptr{ImGuiWindow}), windows, windows_size, parent_in_begin_stack)
end

function igDebugNodeViewport(viewport)
    ccall((:igDebugNodeViewport, libcimgui), Cvoid, (Ptr{ImGuiViewportP},), viewport)
end

function igDebugNodePlatformMonitor(monitor, label, idx)
    ccall((:igDebugNodePlatformMonitor, libcimgui), Cvoid, (Ptr{ImGuiPlatformMonitor}, Ptr{Cchar}, Cint), monitor, label, idx)
end

function igDebugRenderKeyboardPreview(draw_list)
    ccall((:igDebugRenderKeyboardPreview, libcimgui), Cvoid, (Ptr{ImDrawList},), draw_list)
end

function igDebugRenderViewportThumbnail(draw_list, viewport, bb)
    ccall((:igDebugRenderViewportThumbnail, libcimgui), Cvoid, (Ptr{ImDrawList}, Ptr{ImGuiViewportP}, ImRect), draw_list, viewport, bb)
end

function igImFontAtlasGetBuilderForStbTruetype()
    ccall((:igImFontAtlasGetBuilderForStbTruetype, libcimgui), Ptr{ImFontBuilderIO}, ())
end

function igImFontAtlasUpdateConfigDataPointers(atlas)
    ccall((:igImFontAtlasUpdateConfigDataPointers, libcimgui), Cvoid, (Ptr{ImFontAtlas},), atlas)
end

function igImFontAtlasBuildInit(atlas)
    ccall((:igImFontAtlasBuildInit, libcimgui), Cvoid, (Ptr{ImFontAtlas},), atlas)
end

function igImFontAtlasBuildSetupFont(atlas, font, font_config, ascent, descent)
    ccall((:igImFontAtlasBuildSetupFont, libcimgui), Cvoid, (Ptr{ImFontAtlas}, Ptr{ImFont}, Ptr{ImFontConfig}, Cfloat, Cfloat), atlas, font, font_config, ascent, descent)
end

function igImFontAtlasBuildPackCustomRects(atlas, stbrp_context_opaque)
    ccall((:igImFontAtlasBuildPackCustomRects, libcimgui), Cvoid, (Ptr{ImFontAtlas}, Ptr{Cvoid}), atlas, stbrp_context_opaque)
end

function igImFontAtlasBuildFinish(atlas)
    ccall((:igImFontAtlasBuildFinish, libcimgui), Cvoid, (Ptr{ImFontAtlas},), atlas)
end

function igImFontAtlasBuildRender8bppRectFromString(atlas, x, y, w, h, in_str, in_marker_char, in_marker_pixel_value)
    ccall((:igImFontAtlasBuildRender8bppRectFromString, libcimgui), Cvoid, (Ptr{ImFontAtlas}, Cint, Cint, Cint, Cint, Ptr{Cchar}, Cchar, Cuchar), atlas, x, y, w, h, in_str, in_marker_char, in_marker_pixel_value)
end

function igImFontAtlasBuildRender32bppRectFromString(atlas, x, y, w, h, in_str, in_marker_char, in_marker_pixel_value)
    ccall((:igImFontAtlasBuildRender32bppRectFromString, libcimgui), Cvoid, (Ptr{ImFontAtlas}, Cint, Cint, Cint, Cint, Ptr{Cchar}, Cchar, Cuint), atlas, x, y, w, h, in_str, in_marker_char, in_marker_pixel_value)
end

function igImFontAtlasBuildMultiplyCalcLookupTable(out_table, in_multiply_factor)
    ccall((:igImFontAtlasBuildMultiplyCalcLookupTable, libcimgui), Cvoid, (Ptr{Cuchar}, Cfloat), out_table, in_multiply_factor)
end

function igImFontAtlasBuildMultiplyRectAlpha8(table, pixels, x, y, w, h, stride)
    ccall((:igImFontAtlasBuildMultiplyRectAlpha8, libcimgui), Cvoid, (Ptr{Cuchar}, Ptr{Cuchar}, Cint, Cint, Cint, Cint, Cint), table, pixels, x, y, w, h, stride)
end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function igLogText(fmt, va_list...)
        :(@ccall(libcimgui.igLogText(fmt::Ptr{Cchar}; $(to_c_type_pairs(va_list)...))::Cvoid))
    end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function ImGuiTextBuffer_appendf(buffer, fmt, va_list...)
        :(@ccall(libcimgui.ImGuiTextBuffer_appendf(buffer::Ptr{ImGuiTextBuffer}, fmt::Ptr{Cchar}; $(to_c_type_pairs(va_list)...))::Cvoid))
    end

function igGET_FLT_MAX()
    ccall((:igGET_FLT_MAX, libcimgui), Cfloat, ())
end

function igGET_FLT_MIN()
    ccall((:igGET_FLT_MIN, libcimgui), Cfloat, ())
end

function ImVector_ImWchar_create()
    ccall((:ImVector_ImWchar_create, libcimgui), Ptr{ImVector_ImWchar}, ())
end

function ImVector_ImWchar_destroy(self)
    ccall((:ImVector_ImWchar_destroy, libcimgui), Cvoid, (Ptr{ImVector_ImWchar},), self)
end

function ImVector_ImWchar_Init(p)
    ccall((:ImVector_ImWchar_Init, libcimgui), Cvoid, (Ptr{ImVector_ImWchar},), p)
end

function ImVector_ImWchar_UnInit(p)
    ccall((:ImVector_ImWchar_UnInit, libcimgui), Cvoid, (Ptr{ImVector_ImWchar},), p)
end

function ImGuiPlatformIO_Set_Platform_GetWindowPos(platform_io, user_callback)
    ccall((:ImGuiPlatformIO_Set_Platform_GetWindowPos, libcimgui), Cvoid, (Ptr{ImGuiPlatformIO}, Ptr{Cvoid}), platform_io, user_callback)
end

function ImGuiPlatformIO_Set_Platform_GetWindowSize(platform_io, user_callback)
    ccall((:ImGuiPlatformIO_Set_Platform_GetWindowSize, libcimgui), Cvoid, (Ptr{ImGuiPlatformIO}, Ptr{Cvoid}), platform_io, user_callback)
end

const ImPlotFlags = Cint

const ImPlotLocation = Cint

const ImPlotMouseTextFlags = Cint

const ImPlotAxisFlags = Cint

struct ImPlotRange
    Min::Cdouble
    Max::Cdouble
end

const ImPlotCond = Cint

const ImPlotScale = Cint

struct ImPlotTick
    PlotPos::Cdouble
    PixelPos::Cfloat
    LabelSize::ImVec2
    TextOffset::Cint
    Major::Bool
    ShowLabel::Bool
    Level::Cint
    Idx::Cint
end

struct ImVector_ImPlotTick
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImPlotTick}
end

struct ImPlotTicker
    Ticks::ImVector_ImPlotTick
    TextBuffer::ImGuiTextBuffer
    MaxSize::ImVec2
    LateSize::ImVec2
    Levels::Cint
end

# typedef int ( * ImPlotFormatter ) ( double value , char * buff , int size , void * user_data )
const ImPlotFormatter = Ptr{Cvoid}

# typedef void ( * ImPlotLocator ) ( ImPlotTicker * ticker , const ImPlotRange range , float pixels , bool vertical , ImPlotFormatter formatter , void * formatter_data )
const ImPlotLocator = Ptr{Cvoid}

struct ImPlotTime
    S::time_t
    Us::Cint
end

# typedef double ( * ImPlotTransform ) ( double value , void * user_data )
const ImPlotTransform = Ptr{Cvoid}

struct ImPlotAxis
    ID::ImGuiID
    Flags::ImPlotAxisFlags
    PreviousFlags::ImPlotAxisFlags
    Range::ImPlotRange
    RangeCond::ImPlotCond
    Scale::ImPlotScale
    FitExtents::ImPlotRange
    OrthoAxis::Ptr{ImPlotAxis}
    ConstraintRange::ImPlotRange
    ConstraintZoom::ImPlotRange
    Ticker::ImPlotTicker
    Formatter::ImPlotFormatter
    FormatterData::Ptr{Cvoid}
    FormatSpec::NTuple{16, Cchar}
    Locator::ImPlotLocator
    LinkedMin::Ptr{Cdouble}
    LinkedMax::Ptr{Cdouble}
    PickerLevel::Cint
    PickerTimeMin::ImPlotTime
    PickerTimeMax::ImPlotTime
    TransformForward::ImPlotTransform
    TransformInverse::ImPlotTransform
    TransformData::Ptr{Cvoid}
    PixelMin::Cfloat
    PixelMax::Cfloat
    ScaleMin::Cdouble
    ScaleMax::Cdouble
    ScaleToPixel::Cdouble
    Datum1::Cfloat
    Datum2::Cfloat
    HoverRect::ImRect
    LabelOffset::Cint
    ColorMaj::ImU32
    ColorMin::ImU32
    ColorTick::ImU32
    ColorTxt::ImU32
    ColorBg::ImU32
    ColorHov::ImU32
    ColorAct::ImU32
    ColorHiLi::ImU32
    Enabled::Bool
    Vertical::Bool
    FitThisFrame::Bool
    HasRange::Bool
    HasFormatSpec::Bool
    ShowDefaultTicks::Bool
    Hovered::Bool
    Held::Bool
end

const ImPlotLegendFlags = Cint

struct ImPlotLegend
    Flags::ImPlotLegendFlags
    PreviousFlags::ImPlotLegendFlags
    Location::ImPlotLocation
    PreviousLocation::ImPlotLocation
    Scroll::ImVec2
    Indices::ImVector_int
    Labels::ImGuiTextBuffer
    Rect::ImRect
    RectClamped::ImRect
    Hovered::Bool
    Held::Bool
    CanGoInside::Bool
end

struct ImPlotItem
    ID::ImGuiID
    Color::ImU32
    LegendHoverRect::ImRect
    NameOffset::Cint
    Show::Bool
    LegendHovered::Bool
    SeenThisFrame::Bool
end

struct ImVector_ImPlotItem
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImPlotItem}
end

struct ImPool_ImPlotItem
    Buf::ImVector_ImPlotItem
    Map::ImGuiStorage
    FreeIdx::ImPoolIdx
    AliveCount::ImPoolIdx
end

struct ImPlotItemGroup
    ID::ImGuiID
    Legend::ImPlotLegend
    ItemPool::ImPool_ImPlotItem
    ColormapIdx::Cint
end

const ImAxis = Cint

struct ImPlotPlot
    ID::ImGuiID
    Flags::ImPlotFlags
    PreviousFlags::ImPlotFlags
    MouseTextLocation::ImPlotLocation
    MouseTextFlags::ImPlotMouseTextFlags
    Axes::NTuple{6, ImPlotAxis}
    TextBuffer::ImGuiTextBuffer
    Items::ImPlotItemGroup
    CurrentX::ImAxis
    CurrentY::ImAxis
    FrameRect::ImRect
    CanvasRect::ImRect
    PlotRect::ImRect
    AxesRect::ImRect
    SelectRect::ImRect
    SelectStart::ImVec2
    TitleOffset::Cint
    JustCreated::Bool
    Initialized::Bool
    SetupLocked::Bool
    FitThisFrame::Bool
    Hovered::Bool
    Held::Bool
    Selecting::Bool
    Selected::Bool
    ContextLocked::Bool
end

struct ImVector_ImPlotPlot
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImPlotPlot}
end

struct ImPool_ImPlotPlot
    Buf::ImVector_ImPlotPlot
    Map::ImGuiStorage
    FreeIdx::ImPoolIdx
    AliveCount::ImPoolIdx
end

const ImPlotSubplotFlags = Cint

struct ImPlotAlignmentData
    Vertical::Bool
    PadA::Cfloat
    PadB::Cfloat
    PadAMax::Cfloat
    PadBMax::Cfloat
end

struct ImVector_ImPlotAlignmentData
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImPlotAlignmentData}
end

struct ImVector_ImPlotRange
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImPlotRange}
end

struct ImPlotSubplot
    ID::ImGuiID
    Flags::ImPlotSubplotFlags
    PreviousFlags::ImPlotSubplotFlags
    Items::ImPlotItemGroup
    Rows::Cint
    Cols::Cint
    CurrentIdx::Cint
    FrameRect::ImRect
    GridRect::ImRect
    CellSize::ImVec2
    RowAlignmentData::ImVector_ImPlotAlignmentData
    ColAlignmentData::ImVector_ImPlotAlignmentData
    RowRatios::ImVector_float
    ColRatios::ImVector_float
    RowLinkData::ImVector_ImPlotRange
    ColLinkData::ImVector_ImPlotRange
    TempSizes::NTuple{2, Cfloat}
    FrameHovered::Bool
    HasTitle::Bool
end

struct ImVector_ImPlotSubplot
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImPlotSubplot}
end

struct ImPool_ImPlotSubplot
    Buf::ImVector_ImPlotSubplot
    Map::ImGuiStorage
    FreeIdx::ImPoolIdx
    AliveCount::ImPoolIdx
end

struct ImPlotAnnotation
    Pos::ImVec2
    Offset::ImVec2
    ColorBg::ImU32
    ColorFg::ImU32
    TextOffset::Cint
    Clamp::Bool
end

struct ImVector_ImPlotAnnotation
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImPlotAnnotation}
end

struct ImPlotAnnotationCollection
    Annotations::ImVector_ImPlotAnnotation
    TextBuffer::ImGuiTextBuffer
    Size::Cint
end

struct ImPlotTag
    Axis::ImAxis
    Value::Cdouble
    ColorBg::ImU32
    ColorFg::ImU32
    TextOffset::Cint
end

struct ImVector_ImPlotTag
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImPlotTag}
end

struct ImPlotTagCollection
    Tags::ImVector_ImPlotTag
    TextBuffer::ImGuiTextBuffer
    Size::Cint
end

const ImPlotColormap = Cint

struct ImPlotStyle
    LineWeight::Cfloat
    Marker::Cint
    MarkerSize::Cfloat
    MarkerWeight::Cfloat
    FillAlpha::Cfloat
    ErrorBarSize::Cfloat
    ErrorBarWeight::Cfloat
    DigitalBitHeight::Cfloat
    DigitalBitGap::Cfloat
    PlotBorderSize::Cfloat
    MinorAlpha::Cfloat
    MajorTickLen::ImVec2
    MinorTickLen::ImVec2
    MajorTickSize::ImVec2
    MinorTickSize::ImVec2
    MajorGridSize::ImVec2
    MinorGridSize::ImVec2
    PlotPadding::ImVec2
    LabelPadding::ImVec2
    LegendPadding::ImVec2
    LegendInnerPadding::ImVec2
    LegendSpacing::ImVec2
    MousePosPadding::ImVec2
    AnnotationPadding::ImVec2
    FitPadding::ImVec2
    PlotDefaultSize::ImVec2
    PlotMinSize::ImVec2
    Colors::NTuple{21, ImVec4}
    Colormap::ImPlotColormap
    UseLocalTime::Bool
    UseISO8601::Bool
    Use24HourClock::Bool
end

struct ImVector_bool
    Size::Cint
    Capacity::Cint
    Data::Ptr{Bool}
end

struct ImPlotColormapData
    Keys::ImVector_ImU32
    KeyCounts::ImVector_int
    KeyOffsets::ImVector_int
    Tables::ImVector_ImU32
    TableSizes::ImVector_int
    TableOffsets::ImVector_int
    Text::ImGuiTextBuffer
    TextOffsets::ImVector_int
    Quals::ImVector_bool
    Map::ImGuiStorage
    Count::Cint
end

struct ImVector_ImPlotColormap
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImPlotColormap}
end

struct ImVector_double
    Size::Cint
    Capacity::Cint
    Data::Ptr{Cdouble}
end

struct ImPlotNextPlotData
    RangeCond::NTuple{6, ImPlotCond}
    Range::NTuple{6, ImPlotRange}
    HasRange::NTuple{6, Bool}
    Fit::NTuple{6, Bool}
    LinkedMin::NTuple{6, Ptr{Cdouble}}
    LinkedMax::NTuple{6, Ptr{Cdouble}}
end

const ImPlotMarker = Cint

struct ImPlotNextItemData
    Colors::NTuple{5, ImVec4}
    LineWeight::Cfloat
    Marker::ImPlotMarker
    MarkerSize::Cfloat
    MarkerWeight::Cfloat
    FillAlpha::Cfloat
    ErrorBarSize::Cfloat
    ErrorBarWeight::Cfloat
    DigitalBitHeight::Cfloat
    DigitalBitGap::Cfloat
    RenderLine::Bool
    RenderFill::Bool
    RenderMarkerLine::Bool
    RenderMarkerFill::Bool
    HasHidden::Bool
    Hidden::Bool
    HiddenCond::ImPlotCond
end

struct ImPlotInputMap
    Pan::ImGuiMouseButton
    PanMod::Cint
    Fit::ImGuiMouseButton
    Select::ImGuiMouseButton
    SelectCancel::ImGuiMouseButton
    SelectMod::Cint
    SelectHorzMod::Cint
    SelectVertMod::Cint
    Menu::ImGuiMouseButton
    OverrideMod::Cint
    ZoomMod::Cint
    ZoomRate::Cfloat
end

struct ImPool_ImPlotAlignmentData
    Buf::ImVector_ImPlotAlignmentData
    Map::ImGuiStorage
    FreeIdx::ImPoolIdx
    AliveCount::ImPoolIdx
end

struct ImPlotContext
    Plots::ImPool_ImPlotPlot
    Subplots::ImPool_ImPlotSubplot
    CurrentPlot::Ptr{ImPlotPlot}
    CurrentSubplot::Ptr{ImPlotSubplot}
    CurrentItems::Ptr{ImPlotItemGroup}
    CurrentItem::Ptr{ImPlotItem}
    PreviousItem::Ptr{ImPlotItem}
    CTicker::ImPlotTicker
    Annotations::ImPlotAnnotationCollection
    Tags::ImPlotTagCollection
    Style::ImPlotStyle
    ColorModifiers::ImVector_ImGuiColorMod
    StyleModifiers::ImVector_ImGuiStyleMod
    ColormapData::ImPlotColormapData
    ColormapModifiers::ImVector_ImPlotColormap
    Tm::tm
    TempDouble1::ImVector_double
    TempDouble2::ImVector_double
    TempInt1::ImVector_int
    DigitalPlotItemCnt::Cint
    DigitalPlotOffset::Cint
    NextPlotData::ImPlotNextPlotData
    NextItemData::ImPlotNextItemData
    InputMap::ImPlotInputMap
    OpenContextThisFrame::Bool
    MousePosStringBuilder::ImGuiTextBuffer
    SortItems::Ptr{ImPlotItemGroup}
    AlignmentData::ImPool_ImPlotAlignmentData
    CurrentAlignmentH::Ptr{ImPlotAlignmentData}
    CurrentAlignmentV::Ptr{ImPlotAlignmentData}
end

mutable struct ImPlotAxisColor end

struct ImVector_ImS16
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImS16}
end

struct ImVector_ImS32
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImS32}
end

struct ImVector_ImS64
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImS64}
end

struct ImVector_ImS8
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImS8}
end

struct ImVector_ImU16
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImU16}
end

struct ImVector_ImU64
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImU64}
end

struct ImVector_ImU8
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImU8}
end

const ImPlotDragToolFlags = Cint

const ImPlotColormapScaleFlags = Cint

const ImPlotItemFlags = Cint

const ImPlotLineFlags = Cint

const ImPlotScatterFlags = Cint

const ImPlotStairsFlags = Cint

const ImPlotShadedFlags = Cint

const ImPlotBarsFlags = Cint

const ImPlotBarGroupsFlags = Cint

const ImPlotErrorBarsFlags = Cint

const ImPlotStemsFlags = Cint

const ImPlotInfLinesFlags = Cint

const ImPlotPieChartFlags = Cint

const ImPlotHeatmapFlags = Cint

const ImPlotHistogramFlags = Cint

const ImPlotDigitalFlags = Cint

const ImPlotImageFlags = Cint

const ImPlotTextFlags = Cint

const ImPlotDummyFlags = Cint

const ImPlotCol = Cint

const ImPlotStyleVar = Cint

const ImPlotBin = Cint

@cenum ImAxis_::UInt32 begin
    ImAxis_X1 = 0
    ImAxis_X2 = 1
    ImAxis_X3 = 2
    ImAxis_Y1 = 3
    ImAxis_Y2 = 4
    ImAxis_Y3 = 5
    ImAxis_COUNT = 6
end

@cenum ImPlotFlags_::UInt32 begin
    ImPlotFlags_None = 0
    ImPlotFlags_NoTitle = 1
    ImPlotFlags_NoLegend = 2
    ImPlotFlags_NoMouseText = 4
    ImPlotFlags_NoInputs = 8
    ImPlotFlags_NoMenus = 16
    ImPlotFlags_NoBoxSelect = 32
    ImPlotFlags_NoFrame = 64
    ImPlotFlags_Equal = 128
    ImPlotFlags_Crosshairs = 256
    ImPlotFlags_CanvasOnly = 55
end

@cenum ImPlotAxisFlags_::UInt32 begin
    ImPlotAxisFlags_None = 0
    ImPlotAxisFlags_NoLabel = 1
    ImPlotAxisFlags_NoGridLines = 2
    ImPlotAxisFlags_NoTickMarks = 4
    ImPlotAxisFlags_NoTickLabels = 8
    ImPlotAxisFlags_NoInitialFit = 16
    ImPlotAxisFlags_NoMenus = 32
    ImPlotAxisFlags_NoSideSwitch = 64
    ImPlotAxisFlags_NoHighlight = 128
    ImPlotAxisFlags_Opposite = 256
    ImPlotAxisFlags_Foreground = 512
    ImPlotAxisFlags_Invert = 1024
    ImPlotAxisFlags_AutoFit = 2048
    ImPlotAxisFlags_RangeFit = 4096
    ImPlotAxisFlags_PanStretch = 8192
    ImPlotAxisFlags_LockMin = 16384
    ImPlotAxisFlags_LockMax = 32768
    ImPlotAxisFlags_Lock = 49152
    ImPlotAxisFlags_NoDecorations = 15
    ImPlotAxisFlags_AuxDefault = 258
end

@cenum ImPlotSubplotFlags_::UInt32 begin
    ImPlotSubplotFlags_None = 0
    ImPlotSubplotFlags_NoTitle = 1
    ImPlotSubplotFlags_NoLegend = 2
    ImPlotSubplotFlags_NoMenus = 4
    ImPlotSubplotFlags_NoResize = 8
    ImPlotSubplotFlags_NoAlign = 16
    ImPlotSubplotFlags_ShareItems = 32
    ImPlotSubplotFlags_LinkRows = 64
    ImPlotSubplotFlags_LinkCols = 128
    ImPlotSubplotFlags_LinkAllX = 256
    ImPlotSubplotFlags_LinkAllY = 512
    ImPlotSubplotFlags_ColMajor = 1024
end

@cenum ImPlotLegendFlags_::UInt32 begin
    ImPlotLegendFlags_None = 0
    ImPlotLegendFlags_NoButtons = 1
    ImPlotLegendFlags_NoHighlightItem = 2
    ImPlotLegendFlags_NoHighlightAxis = 4
    ImPlotLegendFlags_NoMenus = 8
    ImPlotLegendFlags_Outside = 16
    ImPlotLegendFlags_Horizontal = 32
    ImPlotLegendFlags_Sort = 64
end

@cenum ImPlotMouseTextFlags_::UInt32 begin
    ImPlotMouseTextFlags_None = 0
    ImPlotMouseTextFlags_NoAuxAxes = 1
    ImPlotMouseTextFlags_NoFormat = 2
    ImPlotMouseTextFlags_ShowAlways = 4
end

@cenum ImPlotDragToolFlags_::UInt32 begin
    ImPlotDragToolFlags_None = 0
    ImPlotDragToolFlags_NoCursors = 1
    ImPlotDragToolFlags_NoFit = 2
    ImPlotDragToolFlags_NoInputs = 4
    ImPlotDragToolFlags_Delayed = 8
end

@cenum ImPlotColormapScaleFlags_::UInt32 begin
    ImPlotColormapScaleFlags_None = 0
    ImPlotColormapScaleFlags_NoLabel = 1
    ImPlotColormapScaleFlags_Opposite = 2
    ImPlotColormapScaleFlags_Invert = 4
end

@cenum ImPlotItemFlags_::UInt32 begin
    ImPlotItemFlags_None = 0
    ImPlotItemFlags_NoLegend = 1
    ImPlotItemFlags_NoFit = 2
end

@cenum ImPlotLineFlags_::UInt32 begin
    ImPlotLineFlags_None = 0
    ImPlotLineFlags_Segments = 1024
    ImPlotLineFlags_Loop = 2048
    ImPlotLineFlags_SkipNaN = 4096
    ImPlotLineFlags_NoClip = 8192
    ImPlotLineFlags_Shaded = 16384
end

@cenum ImPlotScatterFlags_::UInt32 begin
    ImPlotScatterFlags_None = 0
    ImPlotScatterFlags_NoClip = 1024
end

@cenum ImPlotStairsFlags_::UInt32 begin
    ImPlotStairsFlags_None = 0
    ImPlotStairsFlags_PreStep = 1024
    ImPlotStairsFlags_Shaded = 2048
end

@cenum ImPlotShadedFlags_::UInt32 begin
    ImPlotShadedFlags_None = 0
end

@cenum ImPlotBarsFlags_::UInt32 begin
    ImPlotBarsFlags_None = 0
    ImPlotBarsFlags_Horizontal = 1024
end

@cenum ImPlotBarGroupsFlags_::UInt32 begin
    ImPlotBarGroupsFlags_None = 0
    ImPlotBarGroupsFlags_Horizontal = 1024
    ImPlotBarGroupsFlags_Stacked = 2048
end

@cenum ImPlotErrorBarsFlags_::UInt32 begin
    ImPlotErrorBarsFlags_None = 0
    ImPlotErrorBarsFlags_Horizontal = 1024
end

@cenum ImPlotStemsFlags_::UInt32 begin
    ImPlotStemsFlags_None = 0
    ImPlotStemsFlags_Horizontal = 1024
end

@cenum ImPlotInfLinesFlags_::UInt32 begin
    ImPlotInfLinesFlags_None = 0
    ImPlotInfLinesFlags_Horizontal = 1024
end

@cenum ImPlotPieChartFlags_::UInt32 begin
    ImPlotPieChartFlags_None = 0
    ImPlotPieChartFlags_Normalize = 1024
    ImPlotPieChartFlags_IgnoreHidden = 2048
end

@cenum ImPlotHeatmapFlags_::UInt32 begin
    ImPlotHeatmapFlags_None = 0
    ImPlotHeatmapFlags_ColMajor = 1024
end

@cenum ImPlotHistogramFlags_::UInt32 begin
    ImPlotHistogramFlags_None = 0
    ImPlotHistogramFlags_Horizontal = 1024
    ImPlotHistogramFlags_Cumulative = 2048
    ImPlotHistogramFlags_Density = 4096
    ImPlotHistogramFlags_NoOutliers = 8192
    ImPlotHistogramFlags_ColMajor = 16384
end

@cenum ImPlotDigitalFlags_::UInt32 begin
    ImPlotDigitalFlags_None = 0
end

@cenum ImPlotImageFlags_::UInt32 begin
    ImPlotImageFlags_None = 0
end

@cenum ImPlotTextFlags_::UInt32 begin
    ImPlotTextFlags_None = 0
    ImPlotTextFlags_Vertical = 1024
end

@cenum ImPlotDummyFlags_::UInt32 begin
    ImPlotDummyFlags_None = 0
end

@cenum ImPlotCond_::UInt32 begin
    ImPlotCond_None = 0
    ImPlotCond_Always = 1
    ImPlotCond_Once = 2
end

@cenum ImPlotCol_::UInt32 begin
    ImPlotCol_Line = 0
    ImPlotCol_Fill = 1
    ImPlotCol_MarkerOutline = 2
    ImPlotCol_MarkerFill = 3
    ImPlotCol_ErrorBar = 4
    ImPlotCol_FrameBg = 5
    ImPlotCol_PlotBg = 6
    ImPlotCol_PlotBorder = 7
    ImPlotCol_LegendBg = 8
    ImPlotCol_LegendBorder = 9
    ImPlotCol_LegendText = 10
    ImPlotCol_TitleText = 11
    ImPlotCol_InlayText = 12
    ImPlotCol_AxisText = 13
    ImPlotCol_AxisGrid = 14
    ImPlotCol_AxisTick = 15
    ImPlotCol_AxisBg = 16
    ImPlotCol_AxisBgHovered = 17
    ImPlotCol_AxisBgActive = 18
    ImPlotCol_Selection = 19
    ImPlotCol_Crosshairs = 20
    ImPlotCol_COUNT = 21
end

@cenum ImPlotStyleVar_::UInt32 begin
    ImPlotStyleVar_LineWeight = 0
    ImPlotStyleVar_Marker = 1
    ImPlotStyleVar_MarkerSize = 2
    ImPlotStyleVar_MarkerWeight = 3
    ImPlotStyleVar_FillAlpha = 4
    ImPlotStyleVar_ErrorBarSize = 5
    ImPlotStyleVar_ErrorBarWeight = 6
    ImPlotStyleVar_DigitalBitHeight = 7
    ImPlotStyleVar_DigitalBitGap = 8
    ImPlotStyleVar_PlotBorderSize = 9
    ImPlotStyleVar_MinorAlpha = 10
    ImPlotStyleVar_MajorTickLen = 11
    ImPlotStyleVar_MinorTickLen = 12
    ImPlotStyleVar_MajorTickSize = 13
    ImPlotStyleVar_MinorTickSize = 14
    ImPlotStyleVar_MajorGridSize = 15
    ImPlotStyleVar_MinorGridSize = 16
    ImPlotStyleVar_PlotPadding = 17
    ImPlotStyleVar_LabelPadding = 18
    ImPlotStyleVar_LegendPadding = 19
    ImPlotStyleVar_LegendInnerPadding = 20
    ImPlotStyleVar_LegendSpacing = 21
    ImPlotStyleVar_MousePosPadding = 22
    ImPlotStyleVar_AnnotationPadding = 23
    ImPlotStyleVar_FitPadding = 24
    ImPlotStyleVar_PlotDefaultSize = 25
    ImPlotStyleVar_PlotMinSize = 26
    ImPlotStyleVar_COUNT = 27
end

@cenum ImPlotScale_::UInt32 begin
    ImPlotScale_Linear = 0
    ImPlotScale_Time = 1
    ImPlotScale_Log10 = 2
    ImPlotScale_SymLog = 3
end

@cenum ImPlotMarker_::Int32 begin
    ImPlotMarker_None = -1
    ImPlotMarker_Circle = 0
    ImPlotMarker_Square = 1
    ImPlotMarker_Diamond = 2
    ImPlotMarker_Up = 3
    ImPlotMarker_Down = 4
    ImPlotMarker_Left = 5
    ImPlotMarker_Right = 6
    ImPlotMarker_Cross = 7
    ImPlotMarker_Plus = 8
    ImPlotMarker_Asterisk = 9
    ImPlotMarker_COUNT = 10
end

@cenum ImPlotColormap_::UInt32 begin
    ImPlotColormap_Deep = 0
    ImPlotColormap_Dark = 1
    ImPlotColormap_Pastel = 2
    ImPlotColormap_Paired = 3
    ImPlotColormap_Viridis = 4
    ImPlotColormap_Plasma = 5
    ImPlotColormap_Hot = 6
    ImPlotColormap_Cool = 7
    ImPlotColormap_Pink = 8
    ImPlotColormap_Jet = 9
    ImPlotColormap_Twilight = 10
    ImPlotColormap_RdBu = 11
    ImPlotColormap_BrBG = 12
    ImPlotColormap_PiYG = 13
    ImPlotColormap_Spectral = 14
    ImPlotColormap_Greys = 15
end

@cenum ImPlotLocation_::UInt32 begin
    ImPlotLocation_Center = 0
    ImPlotLocation_North = 1
    ImPlotLocation_South = 2
    ImPlotLocation_West = 4
    ImPlotLocation_East = 8
    ImPlotLocation_NorthWest = 5
    ImPlotLocation_NorthEast = 9
    ImPlotLocation_SouthWest = 6
    ImPlotLocation_SouthEast = 10
end

@cenum ImPlotBin_::Int32 begin
    ImPlotBin_Sqrt = -1
    ImPlotBin_Sturges = -2
    ImPlotBin_Rice = -3
    ImPlotBin_Scott = -4
end

struct ImPlotPoint
    x::Cdouble
    y::Cdouble
end

struct ImPlotRect
    X::ImPlotRange
    Y::ImPlotRange
end

# typedef ImPlotPoint ( * ImPlotGetter ) ( int idx , void * user_data )
const ImPlotGetter = Ptr{Cvoid}

const ImPlotTimeUnit = Cint

const ImPlotDateFmt = Cint

const ImPlotTimeFmt = Cint

@cenum ImPlotTimeUnit_::UInt32 begin
    ImPlotTimeUnit_Us = 0
    ImPlotTimeUnit_Ms = 1
    ImPlotTimeUnit_S = 2
    ImPlotTimeUnit_Min = 3
    ImPlotTimeUnit_Hr = 4
    ImPlotTimeUnit_Day = 5
    ImPlotTimeUnit_Mo = 6
    ImPlotTimeUnit_Yr = 7
    ImPlotTimeUnit_COUNT = 8
end

@cenum ImPlotDateFmt_::UInt32 begin
    ImPlotDateFmt_None = 0
    ImPlotDateFmt_DayMo = 1
    ImPlotDateFmt_DayMoYr = 2
    ImPlotDateFmt_MoYr = 3
    ImPlotDateFmt_Mo = 4
    ImPlotDateFmt_Yr = 5
end

@cenum ImPlotTimeFmt_::UInt32 begin
    ImPlotTimeFmt_None = 0
    ImPlotTimeFmt_Us = 1
    ImPlotTimeFmt_SUs = 2
    ImPlotTimeFmt_SMs = 3
    ImPlotTimeFmt_S = 4
    ImPlotTimeFmt_MinSMs = 5
    ImPlotTimeFmt_HrMinSMs = 6
    ImPlotTimeFmt_HrMinS = 7
    ImPlotTimeFmt_HrMin = 8
    ImPlotTimeFmt_Hr = 9
end

struct ImPlotDateTimeSpec
    Date::ImPlotDateFmt
    Time::ImPlotTimeFmt
    UseISO8601::Bool
    Use24HourClock::Bool
end

struct ImPlotPointError
    X::Cdouble
    Y::Cdouble
    Neg::Cdouble
    Pos::Cdouble
end

struct Formatter_Time_Data
    Time::ImPlotTime
    Spec::ImPlotDateTimeSpec
    UserFormatter::ImPlotFormatter
    UserFormatterData::Ptr{Cvoid}
end

# typedef void * ( * ImPlotPoint_getter ) ( void * data , int idx , ImPlotPoint * point )
const ImPlotPoint_getter = Ptr{Cvoid}

function ImPlotPoint_ImPlotPoint_Nil()
    ccall((:ImPlotPoint_ImPlotPoint_Nil, libcimgui), Ptr{ImPlotPoint}, ())
end

function ImPlotPoint_destroy(self)
    ccall((:ImPlotPoint_destroy, libcimgui), Cvoid, (Ptr{ImPlotPoint},), self)
end

function ImPlotPoint_ImPlotPoint_double(_x, _y)
    ccall((:ImPlotPoint_ImPlotPoint_double, libcimgui), Ptr{ImPlotPoint}, (Cdouble, Cdouble), _x, _y)
end

function ImPlotPoint_ImPlotPoint_Vec2(p)
    ccall((:ImPlotPoint_ImPlotPoint_Vec2, libcimgui), Ptr{ImPlotPoint}, (ImVec2,), p)
end

function ImPlotRange_ImPlotRange_Nil()
    ccall((:ImPlotRange_ImPlotRange_Nil, libcimgui), Ptr{ImPlotRange}, ())
end

function ImPlotRange_destroy(self)
    ccall((:ImPlotRange_destroy, libcimgui), Cvoid, (Ptr{ImPlotRange},), self)
end

function ImPlotRange_ImPlotRange_double(_min, _max)
    ccall((:ImPlotRange_ImPlotRange_double, libcimgui), Ptr{ImPlotRange}, (Cdouble, Cdouble), _min, _max)
end

function ImPlotRange_Contains(self, value)
    ccall((:ImPlotRange_Contains, libcimgui), Bool, (Ptr{ImPlotRange}, Cdouble), self, value)
end

function ImPlotRange_Size(self)
    ccall((:ImPlotRange_Size, libcimgui), Cdouble, (Ptr{ImPlotRange},), self)
end

function ImPlotRange_Clamp(self, value)
    ccall((:ImPlotRange_Clamp, libcimgui), Cdouble, (Ptr{ImPlotRange}, Cdouble), self, value)
end

function ImPlotRect_ImPlotRect_Nil()
    ccall((:ImPlotRect_ImPlotRect_Nil, libcimgui), Ptr{ImPlotRect}, ())
end

function ImPlotRect_destroy(self)
    ccall((:ImPlotRect_destroy, libcimgui), Cvoid, (Ptr{ImPlotRect},), self)
end

function ImPlotRect_ImPlotRect_double(x_min, x_max, y_min, y_max)
    ccall((:ImPlotRect_ImPlotRect_double, libcimgui), Ptr{ImPlotRect}, (Cdouble, Cdouble, Cdouble, Cdouble), x_min, x_max, y_min, y_max)
end

function ImPlotRect_Contains_PlotPoInt(self, p)
    ccall((:ImPlotRect_Contains_PlotPoInt, libcimgui), Bool, (Ptr{ImPlotRect}, ImPlotPoint), self, p)
end

function ImPlotRect_Contains_double(self, x, y)
    ccall((:ImPlotRect_Contains_double, libcimgui), Bool, (Ptr{ImPlotRect}, Cdouble, Cdouble), self, x, y)
end

function ImPlotRect_Size(pOut, self)
    ccall((:ImPlotRect_Size, libcimgui), Cvoid, (Ptr{ImPlotPoint}, Ptr{ImPlotRect}), pOut, self)
end

function ImPlotRect_Clamp_PlotPoInt(pOut, self, p)
    ccall((:ImPlotRect_Clamp_PlotPoInt, libcimgui), Cvoid, (Ptr{ImPlotPoint}, Ptr{ImPlotRect}, ImPlotPoint), pOut, self, p)
end

function ImPlotRect_Clamp_double(pOut, self, x, y)
    ccall((:ImPlotRect_Clamp_double, libcimgui), Cvoid, (Ptr{ImPlotPoint}, Ptr{ImPlotRect}, Cdouble, Cdouble), pOut, self, x, y)
end

function ImPlotRect_Min(pOut, self)
    ccall((:ImPlotRect_Min, libcimgui), Cvoid, (Ptr{ImPlotPoint}, Ptr{ImPlotRect}), pOut, self)
end

function ImPlotRect_Max(pOut, self)
    ccall((:ImPlotRect_Max, libcimgui), Cvoid, (Ptr{ImPlotPoint}, Ptr{ImPlotRect}), pOut, self)
end

function ImPlotStyle_ImPlotStyle()
    ccall((:ImPlotStyle_ImPlotStyle, libcimgui), Ptr{ImPlotStyle}, ())
end

function ImPlotStyle_destroy(self)
    ccall((:ImPlotStyle_destroy, libcimgui), Cvoid, (Ptr{ImPlotStyle},), self)
end

function ImPlotInputMap_ImPlotInputMap()
    ccall((:ImPlotInputMap_ImPlotInputMap, libcimgui), Ptr{ImPlotInputMap}, ())
end

function ImPlotInputMap_destroy(self)
    ccall((:ImPlotInputMap_destroy, libcimgui), Cvoid, (Ptr{ImPlotInputMap},), self)
end

function ImPlot_CreateContext()
    ccall((:ImPlot_CreateContext, libcimgui), Ptr{ImPlotContext}, ())
end

function ImPlot_DestroyContext(ctx)
    ccall((:ImPlot_DestroyContext, libcimgui), Cvoid, (Ptr{ImPlotContext},), ctx)
end

function ImPlot_GetCurrentContext()
    ccall((:ImPlot_GetCurrentContext, libcimgui), Ptr{ImPlotContext}, ())
end

function ImPlot_SetCurrentContext(ctx)
    ccall((:ImPlot_SetCurrentContext, libcimgui), Cvoid, (Ptr{ImPlotContext},), ctx)
end

function ImPlot_SetImGuiContext(ctx)
    ccall((:ImPlot_SetImGuiContext, libcimgui), Cvoid, (Ptr{ImGuiContext},), ctx)
end

function ImPlot_BeginPlot(title_id, size, flags)
    ccall((:ImPlot_BeginPlot, libcimgui), Bool, (Ptr{Cchar}, ImVec2, ImPlotFlags), title_id, size, flags)
end

function ImPlot_EndPlot()
    ccall((:ImPlot_EndPlot, libcimgui), Cvoid, ())
end

function ImPlot_BeginSubplots(title_id, rows, cols, size, flags, row_ratios, col_ratios)
    ccall((:ImPlot_BeginSubplots, libcimgui), Bool, (Ptr{Cchar}, Cint, Cint, ImVec2, ImPlotSubplotFlags, Ptr{Cfloat}, Ptr{Cfloat}), title_id, rows, cols, size, flags, row_ratios, col_ratios)
end

function ImPlot_EndSubplots()
    ccall((:ImPlot_EndSubplots, libcimgui), Cvoid, ())
end

function ImPlot_SetupAxis(axis, label, flags)
    ccall((:ImPlot_SetupAxis, libcimgui), Cvoid, (ImAxis, Ptr{Cchar}, ImPlotAxisFlags), axis, label, flags)
end

function ImPlot_SetupAxisLimits(axis, v_min, v_max, cond)
    ccall((:ImPlot_SetupAxisLimits, libcimgui), Cvoid, (ImAxis, Cdouble, Cdouble, ImPlotCond), axis, v_min, v_max, cond)
end

function ImPlot_SetupAxisLinks(axis, link_min, link_max)
    ccall((:ImPlot_SetupAxisLinks, libcimgui), Cvoid, (ImAxis, Ptr{Cdouble}, Ptr{Cdouble}), axis, link_min, link_max)
end

function ImPlot_SetupAxisFormat_Str(axis, fmt)
    ccall((:ImPlot_SetupAxisFormat_Str, libcimgui), Cvoid, (ImAxis, Ptr{Cchar}), axis, fmt)
end

function ImPlot_SetupAxisFormat_PlotFormatter(axis, formatter, data)
    ccall((:ImPlot_SetupAxisFormat_PlotFormatter, libcimgui), Cvoid, (ImAxis, ImPlotFormatter, Ptr{Cvoid}), axis, formatter, data)
end

function ImPlot_SetupAxisTicks_doublePtr(axis, values, n_ticks, labels, keep_default)
    ccall((:ImPlot_SetupAxisTicks_doublePtr, libcimgui), Cvoid, (ImAxis, Ptr{Cdouble}, Cint, Ptr{Ptr{Cchar}}, Bool), axis, values, n_ticks, labels, keep_default)
end

function ImPlot_SetupAxisTicks_double(axis, v_min, v_max, n_ticks, labels, keep_default)
    ccall((:ImPlot_SetupAxisTicks_double, libcimgui), Cvoid, (ImAxis, Cdouble, Cdouble, Cint, Ptr{Ptr{Cchar}}, Bool), axis, v_min, v_max, n_ticks, labels, keep_default)
end

function ImPlot_SetupAxisScale_PlotScale(axis, scale)
    ccall((:ImPlot_SetupAxisScale_PlotScale, libcimgui), Cvoid, (ImAxis, ImPlotScale), axis, scale)
end

function ImPlot_SetupAxisScale_PlotTransform(axis, forward, inverse, data)
    ccall((:ImPlot_SetupAxisScale_PlotTransform, libcimgui), Cvoid, (ImAxis, ImPlotTransform, ImPlotTransform, Ptr{Cvoid}), axis, forward, inverse, data)
end

function ImPlot_SetupAxisLimitsConstraints(axis, v_min, v_max)
    ccall((:ImPlot_SetupAxisLimitsConstraints, libcimgui), Cvoid, (ImAxis, Cdouble, Cdouble), axis, v_min, v_max)
end

function ImPlot_SetupAxisZoomConstraints(axis, z_min, z_max)
    ccall((:ImPlot_SetupAxisZoomConstraints, libcimgui), Cvoid, (ImAxis, Cdouble, Cdouble), axis, z_min, z_max)
end

function ImPlot_SetupAxes(x_label, y_label, x_flags, y_flags)
    ccall((:ImPlot_SetupAxes, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cchar}, ImPlotAxisFlags, ImPlotAxisFlags), x_label, y_label, x_flags, y_flags)
end

function ImPlot_SetupAxesLimits(x_min, x_max, y_min, y_max, cond)
    ccall((:ImPlot_SetupAxesLimits, libcimgui), Cvoid, (Cdouble, Cdouble, Cdouble, Cdouble, ImPlotCond), x_min, x_max, y_min, y_max, cond)
end

function ImPlot_SetupLegend(location, flags)
    ccall((:ImPlot_SetupLegend, libcimgui), Cvoid, (ImPlotLocation, ImPlotLegendFlags), location, flags)
end

function ImPlot_SetupMouseText(location, flags)
    ccall((:ImPlot_SetupMouseText, libcimgui), Cvoid, (ImPlotLocation, ImPlotMouseTextFlags), location, flags)
end

function ImPlot_SetupFinish()
    ccall((:ImPlot_SetupFinish, libcimgui), Cvoid, ())
end

function ImPlot_SetNextAxisLimits(axis, v_min, v_max, cond)
    ccall((:ImPlot_SetNextAxisLimits, libcimgui), Cvoid, (ImAxis, Cdouble, Cdouble, ImPlotCond), axis, v_min, v_max, cond)
end

function ImPlot_SetNextAxisLinks(axis, link_min, link_max)
    ccall((:ImPlot_SetNextAxisLinks, libcimgui), Cvoid, (ImAxis, Ptr{Cdouble}, Ptr{Cdouble}), axis, link_min, link_max)
end

function ImPlot_SetNextAxisToFit(axis)
    ccall((:ImPlot_SetNextAxisToFit, libcimgui), Cvoid, (ImAxis,), axis)
end

function ImPlot_SetNextAxesLimits(x_min, x_max, y_min, y_max, cond)
    ccall((:ImPlot_SetNextAxesLimits, libcimgui), Cvoid, (Cdouble, Cdouble, Cdouble, Cdouble, ImPlotCond), x_min, x_max, y_min, y_max, cond)
end

function ImPlot_SetNextAxesToFit()
    ccall((:ImPlot_SetNextAxesToFit, libcimgui), Cvoid, ())
end

function ImPlot_PlotLine_FloatPtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotLine_FloatPtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cfloat}, Cint, Cdouble, Cdouble, ImPlotLineFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotLine_doublePtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotLine_doublePtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cdouble}, Cint, Cdouble, Cdouble, ImPlotLineFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotLine_S8PtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotLine_S8PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS8}, Cint, Cdouble, Cdouble, ImPlotLineFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotLine_U8PtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotLine_U8PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU8}, Cint, Cdouble, Cdouble, ImPlotLineFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotLine_S16PtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotLine_S16PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS16}, Cint, Cdouble, Cdouble, ImPlotLineFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotLine_U16PtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotLine_U16PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU16}, Cint, Cdouble, Cdouble, ImPlotLineFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotLine_S32PtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotLine_S32PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS32}, Cint, Cdouble, Cdouble, ImPlotLineFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotLine_U32PtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotLine_U32PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU32}, Cint, Cdouble, Cdouble, ImPlotLineFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotLine_S64PtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotLine_S64PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS64}, Cint, Cdouble, Cdouble, ImPlotLineFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotLine_U64PtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotLine_U64PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU64}, Cint, Cdouble, Cdouble, ImPlotLineFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotLine_FloatPtrFloatPtr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotLine_FloatPtrFloatPtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cfloat}, Ptr{Cfloat}, Cint, ImPlotLineFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotLine_doublePtrdoublePtr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotLine_doublePtrdoublePtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cdouble}, Ptr{Cdouble}, Cint, ImPlotLineFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotLine_S8PtrS8Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotLine_S8PtrS8Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS8}, Ptr{ImS8}, Cint, ImPlotLineFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotLine_U8PtrU8Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotLine_U8PtrU8Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU8}, Ptr{ImU8}, Cint, ImPlotLineFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotLine_S16PtrS16Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotLine_S16PtrS16Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS16}, Ptr{ImS16}, Cint, ImPlotLineFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotLine_U16PtrU16Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotLine_U16PtrU16Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU16}, Ptr{ImU16}, Cint, ImPlotLineFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotLine_S32PtrS32Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotLine_S32PtrS32Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS32}, Ptr{ImS32}, Cint, ImPlotLineFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotLine_U32PtrU32Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotLine_U32PtrU32Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU32}, Ptr{ImU32}, Cint, ImPlotLineFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotLine_S64PtrS64Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotLine_S64PtrS64Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS64}, Ptr{ImS64}, Cint, ImPlotLineFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotLine_U64PtrU64Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotLine_U64PtrU64Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU64}, Ptr{ImU64}, Cint, ImPlotLineFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotLineG(label_id, getter, data, count, flags)
    ccall((:ImPlot_PlotLineG, libcimgui), Cvoid, (Ptr{Cchar}, ImPlotPoint_getter, Ptr{Cvoid}, Cint, ImPlotLineFlags), label_id, getter, data, count, flags)
end

function ImPlot_PlotScatter_FloatPtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotScatter_FloatPtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cfloat}, Cint, Cdouble, Cdouble, ImPlotScatterFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotScatter_doublePtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotScatter_doublePtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cdouble}, Cint, Cdouble, Cdouble, ImPlotScatterFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotScatter_S8PtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotScatter_S8PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS8}, Cint, Cdouble, Cdouble, ImPlotScatterFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotScatter_U8PtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotScatter_U8PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU8}, Cint, Cdouble, Cdouble, ImPlotScatterFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotScatter_S16PtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotScatter_S16PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS16}, Cint, Cdouble, Cdouble, ImPlotScatterFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotScatter_U16PtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotScatter_U16PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU16}, Cint, Cdouble, Cdouble, ImPlotScatterFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotScatter_S32PtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotScatter_S32PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS32}, Cint, Cdouble, Cdouble, ImPlotScatterFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotScatter_U32PtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotScatter_U32PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU32}, Cint, Cdouble, Cdouble, ImPlotScatterFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotScatter_S64PtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotScatter_S64PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS64}, Cint, Cdouble, Cdouble, ImPlotScatterFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotScatter_U64PtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotScatter_U64PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU64}, Cint, Cdouble, Cdouble, ImPlotScatterFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotScatter_FloatPtrFloatPtr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotScatter_FloatPtrFloatPtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cfloat}, Ptr{Cfloat}, Cint, ImPlotScatterFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotScatter_doublePtrdoublePtr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotScatter_doublePtrdoublePtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cdouble}, Ptr{Cdouble}, Cint, ImPlotScatterFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotScatter_S8PtrS8Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotScatter_S8PtrS8Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS8}, Ptr{ImS8}, Cint, ImPlotScatterFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotScatter_U8PtrU8Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotScatter_U8PtrU8Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU8}, Ptr{ImU8}, Cint, ImPlotScatterFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotScatter_S16PtrS16Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotScatter_S16PtrS16Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS16}, Ptr{ImS16}, Cint, ImPlotScatterFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotScatter_U16PtrU16Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotScatter_U16PtrU16Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU16}, Ptr{ImU16}, Cint, ImPlotScatterFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotScatter_S32PtrS32Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotScatter_S32PtrS32Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS32}, Ptr{ImS32}, Cint, ImPlotScatterFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotScatter_U32PtrU32Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotScatter_U32PtrU32Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU32}, Ptr{ImU32}, Cint, ImPlotScatterFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotScatter_S64PtrS64Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotScatter_S64PtrS64Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS64}, Ptr{ImS64}, Cint, ImPlotScatterFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotScatter_U64PtrU64Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotScatter_U64PtrU64Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU64}, Ptr{ImU64}, Cint, ImPlotScatterFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotScatterG(label_id, getter, data, count, flags)
    ccall((:ImPlot_PlotScatterG, libcimgui), Cvoid, (Ptr{Cchar}, ImPlotPoint_getter, Ptr{Cvoid}, Cint, ImPlotScatterFlags), label_id, getter, data, count, flags)
end

function ImPlot_PlotStairs_FloatPtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotStairs_FloatPtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cfloat}, Cint, Cdouble, Cdouble, ImPlotStairsFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotStairs_doublePtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotStairs_doublePtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cdouble}, Cint, Cdouble, Cdouble, ImPlotStairsFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotStairs_S8PtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotStairs_S8PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS8}, Cint, Cdouble, Cdouble, ImPlotStairsFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotStairs_U8PtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotStairs_U8PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU8}, Cint, Cdouble, Cdouble, ImPlotStairsFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotStairs_S16PtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotStairs_S16PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS16}, Cint, Cdouble, Cdouble, ImPlotStairsFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotStairs_U16PtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotStairs_U16PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU16}, Cint, Cdouble, Cdouble, ImPlotStairsFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotStairs_S32PtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotStairs_S32PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS32}, Cint, Cdouble, Cdouble, ImPlotStairsFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotStairs_U32PtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotStairs_U32PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU32}, Cint, Cdouble, Cdouble, ImPlotStairsFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotStairs_S64PtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotStairs_S64PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS64}, Cint, Cdouble, Cdouble, ImPlotStairsFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotStairs_U64PtrInt(label_id, values, count, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotStairs_U64PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU64}, Cint, Cdouble, Cdouble, ImPlotStairsFlags, Cint, Cint), label_id, values, count, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotStairs_FloatPtrFloatPtr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotStairs_FloatPtrFloatPtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cfloat}, Ptr{Cfloat}, Cint, ImPlotStairsFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotStairs_doublePtrdoublePtr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotStairs_doublePtrdoublePtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cdouble}, Ptr{Cdouble}, Cint, ImPlotStairsFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotStairs_S8PtrS8Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotStairs_S8PtrS8Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS8}, Ptr{ImS8}, Cint, ImPlotStairsFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotStairs_U8PtrU8Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotStairs_U8PtrU8Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU8}, Ptr{ImU8}, Cint, ImPlotStairsFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotStairs_S16PtrS16Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotStairs_S16PtrS16Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS16}, Ptr{ImS16}, Cint, ImPlotStairsFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotStairs_U16PtrU16Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotStairs_U16PtrU16Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU16}, Ptr{ImU16}, Cint, ImPlotStairsFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotStairs_S32PtrS32Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotStairs_S32PtrS32Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS32}, Ptr{ImS32}, Cint, ImPlotStairsFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotStairs_U32PtrU32Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotStairs_U32PtrU32Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU32}, Ptr{ImU32}, Cint, ImPlotStairsFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotStairs_S64PtrS64Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotStairs_S64PtrS64Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS64}, Ptr{ImS64}, Cint, ImPlotStairsFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotStairs_U64PtrU64Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotStairs_U64PtrU64Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU64}, Ptr{ImU64}, Cint, ImPlotStairsFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotStairsG(label_id, getter, data, count, flags)
    ccall((:ImPlot_PlotStairsG, libcimgui), Cvoid, (Ptr{Cchar}, ImPlotPoint_getter, Ptr{Cvoid}, Cint, ImPlotStairsFlags), label_id, getter, data, count, flags)
end

function ImPlot_PlotShaded_FloatPtrInt(label_id, values, count, yref, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_FloatPtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cfloat}, Cint, Cdouble, Cdouble, Cdouble, ImPlotShadedFlags, Cint, Cint), label_id, values, count, yref, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotShaded_doublePtrInt(label_id, values, count, yref, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_doublePtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cdouble}, Cint, Cdouble, Cdouble, Cdouble, ImPlotShadedFlags, Cint, Cint), label_id, values, count, yref, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotShaded_S8PtrInt(label_id, values, count, yref, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_S8PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS8}, Cint, Cdouble, Cdouble, Cdouble, ImPlotShadedFlags, Cint, Cint), label_id, values, count, yref, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotShaded_U8PtrInt(label_id, values, count, yref, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_U8PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU8}, Cint, Cdouble, Cdouble, Cdouble, ImPlotShadedFlags, Cint, Cint), label_id, values, count, yref, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotShaded_S16PtrInt(label_id, values, count, yref, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_S16PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS16}, Cint, Cdouble, Cdouble, Cdouble, ImPlotShadedFlags, Cint, Cint), label_id, values, count, yref, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotShaded_U16PtrInt(label_id, values, count, yref, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_U16PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU16}, Cint, Cdouble, Cdouble, Cdouble, ImPlotShadedFlags, Cint, Cint), label_id, values, count, yref, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotShaded_S32PtrInt(label_id, values, count, yref, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_S32PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS32}, Cint, Cdouble, Cdouble, Cdouble, ImPlotShadedFlags, Cint, Cint), label_id, values, count, yref, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotShaded_U32PtrInt(label_id, values, count, yref, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_U32PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU32}, Cint, Cdouble, Cdouble, Cdouble, ImPlotShadedFlags, Cint, Cint), label_id, values, count, yref, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotShaded_S64PtrInt(label_id, values, count, yref, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_S64PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS64}, Cint, Cdouble, Cdouble, Cdouble, ImPlotShadedFlags, Cint, Cint), label_id, values, count, yref, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotShaded_U64PtrInt(label_id, values, count, yref, xscale, xstart, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_U64PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU64}, Cint, Cdouble, Cdouble, Cdouble, ImPlotShadedFlags, Cint, Cint), label_id, values, count, yref, xscale, xstart, flags, offset, stride)
end

function ImPlot_PlotShaded_FloatPtrFloatPtrInt(label_id, xs, ys, count, yref, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_FloatPtrFloatPtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cfloat}, Ptr{Cfloat}, Cint, Cdouble, ImPlotShadedFlags, Cint, Cint), label_id, xs, ys, count, yref, flags, offset, stride)
end

function ImPlot_PlotShaded_doublePtrdoublePtrInt(label_id, xs, ys, count, yref, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_doublePtrdoublePtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cdouble}, Ptr{Cdouble}, Cint, Cdouble, ImPlotShadedFlags, Cint, Cint), label_id, xs, ys, count, yref, flags, offset, stride)
end

function ImPlot_PlotShaded_S8PtrS8PtrInt(label_id, xs, ys, count, yref, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_S8PtrS8PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS8}, Ptr{ImS8}, Cint, Cdouble, ImPlotShadedFlags, Cint, Cint), label_id, xs, ys, count, yref, flags, offset, stride)
end

function ImPlot_PlotShaded_U8PtrU8PtrInt(label_id, xs, ys, count, yref, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_U8PtrU8PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU8}, Ptr{ImU8}, Cint, Cdouble, ImPlotShadedFlags, Cint, Cint), label_id, xs, ys, count, yref, flags, offset, stride)
end

function ImPlot_PlotShaded_S16PtrS16PtrInt(label_id, xs, ys, count, yref, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_S16PtrS16PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS16}, Ptr{ImS16}, Cint, Cdouble, ImPlotShadedFlags, Cint, Cint), label_id, xs, ys, count, yref, flags, offset, stride)
end

function ImPlot_PlotShaded_U16PtrU16PtrInt(label_id, xs, ys, count, yref, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_U16PtrU16PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU16}, Ptr{ImU16}, Cint, Cdouble, ImPlotShadedFlags, Cint, Cint), label_id, xs, ys, count, yref, flags, offset, stride)
end

function ImPlot_PlotShaded_S32PtrS32PtrInt(label_id, xs, ys, count, yref, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_S32PtrS32PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS32}, Ptr{ImS32}, Cint, Cdouble, ImPlotShadedFlags, Cint, Cint), label_id, xs, ys, count, yref, flags, offset, stride)
end

function ImPlot_PlotShaded_U32PtrU32PtrInt(label_id, xs, ys, count, yref, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_U32PtrU32PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU32}, Ptr{ImU32}, Cint, Cdouble, ImPlotShadedFlags, Cint, Cint), label_id, xs, ys, count, yref, flags, offset, stride)
end

function ImPlot_PlotShaded_S64PtrS64PtrInt(label_id, xs, ys, count, yref, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_S64PtrS64PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS64}, Ptr{ImS64}, Cint, Cdouble, ImPlotShadedFlags, Cint, Cint), label_id, xs, ys, count, yref, flags, offset, stride)
end

function ImPlot_PlotShaded_U64PtrU64PtrInt(label_id, xs, ys, count, yref, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_U64PtrU64PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU64}, Ptr{ImU64}, Cint, Cdouble, ImPlotShadedFlags, Cint, Cint), label_id, xs, ys, count, yref, flags, offset, stride)
end

function ImPlot_PlotShaded_FloatPtrFloatPtrFloatPtr(label_id, xs, ys1, ys2, count, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_FloatPtrFloatPtrFloatPtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Cint, ImPlotShadedFlags, Cint, Cint), label_id, xs, ys1, ys2, count, flags, offset, stride)
end

function ImPlot_PlotShaded_doublePtrdoublePtrdoublePtr(label_id, xs, ys1, ys2, count, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_doublePtrdoublePtrdoublePtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Cint, ImPlotShadedFlags, Cint, Cint), label_id, xs, ys1, ys2, count, flags, offset, stride)
end

function ImPlot_PlotShaded_S8PtrS8PtrS8Ptr(label_id, xs, ys1, ys2, count, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_S8PtrS8PtrS8Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS8}, Ptr{ImS8}, Ptr{ImS8}, Cint, ImPlotShadedFlags, Cint, Cint), label_id, xs, ys1, ys2, count, flags, offset, stride)
end

function ImPlot_PlotShaded_U8PtrU8PtrU8Ptr(label_id, xs, ys1, ys2, count, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_U8PtrU8PtrU8Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU8}, Ptr{ImU8}, Ptr{ImU8}, Cint, ImPlotShadedFlags, Cint, Cint), label_id, xs, ys1, ys2, count, flags, offset, stride)
end

function ImPlot_PlotShaded_S16PtrS16PtrS16Ptr(label_id, xs, ys1, ys2, count, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_S16PtrS16PtrS16Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS16}, Ptr{ImS16}, Ptr{ImS16}, Cint, ImPlotShadedFlags, Cint, Cint), label_id, xs, ys1, ys2, count, flags, offset, stride)
end

function ImPlot_PlotShaded_U16PtrU16PtrU16Ptr(label_id, xs, ys1, ys2, count, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_U16PtrU16PtrU16Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU16}, Ptr{ImU16}, Ptr{ImU16}, Cint, ImPlotShadedFlags, Cint, Cint), label_id, xs, ys1, ys2, count, flags, offset, stride)
end

function ImPlot_PlotShaded_S32PtrS32PtrS32Ptr(label_id, xs, ys1, ys2, count, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_S32PtrS32PtrS32Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS32}, Ptr{ImS32}, Ptr{ImS32}, Cint, ImPlotShadedFlags, Cint, Cint), label_id, xs, ys1, ys2, count, flags, offset, stride)
end

function ImPlot_PlotShaded_U32PtrU32PtrU32Ptr(label_id, xs, ys1, ys2, count, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_U32PtrU32PtrU32Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU32}, Ptr{ImU32}, Ptr{ImU32}, Cint, ImPlotShadedFlags, Cint, Cint), label_id, xs, ys1, ys2, count, flags, offset, stride)
end

function ImPlot_PlotShaded_S64PtrS64PtrS64Ptr(label_id, xs, ys1, ys2, count, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_S64PtrS64PtrS64Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS64}, Ptr{ImS64}, Ptr{ImS64}, Cint, ImPlotShadedFlags, Cint, Cint), label_id, xs, ys1, ys2, count, flags, offset, stride)
end

function ImPlot_PlotShaded_U64PtrU64PtrU64Ptr(label_id, xs, ys1, ys2, count, flags, offset, stride)
    ccall((:ImPlot_PlotShaded_U64PtrU64PtrU64Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU64}, Ptr{ImU64}, Ptr{ImU64}, Cint, ImPlotShadedFlags, Cint, Cint), label_id, xs, ys1, ys2, count, flags, offset, stride)
end

function ImPlot_PlotShadedG(label_id, getter1, data1, getter2, data2, count, flags)
    ccall((:ImPlot_PlotShadedG, libcimgui), Cvoid, (Ptr{Cchar}, ImPlotPoint_getter, Ptr{Cvoid}, ImPlotPoint_getter, Ptr{Cvoid}, Cint, ImPlotShadedFlags), label_id, getter1, data1, getter2, data2, count, flags)
end

function ImPlot_PlotBars_FloatPtrInt(label_id, values, count, bar_size, shift, flags, offset, stride)
    ccall((:ImPlot_PlotBars_FloatPtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cfloat}, Cint, Cdouble, Cdouble, ImPlotBarsFlags, Cint, Cint), label_id, values, count, bar_size, shift, flags, offset, stride)
end

function ImPlot_PlotBars_doublePtrInt(label_id, values, count, bar_size, shift, flags, offset, stride)
    ccall((:ImPlot_PlotBars_doublePtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cdouble}, Cint, Cdouble, Cdouble, ImPlotBarsFlags, Cint, Cint), label_id, values, count, bar_size, shift, flags, offset, stride)
end

function ImPlot_PlotBars_S8PtrInt(label_id, values, count, bar_size, shift, flags, offset, stride)
    ccall((:ImPlot_PlotBars_S8PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS8}, Cint, Cdouble, Cdouble, ImPlotBarsFlags, Cint, Cint), label_id, values, count, bar_size, shift, flags, offset, stride)
end

function ImPlot_PlotBars_U8PtrInt(label_id, values, count, bar_size, shift, flags, offset, stride)
    ccall((:ImPlot_PlotBars_U8PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU8}, Cint, Cdouble, Cdouble, ImPlotBarsFlags, Cint, Cint), label_id, values, count, bar_size, shift, flags, offset, stride)
end

function ImPlot_PlotBars_S16PtrInt(label_id, values, count, bar_size, shift, flags, offset, stride)
    ccall((:ImPlot_PlotBars_S16PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS16}, Cint, Cdouble, Cdouble, ImPlotBarsFlags, Cint, Cint), label_id, values, count, bar_size, shift, flags, offset, stride)
end

function ImPlot_PlotBars_U16PtrInt(label_id, values, count, bar_size, shift, flags, offset, stride)
    ccall((:ImPlot_PlotBars_U16PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU16}, Cint, Cdouble, Cdouble, ImPlotBarsFlags, Cint, Cint), label_id, values, count, bar_size, shift, flags, offset, stride)
end

function ImPlot_PlotBars_S32PtrInt(label_id, values, count, bar_size, shift, flags, offset, stride)
    ccall((:ImPlot_PlotBars_S32PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS32}, Cint, Cdouble, Cdouble, ImPlotBarsFlags, Cint, Cint), label_id, values, count, bar_size, shift, flags, offset, stride)
end

function ImPlot_PlotBars_U32PtrInt(label_id, values, count, bar_size, shift, flags, offset, stride)
    ccall((:ImPlot_PlotBars_U32PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU32}, Cint, Cdouble, Cdouble, ImPlotBarsFlags, Cint, Cint), label_id, values, count, bar_size, shift, flags, offset, stride)
end

function ImPlot_PlotBars_S64PtrInt(label_id, values, count, bar_size, shift, flags, offset, stride)
    ccall((:ImPlot_PlotBars_S64PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS64}, Cint, Cdouble, Cdouble, ImPlotBarsFlags, Cint, Cint), label_id, values, count, bar_size, shift, flags, offset, stride)
end

function ImPlot_PlotBars_U64PtrInt(label_id, values, count, bar_size, shift, flags, offset, stride)
    ccall((:ImPlot_PlotBars_U64PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU64}, Cint, Cdouble, Cdouble, ImPlotBarsFlags, Cint, Cint), label_id, values, count, bar_size, shift, flags, offset, stride)
end

function ImPlot_PlotBars_FloatPtrFloatPtr(label_id, xs, ys, count, bar_size, flags, offset, stride)
    ccall((:ImPlot_PlotBars_FloatPtrFloatPtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cfloat}, Ptr{Cfloat}, Cint, Cdouble, ImPlotBarsFlags, Cint, Cint), label_id, xs, ys, count, bar_size, flags, offset, stride)
end

function ImPlot_PlotBars_doublePtrdoublePtr(label_id, xs, ys, count, bar_size, flags, offset, stride)
    ccall((:ImPlot_PlotBars_doublePtrdoublePtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cdouble}, Ptr{Cdouble}, Cint, Cdouble, ImPlotBarsFlags, Cint, Cint), label_id, xs, ys, count, bar_size, flags, offset, stride)
end

function ImPlot_PlotBars_S8PtrS8Ptr(label_id, xs, ys, count, bar_size, flags, offset, stride)
    ccall((:ImPlot_PlotBars_S8PtrS8Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS8}, Ptr{ImS8}, Cint, Cdouble, ImPlotBarsFlags, Cint, Cint), label_id, xs, ys, count, bar_size, flags, offset, stride)
end

function ImPlot_PlotBars_U8PtrU8Ptr(label_id, xs, ys, count, bar_size, flags, offset, stride)
    ccall((:ImPlot_PlotBars_U8PtrU8Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU8}, Ptr{ImU8}, Cint, Cdouble, ImPlotBarsFlags, Cint, Cint), label_id, xs, ys, count, bar_size, flags, offset, stride)
end

function ImPlot_PlotBars_S16PtrS16Ptr(label_id, xs, ys, count, bar_size, flags, offset, stride)
    ccall((:ImPlot_PlotBars_S16PtrS16Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS16}, Ptr{ImS16}, Cint, Cdouble, ImPlotBarsFlags, Cint, Cint), label_id, xs, ys, count, bar_size, flags, offset, stride)
end

function ImPlot_PlotBars_U16PtrU16Ptr(label_id, xs, ys, count, bar_size, flags, offset, stride)
    ccall((:ImPlot_PlotBars_U16PtrU16Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU16}, Ptr{ImU16}, Cint, Cdouble, ImPlotBarsFlags, Cint, Cint), label_id, xs, ys, count, bar_size, flags, offset, stride)
end

function ImPlot_PlotBars_S32PtrS32Ptr(label_id, xs, ys, count, bar_size, flags, offset, stride)
    ccall((:ImPlot_PlotBars_S32PtrS32Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS32}, Ptr{ImS32}, Cint, Cdouble, ImPlotBarsFlags, Cint, Cint), label_id, xs, ys, count, bar_size, flags, offset, stride)
end

function ImPlot_PlotBars_U32PtrU32Ptr(label_id, xs, ys, count, bar_size, flags, offset, stride)
    ccall((:ImPlot_PlotBars_U32PtrU32Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU32}, Ptr{ImU32}, Cint, Cdouble, ImPlotBarsFlags, Cint, Cint), label_id, xs, ys, count, bar_size, flags, offset, stride)
end

function ImPlot_PlotBars_S64PtrS64Ptr(label_id, xs, ys, count, bar_size, flags, offset, stride)
    ccall((:ImPlot_PlotBars_S64PtrS64Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS64}, Ptr{ImS64}, Cint, Cdouble, ImPlotBarsFlags, Cint, Cint), label_id, xs, ys, count, bar_size, flags, offset, stride)
end

function ImPlot_PlotBars_U64PtrU64Ptr(label_id, xs, ys, count, bar_size, flags, offset, stride)
    ccall((:ImPlot_PlotBars_U64PtrU64Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU64}, Ptr{ImU64}, Cint, Cdouble, ImPlotBarsFlags, Cint, Cint), label_id, xs, ys, count, bar_size, flags, offset, stride)
end

function ImPlot_PlotBarsG(label_id, getter, data, count, bar_size, flags)
    ccall((:ImPlot_PlotBarsG, libcimgui), Cvoid, (Ptr{Cchar}, ImPlotPoint_getter, Ptr{Cvoid}, Cint, Cdouble, ImPlotBarsFlags), label_id, getter, data, count, bar_size, flags)
end

function ImPlot_PlotBarGroups_FloatPtr(label_ids, values, item_count, group_count, group_size, shift, flags)
    ccall((:ImPlot_PlotBarGroups_FloatPtr, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{Cfloat}, Cint, Cint, Cdouble, Cdouble, ImPlotBarGroupsFlags), label_ids, values, item_count, group_count, group_size, shift, flags)
end

function ImPlot_PlotBarGroups_doublePtr(label_ids, values, item_count, group_count, group_size, shift, flags)
    ccall((:ImPlot_PlotBarGroups_doublePtr, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{Cdouble}, Cint, Cint, Cdouble, Cdouble, ImPlotBarGroupsFlags), label_ids, values, item_count, group_count, group_size, shift, flags)
end

function ImPlot_PlotBarGroups_S8Ptr(label_ids, values, item_count, group_count, group_size, shift, flags)
    ccall((:ImPlot_PlotBarGroups_S8Ptr, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{ImS8}, Cint, Cint, Cdouble, Cdouble, ImPlotBarGroupsFlags), label_ids, values, item_count, group_count, group_size, shift, flags)
end

function ImPlot_PlotBarGroups_U8Ptr(label_ids, values, item_count, group_count, group_size, shift, flags)
    ccall((:ImPlot_PlotBarGroups_U8Ptr, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{ImU8}, Cint, Cint, Cdouble, Cdouble, ImPlotBarGroupsFlags), label_ids, values, item_count, group_count, group_size, shift, flags)
end

function ImPlot_PlotBarGroups_S16Ptr(label_ids, values, item_count, group_count, group_size, shift, flags)
    ccall((:ImPlot_PlotBarGroups_S16Ptr, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{ImS16}, Cint, Cint, Cdouble, Cdouble, ImPlotBarGroupsFlags), label_ids, values, item_count, group_count, group_size, shift, flags)
end

function ImPlot_PlotBarGroups_U16Ptr(label_ids, values, item_count, group_count, group_size, shift, flags)
    ccall((:ImPlot_PlotBarGroups_U16Ptr, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{ImU16}, Cint, Cint, Cdouble, Cdouble, ImPlotBarGroupsFlags), label_ids, values, item_count, group_count, group_size, shift, flags)
end

function ImPlot_PlotBarGroups_S32Ptr(label_ids, values, item_count, group_count, group_size, shift, flags)
    ccall((:ImPlot_PlotBarGroups_S32Ptr, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{ImS32}, Cint, Cint, Cdouble, Cdouble, ImPlotBarGroupsFlags), label_ids, values, item_count, group_count, group_size, shift, flags)
end

function ImPlot_PlotBarGroups_U32Ptr(label_ids, values, item_count, group_count, group_size, shift, flags)
    ccall((:ImPlot_PlotBarGroups_U32Ptr, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{ImU32}, Cint, Cint, Cdouble, Cdouble, ImPlotBarGroupsFlags), label_ids, values, item_count, group_count, group_size, shift, flags)
end

function ImPlot_PlotBarGroups_S64Ptr(label_ids, values, item_count, group_count, group_size, shift, flags)
    ccall((:ImPlot_PlotBarGroups_S64Ptr, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{ImS64}, Cint, Cint, Cdouble, Cdouble, ImPlotBarGroupsFlags), label_ids, values, item_count, group_count, group_size, shift, flags)
end

function ImPlot_PlotBarGroups_U64Ptr(label_ids, values, item_count, group_count, group_size, shift, flags)
    ccall((:ImPlot_PlotBarGroups_U64Ptr, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{ImU64}, Cint, Cint, Cdouble, Cdouble, ImPlotBarGroupsFlags), label_ids, values, item_count, group_count, group_size, shift, flags)
end

function ImPlot_PlotErrorBars_FloatPtrFloatPtrFloatPtrInt(label_id, xs, ys, err, count, flags, offset, stride)
    ccall((:ImPlot_PlotErrorBars_FloatPtrFloatPtrFloatPtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Cint, ImPlotErrorBarsFlags, Cint, Cint), label_id, xs, ys, err, count, flags, offset, stride)
end

function ImPlot_PlotErrorBars_doublePtrdoublePtrdoublePtrInt(label_id, xs, ys, err, count, flags, offset, stride)
    ccall((:ImPlot_PlotErrorBars_doublePtrdoublePtrdoublePtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Cint, ImPlotErrorBarsFlags, Cint, Cint), label_id, xs, ys, err, count, flags, offset, stride)
end

function ImPlot_PlotErrorBars_S8PtrS8PtrS8PtrInt(label_id, xs, ys, err, count, flags, offset, stride)
    ccall((:ImPlot_PlotErrorBars_S8PtrS8PtrS8PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS8}, Ptr{ImS8}, Ptr{ImS8}, Cint, ImPlotErrorBarsFlags, Cint, Cint), label_id, xs, ys, err, count, flags, offset, stride)
end

function ImPlot_PlotErrorBars_U8PtrU8PtrU8PtrInt(label_id, xs, ys, err, count, flags, offset, stride)
    ccall((:ImPlot_PlotErrorBars_U8PtrU8PtrU8PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU8}, Ptr{ImU8}, Ptr{ImU8}, Cint, ImPlotErrorBarsFlags, Cint, Cint), label_id, xs, ys, err, count, flags, offset, stride)
end

function ImPlot_PlotErrorBars_S16PtrS16PtrS16PtrInt(label_id, xs, ys, err, count, flags, offset, stride)
    ccall((:ImPlot_PlotErrorBars_S16PtrS16PtrS16PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS16}, Ptr{ImS16}, Ptr{ImS16}, Cint, ImPlotErrorBarsFlags, Cint, Cint), label_id, xs, ys, err, count, flags, offset, stride)
end

function ImPlot_PlotErrorBars_U16PtrU16PtrU16PtrInt(label_id, xs, ys, err, count, flags, offset, stride)
    ccall((:ImPlot_PlotErrorBars_U16PtrU16PtrU16PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU16}, Ptr{ImU16}, Ptr{ImU16}, Cint, ImPlotErrorBarsFlags, Cint, Cint), label_id, xs, ys, err, count, flags, offset, stride)
end

function ImPlot_PlotErrorBars_S32PtrS32PtrS32PtrInt(label_id, xs, ys, err, count, flags, offset, stride)
    ccall((:ImPlot_PlotErrorBars_S32PtrS32PtrS32PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS32}, Ptr{ImS32}, Ptr{ImS32}, Cint, ImPlotErrorBarsFlags, Cint, Cint), label_id, xs, ys, err, count, flags, offset, stride)
end

function ImPlot_PlotErrorBars_U32PtrU32PtrU32PtrInt(label_id, xs, ys, err, count, flags, offset, stride)
    ccall((:ImPlot_PlotErrorBars_U32PtrU32PtrU32PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU32}, Ptr{ImU32}, Ptr{ImU32}, Cint, ImPlotErrorBarsFlags, Cint, Cint), label_id, xs, ys, err, count, flags, offset, stride)
end

function ImPlot_PlotErrorBars_S64PtrS64PtrS64PtrInt(label_id, xs, ys, err, count, flags, offset, stride)
    ccall((:ImPlot_PlotErrorBars_S64PtrS64PtrS64PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS64}, Ptr{ImS64}, Ptr{ImS64}, Cint, ImPlotErrorBarsFlags, Cint, Cint), label_id, xs, ys, err, count, flags, offset, stride)
end

function ImPlot_PlotErrorBars_U64PtrU64PtrU64PtrInt(label_id, xs, ys, err, count, flags, offset, stride)
    ccall((:ImPlot_PlotErrorBars_U64PtrU64PtrU64PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU64}, Ptr{ImU64}, Ptr{ImU64}, Cint, ImPlotErrorBarsFlags, Cint, Cint), label_id, xs, ys, err, count, flags, offset, stride)
end

function ImPlot_PlotErrorBars_FloatPtrFloatPtrFloatPtrFloatPtr(label_id, xs, ys, neg, pos, count, flags, offset, stride)
    ccall((:ImPlot_PlotErrorBars_FloatPtrFloatPtrFloatPtrFloatPtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Cint, ImPlotErrorBarsFlags, Cint, Cint), label_id, xs, ys, neg, pos, count, flags, offset, stride)
end

function ImPlot_PlotErrorBars_doublePtrdoublePtrdoublePtrdoublePtr(label_id, xs, ys, neg, pos, count, flags, offset, stride)
    ccall((:ImPlot_PlotErrorBars_doublePtrdoublePtrdoublePtrdoublePtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Cint, ImPlotErrorBarsFlags, Cint, Cint), label_id, xs, ys, neg, pos, count, flags, offset, stride)
end

function ImPlot_PlotErrorBars_S8PtrS8PtrS8PtrS8Ptr(label_id, xs, ys, neg, pos, count, flags, offset, stride)
    ccall((:ImPlot_PlotErrorBars_S8PtrS8PtrS8PtrS8Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS8}, Ptr{ImS8}, Ptr{ImS8}, Ptr{ImS8}, Cint, ImPlotErrorBarsFlags, Cint, Cint), label_id, xs, ys, neg, pos, count, flags, offset, stride)
end

function ImPlot_PlotErrorBars_U8PtrU8PtrU8PtrU8Ptr(label_id, xs, ys, neg, pos, count, flags, offset, stride)
    ccall((:ImPlot_PlotErrorBars_U8PtrU8PtrU8PtrU8Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU8}, Ptr{ImU8}, Ptr{ImU8}, Ptr{ImU8}, Cint, ImPlotErrorBarsFlags, Cint, Cint), label_id, xs, ys, neg, pos, count, flags, offset, stride)
end

function ImPlot_PlotErrorBars_S16PtrS16PtrS16PtrS16Ptr(label_id, xs, ys, neg, pos, count, flags, offset, stride)
    ccall((:ImPlot_PlotErrorBars_S16PtrS16PtrS16PtrS16Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS16}, Ptr{ImS16}, Ptr{ImS16}, Ptr{ImS16}, Cint, ImPlotErrorBarsFlags, Cint, Cint), label_id, xs, ys, neg, pos, count, flags, offset, stride)
end

function ImPlot_PlotErrorBars_U16PtrU16PtrU16PtrU16Ptr(label_id, xs, ys, neg, pos, count, flags, offset, stride)
    ccall((:ImPlot_PlotErrorBars_U16PtrU16PtrU16PtrU16Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU16}, Ptr{ImU16}, Ptr{ImU16}, Ptr{ImU16}, Cint, ImPlotErrorBarsFlags, Cint, Cint), label_id, xs, ys, neg, pos, count, flags, offset, stride)
end

function ImPlot_PlotErrorBars_S32PtrS32PtrS32PtrS32Ptr(label_id, xs, ys, neg, pos, count, flags, offset, stride)
    ccall((:ImPlot_PlotErrorBars_S32PtrS32PtrS32PtrS32Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS32}, Ptr{ImS32}, Ptr{ImS32}, Ptr{ImS32}, Cint, ImPlotErrorBarsFlags, Cint, Cint), label_id, xs, ys, neg, pos, count, flags, offset, stride)
end

function ImPlot_PlotErrorBars_U32PtrU32PtrU32PtrU32Ptr(label_id, xs, ys, neg, pos, count, flags, offset, stride)
    ccall((:ImPlot_PlotErrorBars_U32PtrU32PtrU32PtrU32Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU32}, Ptr{ImU32}, Ptr{ImU32}, Ptr{ImU32}, Cint, ImPlotErrorBarsFlags, Cint, Cint), label_id, xs, ys, neg, pos, count, flags, offset, stride)
end

function ImPlot_PlotErrorBars_S64PtrS64PtrS64PtrS64Ptr(label_id, xs, ys, neg, pos, count, flags, offset, stride)
    ccall((:ImPlot_PlotErrorBars_S64PtrS64PtrS64PtrS64Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS64}, Ptr{ImS64}, Ptr{ImS64}, Ptr{ImS64}, Cint, ImPlotErrorBarsFlags, Cint, Cint), label_id, xs, ys, neg, pos, count, flags, offset, stride)
end

function ImPlot_PlotErrorBars_U64PtrU64PtrU64PtrU64Ptr(label_id, xs, ys, neg, pos, count, flags, offset, stride)
    ccall((:ImPlot_PlotErrorBars_U64PtrU64PtrU64PtrU64Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU64}, Ptr{ImU64}, Ptr{ImU64}, Ptr{ImU64}, Cint, ImPlotErrorBarsFlags, Cint, Cint), label_id, xs, ys, neg, pos, count, flags, offset, stride)
end

function ImPlot_PlotStems_FloatPtrInt(label_id, values, count, ref, scale, start, flags, offset, stride)
    ccall((:ImPlot_PlotStems_FloatPtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cfloat}, Cint, Cdouble, Cdouble, Cdouble, ImPlotStemsFlags, Cint, Cint), label_id, values, count, ref, scale, start, flags, offset, stride)
end

function ImPlot_PlotStems_doublePtrInt(label_id, values, count, ref, scale, start, flags, offset, stride)
    ccall((:ImPlot_PlotStems_doublePtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cdouble}, Cint, Cdouble, Cdouble, Cdouble, ImPlotStemsFlags, Cint, Cint), label_id, values, count, ref, scale, start, flags, offset, stride)
end

function ImPlot_PlotStems_S8PtrInt(label_id, values, count, ref, scale, start, flags, offset, stride)
    ccall((:ImPlot_PlotStems_S8PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS8}, Cint, Cdouble, Cdouble, Cdouble, ImPlotStemsFlags, Cint, Cint), label_id, values, count, ref, scale, start, flags, offset, stride)
end

function ImPlot_PlotStems_U8PtrInt(label_id, values, count, ref, scale, start, flags, offset, stride)
    ccall((:ImPlot_PlotStems_U8PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU8}, Cint, Cdouble, Cdouble, Cdouble, ImPlotStemsFlags, Cint, Cint), label_id, values, count, ref, scale, start, flags, offset, stride)
end

function ImPlot_PlotStems_S16PtrInt(label_id, values, count, ref, scale, start, flags, offset, stride)
    ccall((:ImPlot_PlotStems_S16PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS16}, Cint, Cdouble, Cdouble, Cdouble, ImPlotStemsFlags, Cint, Cint), label_id, values, count, ref, scale, start, flags, offset, stride)
end

function ImPlot_PlotStems_U16PtrInt(label_id, values, count, ref, scale, start, flags, offset, stride)
    ccall((:ImPlot_PlotStems_U16PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU16}, Cint, Cdouble, Cdouble, Cdouble, ImPlotStemsFlags, Cint, Cint), label_id, values, count, ref, scale, start, flags, offset, stride)
end

function ImPlot_PlotStems_S32PtrInt(label_id, values, count, ref, scale, start, flags, offset, stride)
    ccall((:ImPlot_PlotStems_S32PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS32}, Cint, Cdouble, Cdouble, Cdouble, ImPlotStemsFlags, Cint, Cint), label_id, values, count, ref, scale, start, flags, offset, stride)
end

function ImPlot_PlotStems_U32PtrInt(label_id, values, count, ref, scale, start, flags, offset, stride)
    ccall((:ImPlot_PlotStems_U32PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU32}, Cint, Cdouble, Cdouble, Cdouble, ImPlotStemsFlags, Cint, Cint), label_id, values, count, ref, scale, start, flags, offset, stride)
end

function ImPlot_PlotStems_S64PtrInt(label_id, values, count, ref, scale, start, flags, offset, stride)
    ccall((:ImPlot_PlotStems_S64PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS64}, Cint, Cdouble, Cdouble, Cdouble, ImPlotStemsFlags, Cint, Cint), label_id, values, count, ref, scale, start, flags, offset, stride)
end

function ImPlot_PlotStems_U64PtrInt(label_id, values, count, ref, scale, start, flags, offset, stride)
    ccall((:ImPlot_PlotStems_U64PtrInt, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU64}, Cint, Cdouble, Cdouble, Cdouble, ImPlotStemsFlags, Cint, Cint), label_id, values, count, ref, scale, start, flags, offset, stride)
end

function ImPlot_PlotStems_FloatPtrFloatPtr(label_id, xs, ys, count, ref, flags, offset, stride)
    ccall((:ImPlot_PlotStems_FloatPtrFloatPtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cfloat}, Ptr{Cfloat}, Cint, Cdouble, ImPlotStemsFlags, Cint, Cint), label_id, xs, ys, count, ref, flags, offset, stride)
end

function ImPlot_PlotStems_doublePtrdoublePtr(label_id, xs, ys, count, ref, flags, offset, stride)
    ccall((:ImPlot_PlotStems_doublePtrdoublePtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cdouble}, Ptr{Cdouble}, Cint, Cdouble, ImPlotStemsFlags, Cint, Cint), label_id, xs, ys, count, ref, flags, offset, stride)
end

function ImPlot_PlotStems_S8PtrS8Ptr(label_id, xs, ys, count, ref, flags, offset, stride)
    ccall((:ImPlot_PlotStems_S8PtrS8Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS8}, Ptr{ImS8}, Cint, Cdouble, ImPlotStemsFlags, Cint, Cint), label_id, xs, ys, count, ref, flags, offset, stride)
end

function ImPlot_PlotStems_U8PtrU8Ptr(label_id, xs, ys, count, ref, flags, offset, stride)
    ccall((:ImPlot_PlotStems_U8PtrU8Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU8}, Ptr{ImU8}, Cint, Cdouble, ImPlotStemsFlags, Cint, Cint), label_id, xs, ys, count, ref, flags, offset, stride)
end

function ImPlot_PlotStems_S16PtrS16Ptr(label_id, xs, ys, count, ref, flags, offset, stride)
    ccall((:ImPlot_PlotStems_S16PtrS16Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS16}, Ptr{ImS16}, Cint, Cdouble, ImPlotStemsFlags, Cint, Cint), label_id, xs, ys, count, ref, flags, offset, stride)
end

function ImPlot_PlotStems_U16PtrU16Ptr(label_id, xs, ys, count, ref, flags, offset, stride)
    ccall((:ImPlot_PlotStems_U16PtrU16Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU16}, Ptr{ImU16}, Cint, Cdouble, ImPlotStemsFlags, Cint, Cint), label_id, xs, ys, count, ref, flags, offset, stride)
end

function ImPlot_PlotStems_S32PtrS32Ptr(label_id, xs, ys, count, ref, flags, offset, stride)
    ccall((:ImPlot_PlotStems_S32PtrS32Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS32}, Ptr{ImS32}, Cint, Cdouble, ImPlotStemsFlags, Cint, Cint), label_id, xs, ys, count, ref, flags, offset, stride)
end

function ImPlot_PlotStems_U32PtrU32Ptr(label_id, xs, ys, count, ref, flags, offset, stride)
    ccall((:ImPlot_PlotStems_U32PtrU32Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU32}, Ptr{ImU32}, Cint, Cdouble, ImPlotStemsFlags, Cint, Cint), label_id, xs, ys, count, ref, flags, offset, stride)
end

function ImPlot_PlotStems_S64PtrS64Ptr(label_id, xs, ys, count, ref, flags, offset, stride)
    ccall((:ImPlot_PlotStems_S64PtrS64Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS64}, Ptr{ImS64}, Cint, Cdouble, ImPlotStemsFlags, Cint, Cint), label_id, xs, ys, count, ref, flags, offset, stride)
end

function ImPlot_PlotStems_U64PtrU64Ptr(label_id, xs, ys, count, ref, flags, offset, stride)
    ccall((:ImPlot_PlotStems_U64PtrU64Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU64}, Ptr{ImU64}, Cint, Cdouble, ImPlotStemsFlags, Cint, Cint), label_id, xs, ys, count, ref, flags, offset, stride)
end

function ImPlot_PlotInfLines_FloatPtr(label_id, values, count, flags, offset, stride)
    ccall((:ImPlot_PlotInfLines_FloatPtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cfloat}, Cint, ImPlotInfLinesFlags, Cint, Cint), label_id, values, count, flags, offset, stride)
end

function ImPlot_PlotInfLines_doublePtr(label_id, values, count, flags, offset, stride)
    ccall((:ImPlot_PlotInfLines_doublePtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cdouble}, Cint, ImPlotInfLinesFlags, Cint, Cint), label_id, values, count, flags, offset, stride)
end

function ImPlot_PlotInfLines_S8Ptr(label_id, values, count, flags, offset, stride)
    ccall((:ImPlot_PlotInfLines_S8Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS8}, Cint, ImPlotInfLinesFlags, Cint, Cint), label_id, values, count, flags, offset, stride)
end

function ImPlot_PlotInfLines_U8Ptr(label_id, values, count, flags, offset, stride)
    ccall((:ImPlot_PlotInfLines_U8Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU8}, Cint, ImPlotInfLinesFlags, Cint, Cint), label_id, values, count, flags, offset, stride)
end

function ImPlot_PlotInfLines_S16Ptr(label_id, values, count, flags, offset, stride)
    ccall((:ImPlot_PlotInfLines_S16Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS16}, Cint, ImPlotInfLinesFlags, Cint, Cint), label_id, values, count, flags, offset, stride)
end

function ImPlot_PlotInfLines_U16Ptr(label_id, values, count, flags, offset, stride)
    ccall((:ImPlot_PlotInfLines_U16Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU16}, Cint, ImPlotInfLinesFlags, Cint, Cint), label_id, values, count, flags, offset, stride)
end

function ImPlot_PlotInfLines_S32Ptr(label_id, values, count, flags, offset, stride)
    ccall((:ImPlot_PlotInfLines_S32Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS32}, Cint, ImPlotInfLinesFlags, Cint, Cint), label_id, values, count, flags, offset, stride)
end

function ImPlot_PlotInfLines_U32Ptr(label_id, values, count, flags, offset, stride)
    ccall((:ImPlot_PlotInfLines_U32Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU32}, Cint, ImPlotInfLinesFlags, Cint, Cint), label_id, values, count, flags, offset, stride)
end

function ImPlot_PlotInfLines_S64Ptr(label_id, values, count, flags, offset, stride)
    ccall((:ImPlot_PlotInfLines_S64Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS64}, Cint, ImPlotInfLinesFlags, Cint, Cint), label_id, values, count, flags, offset, stride)
end

function ImPlot_PlotInfLines_U64Ptr(label_id, values, count, flags, offset, stride)
    ccall((:ImPlot_PlotInfLines_U64Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU64}, Cint, ImPlotInfLinesFlags, Cint, Cint), label_id, values, count, flags, offset, stride)
end

function ImPlot_PlotPieChart_FloatPtrPlotFormatter(label_ids, values, count, x, y, radius, fmt, fmt_data, angle0, flags)
    ccall((:ImPlot_PlotPieChart_FloatPtrPlotFormatter, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{Cfloat}, Cint, Cdouble, Cdouble, Cdouble, ImPlotFormatter, Ptr{Cvoid}, Cdouble, ImPlotPieChartFlags), label_ids, values, count, x, y, radius, fmt, fmt_data, angle0, flags)
end

function ImPlot_PlotPieChart_doublePtrPlotFormatter(label_ids, values, count, x, y, radius, fmt, fmt_data, angle0, flags)
    ccall((:ImPlot_PlotPieChart_doublePtrPlotFormatter, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{Cdouble}, Cint, Cdouble, Cdouble, Cdouble, ImPlotFormatter, Ptr{Cvoid}, Cdouble, ImPlotPieChartFlags), label_ids, values, count, x, y, radius, fmt, fmt_data, angle0, flags)
end

function ImPlot_PlotPieChart_S8PtrPlotFormatter(label_ids, values, count, x, y, radius, fmt, fmt_data, angle0, flags)
    ccall((:ImPlot_PlotPieChart_S8PtrPlotFormatter, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{ImS8}, Cint, Cdouble, Cdouble, Cdouble, ImPlotFormatter, Ptr{Cvoid}, Cdouble, ImPlotPieChartFlags), label_ids, values, count, x, y, radius, fmt, fmt_data, angle0, flags)
end

function ImPlot_PlotPieChart_U8PtrPlotFormatter(label_ids, values, count, x, y, radius, fmt, fmt_data, angle0, flags)
    ccall((:ImPlot_PlotPieChart_U8PtrPlotFormatter, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{ImU8}, Cint, Cdouble, Cdouble, Cdouble, ImPlotFormatter, Ptr{Cvoid}, Cdouble, ImPlotPieChartFlags), label_ids, values, count, x, y, radius, fmt, fmt_data, angle0, flags)
end

function ImPlot_PlotPieChart_S16PtrPlotFormatter(label_ids, values, count, x, y, radius, fmt, fmt_data, angle0, flags)
    ccall((:ImPlot_PlotPieChart_S16PtrPlotFormatter, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{ImS16}, Cint, Cdouble, Cdouble, Cdouble, ImPlotFormatter, Ptr{Cvoid}, Cdouble, ImPlotPieChartFlags), label_ids, values, count, x, y, radius, fmt, fmt_data, angle0, flags)
end

function ImPlot_PlotPieChart_U16PtrPlotFormatter(label_ids, values, count, x, y, radius, fmt, fmt_data, angle0, flags)
    ccall((:ImPlot_PlotPieChart_U16PtrPlotFormatter, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{ImU16}, Cint, Cdouble, Cdouble, Cdouble, ImPlotFormatter, Ptr{Cvoid}, Cdouble, ImPlotPieChartFlags), label_ids, values, count, x, y, radius, fmt, fmt_data, angle0, flags)
end

function ImPlot_PlotPieChart_S32PtrPlotFormatter(label_ids, values, count, x, y, radius, fmt, fmt_data, angle0, flags)
    ccall((:ImPlot_PlotPieChart_S32PtrPlotFormatter, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{ImS32}, Cint, Cdouble, Cdouble, Cdouble, ImPlotFormatter, Ptr{Cvoid}, Cdouble, ImPlotPieChartFlags), label_ids, values, count, x, y, radius, fmt, fmt_data, angle0, flags)
end

function ImPlot_PlotPieChart_U32PtrPlotFormatter(label_ids, values, count, x, y, radius, fmt, fmt_data, angle0, flags)
    ccall((:ImPlot_PlotPieChart_U32PtrPlotFormatter, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{ImU32}, Cint, Cdouble, Cdouble, Cdouble, ImPlotFormatter, Ptr{Cvoid}, Cdouble, ImPlotPieChartFlags), label_ids, values, count, x, y, radius, fmt, fmt_data, angle0, flags)
end

function ImPlot_PlotPieChart_S64PtrPlotFormatter(label_ids, values, count, x, y, radius, fmt, fmt_data, angle0, flags)
    ccall((:ImPlot_PlotPieChart_S64PtrPlotFormatter, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{ImS64}, Cint, Cdouble, Cdouble, Cdouble, ImPlotFormatter, Ptr{Cvoid}, Cdouble, ImPlotPieChartFlags), label_ids, values, count, x, y, radius, fmt, fmt_data, angle0, flags)
end

function ImPlot_PlotPieChart_U64PtrPlotFormatter(label_ids, values, count, x, y, radius, fmt, fmt_data, angle0, flags)
    ccall((:ImPlot_PlotPieChart_U64PtrPlotFormatter, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{ImU64}, Cint, Cdouble, Cdouble, Cdouble, ImPlotFormatter, Ptr{Cvoid}, Cdouble, ImPlotPieChartFlags), label_ids, values, count, x, y, radius, fmt, fmt_data, angle0, flags)
end

function ImPlot_PlotPieChart_FloatPtrStr(label_ids, values, count, x, y, radius, label_fmt, angle0, flags)
    ccall((:ImPlot_PlotPieChart_FloatPtrStr, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{Cfloat}, Cint, Cdouble, Cdouble, Cdouble, Ptr{Cchar}, Cdouble, ImPlotPieChartFlags), label_ids, values, count, x, y, radius, label_fmt, angle0, flags)
end

function ImPlot_PlotPieChart_doublePtrStr(label_ids, values, count, x, y, radius, label_fmt, angle0, flags)
    ccall((:ImPlot_PlotPieChart_doublePtrStr, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{Cdouble}, Cint, Cdouble, Cdouble, Cdouble, Ptr{Cchar}, Cdouble, ImPlotPieChartFlags), label_ids, values, count, x, y, radius, label_fmt, angle0, flags)
end

function ImPlot_PlotPieChart_S8PtrStr(label_ids, values, count, x, y, radius, label_fmt, angle0, flags)
    ccall((:ImPlot_PlotPieChart_S8PtrStr, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{ImS8}, Cint, Cdouble, Cdouble, Cdouble, Ptr{Cchar}, Cdouble, ImPlotPieChartFlags), label_ids, values, count, x, y, radius, label_fmt, angle0, flags)
end

function ImPlot_PlotPieChart_U8PtrStr(label_ids, values, count, x, y, radius, label_fmt, angle0, flags)
    ccall((:ImPlot_PlotPieChart_U8PtrStr, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{ImU8}, Cint, Cdouble, Cdouble, Cdouble, Ptr{Cchar}, Cdouble, ImPlotPieChartFlags), label_ids, values, count, x, y, radius, label_fmt, angle0, flags)
end

function ImPlot_PlotPieChart_S16PtrStr(label_ids, values, count, x, y, radius, label_fmt, angle0, flags)
    ccall((:ImPlot_PlotPieChart_S16PtrStr, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{ImS16}, Cint, Cdouble, Cdouble, Cdouble, Ptr{Cchar}, Cdouble, ImPlotPieChartFlags), label_ids, values, count, x, y, radius, label_fmt, angle0, flags)
end

function ImPlot_PlotPieChart_U16PtrStr(label_ids, values, count, x, y, radius, label_fmt, angle0, flags)
    ccall((:ImPlot_PlotPieChart_U16PtrStr, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{ImU16}, Cint, Cdouble, Cdouble, Cdouble, Ptr{Cchar}, Cdouble, ImPlotPieChartFlags), label_ids, values, count, x, y, radius, label_fmt, angle0, flags)
end

function ImPlot_PlotPieChart_S32PtrStr(label_ids, values, count, x, y, radius, label_fmt, angle0, flags)
    ccall((:ImPlot_PlotPieChart_S32PtrStr, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{ImS32}, Cint, Cdouble, Cdouble, Cdouble, Ptr{Cchar}, Cdouble, ImPlotPieChartFlags), label_ids, values, count, x, y, radius, label_fmt, angle0, flags)
end

function ImPlot_PlotPieChart_U32PtrStr(label_ids, values, count, x, y, radius, label_fmt, angle0, flags)
    ccall((:ImPlot_PlotPieChart_U32PtrStr, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{ImU32}, Cint, Cdouble, Cdouble, Cdouble, Ptr{Cchar}, Cdouble, ImPlotPieChartFlags), label_ids, values, count, x, y, radius, label_fmt, angle0, flags)
end

function ImPlot_PlotPieChart_S64PtrStr(label_ids, values, count, x, y, radius, label_fmt, angle0, flags)
    ccall((:ImPlot_PlotPieChart_S64PtrStr, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{ImS64}, Cint, Cdouble, Cdouble, Cdouble, Ptr{Cchar}, Cdouble, ImPlotPieChartFlags), label_ids, values, count, x, y, radius, label_fmt, angle0, flags)
end

function ImPlot_PlotPieChart_U64PtrStr(label_ids, values, count, x, y, radius, label_fmt, angle0, flags)
    ccall((:ImPlot_PlotPieChart_U64PtrStr, libcimgui), Cvoid, (Ptr{Ptr{Cchar}}, Ptr{ImU64}, Cint, Cdouble, Cdouble, Cdouble, Ptr{Cchar}, Cdouble, ImPlotPieChartFlags), label_ids, values, count, x, y, radius, label_fmt, angle0, flags)
end

function ImPlot_PlotHeatmap_FloatPtr(label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max, flags)
    ccall((:ImPlot_PlotHeatmap_FloatPtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cfloat}, Cint, Cint, Cdouble, Cdouble, Ptr{Cchar}, ImPlotPoint, ImPlotPoint, ImPlotHeatmapFlags), label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max, flags)
end

function ImPlot_PlotHeatmap_doublePtr(label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max, flags)
    ccall((:ImPlot_PlotHeatmap_doublePtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cdouble}, Cint, Cint, Cdouble, Cdouble, Ptr{Cchar}, ImPlotPoint, ImPlotPoint, ImPlotHeatmapFlags), label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max, flags)
end

function ImPlot_PlotHeatmap_S8Ptr(label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max, flags)
    ccall((:ImPlot_PlotHeatmap_S8Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS8}, Cint, Cint, Cdouble, Cdouble, Ptr{Cchar}, ImPlotPoint, ImPlotPoint, ImPlotHeatmapFlags), label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max, flags)
end

function ImPlot_PlotHeatmap_U8Ptr(label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max, flags)
    ccall((:ImPlot_PlotHeatmap_U8Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU8}, Cint, Cint, Cdouble, Cdouble, Ptr{Cchar}, ImPlotPoint, ImPlotPoint, ImPlotHeatmapFlags), label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max, flags)
end

function ImPlot_PlotHeatmap_S16Ptr(label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max, flags)
    ccall((:ImPlot_PlotHeatmap_S16Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS16}, Cint, Cint, Cdouble, Cdouble, Ptr{Cchar}, ImPlotPoint, ImPlotPoint, ImPlotHeatmapFlags), label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max, flags)
end

function ImPlot_PlotHeatmap_U16Ptr(label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max, flags)
    ccall((:ImPlot_PlotHeatmap_U16Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU16}, Cint, Cint, Cdouble, Cdouble, Ptr{Cchar}, ImPlotPoint, ImPlotPoint, ImPlotHeatmapFlags), label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max, flags)
end

function ImPlot_PlotHeatmap_S32Ptr(label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max, flags)
    ccall((:ImPlot_PlotHeatmap_S32Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS32}, Cint, Cint, Cdouble, Cdouble, Ptr{Cchar}, ImPlotPoint, ImPlotPoint, ImPlotHeatmapFlags), label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max, flags)
end

function ImPlot_PlotHeatmap_U32Ptr(label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max, flags)
    ccall((:ImPlot_PlotHeatmap_U32Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU32}, Cint, Cint, Cdouble, Cdouble, Ptr{Cchar}, ImPlotPoint, ImPlotPoint, ImPlotHeatmapFlags), label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max, flags)
end

function ImPlot_PlotHeatmap_S64Ptr(label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max, flags)
    ccall((:ImPlot_PlotHeatmap_S64Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS64}, Cint, Cint, Cdouble, Cdouble, Ptr{Cchar}, ImPlotPoint, ImPlotPoint, ImPlotHeatmapFlags), label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max, flags)
end

function ImPlot_PlotHeatmap_U64Ptr(label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max, flags)
    ccall((:ImPlot_PlotHeatmap_U64Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU64}, Cint, Cint, Cdouble, Cdouble, Ptr{Cchar}, ImPlotPoint, ImPlotPoint, ImPlotHeatmapFlags), label_id, values, rows, cols, scale_min, scale_max, label_fmt, bounds_min, bounds_max, flags)
end

function ImPlot_PlotHistogram_FloatPtr(label_id, values, count, bins, bar_scale, range, flags)
    ccall((:ImPlot_PlotHistogram_FloatPtr, libcimgui), Cdouble, (Ptr{Cchar}, Ptr{Cfloat}, Cint, Cint, Cdouble, ImPlotRange, ImPlotHistogramFlags), label_id, values, count, bins, bar_scale, range, flags)
end

function ImPlot_PlotHistogram_doublePtr(label_id, values, count, bins, bar_scale, range, flags)
    ccall((:ImPlot_PlotHistogram_doublePtr, libcimgui), Cdouble, (Ptr{Cchar}, Ptr{Cdouble}, Cint, Cint, Cdouble, ImPlotRange, ImPlotHistogramFlags), label_id, values, count, bins, bar_scale, range, flags)
end

function ImPlot_PlotHistogram_S8Ptr(label_id, values, count, bins, bar_scale, range, flags)
    ccall((:ImPlot_PlotHistogram_S8Ptr, libcimgui), Cdouble, (Ptr{Cchar}, Ptr{ImS8}, Cint, Cint, Cdouble, ImPlotRange, ImPlotHistogramFlags), label_id, values, count, bins, bar_scale, range, flags)
end

function ImPlot_PlotHistogram_U8Ptr(label_id, values, count, bins, bar_scale, range, flags)
    ccall((:ImPlot_PlotHistogram_U8Ptr, libcimgui), Cdouble, (Ptr{Cchar}, Ptr{ImU8}, Cint, Cint, Cdouble, ImPlotRange, ImPlotHistogramFlags), label_id, values, count, bins, bar_scale, range, flags)
end

function ImPlot_PlotHistogram_S16Ptr(label_id, values, count, bins, bar_scale, range, flags)
    ccall((:ImPlot_PlotHistogram_S16Ptr, libcimgui), Cdouble, (Ptr{Cchar}, Ptr{ImS16}, Cint, Cint, Cdouble, ImPlotRange, ImPlotHistogramFlags), label_id, values, count, bins, bar_scale, range, flags)
end

function ImPlot_PlotHistogram_U16Ptr(label_id, values, count, bins, bar_scale, range, flags)
    ccall((:ImPlot_PlotHistogram_U16Ptr, libcimgui), Cdouble, (Ptr{Cchar}, Ptr{ImU16}, Cint, Cint, Cdouble, ImPlotRange, ImPlotHistogramFlags), label_id, values, count, bins, bar_scale, range, flags)
end

function ImPlot_PlotHistogram_S32Ptr(label_id, values, count, bins, bar_scale, range, flags)
    ccall((:ImPlot_PlotHistogram_S32Ptr, libcimgui), Cdouble, (Ptr{Cchar}, Ptr{ImS32}, Cint, Cint, Cdouble, ImPlotRange, ImPlotHistogramFlags), label_id, values, count, bins, bar_scale, range, flags)
end

function ImPlot_PlotHistogram_U32Ptr(label_id, values, count, bins, bar_scale, range, flags)
    ccall((:ImPlot_PlotHistogram_U32Ptr, libcimgui), Cdouble, (Ptr{Cchar}, Ptr{ImU32}, Cint, Cint, Cdouble, ImPlotRange, ImPlotHistogramFlags), label_id, values, count, bins, bar_scale, range, flags)
end

function ImPlot_PlotHistogram_S64Ptr(label_id, values, count, bins, bar_scale, range, flags)
    ccall((:ImPlot_PlotHistogram_S64Ptr, libcimgui), Cdouble, (Ptr{Cchar}, Ptr{ImS64}, Cint, Cint, Cdouble, ImPlotRange, ImPlotHistogramFlags), label_id, values, count, bins, bar_scale, range, flags)
end

function ImPlot_PlotHistogram_U64Ptr(label_id, values, count, bins, bar_scale, range, flags)
    ccall((:ImPlot_PlotHistogram_U64Ptr, libcimgui), Cdouble, (Ptr{Cchar}, Ptr{ImU64}, Cint, Cint, Cdouble, ImPlotRange, ImPlotHistogramFlags), label_id, values, count, bins, bar_scale, range, flags)
end

function ImPlot_PlotHistogram2D_FloatPtr(label_id, xs, ys, count, x_bins, y_bins, range, flags)
    ccall((:ImPlot_PlotHistogram2D_FloatPtr, libcimgui), Cdouble, (Ptr{Cchar}, Ptr{Cfloat}, Ptr{Cfloat}, Cint, Cint, Cint, ImPlotRect, ImPlotHistogramFlags), label_id, xs, ys, count, x_bins, y_bins, range, flags)
end

function ImPlot_PlotHistogram2D_doublePtr(label_id, xs, ys, count, x_bins, y_bins, range, flags)
    ccall((:ImPlot_PlotHistogram2D_doublePtr, libcimgui), Cdouble, (Ptr{Cchar}, Ptr{Cdouble}, Ptr{Cdouble}, Cint, Cint, Cint, ImPlotRect, ImPlotHistogramFlags), label_id, xs, ys, count, x_bins, y_bins, range, flags)
end

function ImPlot_PlotHistogram2D_S8Ptr(label_id, xs, ys, count, x_bins, y_bins, range, flags)
    ccall((:ImPlot_PlotHistogram2D_S8Ptr, libcimgui), Cdouble, (Ptr{Cchar}, Ptr{ImS8}, Ptr{ImS8}, Cint, Cint, Cint, ImPlotRect, ImPlotHistogramFlags), label_id, xs, ys, count, x_bins, y_bins, range, flags)
end

function ImPlot_PlotHistogram2D_U8Ptr(label_id, xs, ys, count, x_bins, y_bins, range, flags)
    ccall((:ImPlot_PlotHistogram2D_U8Ptr, libcimgui), Cdouble, (Ptr{Cchar}, Ptr{ImU8}, Ptr{ImU8}, Cint, Cint, Cint, ImPlotRect, ImPlotHistogramFlags), label_id, xs, ys, count, x_bins, y_bins, range, flags)
end

function ImPlot_PlotHistogram2D_S16Ptr(label_id, xs, ys, count, x_bins, y_bins, range, flags)
    ccall((:ImPlot_PlotHistogram2D_S16Ptr, libcimgui), Cdouble, (Ptr{Cchar}, Ptr{ImS16}, Ptr{ImS16}, Cint, Cint, Cint, ImPlotRect, ImPlotHistogramFlags), label_id, xs, ys, count, x_bins, y_bins, range, flags)
end

function ImPlot_PlotHistogram2D_U16Ptr(label_id, xs, ys, count, x_bins, y_bins, range, flags)
    ccall((:ImPlot_PlotHistogram2D_U16Ptr, libcimgui), Cdouble, (Ptr{Cchar}, Ptr{ImU16}, Ptr{ImU16}, Cint, Cint, Cint, ImPlotRect, ImPlotHistogramFlags), label_id, xs, ys, count, x_bins, y_bins, range, flags)
end

function ImPlot_PlotHistogram2D_S32Ptr(label_id, xs, ys, count, x_bins, y_bins, range, flags)
    ccall((:ImPlot_PlotHistogram2D_S32Ptr, libcimgui), Cdouble, (Ptr{Cchar}, Ptr{ImS32}, Ptr{ImS32}, Cint, Cint, Cint, ImPlotRect, ImPlotHistogramFlags), label_id, xs, ys, count, x_bins, y_bins, range, flags)
end

function ImPlot_PlotHistogram2D_U32Ptr(label_id, xs, ys, count, x_bins, y_bins, range, flags)
    ccall((:ImPlot_PlotHistogram2D_U32Ptr, libcimgui), Cdouble, (Ptr{Cchar}, Ptr{ImU32}, Ptr{ImU32}, Cint, Cint, Cint, ImPlotRect, ImPlotHistogramFlags), label_id, xs, ys, count, x_bins, y_bins, range, flags)
end

function ImPlot_PlotHistogram2D_S64Ptr(label_id, xs, ys, count, x_bins, y_bins, range, flags)
    ccall((:ImPlot_PlotHistogram2D_S64Ptr, libcimgui), Cdouble, (Ptr{Cchar}, Ptr{ImS64}, Ptr{ImS64}, Cint, Cint, Cint, ImPlotRect, ImPlotHistogramFlags), label_id, xs, ys, count, x_bins, y_bins, range, flags)
end

function ImPlot_PlotHistogram2D_U64Ptr(label_id, xs, ys, count, x_bins, y_bins, range, flags)
    ccall((:ImPlot_PlotHistogram2D_U64Ptr, libcimgui), Cdouble, (Ptr{Cchar}, Ptr{ImU64}, Ptr{ImU64}, Cint, Cint, Cint, ImPlotRect, ImPlotHistogramFlags), label_id, xs, ys, count, x_bins, y_bins, range, flags)
end

function ImPlot_PlotDigital_FloatPtr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotDigital_FloatPtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cfloat}, Ptr{Cfloat}, Cint, ImPlotDigitalFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotDigital_doublePtr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotDigital_doublePtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cdouble}, Ptr{Cdouble}, Cint, ImPlotDigitalFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotDigital_S8Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotDigital_S8Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS8}, Ptr{ImS8}, Cint, ImPlotDigitalFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotDigital_U8Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotDigital_U8Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU8}, Ptr{ImU8}, Cint, ImPlotDigitalFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotDigital_S16Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotDigital_S16Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS16}, Ptr{ImS16}, Cint, ImPlotDigitalFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotDigital_U16Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotDigital_U16Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU16}, Ptr{ImU16}, Cint, ImPlotDigitalFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotDigital_S32Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotDigital_S32Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS32}, Ptr{ImS32}, Cint, ImPlotDigitalFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotDigital_U32Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotDigital_U32Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU32}, Ptr{ImU32}, Cint, ImPlotDigitalFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotDigital_S64Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotDigital_S64Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImS64}, Ptr{ImS64}, Cint, ImPlotDigitalFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotDigital_U64Ptr(label_id, xs, ys, count, flags, offset, stride)
    ccall((:ImPlot_PlotDigital_U64Ptr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{ImU64}, Ptr{ImU64}, Cint, ImPlotDigitalFlags, Cint, Cint), label_id, xs, ys, count, flags, offset, stride)
end

function ImPlot_PlotDigitalG(label_id, getter, data, count, flags)
    ccall((:ImPlot_PlotDigitalG, libcimgui), Cvoid, (Ptr{Cchar}, ImPlotPoint_getter, Ptr{Cvoid}, Cint, ImPlotDigitalFlags), label_id, getter, data, count, flags)
end

function ImPlot_PlotImage(label_id, user_texture_id, bounds_min, bounds_max, uv0, uv1, tint_col, flags)
    ccall((:ImPlot_PlotImage, libcimgui), Cvoid, (Ptr{Cchar}, ImTextureID, ImPlotPoint, ImPlotPoint, ImVec2, ImVec2, ImVec4, ImPlotImageFlags), label_id, user_texture_id, bounds_min, bounds_max, uv0, uv1, tint_col, flags)
end

function ImPlot_PlotText(text, x, y, pix_offset, flags)
    ccall((:ImPlot_PlotText, libcimgui), Cvoid, (Ptr{Cchar}, Cdouble, Cdouble, ImVec2, ImPlotTextFlags), text, x, y, pix_offset, flags)
end

function ImPlot_PlotDummy(label_id, flags)
    ccall((:ImPlot_PlotDummy, libcimgui), Cvoid, (Ptr{Cchar}, ImPlotDummyFlags), label_id, flags)
end

function ImPlot_DragPoint(id, x, y, col, size, flags, out_clicked, out_hovered, held)
    ccall((:ImPlot_DragPoint, libcimgui), Bool, (Cint, Ptr{Cdouble}, Ptr{Cdouble}, ImVec4, Cfloat, ImPlotDragToolFlags, Ptr{Bool}, Ptr{Bool}, Ptr{Bool}), id, x, y, col, size, flags, out_clicked, out_hovered, held)
end

function ImPlot_DragLineX(id, x, col, thickness, flags, out_clicked, out_hovered, held)
    ccall((:ImPlot_DragLineX, libcimgui), Bool, (Cint, Ptr{Cdouble}, ImVec4, Cfloat, ImPlotDragToolFlags, Ptr{Bool}, Ptr{Bool}, Ptr{Bool}), id, x, col, thickness, flags, out_clicked, out_hovered, held)
end

function ImPlot_DragLineY(id, y, col, thickness, flags, out_clicked, out_hovered, held)
    ccall((:ImPlot_DragLineY, libcimgui), Bool, (Cint, Ptr{Cdouble}, ImVec4, Cfloat, ImPlotDragToolFlags, Ptr{Bool}, Ptr{Bool}, Ptr{Bool}), id, y, col, thickness, flags, out_clicked, out_hovered, held)
end

function ImPlot_DragRect(id, x1, y1, x2, y2, col, flags, out_clicked, out_hovered, held)
    ccall((:ImPlot_DragRect, libcimgui), Bool, (Cint, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, ImVec4, ImPlotDragToolFlags, Ptr{Bool}, Ptr{Bool}, Ptr{Bool}), id, x1, y1, x2, y2, col, flags, out_clicked, out_hovered, held)
end

function ImPlot_Annotation_Bool(x, y, col, pix_offset, clamp, round)
    ccall((:ImPlot_Annotation_Bool, libcimgui), Cvoid, (Cdouble, Cdouble, ImVec4, ImVec2, Bool, Bool), x, y, col, pix_offset, clamp, round)
end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function ImPlot_Annotation_Str(x, y, col, pix_offset, clamp, fmt, va_list...)
        :(@ccall(libcimgui.ImPlot_Annotation_Str(x::Cdouble, y::Cdouble, col::ImVec4, pix_offset::ImVec2, clamp::Bool, fmt::Ptr{Cchar}; $(to_c_type_pairs(va_list)...))::Cvoid))
    end

function ImPlot_TagX_Bool(x, col, round)
    ccall((:ImPlot_TagX_Bool, libcimgui), Cvoid, (Cdouble, ImVec4, Bool), x, col, round)
end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function ImPlot_TagX_Str(x, col, fmt, va_list...)
        :(@ccall(libcimgui.ImPlot_TagX_Str(x::Cdouble, col::ImVec4, fmt::Ptr{Cchar}; $(to_c_type_pairs(va_list)...))::Cvoid))
    end

function ImPlot_TagY_Bool(y, col, round)
    ccall((:ImPlot_TagY_Bool, libcimgui), Cvoid, (Cdouble, ImVec4, Bool), y, col, round)
end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function ImPlot_TagY_Str(y, col, fmt, va_list...)
        :(@ccall(libcimgui.ImPlot_TagY_Str(y::Cdouble, col::ImVec4, fmt::Ptr{Cchar}; $(to_c_type_pairs(va_list)...))::Cvoid))
    end

function ImPlot_SetAxis(axis)
    ccall((:ImPlot_SetAxis, libcimgui), Cvoid, (ImAxis,), axis)
end

function ImPlot_SetAxes(x_axis, y_axis)
    ccall((:ImPlot_SetAxes, libcimgui), Cvoid, (ImAxis, ImAxis), x_axis, y_axis)
end

function ImPlot_PixelsToPlot_Vec2(pOut, pix, x_axis, y_axis)
    ccall((:ImPlot_PixelsToPlot_Vec2, libcimgui), Cvoid, (Ptr{ImPlotPoint}, ImVec2, ImAxis, ImAxis), pOut, pix, x_axis, y_axis)
end

function ImPlot_PixelsToPlot_Float(pOut, x, y, x_axis, y_axis)
    ccall((:ImPlot_PixelsToPlot_Float, libcimgui), Cvoid, (Ptr{ImPlotPoint}, Cfloat, Cfloat, ImAxis, ImAxis), pOut, x, y, x_axis, y_axis)
end

function ImPlot_PlotToPixels_PlotPoInt(pOut, plt, x_axis, y_axis)
    ccall((:ImPlot_PlotToPixels_PlotPoInt, libcimgui), Cvoid, (Ptr{ImVec2}, ImPlotPoint, ImAxis, ImAxis), pOut, plt, x_axis, y_axis)
end

function ImPlot_PlotToPixels_double(pOut, x, y, x_axis, y_axis)
    ccall((:ImPlot_PlotToPixels_double, libcimgui), Cvoid, (Ptr{ImVec2}, Cdouble, Cdouble, ImAxis, ImAxis), pOut, x, y, x_axis, y_axis)
end

function ImPlot_GetPlotPos(pOut)
    ccall((:ImPlot_GetPlotPos, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function ImPlot_GetPlotSize(pOut)
    ccall((:ImPlot_GetPlotSize, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function ImPlot_GetPlotMousePos(pOut, x_axis, y_axis)
    ccall((:ImPlot_GetPlotMousePos, libcimgui), Cvoid, (Ptr{ImPlotPoint}, ImAxis, ImAxis), pOut, x_axis, y_axis)
end

function ImPlot_GetPlotLimits(pOut, x_axis, y_axis)
    ccall((:ImPlot_GetPlotLimits, libcimgui), Cvoid, (Ptr{ImPlotRect}, ImAxis, ImAxis), pOut, x_axis, y_axis)
end

function ImPlot_IsPlotHovered()
    ccall((:ImPlot_IsPlotHovered, libcimgui), Bool, ())
end

function ImPlot_IsAxisHovered(axis)
    ccall((:ImPlot_IsAxisHovered, libcimgui), Bool, (ImAxis,), axis)
end

function ImPlot_IsSubplotsHovered()
    ccall((:ImPlot_IsSubplotsHovered, libcimgui), Bool, ())
end

function ImPlot_IsPlotSelected()
    ccall((:ImPlot_IsPlotSelected, libcimgui), Bool, ())
end

function ImPlot_GetPlotSelection(pOut, x_axis, y_axis)
    ccall((:ImPlot_GetPlotSelection, libcimgui), Cvoid, (Ptr{ImPlotRect}, ImAxis, ImAxis), pOut, x_axis, y_axis)
end

function ImPlot_CancelPlotSelection()
    ccall((:ImPlot_CancelPlotSelection, libcimgui), Cvoid, ())
end

function ImPlot_HideNextItem(hidden, cond)
    ccall((:ImPlot_HideNextItem, libcimgui), Cvoid, (Bool, ImPlotCond), hidden, cond)
end

function ImPlot_BeginAlignedPlots(group_id, vertical)
    ccall((:ImPlot_BeginAlignedPlots, libcimgui), Bool, (Ptr{Cchar}, Bool), group_id, vertical)
end

function ImPlot_EndAlignedPlots()
    ccall((:ImPlot_EndAlignedPlots, libcimgui), Cvoid, ())
end

function ImPlot_BeginLegendPopup(label_id, mouse_button)
    ccall((:ImPlot_BeginLegendPopup, libcimgui), Bool, (Ptr{Cchar}, ImGuiMouseButton), label_id, mouse_button)
end

function ImPlot_EndLegendPopup()
    ccall((:ImPlot_EndLegendPopup, libcimgui), Cvoid, ())
end

function ImPlot_IsLegendEntryHovered(label_id)
    ccall((:ImPlot_IsLegendEntryHovered, libcimgui), Bool, (Ptr{Cchar},), label_id)
end

function ImPlot_BeginDragDropTargetPlot()
    ccall((:ImPlot_BeginDragDropTargetPlot, libcimgui), Bool, ())
end

function ImPlot_BeginDragDropTargetAxis(axis)
    ccall((:ImPlot_BeginDragDropTargetAxis, libcimgui), Bool, (ImAxis,), axis)
end

function ImPlot_BeginDragDropTargetLegend()
    ccall((:ImPlot_BeginDragDropTargetLegend, libcimgui), Bool, ())
end

function ImPlot_EndDragDropTarget()
    ccall((:ImPlot_EndDragDropTarget, libcimgui), Cvoid, ())
end

function ImPlot_BeginDragDropSourcePlot(flags)
    ccall((:ImPlot_BeginDragDropSourcePlot, libcimgui), Bool, (ImGuiDragDropFlags,), flags)
end

function ImPlot_BeginDragDropSourceAxis(axis, flags)
    ccall((:ImPlot_BeginDragDropSourceAxis, libcimgui), Bool, (ImAxis, ImGuiDragDropFlags), axis, flags)
end

function ImPlot_BeginDragDropSourceItem(label_id, flags)
    ccall((:ImPlot_BeginDragDropSourceItem, libcimgui), Bool, (Ptr{Cchar}, ImGuiDragDropFlags), label_id, flags)
end

function ImPlot_EndDragDropSource()
    ccall((:ImPlot_EndDragDropSource, libcimgui), Cvoid, ())
end

function ImPlot_GetStyle()
    ccall((:ImPlot_GetStyle, libcimgui), Ptr{ImPlotStyle}, ())
end

function ImPlot_StyleColorsAuto(dst)
    ccall((:ImPlot_StyleColorsAuto, libcimgui), Cvoid, (Ptr{ImPlotStyle},), dst)
end

function ImPlot_StyleColorsClassic(dst)
    ccall((:ImPlot_StyleColorsClassic, libcimgui), Cvoid, (Ptr{ImPlotStyle},), dst)
end

function ImPlot_StyleColorsDark(dst)
    ccall((:ImPlot_StyleColorsDark, libcimgui), Cvoid, (Ptr{ImPlotStyle},), dst)
end

function ImPlot_StyleColorsLight(dst)
    ccall((:ImPlot_StyleColorsLight, libcimgui), Cvoid, (Ptr{ImPlotStyle},), dst)
end

function ImPlot_PushStyleColor_U32(idx, col)
    ccall((:ImPlot_PushStyleColor_U32, libcimgui), Cvoid, (ImPlotCol, ImU32), idx, col)
end

function ImPlot_PushStyleColor_Vec4(idx, col)
    ccall((:ImPlot_PushStyleColor_Vec4, libcimgui), Cvoid, (ImPlotCol, ImVec4), idx, col)
end

function ImPlot_PopStyleColor(count)
    ccall((:ImPlot_PopStyleColor, libcimgui), Cvoid, (Cint,), count)
end

function ImPlot_PushStyleVar_Float(idx, val)
    ccall((:ImPlot_PushStyleVar_Float, libcimgui), Cvoid, (ImPlotStyleVar, Cfloat), idx, val)
end

function ImPlot_PushStyleVar_Int(idx, val)
    ccall((:ImPlot_PushStyleVar_Int, libcimgui), Cvoid, (ImPlotStyleVar, Cint), idx, val)
end

function ImPlot_PushStyleVar_Vec2(idx, val)
    ccall((:ImPlot_PushStyleVar_Vec2, libcimgui), Cvoid, (ImPlotStyleVar, ImVec2), idx, val)
end

function ImPlot_PopStyleVar(count)
    ccall((:ImPlot_PopStyleVar, libcimgui), Cvoid, (Cint,), count)
end

function ImPlot_SetNextLineStyle(col, weight)
    ccall((:ImPlot_SetNextLineStyle, libcimgui), Cvoid, (ImVec4, Cfloat), col, weight)
end

function ImPlot_SetNextFillStyle(col, alpha_mod)
    ccall((:ImPlot_SetNextFillStyle, libcimgui), Cvoid, (ImVec4, Cfloat), col, alpha_mod)
end

function ImPlot_SetNextMarkerStyle(marker, size, fill, weight, outline)
    ccall((:ImPlot_SetNextMarkerStyle, libcimgui), Cvoid, (ImPlotMarker, Cfloat, ImVec4, Cfloat, ImVec4), marker, size, fill, weight, outline)
end

function ImPlot_SetNextErrorBarStyle(col, size, weight)
    ccall((:ImPlot_SetNextErrorBarStyle, libcimgui), Cvoid, (ImVec4, Cfloat, Cfloat), col, size, weight)
end

function ImPlot_GetLastItemColor(pOut)
    ccall((:ImPlot_GetLastItemColor, libcimgui), Cvoid, (Ptr{ImVec4},), pOut)
end

function ImPlot_GetStyleColorName(idx)
    ccall((:ImPlot_GetStyleColorName, libcimgui), Ptr{Cchar}, (ImPlotCol,), idx)
end

function ImPlot_GetMarkerName(idx)
    ccall((:ImPlot_GetMarkerName, libcimgui), Ptr{Cchar}, (ImPlotMarker,), idx)
end

function ImPlot_AddColormap_Vec4Ptr(name, cols, size, qual)
    ccall((:ImPlot_AddColormap_Vec4Ptr, libcimgui), ImPlotColormap, (Ptr{Cchar}, Ptr{ImVec4}, Cint, Bool), name, cols, size, qual)
end

function ImPlot_AddColormap_U32Ptr(name, cols, size, qual)
    ccall((:ImPlot_AddColormap_U32Ptr, libcimgui), ImPlotColormap, (Ptr{Cchar}, Ptr{ImU32}, Cint, Bool), name, cols, size, qual)
end

function ImPlot_GetColormapCount()
    ccall((:ImPlot_GetColormapCount, libcimgui), Cint, ())
end

function ImPlot_GetColormapName(cmap)
    ccall((:ImPlot_GetColormapName, libcimgui), Ptr{Cchar}, (ImPlotColormap,), cmap)
end

function ImPlot_GetColormapIndex(name)
    ccall((:ImPlot_GetColormapIndex, libcimgui), ImPlotColormap, (Ptr{Cchar},), name)
end

function ImPlot_PushColormap_PlotColormap(cmap)
    ccall((:ImPlot_PushColormap_PlotColormap, libcimgui), Cvoid, (ImPlotColormap,), cmap)
end

function ImPlot_PushColormap_Str(name)
    ccall((:ImPlot_PushColormap_Str, libcimgui), Cvoid, (Ptr{Cchar},), name)
end

function ImPlot_PopColormap(count)
    ccall((:ImPlot_PopColormap, libcimgui), Cvoid, (Cint,), count)
end

function ImPlot_NextColormapColor(pOut)
    ccall((:ImPlot_NextColormapColor, libcimgui), Cvoid, (Ptr{ImVec4},), pOut)
end

function ImPlot_GetColormapSize(cmap)
    ccall((:ImPlot_GetColormapSize, libcimgui), Cint, (ImPlotColormap,), cmap)
end

function ImPlot_GetColormapColor(pOut, idx, cmap)
    ccall((:ImPlot_GetColormapColor, libcimgui), Cvoid, (Ptr{ImVec4}, Cint, ImPlotColormap), pOut, idx, cmap)
end

function ImPlot_SampleColormap(pOut, t, cmap)
    ccall((:ImPlot_SampleColormap, libcimgui), Cvoid, (Ptr{ImVec4}, Cfloat, ImPlotColormap), pOut, t, cmap)
end

function ImPlot_ColormapScale(label, scale_min, scale_max, size, format, flags, cmap)
    ccall((:ImPlot_ColormapScale, libcimgui), Cvoid, (Ptr{Cchar}, Cdouble, Cdouble, ImVec2, Ptr{Cchar}, ImPlotColormapScaleFlags, ImPlotColormap), label, scale_min, scale_max, size, format, flags, cmap)
end

function ImPlot_ColormapSlider(label, t, out, format, cmap)
    ccall((:ImPlot_ColormapSlider, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cfloat}, Ptr{ImVec4}, Ptr{Cchar}, ImPlotColormap), label, t, out, format, cmap)
end

function ImPlot_ColormapButton(label, size, cmap)
    ccall((:ImPlot_ColormapButton, libcimgui), Bool, (Ptr{Cchar}, ImVec2, ImPlotColormap), label, size, cmap)
end

function ImPlot_BustColorCache(plot_title_id)
    ccall((:ImPlot_BustColorCache, libcimgui), Cvoid, (Ptr{Cchar},), plot_title_id)
end

function ImPlot_GetInputMap()
    ccall((:ImPlot_GetInputMap, libcimgui), Ptr{ImPlotInputMap}, ())
end

function ImPlot_MapInputDefault(dst)
    ccall((:ImPlot_MapInputDefault, libcimgui), Cvoid, (Ptr{ImPlotInputMap},), dst)
end

function ImPlot_MapInputReverse(dst)
    ccall((:ImPlot_MapInputReverse, libcimgui), Cvoid, (Ptr{ImPlotInputMap},), dst)
end

function ImPlot_ItemIcon_Vec4(col)
    ccall((:ImPlot_ItemIcon_Vec4, libcimgui), Cvoid, (ImVec4,), col)
end

function ImPlot_ItemIcon_U32(col)
    ccall((:ImPlot_ItemIcon_U32, libcimgui), Cvoid, (ImU32,), col)
end

function ImPlot_ColormapIcon(cmap)
    ccall((:ImPlot_ColormapIcon, libcimgui), Cvoid, (ImPlotColormap,), cmap)
end

function ImPlot_GetPlotDrawList()
    ccall((:ImPlot_GetPlotDrawList, libcimgui), Ptr{ImDrawList}, ())
end

function ImPlot_PushPlotClipRect(expand)
    ccall((:ImPlot_PushPlotClipRect, libcimgui), Cvoid, (Cfloat,), expand)
end

function ImPlot_PopPlotClipRect()
    ccall((:ImPlot_PopPlotClipRect, libcimgui), Cvoid, ())
end

function ImPlot_ShowStyleSelector(label)
    ccall((:ImPlot_ShowStyleSelector, libcimgui), Bool, (Ptr{Cchar},), label)
end

function ImPlot_ShowColormapSelector(label)
    ccall((:ImPlot_ShowColormapSelector, libcimgui), Bool, (Ptr{Cchar},), label)
end

function ImPlot_ShowInputMapSelector(label)
    ccall((:ImPlot_ShowInputMapSelector, libcimgui), Bool, (Ptr{Cchar},), label)
end

function ImPlot_ShowStyleEditor(ref)
    ccall((:ImPlot_ShowStyleEditor, libcimgui), Cvoid, (Ptr{ImPlotStyle},), ref)
end

function ImPlot_ShowUserGuide()
    ccall((:ImPlot_ShowUserGuide, libcimgui), Cvoid, ())
end

function ImPlot_ShowMetricsWindow(p_popen)
    ccall((:ImPlot_ShowMetricsWindow, libcimgui), Cvoid, (Ptr{Bool},), p_popen)
end

function ImPlot_ShowDemoWindow(p_open)
    ccall((:ImPlot_ShowDemoWindow, libcimgui), Cvoid, (Ptr{Bool},), p_open)
end

function ImPlot_ImLog10_Float(x)
    ccall((:ImPlot_ImLog10_Float, libcimgui), Cfloat, (Cfloat,), x)
end

function ImPlot_ImLog10_double(x)
    ccall((:ImPlot_ImLog10_double, libcimgui), Cdouble, (Cdouble,), x)
end

function ImPlot_ImSinh_Float(x)
    ccall((:ImPlot_ImSinh_Float, libcimgui), Cfloat, (Cfloat,), x)
end

function ImPlot_ImSinh_double(x)
    ccall((:ImPlot_ImSinh_double, libcimgui), Cdouble, (Cdouble,), x)
end

function ImPlot_ImAsinh_Float(x)
    ccall((:ImPlot_ImAsinh_Float, libcimgui), Cfloat, (Cfloat,), x)
end

function ImPlot_ImAsinh_double(x)
    ccall((:ImPlot_ImAsinh_double, libcimgui), Cdouble, (Cdouble,), x)
end

function ImPlot_ImRemap_Float(x, x0, x1, y0, y1)
    ccall((:ImPlot_ImRemap_Float, libcimgui), Cfloat, (Cfloat, Cfloat, Cfloat, Cfloat, Cfloat), x, x0, x1, y0, y1)
end

function ImPlot_ImRemap_double(x, x0, x1, y0, y1)
    ccall((:ImPlot_ImRemap_double, libcimgui), Cdouble, (Cdouble, Cdouble, Cdouble, Cdouble, Cdouble), x, x0, x1, y0, y1)
end

function ImPlot_ImRemap_S8(x, x0, x1, y0, y1)
    ccall((:ImPlot_ImRemap_S8, libcimgui), ImS8, (ImS8, ImS8, ImS8, ImS8, ImS8), x, x0, x1, y0, y1)
end

function ImPlot_ImRemap_U8(x, x0, x1, y0, y1)
    ccall((:ImPlot_ImRemap_U8, libcimgui), ImU8, (ImU8, ImU8, ImU8, ImU8, ImU8), x, x0, x1, y0, y1)
end

function ImPlot_ImRemap_S16(x, x0, x1, y0, y1)
    ccall((:ImPlot_ImRemap_S16, libcimgui), ImS16, (ImS16, ImS16, ImS16, ImS16, ImS16), x, x0, x1, y0, y1)
end

function ImPlot_ImRemap_U16(x, x0, x1, y0, y1)
    ccall((:ImPlot_ImRemap_U16, libcimgui), ImU16, (ImU16, ImU16, ImU16, ImU16, ImU16), x, x0, x1, y0, y1)
end

function ImPlot_ImRemap_S32(x, x0, x1, y0, y1)
    ccall((:ImPlot_ImRemap_S32, libcimgui), ImS32, (ImS32, ImS32, ImS32, ImS32, ImS32), x, x0, x1, y0, y1)
end

function ImPlot_ImRemap_U32(x, x0, x1, y0, y1)
    ccall((:ImPlot_ImRemap_U32, libcimgui), ImU32, (ImU32, ImU32, ImU32, ImU32, ImU32), x, x0, x1, y0, y1)
end

function ImPlot_ImRemap_S64(x, x0, x1, y0, y1)
    ccall((:ImPlot_ImRemap_S64, libcimgui), ImS64, (ImS64, ImS64, ImS64, ImS64, ImS64), x, x0, x1, y0, y1)
end

function ImPlot_ImRemap_U64(x, x0, x1, y0, y1)
    ccall((:ImPlot_ImRemap_U64, libcimgui), ImU64, (ImU64, ImU64, ImU64, ImU64, ImU64), x, x0, x1, y0, y1)
end

function ImPlot_ImRemap01_Float(x, x0, x1)
    ccall((:ImPlot_ImRemap01_Float, libcimgui), Cfloat, (Cfloat, Cfloat, Cfloat), x, x0, x1)
end

function ImPlot_ImRemap01_double(x, x0, x1)
    ccall((:ImPlot_ImRemap01_double, libcimgui), Cdouble, (Cdouble, Cdouble, Cdouble), x, x0, x1)
end

function ImPlot_ImRemap01_S8(x, x0, x1)
    ccall((:ImPlot_ImRemap01_S8, libcimgui), ImS8, (ImS8, ImS8, ImS8), x, x0, x1)
end

function ImPlot_ImRemap01_U8(x, x0, x1)
    ccall((:ImPlot_ImRemap01_U8, libcimgui), ImU8, (ImU8, ImU8, ImU8), x, x0, x1)
end

function ImPlot_ImRemap01_S16(x, x0, x1)
    ccall((:ImPlot_ImRemap01_S16, libcimgui), ImS16, (ImS16, ImS16, ImS16), x, x0, x1)
end

function ImPlot_ImRemap01_U16(x, x0, x1)
    ccall((:ImPlot_ImRemap01_U16, libcimgui), ImU16, (ImU16, ImU16, ImU16), x, x0, x1)
end

function ImPlot_ImRemap01_S32(x, x0, x1)
    ccall((:ImPlot_ImRemap01_S32, libcimgui), ImS32, (ImS32, ImS32, ImS32), x, x0, x1)
end

function ImPlot_ImRemap01_U32(x, x0, x1)
    ccall((:ImPlot_ImRemap01_U32, libcimgui), ImU32, (ImU32, ImU32, ImU32), x, x0, x1)
end

function ImPlot_ImRemap01_S64(x, x0, x1)
    ccall((:ImPlot_ImRemap01_S64, libcimgui), ImS64, (ImS64, ImS64, ImS64), x, x0, x1)
end

function ImPlot_ImRemap01_U64(x, x0, x1)
    ccall((:ImPlot_ImRemap01_U64, libcimgui), ImU64, (ImU64, ImU64, ImU64), x, x0, x1)
end

function ImPlot_ImPosMod(l, r)
    ccall((:ImPlot_ImPosMod, libcimgui), Cint, (Cint, Cint), l, r)
end

function ImPlot_ImNan(val)
    ccall((:ImPlot_ImNan, libcimgui), Bool, (Cdouble,), val)
end

function ImPlot_ImNanOrInf(val)
    ccall((:ImPlot_ImNanOrInf, libcimgui), Bool, (Cdouble,), val)
end

function ImPlot_ImConstrainNan(val)
    ccall((:ImPlot_ImConstrainNan, libcimgui), Cdouble, (Cdouble,), val)
end

function ImPlot_ImConstrainInf(val)
    ccall((:ImPlot_ImConstrainInf, libcimgui), Cdouble, (Cdouble,), val)
end

function ImPlot_ImConstrainLog(val)
    ccall((:ImPlot_ImConstrainLog, libcimgui), Cdouble, (Cdouble,), val)
end

function ImPlot_ImConstrainTime(val)
    ccall((:ImPlot_ImConstrainTime, libcimgui), Cdouble, (Cdouble,), val)
end

function ImPlot_ImAlmostEqual(v1, v2, ulp)
    ccall((:ImPlot_ImAlmostEqual, libcimgui), Bool, (Cdouble, Cdouble, Cint), v1, v2, ulp)
end

function ImPlot_ImMinArray_FloatPtr(values, count)
    ccall((:ImPlot_ImMinArray_FloatPtr, libcimgui), Cfloat, (Ptr{Cfloat}, Cint), values, count)
end

function ImPlot_ImMinArray_doublePtr(values, count)
    ccall((:ImPlot_ImMinArray_doublePtr, libcimgui), Cdouble, (Ptr{Cdouble}, Cint), values, count)
end

function ImPlot_ImMinArray_S8Ptr(values, count)
    ccall((:ImPlot_ImMinArray_S8Ptr, libcimgui), ImS8, (Ptr{ImS8}, Cint), values, count)
end

function ImPlot_ImMinArray_U8Ptr(values, count)
    ccall((:ImPlot_ImMinArray_U8Ptr, libcimgui), ImU8, (Ptr{ImU8}, Cint), values, count)
end

function ImPlot_ImMinArray_S16Ptr(values, count)
    ccall((:ImPlot_ImMinArray_S16Ptr, libcimgui), ImS16, (Ptr{ImS16}, Cint), values, count)
end

function ImPlot_ImMinArray_U16Ptr(values, count)
    ccall((:ImPlot_ImMinArray_U16Ptr, libcimgui), ImU16, (Ptr{ImU16}, Cint), values, count)
end

function ImPlot_ImMinArray_S32Ptr(values, count)
    ccall((:ImPlot_ImMinArray_S32Ptr, libcimgui), ImS32, (Ptr{ImS32}, Cint), values, count)
end

function ImPlot_ImMinArray_U32Ptr(values, count)
    ccall((:ImPlot_ImMinArray_U32Ptr, libcimgui), ImU32, (Ptr{ImU32}, Cint), values, count)
end

function ImPlot_ImMinArray_S64Ptr(values, count)
    ccall((:ImPlot_ImMinArray_S64Ptr, libcimgui), ImS64, (Ptr{ImS64}, Cint), values, count)
end

function ImPlot_ImMinArray_U64Ptr(values, count)
    ccall((:ImPlot_ImMinArray_U64Ptr, libcimgui), ImU64, (Ptr{ImU64}, Cint), values, count)
end

function ImPlot_ImMaxArray_FloatPtr(values, count)
    ccall((:ImPlot_ImMaxArray_FloatPtr, libcimgui), Cfloat, (Ptr{Cfloat}, Cint), values, count)
end

function ImPlot_ImMaxArray_doublePtr(values, count)
    ccall((:ImPlot_ImMaxArray_doublePtr, libcimgui), Cdouble, (Ptr{Cdouble}, Cint), values, count)
end

function ImPlot_ImMaxArray_S8Ptr(values, count)
    ccall((:ImPlot_ImMaxArray_S8Ptr, libcimgui), ImS8, (Ptr{ImS8}, Cint), values, count)
end

function ImPlot_ImMaxArray_U8Ptr(values, count)
    ccall((:ImPlot_ImMaxArray_U8Ptr, libcimgui), ImU8, (Ptr{ImU8}, Cint), values, count)
end

function ImPlot_ImMaxArray_S16Ptr(values, count)
    ccall((:ImPlot_ImMaxArray_S16Ptr, libcimgui), ImS16, (Ptr{ImS16}, Cint), values, count)
end

function ImPlot_ImMaxArray_U16Ptr(values, count)
    ccall((:ImPlot_ImMaxArray_U16Ptr, libcimgui), ImU16, (Ptr{ImU16}, Cint), values, count)
end

function ImPlot_ImMaxArray_S32Ptr(values, count)
    ccall((:ImPlot_ImMaxArray_S32Ptr, libcimgui), ImS32, (Ptr{ImS32}, Cint), values, count)
end

function ImPlot_ImMaxArray_U32Ptr(values, count)
    ccall((:ImPlot_ImMaxArray_U32Ptr, libcimgui), ImU32, (Ptr{ImU32}, Cint), values, count)
end

function ImPlot_ImMaxArray_S64Ptr(values, count)
    ccall((:ImPlot_ImMaxArray_S64Ptr, libcimgui), ImS64, (Ptr{ImS64}, Cint), values, count)
end

function ImPlot_ImMaxArray_U64Ptr(values, count)
    ccall((:ImPlot_ImMaxArray_U64Ptr, libcimgui), ImU64, (Ptr{ImU64}, Cint), values, count)
end

function ImPlot_ImMinMaxArray_FloatPtr(values, count, min_out, max_out)
    ccall((:ImPlot_ImMinMaxArray_FloatPtr, libcimgui), Cvoid, (Ptr{Cfloat}, Cint, Ptr{Cfloat}, Ptr{Cfloat}), values, count, min_out, max_out)
end

function ImPlot_ImMinMaxArray_doublePtr(values, count, min_out, max_out)
    ccall((:ImPlot_ImMinMaxArray_doublePtr, libcimgui), Cvoid, (Ptr{Cdouble}, Cint, Ptr{Cdouble}, Ptr{Cdouble}), values, count, min_out, max_out)
end

function ImPlot_ImMinMaxArray_S8Ptr(values, count, min_out, max_out)
    ccall((:ImPlot_ImMinMaxArray_S8Ptr, libcimgui), Cvoid, (Ptr{ImS8}, Cint, Ptr{ImS8}, Ptr{ImS8}), values, count, min_out, max_out)
end

function ImPlot_ImMinMaxArray_U8Ptr(values, count, min_out, max_out)
    ccall((:ImPlot_ImMinMaxArray_U8Ptr, libcimgui), Cvoid, (Ptr{ImU8}, Cint, Ptr{ImU8}, Ptr{ImU8}), values, count, min_out, max_out)
end

function ImPlot_ImMinMaxArray_S16Ptr(values, count, min_out, max_out)
    ccall((:ImPlot_ImMinMaxArray_S16Ptr, libcimgui), Cvoid, (Ptr{ImS16}, Cint, Ptr{ImS16}, Ptr{ImS16}), values, count, min_out, max_out)
end

function ImPlot_ImMinMaxArray_U16Ptr(values, count, min_out, max_out)
    ccall((:ImPlot_ImMinMaxArray_U16Ptr, libcimgui), Cvoid, (Ptr{ImU16}, Cint, Ptr{ImU16}, Ptr{ImU16}), values, count, min_out, max_out)
end

function ImPlot_ImMinMaxArray_S32Ptr(values, count, min_out, max_out)
    ccall((:ImPlot_ImMinMaxArray_S32Ptr, libcimgui), Cvoid, (Ptr{ImS32}, Cint, Ptr{ImS32}, Ptr{ImS32}), values, count, min_out, max_out)
end

function ImPlot_ImMinMaxArray_U32Ptr(values, count, min_out, max_out)
    ccall((:ImPlot_ImMinMaxArray_U32Ptr, libcimgui), Cvoid, (Ptr{ImU32}, Cint, Ptr{ImU32}, Ptr{ImU32}), values, count, min_out, max_out)
end

function ImPlot_ImMinMaxArray_S64Ptr(values, count, min_out, max_out)
    ccall((:ImPlot_ImMinMaxArray_S64Ptr, libcimgui), Cvoid, (Ptr{ImS64}, Cint, Ptr{ImS64}, Ptr{ImS64}), values, count, min_out, max_out)
end

function ImPlot_ImMinMaxArray_U64Ptr(values, count, min_out, max_out)
    ccall((:ImPlot_ImMinMaxArray_U64Ptr, libcimgui), Cvoid, (Ptr{ImU64}, Cint, Ptr{ImU64}, Ptr{ImU64}), values, count, min_out, max_out)
end

function ImPlot_ImSum_FloatPtr(values, count)
    ccall((:ImPlot_ImSum_FloatPtr, libcimgui), Cfloat, (Ptr{Cfloat}, Cint), values, count)
end

function ImPlot_ImSum_doublePtr(values, count)
    ccall((:ImPlot_ImSum_doublePtr, libcimgui), Cdouble, (Ptr{Cdouble}, Cint), values, count)
end

function ImPlot_ImSum_S8Ptr(values, count)
    ccall((:ImPlot_ImSum_S8Ptr, libcimgui), ImS8, (Ptr{ImS8}, Cint), values, count)
end

function ImPlot_ImSum_U8Ptr(values, count)
    ccall((:ImPlot_ImSum_U8Ptr, libcimgui), ImU8, (Ptr{ImU8}, Cint), values, count)
end

function ImPlot_ImSum_S16Ptr(values, count)
    ccall((:ImPlot_ImSum_S16Ptr, libcimgui), ImS16, (Ptr{ImS16}, Cint), values, count)
end

function ImPlot_ImSum_U16Ptr(values, count)
    ccall((:ImPlot_ImSum_U16Ptr, libcimgui), ImU16, (Ptr{ImU16}, Cint), values, count)
end

function ImPlot_ImSum_S32Ptr(values, count)
    ccall((:ImPlot_ImSum_S32Ptr, libcimgui), ImS32, (Ptr{ImS32}, Cint), values, count)
end

function ImPlot_ImSum_U32Ptr(values, count)
    ccall((:ImPlot_ImSum_U32Ptr, libcimgui), ImU32, (Ptr{ImU32}, Cint), values, count)
end

function ImPlot_ImSum_S64Ptr(values, count)
    ccall((:ImPlot_ImSum_S64Ptr, libcimgui), ImS64, (Ptr{ImS64}, Cint), values, count)
end

function ImPlot_ImSum_U64Ptr(values, count)
    ccall((:ImPlot_ImSum_U64Ptr, libcimgui), ImU64, (Ptr{ImU64}, Cint), values, count)
end

function ImPlot_ImMean_FloatPtr(values, count)
    ccall((:ImPlot_ImMean_FloatPtr, libcimgui), Cdouble, (Ptr{Cfloat}, Cint), values, count)
end

function ImPlot_ImMean_doublePtr(values, count)
    ccall((:ImPlot_ImMean_doublePtr, libcimgui), Cdouble, (Ptr{Cdouble}, Cint), values, count)
end

function ImPlot_ImMean_S8Ptr(values, count)
    ccall((:ImPlot_ImMean_S8Ptr, libcimgui), Cdouble, (Ptr{ImS8}, Cint), values, count)
end

function ImPlot_ImMean_U8Ptr(values, count)
    ccall((:ImPlot_ImMean_U8Ptr, libcimgui), Cdouble, (Ptr{ImU8}, Cint), values, count)
end

function ImPlot_ImMean_S16Ptr(values, count)
    ccall((:ImPlot_ImMean_S16Ptr, libcimgui), Cdouble, (Ptr{ImS16}, Cint), values, count)
end

function ImPlot_ImMean_U16Ptr(values, count)
    ccall((:ImPlot_ImMean_U16Ptr, libcimgui), Cdouble, (Ptr{ImU16}, Cint), values, count)
end

function ImPlot_ImMean_S32Ptr(values, count)
    ccall((:ImPlot_ImMean_S32Ptr, libcimgui), Cdouble, (Ptr{ImS32}, Cint), values, count)
end

function ImPlot_ImMean_U32Ptr(values, count)
    ccall((:ImPlot_ImMean_U32Ptr, libcimgui), Cdouble, (Ptr{ImU32}, Cint), values, count)
end

function ImPlot_ImMean_S64Ptr(values, count)
    ccall((:ImPlot_ImMean_S64Ptr, libcimgui), Cdouble, (Ptr{ImS64}, Cint), values, count)
end

function ImPlot_ImMean_U64Ptr(values, count)
    ccall((:ImPlot_ImMean_U64Ptr, libcimgui), Cdouble, (Ptr{ImU64}, Cint), values, count)
end

function ImPlot_ImStdDev_FloatPtr(values, count)
    ccall((:ImPlot_ImStdDev_FloatPtr, libcimgui), Cdouble, (Ptr{Cfloat}, Cint), values, count)
end

function ImPlot_ImStdDev_doublePtr(values, count)
    ccall((:ImPlot_ImStdDev_doublePtr, libcimgui), Cdouble, (Ptr{Cdouble}, Cint), values, count)
end

function ImPlot_ImStdDev_S8Ptr(values, count)
    ccall((:ImPlot_ImStdDev_S8Ptr, libcimgui), Cdouble, (Ptr{ImS8}, Cint), values, count)
end

function ImPlot_ImStdDev_U8Ptr(values, count)
    ccall((:ImPlot_ImStdDev_U8Ptr, libcimgui), Cdouble, (Ptr{ImU8}, Cint), values, count)
end

function ImPlot_ImStdDev_S16Ptr(values, count)
    ccall((:ImPlot_ImStdDev_S16Ptr, libcimgui), Cdouble, (Ptr{ImS16}, Cint), values, count)
end

function ImPlot_ImStdDev_U16Ptr(values, count)
    ccall((:ImPlot_ImStdDev_U16Ptr, libcimgui), Cdouble, (Ptr{ImU16}, Cint), values, count)
end

function ImPlot_ImStdDev_S32Ptr(values, count)
    ccall((:ImPlot_ImStdDev_S32Ptr, libcimgui), Cdouble, (Ptr{ImS32}, Cint), values, count)
end

function ImPlot_ImStdDev_U32Ptr(values, count)
    ccall((:ImPlot_ImStdDev_U32Ptr, libcimgui), Cdouble, (Ptr{ImU32}, Cint), values, count)
end

function ImPlot_ImStdDev_S64Ptr(values, count)
    ccall((:ImPlot_ImStdDev_S64Ptr, libcimgui), Cdouble, (Ptr{ImS64}, Cint), values, count)
end

function ImPlot_ImStdDev_U64Ptr(values, count)
    ccall((:ImPlot_ImStdDev_U64Ptr, libcimgui), Cdouble, (Ptr{ImU64}, Cint), values, count)
end

function ImPlot_ImMixU32(a, b, s)
    ccall((:ImPlot_ImMixU32, libcimgui), ImU32, (ImU32, ImU32, ImU32), a, b, s)
end

function ImPlot_ImLerpU32(colors, size, t)
    ccall((:ImPlot_ImLerpU32, libcimgui), ImU32, (Ptr{ImU32}, Cint, Cfloat), colors, size, t)
end

function ImPlot_ImAlphaU32(col, alpha)
    ccall((:ImPlot_ImAlphaU32, libcimgui), ImU32, (ImU32, Cfloat), col, alpha)
end

function ImPlot_ImOverlaps_Float(min_a, max_a, min_b, max_b)
    ccall((:ImPlot_ImOverlaps_Float, libcimgui), Bool, (Cfloat, Cfloat, Cfloat, Cfloat), min_a, max_a, min_b, max_b)
end

function ImPlot_ImOverlaps_double(min_a, max_a, min_b, max_b)
    ccall((:ImPlot_ImOverlaps_double, libcimgui), Bool, (Cdouble, Cdouble, Cdouble, Cdouble), min_a, max_a, min_b, max_b)
end

function ImPlot_ImOverlaps_S8(min_a, max_a, min_b, max_b)
    ccall((:ImPlot_ImOverlaps_S8, libcimgui), Bool, (ImS8, ImS8, ImS8, ImS8), min_a, max_a, min_b, max_b)
end

function ImPlot_ImOverlaps_U8(min_a, max_a, min_b, max_b)
    ccall((:ImPlot_ImOverlaps_U8, libcimgui), Bool, (ImU8, ImU8, ImU8, ImU8), min_a, max_a, min_b, max_b)
end

function ImPlot_ImOverlaps_S16(min_a, max_a, min_b, max_b)
    ccall((:ImPlot_ImOverlaps_S16, libcimgui), Bool, (ImS16, ImS16, ImS16, ImS16), min_a, max_a, min_b, max_b)
end

function ImPlot_ImOverlaps_U16(min_a, max_a, min_b, max_b)
    ccall((:ImPlot_ImOverlaps_U16, libcimgui), Bool, (ImU16, ImU16, ImU16, ImU16), min_a, max_a, min_b, max_b)
end

function ImPlot_ImOverlaps_S32(min_a, max_a, min_b, max_b)
    ccall((:ImPlot_ImOverlaps_S32, libcimgui), Bool, (ImS32, ImS32, ImS32, ImS32), min_a, max_a, min_b, max_b)
end

function ImPlot_ImOverlaps_U32(min_a, max_a, min_b, max_b)
    ccall((:ImPlot_ImOverlaps_U32, libcimgui), Bool, (ImU32, ImU32, ImU32, ImU32), min_a, max_a, min_b, max_b)
end

function ImPlot_ImOverlaps_S64(min_a, max_a, min_b, max_b)
    ccall((:ImPlot_ImOverlaps_S64, libcimgui), Bool, (ImS64, ImS64, ImS64, ImS64), min_a, max_a, min_b, max_b)
end

function ImPlot_ImOverlaps_U64(min_a, max_a, min_b, max_b)
    ccall((:ImPlot_ImOverlaps_U64, libcimgui), Bool, (ImU64, ImU64, ImU64, ImU64), min_a, max_a, min_b, max_b)
end

function ImPlotDateTimeSpec_ImPlotDateTimeSpec_Nil()
    ccall((:ImPlotDateTimeSpec_ImPlotDateTimeSpec_Nil, libcimgui), Ptr{ImPlotDateTimeSpec}, ())
end

function ImPlotDateTimeSpec_destroy(self)
    ccall((:ImPlotDateTimeSpec_destroy, libcimgui), Cvoid, (Ptr{ImPlotDateTimeSpec},), self)
end

function ImPlotDateTimeSpec_ImPlotDateTimeSpec_PlotDateFmt(date_fmt, time_fmt, use_24_hr_clk, use_iso_8601)
    ccall((:ImPlotDateTimeSpec_ImPlotDateTimeSpec_PlotDateFmt, libcimgui), Ptr{ImPlotDateTimeSpec}, (ImPlotDateFmt, ImPlotTimeFmt, Bool, Bool), date_fmt, time_fmt, use_24_hr_clk, use_iso_8601)
end

function ImPlotTime_ImPlotTime_Nil()
    ccall((:ImPlotTime_ImPlotTime_Nil, libcimgui), Ptr{ImPlotTime}, ())
end

function ImPlotTime_destroy(self)
    ccall((:ImPlotTime_destroy, libcimgui), Cvoid, (Ptr{ImPlotTime},), self)
end

function ImPlotTime_ImPlotTime_time_t(s, us)
    ccall((:ImPlotTime_ImPlotTime_time_t, libcimgui), Ptr{ImPlotTime}, (time_t, Cint), s, us)
end

function ImPlotTime_RollOver(self)
    ccall((:ImPlotTime_RollOver, libcimgui), Cvoid, (Ptr{ImPlotTime},), self)
end

function ImPlotTime_ToDouble(self)
    ccall((:ImPlotTime_ToDouble, libcimgui), Cdouble, (Ptr{ImPlotTime},), self)
end

function ImPlotTime_FromDouble(pOut, t)
    ccall((:ImPlotTime_FromDouble, libcimgui), Cvoid, (Ptr{ImPlotTime}, Cdouble), pOut, t)
end

function ImPlotColormapData_ImPlotColormapData()
    ccall((:ImPlotColormapData_ImPlotColormapData, libcimgui), Ptr{ImPlotColormapData}, ())
end

function ImPlotColormapData_destroy(self)
    ccall((:ImPlotColormapData_destroy, libcimgui), Cvoid, (Ptr{ImPlotColormapData},), self)
end

function ImPlotColormapData_Append(self, name, keys, count, qual)
    ccall((:ImPlotColormapData_Append, libcimgui), Cint, (Ptr{ImPlotColormapData}, Ptr{Cchar}, Ptr{ImU32}, Cint, Bool), self, name, keys, count, qual)
end

function ImPlotColormapData__AppendTable(self, cmap)
    ccall((:ImPlotColormapData__AppendTable, libcimgui), Cvoid, (Ptr{ImPlotColormapData}, ImPlotColormap), self, cmap)
end

function ImPlotColormapData_RebuildTables(self)
    ccall((:ImPlotColormapData_RebuildTables, libcimgui), Cvoid, (Ptr{ImPlotColormapData},), self)
end

function ImPlotColormapData_IsQual(self, cmap)
    ccall((:ImPlotColormapData_IsQual, libcimgui), Bool, (Ptr{ImPlotColormapData}, ImPlotColormap), self, cmap)
end

function ImPlotColormapData_GetName(self, cmap)
    ccall((:ImPlotColormapData_GetName, libcimgui), Ptr{Cchar}, (Ptr{ImPlotColormapData}, ImPlotColormap), self, cmap)
end

function ImPlotColormapData_GetIndex(self, name)
    ccall((:ImPlotColormapData_GetIndex, libcimgui), ImPlotColormap, (Ptr{ImPlotColormapData}, Ptr{Cchar}), self, name)
end

function ImPlotColormapData_GetKeys(self, cmap)
    ccall((:ImPlotColormapData_GetKeys, libcimgui), Ptr{ImU32}, (Ptr{ImPlotColormapData}, ImPlotColormap), self, cmap)
end

function ImPlotColormapData_GetKeyCount(self, cmap)
    ccall((:ImPlotColormapData_GetKeyCount, libcimgui), Cint, (Ptr{ImPlotColormapData}, ImPlotColormap), self, cmap)
end

function ImPlotColormapData_GetKeyColor(self, cmap, idx)
    ccall((:ImPlotColormapData_GetKeyColor, libcimgui), ImU32, (Ptr{ImPlotColormapData}, ImPlotColormap, Cint), self, cmap, idx)
end

function ImPlotColormapData_SetKeyColor(self, cmap, idx, value)
    ccall((:ImPlotColormapData_SetKeyColor, libcimgui), Cvoid, (Ptr{ImPlotColormapData}, ImPlotColormap, Cint, ImU32), self, cmap, idx, value)
end

function ImPlotColormapData_GetTable(self, cmap)
    ccall((:ImPlotColormapData_GetTable, libcimgui), Ptr{ImU32}, (Ptr{ImPlotColormapData}, ImPlotColormap), self, cmap)
end

function ImPlotColormapData_GetTableSize(self, cmap)
    ccall((:ImPlotColormapData_GetTableSize, libcimgui), Cint, (Ptr{ImPlotColormapData}, ImPlotColormap), self, cmap)
end

function ImPlotColormapData_GetTableColor(self, cmap, idx)
    ccall((:ImPlotColormapData_GetTableColor, libcimgui), ImU32, (Ptr{ImPlotColormapData}, ImPlotColormap, Cint), self, cmap, idx)
end

function ImPlotColormapData_LerpTable(self, cmap, t)
    ccall((:ImPlotColormapData_LerpTable, libcimgui), ImU32, (Ptr{ImPlotColormapData}, ImPlotColormap, Cfloat), self, cmap, t)
end

function ImPlotPointError_ImPlotPointError(x, y, neg, pos)
    ccall((:ImPlotPointError_ImPlotPointError, libcimgui), Ptr{ImPlotPointError}, (Cdouble, Cdouble, Cdouble, Cdouble), x, y, neg, pos)
end

function ImPlotPointError_destroy(self)
    ccall((:ImPlotPointError_destroy, libcimgui), Cvoid, (Ptr{ImPlotPointError},), self)
end

function ImPlotAnnotation_ImPlotAnnotation()
    ccall((:ImPlotAnnotation_ImPlotAnnotation, libcimgui), Ptr{ImPlotAnnotation}, ())
end

function ImPlotAnnotation_destroy(self)
    ccall((:ImPlotAnnotation_destroy, libcimgui), Cvoid, (Ptr{ImPlotAnnotation},), self)
end

function ImPlotAnnotationCollection_ImPlotAnnotationCollection()
    ccall((:ImPlotAnnotationCollection_ImPlotAnnotationCollection, libcimgui), Ptr{ImPlotAnnotationCollection}, ())
end

function ImPlotAnnotationCollection_destroy(self)
    ccall((:ImPlotAnnotationCollection_destroy, libcimgui), Cvoid, (Ptr{ImPlotAnnotationCollection},), self)
end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function ImPlotAnnotationCollection_Append(self, pos, off, bg, fg, clamp, fmt, va_list...)
        :(@ccall(libcimgui.ImPlotAnnotationCollection_Append(self::Ptr{ImPlotAnnotationCollection}, pos::ImVec2, off::ImVec2, bg::ImU32, fg::ImU32, clamp::Bool, fmt::Ptr{Cchar}; $(to_c_type_pairs(va_list)...))::Cvoid))
    end

function ImPlotAnnotationCollection_GetText(self, idx)
    ccall((:ImPlotAnnotationCollection_GetText, libcimgui), Ptr{Cchar}, (Ptr{ImPlotAnnotationCollection}, Cint), self, idx)
end

function ImPlotAnnotationCollection_Reset(self)
    ccall((:ImPlotAnnotationCollection_Reset, libcimgui), Cvoid, (Ptr{ImPlotAnnotationCollection},), self)
end

function ImPlotTagCollection_ImPlotTagCollection()
    ccall((:ImPlotTagCollection_ImPlotTagCollection, libcimgui), Ptr{ImPlotTagCollection}, ())
end

function ImPlotTagCollection_destroy(self)
    ccall((:ImPlotTagCollection_destroy, libcimgui), Cvoid, (Ptr{ImPlotTagCollection},), self)
end

# automatic type deduction for variadic arguments may not be what you want, please use with caution
@generated function ImPlotTagCollection_Append(self, axis, value, bg, fg, fmt, va_list...)
        :(@ccall(libcimgui.ImPlotTagCollection_Append(self::Ptr{ImPlotTagCollection}, axis::ImAxis, value::Cdouble, bg::ImU32, fg::ImU32, fmt::Ptr{Cchar}; $(to_c_type_pairs(va_list)...))::Cvoid))
    end

function ImPlotTagCollection_GetText(self, idx)
    ccall((:ImPlotTagCollection_GetText, libcimgui), Ptr{Cchar}, (Ptr{ImPlotTagCollection}, Cint), self, idx)
end

function ImPlotTagCollection_Reset(self)
    ccall((:ImPlotTagCollection_Reset, libcimgui), Cvoid, (Ptr{ImPlotTagCollection},), self)
end

function ImPlotTick_ImPlotTick(value, major, level, show_label)
    ccall((:ImPlotTick_ImPlotTick, libcimgui), Ptr{ImPlotTick}, (Cdouble, Bool, Cint, Bool), value, major, level, show_label)
end

function ImPlotTick_destroy(self)
    ccall((:ImPlotTick_destroy, libcimgui), Cvoid, (Ptr{ImPlotTick},), self)
end

function ImPlotTicker_ImPlotTicker()
    ccall((:ImPlotTicker_ImPlotTicker, libcimgui), Ptr{ImPlotTicker}, ())
end

function ImPlotTicker_destroy(self)
    ccall((:ImPlotTicker_destroy, libcimgui), Cvoid, (Ptr{ImPlotTicker},), self)
end

function ImPlotTicker_AddTick_doubleStr(self, value, major, level, show_label, label)
    ccall((:ImPlotTicker_AddTick_doubleStr, libcimgui), Ptr{ImPlotTick}, (Ptr{ImPlotTicker}, Cdouble, Bool, Cint, Bool, Ptr{Cchar}), self, value, major, level, show_label, label)
end

function ImPlotTicker_AddTick_doublePlotFormatter(self, value, major, level, show_label, formatter, data)
    ccall((:ImPlotTicker_AddTick_doublePlotFormatter, libcimgui), Ptr{ImPlotTick}, (Ptr{ImPlotTicker}, Cdouble, Bool, Cint, Bool, ImPlotFormatter, Ptr{Cvoid}), self, value, major, level, show_label, formatter, data)
end

function ImPlotTicker_AddTick_PlotTick(self, tick)
    ccall((:ImPlotTicker_AddTick_PlotTick, libcimgui), Ptr{ImPlotTick}, (Ptr{ImPlotTicker}, ImPlotTick), self, tick)
end

function ImPlotTicker_GetText_Int(self, idx)
    ccall((:ImPlotTicker_GetText_Int, libcimgui), Ptr{Cchar}, (Ptr{ImPlotTicker}, Cint), self, idx)
end

function ImPlotTicker_GetText_PlotTick(self, tick)
    ccall((:ImPlotTicker_GetText_PlotTick, libcimgui), Ptr{Cchar}, (Ptr{ImPlotTicker}, ImPlotTick), self, tick)
end

function ImPlotTicker_OverrideSizeLate(self, size)
    ccall((:ImPlotTicker_OverrideSizeLate, libcimgui), Cvoid, (Ptr{ImPlotTicker}, ImVec2), self, size)
end

function ImPlotTicker_Reset(self)
    ccall((:ImPlotTicker_Reset, libcimgui), Cvoid, (Ptr{ImPlotTicker},), self)
end

function ImPlotTicker_TickCount(self)
    ccall((:ImPlotTicker_TickCount, libcimgui), Cint, (Ptr{ImPlotTicker},), self)
end

function ImPlotAxis_ImPlotAxis()
    ccall((:ImPlotAxis_ImPlotAxis, libcimgui), Ptr{ImPlotAxis}, ())
end

function ImPlotAxis_destroy(self)
    ccall((:ImPlotAxis_destroy, libcimgui), Cvoid, (Ptr{ImPlotAxis},), self)
end

function ImPlotAxis_Reset(self)
    ccall((:ImPlotAxis_Reset, libcimgui), Cvoid, (Ptr{ImPlotAxis},), self)
end

function ImPlotAxis_SetMin(self, _min, force)
    ccall((:ImPlotAxis_SetMin, libcimgui), Bool, (Ptr{ImPlotAxis}, Cdouble, Bool), self, _min, force)
end

function ImPlotAxis_SetMax(self, _max, force)
    ccall((:ImPlotAxis_SetMax, libcimgui), Bool, (Ptr{ImPlotAxis}, Cdouble, Bool), self, _max, force)
end

function ImPlotAxis_SetRange_double(self, v1, v2)
    ccall((:ImPlotAxis_SetRange_double, libcimgui), Cvoid, (Ptr{ImPlotAxis}, Cdouble, Cdouble), self, v1, v2)
end

function ImPlotAxis_SetRange_PlotRange(self, range)
    ccall((:ImPlotAxis_SetRange_PlotRange, libcimgui), Cvoid, (Ptr{ImPlotAxis}, ImPlotRange), self, range)
end

function ImPlotAxis_SetAspect(self, unit_per_pix)
    ccall((:ImPlotAxis_SetAspect, libcimgui), Cvoid, (Ptr{ImPlotAxis}, Cdouble), self, unit_per_pix)
end

function ImPlotAxis_PixelSize(self)
    ccall((:ImPlotAxis_PixelSize, libcimgui), Cfloat, (Ptr{ImPlotAxis},), self)
end

function ImPlotAxis_GetAspect(self)
    ccall((:ImPlotAxis_GetAspect, libcimgui), Cdouble, (Ptr{ImPlotAxis},), self)
end

function ImPlotAxis_Constrain(self)
    ccall((:ImPlotAxis_Constrain, libcimgui), Cvoid, (Ptr{ImPlotAxis},), self)
end

function ImPlotAxis_UpdateTransformCache(self)
    ccall((:ImPlotAxis_UpdateTransformCache, libcimgui), Cvoid, (Ptr{ImPlotAxis},), self)
end

function ImPlotAxis_PlotToPixels(self, plt)
    ccall((:ImPlotAxis_PlotToPixels, libcimgui), Cfloat, (Ptr{ImPlotAxis}, Cdouble), self, plt)
end

function ImPlotAxis_PixelsToPlot(self, pix)
    ccall((:ImPlotAxis_PixelsToPlot, libcimgui), Cdouble, (Ptr{ImPlotAxis}, Cfloat), self, pix)
end

function ImPlotAxis_ExtendFit(self, v)
    ccall((:ImPlotAxis_ExtendFit, libcimgui), Cvoid, (Ptr{ImPlotAxis}, Cdouble), self, v)
end

function ImPlotAxis_ExtendFitWith(self, alt, v, v_alt)
    ccall((:ImPlotAxis_ExtendFitWith, libcimgui), Cvoid, (Ptr{ImPlotAxis}, Ptr{ImPlotAxis}, Cdouble, Cdouble), self, alt, v, v_alt)
end

function ImPlotAxis_ApplyFit(self, padding)
    ccall((:ImPlotAxis_ApplyFit, libcimgui), Cvoid, (Ptr{ImPlotAxis}, Cfloat), self, padding)
end

function ImPlotAxis_HasLabel(self)
    ccall((:ImPlotAxis_HasLabel, libcimgui), Bool, (Ptr{ImPlotAxis},), self)
end

function ImPlotAxis_HasGridLines(self)
    ccall((:ImPlotAxis_HasGridLines, libcimgui), Bool, (Ptr{ImPlotAxis},), self)
end

function ImPlotAxis_HasTickLabels(self)
    ccall((:ImPlotAxis_HasTickLabels, libcimgui), Bool, (Ptr{ImPlotAxis},), self)
end

function ImPlotAxis_HasTickMarks(self)
    ccall((:ImPlotAxis_HasTickMarks, libcimgui), Bool, (Ptr{ImPlotAxis},), self)
end

function ImPlotAxis_WillRender(self)
    ccall((:ImPlotAxis_WillRender, libcimgui), Bool, (Ptr{ImPlotAxis},), self)
end

function ImPlotAxis_IsOpposite(self)
    ccall((:ImPlotAxis_IsOpposite, libcimgui), Bool, (Ptr{ImPlotAxis},), self)
end

function ImPlotAxis_IsInverted(self)
    ccall((:ImPlotAxis_IsInverted, libcimgui), Bool, (Ptr{ImPlotAxis},), self)
end

function ImPlotAxis_IsForeground(self)
    ccall((:ImPlotAxis_IsForeground, libcimgui), Bool, (Ptr{ImPlotAxis},), self)
end

function ImPlotAxis_IsAutoFitting(self)
    ccall((:ImPlotAxis_IsAutoFitting, libcimgui), Bool, (Ptr{ImPlotAxis},), self)
end

function ImPlotAxis_CanInitFit(self)
    ccall((:ImPlotAxis_CanInitFit, libcimgui), Bool, (Ptr{ImPlotAxis},), self)
end

function ImPlotAxis_IsRangeLocked(self)
    ccall((:ImPlotAxis_IsRangeLocked, libcimgui), Bool, (Ptr{ImPlotAxis},), self)
end

function ImPlotAxis_IsLockedMin(self)
    ccall((:ImPlotAxis_IsLockedMin, libcimgui), Bool, (Ptr{ImPlotAxis},), self)
end

function ImPlotAxis_IsLockedMax(self)
    ccall((:ImPlotAxis_IsLockedMax, libcimgui), Bool, (Ptr{ImPlotAxis},), self)
end

function ImPlotAxis_IsLocked(self)
    ccall((:ImPlotAxis_IsLocked, libcimgui), Bool, (Ptr{ImPlotAxis},), self)
end

function ImPlotAxis_IsInputLockedMin(self)
    ccall((:ImPlotAxis_IsInputLockedMin, libcimgui), Bool, (Ptr{ImPlotAxis},), self)
end

function ImPlotAxis_IsInputLockedMax(self)
    ccall((:ImPlotAxis_IsInputLockedMax, libcimgui), Bool, (Ptr{ImPlotAxis},), self)
end

function ImPlotAxis_IsInputLocked(self)
    ccall((:ImPlotAxis_IsInputLocked, libcimgui), Bool, (Ptr{ImPlotAxis},), self)
end

function ImPlotAxis_HasMenus(self)
    ccall((:ImPlotAxis_HasMenus, libcimgui), Bool, (Ptr{ImPlotAxis},), self)
end

function ImPlotAxis_IsPanLocked(self, increasing)
    ccall((:ImPlotAxis_IsPanLocked, libcimgui), Bool, (Ptr{ImPlotAxis}, Bool), self, increasing)
end

function ImPlotAxis_PushLinks(self)
    ccall((:ImPlotAxis_PushLinks, libcimgui), Cvoid, (Ptr{ImPlotAxis},), self)
end

function ImPlotAxis_PullLinks(self)
    ccall((:ImPlotAxis_PullLinks, libcimgui), Cvoid, (Ptr{ImPlotAxis},), self)
end

function ImPlotAlignmentData_ImPlotAlignmentData()
    ccall((:ImPlotAlignmentData_ImPlotAlignmentData, libcimgui), Ptr{ImPlotAlignmentData}, ())
end

function ImPlotAlignmentData_destroy(self)
    ccall((:ImPlotAlignmentData_destroy, libcimgui), Cvoid, (Ptr{ImPlotAlignmentData},), self)
end

function ImPlotAlignmentData_Begin(self)
    ccall((:ImPlotAlignmentData_Begin, libcimgui), Cvoid, (Ptr{ImPlotAlignmentData},), self)
end

function ImPlotAlignmentData_Update(self, pad_a, pad_b, delta_a, delta_b)
    ccall((:ImPlotAlignmentData_Update, libcimgui), Cvoid, (Ptr{ImPlotAlignmentData}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}), self, pad_a, pad_b, delta_a, delta_b)
end

function ImPlotAlignmentData_End(self)
    ccall((:ImPlotAlignmentData_End, libcimgui), Cvoid, (Ptr{ImPlotAlignmentData},), self)
end

function ImPlotAlignmentData_Reset(self)
    ccall((:ImPlotAlignmentData_Reset, libcimgui), Cvoid, (Ptr{ImPlotAlignmentData},), self)
end

function ImPlotItem_ImPlotItem()
    ccall((:ImPlotItem_ImPlotItem, libcimgui), Ptr{ImPlotItem}, ())
end

function ImPlotItem_destroy(self)
    ccall((:ImPlotItem_destroy, libcimgui), Cvoid, (Ptr{ImPlotItem},), self)
end

function ImPlotLegend_ImPlotLegend()
    ccall((:ImPlotLegend_ImPlotLegend, libcimgui), Ptr{ImPlotLegend}, ())
end

function ImPlotLegend_destroy(self)
    ccall((:ImPlotLegend_destroy, libcimgui), Cvoid, (Ptr{ImPlotLegend},), self)
end

function ImPlotLegend_Reset(self)
    ccall((:ImPlotLegend_Reset, libcimgui), Cvoid, (Ptr{ImPlotLegend},), self)
end

function ImPlotItemGroup_ImPlotItemGroup()
    ccall((:ImPlotItemGroup_ImPlotItemGroup, libcimgui), Ptr{ImPlotItemGroup}, ())
end

function ImPlotItemGroup_destroy(self)
    ccall((:ImPlotItemGroup_destroy, libcimgui), Cvoid, (Ptr{ImPlotItemGroup},), self)
end

function ImPlotItemGroup_GetItemCount(self)
    ccall((:ImPlotItemGroup_GetItemCount, libcimgui), Cint, (Ptr{ImPlotItemGroup},), self)
end

function ImPlotItemGroup_GetItemID(self, label_id)
    ccall((:ImPlotItemGroup_GetItemID, libcimgui), ImGuiID, (Ptr{ImPlotItemGroup}, Ptr{Cchar}), self, label_id)
end

function ImPlotItemGroup_GetItem_ID(self, id)
    ccall((:ImPlotItemGroup_GetItem_ID, libcimgui), Ptr{ImPlotItem}, (Ptr{ImPlotItemGroup}, ImGuiID), self, id)
end

function ImPlotItemGroup_GetItem_Str(self, label_id)
    ccall((:ImPlotItemGroup_GetItem_Str, libcimgui), Ptr{ImPlotItem}, (Ptr{ImPlotItemGroup}, Ptr{Cchar}), self, label_id)
end

function ImPlotItemGroup_GetOrAddItem(self, id)
    ccall((:ImPlotItemGroup_GetOrAddItem, libcimgui), Ptr{ImPlotItem}, (Ptr{ImPlotItemGroup}, ImGuiID), self, id)
end

function ImPlotItemGroup_GetItemByIndex(self, i)
    ccall((:ImPlotItemGroup_GetItemByIndex, libcimgui), Ptr{ImPlotItem}, (Ptr{ImPlotItemGroup}, Cint), self, i)
end

function ImPlotItemGroup_GetItemIndex(self, item)
    ccall((:ImPlotItemGroup_GetItemIndex, libcimgui), Cint, (Ptr{ImPlotItemGroup}, Ptr{ImPlotItem}), self, item)
end

function ImPlotItemGroup_GetLegendCount(self)
    ccall((:ImPlotItemGroup_GetLegendCount, libcimgui), Cint, (Ptr{ImPlotItemGroup},), self)
end

function ImPlotItemGroup_GetLegendItem(self, i)
    ccall((:ImPlotItemGroup_GetLegendItem, libcimgui), Ptr{ImPlotItem}, (Ptr{ImPlotItemGroup}, Cint), self, i)
end

function ImPlotItemGroup_GetLegendLabel(self, i)
    ccall((:ImPlotItemGroup_GetLegendLabel, libcimgui), Ptr{Cchar}, (Ptr{ImPlotItemGroup}, Cint), self, i)
end

function ImPlotItemGroup_Reset(self)
    ccall((:ImPlotItemGroup_Reset, libcimgui), Cvoid, (Ptr{ImPlotItemGroup},), self)
end

function ImPlotPlot_ImPlotPlot()
    ccall((:ImPlotPlot_ImPlotPlot, libcimgui), Ptr{ImPlotPlot}, ())
end

function ImPlotPlot_destroy(self)
    ccall((:ImPlotPlot_destroy, libcimgui), Cvoid, (Ptr{ImPlotPlot},), self)
end

function ImPlotPlot_IsInputLocked(self)
    ccall((:ImPlotPlot_IsInputLocked, libcimgui), Bool, (Ptr{ImPlotPlot},), self)
end

function ImPlotPlot_ClearTextBuffer(self)
    ccall((:ImPlotPlot_ClearTextBuffer, libcimgui), Cvoid, (Ptr{ImPlotPlot},), self)
end

function ImPlotPlot_SetTitle(self, title)
    ccall((:ImPlotPlot_SetTitle, libcimgui), Cvoid, (Ptr{ImPlotPlot}, Ptr{Cchar}), self, title)
end

function ImPlotPlot_HasTitle(self)
    ccall((:ImPlotPlot_HasTitle, libcimgui), Bool, (Ptr{ImPlotPlot},), self)
end

function ImPlotPlot_GetTitle(self)
    ccall((:ImPlotPlot_GetTitle, libcimgui), Ptr{Cchar}, (Ptr{ImPlotPlot},), self)
end

function ImPlotPlot_XAxis_Nil(self, i)
    ccall((:ImPlotPlot_XAxis_Nil, libcimgui), Ptr{ImPlotAxis}, (Ptr{ImPlotPlot}, Cint), self, i)
end

function ImPlotPlot_XAxis__const(self, i)
    ccall((:ImPlotPlot_XAxis__const, libcimgui), Ptr{ImPlotAxis}, (Ptr{ImPlotPlot}, Cint), self, i)
end

function ImPlotPlot_YAxis_Nil(self, i)
    ccall((:ImPlotPlot_YAxis_Nil, libcimgui), Ptr{ImPlotAxis}, (Ptr{ImPlotPlot}, Cint), self, i)
end

function ImPlotPlot_YAxis__const(self, i)
    ccall((:ImPlotPlot_YAxis__const, libcimgui), Ptr{ImPlotAxis}, (Ptr{ImPlotPlot}, Cint), self, i)
end

function ImPlotPlot_EnabledAxesX(self)
    ccall((:ImPlotPlot_EnabledAxesX, libcimgui), Cint, (Ptr{ImPlotPlot},), self)
end

function ImPlotPlot_EnabledAxesY(self)
    ccall((:ImPlotPlot_EnabledAxesY, libcimgui), Cint, (Ptr{ImPlotPlot},), self)
end

function ImPlotPlot_SetAxisLabel(self, axis, label)
    ccall((:ImPlotPlot_SetAxisLabel, libcimgui), Cvoid, (Ptr{ImPlotPlot}, Ptr{ImPlotAxis}, Ptr{Cchar}), self, axis, label)
end

function ImPlotPlot_GetAxisLabel(self, axis)
    ccall((:ImPlotPlot_GetAxisLabel, libcimgui), Ptr{Cchar}, (Ptr{ImPlotPlot}, ImPlotAxis), self, axis)
end

function ImPlotSubplot_ImPlotSubplot()
    ccall((:ImPlotSubplot_ImPlotSubplot, libcimgui), Ptr{ImPlotSubplot}, ())
end

function ImPlotSubplot_destroy(self)
    ccall((:ImPlotSubplot_destroy, libcimgui), Cvoid, (Ptr{ImPlotSubplot},), self)
end

function ImPlotNextPlotData_ImPlotNextPlotData()
    ccall((:ImPlotNextPlotData_ImPlotNextPlotData, libcimgui), Ptr{ImPlotNextPlotData}, ())
end

function ImPlotNextPlotData_destroy(self)
    ccall((:ImPlotNextPlotData_destroy, libcimgui), Cvoid, (Ptr{ImPlotNextPlotData},), self)
end

function ImPlotNextPlotData_Reset(self)
    ccall((:ImPlotNextPlotData_Reset, libcimgui), Cvoid, (Ptr{ImPlotNextPlotData},), self)
end

function ImPlotNextItemData_ImPlotNextItemData()
    ccall((:ImPlotNextItemData_ImPlotNextItemData, libcimgui), Ptr{ImPlotNextItemData}, ())
end

function ImPlotNextItemData_destroy(self)
    ccall((:ImPlotNextItemData_destroy, libcimgui), Cvoid, (Ptr{ImPlotNextItemData},), self)
end

function ImPlotNextItemData_Reset(self)
    ccall((:ImPlotNextItemData_Reset, libcimgui), Cvoid, (Ptr{ImPlotNextItemData},), self)
end

function ImPlot_Initialize(ctx)
    ccall((:ImPlot_Initialize, libcimgui), Cvoid, (Ptr{ImPlotContext},), ctx)
end

function ImPlot_ResetCtxForNextPlot(ctx)
    ccall((:ImPlot_ResetCtxForNextPlot, libcimgui), Cvoid, (Ptr{ImPlotContext},), ctx)
end

function ImPlot_ResetCtxForNextAlignedPlots(ctx)
    ccall((:ImPlot_ResetCtxForNextAlignedPlots, libcimgui), Cvoid, (Ptr{ImPlotContext},), ctx)
end

function ImPlot_ResetCtxForNextSubplot(ctx)
    ccall((:ImPlot_ResetCtxForNextSubplot, libcimgui), Cvoid, (Ptr{ImPlotContext},), ctx)
end

function ImPlot_GetPlot(title)
    ccall((:ImPlot_GetPlot, libcimgui), Ptr{ImPlotPlot}, (Ptr{Cchar},), title)
end

function ImPlot_GetCurrentPlot()
    ccall((:ImPlot_GetCurrentPlot, libcimgui), Ptr{ImPlotPlot}, ())
end

function ImPlot_BustPlotCache()
    ccall((:ImPlot_BustPlotCache, libcimgui), Cvoid, ())
end

function ImPlot_ShowPlotContextMenu(plot)
    ccall((:ImPlot_ShowPlotContextMenu, libcimgui), Cvoid, (Ptr{ImPlotPlot},), plot)
end

function ImPlot_SetupLock()
    ccall((:ImPlot_SetupLock, libcimgui), Cvoid, ())
end

function ImPlot_SubplotNextCell()
    ccall((:ImPlot_SubplotNextCell, libcimgui), Cvoid, ())
end

function ImPlot_ShowSubplotsContextMenu(subplot)
    ccall((:ImPlot_ShowSubplotsContextMenu, libcimgui), Cvoid, (Ptr{ImPlotSubplot},), subplot)
end

function ImPlot_BeginItem(label_id, flags, recolor_from)
    ccall((:ImPlot_BeginItem, libcimgui), Bool, (Ptr{Cchar}, ImPlotItemFlags, ImPlotCol), label_id, flags, recolor_from)
end

function ImPlot_EndItem()
    ccall((:ImPlot_EndItem, libcimgui), Cvoid, ())
end

function ImPlot_RegisterOrGetItem(label_id, flags, just_created)
    ccall((:ImPlot_RegisterOrGetItem, libcimgui), Ptr{ImPlotItem}, (Ptr{Cchar}, ImPlotItemFlags, Ptr{Bool}), label_id, flags, just_created)
end

function ImPlot_GetItem(label_id)
    ccall((:ImPlot_GetItem, libcimgui), Ptr{ImPlotItem}, (Ptr{Cchar},), label_id)
end

function ImPlot_GetCurrentItem()
    ccall((:ImPlot_GetCurrentItem, libcimgui), Ptr{ImPlotItem}, ())
end

function ImPlot_BustItemCache()
    ccall((:ImPlot_BustItemCache, libcimgui), Cvoid, ())
end

function ImPlot_AnyAxesInputLocked(axes, count)
    ccall((:ImPlot_AnyAxesInputLocked, libcimgui), Bool, (Ptr{ImPlotAxis}, Cint), axes, count)
end

function ImPlot_AllAxesInputLocked(axes, count)
    ccall((:ImPlot_AllAxesInputLocked, libcimgui), Bool, (Ptr{ImPlotAxis}, Cint), axes, count)
end

function ImPlot_AnyAxesHeld(axes, count)
    ccall((:ImPlot_AnyAxesHeld, libcimgui), Bool, (Ptr{ImPlotAxis}, Cint), axes, count)
end

function ImPlot_AnyAxesHovered(axes, count)
    ccall((:ImPlot_AnyAxesHovered, libcimgui), Bool, (Ptr{ImPlotAxis}, Cint), axes, count)
end

function ImPlot_FitThisFrame()
    ccall((:ImPlot_FitThisFrame, libcimgui), Bool, ())
end

function ImPlot_FitPointX(x)
    ccall((:ImPlot_FitPointX, libcimgui), Cvoid, (Cdouble,), x)
end

function ImPlot_FitPointY(y)
    ccall((:ImPlot_FitPointY, libcimgui), Cvoid, (Cdouble,), y)
end

function ImPlot_FitPoint(p)
    ccall((:ImPlot_FitPoint, libcimgui), Cvoid, (ImPlotPoint,), p)
end

function ImPlot_RangesOverlap(r1, r2)
    ccall((:ImPlot_RangesOverlap, libcimgui), Bool, (ImPlotRange, ImPlotRange), r1, r2)
end

function ImPlot_ShowAxisContextMenu(axis, equal_axis, time_allowed)
    ccall((:ImPlot_ShowAxisContextMenu, libcimgui), Cvoid, (Ptr{ImPlotAxis}, Ptr{ImPlotAxis}, Bool), axis, equal_axis, time_allowed)
end

function ImPlot_GetLocationPos(pOut, outer_rect, inner_size, location, pad)
    ccall((:ImPlot_GetLocationPos, libcimgui), Cvoid, (Ptr{ImVec2}, ImRect, ImVec2, ImPlotLocation, ImVec2), pOut, outer_rect, inner_size, location, pad)
end

function ImPlot_CalcLegendSize(pOut, items, pad, spacing, vertical)
    ccall((:ImPlot_CalcLegendSize, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImPlotItemGroup}, ImVec2, ImVec2, Bool), pOut, items, pad, spacing, vertical)
end

function ImPlot_ClampLegendRect(legend_rect, outer_rect, pad)
    ccall((:ImPlot_ClampLegendRect, libcimgui), Bool, (Ptr{ImRect}, ImRect, ImVec2), legend_rect, outer_rect, pad)
end

function ImPlot_ShowLegendEntries(items, legend_bb, interactable, pad, spacing, vertical, DrawList)
    ccall((:ImPlot_ShowLegendEntries, libcimgui), Bool, (Ptr{ImPlotItemGroup}, ImRect, Bool, ImVec2, ImVec2, Bool, Ptr{ImDrawList}), items, legend_bb, interactable, pad, spacing, vertical, DrawList)
end

function ImPlot_ShowAltLegend(title_id, vertical, size, interactable)
    ccall((:ImPlot_ShowAltLegend, libcimgui), Cvoid, (Ptr{Cchar}, Bool, ImVec2, Bool), title_id, vertical, size, interactable)
end

function ImPlot_ShowLegendContextMenu(legend, visible)
    ccall((:ImPlot_ShowLegendContextMenu, libcimgui), Bool, (Ptr{ImPlotLegend}, Bool), legend, visible)
end

function ImPlot_LabelAxisValue(axis, value, buff, size, round)
    ccall((:ImPlot_LabelAxisValue, libcimgui), Cvoid, (ImPlotAxis, Cdouble, Ptr{Cchar}, Cint, Bool), axis, value, buff, size, round)
end

function ImPlot_GetItemData()
    ccall((:ImPlot_GetItemData, libcimgui), Ptr{ImPlotNextItemData}, ())
end

function ImPlot_IsColorAuto_Vec4(col)
    ccall((:ImPlot_IsColorAuto_Vec4, libcimgui), Bool, (ImVec4,), col)
end

function ImPlot_IsColorAuto_PlotCol(idx)
    ccall((:ImPlot_IsColorAuto_PlotCol, libcimgui), Bool, (ImPlotCol,), idx)
end

function ImPlot_GetAutoColor(pOut, idx)
    ccall((:ImPlot_GetAutoColor, libcimgui), Cvoid, (Ptr{ImVec4}, ImPlotCol), pOut, idx)
end

function ImPlot_GetStyleColorVec4(pOut, idx)
    ccall((:ImPlot_GetStyleColorVec4, libcimgui), Cvoid, (Ptr{ImVec4}, ImPlotCol), pOut, idx)
end

function ImPlot_GetStyleColorU32(idx)
    ccall((:ImPlot_GetStyleColorU32, libcimgui), ImU32, (ImPlotCol,), idx)
end

function ImPlot_AddTextVertical(DrawList, pos, col, text_begin, text_end)
    ccall((:ImPlot_AddTextVertical, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImU32, Ptr{Cchar}, Ptr{Cchar}), DrawList, pos, col, text_begin, text_end)
end

function ImPlot_AddTextCentered(DrawList, top_center, col, text_begin, text_end)
    ccall((:ImPlot_AddTextCentered, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImU32, Ptr{Cchar}, Ptr{Cchar}), DrawList, top_center, col, text_begin, text_end)
end

function ImPlot_CalcTextSizeVertical(pOut, text)
    ccall((:ImPlot_CalcTextSizeVertical, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{Cchar}), pOut, text)
end

function ImPlot_CalcTextColor_Vec4(bg)
    ccall((:ImPlot_CalcTextColor_Vec4, libcimgui), ImU32, (ImVec4,), bg)
end

function ImPlot_CalcTextColor_U32(bg)
    ccall((:ImPlot_CalcTextColor_U32, libcimgui), ImU32, (ImU32,), bg)
end

function ImPlot_CalcHoverColor(col)
    ccall((:ImPlot_CalcHoverColor, libcimgui), ImU32, (ImU32,), col)
end

function ImPlot_ClampLabelPos(pOut, pos, size, Min, Max)
    ccall((:ImPlot_ClampLabelPos, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2, ImVec2, ImVec2, ImVec2), pOut, pos, size, Min, Max)
end

function ImPlot_GetColormapColorU32(idx, cmap)
    ccall((:ImPlot_GetColormapColorU32, libcimgui), ImU32, (Cint, ImPlotColormap), idx, cmap)
end

function ImPlot_NextColormapColorU32()
    ccall((:ImPlot_NextColormapColorU32, libcimgui), ImU32, ())
end

function ImPlot_SampleColormapU32(t, cmap)
    ccall((:ImPlot_SampleColormapU32, libcimgui), ImU32, (Cfloat, ImPlotColormap), t, cmap)
end

function ImPlot_RenderColorBar(colors, size, DrawList, bounds, vert, reversed, continuous)
    ccall((:ImPlot_RenderColorBar, libcimgui), Cvoid, (Ptr{ImU32}, Cint, Ptr{ImDrawList}, ImRect, Bool, Bool, Bool), colors, size, DrawList, bounds, vert, reversed, continuous)
end

function ImPlot_NiceNum(x, round)
    ccall((:ImPlot_NiceNum, libcimgui), Cdouble, (Cdouble, Bool), x, round)
end

function ImPlot_OrderOfMagnitude(val)
    ccall((:ImPlot_OrderOfMagnitude, libcimgui), Cint, (Cdouble,), val)
end

function ImPlot_OrderToPrecision(order)
    ccall((:ImPlot_OrderToPrecision, libcimgui), Cint, (Cint,), order)
end

function ImPlot_Precision(val)
    ccall((:ImPlot_Precision, libcimgui), Cint, (Cdouble,), val)
end

function ImPlot_RoundTo(val, prec)
    ccall((:ImPlot_RoundTo, libcimgui), Cdouble, (Cdouble, Cint), val, prec)
end

function ImPlot_Intersection(pOut, a1, a2, b1, b2)
    ccall((:ImPlot_Intersection, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2, ImVec2, ImVec2, ImVec2), pOut, a1, a2, b1, b2)
end

function ImPlot_FillRange_Vector_Float_Ptr(buffer, n, vmin, vmax)
    ccall((:ImPlot_FillRange_Vector_Float_Ptr, libcimgui), Cvoid, (Ptr{ImVector_float}, Cint, Cfloat, Cfloat), buffer, n, vmin, vmax)
end

function ImPlot_FillRange_Vector_double_Ptr(buffer, n, vmin, vmax)
    ccall((:ImPlot_FillRange_Vector_double_Ptr, libcimgui), Cvoid, (Ptr{ImVector_double}, Cint, Cdouble, Cdouble), buffer, n, vmin, vmax)
end

function ImPlot_FillRange_Vector_S8_Ptr(buffer, n, vmin, vmax)
    ccall((:ImPlot_FillRange_Vector_S8_Ptr, libcimgui), Cvoid, (Ptr{ImVector_ImS8}, Cint, ImS8, ImS8), buffer, n, vmin, vmax)
end

function ImPlot_FillRange_Vector_U8_Ptr(buffer, n, vmin, vmax)
    ccall((:ImPlot_FillRange_Vector_U8_Ptr, libcimgui), Cvoid, (Ptr{ImVector_ImU8}, Cint, ImU8, ImU8), buffer, n, vmin, vmax)
end

function ImPlot_FillRange_Vector_S16_Ptr(buffer, n, vmin, vmax)
    ccall((:ImPlot_FillRange_Vector_S16_Ptr, libcimgui), Cvoid, (Ptr{ImVector_ImS16}, Cint, ImS16, ImS16), buffer, n, vmin, vmax)
end

function ImPlot_FillRange_Vector_U16_Ptr(buffer, n, vmin, vmax)
    ccall((:ImPlot_FillRange_Vector_U16_Ptr, libcimgui), Cvoid, (Ptr{ImVector_ImU16}, Cint, ImU16, ImU16), buffer, n, vmin, vmax)
end

function ImPlot_FillRange_Vector_S32_Ptr(buffer, n, vmin, vmax)
    ccall((:ImPlot_FillRange_Vector_S32_Ptr, libcimgui), Cvoid, (Ptr{ImVector_ImS32}, Cint, ImS32, ImS32), buffer, n, vmin, vmax)
end

function ImPlot_FillRange_Vector_U32_Ptr(buffer, n, vmin, vmax)
    ccall((:ImPlot_FillRange_Vector_U32_Ptr, libcimgui), Cvoid, (Ptr{ImVector_ImU32}, Cint, ImU32, ImU32), buffer, n, vmin, vmax)
end

function ImPlot_FillRange_Vector_S64_Ptr(buffer, n, vmin, vmax)
    ccall((:ImPlot_FillRange_Vector_S64_Ptr, libcimgui), Cvoid, (Ptr{ImVector_ImS64}, Cint, ImS64, ImS64), buffer, n, vmin, vmax)
end

function ImPlot_FillRange_Vector_U64_Ptr(buffer, n, vmin, vmax)
    ccall((:ImPlot_FillRange_Vector_U64_Ptr, libcimgui), Cvoid, (Ptr{ImVector_ImU64}, Cint, ImU64, ImU64), buffer, n, vmin, vmax)
end

function ImPlot_CalculateBins_FloatPtr(values, count, meth, range, bins_out, width_out)
    ccall((:ImPlot_CalculateBins_FloatPtr, libcimgui), Cvoid, (Ptr{Cfloat}, Cint, ImPlotBin, ImPlotRange, Ptr{Cint}, Ptr{Cdouble}), values, count, meth, range, bins_out, width_out)
end

function ImPlot_CalculateBins_doublePtr(values, count, meth, range, bins_out, width_out)
    ccall((:ImPlot_CalculateBins_doublePtr, libcimgui), Cvoid, (Ptr{Cdouble}, Cint, ImPlotBin, ImPlotRange, Ptr{Cint}, Ptr{Cdouble}), values, count, meth, range, bins_out, width_out)
end

function ImPlot_CalculateBins_S8Ptr(values, count, meth, range, bins_out, width_out)
    ccall((:ImPlot_CalculateBins_S8Ptr, libcimgui), Cvoid, (Ptr{ImS8}, Cint, ImPlotBin, ImPlotRange, Ptr{Cint}, Ptr{Cdouble}), values, count, meth, range, bins_out, width_out)
end

function ImPlot_CalculateBins_U8Ptr(values, count, meth, range, bins_out, width_out)
    ccall((:ImPlot_CalculateBins_U8Ptr, libcimgui), Cvoid, (Ptr{ImU8}, Cint, ImPlotBin, ImPlotRange, Ptr{Cint}, Ptr{Cdouble}), values, count, meth, range, bins_out, width_out)
end

function ImPlot_CalculateBins_S16Ptr(values, count, meth, range, bins_out, width_out)
    ccall((:ImPlot_CalculateBins_S16Ptr, libcimgui), Cvoid, (Ptr{ImS16}, Cint, ImPlotBin, ImPlotRange, Ptr{Cint}, Ptr{Cdouble}), values, count, meth, range, bins_out, width_out)
end

function ImPlot_CalculateBins_U16Ptr(values, count, meth, range, bins_out, width_out)
    ccall((:ImPlot_CalculateBins_U16Ptr, libcimgui), Cvoid, (Ptr{ImU16}, Cint, ImPlotBin, ImPlotRange, Ptr{Cint}, Ptr{Cdouble}), values, count, meth, range, bins_out, width_out)
end

function ImPlot_CalculateBins_S32Ptr(values, count, meth, range, bins_out, width_out)
    ccall((:ImPlot_CalculateBins_S32Ptr, libcimgui), Cvoid, (Ptr{ImS32}, Cint, ImPlotBin, ImPlotRange, Ptr{Cint}, Ptr{Cdouble}), values, count, meth, range, bins_out, width_out)
end

function ImPlot_CalculateBins_U32Ptr(values, count, meth, range, bins_out, width_out)
    ccall((:ImPlot_CalculateBins_U32Ptr, libcimgui), Cvoid, (Ptr{ImU32}, Cint, ImPlotBin, ImPlotRange, Ptr{Cint}, Ptr{Cdouble}), values, count, meth, range, bins_out, width_out)
end

function ImPlot_CalculateBins_S64Ptr(values, count, meth, range, bins_out, width_out)
    ccall((:ImPlot_CalculateBins_S64Ptr, libcimgui), Cvoid, (Ptr{ImS64}, Cint, ImPlotBin, ImPlotRange, Ptr{Cint}, Ptr{Cdouble}), values, count, meth, range, bins_out, width_out)
end

function ImPlot_CalculateBins_U64Ptr(values, count, meth, range, bins_out, width_out)
    ccall((:ImPlot_CalculateBins_U64Ptr, libcimgui), Cvoid, (Ptr{ImU64}, Cint, ImPlotBin, ImPlotRange, Ptr{Cint}, Ptr{Cdouble}), values, count, meth, range, bins_out, width_out)
end

function ImPlot_IsLeapYear(year)
    ccall((:ImPlot_IsLeapYear, libcimgui), Bool, (Cint,), year)
end

function ImPlot_GetDaysInMonth(year, month)
    ccall((:ImPlot_GetDaysInMonth, libcimgui), Cint, (Cint, Cint), year, month)
end

function ImPlot_MkGmtTime(pOut, ptm)
    ccall((:ImPlot_MkGmtTime, libcimgui), Cvoid, (Ptr{ImPlotTime}, Ptr{tm}), pOut, ptm)
end

function ImPlot_GetGmtTime(t, ptm)
    ccall((:ImPlot_GetGmtTime, libcimgui), Ptr{tm}, (ImPlotTime, Ptr{tm}), t, ptm)
end

function ImPlot_MkLocTime(pOut, ptm)
    ccall((:ImPlot_MkLocTime, libcimgui), Cvoid, (Ptr{ImPlotTime}, Ptr{tm}), pOut, ptm)
end

function ImPlot_GetLocTime(t, ptm)
    ccall((:ImPlot_GetLocTime, libcimgui), Ptr{tm}, (ImPlotTime, Ptr{tm}), t, ptm)
end

function ImPlot_MakeTime(pOut, year, month, day, hour, min, sec, us)
    ccall((:ImPlot_MakeTime, libcimgui), Cvoid, (Ptr{ImPlotTime}, Cint, Cint, Cint, Cint, Cint, Cint, Cint), pOut, year, month, day, hour, min, sec, us)
end

function ImPlot_GetYear(t)
    ccall((:ImPlot_GetYear, libcimgui), Cint, (ImPlotTime,), t)
end

function ImPlot_AddTime(pOut, t, unit, count)
    ccall((:ImPlot_AddTime, libcimgui), Cvoid, (Ptr{ImPlotTime}, ImPlotTime, ImPlotTimeUnit, Cint), pOut, t, unit, count)
end

function ImPlot_FloorTime(pOut, t, unit)
    ccall((:ImPlot_FloorTime, libcimgui), Cvoid, (Ptr{ImPlotTime}, ImPlotTime, ImPlotTimeUnit), pOut, t, unit)
end

function ImPlot_CeilTime(pOut, t, unit)
    ccall((:ImPlot_CeilTime, libcimgui), Cvoid, (Ptr{ImPlotTime}, ImPlotTime, ImPlotTimeUnit), pOut, t, unit)
end

function ImPlot_RoundTime(pOut, t, unit)
    ccall((:ImPlot_RoundTime, libcimgui), Cvoid, (Ptr{ImPlotTime}, ImPlotTime, ImPlotTimeUnit), pOut, t, unit)
end

function ImPlot_CombineDateTime(pOut, date_part, time_part)
    ccall((:ImPlot_CombineDateTime, libcimgui), Cvoid, (Ptr{ImPlotTime}, ImPlotTime, ImPlotTime), pOut, date_part, time_part)
end

function ImPlot_FormatTime(t, buffer, size, fmt, use_24_hr_clk)
    ccall((:ImPlot_FormatTime, libcimgui), Cint, (ImPlotTime, Ptr{Cchar}, Cint, ImPlotTimeFmt, Bool), t, buffer, size, fmt, use_24_hr_clk)
end

function ImPlot_FormatDate(t, buffer, size, fmt, use_iso_8601)
    ccall((:ImPlot_FormatDate, libcimgui), Cint, (ImPlotTime, Ptr{Cchar}, Cint, ImPlotDateFmt, Bool), t, buffer, size, fmt, use_iso_8601)
end

function ImPlot_FormatDateTime(t, buffer, size, fmt)
    ccall((:ImPlot_FormatDateTime, libcimgui), Cint, (ImPlotTime, Ptr{Cchar}, Cint, ImPlotDateTimeSpec), t, buffer, size, fmt)
end

function ImPlot_ShowDatePicker(id, level, t, t1, t2)
    ccall((:ImPlot_ShowDatePicker, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, Ptr{ImPlotTime}, Ptr{ImPlotTime}, Ptr{ImPlotTime}), id, level, t, t1, t2)
end

function ImPlot_ShowTimePicker(id, t)
    ccall((:ImPlot_ShowTimePicker, libcimgui), Bool, (Ptr{Cchar}, Ptr{ImPlotTime}), id, t)
end

function ImPlot_TransformForward_Log10(v, noname1)
    ccall((:ImPlot_TransformForward_Log10, libcimgui), Cdouble, (Cdouble, Ptr{Cvoid}), v, noname1)
end

function ImPlot_TransformInverse_Log10(v, noname1)
    ccall((:ImPlot_TransformInverse_Log10, libcimgui), Cdouble, (Cdouble, Ptr{Cvoid}), v, noname1)
end

function ImPlot_TransformForward_SymLog(v, noname1)
    ccall((:ImPlot_TransformForward_SymLog, libcimgui), Cdouble, (Cdouble, Ptr{Cvoid}), v, noname1)
end

function ImPlot_TransformInverse_SymLog(v, noname1)
    ccall((:ImPlot_TransformInverse_SymLog, libcimgui), Cdouble, (Cdouble, Ptr{Cvoid}), v, noname1)
end

function ImPlot_TransformForward_Logit(v, noname1)
    ccall((:ImPlot_TransformForward_Logit, libcimgui), Cdouble, (Cdouble, Ptr{Cvoid}), v, noname1)
end

function ImPlot_TransformInverse_Logit(v, noname1)
    ccall((:ImPlot_TransformInverse_Logit, libcimgui), Cdouble, (Cdouble, Ptr{Cvoid}), v, noname1)
end

function ImPlot_Formatter_Default(value, buff, size, data)
    ccall((:ImPlot_Formatter_Default, libcimgui), Cint, (Cdouble, Ptr{Cchar}, Cint, Ptr{Cvoid}), value, buff, size, data)
end

function ImPlot_Formatter_Logit(value, buff, size, noname1)
    ccall((:ImPlot_Formatter_Logit, libcimgui), Cint, (Cdouble, Ptr{Cchar}, Cint, Ptr{Cvoid}), value, buff, size, noname1)
end

function ImPlot_Formatter_Time(noname1, buff, size, data)
    ccall((:ImPlot_Formatter_Time, libcimgui), Cint, (Cdouble, Ptr{Cchar}, Cint, Ptr{Cvoid}), noname1, buff, size, data)
end

function ImPlot_Locator_Default(ticker, range, pixels, vertical, formatter, formatter_data)
    ccall((:ImPlot_Locator_Default, libcimgui), Cvoid, (Ptr{ImPlotTicker}, ImPlotRange, Cfloat, Bool, ImPlotFormatter, Ptr{Cvoid}), ticker, range, pixels, vertical, formatter, formatter_data)
end

function ImPlot_Locator_Time(ticker, range, pixels, vertical, formatter, formatter_data)
    ccall((:ImPlot_Locator_Time, libcimgui), Cvoid, (Ptr{ImPlotTicker}, ImPlotRange, Cfloat, Bool, ImPlotFormatter, Ptr{Cvoid}), ticker, range, pixels, vertical, formatter, formatter_data)
end

function ImPlot_Locator_Log10(ticker, range, pixels, vertical, formatter, formatter_data)
    ccall((:ImPlot_Locator_Log10, libcimgui), Cvoid, (Ptr{ImPlotTicker}, ImPlotRange, Cfloat, Bool, ImPlotFormatter, Ptr{Cvoid}), ticker, range, pixels, vertical, formatter, formatter_data)
end

function ImPlot_Locator_SymLog(ticker, range, pixels, vertical, formatter, formatter_data)
    ccall((:ImPlot_Locator_SymLog, libcimgui), Cvoid, (Ptr{ImPlotTicker}, ImPlotRange, Cfloat, Bool, ImPlotFormatter, Ptr{Cvoid}), ticker, range, pixels, vertical, formatter, formatter_data)
end

mutable struct ImNodesContext end

mutable struct ImNodesEditorContext end

const ImNodesCol = Cint

const ImNodesStyleVar = Cint

const ImNodesStyleFlags = Cint

const ImNodesPinShape = Cint

const ImNodesAttributeFlags = Cint

const ImNodesMiniMapLocation = Cint

@cenum ImNodesCol_::UInt32 begin
    ImNodesCol_NodeBackground = 0
    ImNodesCol_NodeBackgroundHovered = 1
    ImNodesCol_NodeBackgroundSelected = 2
    ImNodesCol_NodeOutline = 3
    ImNodesCol_TitleBar = 4
    ImNodesCol_TitleBarHovered = 5
    ImNodesCol_TitleBarSelected = 6
    ImNodesCol_Link = 7
    ImNodesCol_LinkHovered = 8
    ImNodesCol_LinkSelected = 9
    ImNodesCol_Pin = 10
    ImNodesCol_PinHovered = 11
    ImNodesCol_BoxSelector = 12
    ImNodesCol_BoxSelectorOutline = 13
    ImNodesCol_GridBackground = 14
    ImNodesCol_GridLine = 15
    ImNodesCol_GridLinePrimary = 16
    ImNodesCol_MiniMapBackground = 17
    ImNodesCol_MiniMapBackgroundHovered = 18
    ImNodesCol_MiniMapOutline = 19
    ImNodesCol_MiniMapOutlineHovered = 20
    ImNodesCol_MiniMapNodeBackground = 21
    ImNodesCol_MiniMapNodeBackgroundHovered = 22
    ImNodesCol_MiniMapNodeBackgroundSelected = 23
    ImNodesCol_MiniMapNodeOutline = 24
    ImNodesCol_MiniMapLink = 25
    ImNodesCol_MiniMapLinkSelected = 26
    ImNodesCol_MiniMapCanvas = 27
    ImNodesCol_MiniMapCanvasOutline = 28
    ImNodesCol_COUNT = 29
end

@cenum ImNodesStyleVar_::UInt32 begin
    ImNodesStyleVar_GridSpacing = 0
    ImNodesStyleVar_NodeCornerRounding = 1
    ImNodesStyleVar_NodePadding = 2
    ImNodesStyleVar_NodeBorderThickness = 3
    ImNodesStyleVar_LinkThickness = 4
    ImNodesStyleVar_LinkLineSegmentsPerLength = 5
    ImNodesStyleVar_LinkHoverDistance = 6
    ImNodesStyleVar_PinCircleRadius = 7
    ImNodesStyleVar_PinQuadSideLength = 8
    ImNodesStyleVar_PinTriangleSideLength = 9
    ImNodesStyleVar_PinLineThickness = 10
    ImNodesStyleVar_PinHoverRadius = 11
    ImNodesStyleVar_PinOffset = 12
    ImNodesStyleVar_MiniMapPadding = 13
    ImNodesStyleVar_MiniMapOffset = 14
    ImNodesStyleVar_COUNT = 15
end

@cenum ImNodesStyleFlags_::UInt32 begin
    ImNodesStyleFlags_None = 0
    ImNodesStyleFlags_NodeOutline = 1
    ImNodesStyleFlags_GridLines = 4
    ImNodesStyleFlags_GridLinesPrimary = 8
    ImNodesStyleFlags_GridSnapping = 16
end

@cenum ImNodesPinShape_::UInt32 begin
    ImNodesPinShape_Circle = 0
    ImNodesPinShape_CircleFilled = 1
    ImNodesPinShape_Triangle = 2
    ImNodesPinShape_TriangleFilled = 3
    ImNodesPinShape_Quad = 4
    ImNodesPinShape_QuadFilled = 5
end

@cenum ImNodesAttributeFlags_::UInt32 begin
    ImNodesAttributeFlags_None = 0
    ImNodesAttributeFlags_EnableLinkDetachWithDragClick = 1
    ImNodesAttributeFlags_EnableLinkCreationOnSnap = 2
end

struct EmulateThreeButtonMouse
    Modifier::Ptr{Bool}
end

struct LinkDetachWithModifierClick
    Modifier::Ptr{Bool}
end

struct MultipleSelectModifier
    Modifier::Ptr{Bool}
end

struct ImNodesIO
    EmulateThreeButtonMouse::EmulateThreeButtonMouse
    LinkDetachWithModifierClick::LinkDetachWithModifierClick
    MultipleSelectModifier::MultipleSelectModifier
    AltMouseButton::Cint
    AutoPanningSpeed::Cfloat
end

struct ImNodesStyle
    GridSpacing::Cfloat
    NodeCornerRounding::Cfloat
    NodePadding::ImVec2
    NodeBorderThickness::Cfloat
    LinkThickness::Cfloat
    LinkLineSegmentsPerLength::Cfloat
    LinkHoverDistance::Cfloat
    PinCircleRadius::Cfloat
    PinQuadSideLength::Cfloat
    PinTriangleSideLength::Cfloat
    PinLineThickness::Cfloat
    PinHoverRadius::Cfloat
    PinOffset::Cfloat
    MiniMapPadding::ImVec2
    MiniMapOffset::ImVec2
    Flags::ImNodesStyleFlags
    Colors::NTuple{29, Cuint}
end

@cenum ImNodesMiniMapLocation_::UInt32 begin
    ImNodesMiniMapLocation_BottomLeft = 0
    ImNodesMiniMapLocation_BottomRight = 1
    ImNodesMiniMapLocation_TopLeft = 2
    ImNodesMiniMapLocation_TopRight = 3
end

# typedef void ( * ImNodesMiniMapNodeHoveringCallback ) ( int , void * )
const ImNodesMiniMapNodeHoveringCallback = Ptr{Cvoid}

const ImNodesMiniMapNodeHoveringCallbackUserData = Ptr{Cvoid}

function EmulateThreeButtonMouse_EmulateThreeButtonMouse()
    ccall((:EmulateThreeButtonMouse_EmulateThreeButtonMouse, libcimgui), Ptr{EmulateThreeButtonMouse}, ())
end

function EmulateThreeButtonMouse_destroy(self)
    ccall((:EmulateThreeButtonMouse_destroy, libcimgui), Cvoid, (Ptr{EmulateThreeButtonMouse},), self)
end

function LinkDetachWithModifierClick_LinkDetachWithModifierClick()
    ccall((:LinkDetachWithModifierClick_LinkDetachWithModifierClick, libcimgui), Ptr{LinkDetachWithModifierClick}, ())
end

function LinkDetachWithModifierClick_destroy(self)
    ccall((:LinkDetachWithModifierClick_destroy, libcimgui), Cvoid, (Ptr{LinkDetachWithModifierClick},), self)
end

function MultipleSelectModifier_MultipleSelectModifier()
    ccall((:MultipleSelectModifier_MultipleSelectModifier, libcimgui), Ptr{MultipleSelectModifier}, ())
end

function MultipleSelectModifier_destroy(self)
    ccall((:MultipleSelectModifier_destroy, libcimgui), Cvoid, (Ptr{MultipleSelectModifier},), self)
end

function ImNodesIO_ImNodesIO()
    ccall((:ImNodesIO_ImNodesIO, libcimgui), Ptr{ImNodesIO}, ())
end

function ImNodesIO_destroy(self)
    ccall((:ImNodesIO_destroy, libcimgui), Cvoid, (Ptr{ImNodesIO},), self)
end

function ImNodesStyle_ImNodesStyle()
    ccall((:ImNodesStyle_ImNodesStyle, libcimgui), Ptr{ImNodesStyle}, ())
end

function ImNodesStyle_destroy(self)
    ccall((:ImNodesStyle_destroy, libcimgui), Cvoid, (Ptr{ImNodesStyle},), self)
end

function imnodes_SetImGuiContext(ctx)
    ccall((:imnodes_SetImGuiContext, libcimgui), Cvoid, (Ptr{ImGuiContext},), ctx)
end

function imnodes_CreateContext()
    ccall((:imnodes_CreateContext, libcimgui), Ptr{ImNodesContext}, ())
end

function imnodes_DestroyContext(ctx)
    ccall((:imnodes_DestroyContext, libcimgui), Cvoid, (Ptr{ImNodesContext},), ctx)
end

function imnodes_GetCurrentContext()
    ccall((:imnodes_GetCurrentContext, libcimgui), Ptr{ImNodesContext}, ())
end

function imnodes_SetCurrentContext(ctx)
    ccall((:imnodes_SetCurrentContext, libcimgui), Cvoid, (Ptr{ImNodesContext},), ctx)
end

function imnodes_EditorContextCreate()
    ccall((:imnodes_EditorContextCreate, libcimgui), Ptr{ImNodesEditorContext}, ())
end

function imnodes_EditorContextFree(noname1)
    ccall((:imnodes_EditorContextFree, libcimgui), Cvoid, (Ptr{ImNodesEditorContext},), noname1)
end

function imnodes_EditorContextSet(noname1)
    ccall((:imnodes_EditorContextSet, libcimgui), Cvoid, (Ptr{ImNodesEditorContext},), noname1)
end

function imnodes_EditorContextGetPanning(pOut)
    ccall((:imnodes_EditorContextGetPanning, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function imnodes_EditorContextResetPanning(pos)
    ccall((:imnodes_EditorContextResetPanning, libcimgui), Cvoid, (ImVec2,), pos)
end

function imnodes_EditorContextMoveToNode(node_id)
    ccall((:imnodes_EditorContextMoveToNode, libcimgui), Cvoid, (Cint,), node_id)
end

function imnodes_GetIO()
    ccall((:imnodes_GetIO, libcimgui), Ptr{ImNodesIO}, ())
end

function imnodes_GetStyle()
    ccall((:imnodes_GetStyle, libcimgui), Ptr{ImNodesStyle}, ())
end

function imnodes_StyleColorsDark(dest)
    ccall((:imnodes_StyleColorsDark, libcimgui), Cvoid, (Ptr{ImNodesStyle},), dest)
end

function imnodes_StyleColorsClassic(dest)
    ccall((:imnodes_StyleColorsClassic, libcimgui), Cvoid, (Ptr{ImNodesStyle},), dest)
end

function imnodes_StyleColorsLight(dest)
    ccall((:imnodes_StyleColorsLight, libcimgui), Cvoid, (Ptr{ImNodesStyle},), dest)
end

function imnodes_BeginNodeEditor()
    ccall((:imnodes_BeginNodeEditor, libcimgui), Cvoid, ())
end

function imnodes_EndNodeEditor()
    ccall((:imnodes_EndNodeEditor, libcimgui), Cvoid, ())
end

function imnodes_MiniMap(minimap_size_fraction, location, node_hovering_callback, node_hovering_callback_data)
    ccall((:imnodes_MiniMap, libcimgui), Cvoid, (Cfloat, ImNodesMiniMapLocation, ImNodesMiniMapNodeHoveringCallback, ImNodesMiniMapNodeHoveringCallbackUserData), minimap_size_fraction, location, node_hovering_callback, node_hovering_callback_data)
end

function imnodes_PushColorStyle(item, color)
    ccall((:imnodes_PushColorStyle, libcimgui), Cvoid, (ImNodesCol, Cuint), item, color)
end

function imnodes_PopColorStyle()
    ccall((:imnodes_PopColorStyle, libcimgui), Cvoid, ())
end

function imnodes_PushStyleVar_Float(style_item, value)
    ccall((:imnodes_PushStyleVar_Float, libcimgui), Cvoid, (ImNodesStyleVar, Cfloat), style_item, value)
end

function imnodes_PushStyleVar_Vec2(style_item, value)
    ccall((:imnodes_PushStyleVar_Vec2, libcimgui), Cvoid, (ImNodesStyleVar, ImVec2), style_item, value)
end

function imnodes_PopStyleVar(count)
    ccall((:imnodes_PopStyleVar, libcimgui), Cvoid, (Cint,), count)
end

function imnodes_BeginNode(id)
    ccall((:imnodes_BeginNode, libcimgui), Cvoid, (Cint,), id)
end

function imnodes_EndNode()
    ccall((:imnodes_EndNode, libcimgui), Cvoid, ())
end

function imnodes_GetNodeDimensions(pOut, id)
    ccall((:imnodes_GetNodeDimensions, libcimgui), Cvoid, (Ptr{ImVec2}, Cint), pOut, id)
end

function imnodes_BeginNodeTitleBar()
    ccall((:imnodes_BeginNodeTitleBar, libcimgui), Cvoid, ())
end

function imnodes_EndNodeTitleBar()
    ccall((:imnodes_EndNodeTitleBar, libcimgui), Cvoid, ())
end

function imnodes_BeginInputAttribute(id, shape)
    ccall((:imnodes_BeginInputAttribute, libcimgui), Cvoid, (Cint, ImNodesPinShape), id, shape)
end

function imnodes_EndInputAttribute()
    ccall((:imnodes_EndInputAttribute, libcimgui), Cvoid, ())
end

function imnodes_BeginOutputAttribute(id, shape)
    ccall((:imnodes_BeginOutputAttribute, libcimgui), Cvoid, (Cint, ImNodesPinShape), id, shape)
end

function imnodes_EndOutputAttribute()
    ccall((:imnodes_EndOutputAttribute, libcimgui), Cvoid, ())
end

function imnodes_BeginStaticAttribute(id)
    ccall((:imnodes_BeginStaticAttribute, libcimgui), Cvoid, (Cint,), id)
end

function imnodes_EndStaticAttribute()
    ccall((:imnodes_EndStaticAttribute, libcimgui), Cvoid, ())
end

function imnodes_PushAttributeFlag(flag)
    ccall((:imnodes_PushAttributeFlag, libcimgui), Cvoid, (ImNodesAttributeFlags,), flag)
end

function imnodes_PopAttributeFlag()
    ccall((:imnodes_PopAttributeFlag, libcimgui), Cvoid, ())
end

function imnodes_Link(id, start_attribute_id, end_attribute_id)
    ccall((:imnodes_Link, libcimgui), Cvoid, (Cint, Cint, Cint), id, start_attribute_id, end_attribute_id)
end

function imnodes_SetNodeDraggable(node_id, draggable)
    ccall((:imnodes_SetNodeDraggable, libcimgui), Cvoid, (Cint, Bool), node_id, draggable)
end

function imnodes_SetNodeScreenSpacePos(node_id, screen_space_pos)
    ccall((:imnodes_SetNodeScreenSpacePos, libcimgui), Cvoid, (Cint, ImVec2), node_id, screen_space_pos)
end

function imnodes_SetNodeEditorSpacePos(node_id, editor_space_pos)
    ccall((:imnodes_SetNodeEditorSpacePos, libcimgui), Cvoid, (Cint, ImVec2), node_id, editor_space_pos)
end

function imnodes_SetNodeGridSpacePos(node_id, grid_pos)
    ccall((:imnodes_SetNodeGridSpacePos, libcimgui), Cvoid, (Cint, ImVec2), node_id, grid_pos)
end

function imnodes_GetNodeScreenSpacePos(pOut, node_id)
    ccall((:imnodes_GetNodeScreenSpacePos, libcimgui), Cvoid, (Ptr{ImVec2}, Cint), pOut, node_id)
end

function imnodes_GetNodeEditorSpacePos(pOut, node_id)
    ccall((:imnodes_GetNodeEditorSpacePos, libcimgui), Cvoid, (Ptr{ImVec2}, Cint), pOut, node_id)
end

function imnodes_GetNodeGridSpacePos(pOut, node_id)
    ccall((:imnodes_GetNodeGridSpacePos, libcimgui), Cvoid, (Ptr{ImVec2}, Cint), pOut, node_id)
end

function imnodes_SnapNodeToGrid(node_id)
    ccall((:imnodes_SnapNodeToGrid, libcimgui), Cvoid, (Cint,), node_id)
end

function imnodes_IsEditorHovered()
    ccall((:imnodes_IsEditorHovered, libcimgui), Bool, ())
end

function imnodes_IsNodeHovered(node_id)
    ccall((:imnodes_IsNodeHovered, libcimgui), Bool, (Ptr{Cint},), node_id)
end

function imnodes_IsLinkHovered(link_id)
    ccall((:imnodes_IsLinkHovered, libcimgui), Bool, (Ptr{Cint},), link_id)
end

function imnodes_IsPinHovered(attribute_id)
    ccall((:imnodes_IsPinHovered, libcimgui), Bool, (Ptr{Cint},), attribute_id)
end

function imnodes_NumSelectedNodes()
    ccall((:imnodes_NumSelectedNodes, libcimgui), Cint, ())
end

function imnodes_NumSelectedLinks()
    ccall((:imnodes_NumSelectedLinks, libcimgui), Cint, ())
end

function imnodes_GetSelectedNodes(node_ids)
    ccall((:imnodes_GetSelectedNodes, libcimgui), Cvoid, (Ptr{Cint},), node_ids)
end

function imnodes_GetSelectedLinks(link_ids)
    ccall((:imnodes_GetSelectedLinks, libcimgui), Cvoid, (Ptr{Cint},), link_ids)
end

function imnodes_ClearNodeSelection_Nil()
    ccall((:imnodes_ClearNodeSelection_Nil, libcimgui), Cvoid, ())
end

function imnodes_ClearLinkSelection_Nil()
    ccall((:imnodes_ClearLinkSelection_Nil, libcimgui), Cvoid, ())
end

function imnodes_SelectNode(node_id)
    ccall((:imnodes_SelectNode, libcimgui), Cvoid, (Cint,), node_id)
end

function imnodes_ClearNodeSelection_Int(node_id)
    ccall((:imnodes_ClearNodeSelection_Int, libcimgui), Cvoid, (Cint,), node_id)
end

function imnodes_IsNodeSelected(node_id)
    ccall((:imnodes_IsNodeSelected, libcimgui), Bool, (Cint,), node_id)
end

function imnodes_SelectLink(link_id)
    ccall((:imnodes_SelectLink, libcimgui), Cvoid, (Cint,), link_id)
end

function imnodes_ClearLinkSelection_Int(link_id)
    ccall((:imnodes_ClearLinkSelection_Int, libcimgui), Cvoid, (Cint,), link_id)
end

function imnodes_IsLinkSelected(link_id)
    ccall((:imnodes_IsLinkSelected, libcimgui), Bool, (Cint,), link_id)
end

function imnodes_IsAttributeActive()
    ccall((:imnodes_IsAttributeActive, libcimgui), Bool, ())
end

function imnodes_IsAnyAttributeActive(attribute_id)
    ccall((:imnodes_IsAnyAttributeActive, libcimgui), Bool, (Ptr{Cint},), attribute_id)
end

function imnodes_IsLinkStarted(started_at_attribute_id)
    ccall((:imnodes_IsLinkStarted, libcimgui), Bool, (Ptr{Cint},), started_at_attribute_id)
end

function imnodes_IsLinkDropped(started_at_attribute_id, including_detached_links)
    ccall((:imnodes_IsLinkDropped, libcimgui), Bool, (Ptr{Cint}, Bool), started_at_attribute_id, including_detached_links)
end

function imnodes_IsLinkCreated_BoolPtr(started_at_attribute_id, ended_at_attribute_id, created_from_snap)
    ccall((:imnodes_IsLinkCreated_BoolPtr, libcimgui), Bool, (Ptr{Cint}, Ptr{Cint}, Ptr{Bool}), started_at_attribute_id, ended_at_attribute_id, created_from_snap)
end

function imnodes_IsLinkCreated_IntPtr(started_at_node_id, started_at_attribute_id, ended_at_node_id, ended_at_attribute_id, created_from_snap)
    ccall((:imnodes_IsLinkCreated_IntPtr, libcimgui), Bool, (Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Bool}), started_at_node_id, started_at_attribute_id, ended_at_node_id, ended_at_attribute_id, created_from_snap)
end

function imnodes_IsLinkDestroyed(link_id)
    ccall((:imnodes_IsLinkDestroyed, libcimgui), Bool, (Ptr{Cint},), link_id)
end

function imnodes_SaveCurrentEditorStateToIniString(data_size)
    ccall((:imnodes_SaveCurrentEditorStateToIniString, libcimgui), Ptr{Cchar}, (Ptr{Csize_t},), data_size)
end

function imnodes_SaveEditorStateToIniString(editor, data_size)
    ccall((:imnodes_SaveEditorStateToIniString, libcimgui), Ptr{Cchar}, (Ptr{ImNodesEditorContext}, Ptr{Csize_t}), editor, data_size)
end

function imnodes_LoadCurrentEditorStateFromIniString(data, data_size)
    ccall((:imnodes_LoadCurrentEditorStateFromIniString, libcimgui), Cvoid, (Ptr{Cchar}, Csize_t), data, data_size)
end

function imnodes_LoadEditorStateFromIniString(editor, data, data_size)
    ccall((:imnodes_LoadEditorStateFromIniString, libcimgui), Cvoid, (Ptr{ImNodesEditorContext}, Ptr{Cchar}, Csize_t), editor, data, data_size)
end

function imnodes_SaveCurrentEditorStateToIniFile(file_name)
    ccall((:imnodes_SaveCurrentEditorStateToIniFile, libcimgui), Cvoid, (Ptr{Cchar},), file_name)
end

function imnodes_SaveEditorStateToIniFile(editor, file_name)
    ccall((:imnodes_SaveEditorStateToIniFile, libcimgui), Cvoid, (Ptr{ImNodesEditorContext}, Ptr{Cchar}), editor, file_name)
end

function imnodes_LoadCurrentEditorStateFromIniFile(file_name)
    ccall((:imnodes_LoadCurrentEditorStateFromIniFile, libcimgui), Cvoid, (Ptr{Cchar},), file_name)
end

function imnodes_LoadEditorStateFromIniFile(editor, file_name)
    ccall((:imnodes_LoadEditorStateFromIniFile, libcimgui), Cvoid, (Ptr{ImNodesEditorContext}, Ptr{Cchar}), editor, file_name)
end

# no prototype is found for this function at cimnodes.h:251:18, please use with caution
function getIOKeyCtrlPtr()
    ccall((:getIOKeyCtrlPtr, libcimgui), Ptr{Bool}, ())
end

mutable struct GLFWwindow end

mutable struct GLFWmonitor end

function ImGui_ImplGlfw_InitForOpenGL(window, install_callbacks)
    ccall((:ImGui_ImplGlfw_InitForOpenGL, libcimgui), Bool, (Ptr{GLFWwindow}, Bool), window, install_callbacks)
end

function ImGui_ImplGlfw_InitForVulkan(window, install_callbacks)
    ccall((:ImGui_ImplGlfw_InitForVulkan, libcimgui), Bool, (Ptr{GLFWwindow}, Bool), window, install_callbacks)
end

function ImGui_ImplGlfw_InitForOther(window, install_callbacks)
    ccall((:ImGui_ImplGlfw_InitForOther, libcimgui), Bool, (Ptr{GLFWwindow}, Bool), window, install_callbacks)
end

function ImGui_ImplGlfw_Shutdown()
    ccall((:ImGui_ImplGlfw_Shutdown, libcimgui), Cvoid, ())
end

function ImGui_ImplGlfw_NewFrame()
    ccall((:ImGui_ImplGlfw_NewFrame, libcimgui), Cvoid, ())
end

function ImGui_ImplGlfw_InstallCallbacks(window)
    ccall((:ImGui_ImplGlfw_InstallCallbacks, libcimgui), Cvoid, (Ptr{GLFWwindow},), window)
end

function ImGui_ImplGlfw_RestoreCallbacks(window)
    ccall((:ImGui_ImplGlfw_RestoreCallbacks, libcimgui), Cvoid, (Ptr{GLFWwindow},), window)
end

function ImGui_ImplGlfw_SetCallbacksChainForAllWindows(chain_for_all_windows)
    ccall((:ImGui_ImplGlfw_SetCallbacksChainForAllWindows, libcimgui), Cvoid, (Bool,), chain_for_all_windows)
end

function ImGui_ImplGlfw_WindowFocusCallback(window, focused)
    ccall((:ImGui_ImplGlfw_WindowFocusCallback, libcimgui), Cvoid, (Ptr{GLFWwindow}, Cint), window, focused)
end

function ImGui_ImplGlfw_CursorEnterCallback(window, entered)
    ccall((:ImGui_ImplGlfw_CursorEnterCallback, libcimgui), Cvoid, (Ptr{GLFWwindow}, Cint), window, entered)
end

function ImGui_ImplGlfw_CursorPosCallback(window, x, y)
    ccall((:ImGui_ImplGlfw_CursorPosCallback, libcimgui), Cvoid, (Ptr{GLFWwindow}, Cdouble, Cdouble), window, x, y)
end

function ImGui_ImplGlfw_MouseButtonCallback(window, button, action, mods)
    ccall((:ImGui_ImplGlfw_MouseButtonCallback, libcimgui), Cvoid, (Ptr{GLFWwindow}, Cint, Cint, Cint), window, button, action, mods)
end

function ImGui_ImplGlfw_ScrollCallback(window, xoffset, yoffset)
    ccall((:ImGui_ImplGlfw_ScrollCallback, libcimgui), Cvoid, (Ptr{GLFWwindow}, Cdouble, Cdouble), window, xoffset, yoffset)
end

function ImGui_ImplGlfw_KeyCallback(window, key, scancode, action, mods)
    ccall((:ImGui_ImplGlfw_KeyCallback, libcimgui), Cvoid, (Ptr{GLFWwindow}, Cint, Cint, Cint, Cint), window, key, scancode, action, mods)
end

function ImGui_ImplGlfw_CharCallback(window, c)
    ccall((:ImGui_ImplGlfw_CharCallback, libcimgui), Cvoid, (Ptr{GLFWwindow}, Cuint), window, c)
end

function ImGui_ImplGlfw_MonitorCallback(monitor, event)
    ccall((:ImGui_ImplGlfw_MonitorCallback, libcimgui), Cvoid, (Ptr{GLFWmonitor}, Cint), monitor, event)
end

function ImGui_ImplOpenGL3_Init(glsl_version)
    ccall((:ImGui_ImplOpenGL3_Init, libcimgui), Bool, (Ptr{Cchar},), glsl_version)
end

function ImGui_ImplOpenGL3_Shutdown()
    ccall((:ImGui_ImplOpenGL3_Shutdown, libcimgui), Cvoid, ())
end

function ImGui_ImplOpenGL3_NewFrame()
    ccall((:ImGui_ImplOpenGL3_NewFrame, libcimgui), Cvoid, ())
end

function ImGui_ImplOpenGL3_RenderDrawData(draw_data)
    ccall((:ImGui_ImplOpenGL3_RenderDrawData, libcimgui), Cvoid, (Ptr{Cint},), draw_data)
end

function ImGui_ImplOpenGL3_CreateFontsTexture()
    ccall((:ImGui_ImplOpenGL3_CreateFontsTexture, libcimgui), Bool, ())
end

function ImGui_ImplOpenGL3_DestroyFontsTexture()
    ccall((:ImGui_ImplOpenGL3_DestroyFontsTexture, libcimgui), Cvoid, ())
end

function ImGui_ImplOpenGL3_CreateDeviceObjects()
    ccall((:ImGui_ImplOpenGL3_CreateDeviceObjects, libcimgui), Bool, ())
end

function ImGui_ImplOpenGL3_DestroyDeviceObjects()
    ccall((:ImGui_ImplOpenGL3_DestroyDeviceObjects, libcimgui), Cvoid, ())
end

const IMGUI_HAS_DOCK = 1

const ImDrawCallback_ResetRenderState = ImDrawCallback(-8)

