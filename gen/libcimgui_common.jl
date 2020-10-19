# Automatically generated using Clang.jl


# Skipping MacroDefinition: API __attribute__ ( ( __visibility__ ( "default" ) ) )
const ImGuiLayoutType = Cint
const ImGuiItemFlags = Cint

const ImGuiID = UInt32

struct ImGuiStoragePair
    key::ImGuiID
end

struct ImGuiTextRange
    b::Cstring
    e::Cstring
end

struct ImGuiPtrOrIndex
    Ptr::Ptr{Cvoid}
    Index::Cint
end

struct ImGuiShrinkWidthItem
    Index::Cint
    Width::Cfloat
end

const ImU8 = Cuchar

struct ImGuiDataTypeTempStorage
    Data::NTuple{8, ImU8}
end

struct ImVec2ih
    x::Int16
    y::Int16
end

struct ImVec1
    x::Cfloat
end

struct ImVec2
    x::Cfloat
    y::Cfloat
end

struct ImVector_float
    Size::Cint
    Capacity::Cint
    Data::Ptr{Cfloat}
end

const ImWchar16 = UInt16
const ImWchar = ImWchar16

struct ImVector_ImWchar
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImWchar}
end

struct ImFontGlyph
    Codepoint::UInt32
    Visible::UInt32
    AdvanceX::Cfloat
    X0::Cfloat
    Y0::Cfloat
    X1::Cfloat
    Y1::Cfloat
    U0::Cfloat
    V0::Cfloat
    U1::Cfloat
    V1::Cfloat
end

struct ImVector_ImFontGlyph
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImFontGlyph}
end

const ImFontAtlasFlags = Cint
const ImTextureID = Ptr{Cvoid}

struct ImVector_ImFontPtr
    Size::Cint
    Capacity::Cint
    Data::Ptr{Ptr{Cvoid}}  # Ptr{Ptr{ImFont}}
end

struct ImVector_ImFontAtlasCustomRect
    Size::Cint
    Capacity::Cint
    Data::Ptr{Cvoid}  # Ptr{ImFontAtlasCustomRect}
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
    RasterizerFlags::UInt32
    RasterizerMultiply::Cfloat
    EllipsisChar::ImWchar
    Name::NTuple{40, UInt8}
    DstFont::Ptr{Cvoid}  # Ptr{ImFont}
end

struct ImVector_ImFontConfig
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImFontConfig}
end

struct ImVec4
    x::Cfloat
    y::Cfloat
    z::Cfloat
    w::Cfloat
end

struct ImFontAtlas
    Locked::Bool
    Flags::ImFontAtlasFlags
    TexID::ImTextureID
    TexDesiredWidth::Cint
    TexGlyphPadding::Cint
    TexPixelsAlpha8::Ptr{Cuchar}
    TexPixelsRGBA32::Ptr{UInt32}
    TexWidth::Cint
    TexHeight::Cint
    TexUvScale::ImVec2
    TexUvWhitePixel::ImVec2
    Fonts::ImVector_ImFontPtr
    CustomRects::ImVector_ImFontAtlasCustomRect
    ConfigData::ImVector_ImFontConfig
    TexUvLines::NTuple{64, ImVec4}
    PackIdMouseCursors::Cint
    PackIdLines::Cint
end

struct ImFont
    IndexAdvanceX::ImVector_float
    FallbackAdvanceX::Cfloat
    FontSize::Cfloat
    IndexLookup::ImVector_ImWchar
    Glyphs::ImVector_ImFontGlyph
    FallbackGlyph::Ptr{ImFontGlyph}
    ContainerAtlas::Ptr{ImFontAtlas}
    ConfigData::Ptr{ImFontConfig}
    ConfigDataCount::Int16
    FallbackChar::ImWchar
    EllipsisChar::ImWchar
    DirtyLookupTables::Bool
    Scale::Cfloat
    Ascent::Cfloat
    Descent::Cfloat
    MetricsTotalSurface::Cint
    Used4kPagesMap::NTuple{2, ImU8}
end

struct ImFontAtlasCustomRect
    Width::UInt16
    Height::UInt16
    X::UInt16
    Y::UInt16
    GlyphID::UInt32
    GlyphAdvanceX::Cfloat
    GlyphOffset::ImVec2
    Font::Ptr{ImFont}
end

struct ImGuiWindowSettings
    ID::ImGuiID
    Pos::ImVec2ih
    Size::ImVec2ih
    Collapsed::Bool
    WantApply::Bool
end

const ImGuiItemStatusFlags = Cint

struct ImRect
    Min::ImVec2
    Max::ImVec2
end

@cenum ImGuiNavLayer::UInt32 begin
    ImGuiNavLayer_Main = 0
    ImGuiNavLayer_Menu = 1
    ImGuiNavLayer_COUNT = 2
end


struct ImGuiMenuColumns
    Spacing::Cfloat
    Width::Cfloat
    NextWidth::Cfloat
    Pos::NTuple{3, Cfloat}
    NextWidths::NTuple{3, Cfloat}
end

const ImU32 = UInt32
const ImGuiWindowFlags = Cint
const ImS8 = UInt8
const ImGuiDir = Cint
const ImGuiCond = Cint

struct ImVector_ImGuiID
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiID}
end

struct ImVector_ImGuiStoragePair
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiStoragePair}
end

struct ImGuiStorage
    Data::ImVector_ImGuiStoragePair
end

const ImGuiColumnsFlags = Cint

struct ImGuiColumnData
    OffsetNorm::Cfloat
    OffsetNormBeforeResize::Cfloat
    Flags::ImGuiColumnsFlags
    ClipRect::ImRect
end

struct ImVector_ImGuiColumnData
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiColumnData}
end

const ImDrawCallback = Ptr{Cvoid}

struct ImDrawCmd
    ClipRect::ImVec4
    TextureId::ImTextureID
    VtxOffset::UInt32
    IdxOffset::UInt32
    ElemCount::UInt32
    UserCallback::ImDrawCallback
    UserCallbackData::Ptr{Cvoid}
end

struct ImVector_ImDrawCmd
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImDrawCmd}
end

const ImDrawIdx = UInt16

struct ImVector_ImDrawIdx
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImDrawIdx}
end

struct ImDrawChannel
    _CmdBuffer::ImVector_ImDrawCmd
    _IdxBuffer::ImVector_ImDrawIdx
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

struct ImGuiColumns
    ID::ImGuiID
    Flags::ImGuiColumnsFlags
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
    Columns::ImVector_ImGuiColumnData
    Splitter::ImDrawListSplitter
end

struct ImVector_ImGuiColumns
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiColumns}
end

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

struct ImDrawListSharedData
    TexUvWhitePixel::ImVec2
    Font::Ptr{ImFont}
    FontSize::Cfloat
    CurveTessellationTol::Cfloat
    CircleSegmentMaxError::Cfloat
    ClipRectFullscreen::ImVec4
    InitialFlags::ImDrawListFlags
    ArcFastVtx::NTuple{12, ImVec2}
    CircleSegmentCounts::NTuple{64, ImU8}
    TexUvLines::Ptr{ImVec4}
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

struct ImVector_ImVec2
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImVec2}
end

