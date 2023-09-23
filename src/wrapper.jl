########################################## context #########################################
"""
    CreateContext() -> Ptr{ImGuiContext}
    CreateContext(shared_font_atlas::Ptr{ImFontAtlas}) -> Ptr{ImGuiContext}
Return a handle of `ImGuiContext`.
"""
CreateContext() = igCreateContext(C_NULL)
CreateContext(shared_font_atlas::Ptr{ImFontAtlas}) = igCreateContext(shared_font_atlas)

"""
    DestroyContext()
    DestroyContext(ctx::Ptr{ImGuiContext})
Destroy `ImGuiContext`. `DestroyContext()` will destroy current context.
"""
DestroyContext() = igDestroyContext(C_NULL)
DestroyContext(ctx::Ptr{ImGuiContext}) = igDestroyContext(ctx)

"""
    GetCurrentContext() -> Ptr{ImGuiContext}
Return a handle of the current context.
"""
GetCurrentContext() = igGetCurrentContext()

"""
    SetCurrentContext(ctx::Ptr{ImGuiContext})
Set current context to `ctx`.
"""
SetCurrentContext(ctx::Ptr{ImGuiContext}) = igSetCurrentContext(ctx)

########################################### Main ###########################################
"""
    GetIO() -> Ptr{ImGuiIO}
Return a handle of `ImGuiIO` which is for accessing the `IO` structure:
- mouse/keyboard/gamepad inputs
- time
- various configuration options/flags
"""
GetIO() = igGetIO()

"""
    GetStyle() -> Ptr{ImGuiStyle}
Return a handle of `ImGuiStyle` which is for accessing the `Style` structure (colors, sizes).

!!! note
    Always use [`PushStyleColor`](@ref), [`PushStyleVar`](@ref) to modify style mid-frame.
"""
GetStyle() = igGetStyle()

"""
    NewFrame()
Start a new ImGui frame. You can submit any command from this point until [`Render`](@ref)
or [`EndFrame`](@ref).
"""
NewFrame() = igNewFrame()

"""
    EndFrame()
Calling this function ends the ImGui frame. This function is automatically called by [`Render`](@ref),
so you likely don't need to call it yourself directly. If you don't need to render data (skipping rendering),
you may call [`EndFrame`](@ref) but you'll have wasted CPU already! If you don't need to render,
better to not create any imgui windows and not call [`NewFrame`](@ref) at all!
"""
EndFrame() = igEndFrame()

"""
    Render()
Calling this function ends the ImGui frame. This function finalizes the draw data.

!!! warning "Obsolete"
    Optionally call `ImGuiIO.RenderDrawListsFn` if set. Nowadays, prefer calling your render
    function yourself.
"""
Render() = igRender()

"""
    GetDrawData() -> Ptr{ImDrawData}
Return a handle of `ImDrawData` which is valid after [`Render`](@ref) and until the next call
to [`NewFrame`](@ref). This is what you have to render.

!!! warning "Obsolete"
    This used to be passed to your `ImGuiIO.RenderDrawListsFn` function.
"""
GetDrawData() = igGetDrawData()

################################# Demo, Debug, Information #################################
"""
    ShowDemoWindow()
    ShowDemoWindow(p_open=C_NULL)
Create demo/test window. Demonstrate most ImGui features.
"""
ShowDemoWindow(p_open=C_NULL) = igShowDemoWindow(p_open)

"""
    ShowAboutWindow()
    ShowAboutWindow(p_open=C_NULL)
Create about window. Display Dear ImGui version, credits and build/system information.
"""
ShowAboutWindow(p_open=C_NULL) = igShowAboutWindow(p_open)

"""
    ShowMetricsWindow()
    ShowMetricsWindow(p_open=C_NULL)
Create metrics window. Display Dear ImGui internals: draw commands (with individual draw calls
and vertices), window list, basic internal state, etc.
"""
ShowMetricsWindow(p_open=C_NULL) = igShowMetricsWindow(p_open)

"""
    ShowStyleEditor()
    ShowStyleEditor(ref=C_NULL)
Add style editor block (not a window). You can pass in a reference `ImGuiStyle` structure to
compare to, revert to and save to (else it uses the default style).
"""
ShowStyleEditor(ref=C_NULL) = igShowStyleEditor(ref)

"""
    ShowStyleSelector()
    ShowStyleSelector(label)
Add style selector block (not a window), essentially a combo listing the default styles.
"""
ShowStyleSelector(label) = igShowStyleSelector(label)

"""
    ShowFontSelector(label)
Add font selector block (not a window), essentially a combo listing the loaded fonts.
"""
ShowFontSelector(label) = igShowFontSelector(label)

"""
    ShowUserGuide()
Add basic help/info block (not a window): how to manipulate ImGui as a end-user (mouse/keyboard controls).
"""
ShowUserGuide() = igShowUserGuide()

"""
    GetVersion() -> Cstring
Get the compiled version string e.g. "1.23"
"""
GetVersion() = igGetVersion()

########################################## Styles ##########################################
"""
    StyleColorsDark()
Use the new, recommended style. This is also the default style.
"""
StyleColorsDark() = igStyleColorsDark(C_NULL)

"""
    StyleColorsClassic()
Use the classic imgui style.
"""
StyleColorsClassic() = igStyleColorsClassic(C_NULL)

"""
    StyleColorsLight()
This style is best used with borders and a custom, thicker font.
"""
StyleColorsLight() = igStyleColorsLight(C_NULL)

########################################## Windows #########################################
"""
    Begin(name, p_open=C_NULL, flags=0) -> Bool
Push window to the stack and start appending to it.

### Usage
- you may **append multiple times to the same window** during **the same frame**.
- passing `p_open != C_NULL` shows a window-closing widget in the upper-right corner of the window,
    which clicking will set the boolean to false when clicked.
- [`Begin`](@ref) return false to indicate the window is collapsed or fully clipped, so you
    may early out and omit submitting anything to the window.

!!! note
    Always call a matching [`End`](@ref) for each [`Begin`](@ref) call, regardless of its return value.
    This is due to legacy reason and is inconsistent with most other functions (such as
    [`BeginMenu`](@ref)/[`EndMenu`](@ref), [`BeginPopup`](@ref)/[`EndPopup`](@ref), etc.)
    where the `EndXXX` call should only be called if the corresponding `BeginXXX` function returned true.
"""
Begin(name, p_open=C_NULL, flags=0) = igBegin(name, p_open, flags)

"""
    End()
Pop window from the stack. See also [`Begin`](@ref).
"""
End() = igEnd()

####################################### Child Windows ######################################
"""
    BeginChild(str_id, size=(0,0), border=false, flags=0) -> Bool
    BeginChild(id::Integer, size=(0,0), border=false, flags=0) -> Bool
Use child windows to begin into a self-contained independent scrolling/clipping regions within
a host window. Child windows can embed their own child.

Return false to indicate the window is collapsed or fully clipped, so you may early out and
omit submitting anything to the window.

For each independent axis of `size`:
- `x == 0.0`: use remaining host window size
- `x > 0.0`: fixed size
- `x < 0.0`: use remaining window size minus abs(size)

Each axis can use a different mode, e.g. `ImVec2(0,400)`.

!!! note
    Always call a matching [`EndChild`](@ref) for each [`BeginChild`](@ref) call, regardless
    of its return value. This is due to legacy reason and is inconsistent with most other
    functions (such as [`BeginMenu`](@ref)/[`EndMenu`](@ref), [`BeginPopup`](@ref)/[`EndPopup`](@ref), etc.)
    where the `EndXXX` call should only be called if the corresponding `BeginXXX` function returned true.
"""
BeginChild(str_id, size=(0,0), border=false, flags=0) = igBeginChild_Str(str_id, size, border, flags)
BeginChild(id::Integer, size=(0,0), border=false, flags=0) = igBeginChild_ID(id, size, border, flags)

"""
    EndChild()
See also [`BeginChild`](@ref).
"""
EndChild() = igEndChild()

##################################### Windows Utilities ####################################
"""
    IsWindowAppearing() -> Bool
"""
IsWindowAppearing() = igIsWindowAppearing()

"""
    IsWindowCollapsed() -> Bool
"""
IsWindowCollapsed() = igIsWindowCollapsed()

"""
    IsWindowFocused(flags=0) -> Bool
Is current window focused? or its root/child, depending on flags.
See the output of `CImGui.GetFlags(CImGui.ImGuiFocusedFlags_)` for options:

```@eval
using CImGui, Markdown
CImGui.ShowFlags(CImGui.ImGuiFocusedFlags_) |> Markdown.parse
```
"""
IsWindowFocused(flags=0) = igIsWindowFocused(flags)

@deprecate IsAnyWindowFocused() IsWindowFocused(ImGuiFocusedFlags_AnyWindow)

"""
    IsWindowHovered(flags=0) -> Bool
Is current window hovered (and typically: not blocked by a popup/modal)?
See the output of `CImGui.GetFlags(CImGui.ImGuiHoveredFlags_)` for options:

```@eval
using CImGui, Markdown
CImGui.ShowFlags(CImGui.ImGuiHoveredFlags_) |> Markdown.parse
```

!!! note
    If you are trying to check whether your mouse should be dispatched to imgui or to your app,
    you should use the `ImGuiIO.WantCaptureMouse` boolean for that! Please read the FAQ!

!!! tip "FAQ"
    Q: How can I tell whether to dispatch mouse/keyboard to imgui or to my application?

    A: You can read the `ImGuiIO.WantCaptureMouse`, `ImGuiIO.WantCaptureKeyboard` and
    `ImGuiIO.WantTextInput` flags from the ImGuiIO structure, for example:
    ```
    if CImGui.Get_WantCaptureMouse(CImGui.GetIO())
        # ...
    end
    ```

    - When `ImGuiIO.WantCaptureMouse` is set, imgui wants to use your mouse state, and you
        may want to discard/hide the inputs from the rest of your application.
    - When `ImGuiIO.WantCaptureKeyboard` is set, imgui wants to use your keyboard state,
        and you may want to discard/hide the inputs from the rest of your application.
    - When `ImGuiIO.WantTextInput` is set to may want to notify your OS to popup an on-screen
        keyboard, if available (e.g. on a mobile phone, or console OS).

!!! note
    1. You should always pass your mouse/keyboard inputs to imgui, even when the
        `ImGuiIO.WantCaptureXXX` flag are set false. This is because imgui needs to detect that you
        clicked in the void to unfocus its own windows.
    2. The `ImGuiIO.WantCaptureMouse` is more accurate that any attempt to "check if the mouse
        is hovering a window" (don't do that!). It handle mouse dragging correctly (both dragging
        that started over your application or over an imgui window) and handle e.g. modal windows
        blocking inputs. Those flags are updated by [`NewFrame`](@ref). Preferably read the flags
        after calling [`NewFrame`](@ref) if you can afford it, but reading them before is also
        perfectly fine, as the bool toggle fairly rarely. If you have on a touch device, you
        might find use for an early call to `UpdateHoveredWindowAndCaptureFlags()`.
    3. Text input widget releases focus on "Return KeyDown", so the subsequent "Return KeyUp"
        event that your application receive will typically have `ImGuiIO.WantCaptureKeyboard=false`.
        Depending on your application logic it may or not be inconvenient. You might want to
        track which key-downs were targeted for Dear ImGui, e.g. with an array of bool, and
        filter out the corresponding key-ups.)
"""
IsWindowHovered(flags=0) = igIsWindowHovered(flags)

@deprecate IsAnyWindowHovered() IsWindowHovered(ImGuiHoveredFlags_AnyWindow)

"""
    GetWindowDrawList() -> Ptr{ImDrawList}
Return draw list associated to the window, to append your own drawing primitives.
"""
GetWindowDrawList() = igGetWindowDrawList()

"""
    GetWindowPos() -> ImVec2
Return current window position in screen space (useful if you want to do your own drawing
via the `ImDrawList` API.
"""
function GetWindowPos()
    x = Ref{ImVec2}()
    igGetWindowPos(x)
    return x[]
end

"""
    GetWindowSize() -> ImVec2
Return current window size.
"""
function GetWindowSize()
    x = Ref{ImVec2}()
    igGetWindowSize(x)
    return x[]
end

"""
    GetWindowWidth() -> Cfloat
Return current window width (shortcut for GetWindowSize().x).
"""
GetWindowWidth() = igGetWindowWidth()

"""
    GetWindowHeight() -> Cfloat
Return current window height (shortcut for GetWindowSize().y).
"""
GetWindowHeight() = igGetWindowHeight()

"""
    GetContentRegionMax() -> ImVec2
Return current content boundaries (typically window boundaries including scrolling,
or current column boundaries), in windows coordinates.
"""
function GetContentRegionMax()
    x = Ref{ImVec2}()
    igGetContentRegionMax(x)
    return x[]
end

"""
    GetContentRegionAvail() -> ImVec2
Return [`GetContentRegionMax`](@ref) - [`GetCursorPos`](@ref).
"""
function GetContentRegionAvail()
    x = Ref{ImVec2}()
    igGetContentRegionAvail(x)
    return x[]
end

@deprecate GetContentRegionAvailWidth() GetContentRegionAvail().x

"""
    GetWindowContentRegionMin() -> ImVec2
Return content boundaries min (roughly (0,0)-Scroll), in window coordinates.
"""
function GetWindowContentRegionMin()
    x = Ref{ImVec2}()
    igGetWindowContentRegionMin(x)
    return x[]
end

"""
    GetWindowContentRegionMax() -> ImVec2
Return content boundaries max (roughly (0,0)+Size-Scroll) where Size can be
override with [`SetNextWindowContentSize`](@ref), in window coordinates.
"""
function GetWindowContentRegionMax()
    x = Ref{ImVec2}()
    igGetWindowContentRegionMax(x)
    return x[]
end

"""
    GetWindowContentRegionWidth() -> ImVec2
"""
GetWindowContentRegionWidth() = GetWindowContentRegionMax().x - GetWindowContentRegionMin().x

"""
    SetNextWindowPos(pos, cond=0, pivot=(0,0))
Set next window position. Call before [`Begin`](@ref). use `pivot=(0.5,0.5)` to center on given point, etc.
"""
SetNextWindowPos(pos, cond=0, pivot=ImVec2(0,0)) = igSetNextWindowPos(pos, cond, pivot)

"""
    SetNextWindowSize(size, cond=0)
Set next window size. Set axis to 0.0 to force an auto-fit on this axis. Call before [`Begin`](@ref).
"""
SetNextWindowSize(size, cond=0) = igSetNextWindowSize(size, cond)

"""
    SetNextWindowSizeConstraints(size_min, size_max, custom_callback=C_NULL, custom_callback_data=C_NULL)
Set next window size limits. Use `-1,-1` on either X/Y axis to preserve the current size.
Use callback to apply non-trivial programmatic constraints.
"""
SetNextWindowSizeConstraints(size_min, size_max, custom_callback=C_NULL, custom_callback_data=C_NULL) = igSetNextWindowSizeConstraints(size_min, size_max, custom_callback, custom_callback_data)

"""
    SetNextWindowContentSize(size)
    SetNextWindowContentSize(x, y)
Set next window content size (~ enforce the range of scrollbars). Not including window decorations
(title bar, menu bar, etc.). Set an axis to `0.0` to leave it automatic. Call before [`Begin`](@ref).
"""
SetNextWindowContentSize(size) = igSetNextWindowContentSize(size)
SetNextWindowContentSize(x, y) = SetNextWindowContentSize(ImVec2(x,y))

"""
    SetNextWindowCollapsed(collapsed, cond=0)
Set next window collapsed state. Call before [`Begin`](@ref).
"""
SetNextWindowCollapsed(collapsed, cond=0) = igSetNextWindowCollapsed(collapsed, cond)

"""
    SetNextWindowFocus()
Set next window to be focused / front-most. Call before [`Begin`](@ref).
"""
SetNextWindowFocus() = igSetNextWindowFocus()

"""
    SetNextWindowBgAlpha(alpha)
Set next window background color alpha. Helper to easily modify `ImGuiCol_WindowBg/ChildBg/PopupBg`.
You may also use `ImGuiWindowFlags_NoBackground`.
"""
SetNextWindowBgAlpha(alpha) = igSetNextWindowBgAlpha(alpha)

"""
    SetWindowPos(pos, cond=0)
Set current window position - call within [`Begin`](@ref)/[`End`](@ref).

!!! warning "Not recommended!"
    This function is not recommended! Prefer using [`SetNextWindowPos`](@ref), as this may
    incur tearing and side-effects.
"""
SetWindowPos(pos, cond=0) = igSetWindowPos_Vec2(pos, cond)

"""
    SetWindowSize(size, cond=0)
Set current window size - call within [`Begin`](@ref)/[`End`](@ref). Set to `(0,0)` to force
an auto-fit.

!!! warning "Not recommended!"
    This function is not recommended! Prefer using [`SetNextWindowSize`](@ref), as this may
    incur tearing and minor side-effects.
"""
SetWindowSize(size, cond=0) = igSetWindowSize_Vec2(size, cond)

"""
    SetWindowCollapsedBool(collapsed, cond=0)
Set current window collapsed state.

!!! warning "Not recommended!"
    This function is not recommended! Prefer using [`SetNextWindowCollapsed`](@ref).
"""
SetWindowCollapsed(collapsed, cond=0) = igSetWindowCollapsed_Bool(collapsed, cond)

"""
    SetWindowFocus()
Set current window to be focused / top-most.

!!! warning "Not recommended!"
    This function is not recommended! Prefer using [`SetNextWindowFocus`](@ref).
"""
SetWindowFocus() = igSetWindowFocus_Nil()

"""
    SetWindowFontScale(scale)
Set font scale. Adjust `ImGuiIO.FontGlobalScale` if you want to scale all windows.
"""
SetWindowFontScale(scale) = igSetWindowFontScale(scale)

"""
    SetWindowPosStr(name::AbstractString, pos, cond=0)
Set named window position.
"""
SetWindowPos(name::AbstractString, pos, cond=0) = igSetWindowPos_Str(name, pos, cond)

