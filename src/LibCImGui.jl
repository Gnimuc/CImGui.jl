module LibCImGui

using CImGui_jll
export CImGui_jll

using CEnum

const ImGuiID = Cuint

const ImS8 = Int8

const ImGuiTableColumnIdx = ImS8

const ImU8 = Cuchar

struct ImGuiTableColumnSettings
    data::NTuple{12, UInt8}
end

function Base.getproperty(x::Ptr{ImGuiTableColumnSettings}, f::Symbol)
    f === :WidthOrWeight && return Ptr{Cfloat}(x + 0)
    f === :UserID && return Ptr{ImGuiID}(x + 4)
    f === :Index && return Ptr{ImGuiTableColumnIdx}(x + 8)
    f === :DisplayOrder && return Ptr{ImGuiTableColumnIdx}(x + 9)
    f === :SortOrder && return Ptr{ImGuiTableColumnIdx}(x + 10)
    f === :SortDirection && return Ptr{ImU8}(x + 11)
    f === :IsEnabled && return Ptr{ImU8}(x + 11)
    f === :IsStretch && return Ptr{ImU8}(x + 11)
    return getfield(x, f)
end

function Base.getproperty(x::ImGuiTableColumnSettings, f::Symbol)
    r = Ref{ImGuiTableColumnSettings}(x)
    ptr = Base.unsafe_convert(Ptr{ImGuiTableColumnSettings}, r)
    GC.@preserve r unsafe_load(getproperty(ptr, f))
end