struct ImDrawList
    CmdBuffer::ImVector_ImDrawCmd
    IdxBuffer::ImVector_ImDrawIdx
    VtxBuffer::ImVector_ImDrawVert
    Flags::ImDrawListFlags
    _Data::Ptr{ImDrawListSharedData}
    _OwnerName::Cstring
    _VtxCurrentIdx::UInt32
    _VtxWritePtr::Ptr{ImDrawVert}
    _IdxWritePtr::Ptr{ImDrawIdx}
    _ClipRectStack::ImVector_ImVec4
    _TextureIdStack::ImVector_ImTextureID
    _Path::ImVector_ImVec2
    _CmdHeader::ImDrawCmd
    _Splitter::ImDrawListSplitter
end

const ImGuiLayoutType = Cint
const ImGuiItemFlags = Cint

struct ImVector_ImGuiItemFlags
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiItemFlags}
end

struct ImGuiGroupData
    BackupCursorPos::ImVec2
    BackupCursorMaxPos::ImVec2
    BackupIndent::ImVec1
    BackupGroupOffset::ImVec1
    BackupCurrLineSize::ImVec2
    BackupCurrLineTextBaseOffset::Cfloat
    BackupActiveIdIsAlive::ImGuiID
    BackupActiveIdPreviousFrameIsAlive::Bool
    EmitItem::Bool
end

struct ImVector_ImGuiGroupData
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiGroupData}
end

struct ImVector_ImGuiWindowPtr
    Size::Cint
    Capacity::Cint
    Data::Ptr{Ptr{Cvoid}}  # Ptr{Ptr{ImGuiWindow}}
end

struct ImGuiWindowTempData
    CursorPos::ImVec2
    CursorPosPrevLine::ImVec2
    CursorStartPos::ImVec2
    CursorMaxPos::ImVec2
    CurrLineSize::ImVec2
    PrevLineSize::ImVec2
    CurrLineTextBaseOffset::Cfloat
    PrevLineTextBaseOffset::Cfloat
    Indent::ImVec1
    ColumnsOffset::ImVec1
    GroupOffset::ImVec1
    LastItemId::ImGuiID
    LastItemStatusFlags::ImGuiItemStatusFlags
    LastItemRect::ImRect
    LastItemDisplayRect::ImRect
    NavLayerCurrent::ImGuiNavLayer
    NavLayerActiveMask::Cint
    NavLayerActiveMaskNext::Cint
    NavFocusScopeIdCurrent::ImGuiID
    NavHideHighlightOneFrame::Bool
    NavHasScroll::Bool
    MenuBarAppending::Bool
    MenuBarOffset::ImVec2
    MenuColumns::ImGuiMenuColumns
    TreeDepth::Cint
    TreeJumpToParentOnPopMask::ImU32
    ChildWindows::ImVector_ImGuiWindowPtr
    StateStorage::Ptr{ImGuiStorage}
    CurrentColumns::Ptr{ImGuiColumns}
    LayoutType::ImGuiLayoutType
    ParentLayoutType::ImGuiLayoutType
    FocusCounterRegular::Cint
    FocusCounterTabStop::Cint
    ItemFlags::ImGuiItemFlags
    ItemWidth::Cfloat
    TextWrapPos::Cfloat
    ItemFlagsStack::ImVector_ImGuiItemFlags
    ItemWidthStack::ImVector_float
    TextWrapPosStack::ImVector_float
    GroupStack::ImVector_ImGuiGroupData
    StackSizesBackup::NTuple{6, Int16}
end

struct ImGuiWindow
    Name::Cstring
    ID::ImGuiID
    Flags::ImGuiWindowFlags
    Pos::ImVec2
    Size::ImVec2
    SizeFull::ImVec2
    ContentSize::ImVec2
    ContentSizeExplicit::ImVec2
    WindowPadding::ImVec2
    WindowRounding::Cfloat
    WindowBorderSize::Cfloat
    NameBufLen::Cint
    MoveId::ImGuiID
    ChildId::ImGuiID
    Scroll::ImVec2
    ScrollMax::ImVec2
    ScrollTarget::ImVec2
    ScrollTargetCenterRatio::ImVec2
    ScrollTargetEdgeSnapDist::ImVec2
    ScrollbarSizes::ImVec2
    ScrollbarX::Bool
    ScrollbarY::Bool
    Active::Bool
    WasActive::Bool
    WriteAccessed::Bool
    Collapsed::Bool
    WantCollapseToggle::Bool
    SkipItems::Bool
    Appearing::Bool
    Hidden::Bool
    IsFallbackWindow::Bool
    HasCloseButton::Bool
    ResizeBorderHeld::UInt8
    BeginCount::Int16
    BeginOrderWithinParent::Int16
    BeginOrderWithinContext::Int16
    PopupId::ImGuiID
    AutoFitFramesX::ImS8
    AutoFitFramesY::ImS8
    AutoFitChildAxises::ImS8
    AutoFitOnlyGrows::Bool
    AutoPosLastDirection::ImGuiDir
    HiddenFramesCanSkipItems::Cint
    HiddenFramesCannotSkipItems::Cint
    SetWindowPosAllowFlags::ImGuiCond
    SetWindowSizeAllowFlags::ImGuiCond
    SetWindowCollapsedAllowFlags::ImGuiCond
    SetWindowPosVal::ImVec2
    SetWindowPosPivot::ImVec2
    IDStack::ImVector_ImGuiID
    DC::ImGuiWindowTempData
    OuterRectClipped::ImRect
    InnerRect::ImRect
    InnerClipRect::ImRect
    WorkRect::ImRect
    ParentWorkRect::ImRect
    ClipRect::ImRect
    ContentRegionRect::ImRect
    HitTestHoleSize::ImVec2ih
    HitTestHoleOffset::ImVec2ih
    LastFrameActive::Cint
    LastTimeActive::Cfloat
    ItemWidthDefault::Cfloat
    StateStorage::ImGuiStorage
    ColumnsStorage::ImVector_ImGuiColumns
    FontWindowScale::Cfloat
    SettingsOffset::Cint
    DrawList::Ptr{ImDrawList}
    DrawListInst::ImDrawList
    ParentWindow::Ptr{ImGuiWindow}
    RootWindow::Ptr{ImGuiWindow}
    RootWindowForTitleBarHighlight::Ptr{ImGuiWindow}
    RootWindowForNav::Ptr{ImGuiWindow}
    NavLastChildNavWindow::Ptr{ImGuiWindow}
    NavLastIds::NTuple{2, ImGuiID}
    NavRectRel::NTuple{2, ImRect}
    MemoryCompacted::Bool
    MemoryDrawListIdxCapacity::Cint
    MemoryDrawListVtxCapacity::Cint
end

const ImGuiTabItemFlags = Cint
const ImS16 = Int16

struct ImGuiTabItem
    ID::ImGuiID
    Flags::ImGuiTabItemFlags
    LastFrameVisible::Cint
    LastFrameSelected::Cint
    Offset::Cfloat
    Width::Cfloat
    ContentWidth::Cfloat
    NameOffset::ImS16
    BeginOrder::ImS8
    IndexDuringLayout::ImS8
    WantClose::Bool
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
    Data::Cstring
end

struct ImGuiTextBuffer
    Buf::ImVector_char
end