"""
    SetWindowSizeStr(name::AbstractString, size, cond=0)
Set named window size. Set axis to `0.0` to force an auto-fit on this axis.
"""
SetWindowSize(name::AbstractString, size, cond=0) = igSetWindowSize_Str(name, size, cond)

"""
    SetWindowCollapsed(name::AbstractString, collapsed, cond=0)
Set named window collapsed state.
"""
SetWindowCollapsed(name::AbstractString, collapsed, cond=0) = igSetWindowCollapsed_Str(name, collapsed, cond)

"""
    SetWindowFocus(name::Ptr{Cvoid})
    SetWindowFocus(name::AbstractString)
Set named window to be focused / front-most. Use `C_NULL` to remove focus.
"""
SetWindowFocus(name::Ptr{Cvoid}) = igSetWindowFocus_Str(name)
SetWindowFocus(name::AbstractString) = igSetWindowFocus_Str(name)


##################################### Windows Scrolling ####################################
"""
    GetScrollX() -> Cfloat
Return scrolling amount [0..GetScrollMaxX()]. See also [`GetScrollMaxX`](@ref).
"""
GetScrollX() = igGetScrollX()

"""
    GetScrollY() -> Cfloat
Return scrolling amount [0..GetScrollMaxY()].
"""
GetScrollY() = igGetScrollY()

"""
    GetScrollMaxX() -> Cfloat
Return maximum scrolling amount ~~ ContentSize.X - WindowSize.X.
"""
GetScrollMaxX() = igGetScrollMaxX()

"""
    GetScrollMaxY() -> Cfloat
Return maximum scrolling amount ~~ ContentSize.Y - WindowSize.Y.
"""
GetScrollMaxY() = igGetScrollMaxY()

"""
    SetScrollX(scroll_x)
Set scrolling amount [0..GetScrollMaxX()].
"""
SetScrollX(scroll_x) = igSetScrollXFloat(scroll_x)

"""
    SetScrollY(scroll_y)
Set scrolling amount [0..GetScrollMaxY()].
"""
SetScrollY(scroll_y) = igSetScrollYFloat(scroll_y)

"""
    SetScrollHereY(center_y_ratio=0.5)
Adjust scrolling amount to make current cursor position visible.
- `center_y_ratio == 0.0`: top
- `center_y_ratio == 0.5`: center
- `center_y_ratio == 1.0`: bottom

When using to make a "default/current item" visible, consider using [`SetItemDefaultFocus`](@ref) instead.
"""
SetScrollHereY(center_y_ratio=0.5) = igSetScrollHereY(center_y_ratio)

@deprecate SetScrollHere(center_ratio) SetScrollHereY(center_ratio)

"""
    SetScrollFromPosX(local_y, center_y_ratio=0.5)
Adjust scrolling amount to make given position visible.
Generally [`GetCursorStartPos`](@ref) + offset to compute a valid position.
"""
SetScrollFromPosX(local_y, center_y_ratio=0.5) = igSetScrollFromPosX_Float(local_y, center_y_ratio)

"""
    SetScrollFromPosY(local_y, center_y_ratio=0.5)
Adjust scrolling amount to make given position visible.
Generally [`GetCursorStartPos`](@ref) + offset to compute a valid position.
"""
SetScrollFromPosY(local_y, center_y_ratio=0.5) = igSetScrollFromPosY_Float(local_y, center_y_ratio)

################################ Parameters stacks (shared) ################################
"""
    PushFont(font)
Use C_NULL as a shortcut to push default font.
"""
PushFont(font) = igPushFont(font)

"""
    PopFont()
See [`PushFont`](@ref).
"""
PopFont() = igPopFont()

"""
    PushStyleColor(idx, col)
    PushStyleColor(idx, col::Integer)
See also [`GetStyleColorVec4`](@ref), [`TextColored`](@ref), [`TextDisabled`](@ref).
"""
PushStyleColor(idx, col) = igPushStyleColor_Vec4(idx, col)
PushStyleColor(idx, col::Integer) = igPushStyleColor_U32(idx, col)

"""
    PopStyleColor(count=1)
See [`PushStyleColor`](@ref).
"""
PopStyleColor(count=1) = igPopStyleColor(count)

"""
    PushStyleVar(idx, val)
    PushStyleVar(idx, val::Real)
See also [`GetStyle`](@ref).
"""
PushStyleVar(idx, val) = igPushStyleVar_Vec2(idx, val)
PushStyleVar(idx, val::Real) = igPushStyleVar_Float(idx, val)

"""
    PopStyleVar(count=1)
See [`PushStyleVar`](@ref).
"""
PopStyleVar(count=1) = igPopStyleVar(count)

"""
    GetStyleColorVec4(idx) -> ImVec4
Retrieve style color as stored in [`ImGuiStyle`] structure. Use to feed back into [`PushStyleColor`](@ref),
otherwise use [`GetColorU32`](@ref) to get style color with style alpha baked in.
"""
GetStyleColorVec4(idx) = igGetStyleColorVec4(idx)

"""
    GetFont() -> Ptr{ImFont}
Get current font.
"""
GetFont() = igGetFont()

"""
    GetFontSize() -> Cfloat
Get current font size (= height in pixels) of current font with current scale applied.
"""
GetFontSize() = igGetFontSize()

"""
    GetFontTexUvWhitePixel() -> ImVec2
Get UV coordinate for a while pixel, useful to draw custom shapes via the `ImDrawList` API.
"""
function GetFontTexUvWhitePixel()
    x = Ref{ImVec2}()
    igGetFontTexUvWhitePixel(x)
    return x[]
end

"""
    GetColorU32(r, g, b, a) -> ImU32
    GetColorU32(col::ImVec4) -> ImU32
    GetColorU32(col::ImU32) -> ImU32
    GetColorU32(idx::Integer, alpha_mul=1.0) -> ImU32
Retrieve given style color with style alpha applied and optional extra alpha multiplier.
"""
GetColorU32(idx::Integer, alpha_mul=1.0) = igGetColorU32_Col(idx, alpha_mul)
GetColorU32(col::ImVec4) = igGetColorU32_Vec4(col)
GetColorU32(r, g, b, a) = GetColorU32(ImVec4(r,g,b,a))
GetColorU32(col::ImU32) = igGetColorU32_U32(col)
GetColorU32(col::Cenum) = GetColorU32(Int(col))

############################ Parameters stacks (current window) ############################
"""
    PushItemWidth(item_width)
Push width of items for the common item+label case, pixels:
- `item_width == 0`: default to ~2/3 of windows width
- `item_width > 0`: width in pixels
- `item_width < 0`: align xx pixels to the right of window (so `-1.0` always align width to the right side)
"""
PushItemWidth(item_width) = igPushItemWidth(item_width)

"""
    PopItemWidth()
See [`PushItemWidth`](@ref).
"""
PopItemWidth() = igPopItemWidth()

"""
    SetNextItemWidth(item_width)
Set width of the _next_ common large "item+label" widget.
- `item_width > 0.0`: width in pixels
- `item_width < 0.0`: align xx pixels to the right of window (so `-1.0` always align width to the right side)
"""
SetNextItemWidth(item_width) = igSetNextItemWidth(item_width)

"""
    CalcItemWidth() -> Cfloat
Return width of item given pushed settings and current cursor position.
"""
CalcItemWidth() = igCalcItemWidth()

"""
    PushTextWrapPos(wrap_pos_x=0.0)
Word-wrapping for `Text*()` commands:
- `wrap_pos_x < 0`: no wrapping
- `wrap_pos_x == 0`: wrap to end of window (or column)
- `wrap_pos_x > 0`: wrap at `wrap_pos_x` position in window local space
"""
PushTextWrapPos(wrap_local_pos_x=0.0) = igPushTextWrapPos(wrap_local_pos_x)

"""
    PopTextWrapPos()
See [`PushTextWrapPos`](@ref).
"""
PopTextWrapPos() = igPopTextWrapPos()

"""
    PushTabStop(allow_keyboard_focus)
Allow focusing using `TAB`/`Shift-TAB`, enabled by default but you can disable it for certain widgets.
"""
PushTabStop(allow_keyboard_focus) = igPushTabStop(allow_keyboard_focus)
@deprecate PushAllowKeyboardFocus(focus) PushTabStop(focus)

"""
    PopTabStop()
"""
PopTabStop() = igPopTabStop()
@deprecate PopAllowKeyboardFocus() PopTabStop()

"""
    PushButtonRepeat(repeat)
In "repeat" mode, `Button*()` functions return repeated true in a typematic manner (using
`ImGuiIO.KeyRepeatDelay/ImGuiIO.KeyRepeatRate setting`). Note that you can call [`IsItemActive`](@ref)
after any `Button()` to tell if the button is held in the current frame.
"""
PushButtonRepeat(repeat) = igPushButtonRepeat(repeat)

"""
    PopButtonRepeat()
See [`PushButtonRepeat`](@ref).
"""
PopButtonRepeat() = igPopButtonRepeat()

###################################### Cursor / Layout #####################################
"""
    Separator()
Separator, generally horizontal. But inside a menu bar or in horizontal layout mode,
it becomes a vertical separator.
"""
Separator() = igSeparator()

"""
    SameLine(local_pos_x=0.0, spacing_w=-1.0)
Call this function between widgets or groups to layout them horizontally.
"""
SameLine(local_pos_x=0.0, spacing_w=-1.0) = igSameLine(local_pos_x, spacing_w)

"""
    NewLine()
Undo a [`SameLine`](@ref).
"""
NewLine() = igNewLine()

"""
    Spacing()
Add vertical spacing.
"""
Spacing() = igSpacing()

"""
    Dummy(size)
    Dummy(x, y)
Add a dummy item of given size.
"""
Dummy(size) = igDummy(size)
Dummy(x, y) = Dummy(ImVec2(x,y))

"""
    Indent()
    Indent(indent_w)
Move content position toward the right, by `ImGuiStyle.IndentSpacing` or `indent_w` if `indent_w != 0`.
"""
Indent(indent_w=Cfloat(0.0)) = igIndent(indent_w)

"""
    Unindent()
    Unindent(indent_w)
Move content position back to the left, by `ImGuiStyle.IndentSpacing` or `indent_w` if `indent_w != 0`.
"""
Unindent(indent_w=Cfloat(0.0)) = igUnindent(indent_w)

"""
    BeginGroup()
Lock horizontal starting position + capture group bounding box into one "item", so you can
use [`IsItemHovered`](@ref) or layout primitives such as [`SameLine`](@ref) on whole group, etc.
"""
BeginGroup() = igBeginGroup()

"""
    EndGroup()
See [`BeginGroup`](@ref).
"""
EndGroup() = igEndGroup()

"""
    GetCursorPos() -> ImVec2
Return cursor position which is relative to window position.
"""
function GetCursorPos()
    x = Ref{ImVec2}()
    igGetCursorPos(x)
    return x[]
end

"""
    GetCursorPosX() -> Cfloat
"""
GetCursorPosX() = igGetCursorPosX()

"""
    GetCursorPosY() -> Cfloat
"""
GetCursorPosY() = igGetCursorPosY()

"""
    SetCursorPos(x, y)
    SetCursorPos(local_pos)
"""
SetCursorPos(local_pos) = igSetCursorPos(local_pos)
SetCursorPos(x, y) = SetCursorPos(ImVec2(x,y))

"""
    SetCursorPosX(local_x)
"""
SetCursorPosX(local_x) = igSetCursorPosX(local_x)

"""
    SetCursorPosX(local_y)
"""
SetCursorPosY(local_y) = igSetCursorPosY(local_y)

"""
    GetCursorStartPos() -> ImVec2
Return initial cursor position in window coordinates.
"""
function GetCursorStartPos()
    x = Ref{ImVec2}()
    igGetCursorStartPos(x)
    return x[]
end

"""
    GetCursorScreenPos() -> ImVec2
Return cursor position in absolute screen coordinates [0..io.DisplaySize].
This is useful to work with `ImDrawList` API.
"""
function GetCursorScreenPos()
    x = Ref{ImVec2}()
    igGetCursorScreenPos(x)
    return x[]
end

"""
    SetCursorScreenPos(pos)
    SetCursorScreenPos(x, y)
Set cursor position in absolute screen coordinates [0..io.DisplaySize].
"""
SetCursorScreenPos(pos) = igSetCursorScreenPos(pos)
SetCursorScreenPos(x, y) = SetCursorScreenPos(ImVec2(x,y))

"""
    AlignTextToFramePadding()
Vertically align upcoming text baseline to `FramePadding.y` so that it will align properly to
regularly framed items (call if you have text on a line before a framed item).
"""
AlignTextToFramePadding() = igAlignTextToFramePadding()

"""
    GetTextLineHeight() -> Cfloat
Return `FontSize`.
"""
GetTextLineHeight() = igGetTextLineHeight()

"""
    GetTextLineHeightWithSpacing() -> Cfloat
Return `FontSize + ImGuiStyle.ItemSpacing.y` (distance in pixels between 2 consecutive lines of text).
"""
GetTextLineHeightWithSpacing() = igGetTextLineHeightWithSpacing()

"""
    GetFrameHeight() -> Cfloat
Return `FontSize + ImGuiStyle.FramePadding.y * 2`.
"""
GetFrameHeight() = igGetFrameHeight()

"""
    GetFrameHeightWithSpacing() -> Cfloat
Return `FontSize + ImGuiStyle.FramePadding.y * 2 + ImGuiStyle.ItemSpacing.y` (distance
in pixels between 2 consecutive lines of framed widgets).
"""
GetFrameHeightWithSpacing() = igGetFrameHeightWithSpacing()

###################################### ID stack/scopes #####################################
"""
    PushID(ptr_id::Ptr)
    PushID(int_id::Integer)
    PushID(str_id::AbstractString)
    PushID(str_id_begin::AbstractString, str_id_end::AbstractString)
Push identifier into the ID stack. IDs are hash of the entire stack!

!!! note
    Read the FAQ for more details about how ID are handled in dear imgui. If you are creating
    widgets in a loop you most likely want to push a unique identifier (e.g. object pointer, loop index)
    to uniquely differentiate them. You can also use the "##foobar" syntax within widget label
    to distinguish them from each others.

!!! tip "FAQ"
    Q: How can I have multiple widgets with the same label or without a label?

    Q: I have multiple widgets with the same label, and only the first one works. Why is that?

    A: A primer on labels and the ID Stack...

    Dear ImGui internally need to uniquely identify UI elements.
    Elements that are typically not clickable (such as calls to the Text functions) don't need an ID.
    Interactive widgets (such as calls to Button buttons) need a unique ID.
    Unique ID are used internally to track active widgets and occasionally associate state to widgets.
    Unique ID are implicitly built from the hash of multiple elements that identify the "path" to the UI element.
    -  Unique ID are often derived from a string label:
    ```
    CImGui.Button("OK")          # Label = "OK",     ID = hash of (..., "OK")
    CImGui.Button("Cancel")      # Label = "Cancel", ID = hash of (..., "Cancel")
    ```
    - ID are uniquely scoped within windows, tree nodes, etc. which all pushes to the ID stack.
        Having two buttons labeled "OK" in different windows or different tree locations is fine.
        We used "..." above to signify whatever was already pushed to the ID stack previously:
    ```
    CImGui.Begin("MyWindow")
    CImGui.Button("OK")          # Label = "OK",     ID = hash of ("MyWindow", "OK")
    CImGui.End()
    ```
    - If you have a same ID twice in the same location, you'll have a conflict:
    ```
    CImGui.Button("OK")
    CImGui.Button("OK")          # ID collision! Interacting with either button will trigger the first one.
    ```

    Fear not! this is easy to solve and there are many ways to solve it!

    - Solving ID conflict in a simple/local context:
        When passing a label you can optionally specify extra ID information within string itself.
        Use `##` to pass a complement to the ID that won't be visible to the end-user.
        This helps solving the simple collision cases when you know e.g. at compilation time which items
        are going to be created:
    ```
    CImGui.Begin("MyWindow")
    CImGui.Button("Play")        # Label = "Play",   ID = hash of ("MyWindow", "Play")
    CImGui.Button("Play##foo1")  # Label = "Play",   ID = hash of ("MyWindow", "Play##foo1")  # Different from above
    CImGui.Button("Play##foo2")  # Label = "Play",   ID = hash of ("MyWindow", "Play##foo2")  # Different from above
    CImGui.End()
    ```
    - If you want to completely hide the label, but still need an ID:
    ```
    CImGui.Checkbox("##On", &b)  # Label = "", ID = hash of (..., "##On") # No visible label, just a checkbox!
    ```
    - Occasionally/rarely you might want change a label while preserving a constant ID. This allows
     you to animate labels. For example you may want to include varying information in a window title bar,
     but windows are uniquely identified by their ID. Use `###` to pass a label that isn't part of ID:
    ```
    CImGui.Button("Hello###ID")  # Label = "Hello",  ID = hash of (..., "ID")
    CImGui.Button("World###ID")  # Label = "World",  ID = hash of (..., "ID") # Same as above, even though the label looks different
    buf = @sprintf("My game (%f FPS)###MyGame", fps)
    CImGui.Begin(buf)            # Variable title,   ID = hash of "MyGame"
    ```
    - Solving ID conflict in a more general manner:
     Use `PushID()` / `PopID()` to create scopes and manipulate the ID stack, as to avoid ID conflicts
     within the same window. This is the most convenient way of distinguishing ID when iterating and
     creating many UI elements programmatically.
     You can push a pointer, a string or an integer value into the ID stack.
     Remember that ID are formed from the concatenation of _everything_ in the ID stack!
    ```
    CImGui.Begin("Window")
    for i = 0:100-1
        CImGui.PushID(i)         # Push i to the id tack
        CImGui.Button("Click")   # Label = "Click",  ID = Hash of ("Window", i, "Click")
        CImGui.PopID()
    end
    End()
    ```
    - More example showing that you can stack multiple prefixes into the ID stack:
    ```
    CImGui.Button("Click")       # Label = "Click",  ID = hash of (..., "Click")
    CImGui.PushID("node")
    CImGui.Button("Click")       # Label = "Click",  ID = hash of (..., "node", "Click")
        CImGui.PushID(my_ptr)
        CImGui.Button("Click") # Label = "Click",  ID = hash of (..., "node", my_ptr, "Click")
        CImGui.PopID()
    CImGui.PopID()
    ```
    - Tree nodes implicitly creates a scope for you by calling `PushID()`.
    ```
    CImGui.Button("Click")     # Label = "Click",  ID = hash of (..., "Click")
    if CImGui.TreeNode("node")
        CImGui.Button("Click") # Label = "Click",  ID = hash of (..., "node", "Click")
        CImGui.TreePop()
    end
    ```
    - When working with trees, ID are used to preserve the open/close state of each tree node.
        Depending on your use cases you may want to use strings, indices or pointers as ID.
        * e.g. when following a single pointer that may change over time, using a static string as ID
            will preserve your node open/closed state when the targeted object change.
        * e.g. when displaying a list of objects, using indices or pointers as ID will preserve the
            node open/closed state differently. See what makes more sense in your situation!
"""
PushID(str_id::AbstractString) = igPushID_Str(str_id)
PushID(str_id_begin::AbstractString, str_id_end::AbstractString) = igPushID_StrStr(str_id_begin, str_id_end)
PushID(ptr_id::Ptr) = igPushID_Ptr(ptr_id)
PushID(int_id::Integer) = igPushID_Int(int_id)