function Base.setproperty!(x::Ptr{ImGuiTableColumnSettings}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const ImU32 = Cuint

struct ImGuiTableCellData
    BgColor::ImU32
    Column::ImGuiTableColumnIdx
end

const ImGuiViewportFlags = Cint

struct ImVec2
    x::Cfloat
    y::Cfloat
end

struct ImGuiViewport
    Flags::ImGuiViewportFlags
    Pos::ImVec2
    Size::ImVec2
    WorkPos::ImVec2
    WorkSize::ImVec2
end

struct ImVec4
    x::Cfloat
    y::Cfloat
    z::Cfloat
    w::Cfloat
end

const ImTextureID = Ptr{Cvoid}

# C code:
# typedef void ( * ImDrawCallback ) ( const ImDrawList * parent_list , const ImDrawCmd * cmd )
const ImDrawCallback = Ptr{Cvoid}

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

function Base.getproperty(x::ImDrawCmd, f::Symbol)
    r = Ref{ImDrawCmd}(x)
    ptr = Base.unsafe_convert(Ptr{ImDrawCmd}, r)
    GC.@preserve r unsafe_load(getproperty(ptr, f))
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

struct ImDrawCmdHeader
    ClipRect::ImVec4
    TextureId::ImTextureID
    VtxOffset::Cuint
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

struct ImDrawList
    CmdBuffer::ImVector_ImDrawCmd
    IdxBuffer::ImVector_ImDrawIdx
    VtxBuffer::ImVector_ImDrawVert
    Flags::ImDrawListFlags
    _VtxCurrentIdx::Cuint
    # _Data::Ptr{ImDrawListSharedData}
    _Data::Ptr{Cvoid}
    _OwnerName::Ptr{Cchar}
    _VtxWritePtr::Ptr{ImDrawVert}
    _IdxWritePtr::Ptr{ImDrawIdx}
    _ClipRectStack::ImVector_ImVec4
    _TextureIdStack::ImVector_ImTextureID
    _Path::ImVector_ImVec2
    _CmdHeader::ImDrawCmdHeader
    _Splitter::ImDrawListSplitter
    _FringeScale::Cfloat
end

function Base.getproperty(x::Ptr{ImDrawList}, f::Symbol)
    f === :CmdBuffer && return Ptr{ImVector_ImDrawCmd}(x + 0)
    f === :IdxBuffer && return Ptr{ImVector_ImDrawIdx}(x + 16)
    f === :VtxBuffer && return Ptr{ImVector_ImDrawVert}(x + 32)
    f === :Flags && return Ptr{ImDrawListFlags}(x + 48)
    f === :_VtxCurrentIdx && return Ptr{Cuint}(x + 52)
    f === :_Data && return Ptr{Ptr{ImDrawListSharedData}}(x + 56)
    f === :_OwnerName && return Ptr{Ptr{Cchar}}(x + 64)
    f === :_VtxWritePtr && return Ptr{Ptr{ImDrawVert}}(x + 72)
    f === :_IdxWritePtr && return Ptr{Ptr{ImDrawIdx}}(x + 80)
    f === :_ClipRectStack && return Ptr{ImVector_ImVec4}(x + 88)
    f === :_TextureIdStack && return Ptr{ImVector_ImTextureID}(x + 104)
    f === :_Path && return Ptr{ImVector_ImVec2}(x + 120)
    f === :_CmdHeader && return Ptr{ImDrawCmdHeader}(x + 136)
    f === :_Splitter && return Ptr{ImDrawListSplitter}(x + 168)
    f === :_FringeScale && return Ptr{Cfloat}(x + 192)
    return getfield(x, f)
end

function Base.getproperty(x::ImDrawList, f::Symbol)
    r = Ref{ImDrawList}(x)
    ptr = Base.unsafe_convert(Ptr{ImDrawList}, r)
    GC.@preserve r unsafe_load(getproperty(ptr, f))
end

function Base.setproperty!(x::Ptr{ImDrawList}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct ImDrawData
    Valid::Bool
    CmdListsCount::Cint
    TotalIdxCount::Cint
    TotalVtxCount::Cint
    CmdLists::Ptr{Ptr{ImDrawList}}
    DisplayPos::ImVec2
    DisplaySize::ImVec2
    FramebufferScale::ImVec2
end

function Base.getproperty(x::Ptr{ImDrawData}, f::Symbol)
    f === :Valid && return Ptr{Bool}(x + 0)
    f === :CmdListsCount && return Ptr{Cint}(x + 4)
    f === :TotalIdxCount && return Ptr{Cint}(x + 8)
    f === :TotalVtxCount && return Ptr{Cint}(x + 12)
    f === :CmdLists && return Ptr{Ptr{Ptr{ImDrawList}}}(x + 16)
    f === :DisplayPos && return Ptr{ImVec2}(x + 24)
    f === :DisplaySize && return Ptr{ImVec2}(x + 32)
    f === :FramebufferScale && return Ptr{ImVec2}(x + 40)
    return getfield(x, f)
end

function Base.getproperty(x::ImDrawData, f::Symbol)
    r = Ref{ImDrawData}(x)
    ptr = Base.unsafe_convert(Ptr{ImDrawData}, r)
    GC.@preserve r unsafe_load(getproperty(ptr, f))
end

function Base.setproperty!(x::Ptr{ImDrawData}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct ImVector_ImDrawListPtr
    Size::Cint
    Capacity::Cint
    Data::Ptr{Ptr{ImDrawList}}
end

struct ImDrawDataBuilder
    Layers::NTuple{2, ImVector_ImDrawListPtr}
end

struct ImGuiViewportP
    _ImGuiViewport::ImGuiViewport
    DrawListsLastFrame::NTuple{2, Cint}
    DrawLists::NTuple{2, Ptr{ImDrawList}}
    DrawDataP::ImDrawData
    DrawDataBuilder::ImDrawDataBuilder
    WorkOffsetMin::ImVec2
    WorkOffsetMax::ImVec2
    CurrWorkOffsetMin::ImVec2
    CurrWorkOffsetMax::ImVec2
end

struct ImGuiPtrOrIndex
    Ptr::Ptr{Cvoid}
    Index::Cint
end

struct ImGuiShrinkWidthItem
    Index::Cint
    Width::Cfloat
end

struct ImGuiDataTypeTempStorage
    Data::NTuple{8, ImU8}
end

struct ImVec2ih
    x::Cshort
    y::Cshort
end

struct ImVec1
    x::Cfloat
end

struct StbTexteditRow
    x0::Cfloat
    x1::Cfloat
    baseline_y_delta::Cfloat
    ymin::Cfloat
    ymax::Cfloat
    num_chars::Cint
end

struct StbUndoRecord
    where::Cint
    insert_length::Cint
    delete_length::Cint
    char_storage::Cint
end

const ImWchar16 = Cushort

const ImWchar = ImWchar16

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

struct ImVector_ImGuiWindowPtr
    Size::Cint
    Capacity::Cint
    # Data::Ptr{Ptr{ImGuiWindow}}
    Data::Ptr{Ptr{Cvoid}}
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
    GC.@preserve r unsafe_load(getproperty(ptr, f))
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

const ImGuiItemFlags = Cint

struct ImVector_float
    Size::Cint
    Capacity::Cint
    Data::Ptr{Cfloat}
end

struct ImGuiStackSizes
    SizeOfIDStack::Cshort
    SizeOfColorStack::Cshort
    SizeOfStyleVarStack::Cshort
    SizeOfFontStack::Cshort
    SizeOfFocusScopeStack::Cshort
    SizeOfGroupStack::Cshort
    SizeOfBeginPopupStack::Cshort
end

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
    CurrentColumns::Ptr{ImGuiOldColumns}
    CurrentTableIdx::Cint
    LayoutType::ImGuiLayoutType
    ParentLayoutType::ImGuiLayoutType
    FocusCounterRegular::Cint
    FocusCounterTabStop::Cint
    ItemFlags::ImGuiItemFlags
    ItemWidth::Cfloat
    TextWrapPos::Cfloat
    ItemWidthStack::ImVector_float
    TextWrapPosStack::ImVector_float
    StackSizesOnBegin::ImGuiStackSizes
end

const ImGuiWindowFlags = Cint

const ImGuiDir = Cint

const ImGuiCond = Cint

struct ImVector_ImGuiID
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiID}
end

struct ImVector_ImGuiOldColumns
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiOldColumns}
end

struct ImGuiWindow
    data::NTuple{1000, UInt8}
end

function Base.getproperty(x::Ptr{ImGuiWindow}, f::Symbol)
    f === :Name && return Ptr{Ptr{Cchar}}(x + 0)
    f === :ID && return Ptr{ImGuiID}(x + 8)
    f === :Flags && return Ptr{ImGuiWindowFlags}(x + 12)
    f === :Pos && return Ptr{ImVec2}(x + 16)
    f === :Size && return Ptr{ImVec2}(x + 24)
    f === :SizeFull && return Ptr{ImVec2}(x + 32)
    f === :ContentSize && return Ptr{ImVec2}(x + 40)
    f === :ContentSizeIdeal && return Ptr{ImVec2}(x + 48)
    f === :ContentSizeExplicit && return Ptr{ImVec2}(x + 56)
    f === :WindowPadding && return Ptr{ImVec2}(x + 64)
    f === :WindowRounding && return Ptr{Cfloat}(x + 72)
    f === :WindowBorderSize && return Ptr{Cfloat}(x + 76)
    f === :NameBufLen && return Ptr{Cint}(x + 80)
    f === :MoveId && return Ptr{ImGuiID}(x + 84)
    f === :ChildId && return Ptr{ImGuiID}(x + 88)
    f === :Scroll && return Ptr{ImVec2}(x + 92)
    f === :ScrollMax && return Ptr{ImVec2}(x + 100)
    f === :ScrollTarget && return Ptr{ImVec2}(x + 108)
    f === :ScrollTargetCenterRatio && return Ptr{ImVec2}(x + 116)
    f === :ScrollTargetEdgeSnapDist && return Ptr{ImVec2}(x + 124)
    f === :ScrollbarSizes && return Ptr{ImVec2}(x + 132)
    f === :ScrollbarX && return Ptr{Bool}(x + 140)
    f === :ScrollbarY && return Ptr{Bool}(x + 141)
    f === :Active && return Ptr{Bool}(x + 142)
    f === :WasActive && return Ptr{Bool}(x + 143)
    f === :WriteAccessed && return Ptr{Bool}(x + 144)
    f === :Collapsed && return Ptr{Bool}(x + 145)
    f === :WantCollapseToggle && return Ptr{Bool}(x + 146)
    f === :SkipItems && return Ptr{Bool}(x + 147)
    f === :Appearing && return Ptr{Bool}(x + 148)
    f === :Hidden && return Ptr{Bool}(x + 149)
    f === :IsFallbackWindow && return Ptr{Bool}(x + 150)
    f === :HasCloseButton && return Ptr{Bool}(x + 151)
    f === :ResizeBorderHeld && return Ptr{Int8}(x + 152)
    f === :BeginCount && return Ptr{Cshort}(x + 154)
    f === :BeginOrderWithinParent && return Ptr{Cshort}(x + 156)
    f === :BeginOrderWithinContext && return Ptr{Cshort}(x + 158)
    f === :PopupId && return Ptr{ImGuiID}(x + 160)
    f === :AutoFitFramesX && return Ptr{ImS8}(x + 164)
    f === :AutoFitFramesY && return Ptr{ImS8}(x + 165)
    f === :AutoFitChildAxises && return Ptr{ImS8}(x + 166)
    f === :AutoFitOnlyGrows && return Ptr{Bool}(x + 167)
    f === :AutoPosLastDirection && return Ptr{ImGuiDir}(x + 168)
    f === :HiddenFramesCanSkipItems && return Ptr{ImS8}(x + 172)
    f === :HiddenFramesCannotSkipItems && return Ptr{ImS8}(x + 173)
    f === :HiddenFramesForRenderOnly && return Ptr{ImS8}(x + 174)
    f === :SetWindowPosAllowFlags && return Ptr{ImGuiCond}(x + 175)
    f === :SetWindowSizeAllowFlags && return Ptr{ImGuiCond}(x + 176)
    f === :SetWindowCollapsedAllowFlags && return Ptr{ImGuiCond}(x + 177)
    f === :SetWindowPosVal && return Ptr{ImVec2}(x + 180)
    f === :SetWindowPosPivot && return Ptr{ImVec2}(x + 188)
    f === :IDStack && return Ptr{ImVector_ImGuiID}(x + 200)
    f === :DC && return Ptr{ImGuiWindowTempData}(x + 216)
    f === :OuterRectClipped && return Ptr{ImRect}(x + 520)
    f === :InnerRect && return Ptr{ImRect}(x + 536)
    f === :InnerClipRect && return Ptr{ImRect}(x + 552)
    f === :WorkRect && return Ptr{ImRect}(x + 568)
    f === :ParentWorkRect && return Ptr{ImRect}(x + 584)
    f === :ClipRect && return Ptr{ImRect}(x + 600)
    f === :ContentRegionRect && return Ptr{ImRect}(x + 616)
    f === :HitTestHoleSize && return Ptr{ImVec2ih}(x + 632)
    f === :HitTestHoleOffset && return Ptr{ImVec2ih}(x + 636)
    f === :LastFrameActive && return Ptr{Cint}(x + 640)
    f === :LastTimeActive && return Ptr{Cfloat}(x + 644)
    f === :ItemWidthDefault && return Ptr{Cfloat}(x + 648)
    f === :StateStorage && return Ptr{ImGuiStorage}(x + 656)
    f === :ColumnsStorage && return Ptr{ImVector_ImGuiOldColumns}(x + 672)
    f === :FontWindowScale && return Ptr{Cfloat}(x + 688)
    f === :SettingsOffset && return Ptr{Cint}(x + 692)
    f === :DrawList && return Ptr{Ptr{ImDrawList}}(x + 696)
    f === :DrawListInst && return Ptr{ImDrawList}(x + 704)
    f === :ParentWindow && return Ptr{Ptr{ImGuiWindow}}(x + 904)
    f === :RootWindow && return Ptr{Ptr{ImGuiWindow}}(x + 912)
    f === :RootWindowForTitleBarHighlight && return Ptr{Ptr{ImGuiWindow}}(x + 920)
    f === :RootWindowForNav && return Ptr{Ptr{ImGuiWindow}}(x + 928)
    f === :NavLastChildNavWindow && return Ptr{Ptr{ImGuiWindow}}(x + 936)
    f === :NavLastIds && return Ptr{NTuple{2, ImGuiID}}(x + 944)
    f === :NavRectRel && return Ptr{NTuple{2, ImRect}}(x + 952)
    f === :MemoryDrawListIdxCapacity && return Ptr{Cint}(x + 984)
    f === :MemoryDrawListVtxCapacity && return Ptr{Cint}(x + 988)
    f === :MemoryCompacted && return Ptr{Bool}(x + 992)
    return getfield(x, f)
end

function Base.getproperty(x::ImGuiWindow, f::Symbol)
    r = Ref{ImGuiWindow}(x)
    ptr = Base.unsafe_convert(Ptr{ImGuiWindow}, r)
    GC.@preserve r unsafe_load(getproperty(ptr, f))
end

function Base.setproperty!(x::Ptr{ImGuiWindow}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

mutable struct ImGuiTableColumnsSettings end

const ImGuiTableFlags = Cint

struct ImGuiTableSettings
    ID::ImGuiID
    SaveFlags::ImGuiTableFlags
    RefScale::Cfloat
    ColumnsCount::ImGuiTableColumnIdx
    ColumnsCountMax::ImGuiTableColumnIdx
    WantApply::Bool
end

const ImGuiTableColumnFlags = Cint

const ImS16 = Cshort

const ImGuiTableDrawChannelIdx = ImU8

struct ImGuiTableColumn
    data::NTuple{104, UInt8}
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
    f === :IndexWithinEnabledSet && return Ptr{ImGuiTableColumnIdx}(x + 83)
    f === :PrevEnabledColumn && return Ptr{ImGuiTableColumnIdx}(x + 84)
    f === :NextEnabledColumn && return Ptr{ImGuiTableColumnIdx}(x + 85)
    f === :SortOrder && return Ptr{ImGuiTableColumnIdx}(x + 86)
    f === :DrawChannelCurrent && return Ptr{ImGuiTableDrawChannelIdx}(x + 87)
    f === :DrawChannelFrozen && return Ptr{ImGuiTableDrawChannelIdx}(x + 88)
    f === :DrawChannelUnfrozen && return Ptr{ImGuiTableDrawChannelIdx}(x + 89)
    f === :IsEnabled && return Ptr{Bool}(x + 90)
    f === :IsEnabledNextFrame && return Ptr{Bool}(x + 91)
    f === :IsVisibleX && return Ptr{Bool}(x + 92)
    f === :IsVisibleY && return Ptr{Bool}(x + 93)
    f === :IsRequestOutput && return Ptr{Bool}(x + 94)
    f === :IsSkipItems && return Ptr{Bool}(x + 95)
    f === :IsPreserveWidthAuto && return Ptr{Bool}(x + 96)
    f === :NavLayerCurrent && return Ptr{ImS8}(x + 97)
    f === :AutoFitQueue && return Ptr{ImU8}(x + 98)
    f === :CannotSkipItemsQueue && return Ptr{ImU8}(x + 99)
    f === :SortDirection && return Ptr{ImU8}(x + 100)
    f === :SortDirectionsAvailCount && return Ptr{ImU8}(x + 100)
    f === :SortDirectionsAvailMask && return Ptr{ImU8}(x + 100)
    f === :SortDirectionsAvailList && return Ptr{ImU8}(x + 101)
    return getfield(x, f)
end

function Base.getproperty(x::ImGuiTableColumn, f::Symbol)
    r = Ref{ImGuiTableColumn}(x)
    ptr = Base.unsafe_convert(Ptr{ImGuiTableColumn}, r)
    GC.@preserve r unsafe_load(getproperty(ptr, f))
end

function Base.setproperty!(x::Ptr{ImGuiTableColumn}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct ImSpan_ImGuiTableColumn
    Data::Ptr{ImGuiTableColumn}
    DataEnd::Ptr{ImGuiTableColumn}
end

struct ImSpan_ImGuiTableColumnIdx
    Data::Ptr{ImGuiTableColumnIdx}
    DataEnd::Ptr{ImGuiTableColumnIdx}
end

struct ImSpan_ImGuiTableCellData
    Data::Ptr{ImGuiTableCellData}
    DataEnd::Ptr{ImGuiTableCellData}
end

const ImU64 = UInt64

const ImGuiTableRowFlags = Cint

struct ImVector_char
    Size::Cint
    Capacity::Cint
    Data::Ptr{Cchar}
end

struct ImGuiTextBuffer
    Buf::ImVector_char
end

const ImGuiSortDirection = Cint

struct ImGuiTableColumnSortSpecs
    data::NTuple{12, UInt8}
end

function Base.getproperty(x::Ptr{ImGuiTableColumnSortSpecs}, f::Symbol)
    f === :ColumnUserID && return Ptr{ImGuiID}(x + 0)
    f === :ColumnIndex && return Ptr{ImS16}(x + 4)
    f === :SortOrder && return Ptr{ImS16}(x + 6)
    f === :SortDirection && return Ptr{ImGuiSortDirection}(x + 8)
    return getfield(x, f)
end

function Base.getproperty(x::ImGuiTableColumnSortSpecs, f::Symbol)
    r = Ref{ImGuiTableColumnSortSpecs}(x)
    ptr = Base.unsafe_convert(Ptr{ImGuiTableColumnSortSpecs}, r)
    GC.@preserve r unsafe_load(getproperty(ptr, f))
end

function Base.setproperty!(x::Ptr{ImGuiTableColumnSortSpecs}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
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
    data::NTuple{600, UInt8}
end

function Base.getproperty(x::Ptr{ImGuiTable}, f::Symbol)
    f === :ID && return Ptr{ImGuiID}(x + 0)
    f === :Flags && return Ptr{ImGuiTableFlags}(x + 4)
    f === :RawData && return Ptr{Ptr{Cvoid}}(x + 8)
    f === :Columns && return Ptr{ImSpan_ImGuiTableColumn}(x + 16)
    f === :DisplayOrderToIndex && return Ptr{ImSpan_ImGuiTableColumnIdx}(x + 32)
    f === :RowCellData && return Ptr{ImSpan_ImGuiTableCellData}(x + 48)
    f === :EnabledMaskByDisplayOrder && return Ptr{ImU64}(x + 64)
    f === :EnabledMaskByIndex && return Ptr{ImU64}(x + 72)
    f === :VisibleMaskByIndex && return Ptr{ImU64}(x + 80)
    f === :RequestOutputMaskByIndex && return Ptr{ImU64}(x + 88)
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
    f === :RowTextBaseline && return Ptr{Cfloat}(x + 136)
    f === :RowIndentOffsetX && return Ptr{Cfloat}(x + 140)
    f === :RowFlags && return Ptr{ImGuiTableRowFlags}(x + 144)
    f === :LastRowFlags && return Ptr{ImGuiTableRowFlags}(x + 146)
    f === :RowBgColorCounter && return Ptr{Cint}(x + 148)
    f === :RowBgColor && return Ptr{NTuple{2, ImU32}}(x + 152)
    f === :BorderColorStrong && return Ptr{ImU32}(x + 160)
    f === :BorderColorLight && return Ptr{ImU32}(x + 164)
    f === :BorderX1 && return Ptr{Cfloat}(x + 168)
    f === :BorderX2 && return Ptr{Cfloat}(x + 172)
    f === :HostIndentX && return Ptr{Cfloat}(x + 176)
    f === :MinColumnWidth && return Ptr{Cfloat}(x + 180)
    f === :OuterPaddingX && return Ptr{Cfloat}(x + 184)
    f === :CellPaddingX && return Ptr{Cfloat}(x + 188)
    f === :CellPaddingY && return Ptr{Cfloat}(x + 192)
    f === :CellSpacingX1 && return Ptr{Cfloat}(x + 196)
    f === :CellSpacingX2 && return Ptr{Cfloat}(x + 200)
    f === :LastOuterHeight && return Ptr{Cfloat}(x + 204)
    f === :LastFirstRowHeight && return Ptr{Cfloat}(x + 208)
    f === :InnerWidth && return Ptr{Cfloat}(x + 212)
    f === :ColumnsGivenWidth && return Ptr{Cfloat}(x + 216)
    f === :ColumnsAutoFitWidth && return Ptr{Cfloat}(x + 220)
    f === :ResizedColumnNextWidth && return Ptr{Cfloat}(x + 224)
    f === :ResizeLockMinContentsX2 && return Ptr{Cfloat}(x + 228)
    f === :RefScale && return Ptr{Cfloat}(x + 232)
    f === :OuterRect && return Ptr{ImRect}(x + 236)
    f === :InnerRect && return Ptr{ImRect}(x + 252)
    f === :WorkRect && return Ptr{ImRect}(x + 268)
    f === :InnerClipRect && return Ptr{ImRect}(x + 284)
    f === :BgClipRect && return Ptr{ImRect}(x + 300)
    f === :Bg0ClipRectForDrawCmd && return Ptr{ImRect}(x + 316)
    f === :Bg2ClipRectForDrawCmd && return Ptr{ImRect}(x + 332)
    f === :HostClipRect && return Ptr{ImRect}(x + 348)
    f === :HostBackupWorkRect && return Ptr{ImRect}(x + 364)
    f === :HostBackupParentWorkRect && return Ptr{ImRect}(x + 380)
    f === :HostBackupInnerClipRect && return Ptr{ImRect}(x + 396)
    f === :HostBackupPrevLineSize && return Ptr{ImVec2}(x + 412)
    f === :HostBackupCurrLineSize && return Ptr{ImVec2}(x + 420)
    f === :HostBackupCursorMaxPos && return Ptr{ImVec2}(x + 428)
    f === :UserOuterSize && return Ptr{ImVec2}(x + 436)
    f === :HostBackupColumnsOffset && return Ptr{ImVec1}(x + 444)
    f === :HostBackupItemWidth && return Ptr{Cfloat}(x + 448)
    f === :HostBackupItemWidthStackSize && return Ptr{Cint}(x + 452)
    f === :OuterWindow && return Ptr{Ptr{ImGuiWindow}}(x + 456)
    f === :InnerWindow && return Ptr{Ptr{ImGuiWindow}}(x + 464)
    f === :ColumnsNames && return Ptr{ImGuiTextBuffer}(x + 472)
    f === :DrawSplitter && return Ptr{ImDrawListSplitter}(x + 488)
    f === :SortSpecsSingle && return Ptr{ImGuiTableColumnSortSpecs}(x + 512)
    f === :SortSpecsMulti && return Ptr{ImVector_ImGuiTableColumnSortSpecs}(x + 528)
    f === :SortSpecs && return Ptr{ImGuiTableSortSpecs}(x + 544)
    f === :SortSpecsCount && return Ptr{ImGuiTableColumnIdx}(x + 560)
    f === :ColumnsEnabledCount && return Ptr{ImGuiTableColumnIdx}(x + 561)
    f === :ColumnsEnabledFixedCount && return Ptr{ImGuiTableColumnIdx}(x + 562)
    f === :DeclColumnsCount && return Ptr{ImGuiTableColumnIdx}(x + 563)
    f === :HoveredColumnBody && return Ptr{ImGuiTableColumnIdx}(x + 564)
    f === :HoveredColumnBorder && return Ptr{ImGuiTableColumnIdx}(x + 565)
    f === :AutoFitSingleColumn && return Ptr{ImGuiTableColumnIdx}(x + 566)
    f === :ResizedColumn && return Ptr{ImGuiTableColumnIdx}(x + 567)
    f === :LastResizedColumn && return Ptr{ImGuiTableColumnIdx}(x + 568)
    f === :HeldHeaderColumn && return Ptr{ImGuiTableColumnIdx}(x + 569)
    f === :ReorderColumn && return Ptr{ImGuiTableColumnIdx}(x + 570)
    f === :ReorderColumnDir && return Ptr{ImGuiTableColumnIdx}(x + 571)
    f === :LeftMostEnabledColumn && return Ptr{ImGuiTableColumnIdx}(x + 572)
    f === :RightMostEnabledColumn && return Ptr{ImGuiTableColumnIdx}(x + 573)
    f === :LeftMostStretchedColumn && return Ptr{ImGuiTableColumnIdx}(x + 574)
    f === :RightMostStretchedColumn && return Ptr{ImGuiTableColumnIdx}(x + 575)
    f === :ContextPopupColumn && return Ptr{ImGuiTableColumnIdx}(x + 576)
    f === :FreezeRowsRequest && return Ptr{ImGuiTableColumnIdx}(x + 577)
    f === :FreezeRowsCount && return Ptr{ImGuiTableColumnIdx}(x + 578)
    f === :FreezeColumnsRequest && return Ptr{ImGuiTableColumnIdx}(x + 579)
    f === :FreezeColumnsCount && return Ptr{ImGuiTableColumnIdx}(x + 580)
    f === :RowCellDataCurrent && return Ptr{ImGuiTableColumnIdx}(x + 581)
    f === :DummyDrawChannel && return Ptr{ImGuiTableDrawChannelIdx}(x + 582)
    f === :Bg2DrawChannelCurrent && return Ptr{ImGuiTableDrawChannelIdx}(x + 583)
    f === :Bg2DrawChannelUnfrozen && return Ptr{ImGuiTableDrawChannelIdx}(x + 584)
    f === :IsLayoutLocked && return Ptr{Bool}(x + 585)
    f === :IsInsideRow && return Ptr{Bool}(x + 586)
    f === :IsInitializing && return Ptr{Bool}(x + 587)
    f === :IsSortSpecsDirty && return Ptr{Bool}(x + 588)
    f === :IsUsingHeaders && return Ptr{Bool}(x + 589)
    f === :IsContextPopupOpen && return Ptr{Bool}(x + 590)
    f === :IsSettingsRequestLoad && return Ptr{Bool}(x + 591)
    f === :IsSettingsDirty && return Ptr{Bool}(x + 592)
    f === :IsDefaultDisplayOrder && return Ptr{Bool}(x + 593)
    f === :IsResetAllRequest && return Ptr{Bool}(x + 594)
    f === :IsResetDisplayOrderRequest && return Ptr{Bool}(x + 595)
    f === :IsUnfrozenRows && return Ptr{Bool}(x + 596)
    f === :IsDefaultSizingPolicy && return Ptr{Bool}(x + 597)
    f === :MemoryCompacted && return Ptr{Bool}(x + 598)
    f === :HostSkipItems && return Ptr{Bool}(x + 599)
    return getfield(x, f)
end

function Base.getproperty(x::ImGuiTable, f::Symbol)
    r = Ref{ImGuiTable}(x)
    ptr = Base.unsafe_convert(Ptr{ImGuiTable}, r)
    GC.@preserve r unsafe_load(getproperty(ptr, f))
end

function Base.setproperty!(x::Ptr{ImGuiTable}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

const ImGuiTabItemFlags = Cint

struct ImGuiTabItem
    ID::ImGuiID
    Flags::ImGuiTabItemFlags
    LastFrameVisible::Cint
    LastFrameSelected::Cint
    Offset::Cfloat
    Width::Cfloat
    ContentWidth::Cfloat
    NameOffset::ImS16
    BeginOrder::ImS16
    IndexDuringLayout::ImS16
    WantClose::Bool
end

struct ImVector_ImGuiTabItem
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiTabItem}
end

const ImGuiTabBarFlags = Cint

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
    ReorderRequestTabId::ImGuiID
    ReorderRequestDir::ImS8
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
    GC.@preserve r unsafe_load(getproperty(ptr, f))
end

function Base.setproperty!(x::Ptr{ImGuiStyleMod}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
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

# C code:
# typedef void ( * ImGuiSizeCallback ) ( ImGuiSizeCallbackData * data )
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

struct ImGuiMetricsConfig
    ShowWindowsRects::Bool
    ShowWindowsBeginOrder::Bool
    ShowTablesRects::Bool
    ShowDrawCmdMesh::Bool
    ShowDrawCmdBoundingBoxes::Bool
    ShowWindowsRectsType::Cint
    ShowTablesRectsType::Cint
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

struct ImVector_ImWchar
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImWchar}
end

const ImGuiInputTextFlags = Cint

# C code:
# typedef int ( * ImGuiInputTextCallback ) ( ImGuiInputTextCallbackData * data )
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

struct ImGuiGroupData
    WindowID::ImGuiID
    BackupCursorPos::ImVec2
    BackupCursorMaxPos::ImVec2
    BackupIndent::ImVec1
    BackupGroupOffset::ImVec1
    BackupCurrLineSize::ImVec2
    BackupCurrLineTextBaseOffset::Cfloat
    BackupActiveIdIsAlive::ImGuiID
    BackupActiveIdPreviousFrameIsAlive::Bool
    BackupHoveredIdIsAlive::Bool
    EmitItem::Bool
end

struct ImGuiDataTypeInfo
    Size::Csize_t
    Name::Ptr{Cchar}
    PrintFmt::Ptr{Cchar}
    ScanFmt::Ptr{Cchar}
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

# C code:
# typedef void ( * ImGuiContextHookCallback ) ( ImGuiContext * ctx , ImGuiContextHook * hook )
const ImGuiContextHookCallback = Ptr{Cvoid}

struct ImGuiContextHook
    HookId::ImGuiID
    Type::ImGuiContextHookType
    Owner::ImGuiID
    Callback::ImGuiContextHookCallback
    UserData::Ptr{Cvoid}
end

const ImGuiCol = Cint

struct ImGuiColorMod
    Col::ImGuiCol
    BackupValue::ImVec4
end

struct ImVector_ImU32
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImU32}
end

struct ImBitVector
    Storage::ImVector_ImU32
end

struct ImFontAtlasCustomRect
    Width::Cushort
    Height::Cushort
    X::Cushort
    Y::Cushort
    GlyphID::Cuint
    GlyphAdvanceX::Cfloat
    GlyphOffset::ImVec2
    # Font::Ptr{ImFont}
    Font::Ptr{Cvoid}
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
    CircleTessellationMaxError::Cfloat
    Colors::NTuple{53, ImVec4}
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

function Base.getproperty(x::ImGuiSizeCallbackData, f::Symbol)
    r = Ref{ImGuiSizeCallbackData}(x)
    ptr = Base.unsafe_convert(Ptr{ImGuiSizeCallbackData}, r)
    GC.@preserve r unsafe_load(getproperty(ptr, f))
end

function Base.setproperty!(x::Ptr{ImGuiSizeCallbackData}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

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

struct ImGuiOnceUponAFrame
    RefFrame::Cint
end

struct ImGuiListClipper
    DisplayStart::Cint
    DisplayEnd::Cint
    ItemsCount::Cint
    StepNo::Cint
    ItemsFrozen::Cint
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
    Buf::Ptr{Cchar}
    BufTextLen::Cint
    BufSize::Cint
    BufDirty::Bool
    CursorPos::Cint
    SelectionStart::Cint
    SelectionEnd::Cint
end

const ImGuiConfigFlags = Cint

const ImGuiBackendFlags = Cint

const ImFontAtlasFlags = Cint

struct ImVector_ImFontPtr
    Size::Cint
    Capacity::Cint
    # Data::Ptr{Ptr{ImFont}}
    Data::Ptr{Ptr{Cvoid}}
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
    EllipsisChar::ImWchar
    Name::NTuple{40, Cchar}
    # DstFont::Ptr{ImFont}
    DstFont::Ptr{Cvoid}
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
    f === :EllipsisChar && return Ptr{ImWchar}(x + 84)
    f === :Name && return Ptr{NTuple{40, Cchar}}(x + 86)
    f === :DstFont && return Ptr{Ptr{ImFont}}(x + 128)
    return getfield(x, f)
end

function Base.getproperty(x::ImFontConfig, f::Symbol)
    r = Ref{ImFontConfig}(x)
    ptr = Base.unsafe_convert(Ptr{ImFontConfig}, r)
    GC.@preserve r unsafe_load(getproperty(ptr, f))
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
    f === :TexPixelsUseColors && return Ptr{Bool}(x + 25)
    f === :TexPixelsAlpha8 && return Ptr{Ptr{Cuchar}}(x + 32)
    f === :TexPixelsRGBA32 && return Ptr{Ptr{Cuint}}(x + 40)
    f === :TexWidth && return Ptr{Cint}(x + 48)
    f === :TexHeight && return Ptr{Cint}(x + 52)
    f === :TexUvScale && return Ptr{ImVec2}(x + 56)
    f === :TexUvWhitePixel && return Ptr{ImVec2}(x + 64)
    f === :Fonts && return Ptr{ImVector_ImFontPtr}(x + 72)
    f === :CustomRects && return Ptr{ImVector_ImFontAtlasCustomRect}(x + 88)
    f === :ConfigData && return Ptr{ImVector_ImFontConfig}(x + 104)
    f === :TexUvLines && return Ptr{NTuple{64, ImVec4}}(x + 120)
    f === :FontBuilderIO && return Ptr{Ptr{ImFontBuilderIO}}(x + 1144)
    f === :FontBuilderFlags && return Ptr{Cuint}(x + 1152)
    f === :PackIdMouseCursors && return Ptr{Cint}(x + 1156)
    f === :PackIdLines && return Ptr{Cint}(x + 1160)
    return getfield(x, f)
end

function Base.getproperty(x::ImFontAtlas, f::Symbol)
    r = Ref{ImFontAtlas}(x)
    ptr = Base.unsafe_convert(Ptr{ImFontAtlas}, r)
    GC.@preserve r unsafe_load(getproperty(ptr, f))
end

function Base.setproperty!(x::Ptr{ImFontAtlas}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct ImFontGlyph
    data::NTuple{40, UInt8}
end

function Base.getproperty(x::Ptr{ImFontGlyph}, f::Symbol)
    f === :Colored && return Ptr{Cuint}(x + 0)
    f === :Visible && return Ptr{Cuint}(x + 0)
    f === :Codepoint && return Ptr{Cuint}(x + 0)
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
    GC.@preserve r unsafe_load(getproperty(ptr, f))
end

function Base.setproperty!(x::Ptr{ImFontGlyph}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct ImVector_ImFontGlyph
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImFontGlyph}
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
    ConfigDataCount::Cshort
    FallbackChar::ImWchar
    EllipsisChar::ImWchar
    DirtyLookupTables::Bool
    Scale::Cfloat
    Ascent::Cfloat
    Descent::Cfloat
    MetricsTotalSurface::Cint
    Used4kPagesMap::NTuple{2, ImU8}
end

const ImGuiKeyModFlags = Cint

struct ImGuiIO
    ConfigFlags::ImGuiConfigFlags
    BackendFlags::ImGuiBackendFlags
    DisplaySize::ImVec2
    DeltaTime::Cfloat
    IniSavingRate::Cfloat
    IniFilename::Ptr{Cchar}
    LogFilename::Ptr{Cchar}
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
    ConfigDragClickToInputText::Bool
    ConfigWindowsResizeFromEdges::Bool
    ConfigWindowsMoveFromTitleBarOnly::Bool
    ConfigMemoryCompactTimer::Cfloat
    BackendPlatformName::Ptr{Cchar}
    BackendRendererName::Ptr{Cchar}
    BackendPlatformUserData::Ptr{Cvoid}
    BackendRendererUserData::Ptr{Cvoid}
    BackendLanguageUserData::Ptr{Cvoid}
    GetClipboardTextFn::Ptr{Cvoid}
    SetClipboardTextFn::Ptr{Cvoid}
    ClipboardUserData::Ptr{Cvoid}
    ImeSetInputScreenPosFn::Ptr{Cvoid}
    ImeWindowHandle::Ptr{Cvoid}
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

function Base.getproperty(x::Ptr{ImGuiIO}, f::Symbol)
    f === :ConfigFlags && return Ptr{ImGuiConfigFlags}(x + 0)
    f === :BackendFlags && return Ptr{ImGuiBackendFlags}(x + 4)
    f === :DisplaySize && return Ptr{ImVec2}(x + 8)
    f === :DeltaTime && return Ptr{Cfloat}(x + 16)
    f === :IniSavingRate && return Ptr{Cfloat}(x + 20)
    f === :IniFilename && return Ptr{Ptr{Cchar}}(x + 24)
    f === :LogFilename && return Ptr{Ptr{Cchar}}(x + 32)
    f === :MouseDoubleClickTime && return Ptr{Cfloat}(x + 40)
    f === :MouseDoubleClickMaxDist && return Ptr{Cfloat}(x + 44)
    f === :MouseDragThreshold && return Ptr{Cfloat}(x + 48)
    f === :KeyMap && return Ptr{NTuple{22, Cint}}(x + 52)
    f === :KeyRepeatDelay && return Ptr{Cfloat}(x + 140)
    f === :KeyRepeatRate && return Ptr{Cfloat}(x + 144)
    f === :UserData && return Ptr{Ptr{Cvoid}}(x + 152)
    f === :Fonts && return Ptr{Ptr{ImFontAtlas}}(x + 160)
    f === :FontGlobalScale && return Ptr{Cfloat}(x + 168)
    f === :FontAllowUserScaling && return Ptr{Bool}(x + 172)
    f === :FontDefault && return Ptr{Ptr{ImFont}}(x + 176)
    f === :DisplayFramebufferScale && return Ptr{ImVec2}(x + 184)
    f === :MouseDrawCursor && return Ptr{Bool}(x + 192)
    f === :ConfigMacOSXBehaviors && return Ptr{Bool}(x + 193)
    f === :ConfigInputTextCursorBlink && return Ptr{Bool}(x + 194)
    f === :ConfigDragClickToInputText && return Ptr{Bool}(x + 195)
    f === :ConfigWindowsResizeFromEdges && return Ptr{Bool}(x + 196)
    f === :ConfigWindowsMoveFromTitleBarOnly && return Ptr{Bool}(x + 197)
    f === :ConfigMemoryCompactTimer && return Ptr{Cfloat}(x + 200)
    f === :BackendPlatformName && return Ptr{Ptr{Cchar}}(x + 208)
    f === :BackendRendererName && return Ptr{Ptr{Cchar}}(x + 216)
    f === :BackendPlatformUserData && return Ptr{Ptr{Cvoid}}(x + 224)
    f === :BackendRendererUserData && return Ptr{Ptr{Cvoid}}(x + 232)
    f === :BackendLanguageUserData && return Ptr{Ptr{Cvoid}}(x + 240)
    f === :GetClipboardTextFn && return Ptr{Ptr{Cvoid}}(x + 248)
    f === :SetClipboardTextFn && return Ptr{Ptr{Cvoid}}(x + 256)
    f === :ClipboardUserData && return Ptr{Ptr{Cvoid}}(x + 264)
    f === :ImeSetInputScreenPosFn && return Ptr{Ptr{Cvoid}}(x + 272)
    f === :ImeWindowHandle && return Ptr{Ptr{Cvoid}}(x + 280)
    f === :MousePos && return Ptr{ImVec2}(x + 288)
    f === :MouseDown && return Ptr{NTuple{5, Bool}}(x + 296)
    f === :MouseWheel && return Ptr{Cfloat}(x + 304)
    f === :MouseWheelH && return Ptr{Cfloat}(x + 308)
    f === :KeyCtrl && return Ptr{Bool}(x + 312)
    f === :KeyShift && return Ptr{Bool}(x + 313)
    f === :KeyAlt && return Ptr{Bool}(x + 314)
    f === :KeySuper && return Ptr{Bool}(x + 315)
    f === :KeysDown && return Ptr{NTuple{512, Bool}}(x + 316)
    f === :NavInputs && return Ptr{NTuple{21, Cfloat}}(x + 828)
    f === :WantCaptureMouse && return Ptr{Bool}(x + 912)
    f === :WantCaptureKeyboard && return Ptr{Bool}(x + 913)
    f === :WantTextInput && return Ptr{Bool}(x + 914)
    f === :WantSetMousePos && return Ptr{Bool}(x + 915)
    f === :WantSaveIniSettings && return Ptr{Bool}(x + 916)
    f === :NavActive && return Ptr{Bool}(x + 917)
    f === :NavVisible && return Ptr{Bool}(x + 918)
    f === :Framerate && return Ptr{Cfloat}(x + 920)
    f === :MetricsRenderVertices && return Ptr{Cint}(x + 924)
    f === :MetricsRenderIndices && return Ptr{Cint}(x + 928)
    f === :MetricsRenderWindows && return Ptr{Cint}(x + 932)
    f === :MetricsActiveWindows && return Ptr{Cint}(x + 936)
    f === :MetricsActiveAllocations && return Ptr{Cint}(x + 940)
    f === :MouseDelta && return Ptr{ImVec2}(x + 944)
    f === :KeyMods && return Ptr{ImGuiKeyModFlags}(x + 952)
    f === :MousePosPrev && return Ptr{ImVec2}(x + 956)
    f === :MouseClickedPos && return Ptr{NTuple{5, ImVec2}}(x + 964)
    f === :MouseClickedTime && return Ptr{NTuple{5, Cdouble}}(x + 1008)
    f === :MouseClicked && return Ptr{NTuple{5, Bool}}(x + 1048)
    f === :MouseDoubleClicked && return Ptr{NTuple{5, Bool}}(x + 1053)
    f === :MouseReleased && return Ptr{NTuple{5, Bool}}(x + 1058)
    f === :MouseDownOwned && return Ptr{NTuple{5, Bool}}(x + 1063)
    f === :MouseDownWasDoubleClick && return Ptr{NTuple{5, Bool}}(x + 1068)
    f === :MouseDownDuration && return Ptr{NTuple{5, Cfloat}}(x + 1076)
    f === :MouseDownDurationPrev && return Ptr{NTuple{5, Cfloat}}(x + 1096)
    f === :MouseDragMaxDistanceAbs && return Ptr{NTuple{5, ImVec2}}(x + 1116)
    f === :MouseDragMaxDistanceSqr && return Ptr{NTuple{5, Cfloat}}(x + 1156)
    f === :KeysDownDuration && return Ptr{NTuple{512, Cfloat}}(x + 1176)
    f === :KeysDownDurationPrev && return Ptr{NTuple{512, Cfloat}}(x + 3224)
    f === :NavInputsDownDuration && return Ptr{NTuple{21, Cfloat}}(x + 5272)
    f === :NavInputsDownDurationPrev && return Ptr{NTuple{21, Cfloat}}(x + 5356)
    f === :PenPressure && return Ptr{Cfloat}(x + 5440)
    f === :InputQueueSurrogate && return Ptr{ImWchar16}(x + 5444)
    f === :InputQueueCharacters && return Ptr{ImVector_ImWchar}(x + 5448)
    return getfield(x, f)
end

function Base.getproperty(x::ImGuiIO, f::Symbol)
    r = Ref{ImGuiIO}(x)
    ptr = Base.unsafe_convert(Ptr{ImGuiIO}, r)
    GC.@preserve r unsafe_load(getproperty(ptr, f))
end

function Base.setproperty!(x::Ptr{ImGuiIO}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct ImDrawListSharedData
    TexUvWhitePixel::ImVec2
    Font::Ptr{ImFont}
    FontSize::Cfloat
    CurveTessellationTol::Cfloat
    CircleSegmentMaxError::Cfloat
    ClipRectFullscreen::ImVec4
    InitialFlags::ImDrawListFlags
    ArcFastVtx::NTuple{48, ImVec2}
    ArcFastRadiusCutoff::Cfloat
    CircleSegmentCounts::NTuple{64, ImU8}
    TexUvLines::Ptr{ImVec4}
end

@cenum ImGuiInputSource::UInt32 begin
    ImGuiInputSource_None = 0
    ImGuiInputSource_Mouse = 1
    ImGuiInputSource_Keyboard = 2
    ImGuiInputSource_Gamepad = 3
    ImGuiInputSource_Nav = 4
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

struct ImVector_ImGuiItemFlags
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiItemFlags}
end

struct ImVector_ImGuiGroupData
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiGroupData}
end

struct ImVector_ImGuiPopupData
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiPopupData}
end

struct ImVector_ImGuiViewportPPtr
    Size::Cint
    Capacity::Cint
    Data::Ptr{Ptr{ImGuiViewportP}}
end

const ImGuiNavMoveFlags = Cint

@cenum ImGuiNavForward::UInt32 begin
    ImGuiNavForward_None = 0
    ImGuiNavForward_ForwardQueued = 1
    ImGuiNavForward_ForwardActive = 2
end

const ImGuiMouseCursor = Cint

const ImGuiDragDropFlags = Cint

struct ImVector_unsigned_char
    Size::Cint
    Capacity::Cint
    Data::Ptr{Cuchar}
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
end

struct ImVector_ImGuiPtrOrIndex
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiPtrOrIndex}
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

struct ImVector_ImGuiTableSettings
    Size::Cint
    Capacity::Cint
    Data::Ptr{ImGuiTableSettings}
end

struct ImChunkStream_ImGuiTableSettings
    Buf::ImVector_ImGuiTableSettings
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
    GcCompactAll::Bool
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
    HoveredWindowUnderMovingWindow::Ptr{ImGuiWindow}
    MovingWindow::Ptr{ImGuiWindow}
    WheelingWindow::Ptr{ImGuiWindow}
    WheelingWindowRefMousePos::ImVec2
    WheelingWindowTimer::Cfloat
    HoveredId::ImGuiID
    HoveredIdPreviousFrame::ImGuiID
    HoveredIdAllowOverlap::Bool
    HoveredIdUsingMouseWheel::Bool
    HoveredIdPreviousFrameUsingMouseWheel::Bool
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
    ActiveIdUsingMouseWheel::Bool
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
    ColorStack::ImVector_ImGuiColorMod
    StyleVarStack::ImVector_ImGuiStyleMod
    FontStack::ImVector_ImFontPtr
    FocusScopeStack::ImVector_ImGuiID
    ItemFlagsStack::ImVector_ImGuiItemFlags
    GroupStack::ImVector_ImGuiGroupData
    OpenPopupStack::ImVector_ImGuiPopupData
    BeginPopupStack::ImVector_ImGuiPopupData
    Viewports::ImVector_ImGuiViewportPPtr
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
    TabFocusRequestCurrWindow::Ptr{ImGuiWindow}
    TabFocusRequestNextWindow::Ptr{ImGuiWindow}
    TabFocusRequestCurrCounterRegular::Cint
    TabFocusRequestCurrCounterTabStop::Cint
    TabFocusRequestNextCounterRegular::Cint
    TabFocusRequestNextCounterTabStop::Cint
    TabFocusPressed::Bool
    DimBgRatio::Cfloat
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
    CurrentTable::Ptr{ImGuiTable}
    Tables::ImPool_ImGuiTable
    CurrentTableStack::ImVector_ImGuiPtrOrIndex
    TablesLastTimeActive::ImVector_float
    DrawChannelsTempMergeBuffer::ImVector_ImDrawChannel
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
    TooltipSlowDelay::Cfloat
    ClipboardHandlerData::ImVector_char
    MenusIdSubmittedThisFrame::ImVector_ImGuiID
    PlatformImePos::ImVec2
    PlatformImeLastPos::ImVec2
    PlatformLocaleDecimalPoint::Cchar
    SettingsLoaded::Bool
    SettingsDirtyTimer::Cfloat
    SettingsIniData::ImGuiTextBuffer
    SettingsHandlers::ImVector_ImGuiSettingsHandler
    SettingsWindows::ImChunkStream_ImGuiWindowSettings
    SettingsTables::ImChunkStream_ImGuiTableSettings
    Hooks::ImVector_ImGuiContextHook
    HookIdNext::ImGuiID
    LogEnabled::Bool
    LogType::ImGuiLogType
    LogFile::ImFileHandle
    LogBuffer::ImGuiTextBuffer
    LogNextPrefix::Ptr{Cchar}
    LogNextSuffix::Ptr{Cchar}
    LogLinePosY::Cfloat
    LogLineFirstItem::Bool
    LogDepthRef::Cint
    LogDepthToExpand::Cint
    LogDepthToExpandDefault::Cint
    DebugItemPickerActive::Bool
    DebugItemPickerBreakId::ImGuiID
    DebugMetricsConfig::ImGuiMetricsConfig
    FramerateSecPerFrame::NTuple{120, Cfloat}
    FramerateSecPerFrameIdx::Cint
    FramerateSecPerFrameAccum::Cfloat
    WantCaptureMouseNextFrame::Cint
    WantCaptureKeyboardNextFrame::Cint
    WantTextInputNextFrame::Cint
    TempBuffer::NTuple{3073, Cchar}
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

const ImGuiTableBgTarget = Cint

const ImDrawFlags = Cint

const ImGuiButtonFlags = Cint

const ImGuiComboFlags = Cint

const ImGuiFocusedFlags = Cint

const ImGuiHoveredFlags = Cint

const ImGuiPopupFlags = Cint

const ImGuiSelectableFlags = Cint

const ImGuiSliderFlags = Cint

const ImGuiTreeNodeFlags = Cint

# C code:
# typedef void * ( * ImGuiMemAllocFunc ) ( size_t sz , void * user_data )
const ImGuiMemAllocFunc = Ptr{Cvoid}

# C code:
# typedef void ( * ImGuiMemFreeFunc ) ( void * ptr , void * user_data )
const ImGuiMemFreeFunc = Ptr{Cvoid}

const ImWchar32 = Cuint

const ImU16 = Cushort

const ImS32 = Cint

const ImS64 = Int64

const ImGuiNavHighlightFlags = Cint

const ImGuiNavDirSourceFlags = Cint

const ImGuiSeparatorFlags = Cint

const ImGuiTextFlags = Cint

const ImGuiTooltipFlags = Cint

# C code:
# typedef void ( * ImGuiErrorLogCallback ) ( void * user_data , const char * fmt , ... )
const ImGuiErrorLogCallback = Ptr{Cvoid}

struct ImVector
    Size::Cint
    Capacity::Cint
    Data::Ptr{Cvoid}
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
    ImGuiInputTextFlags_AlwaysOverwrite = 8192
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
    ImGuiTableFlags_SizingMask_ = 57344
end

@cenum ImGuiTableColumnFlags_::UInt32 begin
    ImGuiTableColumnFlags_None = 0
    ImGuiTableColumnFlags_DefaultHide = 1
    ImGuiTableColumnFlags_DefaultSort = 2
    ImGuiTableColumnFlags_WidthStretch = 4
    ImGuiTableColumnFlags_WidthFixed = 8
    ImGuiTableColumnFlags_NoResize = 16
    ImGuiTableColumnFlags_NoReorder = 32
    ImGuiTableColumnFlags_NoHide = 64
    ImGuiTableColumnFlags_NoClip = 128
    ImGuiTableColumnFlags_NoSort = 256
    ImGuiTableColumnFlags_NoSortAscending = 512
    ImGuiTableColumnFlags_NoSortDescending = 1024
    ImGuiTableColumnFlags_NoHeaderWidth = 2048
    ImGuiTableColumnFlags_PreferSortAscending = 4096
    ImGuiTableColumnFlags_PreferSortDescending = 8192
    ImGuiTableColumnFlags_IndentEnable = 16384
    ImGuiTableColumnFlags_IndentDisable = 32768
    ImGuiTableColumnFlags_IsEnabled = 1048576
    ImGuiTableColumnFlags_IsVisible = 2097152
    ImGuiTableColumnFlags_IsSorted = 4194304
    ImGuiTableColumnFlags_IsHovered = 8388608
    ImGuiTableColumnFlags_WidthMask_ = 12
    ImGuiTableColumnFlags_IndentMask_ = 49152
    ImGuiTableColumnFlags_StatusMask_ = 15728640
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

@cenum ImGuiSortDirection_::UInt32 begin
    ImGuiSortDirection_None = 0
    ImGuiSortDirection_Ascending = 1
    ImGuiSortDirection_Descending = 2
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
    ImGuiCol_TableHeaderBg = 42
    ImGuiCol_TableBorderStrong = 43
    ImGuiCol_TableBorderLight = 44
    ImGuiCol_TableRowBg = 45
    ImGuiCol_TableRowBgAlt = 46
    ImGuiCol_TextSelectedBg = 47
    ImGuiCol_DragDropTarget = 48
    ImGuiCol_NavHighlight = 49
    ImGuiCol_NavWindowingHighlight = 50
    ImGuiCol_NavWindowingDimBg = 51
    ImGuiCol_ModalWindowDimBg = 52
    ImGuiCol_COUNT = 53
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
    ImGuiStyleVar_CellPadding = 16
    ImGuiStyleVar_ScrollbarSize = 17
    ImGuiStyleVar_ScrollbarRounding = 18
    ImGuiStyleVar_GrabMinSize = 19
    ImGuiStyleVar_GrabRounding = 20
    ImGuiStyleVar_TabRounding = 21
    ImGuiStyleVar_ButtonTextAlign = 22
    ImGuiStyleVar_SelectableTextAlign = 23
    ImGuiStyleVar_COUNT = 24
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
    ImGuiItemStatusFlags_HoveredWindow = 128
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

@cenum ImGuiOldColumnFlags_::UInt32 begin
    ImGuiOldColumnFlags_None = 0
    ImGuiOldColumnFlags_NoBorder = 1
    ImGuiOldColumnFlags_NoResize = 2
    ImGuiOldColumnFlags_NoPreserveWidths = 4
    ImGuiOldColumnFlags_NoForceWithinWindow = 8
    ImGuiOldColumnFlags_GrowParentContentsSize = 16
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

function ImVec2_ImVec2Nil()
    ccall((:ImVec2_ImVec2Nil, libcimgui), Ptr{ImVec2}, ())
end

function ImVec2_destroy(self)
    ccall((:ImVec2_destroy, libcimgui), Cvoid, (Ptr{ImVec2},), self)
end

function ImVec2_ImVec2Float(_x, _y)
    ccall((:ImVec2_ImVec2Float, libcimgui), Ptr{ImVec2}, (Cfloat, Cfloat), _x, _y)
end

function ImVec4_ImVec4Nil()
    ccall((:ImVec4_ImVec4Nil, libcimgui), Ptr{ImVec4}, ())
end

function ImVec4_destroy(self)
    ccall((:ImVec4_destroy, libcimgui), Cvoid, (Ptr{ImVec4},), self)
end

function ImVec4_ImVec4Float(_x, _y, _z, _w)
    ccall((:ImVec4_ImVec4Float, libcimgui), Ptr{ImVec4}, (Cfloat, Cfloat, Cfloat, Cfloat), _x, _y, _z, _w)
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

function igBeginChildStr(str_id, size, border, flags)
    ccall((:igBeginChildStr, libcimgui), Bool, (Ptr{Cchar}, ImVec2, Bool, ImGuiWindowFlags), str_id, size, border, flags)
end

function igBeginChildID(id, size, border, flags)
    ccall((:igBeginChildID, libcimgui), Bool, (ImGuiID, ImVec2, Bool, ImGuiWindowFlags), id, size, border, flags)
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

function igSetNextWindowBgAlpha(alpha)
    ccall((:igSetNextWindowBgAlpha, libcimgui), Cvoid, (Cfloat,), alpha)
end

function igSetWindowPosVec2(pos, cond)
    ccall((:igSetWindowPosVec2, libcimgui), Cvoid, (ImVec2, ImGuiCond), pos, cond)
end

function igSetWindowSizeVec2(size, cond)
    ccall((:igSetWindowSizeVec2, libcimgui), Cvoid, (ImVec2, ImGuiCond), size, cond)
end

function igSetWindowCollapsedBool(collapsed, cond)
    ccall((:igSetWindowCollapsedBool, libcimgui), Cvoid, (Bool, ImGuiCond), collapsed, cond)
end

function igSetWindowFocusNil()
    ccall((:igSetWindowFocusNil, libcimgui), Cvoid, ())
end

function igSetWindowFontScale(scale)
    ccall((:igSetWindowFontScale, libcimgui), Cvoid, (Cfloat,), scale)
end

function igSetWindowPosStr(name, pos, cond)
    ccall((:igSetWindowPosStr, libcimgui), Cvoid, (Ptr{Cchar}, ImVec2, ImGuiCond), name, pos, cond)
end

function igSetWindowSizeStr(name, size, cond)
    ccall((:igSetWindowSizeStr, libcimgui), Cvoid, (Ptr{Cchar}, ImVec2, ImGuiCond), name, size, cond)
end

function igSetWindowCollapsedStr(name, collapsed, cond)
    ccall((:igSetWindowCollapsedStr, libcimgui), Cvoid, (Ptr{Cchar}, Bool, ImGuiCond), name, collapsed, cond)
end

function igSetWindowFocusStr(name)
    ccall((:igSetWindowFocusStr, libcimgui), Cvoid, (Ptr{Cchar},), name)
end

function igGetContentRegionAvail(pOut)
    ccall((:igGetContentRegionAvail, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetContentRegionMax(pOut)
    ccall((:igGetContentRegionMax, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetWindowContentRegionMin(pOut)
    ccall((:igGetWindowContentRegionMin, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetWindowContentRegionMax(pOut)
    ccall((:igGetWindowContentRegionMax, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetWindowContentRegionWidth()
    ccall((:igGetWindowContentRegionWidth, libcimgui), Cfloat, ())
end

function igGetScrollX()
    ccall((:igGetScrollX, libcimgui), Cfloat, ())
end

function igGetScrollY()
    ccall((:igGetScrollY, libcimgui), Cfloat, ())
end

function igSetScrollXFloat(scroll_x)
    ccall((:igSetScrollXFloat, libcimgui), Cvoid, (Cfloat,), scroll_x)
end

function igSetScrollYFloat(scroll_y)
    ccall((:igSetScrollYFloat, libcimgui), Cvoid, (Cfloat,), scroll_y)
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

function igSetScrollFromPosXFloat(local_x, center_x_ratio)
    ccall((:igSetScrollFromPosXFloat, libcimgui), Cvoid, (Cfloat, Cfloat), local_x, center_x_ratio)
end

function igSetScrollFromPosYFloat(local_y, center_y_ratio)
    ccall((:igSetScrollFromPosYFloat, libcimgui), Cvoid, (Cfloat, Cfloat), local_y, center_y_ratio)
end

function igPushFont(font)
    ccall((:igPushFont, libcimgui), Cvoid, (Ptr{ImFont},), font)
end

function igPopFont()
    ccall((:igPopFont, libcimgui), Cvoid, ())
end

function igPushStyleColorU32(idx, col)
    ccall((:igPushStyleColorU32, libcimgui), Cvoid, (ImGuiCol, ImU32), idx, col)
end

function igPushStyleColorVec4(idx, col)
    ccall((:igPushStyleColorVec4, libcimgui), Cvoid, (ImGuiCol, ImVec4), idx, col)
end

function igPopStyleColor(count)
    ccall((:igPopStyleColor, libcimgui), Cvoid, (Cint,), count)
end

function igPushStyleVarFloat(idx, val)
    ccall((:igPushStyleVarFloat, libcimgui), Cvoid, (ImGuiStyleVar, Cfloat), idx, val)
end

function igPushStyleVarVec2(idx, val)
    ccall((:igPushStyleVarVec2, libcimgui), Cvoid, (ImGuiStyleVar, ImVec2), idx, val)
end

function igPopStyleVar(count)
    ccall((:igPopStyleVar, libcimgui), Cvoid, (Cint,), count)
end

function igPushAllowKeyboardFocus(allow_keyboard_focus)
    ccall((:igPushAllowKeyboardFocus, libcimgui), Cvoid, (Bool,), allow_keyboard_focus)
end

function igPopAllowKeyboardFocus()
    ccall((:igPopAllowKeyboardFocus, libcimgui), Cvoid, ())
end

function igPushButtonRepeat(repeat)
    ccall((:igPushButtonRepeat, libcimgui), Cvoid, (Bool,), repeat)
end

function igPopButtonRepeat()
    ccall((:igPopButtonRepeat, libcimgui), Cvoid, ())
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

function igGetColorU32Col(idx, alpha_mul)
    ccall((:igGetColorU32Col, libcimgui), ImU32, (ImGuiCol, Cfloat), idx, alpha_mul)
end

function igGetColorU32Vec4(col)
    ccall((:igGetColorU32Vec4, libcimgui), ImU32, (ImVec4,), col)
end

function igGetColorU32U32(col)
    ccall((:igGetColorU32U32, libcimgui), ImU32, (ImU32,), col)
end

function igGetStyleColorVec4(idx)
    ccall((:igGetStyleColorVec4, libcimgui), Ptr{ImVec4}, (ImGuiCol,), idx)
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

function igGetCursorScreenPos(pOut)
    ccall((:igGetCursorScreenPos, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igSetCursorScreenPos(pos)
    ccall((:igSetCursorScreenPos, libcimgui), Cvoid, (ImVec2,), pos)
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

function igPushIDStr(str_id)
    ccall((:igPushIDStr, libcimgui), Cvoid, (Ptr{Cchar},), str_id)
end

function igPushIDStrStr(str_id_begin, str_id_end)
    ccall((:igPushIDStrStr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cchar}), str_id_begin, str_id_end)
end

function igPushIDPtr(ptr_id)
    ccall((:igPushIDPtr, libcimgui), Cvoid, (Ptr{Cvoid},), ptr_id)
end

function igPushIDInt(int_id)
    ccall((:igPushIDInt, libcimgui), Cvoid, (Cint,), int_id)
end

function igPopID()
    ccall((:igPopID, libcimgui), Cvoid, ())
end

function igGetIDStr(str_id)
    ccall((:igGetIDStr, libcimgui), ImGuiID, (Ptr{Cchar},), str_id)
end

function igGetIDStrStr(str_id_begin, str_id_end)
    ccall((:igGetIDStrStr, libcimgui), ImGuiID, (Ptr{Cchar}, Ptr{Cchar}), str_id_begin, str_id_end)
end

function igGetIDPtr(ptr_id)
    ccall((:igGetIDPtr, libcimgui), ImGuiID, (Ptr{Cvoid},), ptr_id)
end

function igTextUnformatted(text, text_end)
    ccall((:igTextUnformatted, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cchar}), text, text_end)
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

function igImage(user_texture_id, size, uv0, uv1, tint_col, border_col)
    ccall((:igImage, libcimgui), Cvoid, (ImTextureID, ImVec2, ImVec2, ImVec2, ImVec4, ImVec4), user_texture_id, size, uv0, uv1, tint_col, border_col)
end

function igImageButton(user_texture_id, size, uv0, uv1, frame_padding, bg_col, tint_col)
    ccall((:igImageButton, libcimgui), Bool, (ImTextureID, ImVec2, ImVec2, ImVec2, Cint, ImVec4, ImVec4), user_texture_id, size, uv0, uv1, frame_padding, bg_col, tint_col)
end

function igCheckbox(label, v)
    ccall((:igCheckbox, libcimgui), Bool, (Ptr{Cchar}, Ptr{Bool}), label, v)
end

function igCheckboxFlagsIntPtr(label, flags, flags_value)
    ccall((:igCheckboxFlagsIntPtr, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, Cint), label, flags, flags_value)
end

function igCheckboxFlagsUintPtr(label, flags, flags_value)
    ccall((:igCheckboxFlagsUintPtr, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cuint}, Cuint), label, flags, flags_value)
end

function igRadioButtonBool(label, active)
    ccall((:igRadioButtonBool, libcimgui), Bool, (Ptr{Cchar}, Bool), label, active)
end

function igRadioButtonIntPtr(label, v, v_button)
    ccall((:igRadioButtonIntPtr, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, Cint), label, v, v_button)
end

function igProgressBar(fraction, size_arg, overlay)
    ccall((:igProgressBar, libcimgui), Cvoid, (Cfloat, ImVec2, Ptr{Cchar}), fraction, size_arg, overlay)
end

function igBullet()
    ccall((:igBullet, libcimgui), Cvoid, ())
end

function igBeginCombo(label, preview_value, flags)
    ccall((:igBeginCombo, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cchar}, ImGuiComboFlags), label, preview_value, flags)
end

function igEndCombo()
    ccall((:igEndCombo, libcimgui), Cvoid, ())
end

function igComboStr_arr(label, current_item, items, items_count, popup_max_height_in_items)
    ccall((:igComboStr_arr, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, Ptr{Ptr{Cchar}}, Cint, Cint), label, current_item, items, items_count, popup_max_height_in_items)
end

function igComboStr(label, current_item, items_separated_by_zeros, popup_max_height_in_items)
    ccall((:igComboStr, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, Ptr{Cchar}, Cint), label, current_item, items_separated_by_zeros, popup_max_height_in_items)
end

function igComboFnBoolPtr(label, current_item, items_getter, data, items_count, popup_max_height_in_items)
    ccall((:igComboFnBoolPtr, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, Ptr{Cvoid}, Ptr{Cvoid}, Cint, Cint), label, current_item, items_getter, data, items_count, popup_max_height_in_items)
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

function igTreeNodeStr(label)
    ccall((:igTreeNodeStr, libcimgui), Bool, (Ptr{Cchar},), label)
end

function igTreeNodeExStr(label, flags)
    ccall((:igTreeNodeExStr, libcimgui), Bool, (Ptr{Cchar}, ImGuiTreeNodeFlags), label, flags)
end

function igTreePushStr(str_id)
    ccall((:igTreePushStr, libcimgui), Cvoid, (Ptr{Cchar},), str_id)
end

function igTreePushPtr(ptr_id)
    ccall((:igTreePushPtr, libcimgui), Cvoid, (Ptr{Cvoid},), ptr_id)
end

function igTreePop()
    ccall((:igTreePop, libcimgui), Cvoid, ())
end

function igGetTreeNodeToLabelSpacing()
    ccall((:igGetTreeNodeToLabelSpacing, libcimgui), Cfloat, ())
end

function igCollapsingHeaderTreeNodeFlags(label, flags)
    ccall((:igCollapsingHeaderTreeNodeFlags, libcimgui), Bool, (Ptr{Cchar}, ImGuiTreeNodeFlags), label, flags)
end

function igCollapsingHeaderBoolPtr(label, p_visible, flags)
    ccall((:igCollapsingHeaderBoolPtr, libcimgui), Bool, (Ptr{Cchar}, Ptr{Bool}, ImGuiTreeNodeFlags), label, p_visible, flags)
end

function igSetNextItemOpen(is_open, cond)
    ccall((:igSetNextItemOpen, libcimgui), Cvoid, (Bool, ImGuiCond), is_open, cond)
end

function igSelectableBool(label, selected, flags, size)
    ccall((:igSelectableBool, libcimgui), Bool, (Ptr{Cchar}, Bool, ImGuiSelectableFlags, ImVec2), label, selected, flags, size)
end

function igSelectableBoolPtr(label, p_selected, flags, size)
    ccall((:igSelectableBoolPtr, libcimgui), Bool, (Ptr{Cchar}, Ptr{Bool}, ImGuiSelectableFlags, ImVec2), label, p_selected, flags, size)
end

function igBeginListBox(label, size)
    ccall((:igBeginListBox, libcimgui), Bool, (Ptr{Cchar}, ImVec2), label, size)
end

function igEndListBox()
    ccall((:igEndListBox, libcimgui), Cvoid, ())
end

function igListBoxStr_arr(label, current_item, items, items_count, height_in_items)
    ccall((:igListBoxStr_arr, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, Ptr{Ptr{Cchar}}, Cint, Cint), label, current_item, items, items_count, height_in_items)
end

function igListBoxFnBoolPtr(label, current_item, items_getter, data, items_count, height_in_items)
    ccall((:igListBoxFnBoolPtr, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cint}, Ptr{Cvoid}, Ptr{Cvoid}, Cint, Cint), label, current_item, items_getter, data, items_count, height_in_items)
end

function igPlotLinesFloatPtr(label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride)
    ccall((:igPlotLinesFloatPtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cfloat}, Cint, Cint, Ptr{Cchar}, Cfloat, Cfloat, ImVec2, Cint), label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride)
end

function igPlotLinesFnFloatPtr(label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size)
    ccall((:igPlotLinesFnFloatPtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cvoid}, Ptr{Cvoid}, Cint, Cint, Ptr{Cchar}, Cfloat, Cfloat, ImVec2), label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size)
end

function igPlotHistogramFloatPtr(label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride)
    ccall((:igPlotHistogramFloatPtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cfloat}, Cint, Cint, Ptr{Cchar}, Cfloat, Cfloat, ImVec2, Cint), label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride)
end

function igPlotHistogramFnFloatPtr(label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size)
    ccall((:igPlotHistogramFnFloatPtr, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cvoid}, Ptr{Cvoid}, Cint, Cint, Ptr{Cchar}, Cfloat, Cfloat, ImVec2), label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size)
end

function igValueBool(prefix, b)
    ccall((:igValueBool, libcimgui), Cvoid, (Ptr{Cchar}, Bool), prefix, b)
end

function igValueInt(prefix, v)
    ccall((:igValueInt, libcimgui), Cvoid, (Ptr{Cchar}, Cint), prefix, v)
end

function igValueUint(prefix, v)
    ccall((:igValueUint, libcimgui), Cvoid, (Ptr{Cchar}, Cuint), prefix, v)
end

function igValueFloat(prefix, v, float_format)
    ccall((:igValueFloat, libcimgui), Cvoid, (Ptr{Cchar}, Cfloat, Ptr{Cchar}), prefix, v, float_format)
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

function igMenuItemBool(label, shortcut, selected, enabled)
    ccall((:igMenuItemBool, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cchar}, Bool, Bool), label, shortcut, selected, enabled)
end

function igMenuItemBoolPtr(label, shortcut, p_selected, enabled)
    ccall((:igMenuItemBoolPtr, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cchar}, Ptr{Bool}, Bool), label, shortcut, p_selected, enabled)
end

function igBeginTooltip()
    ccall((:igBeginTooltip, libcimgui), Cvoid, ())
end

function igEndTooltip()
    ccall((:igEndTooltip, libcimgui), Cvoid, ())
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

function igOpenPopup(str_id, popup_flags)
    ccall((:igOpenPopup, libcimgui), Cvoid, (Ptr{Cchar}, ImGuiPopupFlags), str_id, popup_flags)
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

function igIsPopupOpenStr(str_id, flags)
    ccall((:igIsPopupOpenStr, libcimgui), Bool, (Ptr{Cchar}, ImGuiPopupFlags), str_id, flags)
end

function igBeginTable(str_id, column, flags, outer_size, inner_width)
    ccall((:igBeginTable, libcimgui), Bool, (Ptr{Cchar}, Cint, ImGuiTableFlags, ImVec2, Cfloat), str_id, column, flags, outer_size, inner_width)
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

function igTableHeadersRow()
    ccall((:igTableHeadersRow, libcimgui), Cvoid, ())
end

function igTableHeader(label)
    ccall((:igTableHeader, libcimgui), Cvoid, (Ptr{Cchar},), label)
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

function igTableGetColumnNameInt(column_n)
    ccall((:igTableGetColumnNameInt, libcimgui), Ptr{Cchar}, (Cint,), column_n)
end

function igTableGetColumnFlags(column_n)
    ccall((:igTableGetColumnFlags, libcimgui), ImGuiTableColumnFlags, (Cint,), column_n)
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

function igGetItemRectMin(pOut)
    ccall((:igGetItemRectMin, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetItemRectMax(pOut)
    ccall((:igGetItemRectMax, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetItemRectSize(pOut)
    ccall((:igGetItemRectSize, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igSetItemAllowOverlap()
    ccall((:igSetItemAllowOverlap, libcimgui), Cvoid, ())
end

function igGetMainViewport()
    ccall((:igGetMainViewport, libcimgui), Ptr{ImGuiViewport}, ())
end

function igIsRectVisibleNil(size)
    ccall((:igIsRectVisibleNil, libcimgui), Bool, (ImVec2,), size)
end

function igIsRectVisibleVec2(rect_min, rect_max)
    ccall((:igIsRectVisibleVec2, libcimgui), Bool, (ImVec2, ImVec2), rect_min, rect_max)
end

function igGetTime()
    ccall((:igGetTime, libcimgui), Cdouble, ())
end

function igGetFrameCount()
    ccall((:igGetFrameCount, libcimgui), Cint, ())
end

function igGetBackgroundDrawListNil()
    ccall((:igGetBackgroundDrawListNil, libcimgui), Ptr{ImDrawList}, ())
end

function igGetForegroundDrawListNil()
    ccall((:igGetForegroundDrawListNil, libcimgui), Ptr{ImDrawList}, ())
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

function igCalcListClipping(items_count, items_height, out_items_display_start, out_items_display_end)
    ccall((:igCalcListClipping, libcimgui), Cvoid, (Cint, Cfloat, Ptr{Cint}, Ptr{Cint}), items_count, items_height, out_items_display_start, out_items_display_end)
end

function igBeginChildFrame(id, size, flags)
    ccall((:igBeginChildFrame, libcimgui), Bool, (ImGuiID, ImVec2, ImGuiWindowFlags), id, size, flags)
end

function igEndChildFrame()
    ccall((:igEndChildFrame, libcimgui), Cvoid, ())
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

function igGetKeyIndex(imgui_key)
    ccall((:igGetKeyIndex, libcimgui), Cint, (ImGuiKey,), imgui_key)
end

function igIsKeyDown(user_key_index)
    ccall((:igIsKeyDown, libcimgui), Bool, (Cint,), user_key_index)
end

function igIsKeyPressed(user_key_index, repeat)
    ccall((:igIsKeyPressed, libcimgui), Bool, (Cint, Bool), user_key_index, repeat)
end

function igIsKeyReleased(user_key_index)
    ccall((:igIsKeyReleased, libcimgui), Bool, (Cint,), user_key_index)
end

function igGetKeyPressedAmount(key_index, repeat_delay, rate)
    ccall((:igGetKeyPressedAmount, libcimgui), Cint, (Cint, Cfloat, Cfloat), key_index, repeat_delay, rate)
end

function igCaptureKeyboardFromApp(want_capture_keyboard_value)
    ccall((:igCaptureKeyboardFromApp, libcimgui), Cvoid, (Bool,), want_capture_keyboard_value)
end

function igIsMouseDown(button)
    ccall((:igIsMouseDown, libcimgui), Bool, (ImGuiMouseButton,), button)
end

function igIsMouseClicked(button, repeat)
    ccall((:igIsMouseClicked, libcimgui), Bool, (ImGuiMouseButton, Bool), button, repeat)
end

function igIsMouseReleased(button)
    ccall((:igIsMouseReleased, libcimgui), Bool, (ImGuiMouseButton,), button)
end

function igIsMouseDoubleClicked(button)
    ccall((:igIsMouseDoubleClicked, libcimgui), Bool, (ImGuiMouseButton,), button)
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

function igCaptureMouseFromApp(want_capture_mouse_value)
    ccall((:igCaptureMouseFromApp, libcimgui), Cvoid, (Bool,), want_capture_mouse_value)
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

function igDebugCheckVersionAndDataLayout(version_str, sz_io, sz_style, sz_vec2, sz_vec4, sz_drawvert, sz_drawidx)
    ccall((:igDebugCheckVersionAndDataLayout, libcimgui), Bool, (Ptr{Cchar}, Csize_t, Csize_t, Csize_t, Csize_t, Csize_t, Csize_t), version_str, sz_io, sz_style, sz_vec2, sz_vec4, sz_drawvert, sz_drawidx)
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

function ImGuiStyle_ImGuiStyle()
    ccall((:ImGuiStyle_ImGuiStyle, libcimgui), Ptr{ImGuiStyle}, ())
end

function ImGuiStyle_destroy(self)
    ccall((:ImGuiStyle_destroy, libcimgui), Cvoid, (Ptr{ImGuiStyle},), self)
end

function ImGuiStyle_ScaleAllSizes(self, scale_factor)
    ccall((:ImGuiStyle_ScaleAllSizes, libcimgui), Cvoid, (Ptr{ImGuiStyle}, Cfloat), self, scale_factor)
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

function ImGuiIO_ClearInputCharacters(self)
    ccall((:ImGuiIO_ClearInputCharacters, libcimgui), Cvoid, (Ptr{ImGuiIO},), self)
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

function ImGuiTableColumnSortSpecs_ImGuiTableColumnSortSpecs()
    ccall((:ImGuiTableColumnSortSpecs_ImGuiTableColumnSortSpecs, libcimgui), Ptr{ImGuiTableColumnSortSpecs}, ())
end

function ImGuiTableColumnSortSpecs_destroy(self)
    ccall((:ImGuiTableColumnSortSpecs_destroy, libcimgui), Cvoid, (Ptr{ImGuiTableColumnSortSpecs},), self)
end

function ImGuiTableSortSpecs_ImGuiTableSortSpecs()
    ccall((:ImGuiTableSortSpecs_ImGuiTableSortSpecs, libcimgui), Ptr{ImGuiTableSortSpecs}, ())
end

function ImGuiTableSortSpecs_destroy(self)
    ccall((:ImGuiTableSortSpecs_destroy, libcimgui), Cvoid, (Ptr{ImGuiTableSortSpecs},), self)
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

function ImGuiTextRange_ImGuiTextRangeNil()
    ccall((:ImGuiTextRange_ImGuiTextRangeNil, libcimgui), Ptr{ImGuiTextRange}, ())
end

function ImGuiTextRange_destroy(self)
    ccall((:ImGuiTextRange_destroy, libcimgui), Cvoid, (Ptr{ImGuiTextRange},), self)
end

function ImGuiTextRange_ImGuiTextRangeStr(_b, _e)
    ccall((:ImGuiTextRange_ImGuiTextRangeStr, libcimgui), Ptr{ImGuiTextRange}, (Ptr{Cchar}, Ptr{Cchar}), _b, _e)
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

function ImGuiStoragePair_ImGuiStoragePairInt(_key, _val_i)
    ccall((:ImGuiStoragePair_ImGuiStoragePairInt, libcimgui), Ptr{ImGuiStoragePair}, (ImGuiID, Cint), _key, _val_i)
end

function ImGuiStoragePair_destroy(self)
    ccall((:ImGuiStoragePair_destroy, libcimgui), Cvoid, (Ptr{ImGuiStoragePair},), self)
end

function ImGuiStoragePair_ImGuiStoragePairFloat(_key, _val_f)
    ccall((:ImGuiStoragePair_ImGuiStoragePairFloat, libcimgui), Ptr{ImGuiStoragePair}, (ImGuiID, Cfloat), _key, _val_f)
end

function ImGuiStoragePair_ImGuiStoragePairPtr(_key, _val_p)
    ccall((:ImGuiStoragePair_ImGuiStoragePairPtr, libcimgui), Ptr{ImGuiStoragePair}, (ImGuiID, Ptr{Cvoid}), _key, _val_p)
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

function ImGuiStorage_SetAllInt(self, val)
    ccall((:ImGuiStorage_SetAllInt, libcimgui), Cvoid, (Ptr{ImGuiStorage}, Cint), self, val)
end

function ImGuiStorage_BuildSortByKey(self)
    ccall((:ImGuiStorage_BuildSortByKey, libcimgui), Cvoid, (Ptr{ImGuiStorage},), self)
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

function ImColor_ImColorNil()
    ccall((:ImColor_ImColorNil, libcimgui), Ptr{ImColor}, ())
end

function ImColor_destroy(self)
    ccall((:ImColor_destroy, libcimgui), Cvoid, (Ptr{ImColor},), self)
end

function ImColor_ImColorInt(r, g, b, a)
    ccall((:ImColor_ImColorInt, libcimgui), Ptr{ImColor}, (Cint, Cint, Cint, Cint), r, g, b, a)
end

function ImColor_ImColorU32(rgba)
    ccall((:ImColor_ImColorU32, libcimgui), Ptr{ImColor}, (ImU32,), rgba)
end

function ImColor_ImColorFloat(r, g, b, a)
    ccall((:ImColor_ImColorFloat, libcimgui), Ptr{ImColor}, (Cfloat, Cfloat, Cfloat, Cfloat), r, g, b, a)
end

function ImColor_ImColorVec4(col)
    ccall((:ImColor_ImColorVec4, libcimgui), Ptr{ImColor}, (ImVec4,), col)
end

function ImColor_SetHSV(self, h, s, v, a)
    ccall((:ImColor_SetHSV, libcimgui), Cvoid, (Ptr{ImColor}, Cfloat, Cfloat, Cfloat, Cfloat), self, h, s, v, a)
end

function ImColor_HSV(pOut, h, s, v, a)
    ccall((:ImColor_HSV, libcimgui), Cvoid, (Ptr{ImColor}, Cfloat, Cfloat, Cfloat, Cfloat), pOut, h, s, v, a)
end

function ImDrawCmd_ImDrawCmd()
    ccall((:ImDrawCmd_ImDrawCmd, libcimgui), Ptr{ImDrawCmd}, ())
end

function ImDrawCmd_destroy(self)
    ccall((:ImDrawCmd_destroy, libcimgui), Cvoid, (Ptr{ImDrawCmd},), self)
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

function ImDrawList_AddTextVec2(self, pos, col, text_begin, text_end)
    ccall((:ImDrawList_AddTextVec2, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImU32, Ptr{Cchar}, Ptr{Cchar}), self, pos, col, text_begin, text_end)
end

function ImDrawList_AddTextFontPtr(self, font, font_size, pos, col, text_begin, text_end, wrap_width, cpu_fine_clip_rect)
    ccall((:ImDrawList_AddTextFontPtr, libcimgui), Cvoid, (Ptr{ImDrawList}, Ptr{ImFont}, Cfloat, ImVec2, ImU32, Ptr{Cchar}, Ptr{Cchar}, Cfloat, Ptr{ImVec4}), self, font, font_size, pos, col, text_begin, text_end, wrap_width, cpu_fine_clip_rect)
end

function ImDrawList_AddPolyline(self, points, num_points, col, flags, thickness)
    ccall((:ImDrawList_AddPolyline, libcimgui), Cvoid, (Ptr{ImDrawList}, Ptr{ImVec2}, Cint, ImU32, ImDrawFlags, Cfloat), self, points, num_points, col, flags, thickness)
end

function ImDrawList_AddConvexPolyFilled(self, points, num_points, col)
    ccall((:ImDrawList_AddConvexPolyFilled, libcimgui), Cvoid, (Ptr{ImDrawList}, Ptr{ImVec2}, Cint, ImU32), self, points, num_points, col)
end

function ImDrawList_AddBezierCubic(self, p1, p2, p3, p4, col, thickness, num_segments)
    ccall((:ImDrawList_AddBezierCubic, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImVec2, ImVec2, ImU32, Cfloat, Cint), self, p1, p2, p3, p4, col, thickness, num_segments)
end

function ImDrawList_AddBezierQuadratic(self, p1, p2, p3, col, thickness, num_segments)
    ccall((:ImDrawList_AddBezierQuadratic, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImVec2, ImU32, Cfloat, Cint), self, p1, p2, p3, col, thickness, num_segments)
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

function ImDrawList_PathStroke(self, col, flags, thickness)
    ccall((:ImDrawList_PathStroke, libcimgui), Cvoid, (Ptr{ImDrawList}, ImU32, ImDrawFlags, Cfloat), self, col, flags, thickness)
end

function ImDrawList_PathArcTo(self, center, radius, a_min, a_max, num_segments)
    ccall((:ImDrawList_PathArcTo, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, Cfloat, Cfloat, Cfloat, Cint), self, center, radius, a_min, a_max, num_segments)
end

function ImDrawList_PathArcToFast(self, center, radius, a_min_of_12, a_max_of_12)
    ccall((:ImDrawList_PathArcToFast, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, Cfloat, Cint, Cint), self, center, radius, a_min_of_12, a_max_of_12)
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

function ImFontAtlas_AddFontFromMemoryTTF(self, font_data, font_size, size_pixels, font_cfg, glyph_ranges)
    ccall((:ImFontAtlas_AddFontFromMemoryTTF, libcimgui), Ptr{ImFont}, (Ptr{ImFontAtlas}, Ptr{Cvoid}, Cint, Cfloat, Ptr{ImFontConfig}, Ptr{ImWchar}), self, font_data, font_size, size_pixels, font_cfg, glyph_ranges)
end

function ImFontAtlas_AddFontFromMemoryCompressedTTF(self, compressed_font_data, compressed_font_size, size_pixels, font_cfg, glyph_ranges)
    ccall((:ImFontAtlas_AddFontFromMemoryCompressedTTF, libcimgui), Ptr{ImFont}, (Ptr{ImFontAtlas}, Ptr{Cvoid}, Cint, Cfloat, Ptr{ImFontConfig}, Ptr{ImWchar}), self, compressed_font_data, compressed_font_size, size_pixels, font_cfg, glyph_ranges)
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

function ImFont_SetFallbackChar(self, c)
    ccall((:ImFont_SetFallbackChar, libcimgui), Cvoid, (Ptr{ImFont}, ImWchar), self, c)
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

function igImHashData(data, data_size, seed)
    ccall((:igImHashData, libcimgui), ImGuiID, (Ptr{Cvoid}, Csize_t, ImU32), data, data_size, seed)
end

function igImHashStr(data, data_size, seed)
    ccall((:igImHashStr, libcimgui), ImGuiID, (Ptr{Cchar}, Csize_t, ImU32), data, data_size, seed)
end

function igImAlphaBlendColors(col_a, col_b)
    ccall((:igImAlphaBlendColors, libcimgui), ImU32, (ImU32, ImU32), col_a, col_b)
end

function igImIsPowerOfTwoInt(v)
    ccall((:igImIsPowerOfTwoInt, libcimgui), Bool, (Cint,), v)
end

function igImIsPowerOfTwoU64(v)
    ccall((:igImIsPowerOfTwoU64, libcimgui), Bool, (ImU64,), v)
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

function igImStrlenW(str)
    ccall((:igImStrlenW, libcimgui), Cint, (Ptr{ImWchar},), str)
end

function igImStreolRange(str, str_end)
    ccall((:igImStreolRange, libcimgui), Ptr{Cchar}, (Ptr{Cchar}, Ptr{Cchar}), str, str_end)
end

function igImStrbolW(buf_mid_line, buf_begin)
    ccall((:igImStrbolW, libcimgui), Ptr{ImWchar}, (Ptr{ImWchar}, Ptr{ImWchar}), buf_mid_line, buf_begin)
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

function igImParseFormatFindStart(format)
    ccall((:igImParseFormatFindStart, libcimgui), Ptr{Cchar}, (Ptr{Cchar},), format)
end

function igImParseFormatFindEnd(format)
    ccall((:igImParseFormatFindEnd, libcimgui), Ptr{Cchar}, (Ptr{Cchar},), format)
end

function igImParseFormatTrimDecorations(format, buf, buf_size)
    ccall((:igImParseFormatTrimDecorations, libcimgui), Ptr{Cchar}, (Ptr{Cchar}, Ptr{Cchar}, Csize_t), format, buf, buf_size)
end

function igImParseFormatPrecision(format, default_value)
    ccall((:igImParseFormatPrecision, libcimgui), Cint, (Ptr{Cchar}, Cint), format, default_value)
end

function igImCharIsBlankA(c)
    ccall((:igImCharIsBlankA, libcimgui), Bool, (Cchar,), c)
end

function igImCharIsBlankW(c)
    ccall((:igImCharIsBlankW, libcimgui), Bool, (Cuint,), c)
end

function igImTextStrToUtf8(buf, buf_size, in_text, in_text_end)
    ccall((:igImTextStrToUtf8, libcimgui), Cint, (Ptr{Cchar}, Cint, Ptr{ImWchar}, Ptr{ImWchar}), buf, buf_size, in_text, in_text_end)
end

function igImTextCharFromUtf8(out_char, in_text, in_text_end)
    ccall((:igImTextCharFromUtf8, libcimgui), Cint, (Ptr{Cuint}, Ptr{Cchar}, Ptr{Cchar}), out_char, in_text, in_text_end)
end

function igImTextStrFromUtf8(buf, buf_size, in_text, in_text_end, in_remaining)
    ccall((:igImTextStrFromUtf8, libcimgui), Cint, (Ptr{ImWchar}, Cint, Ptr{Cchar}, Ptr{Cchar}, Ptr{Ptr{Cchar}}), buf, buf_size, in_text, in_text_end, in_remaining)
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

function igImPowFloat(x, y)
    ccall((:igImPowFloat, libcimgui), Cfloat, (Cfloat, Cfloat), x, y)
end

function igImPowdouble(x, y)
    ccall((:igImPowdouble, libcimgui), Cdouble, (Cdouble, Cdouble), x, y)
end

function igImLogFloat(x)
    ccall((:igImLogFloat, libcimgui), Cfloat, (Cfloat,), x)
end

function igImLogdouble(x)
    ccall((:igImLogdouble, libcimgui), Cdouble, (Cdouble,), x)
end

function igImAbsFloat(x)
    ccall((:igImAbsFloat, libcimgui), Cfloat, (Cfloat,), x)
end

function igImAbsdouble(x)
    ccall((:igImAbsdouble, libcimgui), Cdouble, (Cdouble,), x)
end

function igImSignFloat(x)
    ccall((:igImSignFloat, libcimgui), Cfloat, (Cfloat,), x)
end

function igImSigndouble(x)
    ccall((:igImSigndouble, libcimgui), Cdouble, (Cdouble,), x)
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

function igImLerpVec2Float(pOut, a, b, t)
    ccall((:igImLerpVec2Float, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2, ImVec2, Cfloat), pOut, a, b, t)
end

function igImLerpVec2Vec2(pOut, a, b, t)
    ccall((:igImLerpVec2Vec2, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2, ImVec2, ImVec2), pOut, a, b, t)
end

function igImLerpVec4(pOut, a, b, t)
    ccall((:igImLerpVec4, libcimgui), Cvoid, (Ptr{ImVec4}, ImVec4, ImVec4, Cfloat), pOut, a, b, t)
end

function igImSaturate(f)
    ccall((:igImSaturate, libcimgui), Cfloat, (Cfloat,), f)
end

function igImLengthSqrVec2(lhs)
    ccall((:igImLengthSqrVec2, libcimgui), Cfloat, (ImVec2,), lhs)
end

function igImLengthSqrVec4(lhs)
    ccall((:igImLengthSqrVec4, libcimgui), Cfloat, (ImVec4,), lhs)
end

function igImInvLength(lhs, fail_value)
    ccall((:igImInvLength, libcimgui), Cfloat, (ImVec2, Cfloat), lhs, fail_value)
end

function igImFloorFloat(f)
    ccall((:igImFloorFloat, libcimgui), Cfloat, (Cfloat,), f)
end

function igImFloorVec2(pOut, v)
    ccall((:igImFloorVec2, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2), pOut, v)
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

function igImMul(pOut, lhs, rhs)
    ccall((:igImMul, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2, ImVec2), pOut, lhs, rhs)
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

function igImGetDirQuadrantFromDelta(dx, dy)
    ccall((:igImGetDirQuadrantFromDelta, libcimgui), ImGuiDir, (Cfloat, Cfloat), dx, dy)
end

function ImVec1_ImVec1Nil()
    ccall((:ImVec1_ImVec1Nil, libcimgui), Ptr{ImVec1}, ())
end

function ImVec1_destroy(self)
    ccall((:ImVec1_destroy, libcimgui), Cvoid, (Ptr{ImVec1},), self)
end

function ImVec1_ImVec1Float(_x)
    ccall((:ImVec1_ImVec1Float, libcimgui), Ptr{ImVec1}, (Cfloat,), _x)
end

function ImVec2ih_ImVec2ihNil()
    ccall((:ImVec2ih_ImVec2ihNil, libcimgui), Ptr{ImVec2ih}, ())
end

function ImVec2ih_destroy(self)
    ccall((:ImVec2ih_destroy, libcimgui), Cvoid, (Ptr{ImVec2ih},), self)
end

function ImVec2ih_ImVec2ihshort(_x, _y)
    ccall((:ImVec2ih_ImVec2ihshort, libcimgui), Ptr{ImVec2ih}, (Cshort, Cshort), _x, _y)
end

function ImVec2ih_ImVec2ihVec2(rhs)
    ccall((:ImVec2ih_ImVec2ihVec2, libcimgui), Ptr{ImVec2ih}, (ImVec2,), rhs)
end

function ImRect_ImRectNil()
    ccall((:ImRect_ImRectNil, libcimgui), Ptr{ImRect}, ())
end

function ImRect_destroy(self)
    ccall((:ImRect_destroy, libcimgui), Cvoid, (Ptr{ImRect},), self)
end

function ImRect_ImRectVec2(min, max)
    ccall((:ImRect_ImRectVec2, libcimgui), Ptr{ImRect}, (ImVec2, ImVec2), min, max)
end

function ImRect_ImRectVec4(v)
    ccall((:ImRect_ImRectVec4, libcimgui), Ptr{ImRect}, (ImVec4,), v)
end

function ImRect_ImRectFloat(x1, y1, x2, y2)
    ccall((:ImRect_ImRectFloat, libcimgui), Ptr{ImRect}, (Cfloat, Cfloat, Cfloat, Cfloat), x1, y1, x2, y2)
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

function ImRect_ContainsVec2(self, p)
    ccall((:ImRect_ContainsVec2, libcimgui), Bool, (Ptr{ImRect}, ImVec2), self, p)
end

function ImRect_ContainsRect(self, r)
    ccall((:ImRect_ContainsRect, libcimgui), Bool, (Ptr{ImRect}, ImRect), self, r)
end

function ImRect_Overlaps(self, r)
    ccall((:ImRect_Overlaps, libcimgui), Bool, (Ptr{ImRect}, ImRect), self, r)
end

function ImRect_AddVec2(self, p)
    ccall((:ImRect_AddVec2, libcimgui), Cvoid, (Ptr{ImRect}, ImVec2), self, p)
end

function ImRect_AddRect(self, r)
    ccall((:ImRect_AddRect, libcimgui), Cvoid, (Ptr{ImRect}, ImRect), self, r)
end

function ImRect_ExpandFloat(self, amount)
    ccall((:ImRect_ExpandFloat, libcimgui), Cvoid, (Ptr{ImRect}, Cfloat), self, amount)
end

function ImRect_ExpandVec2(self, amount)
    ccall((:ImRect_ExpandVec2, libcimgui), Cvoid, (Ptr{ImRect}, ImVec2), self, amount)
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

function ImDrawListSharedData_ImDrawListSharedData()
    ccall((:ImDrawListSharedData_ImDrawListSharedData, libcimgui), Ptr{ImDrawListSharedData}, ())
end

function ImDrawListSharedData_destroy(self)
    ccall((:ImDrawListSharedData_destroy, libcimgui), Cvoid, (Ptr{ImDrawListSharedData},), self)
end

function ImDrawListSharedData_SetCircleTessellationMaxError(self, max_error)
    ccall((:ImDrawListSharedData_SetCircleTessellationMaxError, libcimgui), Cvoid, (Ptr{ImDrawListSharedData}, Cfloat), self, max_error)
end

function ImDrawDataBuilder_Clear(self)
    ccall((:ImDrawDataBuilder_Clear, libcimgui), Cvoid, (Ptr{ImDrawDataBuilder},), self)
end

function ImDrawDataBuilder_ClearFreeMemory(self)
    ccall((:ImDrawDataBuilder_ClearFreeMemory, libcimgui), Cvoid, (Ptr{ImDrawDataBuilder},), self)
end

function ImDrawDataBuilder_GetDrawListCount(self)
    ccall((:ImDrawDataBuilder_GetDrawListCount, libcimgui), Cint, (Ptr{ImDrawDataBuilder},), self)
end

function ImDrawDataBuilder_FlattenIntoSingleLayer(self)
    ccall((:ImDrawDataBuilder_FlattenIntoSingleLayer, libcimgui), Cvoid, (Ptr{ImDrawDataBuilder},), self)
end

function ImGuiStyleMod_ImGuiStyleModInt(idx, v)
    ccall((:ImGuiStyleMod_ImGuiStyleModInt, libcimgui), Ptr{ImGuiStyleMod}, (ImGuiStyleVar, Cint), idx, v)
end

function ImGuiStyleMod_destroy(self)
    ccall((:ImGuiStyleMod_destroy, libcimgui), Cvoid, (Ptr{ImGuiStyleMod},), self)
end

function ImGuiStyleMod_ImGuiStyleModFloat(idx, v)
    ccall((:ImGuiStyleMod_ImGuiStyleModFloat, libcimgui), Ptr{ImGuiStyleMod}, (ImGuiStyleVar, Cfloat), idx, v)
end

function ImGuiStyleMod_ImGuiStyleModVec2(idx, v)
    ccall((:ImGuiStyleMod_ImGuiStyleModVec2, libcimgui), Ptr{ImGuiStyleMod}, (ImGuiStyleVar, ImVec2), idx, v)
end

function ImGuiMenuColumns_ImGuiMenuColumns()
    ccall((:ImGuiMenuColumns_ImGuiMenuColumns, libcimgui), Ptr{ImGuiMenuColumns}, ())
end

function ImGuiMenuColumns_destroy(self)
    ccall((:ImGuiMenuColumns_destroy, libcimgui), Cvoid, (Ptr{ImGuiMenuColumns},), self)
end

function ImGuiMenuColumns_Update(self, count, spacing, clear)
    ccall((:ImGuiMenuColumns_Update, libcimgui), Cvoid, (Ptr{ImGuiMenuColumns}, Cint, Cfloat, Bool), self, count, spacing, clear)
end

function ImGuiMenuColumns_DeclColumns(self, w0, w1, w2)
    ccall((:ImGuiMenuColumns_DeclColumns, libcimgui), Cfloat, (Ptr{ImGuiMenuColumns}, Cfloat, Cfloat, Cfloat), self, w0, w1, w2)
end

function ImGuiMenuColumns_CalcExtraSpace(self, avail_w)
    ccall((:ImGuiMenuColumns_CalcExtraSpace, libcimgui), Cfloat, (Ptr{ImGuiMenuColumns}, Cfloat), self, avail_w)
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

function ImGuiInputTextState_SelectAll(self)
    ccall((:ImGuiInputTextState_SelectAll, libcimgui), Cvoid, (Ptr{ImGuiInputTextState},), self)
end

function ImGuiPopupData_ImGuiPopupData()
    ccall((:ImGuiPopupData_ImGuiPopupData, libcimgui), Ptr{ImGuiPopupData}, ())
end

function ImGuiPopupData_destroy(self)
    ccall((:ImGuiPopupData_destroy, libcimgui), Cvoid, (Ptr{ImGuiPopupData},), self)
end

function ImGuiNavMoveResult_ImGuiNavMoveResult()
    ccall((:ImGuiNavMoveResult_ImGuiNavMoveResult, libcimgui), Ptr{ImGuiNavMoveResult}, ())
end

function ImGuiNavMoveResult_destroy(self)
    ccall((:ImGuiNavMoveResult_destroy, libcimgui), Cvoid, (Ptr{ImGuiNavMoveResult},), self)
end

function ImGuiNavMoveResult_Clear(self)
    ccall((:ImGuiNavMoveResult_Clear, libcimgui), Cvoid, (Ptr{ImGuiNavMoveResult},), self)
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

function ImGuiPtrOrIndex_ImGuiPtrOrIndexPtr(ptr)
    ccall((:ImGuiPtrOrIndex_ImGuiPtrOrIndexPtr, libcimgui), Ptr{ImGuiPtrOrIndex}, (Ptr{Cvoid},), ptr)
end

function ImGuiPtrOrIndex_destroy(self)
    ccall((:ImGuiPtrOrIndex_destroy, libcimgui), Cvoid, (Ptr{ImGuiPtrOrIndex},), self)
end

function ImGuiPtrOrIndex_ImGuiPtrOrIndexInt(index)
    ccall((:ImGuiPtrOrIndex_ImGuiPtrOrIndexInt, libcimgui), Ptr{ImGuiPtrOrIndex}, (Cint,), index)
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

function ImGuiViewportP_ImGuiViewportP()
    ccall((:ImGuiViewportP_ImGuiViewportP, libcimgui), Ptr{ImGuiViewportP}, ())
end

function ImGuiViewportP_destroy(self)
    ccall((:ImGuiViewportP_destroy, libcimgui), Cvoid, (Ptr{ImGuiViewportP},), self)
end

function ImGuiViewportP_GetMainRect(pOut, self)
    ccall((:ImGuiViewportP_GetMainRect, libcimgui), Cvoid, (Ptr{ImRect}, Ptr{ImGuiViewportP}), pOut, self)
end

function ImGuiViewportP_GetWorkRect(pOut, self)
    ccall((:ImGuiViewportP_GetWorkRect, libcimgui), Cvoid, (Ptr{ImRect}, Ptr{ImGuiViewportP}), pOut, self)
end

function ImGuiViewportP_UpdateWorkRect(self)
    ccall((:ImGuiViewportP_UpdateWorkRect, libcimgui), Cvoid, (Ptr{ImGuiViewportP},), self)
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

function ImGuiMetricsConfig_ImGuiMetricsConfig()
    ccall((:ImGuiMetricsConfig_ImGuiMetricsConfig, libcimgui), Ptr{ImGuiMetricsConfig}, ())
end

function ImGuiMetricsConfig_destroy(self)
    ccall((:ImGuiMetricsConfig_destroy, libcimgui), Cvoid, (Ptr{ImGuiMetricsConfig},), self)
end

function ImGuiStackSizes_ImGuiStackSizes()
    ccall((:ImGuiStackSizes_ImGuiStackSizes, libcimgui), Ptr{ImGuiStackSizes}, ())
end

function ImGuiStackSizes_destroy(self)
    ccall((:ImGuiStackSizes_destroy, libcimgui), Cvoid, (Ptr{ImGuiStackSizes},), self)
end

function ImGuiStackSizes_SetToCurrentState(self)
    ccall((:ImGuiStackSizes_SetToCurrentState, libcimgui), Cvoid, (Ptr{ImGuiStackSizes},), self)
end

function ImGuiStackSizes_CompareWithCurrentState(self)
    ccall((:ImGuiStackSizes_CompareWithCurrentState, libcimgui), Cvoid, (Ptr{ImGuiStackSizes},), self)
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

function ImGuiWindow_GetIDStr(self, str, str_end)
    ccall((:ImGuiWindow_GetIDStr, libcimgui), ImGuiID, (Ptr{ImGuiWindow}, Ptr{Cchar}, Ptr{Cchar}), self, str, str_end)
end

function ImGuiWindow_GetIDPtr(self, ptr)
    ccall((:ImGuiWindow_GetIDPtr, libcimgui), ImGuiID, (Ptr{ImGuiWindow}, Ptr{Cvoid}), self, ptr)
end

function ImGuiWindow_GetIDInt(self, n)
    ccall((:ImGuiWindow_GetIDInt, libcimgui), ImGuiID, (Ptr{ImGuiWindow}, Cint), self, n)
end

function ImGuiWindow_GetIDNoKeepAliveStr(self, str, str_end)
    ccall((:ImGuiWindow_GetIDNoKeepAliveStr, libcimgui), ImGuiID, (Ptr{ImGuiWindow}, Ptr{Cchar}, Ptr{Cchar}), self, str, str_end)
end

function ImGuiWindow_GetIDNoKeepAlivePtr(self, ptr)
    ccall((:ImGuiWindow_GetIDNoKeepAlivePtr, libcimgui), ImGuiID, (Ptr{ImGuiWindow}, Ptr{Cvoid}), self, ptr)
end

function ImGuiWindow_GetIDNoKeepAliveInt(self, n)
    ccall((:ImGuiWindow_GetIDNoKeepAliveInt, libcimgui), ImGuiID, (Ptr{ImGuiWindow}, Cint), self, n)
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

function ImGuiWindow_TitleBarHeight(self)
    ccall((:ImGuiWindow_TitleBarHeight, libcimgui), Cfloat, (Ptr{ImGuiWindow},), self)
end

function ImGuiWindow_TitleBarRect(pOut, self)
    ccall((:ImGuiWindow_TitleBarRect, libcimgui), Cvoid, (Ptr{ImRect}, Ptr{ImGuiWindow}), pOut, self)
end

function ImGuiWindow_MenuBarHeight(self)
    ccall((:ImGuiWindow_MenuBarHeight, libcimgui), Cfloat, (Ptr{ImGuiWindow},), self)
end

function ImGuiWindow_MenuBarRect(pOut, self)
    ccall((:ImGuiWindow_MenuBarRect, libcimgui), Cvoid, (Ptr{ImRect}, Ptr{ImGuiWindow}), pOut, self)
end

function ImGuiLastItemDataBackup_ImGuiLastItemDataBackup()
    ccall((:ImGuiLastItemDataBackup_ImGuiLastItemDataBackup, libcimgui), Ptr{ImGuiLastItemDataBackup}, ())
end

function ImGuiLastItemDataBackup_destroy(self)
    ccall((:ImGuiLastItemDataBackup_destroy, libcimgui), Cvoid, (Ptr{ImGuiLastItemDataBackup},), self)
end

function ImGuiLastItemDataBackup_Backup(self)
    ccall((:ImGuiLastItemDataBackup_Backup, libcimgui), Cvoid, (Ptr{ImGuiLastItemDataBackup},), self)
end

function ImGuiLastItemDataBackup_Restore(self)
    ccall((:ImGuiLastItemDataBackup_Restore, libcimgui), Cvoid, (Ptr{ImGuiLastItemDataBackup},), self)
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

function ImGuiTabBar_GetTabOrder(self, tab)
    ccall((:ImGuiTabBar_GetTabOrder, libcimgui), Cint, (Ptr{ImGuiTabBar}, Ptr{ImGuiTabItem}), self, tab)
end

function ImGuiTabBar_GetTabName(self, tab)
    ccall((:ImGuiTabBar_GetTabName, libcimgui), Ptr{Cchar}, (Ptr{ImGuiTabBar}, Ptr{ImGuiTabItem}), self, tab)
end

function ImGuiTableColumn_ImGuiTableColumn()
    ccall((:ImGuiTableColumn_ImGuiTableColumn, libcimgui), Ptr{ImGuiTableColumn}, ())
end

function ImGuiTableColumn_destroy(self)
    ccall((:ImGuiTableColumn_destroy, libcimgui), Cvoid, (Ptr{ImGuiTableColumn},), self)
end

function ImGuiTable_ImGuiTable()
    ccall((:ImGuiTable_ImGuiTable, libcimgui), Ptr{ImGuiTable}, ())
end

function ImGuiTable_destroy(self)
    ccall((:ImGuiTable_destroy, libcimgui), Cvoid, (Ptr{ImGuiTable},), self)
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

function igCalcWindowNextAutoFitSize(pOut, window)
    ccall((:igCalcWindowNextAutoFitSize, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImGuiWindow}), pOut, window)
end

function igIsWindowChildOf(window, potential_parent)
    ccall((:igIsWindowChildOf, libcimgui), Bool, (Ptr{ImGuiWindow}, Ptr{ImGuiWindow}), window, potential_parent)
end

function igIsWindowAbove(potential_above, potential_below)
    ccall((:igIsWindowAbove, libcimgui), Bool, (Ptr{ImGuiWindow}, Ptr{ImGuiWindow}), potential_above, potential_below)
end

function igIsWindowNavFocusable(window)
    ccall((:igIsWindowNavFocusable, libcimgui), Bool, (Ptr{ImGuiWindow},), window)
end

function igGetWindowAllowedExtentRect(pOut, window)
    ccall((:igGetWindowAllowedExtentRect, libcimgui), Cvoid, (Ptr{ImRect}, Ptr{ImGuiWindow}), pOut, window)
end

function igSetWindowPosWindowPtr(window, pos, cond)
    ccall((:igSetWindowPosWindowPtr, libcimgui), Cvoid, (Ptr{ImGuiWindow}, ImVec2, ImGuiCond), window, pos, cond)
end

function igSetWindowSizeWindowPtr(window, size, cond)
    ccall((:igSetWindowSizeWindowPtr, libcimgui), Cvoid, (Ptr{ImGuiWindow}, ImVec2, ImGuiCond), window, size, cond)
end

function igSetWindowCollapsedWindowPtr(window, collapsed, cond)
    ccall((:igSetWindowCollapsedWindowPtr, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Bool, ImGuiCond), window, collapsed, cond)
end

function igSetWindowHitTestHole(window, pos, size)
    ccall((:igSetWindowHitTestHole, libcimgui), Cvoid, (Ptr{ImGuiWindow}, ImVec2, ImVec2), window, pos, size)
end

function igFocusWindow(window)
    ccall((:igFocusWindow, libcimgui), Cvoid, (Ptr{ImGuiWindow},), window)
end

function igFocusTopMostWindowUnderOne(under_this_window, ignore_window)
    ccall((:igFocusTopMostWindowUnderOne, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Ptr{ImGuiWindow}), under_this_window, ignore_window)
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

function igSetCurrentFont(font)
    ccall((:igSetCurrentFont, libcimgui), Cvoid, (Ptr{ImFont},), font)
end

function igGetDefaultFont()
    ccall((:igGetDefaultFont, libcimgui), Ptr{ImFont}, ())
end

function igGetForegroundDrawListWindowPtr(window)
    ccall((:igGetForegroundDrawListWindowPtr, libcimgui), Ptr{ImDrawList}, (Ptr{ImGuiWindow},), window)
end

function igGetBackgroundDrawListViewportPtr(viewport)
    ccall((:igGetBackgroundDrawListViewportPtr, libcimgui), Ptr{ImDrawList}, (Ptr{ImGuiViewport},), viewport)
end

function igGetForegroundDrawListViewportPtr(viewport)
    ccall((:igGetForegroundDrawListViewportPtr, libcimgui), Ptr{ImDrawList}, (Ptr{ImGuiViewport},), viewport)
end

function igInitialize(context)
    ccall((:igInitialize, libcimgui), Cvoid, (Ptr{ImGuiContext},), context)
end

function igShutdown(context)
    ccall((:igShutdown, libcimgui), Cvoid, (Ptr{ImGuiContext},), context)
end

function igUpdateHoveredWindowAndCaptureFlags()
    ccall((:igUpdateHoveredWindowAndCaptureFlags, libcimgui), Cvoid, ())
end

function igStartMouseMovingWindow(window)
    ccall((:igStartMouseMovingWindow, libcimgui), Cvoid, (Ptr{ImGuiWindow},), window)
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

function igMarkIniSettingsDirtyNil()
    ccall((:igMarkIniSettingsDirtyNil, libcimgui), Cvoid, ())
end

function igMarkIniSettingsDirtyWindowPtr(window)
    ccall((:igMarkIniSettingsDirtyWindowPtr, libcimgui), Cvoid, (Ptr{ImGuiWindow},), window)
end

function igClearIniSettings()
    ccall((:igClearIniSettings, libcimgui), Cvoid, ())
end

function igCreateNewWindowSettings(name)
    ccall((:igCreateNewWindowSettings, libcimgui), Ptr{ImGuiWindowSettings}, (Ptr{Cchar},), name)
end

function igFindWindowSettings(id)
    ccall((:igFindWindowSettings, libcimgui), Ptr{ImGuiWindowSettings}, (ImGuiID,), id)
end

function igFindOrCreateWindowSettings(name)
    ccall((:igFindOrCreateWindowSettings, libcimgui), Ptr{ImGuiWindowSettings}, (Ptr{Cchar},), name)
end

function igFindSettingsHandler(type_name)
    ccall((:igFindSettingsHandler, libcimgui), Ptr{ImGuiSettingsHandler}, (Ptr{Cchar},), type_name)
end

function igSetNextWindowScroll(scroll)
    ccall((:igSetNextWindowScroll, libcimgui), Cvoid, (ImVec2,), scroll)
end

function igSetScrollXWindowPtr(window, scroll_x)
    ccall((:igSetScrollXWindowPtr, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Cfloat), window, scroll_x)
end

function igSetScrollYWindowPtr(window, scroll_y)
    ccall((:igSetScrollYWindowPtr, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Cfloat), window, scroll_y)
end

function igSetScrollFromPosXWindowPtr(window, local_x, center_x_ratio)
    ccall((:igSetScrollFromPosXWindowPtr, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Cfloat, Cfloat), window, local_x, center_x_ratio)
end

function igSetScrollFromPosYWindowPtr(window, local_y, center_y_ratio)
    ccall((:igSetScrollFromPosYWindowPtr, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Cfloat, Cfloat), window, local_y, center_y_ratio)
end

function igScrollToBringRectIntoView(pOut, window, item_rect)
    ccall((:igScrollToBringRectIntoView, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImGuiWindow}, ImRect), pOut, window, item_rect)
end

function igGetItemID()
    ccall((:igGetItemID, libcimgui), ImGuiID, ())
end

function igGetItemStatusFlags()
    ccall((:igGetItemStatusFlags, libcimgui), ImGuiItemStatusFlags, ())
end

function igGetActiveID()
    ccall((:igGetActiveID, libcimgui), ImGuiID, ())
end

function igGetFocusID()
    ccall((:igGetFocusID, libcimgui), ImGuiID, ())
end

function igGetItemsFlags()
    ccall((:igGetItemsFlags, libcimgui), ImGuiItemFlags, ())
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

function igGetIDWithSeed(str_id_begin, str_id_end, seed)
    ccall((:igGetIDWithSeed, libcimgui), ImGuiID, (Ptr{Cchar}, Ptr{Cchar}, ImGuiID), str_id_begin, str_id_end, seed)
end

function igItemSizeVec2(size, text_baseline_y)
    ccall((:igItemSizeVec2, libcimgui), Cvoid, (ImVec2, Cfloat), size, text_baseline_y)
end

function igItemSizeRect(bb, text_baseline_y)
    ccall((:igItemSizeRect, libcimgui), Cvoid, (ImRect, Cfloat), bb, text_baseline_y)
end

function igItemAdd(bb, id, nav_bb)
    ccall((:igItemAdd, libcimgui), Bool, (ImRect, ImGuiID, Ptr{ImRect}), bb, id, nav_bb)
end

function igItemHoverable(bb, id)
    ccall((:igItemHoverable, libcimgui), Bool, (ImRect, ImGuiID), bb, id)
end

function igIsClippedEx(bb, id, clip_even_when_logged)
    ccall((:igIsClippedEx, libcimgui), Bool, (ImRect, ImGuiID, Bool), bb, id, clip_even_when_logged)
end

function igSetLastItemData(window, item_id, status_flags, item_rect)
    ccall((:igSetLastItemData, libcimgui), Cvoid, (Ptr{ImGuiWindow}, ImGuiID, ImGuiItemStatusFlags, ImRect), window, item_id, status_flags, item_rect)
end

function igFocusableItemRegister(window, id)
    ccall((:igFocusableItemRegister, libcimgui), Bool, (Ptr{ImGuiWindow}, ImGuiID), window, id)
end

function igFocusableItemUnregister(window)
    ccall((:igFocusableItemUnregister, libcimgui), Cvoid, (Ptr{ImGuiWindow},), window)
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

function igPushItemFlag(option, enabled)
    ccall((:igPushItemFlag, libcimgui), Cvoid, (ImGuiItemFlags, Bool), option, enabled)
end

function igPopItemFlag()
    ccall((:igPopItemFlag, libcimgui), Cvoid, ())
end

function igIsItemToggledSelection()
    ccall((:igIsItemToggledSelection, libcimgui), Bool, ())
end

function igGetContentRegionMaxAbs(pOut)
    ccall((:igGetContentRegionMaxAbs, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igShrinkWidths(items, count, width_excess)
    ccall((:igShrinkWidths, libcimgui), Cvoid, (Ptr{ImGuiShrinkWidthItem}, Cint, Cfloat), items, count, width_excess)
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

function igBeginChildEx(name, id, size_arg, border, flags)
    ccall((:igBeginChildEx, libcimgui), Bool, (Ptr{Cchar}, ImGuiID, ImVec2, Bool, ImGuiWindowFlags), name, id, size_arg, border, flags)
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

function igIsPopupOpenID(id, popup_flags)
    ccall((:igIsPopupOpenID, libcimgui), Bool, (ImGuiID, ImGuiPopupFlags), id, popup_flags)
end

function igBeginPopupEx(id, extra_flags)
    ccall((:igBeginPopupEx, libcimgui), Bool, (ImGuiID, ImGuiWindowFlags), id, extra_flags)
end

function igBeginTooltipEx(extra_flags, tooltip_flags)
    ccall((:igBeginTooltipEx, libcimgui), Cvoid, (ImGuiWindowFlags, ImGuiTooltipFlags), extra_flags, tooltip_flags)
end

function igGetTopMostPopupModal()
    ccall((:igGetTopMostPopupModal, libcimgui), Ptr{ImGuiWindow}, ())
end

function igFindBestWindowPosForPopup(pOut, window)
    ccall((:igFindBestWindowPosForPopup, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImGuiWindow}), pOut, window)
end

function igFindBestWindowPosForPopupEx(pOut, ref_pos, size, last_dir, r_outer, r_avoid, policy)
    ccall((:igFindBestWindowPosForPopupEx, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2, ImVec2, Ptr{ImGuiDir}, ImRect, ImRect, ImGuiPopupPositionPolicy), pOut, ref_pos, size, last_dir, r_outer, r_avoid, policy)
end

function igNavInitWindow(window, force_reinit)
    ccall((:igNavInitWindow, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Bool), window, force_reinit)
end

function igNavMoveRequestButNoResultYet()
    ccall((:igNavMoveRequestButNoResultYet, libcimgui), Bool, ())
end

function igNavMoveRequestCancel()
    ccall((:igNavMoveRequestCancel, libcimgui), Cvoid, ())
end

function igNavMoveRequestForward(move_dir, clip_dir, bb_rel, move_flags)
    ccall((:igNavMoveRequestForward, libcimgui), Cvoid, (ImGuiDir, ImGuiDir, ImRect, ImGuiNavMoveFlags), move_dir, clip_dir, bb_rel, move_flags)
end

function igNavMoveRequestTryWrapping(window, move_flags)
    ccall((:igNavMoveRequestTryWrapping, libcimgui), Cvoid, (Ptr{ImGuiWindow}, ImGuiNavMoveFlags), window, move_flags)
end

function igGetNavInputAmount(n, mode)
    ccall((:igGetNavInputAmount, libcimgui), Cfloat, (ImGuiNavInput, ImGuiInputReadMode), n, mode)
end

function igGetNavInputAmount2d(pOut, dir_sources, mode, slow_factor, fast_factor)
    ccall((:igGetNavInputAmount2d, libcimgui), Cvoid, (Ptr{ImVec2}, ImGuiNavDirSourceFlags, ImGuiInputReadMode, Cfloat, Cfloat), pOut, dir_sources, mode, slow_factor, fast_factor)
end

function igCalcTypematicRepeatAmount(t0, t1, repeat_delay, repeat_rate)
    ccall((:igCalcTypematicRepeatAmount, libcimgui), Cint, (Cfloat, Cfloat, Cfloat, Cfloat), t0, t1, repeat_delay, repeat_rate)
end

function igActivateItem(id)
    ccall((:igActivateItem, libcimgui), Cvoid, (ImGuiID,), id)
end

function igSetNavID(id, nav_layer, focus_scope_id, rect_rel)
    ccall((:igSetNavID, libcimgui), Cvoid, (ImGuiID, Cint, ImGuiID, ImRect), id, nav_layer, focus_scope_id, rect_rel)
end

function igPushFocusScope(id)
    ccall((:igPushFocusScope, libcimgui), Cvoid, (ImGuiID,), id)
end

function igPopFocusScope()
    ccall((:igPopFocusScope, libcimgui), Cvoid, ())
end

function igGetFocusedFocusScope()
    ccall((:igGetFocusedFocusScope, libcimgui), ImGuiID, ())
end

function igGetFocusScope()
    ccall((:igGetFocusScope, libcimgui), ImGuiID, ())
end

function igSetItemUsingMouseWheel()
    ccall((:igSetItemUsingMouseWheel, libcimgui), Cvoid, ())
end

function igIsActiveIdUsingNavDir(dir)
    ccall((:igIsActiveIdUsingNavDir, libcimgui), Bool, (ImGuiDir,), dir)
end

function igIsActiveIdUsingNavInput(input)
    ccall((:igIsActiveIdUsingNavInput, libcimgui), Bool, (ImGuiNavInput,), input)
end

function igIsActiveIdUsingKey(key)
    ccall((:igIsActiveIdUsingKey, libcimgui), Bool, (ImGuiKey,), key)
end

function igIsMouseDragPastThreshold(button, lock_threshold)
    ccall((:igIsMouseDragPastThreshold, libcimgui), Bool, (ImGuiMouseButton, Cfloat), button, lock_threshold)
end

function igIsKeyPressedMap(key, repeat)
    ccall((:igIsKeyPressedMap, libcimgui), Bool, (ImGuiKey, Bool), key, repeat)
end

function igIsNavInputDown(n)
    ccall((:igIsNavInputDown, libcimgui), Bool, (ImGuiNavInput,), n)
end

function igIsNavInputTest(n, rm)
    ccall((:igIsNavInputTest, libcimgui), Bool, (ImGuiNavInput, ImGuiInputReadMode), n, rm)
end

function igGetMergedKeyModFlags()
    ccall((:igGetMergedKeyModFlags, libcimgui), ImGuiKeyModFlags, ())
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

function igTableSetColumnEnabled(column_n, enabled)
    ccall((:igTableSetColumnEnabled, libcimgui), Cvoid, (Cint, Bool), column_n, enabled)
end

function igTableSetColumnWidth(column_n, width)
    ccall((:igTableSetColumnWidth, libcimgui), Cvoid, (Cint, Cfloat), column_n, width)
end

function igTableSetColumnSortDirection(column_n, sort_direction, append_to_sort_specs)
    ccall((:igTableSetColumnSortDirection, libcimgui), Cvoid, (Cint, ImGuiSortDirection, Bool), column_n, sort_direction, append_to_sort_specs)
end

function igTableGetHoveredColumn()
    ccall((:igTableGetHoveredColumn, libcimgui), Cint, ())
end

function igTableGetHeaderRowHeight()
    ccall((:igTableGetHeaderRowHeight, libcimgui), Cfloat, ())
end

function igTablePushBackgroundChannel()
    ccall((:igTablePushBackgroundChannel, libcimgui), Cvoid, ())
end

function igTablePopBackgroundChannel()
    ccall((:igTablePopBackgroundChannel, libcimgui), Cvoid, ())
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

function igTableDrawContextMenu(table)
    ccall((:igTableDrawContextMenu, libcimgui), Cvoid, (Ptr{ImGuiTable},), table)
end

function igTableMergeDrawChannels(table)
    ccall((:igTableMergeDrawChannels, libcimgui), Cvoid, (Ptr{ImGuiTable},), table)
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

function igTableGetColumnNameTablePtr(table, column_n)
    ccall((:igTableGetColumnNameTablePtr, libcimgui), Ptr{Cchar}, (Ptr{ImGuiTable}, Cint), table, column_n)
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

function igTableGcCompactTransientBuffers(table)
    ccall((:igTableGcCompactTransientBuffers, libcimgui), Cvoid, (Ptr{ImGuiTable},), table)
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

function igTableSettingsInstallHandler(context)
    ccall((:igTableSettingsInstallHandler, libcimgui), Cvoid, (Ptr{ImGuiContext},), context)
end

function igTableSettingsCreate(id, columns_count)
    ccall((:igTableSettingsCreate, libcimgui), Ptr{ImGuiTableSettings}, (ImGuiID, Cint), id, columns_count)
end

function igTableSettingsFindByID(id)
    ccall((:igTableSettingsFindByID, libcimgui), Ptr{ImGuiTableSettings}, (ImGuiID,), id)
end

function igBeginTabBarEx(tab_bar, bb, flags)
    ccall((:igBeginTabBarEx, libcimgui), Bool, (Ptr{ImGuiTabBar}, ImRect, ImGuiTabBarFlags), tab_bar, bb, flags)
end

function igTabBarFindTabByID(tab_bar, tab_id)
    ccall((:igTabBarFindTabByID, libcimgui), Ptr{ImGuiTabItem}, (Ptr{ImGuiTabBar}, ImGuiID), tab_bar, tab_id)
end

function igTabBarRemoveTab(tab_bar, tab_id)
    ccall((:igTabBarRemoveTab, libcimgui), Cvoid, (Ptr{ImGuiTabBar}, ImGuiID), tab_bar, tab_id)
end

function igTabBarCloseTab(tab_bar, tab)
    ccall((:igTabBarCloseTab, libcimgui), Cvoid, (Ptr{ImGuiTabBar}, Ptr{ImGuiTabItem}), tab_bar, tab)
end

function igTabBarQueueReorder(tab_bar, tab, dir)
    ccall((:igTabBarQueueReorder, libcimgui), Cvoid, (Ptr{ImGuiTabBar}, Ptr{ImGuiTabItem}, Cint), tab_bar, tab, dir)
end

function igTabBarProcessReorder(tab_bar)
    ccall((:igTabBarProcessReorder, libcimgui), Bool, (Ptr{ImGuiTabBar},), tab_bar)
end

function igTabItemEx(tab_bar, label, p_open, flags)
    ccall((:igTabItemEx, libcimgui), Bool, (Ptr{ImGuiTabBar}, Ptr{Cchar}, Ptr{Bool}, ImGuiTabItemFlags), tab_bar, label, p_open, flags)
end

function igTabItemCalcSize(pOut, label, has_close_button)
    ccall((:igTabItemCalcSize, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{Cchar}, Bool), pOut, label, has_close_button)
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

function igRenderArrow(draw_list, pos, col, dir, scale)
    ccall((:igRenderArrow, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImU32, ImGuiDir, Cfloat), draw_list, pos, col, dir, scale)
end

function igRenderBullet(draw_list, pos, col)
    ccall((:igRenderBullet, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImU32), draw_list, pos, col)
end

function igRenderCheckMark(draw_list, pos, col, sz)
    ccall((:igRenderCheckMark, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImU32, Cfloat), draw_list, pos, col, sz)
end

function igRenderMouseCursor(draw_list, pos, scale, mouse_cursor, col_fill, col_border, col_shadow)
    ccall((:igRenderMouseCursor, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, Cfloat, ImGuiMouseCursor, ImU32, ImU32, ImU32), draw_list, pos, scale, mouse_cursor, col_fill, col_border, col_shadow)
end

function igRenderArrowPointingAt(draw_list, pos, half_sz, direction, col)
    ccall((:igRenderArrowPointingAt, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImGuiDir, ImU32), draw_list, pos, half_sz, direction, col)
end

function igRenderRectFilledRangeH(draw_list, rect, col, x_start_norm, x_end_norm, rounding)
    ccall((:igRenderRectFilledRangeH, libcimgui), Cvoid, (Ptr{ImDrawList}, ImRect, ImU32, Cfloat, Cfloat, Cfloat), draw_list, rect, col, x_start_norm, x_end_norm, rounding)
end

function igRenderRectFilledWithHole(draw_list, outer, inner, col, rounding)
    ccall((:igRenderRectFilledWithHole, libcimgui), Cvoid, (Ptr{ImDrawList}, ImRect, ImRect, ImU32, Cfloat), draw_list, outer, inner, col, rounding)
end

function igTextEx(text, text_end, flags)
    ccall((:igTextEx, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cchar}, ImGuiTextFlags), text, text_end, flags)
end

function igButtonEx(label, size_arg, flags)
    ccall((:igButtonEx, libcimgui), Bool, (Ptr{Cchar}, ImVec2, ImGuiButtonFlags), label, size_arg, flags)
end

function igCloseButton(id, pos)
    ccall((:igCloseButton, libcimgui), Bool, (ImGuiID, ImVec2), id, pos)
end

function igCollapseButton(id, pos)
    ccall((:igCollapseButton, libcimgui), Bool, (ImGuiID, ImVec2), id, pos)
end

function igArrowButtonEx(str_id, dir, size_arg, flags)
    ccall((:igArrowButtonEx, libcimgui), Bool, (Ptr{Cchar}, ImGuiDir, ImVec2, ImGuiButtonFlags), str_id, dir, size_arg, flags)
end

function igScrollbar(axis)
    ccall((:igScrollbar, libcimgui), Cvoid, (ImGuiAxis,), axis)
end

function igScrollbarEx(bb, id, axis, p_scroll_v, avail_v, contents_v, flags)
    ccall((:igScrollbarEx, libcimgui), Bool, (ImRect, ImGuiID, ImGuiAxis, Ptr{Cfloat}, Cfloat, Cfloat, ImDrawFlags), bb, id, axis, p_scroll_v, avail_v, contents_v, flags)
end

function igImageButtonEx(id, texture_id, size, uv0, uv1, padding, bg_col, tint_col)
    ccall((:igImageButtonEx, libcimgui), Bool, (ImGuiID, ImTextureID, ImVec2, ImVec2, ImVec2, ImVec2, ImVec4, ImVec4), id, texture_id, size, uv0, uv1, padding, bg_col, tint_col)
end

function igGetWindowScrollbarRect(pOut, window, axis)
    ccall((:igGetWindowScrollbarRect, libcimgui), Cvoid, (Ptr{ImRect}, Ptr{ImGuiWindow}, ImGuiAxis), pOut, window, axis)
end

function igGetWindowScrollbarID(window, axis)
    ccall((:igGetWindowScrollbarID, libcimgui), ImGuiID, (Ptr{ImGuiWindow}, ImGuiAxis), window, axis)
end

function igGetWindowResizeID(window, n)
    ccall((:igGetWindowResizeID, libcimgui), ImGuiID, (Ptr{ImGuiWindow}, Cint), window, n)
end

function igSeparatorEx(flags)
    ccall((:igSeparatorEx, libcimgui), Cvoid, (ImGuiSeparatorFlags,), flags)
end

function igCheckboxFlagsS64Ptr(label, flags, flags_value)
    ccall((:igCheckboxFlagsS64Ptr, libcimgui), Bool, (Ptr{Cchar}, Ptr{ImS64}, ImS64), label, flags, flags_value)
end

function igCheckboxFlagsU64Ptr(label, flags, flags_value)
    ccall((:igCheckboxFlagsU64Ptr, libcimgui), Bool, (Ptr{Cchar}, Ptr{ImU64}, ImU64), label, flags, flags_value)
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

function igSplitterBehavior(bb, id, axis, size1, size2, min_size1, min_size2, hover_extend, hover_visibility_delay)
    ccall((:igSplitterBehavior, libcimgui), Bool, (ImRect, ImGuiID, ImGuiAxis, Ptr{Cfloat}, Ptr{Cfloat}, Cfloat, Cfloat, Cfloat, Cfloat), bb, id, axis, size1, size2, min_size1, min_size2, hover_extend, hover_visibility_delay)
end

function igTreeNodeBehavior(id, flags, label, label_end)
    ccall((:igTreeNodeBehavior, libcimgui), Bool, (ImGuiID, ImGuiTreeNodeFlags, Ptr{Cchar}, Ptr{Cchar}), id, flags, label, label_end)
end

function igTreeNodeBehaviorIsOpen(id, flags)
    ccall((:igTreeNodeBehaviorIsOpen, libcimgui), Bool, (ImGuiID, ImGuiTreeNodeFlags), id, flags)
end

function igTreePushOverrideID(id)
    ccall((:igTreePushOverrideID, libcimgui), Cvoid, (ImGuiID,), id)
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

function igDataTypeApplyOpFromText(buf, initial_value_buf, data_type, p_data, format)
    ccall((:igDataTypeApplyOpFromText, libcimgui), Bool, (Ptr{Cchar}, Ptr{Cchar}, ImGuiDataType, Ptr{Cvoid}, Ptr{Cchar}), buf, initial_value_buf, data_type, p_data, format)
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

function igColorTooltip(text, col, flags)
    ccall((:igColorTooltip, libcimgui), Cvoid, (Ptr{Cchar}, Ptr{Cfloat}, ImGuiColorEditFlags), text, col, flags)
end

function igColorEditOptionsPopup(col, flags)
    ccall((:igColorEditOptionsPopup, libcimgui), Cvoid, (Ptr{Cfloat}, ImGuiColorEditFlags), col, flags)
end

function igColorPickerOptionsPopup(ref_col, flags)
    ccall((:igColorPickerOptionsPopup, libcimgui), Cvoid, (Ptr{Cfloat}, ImGuiColorEditFlags), ref_col, flags)
end

function igPlotEx(plot_type, label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, frame_size)
    ccall((:igPlotEx, libcimgui), Cint, (ImGuiPlotType, Ptr{Cchar}, Ptr{Cvoid}, Ptr{Cvoid}, Cint, Cint, Ptr{Cchar}, Cfloat, Cfloat, ImVec2), plot_type, label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, frame_size)
end

function igShadeVertsLinearColorGradientKeepAlpha(draw_list, vert_start_idx, vert_end_idx, gradient_p0, gradient_p1, col0, col1)
    ccall((:igShadeVertsLinearColorGradientKeepAlpha, libcimgui), Cvoid, (Ptr{ImDrawList}, Cint, Cint, ImVec2, ImVec2, ImU32, ImU32), draw_list, vert_start_idx, vert_end_idx, gradient_p0, gradient_p1, col0, col1)
end

function igShadeVertsLinearUV(draw_list, vert_start_idx, vert_end_idx, a, b, uv_a, uv_b, clamp)
    ccall((:igShadeVertsLinearUV, libcimgui), Cvoid, (Ptr{ImDrawList}, Cint, Cint, ImVec2, ImVec2, ImVec2, ImVec2, Bool), draw_list, vert_start_idx, vert_end_idx, a, b, uv_a, uv_b, clamp)
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

function igErrorCheckEndFrameRecover(log_callback, user_data)
    ccall((:igErrorCheckEndFrameRecover, libcimgui), Cvoid, (ImGuiErrorLogCallback, Ptr{Cvoid}), log_callback, user_data)
end

function igDebugDrawItemRect(col)
    ccall((:igDebugDrawItemRect, libcimgui), Cvoid, (ImU32,), col)
end

function igDebugStartItemPicker()
    ccall((:igDebugStartItemPicker, libcimgui), Cvoid, ())
end

function igDebugNodeColumns(columns)
    ccall((:igDebugNodeColumns, libcimgui), Cvoid, (Ptr{ImGuiOldColumns},), columns)
end

function igDebugNodeDrawList(window, draw_list, label)
    ccall((:igDebugNodeDrawList, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Ptr{ImDrawList}, Ptr{Cchar}), window, draw_list, label)
end

function igDebugNodeDrawCmdShowMeshAndBoundingBox(out_draw_list, draw_list, draw_cmd, show_mesh, show_aabb)
    ccall((:igDebugNodeDrawCmdShowMeshAndBoundingBox, libcimgui), Cvoid, (Ptr{ImDrawList}, Ptr{ImDrawList}, Ptr{ImDrawCmd}, Bool, Bool), out_draw_list, draw_list, draw_cmd, show_mesh, show_aabb)
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

function igDebugNodeWindow(window, label)
    ccall((:igDebugNodeWindow, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Ptr{Cchar}), window, label)
end

function igDebugNodeWindowSettings(settings)
    ccall((:igDebugNodeWindowSettings, libcimgui), Cvoid, (Ptr{ImGuiWindowSettings},), settings)
end

function igDebugNodeWindowsList(windows, label)
    ccall((:igDebugNodeWindowsList, libcimgui), Cvoid, (Ptr{ImVector_ImGuiWindowPtr}, Ptr{Cchar}), windows, label)
end

function igDebugNodeViewport(viewport)
    ccall((:igDebugNodeViewport, libcimgui), Cvoid, (Ptr{ImGuiViewportP},), viewport)
end

function igDebugRenderViewportThumbnail(draw_list, viewport, bb)
    ccall((:igDebugRenderViewportThumbnail, libcimgui), Cvoid, (Ptr{ImDrawList}, Ptr{ImGuiViewportP}, ImRect), draw_list, viewport, bb)
end

function igImFontAtlasGetBuilderForStbTruetype()
    ccall((:igImFontAtlasGetBuilderForStbTruetype, libcimgui), Ptr{ImFontBuilderIO}, ())
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

# no prototype is found for this function at cimgui.h:3385:18, please use with caution
function igGET_FLT_MAX()
    ccall((:igGET_FLT_MAX, libcimgui), Cfloat, ())
end

# no prototype is found for this function at cimgui.h:3387:18, please use with caution
function igGET_FLT_MIN()
    ccall((:igGET_FLT_MIN, libcimgui), Cfloat, ())
end

# no prototype is found for this function at cimgui.h:3390:30, please use with caution
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

# should be reimplement as macros by using Julia 1.5's @ccall macro
function igText(text)
    ccall((:igText, libcimgui), Cvoid, (Cstring, Cstring), "%s", text)
end

function igTextColored(col, text)
    ccall((:igTextColored, libcimgui), Cvoid, (ImVec4, Cstring), col, text)
end

function igTextDisabled(text)
    ccall((:igTextDisabled, libcimgui), Cvoid, (Cstring,), text)
end

function igTextWrapped(text)
    ccall((:igTextWrapped, libcimgui), Cvoid, (Cstring,), text)
end

function igLabelText(label, text)
    ccall((:igLabelText, libcimgui), Cvoid, (Cstring, Cstring), label, text)
end

function igBulletText(text)
    ccall((:igBulletText, libcimgui), Cvoid, (Cstring,), text)
end

function igTreeNodeStrStr(str_id, text)
    ccall((:igTreeNodeStrStr, libcimgui), Bool, (Cstring, Cstring), str_id, text)
end

function igTreeNodePtr(ptr_id, text)
    ccall((:igTreeNodePtr, libcimgui), Bool, (Ptr{Cvoid}, Cstring), ptr_id, text)
end

function igTreeNodeExStrStr(str_id, flags, text)
    ccall((:igTreeNodeExStrStr, libcimgui), Bool, (Cstring, ImGuiTreeNodeFlags, Cstring), str_id, flags, text)
end

function igTreeNodeExPtr(ptr_id, flags, text)
    ccall((:igTreeNodeExPtr, libcimgui), Bool, (Ptr{Cvoid}, ImGuiTreeNodeFlags, Cstring), ptr_id, flags, text)
end

function igSetTooltip(text)
    ccall((:igSetTooltip, libcimgui), Cvoid, (Cstring,), text)
end

function igOpenPopup(str_id)
    ccall((:igOpenPopup, libcimgui), Cvoid, (Cstring,), str_id)
end

function igLogText(text)
    ccall((:igLogText, libcimgui), Cvoid, (Cstring,), text)
end


# exports
const PREFIXES = ["ig", "Im"]
foreach(names(@__MODULE__; all=true)) do s
    for prefix in PREFIXES
        if startswith(string(s), prefix)
            @eval export $s
        end
    end
end

end # module