struct ImGuiTabBar
    Tabs::ImVector_ImGuiTabItem
    ID::ImGuiID
    SelectedTabId::ImGuiID
    NextSelectedTabId::ImGuiID
    VisibleTabId::ImGuiID
    CurrFrameVisible::Cint
    PrevFrameVisible::Cint
    BarRect::ImRect
    LastTabContentHeight::Cfloat
    WidthAllTabs::Cfloat
    WidthAllTabsIdeal::Cfloat
    ScrollingAnim::Cfloat
    ScrollingTarget::Cfloat
    ScrollingTargetDistToVisibility::Cfloat
    ScrollingSpeed::Cfloat
    ScrollingRectMinX::Cfloat
    ScrollingRectMaxX::Cfloat
    Flags::ImGuiTabBarFlags
    ReorderRequestTabId::ImGuiID
    ReorderRequestDir::ImS8
    TabsActiveCount::ImS8
    WantLayout::Bool
    VisibleTabWasSubmitted::Bool
    TabsAddedNew::Bool
    LastTabItemIdx::Int16
    FramePadding::ImVec2
    TabsNames::ImGuiTextBuffer
end

const ImGuiStyleVar = Cint

struct ImGuiStyleMod
    VarIdx::ImGuiStyleVar
end

struct ImGuiSettingsHandler
    TypeName::Cstring
    TypeHash::ImGuiID
    ClearAllFn::Ptr{Cvoid}
    ReadInitFn::Ptr{Cvoid}
    ReadOpenFn::Ptr{Cvoid}
    ReadLineFn::Ptr{Cvoid}
    ApplyAllFn::Ptr{Cvoid}
    WriteAllFn::Ptr{Cvoid}
    UserData::Ptr{Cvoid}
end

struct ImGuiPopupData
    PopupId::ImGuiID
    Window::Ptr{ImGuiWindow}
    SourceWindow::Ptr{ImGuiWindow}
    OpenFrameCount::Cint
    OpenParentId::ImGuiID
    OpenPopupPos::ImVec2
    OpenMousePos::ImVec2
end

const ImGuiNextItemDataFlags = Cint

struct ImGuiNextItemData
    Flags::ImGuiNextItemDataFlags
    Width::Cfloat
    FocusScopeId::ImGuiID
    OpenCond::ImGuiCond
    OpenVal::Bool
end

const ImGuiNextWindowDataFlags = Cint
const ImGuiSizeCallback = Ptr{Cvoid}

struct ImGuiNextWindowData
    Flags::ImGuiNextWindowDataFlags
    PosCond::ImGuiCond
    SizeCond::ImGuiCond
    CollapsedCond::ImGuiCond
    PosVal::ImVec2
    PosPivotVal::ImVec2
    SizeVal::ImVec2
    ContentSizeVal::ImVec2
    ScrollVal::ImVec2
    CollapsedVal::Bool
    SizeConstraintRect::ImRect
    SizeCallback::ImGuiSizeCallback
    SizeCallbackUserData::Ptr{Cvoid}
    BgAlphaVal::Cfloat
    MenuBarOffsetMinVal::ImVec2
end

struct ImGuiNavMoveResult
    Window::Ptr{ImGuiWindow}
    ID::ImGuiID
    FocusScopeId::ImGuiID
    DistBox::Cfloat
    DistCenter::Cfloat
    DistAxial::Cfloat
    RectRel::ImRect
end

struct ImGuiLastItemDataBackup
    LastItemId::ImGuiID
    LastItemStatusFlags::ImGuiItemStatusFlags
    LastItemRect::ImRect
    LastItemDisplayRect::ImRect
end

struct StbUndoRecord
    where::Cint
    insert_length::Cint
    delete_length::Cint
    char_storage::Cint
end

struct StbUndoState
    undo_rec::NTuple{99, StbUndoRecord}
    undo_char::NTuple{999, ImWchar}
    undo_point::Int16
    redo_point::Int16
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
const ImGuiInputTextCallback = Ptr{Cvoid}

struct ImGuiInputTextState
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
    UserFlags::ImGuiInputTextFlags
    UserCallback::ImGuiInputTextCallback
    UserCallbackData::Ptr{Cvoid}
end

struct ImGuiDataTypeInfo
    Size::Csize_t
    Name::Cstring
    PrintFmt::Cstring
    ScanFmt::Cstring
end

const ImGuiCol = Cint

struct ImGuiColorMod
    Col::ImGuiCol
    BackupValue::ImVec4
end

struct ImVector_ImDrawListPtr
    Size::Cint
    Capacity::Cint
    Data::Ptr{Ptr{ImDrawList}}
end

struct ImDrawDataBuilder
    Layers::NTuple{2, ImVector_ImDrawListPtr}
end

struct ImVector_ImU32
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImU32}
end

struct ImBitVector
    Storage::ImVector_ImU32
end

struct ImVector_ImGuiTextRange
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiTextRange}
end

struct ImGuiTextFilter
    InputBuf::NTuple{256, UInt8}
    Filters::ImVector_ImGuiTextRange
    CountGrep::Cint
end

struct ImGuiStyle
    Alpha::Cfloat
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
    ColorButtonPosition::ImGuiDir
    ButtonTextAlign::ImVec2
    SelectableTextAlign::ImVec2
    DisplayWindowPadding::ImVec2
    DisplaySafeAreaPadding::ImVec2
    MouseCursorScale::Cfloat
    AntiAliasedLines::Bool
    AntiAliasedLinesUseTex::Bool
    AntiAliasedFill::Bool
    CurveTessellationTol::Cfloat
    CircleSegmentMaxError::Cfloat
    Colors::NTuple{48, ImVec4}
end

struct ImGuiSizeCallbackData
    UserData::Ptr{Cvoid}
    Pos::ImVec2
    CurrentSize::ImVec2
    DesiredSize::ImVec2
end

struct ImGuiPayload
    Data::Ptr{Cvoid}
    DataSize::Cint
    SourceId::ImGuiID
    SourceParentId::ImGuiID
    DataFrameCount::Cint
    DataType::NTuple{33, UInt8}
    Preview::Bool
    Delivery::Bool
end

struct ImGuiOnceUponAFrame
    RefFrame::Cint
end

struct ImGuiListClipper
    DisplayStart::Cint
    DisplayEnd::Cint
    ItemsCount::Cint
    StepNo::Cint
    ItemsHeight::Cfloat
    StartPosY::Cfloat
end

const ImGuiKey = Cint

struct ImGuiInputTextCallbackData
    EventFlag::ImGuiInputTextFlags
    Flags::ImGuiInputTextFlags
    UserData::Ptr{Cvoid}
    EventChar::ImWchar
    EventKey::ImGuiKey
    Buf::Cstring
    BufTextLen::Cint
    BufSize::Cint
    BufDirty::Bool
    CursorPos::Cint
    SelectionStart::Cint
    SelectionEnd::Cint
end

const ImGuiConfigFlags = Cint
const ImGuiBackendFlags = Cint
const ImGuiKeyModFlags = Cint