"""
    PopID()
See [`PushID`](@ref).
"""
PopID() = igPopID()

"""
    GetID(str_id::AbstractString) -> ImGuiID
    GetID(str_id_begin::AbstractString, str_id_end::AbstractString) -> ImGuiID
    GetID(ptr_id::Ptr) -> ImGuiID
Calculate unique ID (hash of whole ID stack + given parameter). e.g. if you want to query
into `ImGuiStorage` yourself.
"""
GetID(str_id::AbstractString) = igGetID_Str(str_id)
GetID(str_id_begin::AbstractString, str_id_end::AbstractString) = igGetID_StrStr(str_id_begin, str_id_end)
GetID(ptr_id::Ptr) = igGetID_Ptr(ptr_id)

####################################### Widgets: Text ######################################
"""
    TextUnformatted(text, text_end=C_NULL)
Raw text without formatting. Roughly equivalent to `Text("%s", text)` but:
1. doesn't require null terminated string if `text_end` is specified;
2. it's faster, no memory copy is done, no buffer size limits, recommended for long chunks of text.
"""
TextUnformatted(text, text_end=C_NULL) = igTextUnformatted(text, text_end)

"""
    Text(formatted_text)
Create a text widget.

!!! warning "Limited support"
    Formatting is not supported which means you need to pass a formatted string to this function.
    It's recommended to use Julia stdlib `Printf`'s `@sprintf` as a workaround when translating C/C++ code to Julia.
"""
function Text(formatted_text)
    @static if Sys.isapple()
        # Workaround for segfault on MacOS
        # TODO: Fix https://github.com/Gnimuc/CImGui.jl/issues/74
        TextUnformatted(formatted_text)
    else
        igText(formatted_text)
    end
end

"""
    TextColored(col, formatted_text)
Shortcut for `PushStyleColor(ImGuiCol_Text, col); Text(text); PopStyleColor();`.

!!! warning "Limited support"
    Formatting is not supported which means you need to pass a formatted string to this function.
    It's recommended to use Julia stdlib `Printf`'s `@sprintf` as a workaround when translating C/C++ code to Julia.
"""
TextColored(col, formatted_text) = igTextColored(col, formatted_text)

"""
    TextDisabled(formatted_text)
Shortcut for `PushStyleColor(ImGuiCol_Text, style.Colors[ImGuiCol_TextDisabled]); Text(text); PopStyleColor();`.
!!! warning "Limited support"
    Formatting is not supported which means you need to pass a formatted string to this function.
    It's recommended to use Julia stdlib `Printf`'s `@sprintf` as a workaround when translating C/C++ code to Julia.
"""
TextDisabled(formatted_text) = igTextDisabled(formatted_text)

"""
    TextWrapped(formatted_text)
Shortcut for `PushTextWrapPos(0.0f); Text(text); PopTextWrapPos();`.
Note that this won't work on an auto-resizing window if there's no other widgets to extend
the window width, yoy may need to set a size using [`SetNextWindowSize`](@ref).

!!! warning "Limited support"
    Formatting is not supported which means you need to pass a formatted string to this function.
    It's recommended to use Julia stdlib `Printf`'s `@sprintf` as a workaround when translating C/C++ code to Julia.
"""
TextWrapped(formatted_text) = igTextWrapped(formatted_text)

"""
    LabelText(label, formatted_text)
Display text+label aligned the same way as value+label widgets.

!!! warning "Limited support"
    Formatting is not supported which means you need to pass a formatted string to this function.
    It's recommended to use Julia stdlib `Printf`'s `@sprintf` as a workaround when translating C/C++ code to Julia.
"""
LabelText(label, formatted_text) = igLabelText(label, formatted_text)

"""
    BulletText(formatted_text)
Shortcut for [`Bullet`](@ref)+[`Text`](@ref).

!!! warning "Limited support"
    Formatting is not supported which means you need to pass a formatted string to this function.
    It's recommended to use Julia stdlib `Printf`'s `@sprintf` as a workaround when translating C/C++ code to Julia.
"""
BulletText(formatted_text) = igBulletText(formatted_text)

####################################### Widgets: Main ######################################
"""
    Button(label) -> Bool
    Button(label, size) -> Bool
Return true when the value has been changed or when pressed/selected.
"""
Button(label, size=ImVec2(0,0)) = igButton(label, size)

"""
    SmallButton(label) -> Bool
Return true when the value has been changed or when pressed/selected. It creates a button
with `FramePadding=(0,0)` to easily embed within text.
"""
SmallButton(label) = igSmallButton(label)

"""
    InvisibleButton(str_id, size, flag = 0) -> Bool
Return true when the value has been changed or when pressed/selected.
Flexible button behavior without the visuals, frequently useful to build custom behaviors using
the public api along with [`IsItemActive`](@ref), [`IsItemHovered`](@ref), etc.
"""
InvisibleButton(str_id, size, flag = 0) = igInvisibleButton(str_id, size, flag)

"""
    ArrowButton(str_id, dir) -> Bool
Return true when the value has been changed or when pressed/selected. Create a square button
with an arrow shape.
"""
ArrowButton(str_id, dir) = igArrowButton(str_id, dir)

"""
    Image(user_texture_id, size, uv0=(0,0), uv1=(1,1), tint_col=(1,1,1,1), border_col=(0,0,0,0))
"""
Image(user_texture_id, size, uv0=ImVec2(0,0), uv1=ImVec2(1,1), tint_col=ImVec4(1,1,1,1), border_col=ImVec4(0,0,0,0)) = igImage(user_texture_id, size, uv0, uv1, tint_col, border_col)

"""
    ImageButton(str_id, user_texture_id, size, uv0=(0,0), uv1=(1,1), bg_col=(0,0,0,0), tint_col=(1,1,1,1)) -> Bool
"""
ImageButton(str_id, user_texture_id, size, uv0=ImVec2(0,0), uv1=ImVec2(1,1), bg_col=ImVec4(0,0,0,0), tint_col=ImVec4(1,1,1,1)) = igImageButton(str_id, user_texture_id, size, uv0, uv1, bg_col, tint_col)

"""
    Checkbox(label, v) -> Bool
Return true when the value has been changed or when pressed/selected.
"""
Checkbox(label, v) = igCheckbox(label, v)

"""
    CheckboxFlags(label, flags, flags_value) -> Bool
Return true when the value has been changed or when pressed/selected.
"""
CheckboxFlags(label, flags::Ref{Cint}, flags_value) = igCheckboxFlags_IntPtr(label, flags, flags_value)
CheckboxFlags(label, flags::Ref{Cuint}, flags_value) = igCheckboxFlags_UintPtr(label, flags, flags_value)

"""
    RadioButton(label, active::Bool) -> Bool
    RadioButton(label, v::Ref, v_button::Integer) -> Bool
Return true when the value has been changed or when pressed/selected.

### Example
```julia
if RadioButton("one", my_value==1)
    my_value = 1
end
```
"""
RadioButton(label, active::Bool) = igRadioButton_Bool(label, active)
RadioButton(label, v::Ref, v_button::Integer) = igRadioButton_IntPtr(label, v, v_button)

"""
    ProgressBar(fraction, size_arg=(-1,0), overlay=C_NULL)
"""
ProgressBar(fraction, size_arg=ImVec2(-1,0), overlay=C_NULL) = igProgressBar(fraction, size_arg, overlay)

"""
    Bullet()
Draw a small circle and keep the cursor on the same line.
advance cursor x position by GetTreeNodeToLabelSpacing(), same distance that TreeNode() uses
"""
Bullet() = igBullet()

#################################### Widgets: Combo Box ####################################
"""
    BeginCombo(label, preview_value, flags=0) -> Bool
The new [`BeginCombo`](@ref)/[`EndCombo`](@ref) api allows you to manage your contents and
selection state however you want it, by creating e.g. [`Selectable`](@ref) items.
"""
BeginCombo(label, preview_value, flags=0) = igBeginCombo(label, preview_value, flags)

"""
    EndCombo()
!!! note
    Only call `EndCombo` if [`BeginCombo`](@ref) returns true!

See also [`BeginCombo`](@ref).
"""
EndCombo() = igEndCombo()

"""
    Combo(label, current_item, items::Vector, items_count, popup_max_height_in_items=-1) -> Bool
The old [`Combo`](@ref) api are helpers over [`BeginCombo`](@ref)/[`EndCombo`](@ref) which
are kept available for convenience purpose.
"""
Combo(label, current_item, items::Vector, items_count, popup_max_height_in_items=-1) = igCombo_Str_arr(label, current_item, items, items_count, popup_max_height_in_items)

"""
    Combo(label, current_item, items_separated_by_zeros, popup_max_height_in_items=-1) -> Bool
Separate items with `\0` within a string, end item-list with `\0\0`. e.g. `One\0Two\0Three\0`
"""
Combo(label, current_item, items_separated_by_zeros, popup_max_height_in_items=-1) = igCombo_Str(label, current_item, items_separated_by_zeros, popup_max_height_in_items)

"""
    Combo(label, current_item, items_getter::Union{Ptr,Base.CFunction}, data, items_count, popup_max_height_in_items=-1) -> Bool
"""
Combo(label, current_item, items_getter::Union{Ptr,Base.CFunction}, data, items_count, popup_max_height_in_items=-1) = igCombo_FnBoolPtr(label, current_item, items_getter, data, items_count, popup_max_height_in_items)

###################################### Widgets: Drags ######################################
"""
    DragFloat(label, v, v_speed=1.0, v_min=0.0, v_max=0.0, format="%.3f", flag=0) -> Bool
If `v_min` >= `v_max` we have no bound.
"""
DragFloat(label, v, v_speed=1.0, v_min=0.0, v_max=0.0, format="%.3f", flag=0) = igDragFloat(label, v, v_speed, v_min, v_max, format, flag)
@deprecate DragFloat(label, v, v_speed, v_min, v_max, format, power::AbstractFloat) DragFloat(label, v, v_speed, v_min, v_max, format, 0)

"""
    DragFloat2(label, v, v_speed=1.0, v_min=0.0, v_max=0.0, format="%.3f", flag=0) -> Bool
The expected number of elements to be accessible in `v` is 2.
"""
DragFloat2(label, v, v_speed=1.0, v_min=0.0, v_max=0.0, format="%.3f", flag=0) = igDragFloat2(label, v, v_speed, v_min, v_max, format, flag)
@deprecate DragFloat2(label, v, v_speed, v_min, v_max, format, power::AbstractFloat) DragFloat2(label, v, v_speed, v_min, v_max, format, 0)

"""
    DragFloat3(label, v, v_speed=1.0, v_min=0.0, v_max=0.0, format="%.3f", flag=0) -> Bool
The expected number of elements to be accessible in `v` is 3.
"""
DragFloat3(label, v, v_speed=1.0, v_min=0.0, v_max=0.0, format="%.3f", flag=0) = igDragFloat3(label, v, v_speed, v_min, v_max, format, flag)
@deprecate DragFloat3(label, v, v_speed, v_min, v_max, format, power::AbstractFloat) DragFloat3(label, v, v_speed, v_min, v_max, format, 0)

"""
    DragFloat4(label, v, v_speed=1.0, v_min=0.0, v_max=0.0, format="%.3f", flag=0) -> Bool
The expected number of elements to be accessible in `v` is 4.
"""
DragFloat4(label, v, v_speed=1.0, v_min=0.0, v_max=0.0, format="%.3f", flag=0) = igDragFloat4(label, v, v_speed, v_min, v_max, format, flag)
@deprecate DragFloat4(label, v, v_speed, v_min, v_max, format, power::AbstractFloat) DragFloat4(label, v, v_speed, v_min, v_max, format, 0)

"""
    DragFloatRange2(label, v_current_min, v_current_max, v_speed=1.0, v_min=0.0, v_max=0.0, format="%.3f", format_max=C_NULL, flag=0) -> Bool
"""
DragFloatRange2(label, v_current_min, v_current_max, v_speed=1.0, v_min=0.0, v_max=0.0, format="%.3f", format_max=C_NULL, flag=0) = igDragFloatRange2(label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max, flag)
@deprecate DragFloatRange2(label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max, power::AbstractFloat) DragFloatRange2(label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max, 0)

"""
    DragInt(label, v, v_speed=1.0, v_min=0, v_max=0, format="%d", flag=0)
"""
DragInt(label, v, v_speed=1.0, v_min=0, v_max=0, format="%d", flag=0) = igDragInt(label, v, v_speed, v_min, v_max, format, flag)

"""
    DragInt2(label, v, v_speed=1.0, v_min=0, v_max=0, format="%d", flag=0)
The expected number of elements to be accessible in `v` is 2.
"""
DragInt2(label, v, v_speed=1.0, v_min=0, v_max=0, format="%d", flag=0) = igDragInt2(label, v, v_speed, v_min, v_max, format, flag)

"""
    DragInt3(label, v, v_speed=1.0, v_min=0, v_max=0, format="%d", flag=0)
The expected number of elements to be accessible in `v` is 3.
"""
DragInt3(label, v, v_speed=1.0, v_min=0, v_max=0, format="%d", flag=0) = igDragInt3(label, v, v_speed, v_min, v_max, format, flag)

"""
    DragInt4(label, v, v_speed=1.0, v_min=0, v_max=0, format="%d", flag=0)
The expected number of elements to be accessible in `v` is 4.
"""
DragInt4(label, v, v_speed=1.0, v_min=0, v_max=0, format="%d", flag=0) = igDragInt4(label, v, v_speed, v_min, v_max, format, flag)

"""
    DragIntRange2(label, v_current_min, v_current_max, v_speed=1.0, v_min=0, v_max=0, format="%d", format_max=C_NULL, flag=0)
"""
DragIntRange2(label, v_current_min, v_current_max, v_speed=1.0, v_min=0, v_max=0, format="%d", format_max=C_NULL, flag=0) = igDragIntRange2(label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max, flag)

"""
    DragScalar(label, data_type, v, v_speed, v_min=C_NULL, v_max=C_NULL, format=C_NULL, flags=0)
"""
DragScalar(label, data_type, v, v_speed, v_min=C_NULL, v_max=C_NULL, format=C_NULL, flags=0) = igDragScalar(label, data_type, v, v_speed, v_min, v_max, format, flag)
@deprecate DragScalar(label, data_type, v, v_speed, v_min, v_max, format, power::AbstractFloat) DragScalar(label, data_type, v, v_speed, v_min, v_max, format, 0)

"""
    DragScalarN(label, data_type, v, components, v_speed, v_min=C_NULL, v_max=C_NULL, format=C_NULL, flag=0)
"""
DragScalarN(label, data_type, v, components, v_speed, v_min=C_NULL, v_max=C_NULL, format=C_NULL, flag=0) = igDragScalarN(label, data_type, v, components, v_speed, v_min, v_max, format, flag)
@deprecate DragScalarN(label, data_type, v, components, v_speed, v_min, v_max, format, power::AbstractFloat) DragScalarN(label, data_type, v, components, v_speed, v_min, v_max, format, 0)

##################################### Widgets: Sliders #####################################
"""
    SliderFloat(label, v, v_min, v_max, format="%.3f", flag=0) -> Bool
Create a slider widget.

!!! tip
    `ctrl+click` on a slider to input with keyboard. manually input values aren't clamped, can go off-bounds.

### Arguments
- `format`: adjust format to decorate the value with a prefix or a suffix for in-slider labels or unit display
  * "%.3f" -> 1.234
  * "%5.2f secs" -> 01.23 secs
  * "Biscuit: %.0f" -> Biscuit: 1
"""
SliderFloat(label, v, v_min, v_max, format="%.3f", flag=0) = igSliderFloat(label, v, v_min, v_max, format, flag)
@deprecate SliderFloat(label, v, v_min, v_max, format, power::AbstractFloat) SliderFloat(label, v, v_min, v_max, format, 0)

"""
    SliderFloat2(label, v, v_min, v_max, format="%.3f", flag=0) -> Bool
The expected number of elements to be accessible in `v` is 2.
"""
SliderFloat2(label, v, v_min, v_max, format="%.3f", flag=0) = igSliderFloat2(label, v, v_min, v_max, format, flag)
@deprecate SliderFloat2(label, v, v_min, v_max, format, power::AbstractFloat) SliderFloat2(label, v, v_min, v_max, format, 0)

"""
    SliderFloat3(label, v, v_min, v_max, format="%.3f", flag=0) -> Bool
The expected number of elements to be accessible in `v` is 3.
"""
SliderFloat3(label, v, v_min, v_max, format="%.3f", flag=0) = igSliderFloat3(label, v, v_min, v_max, format, flag)
@deprecate SliderFloat3(label, v, v_min, v_max, format, power::AbstractFloat) SliderFloat3(label, v, v_min, v_max, format, 0)

