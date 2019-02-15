# context
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
Set the current context to the input.
"""
SetCurrentContext(ctx::Ptr{ImGuiContext}) = igSetCurrentContext(ctx)

# Main
"""
    GetIO() -> Ptr{ImGuiIO}
Return a handle of `ImGuiIO` which is for accessing the IO structure:
- mouse/keyboard/gamepad inputs
- time
- various configuration options/flags
"""
GetIO() = igGetIO()

"""
    GetStyle() -> Ptr{ImGuiStyle}
Return a handle of `ImGuiStyle` which is for accessing the Style structure (colors, sizes).

!!! note
    Always use [`PushStyleCol`](@ref), [`PushStyleVar`](@ref) to modify style mid-frame.
"""
GetStyle() = igGetStyle()

"""
    NewFrame()
Start a new ImGui frame, you can submit any command from this point until [`Render`](@ref)
or [`EndFrame`](@ref).
"""
NewFrame() = igNewFrame()

"""
    EndFrame()
Calling this function ends the ImGui frame. This function is automatically called by [`Render`](@ref),
you likely don't need to call it yourself directly. If you don't need to render data (skipping rendering),
you may call [`EndFrame`](@ref) but you'll have wasted CPU already! If you don't need to render,
better to not create any imgui windows and not call [`NewFrame`](@ref) at all!
"""
EndFrame() = igEndFrame()

"""
    Render()
Calling this function ends the ImGui frame. This function finalizes the draw data.

!!! info
    Obsolete: optionally call io.RenderDrawListsFn if set. Nowadays, prefer calling your render
    function yourself.
"""
Render() = igRender()

"""
    GetDrawData() -> Ptr{ImDrawData}
Return a handle of `ImDrawData` which is valid after [`Render`](@ref) and until the next call
to [`NewFrame`](@ref). This is what you have to render.

!!! info
    Obsolete: this used to be passed to your io.RenderDrawListsFn() function.
"""
GetDrawData() = igGetDrawData()

# Styles
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

# Windows
"""
    Begin(name::AbstractString, p_open::=C_NULL, flags=0) -> Bool
Push window to the stack and start appending to it.
- you may append multiple times to the same window during the same frame.
- passing `p_open != C_NULL` shows a window-closing widget in the upper-right corner of the window, which clicking will set the boolean to false when clicked.
- [`Begin`](@ref) return false to indicate the window is collapsed or fully clipped, so you may early out and omit submitting anything to the window.

!!! note
    Always call a matching [`End`](@ref) for each [`Begin`](@ref) call, regardless of its return value.
    This is due to legacy reason and is inconsistent with most other functions such as
    [`BeginMenu`](@ref)/[`EndMenu`](@ref), [`BeginPopup`](@ref)/[`EndPopup`](@ref), etc.
    where the `EndXXX` call should only be called if the corresponding `BeginXXX` function returned true.
"""
Begin(name::AbstractString, p_open=C_NULL, flags=0) = igBegin(name, p_open, flags)

"""
    End()
Pop window from the stack. See also [`Begin`](@ref).
"""
End() = igEnd()

# Widgets: Main
"""
    Button(label::AbstractString) -> Bool
    Button(label::AbstractString, size) -> Bool
Return true when the value has been changed or when pressed/selected.
"""
Button(label::AbstractString, size=ImVec2(0,0)) = igButton(label, size)

"""
    SmallButton(label::AbstractString) -> Bool
Return true when the value has been changed or when pressed/selected. It creates a button
with `FramePadding=(0,0)` to easily embed within text.
"""
SmallButton(label::AbstractString) = igSmallButton(label)

"""
    InvisibleButton(str_id::AbstractString, size) -> Bool
Return true when the value has been changed or when pressed/selected.
Create a button without the visuals, useful to build custom behaviors using the public api
along with [`IsItemActive`](@ref), [`IsItemHovered`](@ref), etc.
"""
InvisibleButton(str_id::AbstractString, size) = igInvisibleButton(str_id, size)

"""
    ArrowButton(str_id::AbstractString, dir) -> Bool
Return true when the value has been changed or when pressed/selected. Create a square button
with an arrow shape.
"""
ArrowButton(str_id::AbstractString, dir) = igArrowButton(str_id, dir)

# TODO: igImage(user_texture_id, size, uv0, uv1, tint_col, border_col)
# TODO: igImageButton(user_texture_id, size, uv0, uv1, frame_padding, bg_col, tint_col)

"""
    Checkbox(label::AbstractString, v::Ref{Bool}) -> Bool
Return true when the value has been changed or when pressed/selected.
"""
Checkbox(label::AbstractString, v::Ref{Bool}) = igCheckbox(label, v)

"""
    CheckboxFlags(label::AbstractString, flags, flags_value) -> Bool
Return true when the value has been changed or when pressed/selected.
"""
CheckboxFlags(label::AbstractString, flags, flags_value) = igCheckboxFlags(label, flags, flags_value)

"""
    RadioButton(label::AbstractString, active::Bool) -> Bool
    RadioButton(label::AbstractString, v::Ref, v_button::Integer) -> Bool
Return true when the value has been changed or when pressed/selected.

### Example
```julia
if RadioButton("one", my_value==1)
    my_value = 1
end
```
"""
RadioButton(label::AbstractString, active::Bool) = igRadioButtonBool(label, active)
RadioButton(label::AbstractString, v::Ref, v_button::Integer) = igRadioButtonIntPtr(label, v, v_button)

"""
    ProgressBar(fraction, size_arg=ImVec2(-1,0), overlay=C_NULL)
"""
ProgressBar(fraction, size_arg=ImVec2(-1,0), overlay=C_NULL) = igProgressBar(fraction, size_arg, overlay)

"""
    Bullet()
Draw a small circle and keep the cursor on the same line.
advance cursor x position by GetTreeNodeToLabelSpacing(), same distance that TreeNode() uses
"""
Bullet() = igBullet()

# Cursor / Layout
"""
    SameLine(local_pos_x=0.0f0, spacing_w=-1.0f0)
Call this function between widgets or groups to layout them horizontally.
"""
SameLine(local_pos_x=0.0f0, spacing_w=-1.0f0) = igSameLine(local_pos_x, spacing_w)


# Widgets: Text
# pending https://github.com/JuliaLang/julia/issues/1315


# Widgets: Sliders
"""
    SliderFloat(label::AbstractString, v, v_min, v_max, format="%.3f", power=1.0) -> Bool
!!! tip
    ctrl+click on a slider to input with keyboard. manually input values aren't clamped, can go off-bounds.

### Arguments
- `format`: adjust format to decorate the value with a prefix or a suffix for in-slider labels or unit display
  * "%.3f" -> 1.234
  * "%5.2f secs" -> 01.23 secs
  * "Biscuit: %.0f" -> Biscuit: 1
- `power`: use `power != 1.0` for power curve sliders
"""
SliderFloat(label::AbstractString, v, v_min, v_max, format="%.3f", power=1.0) = igSliderFloat(label, v, v_min, v_max, format, power)


# Widgets: Color Editor/Picker
"""
    ColorEdit3(label::AbstractString, col, flags=0) -> Bool
!!! tip
    this function has a little colored preview square that can be left-clicked to open a picker,
    and right-clicked to open an option menu.
"""
ColorEdit3(label::AbstractString, col, flags=0) = igColorEdit3(label, col, flags)