struct ImGuiIO
    ConfigFlags::ImGuiConfigFlags
    BackendFlags::ImGuiBackendFlags
    DisplaySize::ImVec2
    DeltaTime::Cfloat
    IniSavingRate::Cfloat
    IniFilename::Cstring
    LogFilename::Cstring
    MouseDoubleClickTime::Cfloat
    MouseDoubleClickMaxDist::Cfloat
    MouseDragThreshold::Cfloat
    KeyMap::NTuple{22, Cint}
    KeyRepeatDelay::Cfloat
    KeyRepeatRate::Cfloat
    UserData::Ptr{Cvoid}
    Fonts::Ptr{ImFontAtlas}
    FontGlobalScale::Cfloat
    FontAllowUserScaling::Bool
    FontDefault::Ptr{ImFont}
    DisplayFramebufferScale::ImVec2
    MouseDrawCursor::Bool
    ConfigMacOSXBehaviors::Bool
    ConfigInputTextCursorBlink::Bool
    ConfigWindowsResizeFromEdges::Bool
    ConfigWindowsMoveFromTitleBarOnly::Bool
    ConfigWindowsMemoryCompactTimer::Cfloat
    BackendPlatformName::Cstring
    BackendRendererName::Cstring
    BackendPlatformUserData::Ptr{Cvoid}
    BackendRendererUserData::Ptr{Cvoid}
    BackendLanguageUserData::Ptr{Cvoid}
    GetClipboardTextFn::Ptr{Cvoid}
    SetClipboardTextFn::Ptr{Cvoid}
    ClipboardUserData::Ptr{Cvoid}
    ImeSetInputScreenPosFn::Ptr{Cvoid}
    ImeWindowHandle::Ptr{Cvoid}
    RenderDrawListsFnUnused::Ptr{Cvoid}
    MousePos::ImVec2
    MouseDown::NTuple{5, Bool}
    MouseWheel::Cfloat
    MouseWheelH::Cfloat
    KeyCtrl::Bool
    KeyShift::Bool
    KeyAlt::Bool
    KeySuper::Bool
    KeysDown::NTuple{512, Bool}
    NavInputs::NTuple{21, Cfloat}
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
    MetricsActiveAllocations::Cint
    MouseDelta::ImVec2
    KeyMods::ImGuiKeyModFlags
    MousePosPrev::ImVec2
    MouseClickedPos::NTuple{5, ImVec2}
    MouseClickedTime::NTuple{5, Cdouble}
    MouseClicked::NTuple{5, Bool}
    MouseDoubleClicked::NTuple{5, Bool}
    MouseReleased::NTuple{5, Bool}
    MouseDownOwned::NTuple{5, Bool}
    MouseDownWasDoubleClick::NTuple{5, Bool}
    MouseDownDuration::NTuple{5, Cfloat}
    MouseDownDurationPrev::NTuple{5, Cfloat}
    MouseDragMaxDistanceAbs::NTuple{5, ImVec2}
    MouseDragMaxDistanceSqr::NTuple{5, Cfloat}
    KeysDownDuration::NTuple{512, Cfloat}
    KeysDownDurationPrev::NTuple{512, Cfloat}
    NavInputsDownDuration::NTuple{21, Cfloat}
    NavInputsDownDurationPrev::NTuple{21, Cfloat}
    PenPressure::Cfloat
    InputQueueSurrogate::ImWchar16
    InputQueueCharacters::ImVector_ImWchar
end

const ImU64 = UInt64

@cenum ImGuiInputSource::UInt32 begin
    ImGuiInputSource_None = 0
    ImGuiInputSource_Mouse = 1
    ImGuiInputSource_Nav = 2
    ImGuiInputSource_NavKeyboard = 3
    ImGuiInputSource_NavGamepad = 4
    ImGuiInputSource_COUNT = 5
end


struct ImVector_ImGuiColorMod
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiColorMod}
end

struct ImVector_ImGuiStyleMod
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiStyleMod}
end

struct ImVector_ImGuiPopupData
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiPopupData}
end

const ImGuiNavMoveFlags = Cint

@cenum ImGuiNavForward::UInt32 begin
    ImGuiNavForward_None = 0
    ImGuiNavForward_ForwardQueued = 1
    ImGuiNavForward_ForwardActive = 2
end


struct ImDrawData
    Valid::Bool
    CmdLists::Ptr{Ptr{ImDrawList}}
    CmdListsCount::Cint
    TotalIdxCount::Cint
    TotalVtxCount::Cint
    DisplayPos::ImVec2
    DisplaySize::ImVec2
    FramebufferScale::ImVec2
end

const ImGuiMouseCursor = Cint
const ImGuiDragDropFlags = Cint

struct ImVector_unsigned_char
    Size::Cint
    Capacity::Cint
    Data::Ptr{Cuchar}
end

struct ImVector_ImGuiTabBar
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiTabBar}
end

const ImPoolIdx = Cint

struct ImPool_ImGuiTabBar
    Buf::ImVector_ImGuiTabBar
    Map::ImGuiStorage
    FreeIdx::ImPoolIdx
end

struct ImVector_ImGuiPtrOrIndex
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiPtrOrIndex}
end

struct ImVector_ImGuiShrinkWidthItem
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiShrinkWidthItem}
end

const ImGuiColorEditFlags = Cint

struct ImVector_ImGuiSettingsHandler
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiSettingsHandler}
end

struct ImVector_ImGuiWindowSettings
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiWindowSettings}
end

struct ImChunkStream_ImGuiWindowSettings
    Buf::ImVector_ImGuiWindowSettings
end

@cenum ImGuiLogType::UInt32 begin
    ImGuiLogType_None = 0
    ImGuiLogType_TTY = 1
    ImGuiLogType_File = 2
    ImGuiLogType_Buffer = 3
    ImGuiLogType_Clipboard = 4
end


const ImFileHandle = Ptr{Libc.FILE}