"""
    SliderFloat4(label, v, v_min, v_max, format="%.3f", flag=0) -> Bool
The expected number of elements to be accessible in `v` is 4.
"""
SliderFloat4(label, v, v_min, v_max, format="%.3f", flag=0) = igSliderFloat4(label, v, v_min, v_max, format, flag)
@deprecate SliderFloat4(label, v, v_min, v_max, format, power::AbstractFloat) SliderFloat4(label, v, v_min, v_max, format, 0)

"""
    SliderAngle(label, v_rad, v_degrees_min=-360.0, v_degrees_max=360.0, format="%.0f deg", flags=0) -> Bool
"""
SliderAngle(label, v_rad, v_degrees_min=-360.0, v_degrees_max=360.0, format="%.0f deg", flags=0) = igSliderAngle(label, v_rad, v_degrees_min, v_degrees_max, format, flags)

"""
    SliderInt(label, v, v_min, v_max, format="%d", flags=0) -> Bool
"""
SliderInt(label, v, v_min, v_max, format="%d", flags=0) = igSliderInt(label, v, v_min, v_max, format, flags)

"""
    SliderInt2(label, v, v_min, v_max, format="%d", flags=0) -> Bool
The expected number of elements to be accessible in `v` is 2.
"""
SliderInt2(label, v, v_min, v_max, format="%d", flags=0) = igSliderInt2(label, v, v_min, v_max, format, flags)

"""
    SliderInt3(label, v, v_min, v_max, format="%d", flags=0) -> Bool
The expected number of elements to be accessible in `v` is 3.
"""
SliderInt3(label, v, v_min, v_max, format="%d", flags=0) = igSliderInt3(label, v, v_min, v_max, format, flags)

"""
    SliderInt4(label, v, v_min, v_max, format="%d", flags=0) -> Bool
The expected number of elements to be accessible in `v` is 4.
"""
SliderInt4(label, v, v_min, v_max, format="%d", flags=0) = igSliderInt4(label, v, v_min, v_max, format, flags)

"""
    SliderScalar(label, data_type, v, v_min, v_max, format=C_NULL, flag=0) -> Bool
"""
SliderScalar(label, data_type, v, v_min, v_max, format=C_NULL, flag=0) = igSliderScalar(label, data_type, v, v_min, v_max, format, flag)
@deprecate SliderScalar(label, data_type, v, v_min, v_max, format, power::AbstractFloat) SliderScalar(label, data_type, v, v_min, v_max, format, 0)

"""
    SliderScalarN(label, data_type, v, components, v_min, v_max, format=C_NULL, flag=0) -> Bool
"""
SliderScalarN(label, data_type, v, components, v_min, v_max, format=C_NULL, flag=0) = igSliderScalarN(label, data_type, v, components, v_min, v_max, format, flag)
@deprecate SliderScalarN(label, data_type, v, components, v_min, v_max, format, power::AbstractFloat) SliderScalarN(label, data_type, v, components, v_min, v_max, format, 0)

"""
    VSliderFloat(label, size, v, v_min, v_max, format="%.3f", flag=0) -> Bool
"""
VSliderFloat(label, size, v, v_min, v_max, format="%.3f", flag=0) = igVSliderFloat(label, size, v, v_min, v_max, format, flag)
@deprecate VSliderFloat(label, size, v, v_min, v_max, format, power::AbstractFloat) VSliderFloat(label, size, v, v_min, v_max, format, 0)

"""
    VSliderInt(label, size, v, v_min, v_max, format="%d", flag=0) -> Bool
"""
VSliderInt(label, size, v, v_min, v_max, format="%d", flag=0) = igVSliderInt(label, size, v, v_min, v_max, format, flag)

"""
    VSliderScalar(label, size, data_type, v, v_min, v_max, format=C_NULL, flag=0) -> Bool
"""
VSliderScalar(label, size, data_type, v, v_min, v_max, format=C_NULL, flag=0) = igVSliderScalar(label, size, data_type, v, v_min, v_max, format, flag)
@deprecate VSliderScalar(label, size, data_type, v, v_min, v_max, format, power::AbstractFloat) VSliderScalar(label, size, data_type, v, v_min, v_max, format, 0)

############################### Widgets: Input with Keyboard ###############################
"""
    InputText(label, buf, buf_size, flags=0, callback=C_NULL, user_data=C_NULL) -> Bool
"""
InputText(label, buf, buf_size, flags=0, callback=C_NULL, user_data=C_NULL) = igInputText(label, buf, buf_size, flags, callback, user_data)

"""
    InputTextMultiline(label, buf, buf_size, size=(0,0), flags=0, callback=C_NULL, user_data=C_NULL) -> Bool
"""
InputTextMultiline(label, buf, buf_size, size=(0,0), flags=0, callback=C_NULL, user_data=C_NULL) = igInputTextMultiline(label, buf, buf_size, size, flags, callback, user_data)

"""
    InputTextWithHint(label, hint, buf, buf_size, flags=0, callback=C_NULL, user_data=C_NULL) -> Bool
"""
InputTextWithHint(label, hint, buf, buf_size, flags=0, callback=C_NULL, user_data=C_NULL) = igInputTextWithHint(label, hint, buf, buf_size, flags, callback, user_data)

"""
    InputFloat(label, v, step=0, step_fast=0, format="%.3f", flags=0) -> Bool
"""
InputFloat(label, v, step=0, step_fast=0, format="%.3f", flags=0) = igInputFloat(label, v, step, step_fast, format, flags)

"""
    InputFloat2(label, v, format="%.3f", flags=0) -> Bool
The expected number of elements to be accessible in `v` is 2.
"""
InputFloat2(label, v, format="%.3f", flags=0) = igInputFloat2(label, v, format, flags)

"""
    InputFloat3(label, v, format="%.3f", flags=0) -> Bool
The expected number of elements to be accessible in `v` is 3.
"""
InputFloat3(label, v, format="%.3f", flags=0) = igInputFloat3(label, v, format, flags)

"""
    InputFloat4(label, v, format="%.3f", flags=0) -> Bool
The expected number of elements to be accessible in `v` is 4.
"""
InputFloat4(label, v, format="%.3f", flags=0) = igInputFloat4(label, v, format, flags)

"""
    InputInt(label, v, step=1, step_fast=100, flags=0) -> Bool
"""
InputInt(label, v, step=1, step_fast=100, flags=0) = igInputInt(label, v, step, step_fast, flags)

"""
    InputInt2(label, v, flags=0) -> Bool
The expected number of elements to be accessible in `v` is 2.
"""
InputInt2(label, v, flags=0) = igInputInt2(label, v, flags)

"""
    InputInt3(label, v, flags=0) -> Bool
The expected number of elements to be accessible in `v` is 3.
"""
InputInt3(label, v, flags=0) = igInputInt3(label, v, flags)

"""
    InputInt4(label, v, flags=0) -> Bool
The expected number of elements to be accessible in `v` is 4.
"""
InputInt4(label, v, flags=0) = igInputInt4(label, v, flags)

"""
    InputDouble(label, v, step=0.0, step_fast=0.0, format="%.6f", flags=0) -> Bool
"""
InputDouble(label, v, step=0.0, step_fast=0.0, format="%.6f", flags=0) = igInputDouble(label, v, step, step_fast, format, flags)

"""
    InputScalar(label, data_type, v, step=C_NULL, step_fast=C_NULL, format=C_NULL, flags=0) -> Bool
"""
InputScalar(label, data_type, v, step=C_NULL, step_fast=C_NULL, format=C_NULL, flags=0) = igInputScalar(label, data_type, v, step, step_fast, format, flags)

"""
    InputScalarN(label, data_type, v, components, step=C_NULL, step_fast=C_NULL, format=C_NULL, flags=0) -> Bool
"""
InputScalarN(label, data_type, v, components, step=C_NULL, step_fast=C_NULL, format=C_NULL, flags=0) = igInputScalarN(label, data_type, v, components, step, step_fast, format, flags)

############################### Widgets: Color Editor/Picker ###############################
"""
    ColorEdit3(label, col, flags=0) -> Bool
!!! tip
    this function has a little colored preview square that can be left-clicked to open a picker,
    and right-clicked to open an option menu.
"""
ColorEdit3(label, col, flags=0) = igColorEdit3(label, col, flags)

"""
    ColorEdit4(label, col, flags=0) -> Bool
!!! tip
    this function has a little colored preview square that can be left-clicked to open a picker,
    and right-clicked to open an option menu.
"""
ColorEdit4(label, col, flags=0) = igColorEdit4(label, col, flags)

"""
    ColorPicker3(label, col, flags=0)
"""
ColorPicker3(label, col, flags=0) = igColorPicker3(label, col, flags)

"""
    ColorPicker4(label, col, flags=0, ref_col=C_NULL)
"""
ColorPicker4(label, col, flags=0, ref_col=C_NULL) = igColorPicker4(label, col, flags, ref_col)

"""
    ColorButton(desc_id, col, flags=0, size=(0,0))
Display a colored square/button, hover for details, return true when pressed.
"""
ColorButton(desc_id, col, flags=0, size=ImVec2(0,0)) = igColorButton(desc_id, col, flags, size)

"""
    SetColorEditOptions(flags)
Initialize current options (generally on application startup) if you want to select a default
format, picker type, etc. User will be able to change many settings, unless you pass the
`_NoOptions` flag to your calls.
"""
SetColorEditOptions(flags) = igSetColorEditOptions(flags)

###################################### Widgets: Trees ######################################
"""
    TreeNode(label::AbstractString) -> Bool
TreeNode functions return true when the node is open, in which case you need to also call
[`TreePop`](@ref) when you are finished displaying the tree node contents.
"""
TreeNode(label::AbstractString) = igTreeNode_Str(label)

"""
    TreeNode(str_id, formatted_text) -> Bool
Helper variation to completely decorelate the id from the displayed string.
Read the FAQ in [`PushID`](@ref)'s' doc about why and how to use ID.
To align arbitrary text at the same level as a [`TreeNode`](@ref) you can use [`Bullet`](@ref).

!!! warning "Limited support"
    Formatting is not supported which means you need to pass a formatted string to this function.
    It's recommended to use Julia stdlib `Printf`'s `@sprintf` as a workaround when translating C/C++ code to Julia.
"""
TreeNode(str_id, formatted_text) = igTreeNode_StrStr(str_id, formatted_text)

"""
    TreeNodePtr(ptr_id::Ptr, formatted_text) -> Bool
Helper variation to completely decorelate the id from the displayed string.
Read the FAQ in [`PushID`](@ref)'s' doc about why and how to use ID.
To align arbitrary text at the same level as a [`TreeNode`](@ref) you can use [`Bullet`](@ref).

!!! warning "Limited support"
    Formatting is not supported which means you need to pass a formatted string to this function.
    It's recommended to use Julia stdlib `Printf`'s `@sprintf` as a workaround when translating C/C++ code to Julia.
"""
TreeNode(ptr_id::Ptr, formatted_text) = igTreeNode_Ptr(ptr_id, formatted_text)

"""
    TreeNodeEx(label, flags=0) -> Bool
"""
TreeNodeEx(label, flags=0) = igTreeNodeEx_Str(label, flags)

"""
    TreeNodeEx(str_id, flags, formatted_text) -> Bool
!!! warning "Limited support"
    Formatting is not supported which means you need to pass a formatted string to this function.
    It's recommended to use Julia stdlib `Printf`'s `@sprintf` as a workaround when translating C/C++ code to Julia.
"""
TreeNodeEx(str_id, flags, formatted_text) = igTreeNodeEx_StrStr(str_id, flags, formatted_text)

"""
    TreeNodeEx(ptr_id::Ptr, flags, formatted_text) -> Bool
!!! warning "Limited support"
    Formatting is not supported which means you need to pass a formatted string to this function.
    It's recommended to use Julia stdlib `Printf`'s `@sprintf` as a workaround when translating C/C++ code to Julia.
"""
TreeNodeEx(ptr_id::Ptr, flags, formatted_text) = igTreeNodeEx_Ptr(ptr_id, flags, formatted_text)

"""
    TreePush(str_id)
[`Indent`](@ref) + [`PushID`](@ref). Already called by [`TreeNode`](@ref) when returning true,
but you can call [`TreePush`](@ref)/[`TreePop`](@ref) yourself if desired.
"""
TreePush(str_id) = igTreePush_Str(str_id)

"""
    TreePush(ptr_id::Ptr=C_NULL)
[`Indent`](@ref) + [`PushID`](@ref). Already called by [`TreeNode`](@ref) when returning true,
but you can call [`TreePush`](@ref)/[`TreePop`](@ref) yourself if desired.
"""
TreePush(ptr_id::Ptr=C_NULL) = igTreePush_Ptr(ptr_id)

"""
    TreePop()
[`Unindent`](@ref) + [`PopID`](@ref).
"""
TreePop() = igTreePop()

"""
    GetTreeNodeToLabelSpacing()
Horizontal distance preceding label when using `TreeNode*()` or `Bullet() == (g.FontSize + style.FramePadding.x*2)` for a regular unframed TreeNode.
"""
GetTreeNodeToLabelSpacing() = igGetTreeNodeToLabelSpacing()

@deprecate TreeAdvanceToLabelPos() SetCursorPosX(GetCursorPosX() + GetTreeNodeToLabelSpacing())

"""
    CollapsingHeader(label, flags=ImGuiTreeNodeFlags_(0)) -> Bool
If returning `true` the header is open. Doesn't indent nor push on ID stack.
User doesn't have to call [`TreePop`](@ref).
"""
CollapsingHeader(label, flags=ImGuiTreeNodeFlags_(0)) = igCollapsingHeader_TreeNodeFlags(label, flags)

"""
    CollapsingHeader(label, p_open::Ref, flags=ImGuiTreeNodeFlags_(0)) -> Bool
When `p_open` isn't `C_NULL`, display an additional small close button on upper right of the header.
"""
CollapsingHeader(label, p_open::Ref, flags=ImGuiTreeNodeFlags_(0)) = igCollapsingHeader_BoolPtr(label, p_open, flags)

"""
    SetNextItemOpen(is_open, cond=0)
Set next TreeNode/CollapsingHeader open state.
"""
SetNextItemOpen(is_open, cond=0) = igSetNextItemOpen(is_open, cond)

@deprecate SetNextTreeNodeOpen(open, cond=0) SetNextItemOpen(open, cond)

################################### Widgets: Selectables ###################################
"""
    Selectable(label, selected::Bool=false, flags=0, size=(0,0)) -> Bool
    Selectable(label, p_selected::Ref, flags=0, sizeImVec2(0,0)) -> Bool
Return true if is clicked, so you can modify your selection state:
- `size.x == 0.0`: use remaining width
- `size.x > 0.0`: specify width
- `size.y == 0.0`: use label height
- `size.y > 0.0`: specify height
"""
Selectable(label, selected::Bool=false, flags=0, size=ImVec2(0,0)) = igSelectable_Bool(label, selected, flags, size)
Selectable(label, p_selected::Ref, flags=0, size=ImVec2(0,0)) = igSelectable_BoolPtr(label, p_selected, flags, size)

#################################### Widgets: List Boxes ###################################
"""
    ListBox(label, current_item, items, items_count, height_in_items=-1)
    ListBox(label, current_item, items_getter::Ptr{Cvoid}, data::Ptr{Cvoid}, items_count, height_in_items=-1)
"""
ListBox(label, current_item, items, items_count, height_in_items=-1) = igListBox_Str_arr(label, current_item, items, items_count, height_in_items)
ListBox(label, current_item, items_getter::Ptr{Cvoid}, data::Ptr{Cvoid}, items_count, height_in_items=-1) = igListBox_FnBoolPtr(label, current_item, items_getter, data, items_count, height_in_items)

"""
    BeginListBox(label, size=(0,0))
Use if you want to reimplement [`ListBox`](@ref) will custom data or interactions.
If the function return true, you can output elements then call [`EndListBox`](@ref) afterwards.
"""
BeginListBox(label,size=ImVec2(0,0)) = igBeginListBox(label,size)

"""
    ListBoxFooter()
Terminate the scrolling region.

!!! note
    Only call `ListBoxFooter()` if [`ListBoxHeader`](@ref) returned true!
"""
EndListBox() = igEndListBox()


################################## Widgets: Data Plotting ##################################
"""
    PlotLines(label, values, values_count::Integer, values_offset=0, overlay_text=C_NULL, scale_min=FLT_MAX, scale_max=FLT_MAX, graph_size=(0,0), stride=sizeof(Cfloat))
    PlotLines(label, values_getter::Ptr, data::Ptr, values_count, values_offset=0, overlay_text=C_NULL, scale_min=FLT_MAX, scale_max=FLT_MAX, graph_size=(0,0))
"""
PlotLines(label, values, values_count, values_offset=0, overlay_text=C_NULL, scale_min=FLT_MAX, scale_max=FLT_MAX, graph_size=ImVec2(0,0), stride=sizeof(Cfloat)) = igPlotLines_FloatPtr(label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride)
PlotLines(label, values_getter, data::Ptr, values_count, values_offset=0, overlay_text=C_NULL, scale_min=FLT_MAX, scale_max=FLT_MAX, graph_size=ImVec2(0,0)) = igPlotLines_FnFloatPtr(label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size)

"""
    PlotHistogram(label, values, values_count, values_offset=0, overlay_text=C_NULL, scale_min=FLT_MAX, scale_max=FLT_MAX, graph_size=(0,0), stride=sizeof(Cfloat))
    PlotHistogram(label, values_getter::Ptr, data::Ptr, values_count, values_offset=0, overlay_text=C_NULL, scale_min=FLT_MAX, scale_max=FLT_MAX, graph_size=ImVec2(0,0))
"""
PlotHistogram(label, values, values_count, values_offset=0, overlay_text=C_NULL, scale_min=FLT_MAX, scale_max=FLT_MAX, graph_size=ImVec2(0,0), stride=sizeof(Cfloat)) = igPlotHistogram_FloatPtr(label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride)
PlotHistogram(label, values_getter, data::Ptr, values_count, values_offset=0, overlay_text=C_NULL, scale_min=FLT_MAX, scale_max=FLT_MAX, graph_size=ImVec2(0,0)) = igPlotHistogram_FnFloatPtr(label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size)

################################# Widgets: Value() Helpers #################################
"""
    ValueBool(prefix, b)
Output single value in "name: value" format.
"""
ValueBool(prefix, b) = igValue_Bool(prefix, b)

"""
    ValueInt(prefix, v)
Output single value in "name: value" format.
"""
ValueInt(prefix, v) = igValue_Int(prefix, v)

"""
    ValueUint(prefix, v)
Output single value in "name: value" format.
"""
ValueUint(prefix, v) = igValue_Uint(prefix, v)

"""
    ValueFloat(prefix, v, float_format=C_NULL)
Output single value in "name: value" format.
"""
ValueFloat(prefix, v, float_format=C_NULL) = igValue_Float(prefix, v, float_format)

###################################### Widgets: Menus ######################################
"""
    BeginMainMenuBar() -> Bool
Create and append to a full screen menu-bar.
"""
BeginMainMenuBar() = igBeginMainMenuBar()

"""
    EndMainMenuBar()
!!! note
    Only call `EndMainMenuBar` if [`BeginMainMenuBar`](@ref) returns true!
"""
EndMainMenuBar() = igEndMainMenuBar()

"""
    BeginMenuBar() -> Bool
Append to menu-bar of current window (requires `ImGuiWindowFlags_MenuBar` flag set on parent window).
"""
BeginMenuBar() = igBeginMenuBar()

"""
    EndMenuBar()
!!! note
    Only call `EndMenuBar` if [`BeginMenuBar`](@ref) returns true!
"""
EndMenuBar() = igEndMenuBar()


"""
    BeginMenu(label, enabled=true) -> Bool
Create a sub-menu entry. only call EndMenu() if this returns true!
"""
BeginMenu(label, enabled=true) = igBeginMenu(label, enabled)

"""
    EndMenu()
!!! note
    Only call `EndMenu` if [`BeginMenu`](@ref) returns true!
"""
EndMenu() = igEndMenu()

"""
    MenuItem(label, shortcut=C_NULL, selected::Bool=false, enabled::Bool=true) -> Bool
    MenuItem(label, shortcut, selected::Ref, enabled::Bool=true) -> Bool
Return true when activated. Shortcuts are displayed for convenience but not processed by ImGui at the moment.
"""
MenuItem(label, shortcut=C_NULL, selected::Bool=false, enabled::Bool=true) = igMenuItem_Bool(label, shortcut, selected, enabled)
MenuItem(label, shortcut, selected::Ref, enabled::Bool=true) = igMenuItem_BoolPtr(label, shortcut, selected, enabled)


######################################### Tooltips #########################################
"""
    BeginTooltip()
Begin/append a tooltip window to create full-featured tooltip (with any kind of items).
"""
BeginTooltip() = igBeginTooltip()

"""
    EndTooltip()
See [`BeginTooltip`](@ref).
"""
EndTooltip() = igEndTooltip()

"""
    SetTooltip(formatted_text)
Set a text-only tooltip, typically use with [`IsItemHovered`](@ref).
Overidde any previous call to [`SetTooltip`](@ref).

!!! warning "Limited support"
    Formatting is not supported which means you need to pass a formatted string to this function.
    It's recommended to use Julia stdlib `Printf`'s `@sprintf` as a workaround when translating C/C++ code to Julia.
"""
SetTooltip(formatted_text) = igSetTooltip(formatted_text)

########################################## Popups ##########################################
"""
    OpenPopup(str_id)
Call to mark popup as open (don't call every frame!).
Popups are closed when user click outside, or if [`CloseCurrentPopup`](@ref) is called within
a [`BeginPopup`](@ref)/[`EndPopup`](@ref) block. By default, [`Selectable`](@ref)/[`MenuItem`](@ref)
are calling [`CloseCurrentPopup`](@ref). Popup identifiers are relative to the current ID-stack
(so OpenPopup and BeginPopup needs to be at the same level).
"""
OpenPopup(str_id, popup_flags=0) =  igOpenPopup_Str(str_id, popup_flags)

"""
    BeginPopup(str_id, flags=0) -> Bool
Return true if the popup is open, and you can start outputting to it.

!!! note
    Only call [`EndPopup`](@ref) if [`BeginPopup`](@ref) returns true!
"""
BeginPopup(str_id, window_flags=0) = igBeginPopup(str_id, window_flags)

"""
    BeginPopupContextItem(str_id=C_NULL, flags=1) -> Bool
Helper to open and begin popup when clicked on last item. if you can pass a C_NULL str_id
only if the previous item had an id. If you want to use that on a non-interactive item such
as [`Text`](@ref) you need to pass in an explicit ID here.
"""
BeginPopupContextItem(str_id=C_NULL, popup_flags=1) = igBeginPopupContextItem(str_id, popup_flags)

"""
    BeginPopupContextWindow(str_id=C_NULL, popup_flags=1) -> Bool
Helper to open and begin popup when clicked on current window.
"""
BeginPopupContextWindow(str_id=C_NULL, popup_flags=1) = igBeginPopupContextWindow(str_id, popup_flags)

"""
    BeginPopupContextVoid(str_id=C_NULL, popup_flags=1) -> Bool
Helper to open and begin popup when clicked in void (where there are no imgui windows).
"""
BeginPopupContextVoid(str_id=C_NULL, popup_flags=1) = igBeginPopupContextVoid(str_id, popup_flags)

"""
    BeginPopupModal(name, p_open=C_NULL, flags=0) -> Bool
Modal dialog (regular window with title bar, block interactions behind the modal window, can't close the modal window by clicking outside).
"""
BeginPopupModal(name, p_open=C_NULL, window_flags=0) = igBeginPopupModal(name, p_open, window_flags)

"""
    EndPopup()
See [`BeginPopup`](@ref), [`BeginPopupContextItem`](@ref), [`BeginPopupContextWindow`](@ref),
[`BeginPopupContextVoid`](@ref), [`BeginPopupModal`](@ref).
!!! note
    Only call [`EndPopup`](@ref) if `BeginPopupXXX()` returns true!
"""
EndPopup() = igEndPopup()

"""
    OpenPopupOnItemClick(str_id=C_NULL, mouse_button=1) -> Nothing
Helper to open popup when clicked on last item (note: actually triggers on the mouse
_released_ event to be consistent with popup behaviors).
"""
OpenPopupOnItemClick(str_id=C_NULL, popup_flags=1) = igOpenPopupOnItemClick(str_id, popup_flags)

@deprecate OpenPopupContextItem(str_id=C_NULL, mouse_button=1) OpenPopupOnItemClick(str_id=C_NULL, mouse_button=1)

"""
    IsPopupOpen(str_id) -> Bool
Return true if the popup is open.
"""
IsPopupOpen(str_id) = igIsPopupOpen_Str(str_id)

"""
    CloseCurrentPopup()
Close the popup we have begin-ed into. clicking on a MenuItem or Selectable automatically
close the current popup.
"""
CloseCurrentPopup() = igCloseCurrentPopup()

########################################## Columns #########################################
"""
    Columns(count=1, id=C_NULL, border=true)

!!! warning "Work in progress!"
    You can also use `SameLine(pos_x)` for simplified columns. The columns API is work-in-progress
    and rather lacking (columns are arguably the worst part of dear imgui at the moment!)
"""
Columns(count=1, id=C_NULL, border=true) = igColumns(count, id, border)

"""
    NextColumn()
Next column, defaults to current row or next row if the current row is finished.
"""
NextColumn() = igNextColumn()

"""
    GetColumnIndex() -> Cint
Return current column index.
"""
GetColumnIndex() = igGetColumnIndex()

"""
    GetColumnWidth(column_index=-1) -> Cfloat
Return column width (in pixels). Pass -1 to use current column.
"""
GetColumnWidth(column_index=-1) = igGetColumnWidth(column_index)

"""
    SetColumnWidth(column_index, width)
Set column width (in pixels). Pass -1 to use current column.
"""
SetColumnWidth(column_index, width) = igSetColumnWidth(column_index, width)

"""
    GetColumnOffset(column_index=-1) -> Cfloat
Get position of column line (in pixels, from the left side of the contents region).
Pass -1 to use current column, otherwise 0..GetColumnsCount() inclusive. Column 0 is typically 0.0.
"""
GetColumnOffset(column_index=-1) = igGetColumnOffset(column_index)

"""
    SetColumnOffset(column_index, offset_x)
Set position of column line (in pixels, from the left side of the contents region).
Pass `-1` to use current column.
"""
SetColumnOffset(column_index, offset_x) = igSetColumnOffset(column_index, offset_x)

"""
    GetColumnsCount() -> Cint
"""
GetColumnsCount() = igGetColumnsCount()

####################################  Table ####################################
# [BETA API] API may evolve slightly! If you use this, please update to the next version when it comes out!
# - Full-featured replacement for old Columns API.
# - See Demo->Tables for demo code.
# - See top of imgui_tables.cpp for general commentary.
# - See ImGuiTableFlags_ and ImGuiTableColumnFlags_ enums for a description of available flags.
# The typical call flow is:
# - 1. Call BeginTable().
# - 2. Optionally call TableSetupColumn() to submit column name/flags/defaults.
# - 3. Optionally call TableSetupScrollFreeze() to request scroll freezing of columns/rows.
# - 4. Optionally call TableHeadersRow() to submit a header row. Names are pulled from TableSetupColumn() data.
# - 5. Populate contents:
#    - In most situations you can use TableNextRow() + TableSetColumnIndex(N) to start appending into a column.
#    - If you are using tables as a sort of grid, where every columns is holding the same type of contents,
#      you may prefer using TableNextColumn() instead of TableNextRow() + TableSetColumnIndex().
#      TableNextColumn() will automatically wrap-around into the next row if needed.
#    - IMPORTANT: Comparatively to the old Columns() API, we need to call TableNextColumn() for the first column!
#    - Summary of possible call flow:
#        --------------------------------------------------------------------------------------------------------
#        TableNextRow() -> TableSetColumnIndex(0) -> Text("Hello 0") -> TableSetColumnIndex(1) -> Text("Hello 1")  // OK
#        TableNextRow() -> TableNextColumn()      -> Text("Hello 0") -> TableNextColumn()      -> Text("Hello 1")  // OK
#                          TableNextColumn()      -> Text("Hello 0") -> TableNextColumn()      -> Text("Hello 1")  // OK: TableNextColumn() automatically gets to next row!
#        TableNextRow()                           -> Text("Hello 0")                                               // Not OK! Missing TableSetColumnIndex() or TableNextColumn()! Text will not appear!
#        --------------------------------------------------------------------------------------------------------
# - 5. Call EndTable()
"""
    BeginTable(str_id, columns_count, flags = ImGuiTableFlags_(0), outer_size = ImVec2(0,0), inner_width = 0.0) -> Bool
Begin a table entry. 
"""

BeginTable(str_id, columns_count, flags = ImGuiTableFlags_(0), outer_size = ImVec2(0,0), inner_width = 0.0) = igBeginTable(str_id, columns_count, flags, outer_size, inner_width)

"""
    EndTable()
Only call [`EndTable`](@ref) if [`BeginTable`](@ref) returns true!
"""
EndTable() = igEndTable()

"""
    TableNextRow(row_flags = ImGuiTableRowFlags_(0), min_row_height = 0.0)
Append into the first cell of a new row.
"""
TableNextRow(row_flags = ImGuiTableRowFlags_(0), min_row_height = 0.0) = igTableNextRow(row_flags, min_row_height)

"""
    TableNextColumn() -> Bool
Append into the next column (or first column of next row if currently in last column). Return true when column is visible.
"""                                                                                                                                    
TableNextColumn() = igTableNextColumn()

"""
    TableSetColumnIndex(column_n) -> Bool
Append into the specified column. Return true when column is visible.
"""
TableSetColumnIndex(column_n) = igTableSetColumnIndex(column_n)

"""
    TableGetColumnIndex() -> CInt
Return current column index
"""
TableGetColumnIndex() = igTableGetColumnIndex()

"""
    TableGetRowIndex() -> CInt
Return current row index.
"""
TableGetRowIndex() = igTableGetRowIndex()

# Tables: Headers & Columns declaration
# - Use TableSetupColumn() to specify label, resizing policy, default width/weight, id, various other flags etc.
# - Use TableHeadersRow() to create a header row and automatically submit a TableHeader() for each column.
#   Headers are required to perform: reordering, sorting, and opening the context menu.
#   The context menu can also be made available in columns body using ImGuiTableFlags_ContextMenuInBody.
# - You may manually submit headers using TableNextRow() + TableHeader() calls, but this is only useful in
#   some advanced use cases (e.g. adding custom widgets in header row).
# - Use TableSetupScrollFreeze() to lock columns/rows so they stay visible when scrolled.
"""
    TableSetupColumn(label, flags = ImGuiTableColumnFlags_(0), init_width_or_weight = 0.0, user_id = ImGuiID(0))
Specify label, resizing policy, default width/weight, id, various other flags etc.
"""
TableSetupColumn(label, flags = ImGuiTableColumnFlags_(0), init_width_or_weight = 0.0, user_id = ImGuiID(0)) = igTableSetupColumn(label, flags, init_width_or_weight, user_id)

"""
    TableSetupScrollFreeze(cols, rows)
Lock columns/rows so they stay visible when scrolled.
"""
TableSetupScrollFreeze(cols, rows) = igTableSetupScrollFreeze(cols, rows)

"""
    TableHeadersRow()
Submit all headers cells based on data provided to TableSetupColumn() + submit context menu
"""
TableHeadersRow() = igTableHeadersRow()

"""
    TableHeader(label)
Submit one header cell manually (rarely used)
"""
TableHeader(label) = igTableHeader(label)

# Tables: Miscellaneous functions
"""
    TableGetColumnCount() -> CInt
return number of columns (value passed to BeginTable)
"""
TableGetColumnCount() = igTableGetColumnCount()

"""
    TableGetColumnName(column_n = -1) -> String
return "" if column didn't have a name declared by TableSetupColumn(). Pass -1 to use current column.
"""
TableGetColumnName(column_n = -1) = unsafe_string(igTableGetColumnName_Int(column_n))

"""
    TableGetColumnFlags(column_n = -1) -> ImGuiTableColumnFlags
Return column flags so you can query their Enabled/Visible/Sorted/Hovered status flags. Pass -1 to use current column.
"""
TableGetColumnFlags(column_n = -1) = igTableGetColumnFlags(column_n)

"""
    TableGetSortSpecs() -> Ptr{ImGuiTableSortSpecs}
get latest sort specs for the table (NULL if not sorting).
"""
TableGetSortSpecs() = igTableGetSortSpecs()

"""
    TableSetBgColor(bg_target, color, column_n = -1)
Change the color of a cell, row, or column. See ImGuiTableBgTarget_ flags for details.
"""
TableSetBgColor(bg_target, color, column_n = -1) = igTableSetBgColor(bg_target, color, column_n)

##################################### Tab Bars, Tabs #######################################
"""
    igBeginTabBar(str_id, flags=ImGuiTabBarFlags_(0)) -> Bool
Create and append into a TabBar.

!!! note "BETA API"
    API may evolve!
"""
BeginTabBar(str_id, flags=ImGuiTabBarFlags_(0)) = igBeginTabBar(str_id, flags)

"""
    EndTabBar()
Only call [`EndTabBar`](@ref) if [`BeginTabBar`](@ref) returns true!

!!! note "BETA API"
    API may evolve!
"""
EndTabBar() = igEndTabBar()

"""
    BeginTabItem(label, p_open=C_NULL, flags=ImGuiTabItemFlags_(0)) -> Bool
!!! note "BETA API"
    API may evolve!
"""
BeginTabItem(label, p_open=C_NULL, flags=ImGuiTabItemFlags_(0)) = igBeginTabItem(label, p_open, flags)

"""
    EndTabItem()
Only call [`EndTabItem`](@ref) if [`BeginTabItem`](@ref) returns true!

!!! note "BETA API"
    API may evolve!
"""
EndTabItem() = igEndTabItem()

"""
    SetTabItemClosed(tab_or_docked_window_label)
Notify TabBar or Docking system of a closed tab/window ahead (useful to reduce visual flicker
on reorderable tab bars). For tab-bar: call after BeginTabBar() and before Tab submissions.
Otherwise call with a window name.

!!! note "BETA API"
    API may evolve!
"""
SetTabItemClosed(tab_or_docked_window_label) = igSetTabItemClosed(tab_or_docked_window_label)

##################################### Logging/Capture ######################################
"""
    LogToTTY(max_depth=-1)
Start logging to tty.

All text output from interface is captured to tty. By default, tree nodes are
automatically opened during logging.
"""
LogToTTY(max_depth=-1) = igLogToTTY(max_depth)

"""
    LogToFile(max_depth=-1, filename=C_NULL)
Start logging to file.

All text output from interface is captured to file. By default, tree nodes are
automatically opened during logging.
"""
LogToFile(max_depth=-1, filename=C_NULL) = igLogToFile(max_depth, filename)

"""
    LogToClipboard(max_depth=-1)
Start logging to OS clipboard.

All text output from interface is captured to clipboard. By default, tree nodes are
automatically opened during logging.
"""
LogToClipboard(max_depth=-1) = igLogToClipboard(max_depth)

"""
    LogFinish()
Stop logging (close file, etc.)
"""
LogFinish() = igLogFinish()

"""
    LogButtons()
Display buttons for logging to tty/file/clipboard.
"""
LogButtons() = igLogButtons()

"""
    LogText(formatted_text)
Pass text data straight to log without being displayed.
"""
LogText(formatted_text) = igLogText(formatted_text)

###################################### Drag and Drop #######################################
"""
    BeginDragDropSource(flags=ImGuiDragDropFlags_(0)) -> bool
Call when the current item is active. If this return true, you can call [`SetDragDropPayload`](@ref) + [`EndDragDropSource`](@ref).

!!! note "BETA API"
    Missing Demo code. API may evolve.
"""
BeginDragDropSource(flags=ImGuiDragDropFlags_(0)) = igBeginDragDropSource(flags)