struct ImGuiContext
    Initialized::Bool
    FontAtlasOwnedByContext::Bool
    IO::ImGuiIO
    Style::ImGuiStyle
    Font::Ptr{ImFont}
    FontSize::Cfloat
    FontBaseSize::Cfloat
    DrawListSharedData::ImDrawListSharedData
    Time::Cdouble
    FrameCount::Cint
    FrameCountEnded::Cint
    FrameCountRendered::Cint
    WithinFrameScope::Bool
    WithinFrameScopeWithImplicitWindow::Bool
    WithinEndChild::Bool
    TestEngineHookItems::Bool
    TestEngineHookIdInfo::ImGuiID
    TestEngine::Ptr{Cvoid}
    Windows::ImVector_ImGuiWindowPtr
    WindowsFocusOrder::ImVector_ImGuiWindowPtr
    WindowsTempSortBuffer::ImVector_ImGuiWindowPtr
    CurrentWindowStack::ImVector_ImGuiWindowPtr
    WindowsById::ImGuiStorage
    WindowsActiveCount::Cint
    CurrentWindow::Ptr{ImGuiWindow}
    HoveredWindow::Ptr{ImGuiWindow}
    HoveredRootWindow::Ptr{ImGuiWindow}
    HoveredWindowUnderMovingWindow::Ptr{ImGuiWindow}
    MovingWindow::Ptr{ImGuiWindow}
    WheelingWindow::Ptr{ImGuiWindow}
    WheelingWindowRefMousePos::ImVec2
    WheelingWindowTimer::Cfloat
    HoveredId::ImGuiID
    HoveredIdPreviousFrame::ImGuiID
    HoveredIdAllowOverlap::Bool
    HoveredIdDisabled::Bool
    HoveredIdTimer::Cfloat
    HoveredIdNotActiveTimer::Cfloat
    ActiveId::ImGuiID
    ActiveIdIsAlive::ImGuiID
    ActiveIdTimer::Cfloat
    ActiveIdIsJustActivated::Bool
    ActiveIdAllowOverlap::Bool
    ActiveIdNoClearOnFocusLoss::Bool
    ActiveIdHasBeenPressedBefore::Bool
    ActiveIdHasBeenEditedBefore::Bool
    ActiveIdHasBeenEditedThisFrame::Bool
    ActiveIdUsingNavDirMask::ImU32
    ActiveIdUsingNavInputMask::ImU32
    ActiveIdUsingKeyInputMask::ImU64
    ActiveIdClickOffset::ImVec2
    ActiveIdWindow::Ptr{ImGuiWindow}
    ActiveIdSource::ImGuiInputSource
    ActiveIdMouseButton::Cint
    ActiveIdPreviousFrame::ImGuiID
    ActiveIdPreviousFrameIsAlive::Bool
    ActiveIdPreviousFrameHasBeenEditedBefore::Bool
    ActiveIdPreviousFrameWindow::Ptr{ImGuiWindow}
    LastActiveId::ImGuiID
    LastActiveIdTimer::Cfloat
    NextWindowData::ImGuiNextWindowData
    NextItemData::ImGuiNextItemData
    ColorModifiers::ImVector_ImGuiColorMod
    StyleModifiers::ImVector_ImGuiStyleMod
    FontStack::ImVector_ImFontPtr
    OpenPopupStack::ImVector_ImGuiPopupData
    BeginPopupStack::ImVector_ImGuiPopupData
    NavWindow::Ptr{ImGuiWindow}
    NavId::ImGuiID
    NavFocusScopeId::ImGuiID
    NavActivateId::ImGuiID
    NavActivateDownId::ImGuiID
    NavActivatePressedId::ImGuiID
    NavInputId::ImGuiID
    NavJustTabbedId::ImGuiID
    NavJustMovedToId::ImGuiID
    NavJustMovedToFocusScopeId::ImGuiID
    NavJustMovedToKeyMods::ImGuiKeyModFlags
    NavNextActivateId::ImGuiID
    NavInputSource::ImGuiInputSource
    NavScoringRect::ImRect
    NavScoringCount::Cint
    NavLayer::ImGuiNavLayer
    NavIdTabCounter::Cint
    NavIdIsAlive::Bool
    NavMousePosDirty::Bool
    NavDisableHighlight::Bool
    NavDisableMouseHover::Bool
    NavAnyRequest::Bool
    NavInitRequest::Bool
    NavInitRequestFromMove::Bool
    NavInitResultId::ImGuiID
    NavInitResultRectRel::ImRect
    NavMoveRequest::Bool
    NavMoveRequestFlags::ImGuiNavMoveFlags
    NavMoveRequestForward::ImGuiNavForward
    NavMoveRequestKeyMods::ImGuiKeyModFlags
    NavMoveDir::ImGuiDir
    NavMoveDirLast::ImGuiDir
    NavMoveClipDir::ImGuiDir
    NavMoveResultLocal::ImGuiNavMoveResult
    NavMoveResultLocalVisibleSet::ImGuiNavMoveResult
    NavMoveResultOther::ImGuiNavMoveResult
    NavWrapRequestWindow::Ptr{ImGuiWindow}
    NavWrapRequestFlags::ImGuiNavMoveFlags
    NavWindowingTarget::Ptr{ImGuiWindow}
    NavWindowingTargetAnim::Ptr{ImGuiWindow}
    NavWindowingListWindow::Ptr{ImGuiWindow}
    NavWindowingTimer::Cfloat
    NavWindowingHighlightAlpha::Cfloat
    NavWindowingToggleLayer::Bool
    FocusRequestCurrWindow::Ptr{ImGuiWindow}
    FocusRequestNextWindow::Ptr{ImGuiWindow}
    FocusRequestCurrCounterRegular::Cint
    FocusRequestCurrCounterTabStop::Cint
    FocusRequestNextCounterRegular::Cint
    FocusRequestNextCounterTabStop::Cint
    FocusTabPressed::Bool
    DrawData::ImDrawData
    DrawDataBuilder::ImDrawDataBuilder
    DimBgRatio::Cfloat
    BackgroundDrawList::ImDrawList
    ForegroundDrawList::ImDrawList
    MouseCursor::ImGuiMouseCursor
    DragDropActive::Bool
    DragDropWithinSource::Bool
    DragDropWithinTarget::Bool
    DragDropSourceFlags::ImGuiDragDropFlags
    DragDropSourceFrameCount::Cint
    DragDropMouseButton::Cint
    DragDropPayload::ImGuiPayload
    DragDropTargetRect::ImRect
    DragDropTargetId::ImGuiID
    DragDropAcceptFlags::ImGuiDragDropFlags
    DragDropAcceptIdCurrRectSurface::Cfloat
    DragDropAcceptIdCurr::ImGuiID
    DragDropAcceptIdPrev::ImGuiID
    DragDropAcceptFrameCount::Cint
    DragDropHoldJustPressedId::ImGuiID
    DragDropPayloadBufHeap::ImVector_unsigned_char
    DragDropPayloadBufLocal::NTuple{16, Cuchar}
    CurrentTabBar::Ptr{ImGuiTabBar}
    TabBars::ImPool_ImGuiTabBar
    CurrentTabBarStack::ImVector_ImGuiPtrOrIndex
    ShrinkWidthBuffer::ImVector_ImGuiShrinkWidthItem
    LastValidMousePos::ImVec2
    InputTextState::ImGuiInputTextState
    InputTextPasswordFont::ImFont
    TempInputId::ImGuiID
    ColorEditOptions::ImGuiColorEditFlags
    ColorEditLastHue::Cfloat
    ColorEditLastSat::Cfloat
    ColorEditLastColor::NTuple{3, Cfloat}
    ColorPickerRef::ImVec4
    SliderCurrentAccum::Cfloat
    SliderCurrentAccumDirty::Bool
    DragCurrentAccumDirty::Bool
    DragCurrentAccum::Cfloat
    DragSpeedDefaultRatio::Cfloat
    ScrollbarClickDeltaToGrabCenter::Cfloat
    TooltipOverrideCount::Cint
    ClipboardHandlerData::ImVector_char
    MenusIdSubmittedThisFrame::ImVector_ImGuiID
    PlatformImePos::ImVec2
    PlatformImeLastPos::ImVec2
    PlatformLocaleDecimalPoint::UInt8
    SettingsLoaded::Bool
    SettingsDirtyTimer::Cfloat
    SettingsIniData::ImGuiTextBuffer
    SettingsHandlers::ImVector_ImGuiSettingsHandler
    SettingsWindows::ImChunkStream_ImGuiWindowSettings
    LogEnabled::Bool
    LogType::ImGuiLogType
    LogFile::ImFileHandle
    LogBuffer::ImGuiTextBuffer
    LogLinePosY::Cfloat
    LogLineFirstItem::Bool
    LogDepthRef::Cint
    LogDepthToExpand::Cint
    LogDepthToExpandDefault::Cint
    DebugItemPickerActive::Bool
    DebugItemPickerBreakId::ImGuiID
    FramerateSecPerFrame::NTuple{120, Cfloat}
    FramerateSecPerFrameIdx::Cint
    FramerateSecPerFrameAccum::Cfloat
    WantCaptureMouseNextFrame::Cint
    WantCaptureKeyboardNextFrame::Cint
    WantTextInputNextFrame::Cint
    TempBuffer::NTuple{3073, UInt8}