"""
    SetDragDropPayload(type, data, size, cond=ImGuiCond_(1)) -> bool
`type` is a user defined string of maximum 32 characters. Strings starting with '_' are
reserved for dear imgui internal types. Data is copied and held by imgui.

!!! note "BETA API"
    Missing Demo code. API may evolve.
"""
SetDragDropPayload(type, data, size, cond=ImGuiCond_(1)) = igSetDragDropPayload(type, data, size, cond)

"""
    EndDragDropSource()
!!! note
    Only call `EndDragDropSource()` if [`BeginDragDropSource`](@ref) returns true!

!!! note "BETA API"
    Missing Demo code. API may evolve.
"""
EndDragDropSource() = igEndDragDropSource()

"""
    BeginDragDropTarget() -> bool
Call after submitting an item that may receive a payload. If this returns true, you can call
[`AcceptDragDropPayload`](@ref) + [`EndDragDropTarget`](@ref).

!!! note "BETA API"
    Missing Demo code. API may evolve.
"""
BeginDragDropTarget() = igBeginDragDropTarget()

"""
    AcceptDragDropPayload(type, flags=ImGuiDragDropFlags_(0)) -> Ptr{ImGuiPayload}

!!! note "BETA API"
    Missing Demo code. API may evolve.
"""
AcceptDragDropPayload(type, flags=ImGuiDragDropFlags_(0)) = igAcceptDragDropPayload(type, flags)

"""
    EndDragDropTarget()
!!! note
    Only call [`EndDragDropTarget`](@ref) if [`BeginDragDropTarget`](@ref) returns true!

!!! note "BETA API"
    Missing Demo code. API may evolve.
"""
EndDragDropTarget() = igEndDragDropTarget()

"""
    GetDragDropPayload() -> Ptr{ImGuiPayload}
Peek directly into the current payload from anywhere. May return C_NULL.
Use [`IsDataType`](@ref) to test for the payload type.

!!! note "BETA API"
    Missing Demo code. API may evolve.
"""
GetDragDropPayload() = igGetDragDropPayload()

######################################### Clipping #########################################
"""
    PushClipRect(clip_rect_min, clip_rect_max, intersect_with_current_clip_rect)
"""
PushClipRect(clip_rect_min, clip_rect_max, intersect_with_current_clip_rect) = igPushClipRect(clip_rect_min, clip_rect_max, intersect_with_current_clip_rect)

"""
    PopClipRect()
"""
PopClipRect() = igPopClipRect()

#################################### Focus, Activation #####################################
"""
    SetItemDefaultFocus()
Make last item the default focused item of a window.

!!! tip
    Prefer using [`SetItemDefaultFocus`](@ref) over `if (IsWindowAppearing()) SetScrollHereY()`
    when applicable to signify "this is the default item").
"""
SetItemDefaultFocus() = igSetItemDefaultFocus()

"""
    SetKeyboardFocusHere(offset=0)
Focus keyboard on the next widget. Use positive `offset` to access sub components of a
multiple component widget. Use `-1` to access previous widget.

!!! tip
    Prefer using [`SetItemDefaultFocus`](@ref) over `if (IsWindowAppearing()) SetScrollHereY()`
    when applicable to signify "this is the default item").
"""
SetKeyboardFocusHere(offset=0) = igSetKeyboardFocusHere(offset)

################################## Item/Widgets Utilities ##################################
"""
    IsItemHovered(flags=ImGuiHoveredFlags_(0)) -> Bool
Is the last item hovered? (and usable, aka not blocked by a popup, etc.).
See the output of `CImGui.GetFlags(CImGui.ImGuiHoveredFlags_)` for options:

```@eval
using CImGui, Markdown
CImGui.ShowFlags(CImGui.ImGuiHoveredFlags_) |> Markdown.parse
```

See Demo Window under "Widgets->Querying Status" for an interactive visualization of many of those functions.
"""
IsItemHovered(flags=ImGuiHoveredFlags_(0)) = igIsItemHovered(flags)

"""
    IsItemActive() -> Bool
Is the last item active? (e.g. button being held, text field being edited.
This will continuously return true while holding mouse button on an item.
Items that don't interact will always return false)
See Demo Window under "Widgets->Querying Status" for an interactive visualization of many of those functions.
"""
IsItemActive() = igIsItemActive()

"""
    IsItemFocused() -> Bool
Is the last item focused for keyboard/gamepad navigation?
See Demo Window under "Widgets->Querying Status" for an interactive visualization of many of those functions.
"""
IsItemFocused() = igIsItemFocused()

"""
    IsItemClicked() -> Bool
    IsItemClicked(mouse_button=0) -> Bool
Is the last item clicked? (e.g. button/node just clicked on) == `IsMouseClicked(mouse_button)` && [`IsItemHovered`](@ref).
See Demo Window under "Widgets->Querying Status" for an interactive visualization of many of those functions.
"""
IsItemClicked(mouse_button=0) = igIsItemClicked(mouse_button)

"""
    IsItemVisible() -> Bool
Is the last item visible? (items may be out of sight because of clipping/scrolling).
See Demo Window under "Widgets->Querying Status" for an interactive visualization of many of those functions.
"""
IsItemVisible() = igIsItemVisible()

"""
    IsItemEdited() -> Bool
Did the last item modify its underlying value this frame? or was pressed?
This is generally the same as the "bool" return value of many widgets.
See Demo Window under "Widgets->Querying Status" for an interactive visualization of many of those functions.
"""
IsItemEdited() = igIsItemEdited()

"""
    IsItemActivated() -> Bool
Was the last item just made active (item was previously inactive).
"""
IsItemActivated() = igIsItemActivated()

"""
    IsItemDeactivated() -> Bool
Was the last item just made inactive (item was previously active).
Useful for Undo/Redo patterns with widgets that requires continuous editing.
See Demo Window under "Widgets->Querying Status" for an interactive visualization of many of those functions.
"""
IsItemDeactivated() = igIsItemDeactivated()

"""
    IsItemDeactivatedAfterEdit() -> Bool
Was the last item just made inactive and made a value change when it was active?
(e.g. Slider/Drag moved). Useful for Undo/Redo patterns with widgets that requires continuous editing.
Note that you may get false positives (some widgets such as [`Combo`](@ref)/[`ListBox`](@ref)/[`Selectable`](@ref)
will return true even when clicking an already selected item).
See Demo Window under "Widgets->Querying Status" for an interactive visualization of many of those functions.
"""
IsItemDeactivatedAfterEdit() = igIsItemDeactivatedAfterEdit()

@deprecate IsItemDeactivatedAfterChange() IsItemDeactivatedAfterEdit()

"""
    IsItemToggledOpen() -> Bool
See Demo Window under "Widgets->Querying Status" for an interactive visualization of many of those functions.
"""
IsItemToggledOpen() = igIsItemToggledOpen()

"""
    IsAnyItemHovered() -> Bool
See Demo Window under "Widgets->Querying Status" for an interactive visualization of many of those functions.
"""
IsAnyItemHovered() = igIsAnyItemHovered()

"""
    IsAnyItemActive() -> Bool
See Demo Window under "Widgets->Querying Status" for an interactive visualization of many of those functions.
"""
IsAnyItemActive() = igIsAnyItemActive()

"""
     IsAnyItemFocused() -> Bool
See Demo Window under "Widgets->Querying Status" for an interactive visualization of many of those functions.
"""
IsAnyItemFocused() = igIsAnyItemFocused()

"""
    GetItemRectMin() -> ImVec2
Return bounding rectangle of last item, in screen space.
See Demo Window under "Widgets->Querying Status" for an interactive visualization of many of those functions.
"""
function GetItemRectMin()
    x = Ref{ImVec2}()
    igGetItemRectMin(x)
    return x[]
end

"""
    GetItemRectMax() -> ImVec2
Return bounding rectangle of last item, in screen space.
See Demo Window under "Widgets->Querying Status" for an interactive visualization of many of those functions.
"""
function GetItemRectMax()
    x = Ref{ImVec2}()
    igGetItemRectMax(x)
    return x[]
end

"""
    GetItemRectSize() -> ImVec2
Return size of last item, in screen space.
See Demo Window under "Widgets->Querying Status" for an interactive visualization of many of those functions.
"""
function GetItemRectSize()
    x = Ref{ImVec2}()
    igGetItemRectSize(x)
    return x[]
end

"""
    SetItemAllowOverlap()
Allow last item to be overlapped by a subsequent item. Sometimes useful with invisible buttons,
selectables, etc. to catch unused area.
See Demo Window under "Widgets->Querying Status" for an interactive visualization of many of those functions.
"""
SetItemAllowOverlap() = igSetItemAllowOverlap()

################################## Miscellaneous Utilities #################################
"""
    IsRectVisible(size) -> Bool
    IsRectVisible(x, y) -> Bool
Test if rectangle (of given size, starting from cursor position) is visible / not clipped.
"""
IsRectVisible(size) = igIsRectVisible_Nil(size)
IsRectVisible(x, y) = IsRectVisible(ImVec2(x,y))

"""
    IsRectVisibleVec2(rect_min::ImVec2, rect_max::ImVec2) -> Bool
    IsRectVisibleVec2(rect_min::NTuple{2}, rect_max::NTuple{2}) -> Bool
Test if rectangle (in screen space) is visible / not clipped. to perform coarse clipping on user's side.
"""
IsRectVisibleVec2(rect_min, rect_max) = igIsRectVisible_Vec2(rect_min, rect_max)

"""
    GetTime() -> Cdouble
"""
GetTime() = igGetTime()

"""
    GetFrameCount() -> Cint
"""
GetFrameCount() = igGetFrameCount()

"""
    GetBackgroundDrawList() -> Ptr{ImDrawList}
This draw list will be the first rendering one. Useful to quickly draw shapes/text behind dear imgui contents.
"""
GetBackgroundDrawList() = igGetBackgroundDrawList_Nil()

"""
    GetForegroundDrawList() -> Ptr{ImDrawList}
this draw list will be the last rendered one. Useful to quickly draw shapes/text over dear imgui contents.
"""
GetForegroundDrawList() = igGetForegroundDrawList_Nil()

@deprecate GetOverlayDrawList() GetForegroundDrawList()

"""
    GetDrawListSharedData() -> Ptr{ImDrawListSharedData}
This function might be used when creating your own `ImDrawList` instances.
"""
GetDrawListSharedData() = igGetDrawListSharedData()

"""
    GetStyleColorName(idx::Integer) -> String
"""
GetStyleColorName(idx::Integer) = unsafe_string(igGetStyleColorName(idx))

"""
    SetStateStorage(storage)
Replace current window storage with our own (if you want to manipulate it yourself,
typically clear subsection of it)
"""
SetStateStorage(storage) = igSetStateStorage(storage)

"""
    GetStateStorage()
"""
GetStateStorage() = igGetStateStorage()

"""
    CalcTextSize(text, text_end=C_NULL, hide_text_after_double_hash=false, wrap_width=-1) -> ImVec2
"""
function CalcTextSize(text, text_end=C_NULL, hide_text_after_double_hash=false, wrap_width=-1)
    x = Ref{ImVec2}()
    igCalcTextSize(x, text, text_end, hide_text_after_double_hash, wrap_width)
    return x[]
end

"""
    BeginChildFrame(id, size, flags=0) -> Bool
Helper to create a child window / scrolling region that looks like a normal widget frame.
"""
BeginChildFrame(id, size, flags=0) = igBeginChildFrame(id, size, flags)

"""
    EndChildFrame()
!!! note
    Always call `EndChildFrame()` regardless of [`BeginChildFrame`](@ref) return values which
    indicates a collapsed/clipped window.
"""
EndChildFrame() = igEndChildFrame()

###################################### Color Utilities #####################################
"""
    ColorConvertU32ToFloat4(in) -> ImVec4
Convert `ImU32` color to `ImVec4`. You could use `Base.convert(::Type{ImVec4}, x::ImU32)` instead.
"""
function ColorConvertU32ToFloat4(in)
    x = Ref{ImVec4}()
    igColorConvertU32ToFloat4(x, in)
    return x[]
end

"""
    ColorConvertFloat4ToU32(in) -> ImU32
Convert `ImVec4` color to `ImU32`. You could use `Base.convert(::Type{ImU32}, x::ImVec4)` instead.
"""
ColorConvertFloat4ToU32(in) = igColorConvertFloat4ToU32(in)

ColorConvertRGBtoHSV(r, g, b, out_h, out_s, out_v) = igColorConvertRGBtoHSV(r, g, b, out_h, out_s, out_v)
ColorConvertHSVtoRGB(h, s, v, out_r, out_g, out_b) = igColorConvertHSVtoRGB(h, s, v, out_r, out_g, out_b)

##################################### Inputs Utilities #####################################
"""
    GetKeyIndex(imgui_key) -> Cint
Map ImGuiKey_* values into user's key index. == io.KeyMap[key]
"""
GetKeyIndex(imgui_key) = igGetKeyIndex(imgui_key)

"""
    IsKeyDown(user_key_index) -> Bool
Is key being held. == io.KeysDown[user_key_index]. note that imgui doesn't know the semantic
of each entry of io.KeysDown[]. Use your own indices/enums according to how your backend/engine
stored them into io.KeysDown[]!
"""
IsKeyDown(user_key_index) = igIsKeyDown_Nil(user_key_index)

"""
    IsKeyPressed(user_key_index, repeat=true) -> Bool
Was key pressed (went from !Down to Down). If repeat=true, uses io.KeyRepeatDelay / KeyRepeatRate.
"""
IsKeyPressed(user_key_index, repeat=true) = igIsKeyPressed_Bool(user_key_index, repeat)

"""
    IsKeyReleased(user_key_index) -> Bool
Was key released (went from Down to !Down).
"""
IsKeyReleased(user_key_index) = igIsKeyReleased_Nil(user_key_index)

"""
    GetKeyPressedAmount(key_index, repeat_delay, rate) -> Cint
Uses provided repeat rate/delay. Return a count, most often 0 or 1 but might be >1 if RepeatRate
is small enough that DeltaTime > RepeatRate
"""
GetKeyPressedAmount(key_index, repeat_delay, rate) = igGetKeyPressedAmount(key_index, repeat_delay, rate)

"""
    SetNextFrameWantCaptureKeyboard(capture=true)
Manually override io.WantCaptureKeyboard flag next frame (said flag is entirely left for
your application to handle). e.g. force capture keyboard when your widget is being hovered.
"""
SetNextFrameWantCaptureKeyboard(capture=true) = igSetNextFrameWantCaptureKeyboard(capture)
@deprecate CaptureKeyboardFromApp(capture) SetNextFrameWantCaptureKeyboard(capture)

"""
    IsMouseDown(button) -> Bool
Is mouse button held (0=left, 1=right, 2=middle).
"""
IsMouseDown(button) = igIsMouseDown_Nil(button)

"""
    IsAnyMouseDown() -> Bool
Is any mouse button held.
"""
IsAnyMouseDown() = igIsAnyMouseDown()

"""
    IsMouseClicked(button, repeat=false) -> Bool
Did mouse button clicked (went from !Down to Down) (0=left, 1=right, 2=middle)
"""
IsMouseClicked(button, repeat=false) = igIsMouseClicked_Bool(button, repeat)

"""
    IsMouseDoubleClicked(button) -> Bool
Did mouse button double-clicked. a double-click returns false in [`IsMouseClicked`](@ref).
Uses io.MouseDoubleClickTime.
"""
IsMouseDoubleClicked(button) = igIsMouseDoubleClicked(button)

"""
    IsMouseReleased(button) -> Bool
Did mouse button released (went from Down to !Down).
"""
IsMouseReleased(button) = igIsMouseReleased_Nil(button)

"""
    IsMouseDragging(button=0, lock_threshold=-1.0) -> Bool
Is mouse dragging. If lock_threshold < -1.0f uses io.MouseDraggingThreshold.
"""
IsMouseDragging(button=0, lock_threshold=-1.0) = igIsMouseDragging(button, lock_threshold)

"""
    IsMouseHoveringRect(r_min, r_max, clip=true) -> Bool
Is mouse hovering given bounding rect (in screen space). Clipped by current clipping settings,
but disregarding of other consideration of focus/window ordering/popup-block.
"""
IsMouseHoveringRect(r_min, r_max, clip=true) = igIsMouseHoveringRect(r_min, r_max, clip)

"""
    IsMousePosValid(mouse_pos=C_NULL) -> Bool
"""
IsMousePosValid(mouse_pos=C_NULL) = igIsMousePosValid(mouse_pos)

"""
    GetMousePos() -> ImVec2
Shortcut to ImGui::GetIO().MousePos provided by user, to be consistent with other calls.
"""
function GetMousePos()
    x = Ref{ImVec2}()
    igGetMousePos(x)
    return x[]
end

"""
    GetMousePosOnOpeningCurrentPopup() -> ImVec2
Retrieve backup of mouse position at the time of opening popup we have [`BeginPopup`](@ref) into.
"""
function GetMousePosOnOpeningCurrentPopup()
    x = Ref{ImVec2}()
    igGetMousePosOnOpeningCurrentPopup(x)
    return x[]
end

"""
    GetMouseDragDelta(button=0, lock_threshold=-1.0) -> ImVec2
Dragging amount since clicking. if lock_threshold < -1.0f uses io.MouseDraggingThreshold.
"""
function GetMouseDragDelta(button=0, lock_threshold=-1.0)
    x = Ref{ImVec2}()
    igGetMouseDragDelta(x, button, lock_threshold)
    return x[]
end

"""
    ResetMouseDragDelta(button=0)
"""
ResetMouseDragDelta(button=0) = igResetMouseDragDelta(button)

"""
    GetMouseCursor() -> ImGuiMouseCursor
Get desired cursor type, reset in ImGui::NewFrame(), this is updated during the frame.
valid before [`Render`](@ref). If you use software rendering by setting io.MouseDrawCursor ImGui will render those for you.
"""
GetMouseCursor() = igGetMouseCursor()

"""
    SetMouseCursor(type)
Set desired cursor type.
"""
SetMouseCursor(type) = igSetMouseCursor(type)

"""
    CaptureMouseFromApp(capture=true)
Manually override io.WantCaptureMouse flag next frame (said flag is entirely left for your
application to handle).
"""
SetNextFrameWantCaptureMouse(capture=true) = igSetNextFrameWantCaptureMouse(capture)
@deprecate CaptureMouseFromApp(capture) SetNextFrameWantCaptureMouse(capture)

#################################### Clipboard Utilities ###################################
"""
    GetClipboardText() -> String
"""
GetClipboardText() = unsafe_string(igGetClipboardText())

"""
    SetClipboardText(text)
"""
SetClipboardText(text) = igSetClipboardText(text)

################################## Settings/.Ini Utilities #################################
"""
    LoadIniSettingsFromDisk(ini_filename)
Call after [`CreateContext`](@ref) and before the first call to [`NewFrame`](@ref).
[`NewFrame`](@ref) automatically calls `LoadIniSettingsFromDisk(ImGuiIO.IniFilename)`.

!!! tip
    The disk functions are automatically called if `ImGuiIO.IniFilename` != C_NULL (default is "imgui.ini").
    Set `ImGuiIO.IniFilename` to C_NULL to load/save manually.
    Read `ImGuiIO.WantSaveIniSettings` description about handling `.ini` saving manually.
"""
LoadIniSettingsFromDisk(ini_filename) = igLoadIniSettingsFromDisk(ini_filename)

"""
    LoadIniSettingsFromMemory(ini_data, ini_size=0)
Call after [`CreateContext`](@ref) and before the first call to [`NewFrame`](@ref) to
provide `.ini` data from your own data source.
"""
LoadIniSettingsFromMemory(ini_data, ini_size=0) = igLoadIniSettingsFromMemory(ini_data, ini_size)

"""
    SaveIniSettingsToDisk(ini_filename)
"""
SaveIniSettingsToDisk(ini_filename) = igSaveIniSettingsToDisk(ini_filename)

"""
    SaveIniSettingsToMemory(out_ini_size=C_NULL)
Return a zero-terminated string with the `.ini` data which you can save by your own mean.
Call when `ImGuiIO.WantSaveIniSettings` is set, then save data by your own mean and clear
`ImGuiIO.WantSaveIniSettings`.
"""
SaveIniSettingsToMemory(out_ini_size=C_NULL) = igSaveIniSettingsToMemory(out_ini_size)

##################################### Memory Utilities #####################################
# All those functions are not reliant on the current context.
# If you reload the contents of imgui.cpp at runtime, you may need to call SetCurrentContext() + SetAllocatorFunctions() again.
SetAllocatorFunctions(alloc_func, free_func, user_data) = igSetAllocatorFunctions(alloc_func, free_func, user_data)
MemAlloc(size) = igMemAlloc(size)
MemFree(ptr) = igMemFree(ptr)

######################################## ImDrawList ########################################
# TODO: find out the use case
# ImDrawList_ImDrawList(shared_data)
# ImDrawList_destroy(handle)

"""
    PushClipRect(handle::Ptr{ImDrawList}, clip_rect_min, clip_rect_max, intersect_with_current_clip_rect)
Render-level scissoring. This is passed down to your render function but not used for CPU-side
coarse clipping. Prefer using higher-level [`PushClipRect`](@ref) to affect logic (hit-testing
and widget culling).
"""
PushClipRect(handle::Ptr{ImDrawList}, clip_rect_min, clip_rect_max, intersect_with_current_clip_rect) = ImDrawList_PushClipRect(handle, clip_rect_min, clip_rect_max, intersect_with_current_clip_rect)

"""
    PushClipRectFullScreen(handle::Ptr{ImDrawList})
"""
PushClipRectFullScreen(handle::Ptr{ImDrawList}) = ImDrawList_PushClipRectFullScreen(handle)

"""
    PopClipRect(handle::Ptr{ImDrawList})
"""
PopClipRect(handle::Ptr{ImDrawList}) = ImDrawList_PopClipRect(handle)

"""
    PushTextureID(handle::Ptr{ImDrawList}, texture_id)
"""
PushTextureID(handle::Ptr{ImDrawList}, texture_id) = ImDrawList_PushTextureID(handle, texture_id)

"""
    PopTextureID(handle::Ptr{ImDrawList})
"""
PopTextureID(handle::Ptr{ImDrawList}) = ImDrawList_PopTextureID(handle)

"""
    GetClipRectMin(handle::Ptr{ImDrawList}) -> ImVec2
"""
function GetClipRectMin(handle::Ptr{ImDrawList})
    x = Ref{ImVec2}()
    ImDrawList_GetClipRectMin(x, handle)
    return x[]
end

"""
    GetClipRectMax(handle::Ptr{ImDrawList}) -> ImVec2
"""
function GetClipRectMax(handle::Ptr{ImDrawList})
    x = Ref{ImVec2}()
    ImDrawList_GetClipRectMax(x, handle)
    return x[]
end

"""
    AddLine(handle::Ptr{ImDrawList}, a, b, col, thickness=1.0)
"""
AddLine(handle::Ptr{ImDrawList}, a, b, col, thickness=1.0) = ImDrawList_AddLine(handle, a, b, col, thickness)

"""
    AddRect(handle::Ptr{ImDrawList}, a, b, col, rounding=0.0, rounding_corners_flags=ImDrawFlags_RoundCornersAll, thickness=1.0)
### Arguments
- `a`: upper-left
- `b`: lower-right
- `rounding_corners_flags`: 4-bits corresponding to which corner to round
"""
AddRect(handle::Ptr{ImDrawList}, a, b, col, rounding=0.0, rounding_corners_flags=ImDrawFlags_RoundCornersAll, thickness=1.0) = ImDrawList_AddRect(handle, a, b, col, rounding, rounding_corners_flags, thickness)

"""
    AddRectFilled(handle::Ptr{ImDrawList}, a, b, col, rounding=0.0, rounding_corners_flags=ImDrawFlags_RoundCornersAll)
### Arguments
- `a`: upper-left
- `b`: lower-right
"""
AddRectFilled(handle::Ptr{ImDrawList}, a, b, col, rounding=0.0, rounding_corners_flags=ImDrawFlags_RoundCornersAll) = ImDrawList_AddRectFilled(handle, a, b, col, rounding, rounding_corners_flags)

"""
    AddRectFilledMultiColor(handle::Ptr{ImDrawList}, a, b, col_upr_left, col_upr_right, col_bot_right, col_bot_left)
"""
AddRectFilledMultiColor(handle::Ptr{ImDrawList}, a, b, col_upr_left, col_upr_right, col_bot_right, col_bot_left) = ImDrawList_AddRectFilledMultiColor(handle, a, b, col_upr_left, col_upr_right, col_bot_right, col_bot_left)

"""
    AddQuad(handle::Ptr{ImDrawList}, a, b, c, d, col, thickness=1.0)
"""
AddQuad(handle::Ptr{ImDrawList}, a, b, c, d, col, thickness=1.0) = ImDrawList_AddQuad(handle, a, b, c, d, col, thickness)

"""
    AddQuadFilled(handle::Ptr{ImDrawList}, a, b, c, d, col)
"""
AddQuadFilled(handle::Ptr{ImDrawList}, a, b, c, d, col) = ImDrawList_AddQuadFilled(handle, a, b, c, d, col)

"""
    AddTriangle(handle::Ptr{ImDrawList}, a, b, c, col, thickness=1.0)
"""
AddTriangle(handle::Ptr{ImDrawList}, a, b, c, col, thickness=1.0) = ImDrawList_AddTriangle(handle, a, b, c, col, thickness)

"""
    AddTriangleFilled(handle::Ptr{ImDrawList}, a, b, c, col)
"""
AddTriangleFilled(handle::Ptr{ImDrawList}, a, b, c, col) = ImDrawList_AddTriangleFilled(handle, a, b, c, col)

"""
    AddCircle(handle::Ptr{ImDrawList}, centre, radius, col, num_segments=12, thickness=1.0)
"""
AddCircle(handle::Ptr{ImDrawList}, centre, radius, col, num_segments=12, thickness=1.0) = ImDrawList_AddCircle(handle, centre, radius, col, num_segments, thickness)

"""
    AddCircleFilled(handle::Ptr{ImDrawList}, centre, radius, col, num_segments=12)
"""
AddCircleFilled(handle::Ptr{ImDrawList}, centre, radius, col, num_segments=12) = ImDrawList_AddCircleFilled(handle, centre, radius, col, num_segments)

"""
    AddText(handle::Ptr{ImDrawList}, pos, col, text_begin, text_end=C_NULL)
"""
AddText(handle::Ptr{ImDrawList}, pos, col, text_begin, text_end=C_NULL) = ImDrawList_AddText_Vec2(handle, pos, col, text_begin, text_end)

"""
    AddText(handle::Ptr{ImDrawList}, font::Ptr{ImFont}, font_size, pos, col, text_begin, text_end=C_NULL, wrap_width=0.0, cpu_fine_clip_rect=C_NULL)
"""
AddText(handle::Ptr{ImDrawList}, font::Ptr{ImFont}, font_size, pos, col, text_begin, text_end=C_NULL, wrap_width=0.0, cpu_fine_clip_rect=C_NULL) = ImDrawList_AddText_FontPtr(handle, font, font_size, pos, col, text_begin, text_end, wrap_width, cpu_fine_clip_rect)

"""
    AddImage(handle::Ptr{ImDrawList}, user_texture_id, a, b, uv_a=(0,0), uv_b=(1,1), col=0xffffffff)
"""
AddImage(handle::Ptr{ImDrawList}, user_texture_id, a, b, uv_a=ImVec2(0,0), uv_b=ImVec2(1,1), col=0xffffffff) = ImDrawList_AddImage(handle, user_texture_id, a, b, uv_a, uv_b, col)

"""
    AddImageQuad(handle::Ptr{ImDrawList}, user_texture_id, a, b, c, d, uv_a=(0,0), uv_b=(1,0), uv_c=(1,1), uv_d=(0,1), col=0xffffffff)
"""
AddImageQuad(handle::Ptr{ImDrawList}, user_texture_id, a, b, c, d, uv_a=ImVec2(0,0), uv_b=ImVec2(1,0), uv_c=ImVec2(1,1), uv_d=ImVec2(0,1), col=0xffffffff) = ImDrawList_AddImageQuad(handle, user_texture_id, a, b, c, d, uv_a, uv_b, uv_c, uv_d, col)

"""
    AddImageRounded(handle::Ptr{ImDrawList}, user_texture_id, a, b, uv_a, uv_b, col, rounding, rounding_corners=ImDrawFlags_All)
"""
AddImageRounded(handle::Ptr{ImDrawList}, user_texture_id, a, b, uv_a, uv_b, col, rounding, rounding_corners=ImDrawFlags_RoundCornersAll) = ImDrawList_AddImageRounded(handle, user_texture_id, a, b, uv_a, uv_b, col, rounding, rounding_corners)

"""
    AddPolyline(handle::Ptr{ImDrawList}, points, num_points, col, closed, thickness)
"""
AddPolyline(handle::Ptr{ImDrawList}, points, num_points, col, closed, thickness) = ImDrawList_AddPolyline(handle, points, num_points, col, closed, thickness)

"""
    AddConvexPolyFilled(handle::Ptr{ImDrawList}, points, num_points, col)
!!! note
    Anti-aliased filling requires points to be in clockwise order.
"""
AddConvexPolyFilled(handle::Ptr{ImDrawList}, points, num_points, col) = ImDrawList_AddConvexPolyFilled(handle, points, num_points, col)

"""
    AddBezierCubic(handle::Ptr{ImDrawList}, pos0, cp0, cp1, pos1, col, thickness, num_segments=0)
"""
AddBezierCubic(handle::Ptr{ImDrawList}, pos0, cp0, cp1, pos1, col, thickness, num_segments=0) = ImDrawList_AddBezierCubic(handle, pos0, cp0, cp1, pos1, col, thickness, num_segments)
@deprecate AddBezierCurve(handle, pos0, cp0, cp1, pos1, col, thickness, num_segments) AddBezierCubic(handle, pos0, cp0, cp1, pos1, col, thickness, num_segments)

"""
    PathClear(handle::Ptr{ImDrawList})
Stateful path API, add points then finish with [`PathFillConvex`](@ref) or [`PathStroke`](@ref).
"""
PathClear(handle::Ptr{ImDrawList}) = ImDrawList_PathClear(handle)

"""
    PathLineTo(handle::Ptr{ImDrawList}, pos)
Stateful path API, add points then finish with [`PathFillConvex`](@ref) or [`PathStroke`](@ref).
"""
PathLineTo(handle::Ptr{ImDrawList}, pos) = ImDrawList_PathLineTo(handle, pos)

"""
    PathLineToMergeDuplicate(handle::Ptr{ImDrawList}, pos)
Stateful path API, add points then finish with [`PathFillConvex`](@ref) or [`PathStroke`](@ref).
"""
PathLineToMergeDuplicate(handle::Ptr{ImDrawList}, pos) = ImDrawList_PathLineToMergeDuplicate(handle, pos)

"""
    PathFillConvex(handle::Ptr{ImDrawList}, col)
!!! note
    Anti-aliased filling requires points to be in clockwise order.
"""
PathFillConvex(handle::Ptr{ImDrawList}, col) = ImDrawList_PathFillConvex(handle, col)

"""
    PathStroke(handle::Ptr{ImDrawList}, col, closed, thickness=1.0)
"""
PathStroke(handle::Ptr{ImDrawList}, col, closed, thickness=1.0) = ImDrawList_PathStroke(handle, col, closed, thickness)

"""
    PathArcTo(handle::Ptr{ImDrawList}, centre, radius, a_min, a_max, num_segments=10)
Stateful path API, add points then finish with [`PathFillConvex`](@ref) or [`PathStroke`](@ref).
"""
PathArcTo(handle::Ptr{ImDrawList}, centre, radius, a_min, a_max, num_segments=10) = ImDrawList_PathArcTo(handle, centre, radius, a_min, a_max, num_segments)

"""
    PathArcToFast(handle::Ptr{ImDrawList}, centre, radius, a_min_of_12, a_max_of_12)
Stateful path API, add points then finish with [`PathFillConvex`](@ref) or [`PathStroke`](@ref).
"""
PathArcToFast(handle::Ptr{ImDrawList}, centre, radius, a_min_of_12, a_max_of_12) = ImDrawList_PathArcToFast(handle, centre, radius, a_min_of_12, a_max_of_12)

"""
    PathBezierCurveTo(handle::Ptr{ImDrawList}, p1, p2, p3, num_segments=0)
Stateful path API, add points then finish with [`PathFillConvex`](@ref) or [`PathStroke`](@ref).
"""
PathBezierCubicTo(handle::Ptr{ImDrawList}, p1, p2, p3, num_segments=0) = ImDrawList_PathBezierCubicCurveTo(handle, p1, p2, p3, num_segments)
@deprecate PathBezierCurveTo(handle, p1, p2, p3, num_segments=0) PathBezierCubicTo(handle, p1, p2, p3, num_segments)

"""
    PathRect(handle::Ptr{ImDrawList}, rect_min, rect_max, rounding=0.0, rounding_corners_flags=ImDrawFlags_RoundCornersAll)
Stateful path API, add points then finish with [`PathFillConvex`](@ref) or [`PathStroke`](@ref).
"""
PathRect(handle::Ptr{ImDrawList}, rect_min, rect_max, rounding=0.0, rounding_corners_flags=ImDrawFlags_RoundCornersAll) = ImDrawList_PathRect(handle, rect_min, rect_max, rounding, rounding_corners_flags)

"""
    ChannelsSplit(handle::Ptr{ImDrawList}, channels_count)
!!! tip
    - Use to simulate layers. By switching channels to can render out-of-order (e.g. submit
        foreground primitives before background primitives)
    - Use to minimize draw calls (e.g. if going back-and-forth between multiple non-overlapping
        clipping rectangles, prefer to append into separate channels then merge at the end)
"""
ChannelsSplit(handle::Ptr{ImDrawList}, channels_count) = ImDrawList_ChannelsSplit(handle, channels_count)

"""
    ChannelsMerge(handle::Ptr{ImDrawList})
!!! tip
    - Use to simulate layers. By switching channels to can render out-of-order (e.g. submit
        foreground primitives before background primitives)
    - Use to minimize draw calls (e.g. if going back-and-forth between multiple non-overlapping
        clipping rectangles, prefer to append into separate channels then merge at the end)
"""
ChannelsMerge(handle::Ptr{ImDrawList}) = ImDrawList_ChannelsMerge(handle)

"""
    ChannelsSetCurrent(handle::Ptr{ImDrawList}, channel_index)
!!! tip
    - Use to simulate layers. By switching channels to can render out-of-order (e.g. submit
        foreground primitives before background primitives)
    - Use to minimize draw calls (e.g. if going back-and-forth between multiple non-overlapping
        clipping rectangles, prefer to append into separate channels then merge at the end)
"""
ChannelsSetCurrent(handle::Ptr{ImDrawList}, channel_index) = ImDrawList_ChannelsSetCurrent(handle, channel_index)

"""
    AddCallback(handle::Ptr{ImDrawList}, callback, callback_data)
Your rendering function must check for `UserCallback` in ImDrawCmd and call the function
instead of rendering triangles.
"""
AddCallback(handle::Ptr{ImDrawList}, callback, callback_data) = ImDrawList_AddCallback(handle, callback, callback_data)

"""
    AddDrawCmd(handle::Ptr{ImDrawList})
This is useful if you need to forcefully create a new draw call (to allow for dependent
rendering / blending). Otherwise primitives are merged into the same draw-call as much as possible.
"""
AddDrawCmd(handle::Ptr{ImDrawList}) = ImDrawList_AddDrawCmd(handle)

"""
    CloneOutput(handle::Ptr{ImDrawList}) -> Ptr{ImDrawList}
Create a clone of the CmdBuffer/IdxBuffer/VtxBuffer.
"""
CloneOutput(handle::Ptr{ImDrawList}) = ImDrawList_CloneOutput(handle)

"""
    PrimReserve(handle::Ptr{ImDrawList}, idx_count, vtx_count)
!!! note
    All primitives needs to be reserved via [`PrimReserve`](@ref) beforehand!
"""
PrimReserve(handle::Ptr{ImDrawList}, idx_count, vtx_count) = ImDrawList_PrimReserve(handle, idx_count, vtx_count)