end

struct ImColor
    Value::ImVec4
end

struct ImFontGlyphRangesBuilder
    UsedChars::ImVector_ImU32
end

const ImGuiDataType = Cint
const ImGuiNavInput = Cint
const ImGuiMouseButton = Cint
const ImDrawCornerFlags = Cint
const ImGuiButtonFlags = Cint
const ImGuiComboFlags = Cint
const ImGuiFocusedFlags = Cint
const ImGuiHoveredFlags = Cint
const ImGuiPopupFlags = Cint
const ImGuiSelectableFlags = Cint
const ImGuiSliderFlags = Cint
const ImGuiTreeNodeFlags = Cint
const ImWchar32 = UInt32
const ImU16 = UInt16
const ImS32 = Cint
const ImS64 = Int64
const ImGuiNavHighlightFlags = Cint
const ImGuiNavDirSourceFlags = Cint
const ImGuiSeparatorFlags = Cint
const ImGuiTextFlags = Cint
const ImGuiTooltipFlags = Cint

struct ImVector
    Size::Cint
    Capacity::Cint
    Data::Ptr{Cvoid}
end

struct StbTexteditRow
    x0::Cfloat
    x1::Cfloat
    baseline_y_delta::Cfloat
    ymin::Cfloat
    ymax::Cfloat
    num_chars::Cint
end

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
    ImGuiWindowFlags_AlwaysUseWindowPadding = 65536
    ImGuiWindowFlags_NoNavInputs = 262144
    ImGuiWindowFlags_NoNavFocus = 524288
    ImGuiWindowFlags_UnsavedDocument = 1048576
    ImGuiWindowFlags_NoNav = 786432
    ImGuiWindowFlags_NoDecoration = 43
    ImGuiWindowFlags_NoInputs = 786944
    ImGuiWindowFlags_NavFlattened = 8388608
    ImGuiWindowFlags_ChildWindow = 16777216
    ImGuiWindowFlags_Tooltip = 33554432
    ImGuiWindowFlags_Popup = 67108864
    ImGuiWindowFlags_Modal = 134217728
    ImGuiWindowFlags_ChildMenu = 268435456
end

@cenum ImGuiInputTextFlags_::UInt32 begin
    ImGuiInputTextFlags_None = 0
    ImGuiInputTextFlags_CharsDecimal = 1
    ImGuiInputTextFlags_CharsHexadecimal = 2
    ImGuiInputTextFlags_CharsUppercase = 4
    ImGuiInputTextFlags_CharsNoBlank = 8
    ImGuiInputTextFlags_AutoSelectAll = 16
    ImGuiInputTextFlags_EnterReturnsTrue = 32
    ImGuiInputTextFlags_CallbackCompletion = 64
    ImGuiInputTextFlags_CallbackHistory = 128
    ImGuiInputTextFlags_CallbackAlways = 256
    ImGuiInputTextFlags_CallbackCharFilter = 512
    ImGuiInputTextFlags_AllowTabInput = 1024
    ImGuiInputTextFlags_CtrlEnterForNewLine = 2048
    ImGuiInputTextFlags_NoHorizontalScroll = 4096
    ImGuiInputTextFlags_AlwaysInsertMode = 8192
    ImGuiInputTextFlags_ReadOnly = 16384
    ImGuiInputTextFlags_Password = 32768
    ImGuiInputTextFlags_NoUndoRedo = 65536
    ImGuiInputTextFlags_CharsScientific = 131072
    ImGuiInputTextFlags_CallbackResize = 262144
    ImGuiInputTextFlags_CallbackEdit = 524288
    ImGuiInputTextFlags_Multiline = 1048576
    ImGuiInputTextFlags_NoMarkEdited = 2097152
end

@cenum ImGuiTreeNodeFlags_::UInt32 begin
    ImGuiTreeNodeFlags_None = 0
    ImGuiTreeNodeFlags_Selected = 1
    ImGuiTreeNodeFlags_Framed = 2
    ImGuiTreeNodeFlags_AllowItemOverlap = 4
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
    ImGuiTreeNodeFlags_NavLeftJumpsBackHere = 8192
    ImGuiTreeNodeFlags_CollapsingHeader = 26
end

@cenum ImGuiPopupFlags_::UInt32 begin
    ImGuiPopupFlags_None = 0
    ImGuiPopupFlags_MouseButtonLeft = 0
    ImGuiPopupFlags_MouseButtonRight = 1
    ImGuiPopupFlags_MouseButtonMiddle = 2
    ImGuiPopupFlags_MouseButtonMask_ = 31
    ImGuiPopupFlags_MouseButtonDefault_ = 1
    ImGuiPopupFlags_NoOpenOverExistingPopup = 32
    ImGuiPopupFlags_NoOpenOverItems = 64
    ImGuiPopupFlags_AnyPopupId = 128
    ImGuiPopupFlags_AnyPopupLevel = 256
    ImGuiPopupFlags_AnyPopup = 384
end

@cenum ImGuiSelectableFlags_::UInt32 begin
    ImGuiSelectableFlags_None = 0
    ImGuiSelectableFlags_DontClosePopups = 1
    ImGuiSelectableFlags_SpanAllColumns = 2
    ImGuiSelectableFlags_AllowDoubleClick = 4
    ImGuiSelectableFlags_Disabled = 8
    ImGuiSelectableFlags_AllowItemOverlap = 16
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
    ImGuiTabBarFlags_FittingPolicyResizeDown = 64
    ImGuiTabBarFlags_FittingPolicyScroll = 128
    ImGuiTabBarFlags_FittingPolicyMask_ = 192
    ImGuiTabBarFlags_FittingPolicyDefault_ = 64
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
end

@cenum ImGuiFocusedFlags_::UInt32 begin
    ImGuiFocusedFlags_None = 0
    ImGuiFocusedFlags_ChildWindows = 1
    ImGuiFocusedFlags_RootWindow = 2
    ImGuiFocusedFlags_AnyWindow = 4
    ImGuiFocusedFlags_RootAndChildWindows = 3
end

@cenum ImGuiHoveredFlags_::UInt32 begin
    ImGuiHoveredFlags_None = 0
    ImGuiHoveredFlags_ChildWindows = 1
    ImGuiHoveredFlags_RootWindow = 2
    ImGuiHoveredFlags_AnyWindow = 4
    ImGuiHoveredFlags_AllowWhenBlockedByPopup = 8
    ImGuiHoveredFlags_AllowWhenBlockedByActiveItem = 32
    ImGuiHoveredFlags_AllowWhenOverlapped = 64
    ImGuiHoveredFlags_AllowWhenDisabled = 128
    ImGuiHoveredFlags_RectOnly = 104
    ImGuiHoveredFlags_RootAndChildWindows = 3
end

@cenum ImGuiDragDropFlags_::UInt32 begin
    ImGuiDragDropFlags_None = 0
    ImGuiDragDropFlags_SourceNoPreviewTooltip = 1
    ImGuiDragDropFlags_SourceNoDisableHover = 2
    ImGuiDragDropFlags_SourceNoHoldToOpenOthers = 4
    ImGuiDragDropFlags_SourceAllowNullID = 8
    ImGuiDragDropFlags_SourceExtern = 16
    ImGuiDragDropFlags_SourceAutoExpirePayload = 32
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
    ImGuiDataType_COUNT = 10