"""
    PrimRect(handle::Ptr{ImDrawList}, a, b, col)
Axis aligned rectangle (composed of two triangles).

!!! note
    All primitives needs to be reserved via [`PrimReserve`](@ref) beforehand!
"""
PrimRect(handle::Ptr{ImDrawList}, a, b, col) = ImDrawList_PrimRect(handle, a, b, col)

"""
    PrimRectUV(handle::Ptr{ImDrawList}, a, b, uv_a, uv_b, col)
!!! note
    All primitives needs to be reserved via [`PrimReserve`](@ref) beforehand!
"""
PrimRectUV(handle::Ptr{ImDrawList}, a, b, uv_a, uv_b, col) = ImDrawList_PrimRectUV(handle, a, b, uv_a, uv_b, col)

"""
    PrimQuadUV(handle::Ptr{ImDrawList}, a, b, c, d, uv_a, uv_b, uv_c, uv_d, col)
!!! note
    All primitives needs to be reserved via [`PrimReserve`](@ref) beforehand!
"""
PrimQuadUV(handle::Ptr{ImDrawList}, a, b, c, d, uv_a, uv_b, uv_c, uv_d, col) = ImDrawList_PrimQuadUV(handle, a, b, c, d, uv_a, uv_b, uv_c, uv_d, col)

"""
    PrimWriteVtx(handle::Ptr{ImDrawList}, pos, uv, col)
!!! note
    All primitives needs to be reserved via [`PrimReserve`](@ref) beforehand!
"""
PrimWriteVtx(handle::Ptr{ImDrawList}, pos, uv, col) = ImDrawList_PrimWriteVtx(handle, pos, uv, col)

"""
    PrimWriteIdx(handle::Ptr{ImDrawList}, idx)
!!! note
    All primitives needs to be reserved via [`PrimReserve`](@ref) beforehand!
"""
PrimWriteIdx(handle::Ptr{ImDrawList}, idx) = ImDrawList_PrimWriteIdx(handle, idx)

"""
    PrimVtx(handle::Ptr{ImDrawList}, pos, uv, col)
!!! note
    All primitives needs to be reserved via [`PrimReserve`](@ref) beforehand!
"""
PrimVtx(handle::Ptr{ImDrawList}, pos, uv, col) = ImDrawList_PrimVtx(handle, pos, uv, col)


###################################### ImGuiTextBuffer #####################################
"""
    TextBuffer() -> Ptr{ImGuiTextBuffer}
Helper: Growable text buffer for logging/accumulating text
"""
TextBuffer() = ImGuiTextBuffer_ImGuiTextBuffer()

"""
    Destroy(handle::Ptr{ImGuiTextBuffer})
"""
Destroy(handle::Ptr{ImGuiTextBuffer}) = ImGuiTextBuffer_destroy(handle)

"""
    Begin(handle::Ptr{ImGuiTextBuffer}) -> Cstring
"""
Begin(handle::Ptr{ImGuiTextBuffer}) = ImGuiTextBuffer_begin(handle)

"""
    End(handle::Ptr{ImGuiTextBuffer}) -> Cstring
"""
End(handle::Ptr{ImGuiTextBuffer}) = ImGuiTextBuffer_end(handle)

"""
    Size(handle::Ptr{ImGuiTextBuffer}) -> Cint
"""
Size(handle::Ptr{ImGuiTextBuffer}) = ImGuiTextBuffer_size(handle)

"""
    Empty(handle::Ptr{ImGuiTextBuffer}) -> Bool
"""
Empty(handle::Ptr{ImGuiTextBuffer}) = ImGuiTextBuffer_empty(handle)

"""
    Clear(handle::Ptr{ImGuiTextBuffer})
"""
Clear(handle::Ptr{ImGuiTextBuffer}) = ImGuiTextBuffer_clear(handle)

"""
    Reserve(handle::Ptr{ImGuiTextBuffer})
"""
Reserve(handle::Ptr{ImGuiTextBuffer}) = ImGuiTextBuffer_reserve(handle)

"""
    C_str(handle::Ptr{ImGuiTextBuffer}) -> Cstring
"""
C_str(handle::Ptr{ImGuiTextBuffer}) = ImGuiTextBuffer_c_str(handle)

"""
    Append(handle::Ptr{ImGuiTextBuffer}, str, str_end=C_NULL)
Text buffer for logging/accumulating text.
"""
Append(handle::Ptr{ImGuiTextBuffer}, str, str_end=C_NULL) = ImGuiTextBuffer_append(handle, str, str_end)

# """
#     Appendf(handle::Ptr{ImGuiTextBuffer}, formatted_text)
# Text buffer for logging/accumulating text.
#
# !!! warning "Limited support"
#     Formatting is not supported which means you need to pass a formatted string to this function.
#     It's recommended to use Julia stdlib `Printf`'s `@sprintf` as a workaround when translating
#     C/C++ code to Julia.
# """
# Appendf(handle::Ptr{ImGuiTextBuffer}, formatted_text) = ImGuiTextBuffer_appendf(handle, formatted_text)

########################################## ImColor #########################################
"""
    HSV(h, s, v, a=1.0) -> ImVec4
"""
function HSV(h, s, v, a=1.0)
    out_r, out_g, out_b = Cfloat(0), Cfloat(0), Cfloat(0)
    @c igColorConvertHSVtoRGB(h, s, v, &out_r, &out_g, &out_b)
    return ImVec4(out_r, out_g, out_b, a)
end

##################################### ImGuiListClipper #####################################
"""
    Clipper() -> Ptr{ImGuiListClipper}
Manually clip large list of items.

If you are submitting lots of evenly spaced items and you have a random access to the list,
you can perform coarse clipping based on visibility to save yourself from processing those items at all.

If you are submitting lots of evenly spaced items and you have a random access to the list,
you can perform coarse clipping based on visibility to save yourself from processing those items at all.

The clipper calculates the range of visible items and advance the cursor to compensate for the
non-visible items we have skipped. ImGui already clip items based on their bounds but it needs
to measure text size to do so. Coarse clipping before submission makes this cost and your own data
fetching/submission cost null.

### Example
```julia
clipper = CImGui.Clipper()
Begin(clipper, 1000)  # we have 1000 elements, evenly spaced.
while CImGui.Step()
    dis_start = CImGui.Get(clipper, :DisplayStart)
    dis_end = CImGui.Get(clipper, :DisplayEnd)-1
    foreach(i->CImGui.Text("line number \$i"), dis_start:dis_end)
end
```
- Step 0: the clipper let you process the first element, regardless of it being visible or not,
    so we can measure the element height (step skipped if we passed a known height as second
    arg to constructor).
- Step 1: the clipper infer height from first element, calculate the actual range of elements
    to display, and position the cursor before the first element.
- (Step 2: dummy step only required if an explicit items_height was passed to constructor
    or [`Begin`](@ref) and user call [`Step`](@ref). Does nothing and switch to Step 3.)
- Step 3: the clipper validate that we have reached the expected Y position (corresponding
    to element DisplayEnd), advance the cursor to the end of the list and then returns `false`
    to end the loop.

### Arguments
- `items_count`: use -1 to ignore (you can call Begin later).
    use `INT_MAX` if you don't know how many items you have (in which case the cursor won't
    be advanced in the final step).
- `items_height`: use -1.0 to be calculated automatically on first step.
    otherwise pass in the distance between your items, typically [`GetTextLineHeightWithSpacing`](@ref)
    or [`GetFrameHeightWithSpacing`](@ref). If you don't specify an `items_height`, you NEED to call
    [`Step`](@ref). If you specify `items_height` you may call the old [`Begin`](@ref)/[`End`](@ref)
    api directly, but prefer calling [`Step`](@ref).
"""
Clipper() = ImGuiListClipper_ImGuiListClipper()

"""
    Destroy(handle::Ptr{ImGuiListClipper})
"""
Destroy(handle::Ptr{ImGuiListClipper}) = ImGuiListClipper_destroy(handle)

"""
    Step(handle::Ptr{ImGuiListClipper}) -> Bool
Call until it returns false. The DisplayStart/DisplayEnd fields will be set and you can
process/draw those items.
"""
Step(handle::Ptr{ImGuiListClipper}) = ImGuiListClipper_Step(handle)

"""
    Begin(handle::Ptr{ImGuiListClipper}, items_count, items_height=-1.0)
Automatically called by constructor if you passed `items_count` or by [`Step`](@ref) in Step 1.
"""
Begin(handle::Ptr{ImGuiListClipper}, items_count, items_height=-1.0) = ImGuiListClipper_Begin(handle, items_count, items_height)

"""
    End(handle::Ptr{ImGuiListClipper})
Automatically called on the last call of [`Step`](@ref) that returns false.
"""
End(handle::Ptr{ImGuiListClipper}) = ImGuiListClipper_End(handle)

######################################## ImFontAtlas #######################################
"""
    AddFont(self::Ptr{ImFontAtlas}, font_cfg) -> Ptr{ImFont}
"""
AddFont(self::Ptr{ImFontAtlas}, font_cfg) = ImFontAtlas_AddFont(self, font_cfg)

"""
    AddFontDefault(self::Ptr{ImFontAtlas}, font_cfg=C_NULL) -> Ptr{ImFont}
"""
AddFontDefault(self::Ptr{ImFontAtlas}, font_cfg=C_NULL) = ImFontAtlas_AddFontDefault(self, font_cfg)

"""
    AddFontFromFileTTF(self::Ptr{ImFontAtlas}, filename, size_pixels, font_cfg=C_NULL, glyph_ranges=C_NULL) -> Ptr{ImFont}
"""
AddFontFromFileTTF(self::Ptr{ImFontAtlas}, filename, size_pixels, font_cfg=C_NULL, glyph_ranges=C_NULL) = ImFontAtlas_AddFontFromFileTTF(self, filename, size_pixels, font_cfg, glyph_ranges)

"""
    AddFontFromMemoryTTF(self::Ptr{ImFontAtlas}, font_data, font_size, size_pixels, font_cfg=C_NULL, glyph_ranges=C_NULL) -> Ptr{ImFont}
!!! note
    Transfer ownership of 'ttf_data' to ImFontAtlas! Will be deleted after destruction of the atlas.
    Set `font_cfg.FontDataOwnedByAtlas=false` to keep ownership of your data and it won't be freed.
"""
AddFontFromMemoryTTF(self::Ptr{ImFontAtlas}, font_data, font_size, size_pixels, font_cfg=C_NULL, glyph_ranges=C_NULL) = ImFontAtlas_AddFontFromMemoryTTF(self, font_data, font_size, size_pixels, font_cfg, glyph_ranges)

"""
    AddFontFromMemoryCompressedTTF(self::Ptr{ImFontAtlas}, compressed_font_data, compressed_font_size, size_pixels, font_cfg=C_NULL, glyph_ranges=C_NULL) -> Ptr{ImFont}
'compressed_font_data' still owned by caller.
"""
AddFontFromMemoryCompressedTTF(self::Ptr{ImFontAtlas}, compressed_font_data, compressed_font_size, size_pixels, font_cfg=C_NULL, glyph_ranges=C_NULL) = ImFontAtlas_AddFontFromMemoryCompressedTTF(self, compressed_font_data, compressed_font_size, size_pixels, font_cfg, glyph_ranges)

"""
    AddFontFromMemoryCompressedBase85TTF(self::Ptr{ImFontAtlas}, compressed_font_data_base85, size_pixels, font_cfg=C_NULL, glyph_ranges=C_NULL) -> Ptr{ImFont}
'compressed_font_data_base85' still owned by caller.
"""
AddFontFromMemoryCompressedBase85TTF(self::Ptr{ImFontAtlas}, compressed_font_data_base85, size_pixels, font_cfg=C_NULL, glyph_ranges=C_NULL) = ImFontAtlas_AddFontFromMemoryCompressedBase85TTF(self, compressed_font_data_base85, size_pixels, font_cfg, glyph_ranges)

"""
    ClearInputData(self::Ptr{ImFontAtlas})
Clear input data (all ImFontConfig structures including sizes, TTF data, glyph ranges, etc.) = all
the data used to build the texture and fonts.
"""
ClearInputData(self::Ptr{ImFontAtlas}) = ImFontAtlas_ClearInputData(self)

"""
    ClearTexData(self::Ptr{ImFontAtlas})
Clear output texture data (CPU side). Saves RAM once the texture has been copied to graphics memory.
"""
ClearTexData(self::Ptr{ImFontAtlas}) = ImFontAtlas_ClearTexData(self)

"""
    ClearFonts(self::Ptr{ImFontAtlas})
Clear output font data (glyphs storage, UV coordinates).
"""
ClearFonts(self::Ptr{ImFontAtlas}) = ImFontAtlas_ClearFonts(self)

"""
    Clear(self::Ptr{ImFontAtlas})
Clear all input and output.
"""
Clear(self::Ptr{ImFontAtlas}) = ImFontAtlas_Clear(self)

"""
    Build(self::Ptr{ImFontAtlas}) -> Bool
Build pixels data. This is called automatically for you by the GetTexData*** functions.
"""
Build(self::Ptr{ImFontAtlas}) = ImFontAtlas_Build(self)

"""
    IsBuilt(self::Ptr{ImFontAtlas}) -> Bool
"""
IsBuilt(self::Ptr{ImFontAtlas}) = ImFontAtlas_IsBuilt(self)

"""
    GetTexDataAsAlpha8(self::Ptr{ImFontAtlas}, out_pixels, out_width, out_height, out_bytes_per_pixel=C_NULL)
1 byte per-pixel.
"""
GetTexDataAsAlpha8(self::Ptr{ImFontAtlas}, out_pixels, out_width, out_height, out_bytes_per_pixel=C_NULL) = ImFontAtlas_GetTexDataAsAlpha8(self, out_pixels, out_width, out_height, out_bytes_per_pixel)

"""
    GetTexDataAsRGBA32(self::Ptr{ImFontAtlas}, out_pixels, out_width, out_height, out_bytes_per_pixel=C_NULL)
4 bytes-per-pixel.
"""
GetTexDataAsRGBA32(self::Ptr{ImFontAtlas}, out_pixels, out_width, out_height, out_bytes_per_pixel=C_NULL) = ImFontAtlas_GetTexDataAsRGBA32(self, out_pixels, out_width, out_height, out_bytes_per_pixel)

"""
    SetTexID(self::Ptr{ImFontAtlas}, id)
"""
SetTexID(self::Ptr{ImFontAtlas}, id) = ImFontAtlas_SetTexID(self, id)

"""
    GetGlyphRangesDefault(self::Ptr{ImFontAtlas}) -> Ptr{ImWchar}
Basic Latin, Extended Latin.
"""
GetGlyphRangesDefault(self::Ptr{ImFontAtlas}) = ImFontAtlas_GetGlyphRangesDefault(self)

"""
    GetGlyphRangesKorean(self::Ptr{ImFontAtlas}) -> Ptr{ImWchar}
Default + Korean characters.
"""
GetGlyphRangesKorean(self::Ptr{ImFontAtlas}) = ImFontAtlas_GetGlyphRangesKorean(self)

"""
    GetGlyphRangesJapanese(self::Ptr{ImFontAtlas}) -> Ptr{ImWchar}
Default + Hiragana, Katakana, Half-Width, Selection of 1946 Ideographs.
"""
GetGlyphRangesJapanese(self::Ptr{ImFontAtlas}) = ImFontAtlas_GetGlyphRangesJapanese(self)

"""
    GetGlyphRangesChineseFull(self::Ptr{ImFontAtlas}) -> Ptr{ImWchar}
Default + Half-Width + Japanese Hiragana/Katakana + full set of about 21000 CJK Unified Ideographs.
"""
GetGlyphRangesChineseFull(self::Ptr{ImFontAtlas}) = ImFontAtlas_GetGlyphRangesChineseFull(self)

"""
    GetGlyphRangesChineseSimplifiedCommon(self::Ptr{ImFontAtlas}) -> Ptr{ImWchar}
Default + Half-Width + Japanese Hiragana/Katakana + set of 2500 CJK Unified Ideographs for common simplified Chinese.
"""
GetGlyphRangesChineseSimplifiedCommon(self::Ptr{ImFontAtlas}) = ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon(self)

"""
    GetGlyphRangesCyrillic(self::Ptr{ImFontAtlas}) -> Ptr{ImWchar}
Default + about 400 Cyrillic characters.
"""
GetGlyphRangesCyrillic(self::Ptr{ImFontAtlas}) = ImFontAtlas_GetGlyphRangesCyrillic(self)

"""
    GetGlyphRangesThai(self::Ptr{ImFontAtlas}) -> Ptr{ImWchar}
Default + Thai characters.
"""
GetGlyphRangesThai(self::Ptr{ImFontAtlas}) = ImFontAtlas_GetGlyphRangesThai(self)

########################################## ImGuiIO #########################################
# functions
"""
    AddInputCharacter(io::Ptr{ImGuiIO}, c)
Add new character into `InputCharacters[]`.
"""
AddInputCharacter(io::Ptr{ImGuiIO}, c) = ImGuiIO_AddInputCharacter(io, c)

"""
    AddInputCharactersUTF8(io::Ptr{ImGuiIO}, utf8_chars)
Add new characters into `InputCharacters[]` from an UTF-8 string.
"""
AddInputCharactersUTF8(io::Ptr{ImGuiIO}, utf8_chars) = ImGuiIO_AddInputCharactersUTF8(io, utf8_chars)

"""
    ClearInputCharacters(io)
Clear the text input buffer manually.
"""
ClearInputCharacters(io) = ImGuiIO_ClearInputCharacters(io)

######################################### ImDrawData #######################################
Clear(handle::Ptr{ImDrawData}) = ImDrawData_Clear(handle)
DeIndexAllBuffers(handle::Ptr{ImDrawData}) = ImDrawData_DeIndexAllBuffers(handle)
ScaleClipRects(handle::Ptr{ImDrawData}, fb_scale) = ImDrawData_ScaleClipRects(handle, fb_scale)