end

@cenum ImGuiDir_::Int32 begin
    ImGuiDir_None = -1
    ImGuiDir_Left = 0
    ImGuiDir_Right = 1
    ImGuiDir_Up = 2
    ImGuiDir_Down = 3
    ImGuiDir_COUNT = 4
end

@cenum ImGuiKey_::UInt32 begin
    ImGuiKey_Tab = 0
    ImGuiKey_LeftArrow = 1
    ImGuiKey_RightArrow = 2
    ImGuiKey_UpArrow = 3
    ImGuiKey_DownArrow = 4
    ImGuiKey_PageUp = 5
    ImGuiKey_PageDown = 6
    ImGuiKey_Home = 7
    ImGuiKey_End = 8
    ImGuiKey_Insert = 9
    ImGuiKey_Delete = 10
    ImGuiKey_Backspace = 11
    ImGuiKey_Space = 12
    ImGuiKey_Enter = 13
    ImGuiKey_Escape = 14
    ImGuiKey_KeyPadEnter = 15
    ImGuiKey_A = 16
    ImGuiKey_C = 17
    ImGuiKey_V = 18
    ImGuiKey_X = 19
    ImGuiKey_Y = 20
    ImGuiKey_Z = 21
    ImGuiKey_COUNT = 22
end

@cenum ImGuiKeyModFlags_::UInt32 begin
    ImGuiKeyModFlags_None = 0
    ImGuiKeyModFlags_Ctrl = 1
    ImGuiKeyModFlags_Shift = 2
    ImGuiKeyModFlags_Alt = 4
    ImGuiKeyModFlags_Super = 8
end

@cenum ImGuiNavInput_::UInt32 begin
    ImGuiNavInput_Activate = 0
    ImGuiNavInput_Cancel = 1
    ImGuiNavInput_Input = 2
    ImGuiNavInput_Menu = 3
    ImGuiNavInput_DpadLeft = 4
    ImGuiNavInput_DpadRight = 5
    ImGuiNavInput_DpadUp = 6
    ImGuiNavInput_DpadDown = 7
    ImGuiNavInput_LStickLeft = 8
    ImGuiNavInput_LStickRight = 9
    ImGuiNavInput_LStickUp = 10
    ImGuiNavInput_LStickDown = 11
    ImGuiNavInput_FocusPrev = 12
    ImGuiNavInput_FocusNext = 13
    ImGuiNavInput_TweakSlow = 14
    ImGuiNavInput_TweakFast = 15
    ImGuiNavInput_KeyMenu_ = 16
    ImGuiNavInput_KeyLeft_ = 17
    ImGuiNavInput_KeyRight_ = 18
    ImGuiNavInput_KeyUp_ = 19
    ImGuiNavInput_KeyDown_ = 20
    ImGuiNavInput_COUNT = 21
    ImGuiNavInput_InternalStart_ = 16
end

@cenum ImGuiConfigFlags_::UInt32 begin
    ImGuiConfigFlags_None = 0
    ImGuiConfigFlags_NavEnableKeyboard = 1
    ImGuiConfigFlags_NavEnableGamepad = 2
    ImGuiConfigFlags_NavEnableSetMousePos = 4
    ImGuiConfigFlags_NavNoCaptureKeyboard = 8
    ImGuiConfigFlags_NoMouse = 16
    ImGuiConfigFlags_NoMouseCursorChange = 32
    ImGuiConfigFlags_IsSRGB = 1048576
    ImGuiConfigFlags_IsTouchScreen = 2097152
end

@cenum ImGuiBackendFlags_::UInt32 begin
    ImGuiBackendFlags_None = 0
    ImGuiBackendFlags_HasGamepad = 1
    ImGuiBackendFlags_HasMouseCursors = 2
    ImGuiBackendFlags_HasSetMousePos = 4
    ImGuiBackendFlags_RendererHasVtxOffset = 8
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
    ImGuiCol_Tab = 33
    ImGuiCol_TabHovered = 34
    ImGuiCol_TabActive = 35
    ImGuiCol_TabUnfocused = 36
    ImGuiCol_TabUnfocusedActive = 37
    ImGuiCol_PlotLines = 38
    ImGuiCol_PlotLinesHovered = 39
    ImGuiCol_PlotHistogram = 40
    ImGuiCol_PlotHistogramHovered = 41
    ImGuiCol_TextSelectedBg = 42
    ImGuiCol_DragDropTarget = 43
    ImGuiCol_NavHighlight = 44
    ImGuiCol_NavWindowingHighlight = 45
    ImGuiCol_NavWindowingDimBg = 46
    ImGuiCol_ModalWindowDimBg = 47
    ImGuiCol_COUNT = 48
end

@cenum ImGuiStyleVar_::UInt32 begin
    ImGuiStyleVar_Alpha = 0
    ImGuiStyleVar_WindowPadding = 1
    ImGuiStyleVar_WindowRounding = 2
    ImGuiStyleVar_WindowBorderSize = 3
    ImGuiStyleVar_WindowMinSize = 4
    ImGuiStyleVar_WindowTitleAlign = 5
    ImGuiStyleVar_ChildRounding = 6
    ImGuiStyleVar_ChildBorderSize = 7
    ImGuiStyleVar_PopupRounding = 8
    ImGuiStyleVar_PopupBorderSize = 9
    ImGuiStyleVar_FramePadding = 10
    ImGuiStyleVar_FrameRounding = 11
    ImGuiStyleVar_FrameBorderSize = 12
    ImGuiStyleVar_ItemSpacing = 13
    ImGuiStyleVar_ItemInnerSpacing = 14
    ImGuiStyleVar_IndentSpacing = 15
    ImGuiStyleVar_ScrollbarSize = 16
    ImGuiStyleVar_ScrollbarRounding = 17
    ImGuiStyleVar_GrabMinSize = 18
    ImGuiStyleVar_GrabRounding = 19
    ImGuiStyleVar_TabRounding = 20
    ImGuiStyleVar_ButtonTextAlign = 21
    ImGuiStyleVar_SelectableTextAlign = 22
    ImGuiStyleVar_COUNT = 23
end

@cenum ImGuiButtonFlags_::UInt32 begin
    ImGuiButtonFlags_None = 0
    ImGuiButtonFlags_MouseButtonLeft = 1
    ImGuiButtonFlags_MouseButtonRight = 2
    ImGuiButtonFlags_MouseButtonMiddle = 4
    ImGuiButtonFlags_MouseButtonMask_ = 7
    ImGuiButtonFlags_MouseButtonDefault_ = 1
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
    ImGuiColorEditFlags__OptionsDefault = 177209344
    ImGuiColorEditFlags__DisplayMask = 7340032
    ImGuiColorEditFlags__DataTypeMask = 25165824
    ImGuiColorEditFlags__PickerMask = 100663296
    ImGuiColorEditFlags__InputMask = 402653184
end

@cenum ImGuiSliderFlags_::UInt32 begin
    ImGuiSliderFlags_None = 0
    ImGuiSliderFlags_AlwaysClamp = 16
    ImGuiSliderFlags_Logarithmic = 32
    ImGuiSliderFlags_NoRoundToFormat = 64
    ImGuiSliderFlags_NoInput = 128
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

@cenum ImDrawCornerFlags_::UInt32 begin
    ImDrawCornerFlags_None = 0
    ImDrawCornerFlags_TopLeft = 1
    ImDrawCornerFlags_TopRight = 2
    ImDrawCornerFlags_BotLeft = 4
    ImDrawCornerFlags_BotRight = 8
    ImDrawCornerFlags_Top = 3
    ImDrawCornerFlags_Bot = 12
    ImDrawCornerFlags_Left = 5
    ImDrawCornerFlags_Right = 10
    ImDrawCornerFlags_All = 15
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

@cenum ImGuiItemFlags_::UInt32 begin
    ImGuiItemFlags_None = 0
    ImGuiItemFlags_NoTabStop = 1
    ImGuiItemFlags_ButtonRepeat = 2
    ImGuiItemFlags_Disabled = 4
    ImGuiItemFlags_NoNav = 8
    ImGuiItemFlags_NoNavDefaultFocus = 16
    ImGuiItemFlags_SelectableDontClosePopup = 32
    ImGuiItemFlags_MixedValue = 64
    ImGuiItemFlags_ReadOnly = 128
    ImGuiItemFlags_Default_ = 0
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
    ImGuiButtonFlags_AllowItemOverlap = 4096
    ImGuiButtonFlags_DontClosePopups = 8192
    ImGuiButtonFlags_Disabled = 16384
    ImGuiButtonFlags_AlignTextBaseLine = 32768
    ImGuiButtonFlags_NoKeyModifiers = 65536
    ImGuiButtonFlags_NoHoldingActiveId = 131072
    ImGuiButtonFlags_NoNavFocus = 262144
    ImGuiButtonFlags_NoHoveredOnFocus = 524288
    ImGuiButtonFlags_PressedOnMask_ = 1008
    ImGuiButtonFlags_PressedOnDefault_ = 32
end

@cenum ImGuiSliderFlagsPrivate_::UInt32 begin
    ImGuiSliderFlags_Vertical = 1048576
    ImGuiSliderFlags_ReadOnly = 2097152
end

@cenum ImGuiSelectableFlagsPrivate_::UInt32 begin
    ImGuiSelectableFlags_NoHoldingActiveID = 1048576
    ImGuiSelectableFlags_SelectOnClick = 2097152
    ImGuiSelectableFlags_SelectOnRelease = 4194304
    ImGuiSelectableFlags_SpanAvailWidth = 8388608
    ImGuiSelectableFlags_DrawHoveredWhenHeld = 16777216
    ImGuiSelectableFlags_SetNavIdOnHover = 33554432
    ImGuiSelectableFlags_NoPadWithHalfSpacing = 67108864
end

@cenum ImGuiTreeNodeFlagsPrivate_::UInt32 begin
    ImGuiTreeNodeFlags_ClipLabelForTrailingButton = 1048576
end

@cenum ImGuiSeparatorFlags_::UInt32 begin
    ImGuiSeparatorFlags_None = 0
    ImGuiSeparatorFlags_Horizontal = 1
    ImGuiSeparatorFlags_Vertical = 2
    ImGuiSeparatorFlags_SpanAllColumns = 4
end

@cenum ImGuiTextFlags_::UInt32 begin
    ImGuiTextFlags_None = 0
    ImGuiTextFlags_NoWidthForLargeClippedText = 1
end

@cenum ImGuiTooltipFlags_::UInt32 begin
    ImGuiTooltipFlags_None = 0
    ImGuiTooltipFlags_OverridePreviousTooltip = 1
end

@cenum ImGuiLayoutType_::UInt32 begin
    ImGuiLayoutType_Horizontal = 0
    ImGuiLayoutType_Vertical = 1
end

@cenum ImGuiAxis::Int32 begin
    ImGuiAxis_None = -1
    ImGuiAxis_X = 0
    ImGuiAxis_Y = 1
end

@cenum ImGuiPlotType::UInt32 begin
    ImGuiPlotType_Lines = 0
    ImGuiPlotType_Histogram = 1
end

@cenum ImGuiInputReadMode::UInt32 begin
    ImGuiInputReadMode_Down = 0
    ImGuiInputReadMode_Pressed = 1
    ImGuiInputReadMode_Released = 2
    ImGuiInputReadMode_Repeat = 3
    ImGuiInputReadMode_RepeatSlow = 4
    ImGuiInputReadMode_RepeatFast = 5
end

@cenum ImGuiNavHighlightFlags_::UInt32 begin
    ImGuiNavHighlightFlags_None = 0
    ImGuiNavHighlightFlags_TypeDefault = 1
    ImGuiNavHighlightFlags_TypeThin = 2
    ImGuiNavHighlightFlags_AlwaysDraw = 4
    ImGuiNavHighlightFlags_NoRounding = 8
end

@cenum ImGuiNavDirSourceFlags_::UInt32 begin
    ImGuiNavDirSourceFlags_None = 0
    ImGuiNavDirSourceFlags_Keyboard = 1
    ImGuiNavDirSourceFlags_PadDPad = 2
    ImGuiNavDirSourceFlags_PadLStick = 4
end

@cenum ImGuiNavMoveFlags_::UInt32 begin
    ImGuiNavMoveFlags_None = 0
    ImGuiNavMoveFlags_LoopX = 1
    ImGuiNavMoveFlags_LoopY = 2
    ImGuiNavMoveFlags_WrapX = 4
    ImGuiNavMoveFlags_WrapY = 8
    ImGuiNavMoveFlags_AllowCurrentNavId = 16
    ImGuiNavMoveFlags_AlsoScoreVisibleSet = 32
    ImGuiNavMoveFlags_ScrollToEdge = 64
end

@cenum ImGuiPopupPositionPolicy::UInt32 begin
    ImGuiPopupPositionPolicy_Default = 0
    ImGuiPopupPositionPolicy_ComboBox = 1
    ImGuiPopupPositionPolicy_Tooltip = 2
end

@cenum ImGuiDataTypePrivate_::UInt32 begin
    ImGuiDataType_String = 11
    ImGuiDataType_Pointer = 12
    ImGuiDataType_ID = 13
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
end

@cenum ImGuiNextItemDataFlags_::UInt32 begin
    ImGuiNextItemDataFlags_None = 0
    ImGuiNextItemDataFlags_HasWidth = 1
    ImGuiNextItemDataFlags_HasOpen = 2
end

@cenum ImGuiColumnsFlags_::UInt32 begin
    ImGuiColumnsFlags_None = 0
    ImGuiColumnsFlags_NoBorder = 1
    ImGuiColumnsFlags_NoResize = 2
    ImGuiColumnsFlags_NoPreserveWidths = 4
    ImGuiColumnsFlags_NoForceWithinWindow = 8
    ImGuiColumnsFlags_GrowParentContentsSize = 16
end

@cenum ImGuiTabBarFlagsPrivate_::UInt32 begin
    ImGuiTabBarFlags_DockNode = 1048576
    ImGuiTabBarFlags_IsFocused = 2097152
    ImGuiTabBarFlags_SaveSettings = 4194304
end

@cenum ImGuiTabItemFlagsPrivate_::UInt32 begin
    ImGuiTabItemFlags_NoCloseButton = 1048576
    ImGuiTabItemFlags_Button = 2097152
end

