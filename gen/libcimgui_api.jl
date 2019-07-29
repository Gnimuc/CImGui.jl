# Julia wrapper for header: cimgui.h
# Automatically generated using Clang.jl


function ImVec2_ImVec2()
    ccall((:ImVec2_ImVec2, libcimgui), Ptr{ImVec2}, ())
end

function ImVec2_destroy(self)
    ccall((:ImVec2_destroy, libcimgui), Cvoid, (Ptr{ImVec2},), self)
end

function ImVec2_ImVec2Float(_x, _y)
    ccall((:ImVec2_ImVec2Float, libcimgui), Ptr{ImVec2}, (Cfloat, Cfloat), _x, _y)
end

function ImVec4_ImVec4()
    ccall((:ImVec4_ImVec4, libcimgui), Ptr{ImVec4}, ())
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

function igDebugCheckVersionAndDataLayout(version_str, sz_io, sz_style, sz_vec2, sz_vec4, sz_drawvert)
    ccall((:igDebugCheckVersionAndDataLayout, libcimgui), Bool, (Cstring, Csize_t, Csize_t, Csize_t, Csize_t, Csize_t), version_str, sz_io, sz_style, sz_vec2, sz_vec4, sz_drawvert)
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

function igShowAboutWindow(p_open)
    ccall((:igShowAboutWindow, libcimgui), Cvoid, (Ptr{Bool},), p_open)
end

function igShowMetricsWindow(p_open)
    ccall((:igShowMetricsWindow, libcimgui), Cvoid, (Ptr{Bool},), p_open)
end

function igShowStyleEditor(ref)
    ccall((:igShowStyleEditor, libcimgui), Cvoid, (Ptr{ImGuiStyle},), ref)
end

function igShowStyleSelector(label)
    ccall((:igShowStyleSelector, libcimgui), Bool, (Cstring,), label)
end

function igShowFontSelector(label)
    ccall((:igShowFontSelector, libcimgui), Cvoid, (Cstring,), label)
end

function igShowUserGuide()
    ccall((:igShowUserGuide, libcimgui), Cvoid, ())
end

function igGetVersion()
    ccall((:igGetVersion, libcimgui), Cstring, ())
end

function igStyleColorsDark(dst)
    ccall((:igStyleColorsDark, libcimgui), Cvoid, (Ptr{ImGuiStyle},), dst)
end

function igStyleColorsClassic(dst)
    ccall((:igStyleColorsClassic, libcimgui), Cvoid, (Ptr{ImGuiStyle},), dst)
end

function igStyleColorsLight(dst)
    ccall((:igStyleColorsLight, libcimgui), Cvoid, (Ptr{ImGuiStyle},), dst)
end

function igBegin(name, p_open, flags)
    ccall((:igBegin, libcimgui), Bool, (Cstring, Ptr{Bool}, ImGuiWindowFlags), name, p_open, flags)
end

function igEnd()
    ccall((:igEnd, libcimgui), Cvoid, ())
end

function igBeginChild(str_id, size, border, flags)
    ccall((:igBeginChild, libcimgui), Bool, (Cstring, ImVec2, Bool, ImGuiWindowFlags), str_id, size, border, flags)
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

function igGetWindowPos()
    ccall((:igGetWindowPos, libcimgui), ImVec2, ())
end

function igGetWindowSize()
    ccall((:igGetWindowSize, libcimgui), ImVec2, ())
end

function igGetWindowWidth()
    ccall((:igGetWindowWidth, libcimgui), Cfloat, ())
end

function igGetWindowHeight()
    ccall((:igGetWindowHeight, libcimgui), Cfloat, ())
end

function igGetContentRegionMax()
    ccall((:igGetContentRegionMax, libcimgui), ImVec2, ())
end

function igGetContentRegionAvail()
    ccall((:igGetContentRegionAvail, libcimgui), ImVec2, ())
end

function igGetContentRegionAvailWidth()
    ccall((:igGetContentRegionAvailWidth, libcimgui), Cfloat, ())
end

function igGetWindowContentRegionMin()
    ccall((:igGetWindowContentRegionMin, libcimgui), ImVec2, ())
end

function igGetWindowContentRegionMax()
    ccall((:igGetWindowContentRegionMax, libcimgui), ImVec2, ())
end

function igGetWindowContentRegionWidth()
    ccall((:igGetWindowContentRegionWidth, libcimgui), Cfloat, ())
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

function igSetWindowFocus()
    ccall((:igSetWindowFocus, libcimgui), Cvoid, ())
end

function igSetWindowFontScale(scale)
    ccall((:igSetWindowFontScale, libcimgui), Cvoid, (Cfloat,), scale)
end

function igSetWindowPosStr(name, pos, cond)
    ccall((:igSetWindowPosStr, libcimgui), Cvoid, (Cstring, ImVec2, ImGuiCond), name, pos, cond)
end

function igSetWindowSizeStr(name, size, cond)
    ccall((:igSetWindowSizeStr, libcimgui), Cvoid, (Cstring, ImVec2, ImGuiCond), name, size, cond)
end

function igSetWindowCollapsedStr(name, collapsed, cond)
    ccall((:igSetWindowCollapsedStr, libcimgui), Cvoid, (Cstring, Bool, ImGuiCond), name, collapsed, cond)
end

function igSetWindowFocusStr(name)
    ccall((:igSetWindowFocusStr, libcimgui), Cvoid, (Cstring,), name)
end

function igGetScrollX()
    ccall((:igGetScrollX, libcimgui), Cfloat, ())
end

function igGetScrollY()
    ccall((:igGetScrollY, libcimgui), Cfloat, ())
end

function igGetScrollMaxX()
    ccall((:igGetScrollMaxX, libcimgui), Cfloat, ())
end

function igGetScrollMaxY()
    ccall((:igGetScrollMaxY, libcimgui), Cfloat, ())
end

function igSetScrollX(scroll_x)
    ccall((:igSetScrollX, libcimgui), Cvoid, (Cfloat,), scroll_x)
end

function igSetScrollY(scroll_y)
    ccall((:igSetScrollY, libcimgui), Cvoid, (Cfloat,), scroll_y)
end

function igSetScrollHereY(center_y_ratio)
    ccall((:igSetScrollHereY, libcimgui), Cvoid, (Cfloat,), center_y_ratio)
end

function igSetScrollFromPosY(local_y, center_y_ratio)
    ccall((:igSetScrollFromPosY, libcimgui), Cvoid, (Cfloat, Cfloat), local_y, center_y_ratio)
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

function igPushStyleColor(idx, col)
    ccall((:igPushStyleColor, libcimgui), Cvoid, (ImGuiCol, ImVec4), idx, col)
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

function igGetStyleColorVec4(idx)
    ccall((:igGetStyleColorVec4, libcimgui), Ptr{ImVec4}, (ImGuiCol,), idx)
end

function igGetFont()
    ccall((:igGetFont, libcimgui), Ptr{ImFont}, ())
end

function igGetFontSize()
    ccall((:igGetFontSize, libcimgui), Cfloat, ())
end

function igGetFontTexUvWhitePixel()
    ccall((:igGetFontTexUvWhitePixel, libcimgui), ImVec2, ())
end

function igGetColorU32(idx, alpha_mul)
    ccall((:igGetColorU32, libcimgui), ImU32, (ImGuiCol, Cfloat), idx, alpha_mul)
end

function igGetColorU32Vec4(col)
    ccall((:igGetColorU32Vec4, libcimgui), ImU32, (ImVec4,), col)
end

function igGetColorU32U32(col)
    ccall((:igGetColorU32U32, libcimgui), ImU32, (ImU32,), col)
end

function igPushItemWidth(item_width)
    ccall((:igPushItemWidth, libcimgui), Cvoid, (Cfloat,), item_width)
end

function igPopItemWidth()
    ccall((:igPopItemWidth, libcimgui), Cvoid, ())
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

function igSeparator()
    ccall((:igSeparator, libcimgui), Cvoid, ())
end

function igSameLine(local_pos_x, spacing_w)
    ccall((:igSameLine, libcimgui), Cvoid, (Cfloat, Cfloat), local_pos_x, spacing_w)
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

function igGetCursorPos()
    ccall((:igGetCursorPos, libcimgui), ImVec2, ())
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

function igGetCursorStartPos()
    ccall((:igGetCursorStartPos, libcimgui), ImVec2, ())
end

function igGetCursorScreenPos()
    ccall((:igGetCursorScreenPos, libcimgui), ImVec2, ())
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
    ccall((:igPushIDStr, libcimgui), Cvoid, (Cstring,), str_id)
end

function igPushIDRange(str_id_begin, str_id_end)
    ccall((:igPushIDRange, libcimgui), Cvoid, (Cstring, Cstring), str_id_begin, str_id_end)
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
    ccall((:igGetIDStr, libcimgui), ImGuiID, (Cstring,), str_id)
end

function igGetIDRange(str_id_begin, str_id_end)
    ccall((:igGetIDRange, libcimgui), ImGuiID, (Cstring, Cstring), str_id_begin, str_id_end)
end

function igGetIDPtr(ptr_id)
    ccall((:igGetIDPtr, libcimgui), ImGuiID, (Ptr{Cvoid},), ptr_id)
end

function igTextUnformatted(text, text_end)
    ccall((:igTextUnformatted, libcimgui), Cvoid, (Cstring, Cstring), text, text_end)
end

function igText(text)
    ccall((:igText, libcimgui), Cvoid, (Cstring,), text)
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

function igButton(label, size)
    ccall((:igButton, libcimgui), Bool, (Cstring, ImVec2), label, size)
end

function igSmallButton(label)
    ccall((:igSmallButton, libcimgui), Bool, (Cstring,), label)
end

function igInvisibleButton(str_id, size)
    ccall((:igInvisibleButton, libcimgui), Bool, (Cstring, ImVec2), str_id, size)
end

function igArrowButton(str_id, dir)
    ccall((:igArrowButton, libcimgui), Bool, (Cstring, ImGuiDir), str_id, dir)
end

function igImage(user_texture_id, size, uv0, uv1, tint_col, border_col)
    ccall((:igImage, libcimgui), Cvoid, (ImTextureID, ImVec2, ImVec2, ImVec2, ImVec4, ImVec4), user_texture_id, size, uv0, uv1, tint_col, border_col)
end

function igImageButton(user_texture_id, size, uv0, uv1, frame_padding, bg_col, tint_col)
    ccall((:igImageButton, libcimgui), Bool, (ImTextureID, ImVec2, ImVec2, ImVec2, Cint, ImVec4, ImVec4), user_texture_id, size, uv0, uv1, frame_padding, bg_col, tint_col)
end

function igCheckbox(label, v)
    ccall((:igCheckbox, libcimgui), Bool, (Cstring, Ptr{Bool}), label, v)
end

function igCheckboxFlags(label, flags, flags_value)
    ccall((:igCheckboxFlags, libcimgui), Bool, (Cstring, Ptr{UInt32}, UInt32), label, flags, flags_value)
end

function igRadioButtonBool(label, active)
    ccall((:igRadioButtonBool, libcimgui), Bool, (Cstring, Bool), label, active)
end

function igRadioButtonIntPtr(label, v, v_button)
    ccall((:igRadioButtonIntPtr, libcimgui), Bool, (Cstring, Ptr{Cint}, Cint), label, v, v_button)
end

function igProgressBar(fraction, size_arg, overlay)
    ccall((:igProgressBar, libcimgui), Cvoid, (Cfloat, ImVec2, Cstring), fraction, size_arg, overlay)
end

function igBullet()
    ccall((:igBullet, libcimgui), Cvoid, ())
end

function igBeginCombo(label, preview_value, flags)
    ccall((:igBeginCombo, libcimgui), Bool, (Cstring, Cstring, ImGuiComboFlags), label, preview_value, flags)
end

function igEndCombo()
    ccall((:igEndCombo, libcimgui), Cvoid, ())
end

function igCombo(label, current_item, items, items_count, popup_max_height_in_items)
    ccall((:igCombo, libcimgui), Bool, (Cstring, Ptr{Cint}, Ptr{Cstring}, Cint, Cint), label, current_item, items, items_count, popup_max_height_in_items)
end

function igComboStr(label, current_item, items_separated_by_zeros, popup_max_height_in_items)
    ccall((:igComboStr, libcimgui), Bool, (Cstring, Ptr{Cint}, Ptr{UInt8}, Cint), label, current_item, items_separated_by_zeros, popup_max_height_in_items)
end

function igComboFnPtr(label, current_item, items_getter, data, items_count, popup_max_height_in_items)
    ccall((:igComboFnPtr, libcimgui), Bool, (Cstring, Ptr{Cint}, Ptr{Cvoid}, Ptr{Cvoid}, Cint, Cint), label, current_item, items_getter, data, items_count, popup_max_height_in_items)
end

function igDragFloat(label, v, v_speed, v_min, v_max, format, power)
    ccall((:igDragFloat, libcimgui), Bool, (Cstring, Ptr{Cfloat}, Cfloat, Cfloat, Cfloat, Cstring, Cfloat), label, v, v_speed, v_min, v_max, format, power)
end

function igDragFloat2(label, v, v_speed, v_min, v_max, format, power)
    ccall((:igDragFloat2, libcimgui), Bool, (Cstring, Ptr{Cfloat}, Cfloat, Cfloat, Cfloat, Cstring, Cfloat), label, v, v_speed, v_min, v_max, format, power)
end

function igDragFloat3(label, v, v_speed, v_min, v_max, format, power)
    ccall((:igDragFloat3, libcimgui), Bool, (Cstring, Ptr{Cfloat}, Cfloat, Cfloat, Cfloat, Cstring, Cfloat), label, v, v_speed, v_min, v_max, format, power)
end

function igDragFloat4(label, v, v_speed, v_min, v_max, format, power)
    ccall((:igDragFloat4, libcimgui), Bool, (Cstring, Ptr{Cfloat}, Cfloat, Cfloat, Cfloat, Cstring, Cfloat), label, v, v_speed, v_min, v_max, format, power)
end

function igDragFloatRange2(label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max, power)
    ccall((:igDragFloatRange2, libcimgui), Bool, (Cstring, Ptr{Cfloat}, Ptr{Cfloat}, Cfloat, Cfloat, Cfloat, Cstring, Cstring, Cfloat), label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max, power)
end

function igDragInt(label, v, v_speed, v_min, v_max, format)
    ccall((:igDragInt, libcimgui), Bool, (Cstring, Ptr{Cint}, Cfloat, Cint, Cint, Cstring), label, v, v_speed, v_min, v_max, format)
end

function igDragInt2(label, v, v_speed, v_min, v_max, format)
    ccall((:igDragInt2, libcimgui), Bool, (Cstring, Ptr{Cint}, Cfloat, Cint, Cint, Cstring), label, v, v_speed, v_min, v_max, format)
end

function igDragInt3(label, v, v_speed, v_min, v_max, format)
    ccall((:igDragInt3, libcimgui), Bool, (Cstring, Ptr{Cint}, Cfloat, Cint, Cint, Cstring), label, v, v_speed, v_min, v_max, format)
end

function igDragInt4(label, v, v_speed, v_min, v_max, format)
    ccall((:igDragInt4, libcimgui), Bool, (Cstring, Ptr{Cint}, Cfloat, Cint, Cint, Cstring), label, v, v_speed, v_min, v_max, format)
end

function igDragIntRange2(label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max)
    ccall((:igDragIntRange2, libcimgui), Bool, (Cstring, Ptr{Cint}, Ptr{Cint}, Cfloat, Cint, Cint, Cstring, Cstring), label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max)
end

function igDragScalar(label, data_type, v, v_speed, v_min, v_max, format, power)
    ccall((:igDragScalar, libcimgui), Bool, (Cstring, ImGuiDataType, Ptr{Cvoid}, Cfloat, Ptr{Cvoid}, Ptr{Cvoid}, Cstring, Cfloat), label, data_type, v, v_speed, v_min, v_max, format, power)
end

function igDragScalarN(label, data_type, v, components, v_speed, v_min, v_max, format, power)
    ccall((:igDragScalarN, libcimgui), Bool, (Cstring, ImGuiDataType, Ptr{Cvoid}, Cint, Cfloat, Ptr{Cvoid}, Ptr{Cvoid}, Cstring, Cfloat), label, data_type, v, components, v_speed, v_min, v_max, format, power)
end

function igSliderFloat(label, v, v_min, v_max, format, power)
    ccall((:igSliderFloat, libcimgui), Bool, (Cstring, Ptr{Cfloat}, Cfloat, Cfloat, Cstring, Cfloat), label, v, v_min, v_max, format, power)
end

function igSliderFloat2(label, v, v_min, v_max, format, power)
    ccall((:igSliderFloat2, libcimgui), Bool, (Cstring, Ptr{Cfloat}, Cfloat, Cfloat, Cstring, Cfloat), label, v, v_min, v_max, format, power)
end

function igSliderFloat3(label, v, v_min, v_max, format, power)
    ccall((:igSliderFloat3, libcimgui), Bool, (Cstring, Ptr{Cfloat}, Cfloat, Cfloat, Cstring, Cfloat), label, v, v_min, v_max, format, power)
end

function igSliderFloat4(label, v, v_min, v_max, format, power)
    ccall((:igSliderFloat4, libcimgui), Bool, (Cstring, Ptr{Cfloat}, Cfloat, Cfloat, Cstring, Cfloat), label, v, v_min, v_max, format, power)
end

function igSliderAngle(label, v_rad, v_degrees_min, v_degrees_max, format)
    ccall((:igSliderAngle, libcimgui), Bool, (Cstring, Ptr{Cfloat}, Cfloat, Cfloat, Cstring), label, v_rad, v_degrees_min, v_degrees_max, format)
end

function igSliderInt(label, v, v_min, v_max, format)
    ccall((:igSliderInt, libcimgui), Bool, (Cstring, Ptr{Cint}, Cint, Cint, Cstring), label, v, v_min, v_max, format)
end

function igSliderInt2(label, v, v_min, v_max, format)
    ccall((:igSliderInt2, libcimgui), Bool, (Cstring, Ptr{Cint}, Cint, Cint, Cstring), label, v, v_min, v_max, format)
end

function igSliderInt3(label, v, v_min, v_max, format)
    ccall((:igSliderInt3, libcimgui), Bool, (Cstring, Ptr{Cint}, Cint, Cint, Cstring), label, v, v_min, v_max, format)
end

function igSliderInt4(label, v, v_min, v_max, format)
    ccall((:igSliderInt4, libcimgui), Bool, (Cstring, Ptr{Cint}, Cint, Cint, Cstring), label, v, v_min, v_max, format)
end

function igSliderScalar(label, data_type, v, v_min, v_max, format, power)
    ccall((:igSliderScalar, libcimgui), Bool, (Cstring, ImGuiDataType, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Cstring, Cfloat), label, data_type, v, v_min, v_max, format, power)
end

function igSliderScalarN(label, data_type, v, components, v_min, v_max, format, power)
    ccall((:igSliderScalarN, libcimgui), Bool, (Cstring, ImGuiDataType, Ptr{Cvoid}, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Cstring, Cfloat), label, data_type, v, components, v_min, v_max, format, power)
end

function igVSliderFloat(label, size, v, v_min, v_max, format, power)
    ccall((:igVSliderFloat, libcimgui), Bool, (Cstring, ImVec2, Ptr{Cfloat}, Cfloat, Cfloat, Cstring, Cfloat), label, size, v, v_min, v_max, format, power)
end

function igVSliderInt(label, size, v, v_min, v_max, format)
    ccall((:igVSliderInt, libcimgui), Bool, (Cstring, ImVec2, Ptr{Cint}, Cint, Cint, Cstring), label, size, v, v_min, v_max, format)
end

function igVSliderScalar(label, size, data_type, v, v_min, v_max, format, power)
    ccall((:igVSliderScalar, libcimgui), Bool, (Cstring, ImVec2, ImGuiDataType, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Cstring, Cfloat), label, size, data_type, v, v_min, v_max, format, power)
end

function igInputText(label, buf, buf_size, flags, callback, user_data)
    ccall((:igInputText, libcimgui), Bool, (Cstring, Ptr{UInt8}, Csize_t, ImGuiInputTextFlags, ImGuiInputTextCallback, Ptr{Cvoid}), label, buf, buf_size, flags, callback, user_data)
end

function igInputTextMultiline(label, buf, buf_size, size, flags, callback, user_data)
    ccall((:igInputTextMultiline, libcimgui), Bool, (Cstring, Ptr{UInt8}, Csize_t, ImVec2, ImGuiInputTextFlags, ImGuiInputTextCallback, Ptr{Cvoid}), label, buf, buf_size, size, flags, callback, user_data)
end

function igInputTextWithHint(label, hint, buf, buf_size, flags, callback, user_data)
    ccall((:igInputTextWithHint, libcimgui), Bool, (Cstring, Cstring, Ptr{UInt8}, Csize_t, ImGuiInputTextFlags, ImGuiInputTextCallback, Ptr{Cvoid}), label, hint, buf, buf_size, flags, callback, user_data)
end

function igInputFloat(label, v, step, step_fast, format, flags)
    ccall((:igInputFloat, libcimgui), Bool, (Cstring, Ptr{Cfloat}, Cfloat, Cfloat, Cstring, ImGuiInputTextFlags), label, v, step, step_fast, format, flags)
end

function igInputFloat2(label, v, format, flags)
    ccall((:igInputFloat2, libcimgui), Bool, (Cstring, Ptr{Cfloat}, Cstring, ImGuiInputTextFlags), label, v, format, flags)
end

function igInputFloat3(label, v, format, flags)
    ccall((:igInputFloat3, libcimgui), Bool, (Cstring, Ptr{Cfloat}, Cstring, ImGuiInputTextFlags), label, v, format, flags)
end

function igInputFloat4(label, v, format, flags)
    ccall((:igInputFloat4, libcimgui), Bool, (Cstring, Ptr{Cfloat}, Cstring, ImGuiInputTextFlags), label, v, format, flags)
end

function igInputInt(label, v, step, step_fast, flags)
    ccall((:igInputInt, libcimgui), Bool, (Cstring, Ptr{Cint}, Cint, Cint, ImGuiInputTextFlags), label, v, step, step_fast, flags)
end

function igInputInt2(label, v, flags)
    ccall((:igInputInt2, libcimgui), Bool, (Cstring, Ptr{Cint}, ImGuiInputTextFlags), label, v, flags)
end

function igInputInt3(label, v, flags)
    ccall((:igInputInt3, libcimgui), Bool, (Cstring, Ptr{Cint}, ImGuiInputTextFlags), label, v, flags)
end

function igInputInt4(label, v, flags)
    ccall((:igInputInt4, libcimgui), Bool, (Cstring, Ptr{Cint}, ImGuiInputTextFlags), label, v, flags)
end

function igInputDouble(label, v, step, step_fast, format, flags)
    ccall((:igInputDouble, libcimgui), Bool, (Cstring, Ptr{Cdouble}, Cdouble, Cdouble, Cstring, ImGuiInputTextFlags), label, v, step, step_fast, format, flags)
end

function igInputScalar(label, data_type, v, step, step_fast, format, flags)
    ccall((:igInputScalar, libcimgui), Bool, (Cstring, ImGuiDataType, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Cstring, ImGuiInputTextFlags), label, data_type, v, step, step_fast, format, flags)
end

function igInputScalarN(label, data_type, v, components, step, step_fast, format, flags)
    ccall((:igInputScalarN, libcimgui), Bool, (Cstring, ImGuiDataType, Ptr{Cvoid}, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Cstring, ImGuiInputTextFlags), label, data_type, v, components, step, step_fast, format, flags)
end

function igColorEdit3(label, col, flags)
    ccall((:igColorEdit3, libcimgui), Bool, (Cstring, Ptr{Cfloat}, ImGuiColorEditFlags), label, col, flags)
end

function igColorEdit4(label, col, flags)
    ccall((:igColorEdit4, libcimgui), Bool, (Cstring, Ptr{Cfloat}, ImGuiColorEditFlags), label, col, flags)
end

function igColorPicker3(label, col, flags)
    ccall((:igColorPicker3, libcimgui), Bool, (Cstring, Ptr{Cfloat}, ImGuiColorEditFlags), label, col, flags)
end

function igColorPicker4(label, col, flags, ref_col)
    ccall((:igColorPicker4, libcimgui), Bool, (Cstring, Ptr{Cfloat}, ImGuiColorEditFlags, Ptr{Cfloat}), label, col, flags, ref_col)
end

function igColorButton(desc_id, col, flags, size)
    ccall((:igColorButton, libcimgui), Bool, (Cstring, ImVec4, ImGuiColorEditFlags, ImVec2), desc_id, col, flags, size)
end

function igSetColorEditOptions(flags)
    ccall((:igSetColorEditOptions, libcimgui), Cvoid, (ImGuiColorEditFlags,), flags)
end

function igTreeNodeStr(label)
    ccall((:igTreeNodeStr, libcimgui), Bool, (Cstring,), label)
end

function igTreeNodeStrStr(str_id, text)
    ccall((:igTreeNodeStrStr, libcimgui), Bool, (Cstring, Cstring), str_id, text)
end

function igTreeNodePtr(ptr_id, text)
    ccall((:igTreeNodePtr, libcimgui), Bool, (Ptr{Cvoid}, Cstring), ptr_id, text)
end

function igTreeNodeExStr(label, flags)
    ccall((:igTreeNodeExStr, libcimgui), Bool, (Cstring, ImGuiTreeNodeFlags), label, flags)
end

function igTreeNodeExStrStr(str_id, flags, text)
    ccall((:igTreeNodeExStrStr, libcimgui), Bool, (Cstring, ImGuiTreeNodeFlags, Cstring), str_id, flags, text)
end

function igTreeNodeExPtr(ptr_id, flags, text)
    ccall((:igTreeNodeExPtr, libcimgui), Bool, (Ptr{Cvoid}, ImGuiTreeNodeFlags, Cstring), ptr_id, flags, text)
end

function igTreePushStr(str_id)
    ccall((:igTreePushStr, libcimgui), Cvoid, (Cstring,), str_id)
end

function igTreePushPtr(ptr_id)
    ccall((:igTreePushPtr, libcimgui), Cvoid, (Ptr{Cvoid},), ptr_id)
end

function igTreePop()
    ccall((:igTreePop, libcimgui), Cvoid, ())
end

function igTreeAdvanceToLabelPos()
    ccall((:igTreeAdvanceToLabelPos, libcimgui), Cvoid, ())
end

function igGetTreeNodeToLabelSpacing()
    ccall((:igGetTreeNodeToLabelSpacing, libcimgui), Cfloat, ())
end

function igSetNextTreeNodeOpen(is_open, cond)
    ccall((:igSetNextTreeNodeOpen, libcimgui), Cvoid, (Bool, ImGuiCond), is_open, cond)
end

function igCollapsingHeader(label, flags)
    ccall((:igCollapsingHeader, libcimgui), Bool, (Cstring, ImGuiTreeNodeFlags), label, flags)
end

function igCollapsingHeaderBoolPtr(label, p_open, flags)
    ccall((:igCollapsingHeaderBoolPtr, libcimgui), Bool, (Cstring, Ptr{Bool}, ImGuiTreeNodeFlags), label, p_open, flags)
end

function igSelectable(label, selected, flags, size)
    ccall((:igSelectable, libcimgui), Bool, (Cstring, Bool, ImGuiSelectableFlags, ImVec2), label, selected, flags, size)
end

function igSelectableBoolPtr(label, p_selected, flags, size)
    ccall((:igSelectableBoolPtr, libcimgui), Bool, (Cstring, Ptr{Bool}, ImGuiSelectableFlags, ImVec2), label, p_selected, flags, size)
end

function igListBoxStr_arr(label, current_item, items, items_count, height_in_items)
    ccall((:igListBoxStr_arr, libcimgui), Bool, (Cstring, Ptr{Cint}, Ptr{Cstring}, Cint, Cint), label, current_item, items, items_count, height_in_items)
end

function igListBoxFnPtr(label, current_item, items_getter, data, items_count, height_in_items)
    ccall((:igListBoxFnPtr, libcimgui), Bool, (Cstring, Ptr{Cint}, Ptr{Cvoid}, Ptr{Cvoid}, Cint, Cint), label, current_item, items_getter, data, items_count, height_in_items)
end

function igListBoxHeaderVec2(label, size)
    ccall((:igListBoxHeaderVec2, libcimgui), Bool, (Cstring, ImVec2), label, size)
end

function igListBoxHeaderInt(label, items_count, height_in_items)
    ccall((:igListBoxHeaderInt, libcimgui), Bool, (Cstring, Cint, Cint), label, items_count, height_in_items)
end

function igListBoxFooter()
    ccall((:igListBoxFooter, libcimgui), Cvoid, ())
end

function igPlotLines(label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride)
    ccall((:igPlotLines, libcimgui), Cvoid, (Cstring, Ptr{Cfloat}, Cint, Cint, Cstring, Cfloat, Cfloat, ImVec2, Cint), label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride)
end

function igPlotLinesFnPtr(label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size)
    ccall((:igPlotLinesFnPtr, libcimgui), Cvoid, (Cstring, Ptr{Cvoid}, Ptr{Cvoid}, Cint, Cint, Cstring, Cfloat, Cfloat, ImVec2), label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size)
end

function igPlotHistogramFloatPtr(label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride)
    ccall((:igPlotHistogramFloatPtr, libcimgui), Cvoid, (Cstring, Ptr{Cfloat}, Cint, Cint, Cstring, Cfloat, Cfloat, ImVec2, Cint), label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride)
end

function igPlotHistogramFnPtr(label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size)
    ccall((:igPlotHistogramFnPtr, libcimgui), Cvoid, (Cstring, Ptr{Cvoid}, Ptr{Cvoid}, Cint, Cint, Cstring, Cfloat, Cfloat, ImVec2), label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size)
end

function igValueBool(prefix, b)
    ccall((:igValueBool, libcimgui), Cvoid, (Cstring, Bool), prefix, b)
end

function igValueInt(prefix, v)
    ccall((:igValueInt, libcimgui), Cvoid, (Cstring, Cint), prefix, v)
end

function igValueUint(prefix, v)
    ccall((:igValueUint, libcimgui), Cvoid, (Cstring, UInt32), prefix, v)
end

function igValueFloat(prefix, v, float_format)
    ccall((:igValueFloat, libcimgui), Cvoid, (Cstring, Cfloat, Cstring), prefix, v, float_format)
end

function igBeginMainMenuBar()
    ccall((:igBeginMainMenuBar, libcimgui), Bool, ())
end

function igEndMainMenuBar()
    ccall((:igEndMainMenuBar, libcimgui), Cvoid, ())
end

function igBeginMenuBar()
    ccall((:igBeginMenuBar, libcimgui), Bool, ())
end

function igEndMenuBar()
    ccall((:igEndMenuBar, libcimgui), Cvoid, ())
end

function igBeginMenu(label, enabled)
    ccall((:igBeginMenu, libcimgui), Bool, (Cstring, Bool), label, enabled)
end

function igEndMenu()
    ccall((:igEndMenu, libcimgui), Cvoid, ())
end

function igMenuItemBool(label, shortcut, selected, enabled)
    ccall((:igMenuItemBool, libcimgui), Bool, (Cstring, Cstring, Bool, Bool), label, shortcut, selected, enabled)
end

function igMenuItemBoolPtr(label, shortcut, p_selected, enabled)
    ccall((:igMenuItemBoolPtr, libcimgui), Bool, (Cstring, Cstring, Ptr{Bool}, Bool), label, shortcut, p_selected, enabled)
end

function igBeginTooltip()
    ccall((:igBeginTooltip, libcimgui), Cvoid, ())
end

function igEndTooltip()
    ccall((:igEndTooltip, libcimgui), Cvoid, ())
end

function igSetTooltip(text)
    ccall((:igSetTooltip, libcimgui), Cvoid, (Cstring,), text)
end

function igOpenPopup(str_id)
    ccall((:igOpenPopup, libcimgui), Cvoid, (Cstring,), str_id)
end

function igBeginPopup(str_id, flags)
    ccall((:igBeginPopup, libcimgui), Bool, (Cstring, ImGuiWindowFlags), str_id, flags)
end

function igBeginPopupContextItem(str_id, mouse_button)
    ccall((:igBeginPopupContextItem, libcimgui), Bool, (Cstring, Cint), str_id, mouse_button)
end

function igBeginPopupContextWindow(str_id, mouse_button, also_over_items)
    ccall((:igBeginPopupContextWindow, libcimgui), Bool, (Cstring, Cint, Bool), str_id, mouse_button, also_over_items)
end

function igBeginPopupContextVoid(str_id, mouse_button)
    ccall((:igBeginPopupContextVoid, libcimgui), Bool, (Cstring, Cint), str_id, mouse_button)
end

function igBeginPopupModal(name, p_open, flags)
    ccall((:igBeginPopupModal, libcimgui), Bool, (Cstring, Ptr{Bool}, ImGuiWindowFlags), name, p_open, flags)
end

function igEndPopup()
    ccall((:igEndPopup, libcimgui), Cvoid, ())
end

function igOpenPopupOnItemClick(str_id, mouse_button)
    ccall((:igOpenPopupOnItemClick, libcimgui), Bool, (Cstring, Cint), str_id, mouse_button)
end

function igIsPopupOpen(str_id)
    ccall((:igIsPopupOpen, libcimgui), Bool, (Cstring,), str_id)
end

function igCloseCurrentPopup()
    ccall((:igCloseCurrentPopup, libcimgui), Cvoid, ())
end

function igColumns(count, id, border)
    ccall((:igColumns, libcimgui), Cvoid, (Cint, Cstring, Bool), count, id, border)
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
    ccall((:igBeginTabBar, libcimgui), Bool, (Cstring, ImGuiTabBarFlags), str_id, flags)
end

function igEndTabBar()
    ccall((:igEndTabBar, libcimgui), Cvoid, ())
end

function igBeginTabItem(label, p_open, flags)
    ccall((:igBeginTabItem, libcimgui), Bool, (Cstring, Ptr{Bool}, ImGuiTabItemFlags), label, p_open, flags)
end

function igEndTabItem()
    ccall((:igEndTabItem, libcimgui), Cvoid, ())
end

function igSetTabItemClosed(tab_or_docked_window_label)
    ccall((:igSetTabItemClosed, libcimgui), Cvoid, (Cstring,), tab_or_docked_window_label)
end

function igLogToTTY(auto_open_depth)
    ccall((:igLogToTTY, libcimgui), Cvoid, (Cint,), auto_open_depth)
end

function igLogToFile(auto_open_depth, filename)
    ccall((:igLogToFile, libcimgui), Cvoid, (Cint, Cstring), auto_open_depth, filename)
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

function igLogText(text)
    ccall((:igLogText, libcimgui), Cvoid, (Cstring,), text)
end

function igBeginDragDropSource(flags)
    ccall((:igBeginDragDropSource, libcimgui), Bool, (ImGuiDragDropFlags,), flags)
end

function igSetDragDropPayload(type, data, sz, cond)
    ccall((:igSetDragDropPayload, libcimgui), Bool, (Cstring, Ptr{Cvoid}, Csize_t, ImGuiCond), type, data, sz, cond)
end

function igEndDragDropSource()
    ccall((:igEndDragDropSource, libcimgui), Cvoid, ())
end

function igBeginDragDropTarget()
    ccall((:igBeginDragDropTarget, libcimgui), Bool, ())
end

function igAcceptDragDropPayload(type, flags)
    ccall((:igAcceptDragDropPayload, libcimgui), Ptr{ImGuiPayload}, (Cstring, ImGuiDragDropFlags), type, flags)
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
    ccall((:igIsItemClicked, libcimgui), Bool, (Cint,), mouse_button)
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

function igIsAnyItemHovered()
    ccall((:igIsAnyItemHovered, libcimgui), Bool, ())
end

function igIsAnyItemActive()
    ccall((:igIsAnyItemActive, libcimgui), Bool, ())
end

function igIsAnyItemFocused()
    ccall((:igIsAnyItemFocused, libcimgui), Bool, ())
end

function igGetItemRectMin()
    ccall((:igGetItemRectMin, libcimgui), ImVec2, ())
end

function igGetItemRectMax()
    ccall((:igGetItemRectMax, libcimgui), ImVec2, ())
end

function igGetItemRectSize()
    ccall((:igGetItemRectSize, libcimgui), ImVec2, ())
end

function igSetItemAllowOverlap()
    ccall((:igSetItemAllowOverlap, libcimgui), Cvoid, ())
end

function igIsRectVisible(size)
    ccall((:igIsRectVisible, libcimgui), Bool, (ImVec2,), size)
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

function igGetBackgroundDrawList()
    ccall((:igGetBackgroundDrawList, libcimgui), Ptr{ImDrawList}, ())
end

function igGetForegroundDrawList()
    ccall((:igGetForegroundDrawList, libcimgui), Ptr{ImDrawList}, ())
end

function igGetDrawListSharedData()
    ccall((:igGetDrawListSharedData, libcimgui), Ptr{ImDrawListSharedData}, ())
end

function igGetStyleColorName(idx)
    ccall((:igGetStyleColorName, libcimgui), Cstring, (ImGuiCol,), idx)
end

function igSetStateStorage(storage)
    ccall((:igSetStateStorage, libcimgui), Cvoid, (Ptr{ImGuiStorage},), storage)
end

function igGetStateStorage()
    ccall((:igGetStateStorage, libcimgui), Ptr{ImGuiStorage}, ())
end

function igCalcTextSize(text, text_end, hide_text_after_double_hash, wrap_width)
    ccall((:igCalcTextSize, libcimgui), ImVec2, (Cstring, Cstring, Bool, Cfloat), text, text_end, hide_text_after_double_hash, wrap_width)
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

function igColorConvertU32ToFloat4(in)
    ccall((:igColorConvertU32ToFloat4, libcimgui), ImVec4, (ImU32,), in)
end

function igColorConvertFloat4ToU32(in)
    ccall((:igColorConvertFloat4ToU32, libcimgui), ImU32, (ImVec4,), in)
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

function igIsMouseDown(button)
    ccall((:igIsMouseDown, libcimgui), Bool, (Cint,), button)
end

function igIsAnyMouseDown()
    ccall((:igIsAnyMouseDown, libcimgui), Bool, ())
end

function igIsMouseClicked(button, repeat)
    ccall((:igIsMouseClicked, libcimgui), Bool, (Cint, Bool), button, repeat)
end

function igIsMouseDoubleClicked(button)
    ccall((:igIsMouseDoubleClicked, libcimgui), Bool, (Cint,), button)
end

function igIsMouseReleased(button)
    ccall((:igIsMouseReleased, libcimgui), Bool, (Cint,), button)
end

function igIsMouseDragging(button, lock_threshold)
    ccall((:igIsMouseDragging, libcimgui), Bool, (Cint, Cfloat), button, lock_threshold)
end

function igIsMouseHoveringRect(r_min, r_max, clip)
    ccall((:igIsMouseHoveringRect, libcimgui), Bool, (ImVec2, ImVec2, Bool), r_min, r_max, clip)
end

function igIsMousePosValid(mouse_pos)
    ccall((:igIsMousePosValid, libcimgui), Bool, (Ptr{ImVec2},), mouse_pos)
end

function igGetMousePos()
    ccall((:igGetMousePos, libcimgui), ImVec2, ())
end

function igGetMousePosOnOpeningCurrentPopup()
    ccall((:igGetMousePosOnOpeningCurrentPopup, libcimgui), ImVec2, ())
end

function igGetMouseDragDelta(button, lock_threshold)
    ccall((:igGetMouseDragDelta, libcimgui), ImVec2, (Cint, Cfloat), button, lock_threshold)
end

function igResetMouseDragDelta(button)
    ccall((:igResetMouseDragDelta, libcimgui), Cvoid, (Cint,), button)
end

function igGetMouseCursor()
    ccall((:igGetMouseCursor, libcimgui), ImGuiMouseCursor, ())
end

function igSetMouseCursor(type)
    ccall((:igSetMouseCursor, libcimgui), Cvoid, (ImGuiMouseCursor,), type)
end

function igCaptureKeyboardFromApp(want_capture_keyboard_value)
    ccall((:igCaptureKeyboardFromApp, libcimgui), Cvoid, (Bool,), want_capture_keyboard_value)
end

function igCaptureMouseFromApp(want_capture_mouse_value)
    ccall((:igCaptureMouseFromApp, libcimgui), Cvoid, (Bool,), want_capture_mouse_value)
end

function igGetClipboardText()
    ccall((:igGetClipboardText, libcimgui), Cstring, ())
end

function igSetClipboardText(text)
    ccall((:igSetClipboardText, libcimgui), Cvoid, (Cstring,), text)
end

function igLoadIniSettingsFromDisk(ini_filename)
    ccall((:igLoadIniSettingsFromDisk, libcimgui), Cvoid, (Cstring,), ini_filename)
end

function igLoadIniSettingsFromMemory(ini_data, ini_size)
    ccall((:igLoadIniSettingsFromMemory, libcimgui), Cvoid, (Cstring, Csize_t), ini_data, ini_size)
end

function igSaveIniSettingsToDisk(ini_filename)
    ccall((:igSaveIniSettingsToDisk, libcimgui), Cvoid, (Cstring,), ini_filename)
end

function igSaveIniSettingsToMemory(out_ini_size)
    ccall((:igSaveIniSettingsToMemory, libcimgui), Cstring, (Ptr{Csize_t},), out_ini_size)
end

function igSetAllocatorFunctions(alloc_func, free_func, user_data)
    ccall((:igSetAllocatorFunctions, libcimgui), Cvoid, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}), alloc_func, free_func, user_data)
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
    ccall((:ImGuiIO_AddInputCharacter, libcimgui), Cvoid, (Ptr{ImGuiIO}, ImWchar), self, c)
end

function ImGuiIO_AddInputCharactersUTF8(self, str)
    ccall((:ImGuiIO_AddInputCharactersUTF8, libcimgui), Cvoid, (Ptr{ImGuiIO}, Cstring), self, str)
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
    ccall((:ImGuiInputTextCallbackData_InsertChars, libcimgui), Cvoid, (Ptr{ImGuiInputTextCallbackData}, Cint, Cstring, Cstring), self, pos, text, text_end)
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
    ccall((:ImGuiPayload_IsDataType, libcimgui), Bool, (Ptr{ImGuiPayload}, Cstring), self, type)
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
    ccall((:ImGuiTextFilter_ImGuiTextFilter, libcimgui), Ptr{ImGuiTextFilter}, (Cstring,), default_filter)
end

function ImGuiTextFilter_destroy(self)
    ccall((:ImGuiTextFilter_destroy, libcimgui), Cvoid, (Ptr{ImGuiTextFilter},), self)
end

function ImGuiTextFilter_Draw(self, label, width)
    ccall((:ImGuiTextFilter_Draw, libcimgui), Bool, (Ptr{ImGuiTextFilter}, Cstring, Cfloat), self, label, width)
end

function ImGuiTextFilter_PassFilter(self, text, text_end)
    ccall((:ImGuiTextFilter_PassFilter, libcimgui), Bool, (Ptr{ImGuiTextFilter}, Cstring, Cstring), self, text, text_end)
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

function TextRange_TextRange()
    ccall((:TextRange_TextRange, libcimgui), Ptr{TextRange}, ())
end

function TextRange_destroy(self)
    ccall((:TextRange_destroy, libcimgui), Cvoid, (Ptr{TextRange},), self)
end

function TextRange_TextRangeStr(_b, _e)
    ccall((:TextRange_TextRangeStr, libcimgui), Ptr{TextRange}, (Cstring, Cstring), _b, _e)
end

function TextRange_begin(self)
    ccall((:TextRange_begin, libcimgui), Cstring, (Ptr{TextRange},), self)
end

function TextRange_end(self)
    ccall((:TextRange_end, libcimgui), Cstring, (Ptr{TextRange},), self)
end

function TextRange_empty(self)
    ccall((:TextRange_empty, libcimgui), Bool, (Ptr{TextRange},), self)
end

function TextRange_split(self, separator, out)
    ccall((:TextRange_split, libcimgui), Cvoid, (Ptr{TextRange}, UInt8, Ptr{ImVector_TextRange}), self, separator, out)
end

function ImGuiTextBuffer_ImGuiTextBuffer()
    ccall((:ImGuiTextBuffer_ImGuiTextBuffer, libcimgui), Ptr{ImGuiTextBuffer}, ())
end

function ImGuiTextBuffer_destroy(self)
    ccall((:ImGuiTextBuffer_destroy, libcimgui), Cvoid, (Ptr{ImGuiTextBuffer},), self)
end

function ImGuiTextBuffer_begin(self)
    ccall((:ImGuiTextBuffer_begin, libcimgui), Cstring, (Ptr{ImGuiTextBuffer},), self)
end

function ImGuiTextBuffer_end(self)
    ccall((:ImGuiTextBuffer_end, libcimgui), Cstring, (Ptr{ImGuiTextBuffer},), self)
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
    ccall((:ImGuiTextBuffer_c_str, libcimgui), Cstring, (Ptr{ImGuiTextBuffer},), self)
end

function ImGuiTextBuffer_append(self, str, str_end)
    ccall((:ImGuiTextBuffer_append, libcimgui), Cvoid, (Ptr{ImGuiTextBuffer}, Cstring, Cstring), self, str, str_end)
end

function Pair_PairInt(_key, _val_i)
    ccall((:Pair_PairInt, libcimgui), Ptr{Pair}, (ImGuiID, Cint), _key, _val_i)
end

function Pair_destroy(self)
    ccall((:Pair_destroy, libcimgui), Cvoid, (Ptr{Pair},), self)
end

function Pair_PairFloat(_key, _val_f)
    ccall((:Pair_PairFloat, libcimgui), Ptr{Pair}, (ImGuiID, Cfloat), _key, _val_f)
end

function Pair_PairPtr(_key, _val_p)
    ccall((:Pair_PairPtr, libcimgui), Ptr{Pair}, (ImGuiID, Ptr{Cvoid}), _key, _val_p)
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

function ImGuiListClipper_ImGuiListClipper(items_count, items_height)
    ccall((:ImGuiListClipper_ImGuiListClipper, libcimgui), Ptr{ImGuiListClipper}, (Cint, Cfloat), items_count, items_height)
end

function ImGuiListClipper_destroy(self)
    ccall((:ImGuiListClipper_destroy, libcimgui), Cvoid, (Ptr{ImGuiListClipper},), self)
end

function ImGuiListClipper_Step(self)
    ccall((:ImGuiListClipper_Step, libcimgui), Bool, (Ptr{ImGuiListClipper},), self)
end

function ImGuiListClipper_Begin(self, items_count, items_height)
    ccall((:ImGuiListClipper_Begin, libcimgui), Cvoid, (Ptr{ImGuiListClipper}, Cint, Cfloat), self, items_count, items_height)
end

function ImGuiListClipper_End(self)
    ccall((:ImGuiListClipper_End, libcimgui), Cvoid, (Ptr{ImGuiListClipper},), self)
end

function ImColor_ImColor()
    ccall((:ImColor_ImColor, libcimgui), Ptr{ImColor}, ())
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

function ImColor_HSV(self, h, s, v, a)
    ccall((:ImColor_HSV, libcimgui), ImColor, (Ptr{ImColor}, Cfloat, Cfloat, Cfloat, Cfloat), self, h, s, v, a)
end

function ImDrawCmd_ImDrawCmd()
    ccall((:ImDrawCmd_ImDrawCmd, libcimgui), Ptr{ImDrawCmd}, ())
end

function ImDrawCmd_destroy(self)
    ccall((:ImDrawCmd_destroy, libcimgui), Cvoid, (Ptr{ImDrawCmd},), self)
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

function ImDrawList_GetClipRectMin(self)
    ccall((:ImDrawList_GetClipRectMin, libcimgui), ImVec2, (Ptr{ImDrawList},), self)
end

function ImDrawList_GetClipRectMax(self)
    ccall((:ImDrawList_GetClipRectMax, libcimgui), ImVec2, (Ptr{ImDrawList},), self)
end

function ImDrawList_AddLine(self, a, b, col, thickness)
    ccall((:ImDrawList_AddLine, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImU32, Cfloat), self, a, b, col, thickness)
end

function ImDrawList_AddRect(self, a, b, col, rounding, rounding_corners_flags, thickness)
    ccall((:ImDrawList_AddRect, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImU32, Cfloat, Cint, Cfloat), self, a, b, col, rounding, rounding_corners_flags, thickness)
end

function ImDrawList_AddRectFilled(self, a, b, col, rounding, rounding_corners_flags)
    ccall((:ImDrawList_AddRectFilled, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImU32, Cfloat, Cint), self, a, b, col, rounding, rounding_corners_flags)
end

function ImDrawList_AddRectFilledMultiColor(self, a, b, col_upr_left, col_upr_right, col_bot_right, col_bot_left)
    ccall((:ImDrawList_AddRectFilledMultiColor, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImU32, ImU32, ImU32, ImU32), self, a, b, col_upr_left, col_upr_right, col_bot_right, col_bot_left)
end

function ImDrawList_AddQuad(self, a, b, c, d, col, thickness)
    ccall((:ImDrawList_AddQuad, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImVec2, ImVec2, ImU32, Cfloat), self, a, b, c, d, col, thickness)
end

function ImDrawList_AddQuadFilled(self, a, b, c, d, col)
    ccall((:ImDrawList_AddQuadFilled, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImVec2, ImVec2, ImU32), self, a, b, c, d, col)
end

function ImDrawList_AddTriangle(self, a, b, c, col, thickness)
    ccall((:ImDrawList_AddTriangle, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImVec2, ImU32, Cfloat), self, a, b, c, col, thickness)
end

function ImDrawList_AddTriangleFilled(self, a, b, c, col)
    ccall((:ImDrawList_AddTriangleFilled, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImVec2, ImU32), self, a, b, c, col)
end

function ImDrawList_AddCircle(self, centre, radius, col, num_segments, thickness)
    ccall((:ImDrawList_AddCircle, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, Cfloat, ImU32, Cint, Cfloat), self, centre, radius, col, num_segments, thickness)
end

function ImDrawList_AddCircleFilled(self, centre, radius, col, num_segments)
    ccall((:ImDrawList_AddCircleFilled, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, Cfloat, ImU32, Cint), self, centre, radius, col, num_segments)
end

function ImDrawList_AddText(self, pos, col, text_begin, text_end)
    ccall((:ImDrawList_AddText, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImU32, Cstring, Cstring), self, pos, col, text_begin, text_end)
end

function ImDrawList_AddTextFontPtr(self, font, font_size, pos, col, text_begin, text_end, wrap_width, cpu_fine_clip_rect)
    ccall((:ImDrawList_AddTextFontPtr, libcimgui), Cvoid, (Ptr{ImDrawList}, Ptr{ImFont}, Cfloat, ImVec2, ImU32, Cstring, Cstring, Cfloat, Ptr{ImVec4}), self, font, font_size, pos, col, text_begin, text_end, wrap_width, cpu_fine_clip_rect)
end

function ImDrawList_AddImage(self, user_texture_id, a, b, uv_a, uv_b, col)
    ccall((:ImDrawList_AddImage, libcimgui), Cvoid, (Ptr{ImDrawList}, ImTextureID, ImVec2, ImVec2, ImVec2, ImVec2, ImU32), self, user_texture_id, a, b, uv_a, uv_b, col)
end

function ImDrawList_AddImageQuad(self, user_texture_id, a, b, c, d, uv_a, uv_b, uv_c, uv_d, col)
    ccall((:ImDrawList_AddImageQuad, libcimgui), Cvoid, (Ptr{ImDrawList}, ImTextureID, ImVec2, ImVec2, ImVec2, ImVec2, ImVec2, ImVec2, ImVec2, ImVec2, ImU32), self, user_texture_id, a, b, c, d, uv_a, uv_b, uv_c, uv_d, col)
end

function ImDrawList_AddImageRounded(self, user_texture_id, a, b, uv_a, uv_b, col, rounding, rounding_corners)
    ccall((:ImDrawList_AddImageRounded, libcimgui), Cvoid, (Ptr{ImDrawList}, ImTextureID, ImVec2, ImVec2, ImVec2, ImVec2, ImU32, Cfloat, Cint), self, user_texture_id, a, b, uv_a, uv_b, col, rounding, rounding_corners)
end

function ImDrawList_AddPolyline(self, points, num_points, col, closed, thickness)
    ccall((:ImDrawList_AddPolyline, libcimgui), Cvoid, (Ptr{ImDrawList}, Ptr{ImVec2}, Cint, ImU32, Bool, Cfloat), self, points, num_points, col, closed, thickness)
end

function ImDrawList_AddConvexPolyFilled(self, points, num_points, col)
    ccall((:ImDrawList_AddConvexPolyFilled, libcimgui), Cvoid, (Ptr{ImDrawList}, Ptr{ImVec2}, Cint, ImU32), self, points, num_points, col)
end

function ImDrawList_AddBezierCurve(self, pos0, cp0, cp1, pos1, col, thickness, num_segments)
    ccall((:ImDrawList_AddBezierCurve, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImVec2, ImVec2, ImU32, Cfloat, Cint), self, pos0, cp0, cp1, pos1, col, thickness, num_segments)
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

function ImDrawList_PathStroke(self, col, closed, thickness)
    ccall((:ImDrawList_PathStroke, libcimgui), Cvoid, (Ptr{ImDrawList}, ImU32, Bool, Cfloat), self, col, closed, thickness)
end

function ImDrawList_PathArcTo(self, centre, radius, a_min, a_max, num_segments)
    ccall((:ImDrawList_PathArcTo, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, Cfloat, Cfloat, Cfloat, Cint), self, centre, radius, a_min, a_max, num_segments)
end

function ImDrawList_PathArcToFast(self, centre, radius, a_min_of_12, a_max_of_12)
    ccall((:ImDrawList_PathArcToFast, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, Cfloat, Cint, Cint), self, centre, radius, a_min_of_12, a_max_of_12)
end

function ImDrawList_PathBezierCurveTo(self, p1, p2, p3, num_segments)
    ccall((:ImDrawList_PathBezierCurveTo, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImVec2, Cint), self, p1, p2, p3, num_segments)
end

function ImDrawList_PathRect(self, rect_min, rect_max, rounding, rounding_corners_flags)
    ccall((:ImDrawList_PathRect, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, Cfloat, Cint), self, rect_min, rect_max, rounding, rounding_corners_flags)
end

function ImDrawList_ChannelsSplit(self, channels_count)
    ccall((:ImDrawList_ChannelsSplit, libcimgui), Cvoid, (Ptr{ImDrawList}, Cint), self, channels_count)
end

function ImDrawList_ChannelsMerge(self)
    ccall((:ImDrawList_ChannelsMerge, libcimgui), Cvoid, (Ptr{ImDrawList},), self)
end

function ImDrawList_ChannelsSetCurrent(self, channel_index)
    ccall((:ImDrawList_ChannelsSetCurrent, libcimgui), Cvoid, (Ptr{ImDrawList}, Cint), self, channel_index)
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

function ImDrawList_Clear(self)
    ccall((:ImDrawList_Clear, libcimgui), Cvoid, (Ptr{ImDrawList},), self)
end

function ImDrawList_ClearFreeMemory(self)
    ccall((:ImDrawList_ClearFreeMemory, libcimgui), Cvoid, (Ptr{ImDrawList},), self)
end

function ImDrawList_PrimReserve(self, idx_count, vtx_count)
    ccall((:ImDrawList_PrimReserve, libcimgui), Cvoid, (Ptr{ImDrawList}, Cint, Cint), self, idx_count, vtx_count)
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

function ImDrawList_UpdateClipRect(self)
    ccall((:ImDrawList_UpdateClipRect, libcimgui), Cvoid, (Ptr{ImDrawList},), self)
end

function ImDrawList_UpdateTextureID(self)
    ccall((:ImDrawList_UpdateTextureID, libcimgui), Cvoid, (Ptr{ImDrawList},), self)
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

function ImFontGlyphRangesBuilder_GetBit(self, n)
    ccall((:ImFontGlyphRangesBuilder_GetBit, libcimgui), Bool, (Ptr{ImFontGlyphRangesBuilder}, Cint), self, n)
end

function ImFontGlyphRangesBuilder_SetBit(self, n)
    ccall((:ImFontGlyphRangesBuilder_SetBit, libcimgui), Cvoid, (Ptr{ImFontGlyphRangesBuilder}, Cint), self, n)
end

function ImFontGlyphRangesBuilder_AddChar(self, c)
    ccall((:ImFontGlyphRangesBuilder_AddChar, libcimgui), Cvoid, (Ptr{ImFontGlyphRangesBuilder}, ImWchar), self, c)
end

function ImFontGlyphRangesBuilder_AddText(self, text, text_end)
    ccall((:ImFontGlyphRangesBuilder_AddText, libcimgui), Cvoid, (Ptr{ImFontGlyphRangesBuilder}, Cstring, Cstring), self, text, text_end)
end

function ImFontGlyphRangesBuilder_AddRanges(self, ranges)
    ccall((:ImFontGlyphRangesBuilder_AddRanges, libcimgui), Cvoid, (Ptr{ImFontGlyphRangesBuilder}, Ptr{ImWchar}), self, ranges)
end

function ImFontGlyphRangesBuilder_BuildRanges(self, out_ranges)
    ccall((:ImFontGlyphRangesBuilder_BuildRanges, libcimgui), Cvoid, (Ptr{ImFontGlyphRangesBuilder}, Ptr{ImVector_ImWchar}), self, out_ranges)
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
    ccall((:ImFontAtlas_AddFontFromFileTTF, libcimgui), Ptr{ImFont}, (Ptr{ImFontAtlas}, Cstring, Cfloat, Ptr{ImFontConfig}, Ptr{ImWchar}), self, filename, size_pixels, font_cfg, glyph_ranges)
end

function ImFontAtlas_AddFontFromMemoryTTF(self, font_data, font_size, size_pixels, font_cfg, glyph_ranges)
    ccall((:ImFontAtlas_AddFontFromMemoryTTF, libcimgui), Ptr{ImFont}, (Ptr{ImFontAtlas}, Ptr{Cvoid}, Cint, Cfloat, Ptr{ImFontConfig}, Ptr{ImWchar}), self, font_data, font_size, size_pixels, font_cfg, glyph_ranges)
end

function ImFontAtlas_AddFontFromMemoryCompressedTTF(self, compressed_font_data, compressed_font_size, size_pixels, font_cfg, glyph_ranges)
    ccall((:ImFontAtlas_AddFontFromMemoryCompressedTTF, libcimgui), Ptr{ImFont}, (Ptr{ImFontAtlas}, Ptr{Cvoid}, Cint, Cfloat, Ptr{ImFontConfig}, Ptr{ImWchar}), self, compressed_font_data, compressed_font_size, size_pixels, font_cfg, glyph_ranges)
end

function ImFontAtlas_AddFontFromMemoryCompressedBase85TTF(self, compressed_font_data_base85, size_pixels, font_cfg, glyph_ranges)
    ccall((:ImFontAtlas_AddFontFromMemoryCompressedBase85TTF, libcimgui), Ptr{ImFont}, (Ptr{ImFontAtlas}, Cstring, Cfloat, Ptr{ImFontConfig}, Ptr{ImWchar}), self, compressed_font_data_base85, size_pixels, font_cfg, glyph_ranges)
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

function CustomRect_CustomRect()
    ccall((:CustomRect_CustomRect, libcimgui), Ptr{CustomRect}, ())
end

function CustomRect_destroy(self)
    ccall((:CustomRect_destroy, libcimgui), Cvoid, (Ptr{CustomRect},), self)
end

function CustomRect_IsPacked(self)
    ccall((:CustomRect_IsPacked, libcimgui), Bool, (Ptr{CustomRect},), self)
end

function ImFontAtlas_AddCustomRectRegular(self, id, width, height)
    ccall((:ImFontAtlas_AddCustomRectRegular, libcimgui), Cint, (Ptr{ImFontAtlas}, UInt32, Cint, Cint), self, id, width, height)
end

function ImFontAtlas_AddCustomRectFontGlyph(self, font, id, width, height, advance_x, offset)
    ccall((:ImFontAtlas_AddCustomRectFontGlyph, libcimgui), Cint, (Ptr{ImFontAtlas}, Ptr{ImFont}, ImWchar, Cint, Cint, Cfloat, ImVec2), self, font, id, width, height, advance_x, offset)
end

function ImFontAtlas_GetCustomRectByIndex(self, index)
    ccall((:ImFontAtlas_GetCustomRectByIndex, libcimgui), Ptr{CustomRect}, (Ptr{ImFontAtlas}, Cint), self, index)
end

function ImFontAtlas_CalcCustomRectUV(self, rect, out_uv_min, out_uv_max)
    ccall((:ImFontAtlas_CalcCustomRectUV, libcimgui), Cvoid, (Ptr{ImFontAtlas}, Ptr{CustomRect}, Ptr{ImVec2}, Ptr{ImVec2}), self, rect, out_uv_min, out_uv_max)
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
    ccall((:ImFont_GetDebugName, libcimgui), Cstring, (Ptr{ImFont},), self)
end

function ImFont_CalcTextSizeA(self, size, max_width, wrap_width, text_begin, text_end, remaining)
    ccall((:ImFont_CalcTextSizeA, libcimgui), ImVec2, (Ptr{ImFont}, Cfloat, Cfloat, Cfloat, Cstring, Cstring, Ptr{Cstring}), self, size, max_width, wrap_width, text_begin, text_end, remaining)
end

function ImFont_CalcWordWrapPositionA(self, scale, text, text_end, wrap_width)
    ccall((:ImFont_CalcWordWrapPositionA, libcimgui), Cstring, (Ptr{ImFont}, Cfloat, Cstring, Cstring, Cfloat), self, scale, text, text_end, wrap_width)
end

function ImFont_RenderChar(self, draw_list, size, pos, col, c)
    ccall((:ImFont_RenderChar, libcimgui), Cvoid, (Ptr{ImFont}, Ptr{ImDrawList}, Cfloat, ImVec2, ImU32, ImWchar), self, draw_list, size, pos, col, c)
end

function ImFont_RenderText(self, draw_list, size, pos, col, clip_rect, text_begin, text_end, wrap_width, cpu_fine_clip)
    ccall((:ImFont_RenderText, libcimgui), Cvoid, (Ptr{ImFont}, Ptr{ImDrawList}, Cfloat, ImVec2, ImU32, ImVec4, Cstring, Cstring, Cfloat, Bool), self, draw_list, size, pos, col, clip_rect, text_begin, text_end, wrap_width, cpu_fine_clip)
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

function ImFont_AddGlyph(self, c, x0, y0, x1, y1, u0, v0, u1, v1, advance_x)
    ccall((:ImFont_AddGlyph, libcimgui), Cvoid, (Ptr{ImFont}, ImWchar, Cfloat, Cfloat, Cfloat, Cfloat, Cfloat, Cfloat, Cfloat, Cfloat, Cfloat), self, c, x0, y0, x1, y1, u0, v0, u1, v1, advance_x)
end

function ImFont_AddRemapChar(self, dst, src, overwrite_dst)
    ccall((:ImFont_AddRemapChar, libcimgui), Cvoid, (Ptr{ImFont}, ImWchar, ImWchar, Bool), self, dst, src, overwrite_dst)
end

function ImFont_SetFallbackChar(self, c)
    ccall((:ImFont_SetFallbackChar, libcimgui), Cvoid, (Ptr{ImFont}, ImWchar), self, c)
end

function igGetWindowPos_nonUDT(pOut)
    ccall((:igGetWindowPos_nonUDT, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetWindowPos_nonUDT2()
    ccall((:igGetWindowPos_nonUDT2, libcimgui), ImVec2_Simple, ())
end

function igGetWindowSize_nonUDT(pOut)
    ccall((:igGetWindowSize_nonUDT, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetWindowSize_nonUDT2()
    ccall((:igGetWindowSize_nonUDT2, libcimgui), ImVec2_Simple, ())
end

function igGetContentRegionMax_nonUDT(pOut)
    ccall((:igGetContentRegionMax_nonUDT, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetContentRegionMax_nonUDT2()
    ccall((:igGetContentRegionMax_nonUDT2, libcimgui), ImVec2_Simple, ())
end

function igGetContentRegionAvail_nonUDT(pOut)
    ccall((:igGetContentRegionAvail_nonUDT, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetContentRegionAvail_nonUDT2()
    ccall((:igGetContentRegionAvail_nonUDT2, libcimgui), ImVec2_Simple, ())
end

function igGetWindowContentRegionMin_nonUDT(pOut)
    ccall((:igGetWindowContentRegionMin_nonUDT, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetWindowContentRegionMin_nonUDT2()
    ccall((:igGetWindowContentRegionMin_nonUDT2, libcimgui), ImVec2_Simple, ())
end

function igGetWindowContentRegionMax_nonUDT(pOut)
    ccall((:igGetWindowContentRegionMax_nonUDT, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetWindowContentRegionMax_nonUDT2()
    ccall((:igGetWindowContentRegionMax_nonUDT2, libcimgui), ImVec2_Simple, ())
end

function igGetFontTexUvWhitePixel_nonUDT(pOut)
    ccall((:igGetFontTexUvWhitePixel_nonUDT, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetFontTexUvWhitePixel_nonUDT2()
    ccall((:igGetFontTexUvWhitePixel_nonUDT2, libcimgui), ImVec2_Simple, ())
end

function igGetCursorPos_nonUDT(pOut)
    ccall((:igGetCursorPos_nonUDT, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetCursorPos_nonUDT2()
    ccall((:igGetCursorPos_nonUDT2, libcimgui), ImVec2_Simple, ())
end

function igGetCursorStartPos_nonUDT(pOut)
    ccall((:igGetCursorStartPos_nonUDT, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetCursorStartPos_nonUDT2()
    ccall((:igGetCursorStartPos_nonUDT2, libcimgui), ImVec2_Simple, ())
end

function igGetCursorScreenPos_nonUDT(pOut)
    ccall((:igGetCursorScreenPos_nonUDT, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetCursorScreenPos_nonUDT2()
    ccall((:igGetCursorScreenPos_nonUDT2, libcimgui), ImVec2_Simple, ())
end

function igGetItemRectMin_nonUDT(pOut)
    ccall((:igGetItemRectMin_nonUDT, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetItemRectMin_nonUDT2()
    ccall((:igGetItemRectMin_nonUDT2, libcimgui), ImVec2_Simple, ())
end

function igGetItemRectMax_nonUDT(pOut)
    ccall((:igGetItemRectMax_nonUDT, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetItemRectMax_nonUDT2()
    ccall((:igGetItemRectMax_nonUDT2, libcimgui), ImVec2_Simple, ())
end

function igGetItemRectSize_nonUDT(pOut)
    ccall((:igGetItemRectSize_nonUDT, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetItemRectSize_nonUDT2()
    ccall((:igGetItemRectSize_nonUDT2, libcimgui), ImVec2_Simple, ())
end

function igCalcTextSize_nonUDT(pOut, text, text_end, hide_text_after_double_hash, wrap_width)
    ccall((:igCalcTextSize_nonUDT, libcimgui), Cvoid, (Ptr{ImVec2}, Cstring, Cstring, Bool, Cfloat), pOut, text, text_end, hide_text_after_double_hash, wrap_width)
end

function igCalcTextSize_nonUDT2(text, text_end, hide_text_after_double_hash, wrap_width)
    ccall((:igCalcTextSize_nonUDT2, libcimgui), ImVec2_Simple, (Cstring, Cstring, Bool, Cfloat), text, text_end, hide_text_after_double_hash, wrap_width)
end

function igColorConvertU32ToFloat4_nonUDT(pOut, in)
    ccall((:igColorConvertU32ToFloat4_nonUDT, libcimgui), Cvoid, (Ptr{ImVec4}, ImU32), pOut, in)
end

function igColorConvertU32ToFloat4_nonUDT2(in)
    ccall((:igColorConvertU32ToFloat4_nonUDT2, libcimgui), ImVec4_Simple, (ImU32,), in)
end

function igGetMousePos_nonUDT(pOut)
    ccall((:igGetMousePos_nonUDT, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetMousePos_nonUDT2()
    ccall((:igGetMousePos_nonUDT2, libcimgui), ImVec2_Simple, ())
end

function igGetMousePosOnOpeningCurrentPopup_nonUDT(pOut)
    ccall((:igGetMousePosOnOpeningCurrentPopup_nonUDT, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetMousePosOnOpeningCurrentPopup_nonUDT2()
    ccall((:igGetMousePosOnOpeningCurrentPopup_nonUDT2, libcimgui), ImVec2_Simple, ())
end

function igGetMouseDragDelta_nonUDT(pOut, button, lock_threshold)
    ccall((:igGetMouseDragDelta_nonUDT, libcimgui), Cvoid, (Ptr{ImVec2}, Cint, Cfloat), pOut, button, lock_threshold)
end

function igGetMouseDragDelta_nonUDT2(button, lock_threshold)
    ccall((:igGetMouseDragDelta_nonUDT2, libcimgui), ImVec2_Simple, (Cint, Cfloat), button, lock_threshold)
end

function ImColor_HSV_nonUDT(pOut, self, h, s, v, a)
    ccall((:ImColor_HSV_nonUDT, libcimgui), Cvoid, (Ptr{ImColor}, Ptr{ImColor}, Cfloat, Cfloat, Cfloat, Cfloat), pOut, self, h, s, v, a)
end

function ImColor_HSV_nonUDT2(self, h, s, v, a)
    ccall((:ImColor_HSV_nonUDT2, libcimgui), ImColor_Simple, (Ptr{ImColor}, Cfloat, Cfloat, Cfloat, Cfloat), self, h, s, v, a)
end

function ImDrawList_GetClipRectMin_nonUDT(pOut, self)
    ccall((:ImDrawList_GetClipRectMin_nonUDT, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImDrawList}), pOut, self)
end

function ImDrawList_GetClipRectMin_nonUDT2(self)
    ccall((:ImDrawList_GetClipRectMin_nonUDT2, libcimgui), ImVec2_Simple, (Ptr{ImDrawList},), self)
end

function ImDrawList_GetClipRectMax_nonUDT(pOut, self)
    ccall((:ImDrawList_GetClipRectMax_nonUDT, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImDrawList}), pOut, self)
end

function ImDrawList_GetClipRectMax_nonUDT2(self)
    ccall((:ImDrawList_GetClipRectMax_nonUDT2, libcimgui), ImVec2_Simple, (Ptr{ImDrawList},), self)
end

function ImFont_CalcTextSizeA_nonUDT(pOut, self, size, max_width, wrap_width, text_begin, text_end, remaining)
    ccall((:ImFont_CalcTextSizeA_nonUDT, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImFont}, Cfloat, Cfloat, Cfloat, Cstring, Cstring, Ptr{Cstring}), pOut, self, size, max_width, wrap_width, text_begin, text_end, remaining)
end

function ImFont_CalcTextSizeA_nonUDT2(self, size, max_width, wrap_width, text_begin, text_end, remaining)
    ccall((:ImFont_CalcTextSizeA_nonUDT2, libcimgui), ImVec2_Simple, (Ptr{ImFont}, Cfloat, Cfloat, Cfloat, Cstring, Cstring, Ptr{Cstring}), self, size, max_width, wrap_width, text_begin, text_end, remaining)
end

function ImVector_float_ImVector_float()
    ccall((:ImVector_float_ImVector_float, libcimgui), Ptr{ImVector_float}, ())
end

function ImVector_float_destroy(self)
    ccall((:ImVector_float_destroy, libcimgui), Cvoid, (Ptr{ImVector_float},), self)
end

function ImVector_ImWchar_ImVector_ImWchar()
    ccall((:ImVector_ImWchar_ImVector_ImWchar, libcimgui), Ptr{ImVector_ImWchar}, ())
end

function ImVector_ImWchar_destroy(self)
    ccall((:ImVector_ImWchar_destroy, libcimgui), Cvoid, (Ptr{ImVector_ImWchar},), self)
end

function ImVector_ImFontConfig_ImVector_ImFontConfig()
    ccall((:ImVector_ImFontConfig_ImVector_ImFontConfig, libcimgui), Ptr{ImVector_ImFontConfig}, ())
end

function ImVector_ImFontConfig_destroy(self)
    ccall((:ImVector_ImFontConfig_destroy, libcimgui), Cvoid, (Ptr{ImVector_ImFontConfig},), self)
end

function ImVector_ImFontGlyph_ImVector_ImFontGlyph()
    ccall((:ImVector_ImFontGlyph_ImVector_ImFontGlyph, libcimgui), Ptr{ImVector_ImFontGlyph}, ())
end

function ImVector_ImFontGlyph_destroy(self)
    ccall((:ImVector_ImFontGlyph_destroy, libcimgui), Cvoid, (Ptr{ImVector_ImFontGlyph},), self)
end

function ImVector_TextRange_ImVector_TextRange()
    ccall((:ImVector_TextRange_ImVector_TextRange, libcimgui), Ptr{ImVector_TextRange}, ())
end

function ImVector_TextRange_destroy(self)
    ccall((:ImVector_TextRange_destroy, libcimgui), Cvoid, (Ptr{ImVector_TextRange},), self)
end

function ImVector_CustomRect_ImVector_CustomRect()
    ccall((:ImVector_CustomRect_ImVector_CustomRect, libcimgui), Ptr{ImVector_CustomRect}, ())
end

function ImVector_CustomRect_destroy(self)
    ccall((:ImVector_CustomRect_destroy, libcimgui), Cvoid, (Ptr{ImVector_CustomRect},), self)
end

function ImVector_ImDrawChannel_ImVector_ImDrawChannel()
    ccall((:ImVector_ImDrawChannel_ImVector_ImDrawChannel, libcimgui), Ptr{ImVector_ImDrawChannel}, ())
end

function ImVector_ImDrawChannel_destroy(self)
    ccall((:ImVector_ImDrawChannel_destroy, libcimgui), Cvoid, (Ptr{ImVector_ImDrawChannel},), self)
end

function ImVector_char_ImVector_char()
    ccall((:ImVector_char_ImVector_char, libcimgui), Ptr{ImVector_char}, ())
end

function ImVector_char_destroy(self)
    ccall((:ImVector_char_destroy, libcimgui), Cvoid, (Ptr{ImVector_char},), self)
end

function ImVector_ImTextureID_ImVector_ImTextureID()
    ccall((:ImVector_ImTextureID_ImVector_ImTextureID, libcimgui), Ptr{ImVector_ImTextureID}, ())
end

function ImVector_ImTextureID_destroy(self)
    ccall((:ImVector_ImTextureID_destroy, libcimgui), Cvoid, (Ptr{ImVector_ImTextureID},), self)
end

function ImVector_ImDrawVert_ImVector_ImDrawVert()
    ccall((:ImVector_ImDrawVert_ImVector_ImDrawVert, libcimgui), Ptr{ImVector_ImDrawVert}, ())
end

function ImVector_ImDrawVert_destroy(self)
    ccall((:ImVector_ImDrawVert_destroy, libcimgui), Cvoid, (Ptr{ImVector_ImDrawVert},), self)
end

function ImVector_int_ImVector_int()
    ccall((:ImVector_int_ImVector_int, libcimgui), Ptr{ImVector_int}, ())
end

function ImVector_int_destroy(self)
    ccall((:ImVector_int_destroy, libcimgui), Cvoid, (Ptr{ImVector_int},), self)
end

function ImVector_Pair_ImVector_Pair()
    ccall((:ImVector_Pair_ImVector_Pair, libcimgui), Ptr{ImVector_Pair}, ())
end

function ImVector_Pair_destroy(self)
    ccall((:ImVector_Pair_destroy, libcimgui), Cvoid, (Ptr{ImVector_Pair},), self)
end

function ImVector_ImFontPtr_ImVector_ImFontPtr()
    ccall((:ImVector_ImFontPtr_ImVector_ImFontPtr, libcimgui), Ptr{ImVector_ImFontPtr}, ())
end

function ImVector_ImFontPtr_destroy(self)
    ccall((:ImVector_ImFontPtr_destroy, libcimgui), Cvoid, (Ptr{ImVector_ImFontPtr},), self)
end

function ImVector_ImVec4_ImVector_ImVec4()
    ccall((:ImVector_ImVec4_ImVector_ImVec4, libcimgui), Ptr{ImVector_ImVec4}, ())
end

function ImVector_ImVec4_destroy(self)
    ccall((:ImVector_ImVec4_destroy, libcimgui), Cvoid, (Ptr{ImVector_ImVec4},), self)
end

function ImVector_ImDrawCmd_ImVector_ImDrawCmd()
    ccall((:ImVector_ImDrawCmd_ImVector_ImDrawCmd, libcimgui), Ptr{ImVector_ImDrawCmd}, ())
end

function ImVector_ImDrawCmd_destroy(self)
    ccall((:ImVector_ImDrawCmd_destroy, libcimgui), Cvoid, (Ptr{ImVector_ImDrawCmd},), self)
end

function ImVector_ImDrawIdx_ImVector_ImDrawIdx()
    ccall((:ImVector_ImDrawIdx_ImVector_ImDrawIdx, libcimgui), Ptr{ImVector_ImDrawIdx}, ())
end

function ImVector_ImDrawIdx_destroy(self)
    ccall((:ImVector_ImDrawIdx_destroy, libcimgui), Cvoid, (Ptr{ImVector_ImDrawIdx},), self)
end

function ImVector_ImVec2_ImVector_ImVec2()
    ccall((:ImVector_ImVec2_ImVector_ImVec2, libcimgui), Ptr{ImVector_ImVec2}, ())
end

function ImVector_ImVec2_destroy(self)
    ccall((:ImVector_ImVec2_destroy, libcimgui), Cvoid, (Ptr{ImVector_ImVec2},), self)
end

function ImVector_float_ImVector_floatVector(src)
    ccall((:ImVector_float_ImVector_floatVector, libcimgui), Ptr{ImVector_float}, (ImVector_float,), src)
end

function ImVector_ImWchar_ImVector_ImWcharVector(src)
    ccall((:ImVector_ImWchar_ImVector_ImWcharVector, libcimgui), Ptr{ImVector_ImWchar}, (ImVector_ImWchar,), src)
end

function ImVector_ImFontConfig_ImVector_ImFontConfigVector(src)
    ccall((:ImVector_ImFontConfig_ImVector_ImFontConfigVector, libcimgui), Ptr{ImVector_ImFontConfig}, (ImVector_ImFontConfig,), src)
end

function ImVector_ImFontGlyph_ImVector_ImFontGlyphVector(src)
    ccall((:ImVector_ImFontGlyph_ImVector_ImFontGlyphVector, libcimgui), Ptr{ImVector_ImFontGlyph}, (ImVector_ImFontGlyph,), src)
end

function ImVector_TextRange_ImVector_TextRangeVector(src)
    ccall((:ImVector_TextRange_ImVector_TextRangeVector, libcimgui), Ptr{ImVector_TextRange}, (ImVector_TextRange,), src)
end

function ImVector_CustomRect_ImVector_CustomRectVector(src)
    ccall((:ImVector_CustomRect_ImVector_CustomRectVector, libcimgui), Ptr{ImVector_CustomRect}, (ImVector_CustomRect,), src)
end

function ImVector_ImDrawChannel_ImVector_ImDrawChannelVector(src)
    ccall((:ImVector_ImDrawChannel_ImVector_ImDrawChannelVector, libcimgui), Ptr{ImVector_ImDrawChannel}, (ImVector_ImDrawChannel,), src)
end

function ImVector_char_ImVector_charVector(src)
    ccall((:ImVector_char_ImVector_charVector, libcimgui), Ptr{ImVector_char}, (ImVector_char,), src)
end

function ImVector_ImTextureID_ImVector_ImTextureIDVector(src)
    ccall((:ImVector_ImTextureID_ImVector_ImTextureIDVector, libcimgui), Ptr{ImVector_ImTextureID}, (ImVector_ImTextureID,), src)
end

function ImVector_ImDrawVert_ImVector_ImDrawVertVector(src)
    ccall((:ImVector_ImDrawVert_ImVector_ImDrawVertVector, libcimgui), Ptr{ImVector_ImDrawVert}, (ImVector_ImDrawVert,), src)
end

function ImVector_int_ImVector_intVector(src)
    ccall((:ImVector_int_ImVector_intVector, libcimgui), Ptr{ImVector_int}, (ImVector_int,), src)
end

function ImVector_Pair_ImVector_PairVector(src)
    ccall((:ImVector_Pair_ImVector_PairVector, libcimgui), Ptr{ImVector_Pair}, (ImVector_Pair,), src)
end

function ImVector_ImFontPtr_ImVector_ImFontPtrVector(src)
    ccall((:ImVector_ImFontPtr_ImVector_ImFontPtrVector, libcimgui), Ptr{ImVector_ImFontPtr}, (ImVector_ImFontPtr,), src)
end

function ImVector_ImVec4_ImVector_ImVec4Vector(src)
    ccall((:ImVector_ImVec4_ImVector_ImVec4Vector, libcimgui), Ptr{ImVector_ImVec4}, (ImVector_ImVec4,), src)
end

function ImVector_ImDrawCmd_ImVector_ImDrawCmdVector(src)
    ccall((:ImVector_ImDrawCmd_ImVector_ImDrawCmdVector, libcimgui), Ptr{ImVector_ImDrawCmd}, (ImVector_ImDrawCmd,), src)
end

function ImVector_ImDrawIdx_ImVector_ImDrawIdxVector(src)
    ccall((:ImVector_ImDrawIdx_ImVector_ImDrawIdxVector, libcimgui), Ptr{ImVector_ImDrawIdx}, (ImVector_ImDrawIdx,), src)
end

function ImVector_ImVec2_ImVector_ImVec2Vector(src)
    ccall((:ImVector_ImVec2_ImVector_ImVec2Vector, libcimgui), Ptr{ImVector_ImVec2}, (ImVector_ImVec2,), src)
end

function ImVector_float_empty(self)
    ccall((:ImVector_float_empty, libcimgui), Bool, (Ptr{ImVector_float},), self)
end

function ImVector_ImWchar_empty(self)
    ccall((:ImVector_ImWchar_empty, libcimgui), Bool, (Ptr{ImVector_ImWchar},), self)
end

function ImVector_ImFontConfig_empty(self)
    ccall((:ImVector_ImFontConfig_empty, libcimgui), Bool, (Ptr{ImVector_ImFontConfig},), self)
end

function ImVector_ImFontGlyph_empty(self)
    ccall((:ImVector_ImFontGlyph_empty, libcimgui), Bool, (Ptr{ImVector_ImFontGlyph},), self)
end

function ImVector_TextRange_empty(self)
    ccall((:ImVector_TextRange_empty, libcimgui), Bool, (Ptr{ImVector_TextRange},), self)
end

function ImVector_CustomRect_empty(self)
    ccall((:ImVector_CustomRect_empty, libcimgui), Bool, (Ptr{ImVector_CustomRect},), self)
end

function ImVector_ImDrawChannel_empty(self)
    ccall((:ImVector_ImDrawChannel_empty, libcimgui), Bool, (Ptr{ImVector_ImDrawChannel},), self)
end

function ImVector_char_empty(self)
    ccall((:ImVector_char_empty, libcimgui), Bool, (Ptr{ImVector_char},), self)
end

function ImVector_ImTextureID_empty(self)
    ccall((:ImVector_ImTextureID_empty, libcimgui), Bool, (Ptr{ImVector_ImTextureID},), self)
end

function ImVector_ImDrawVert_empty(self)
    ccall((:ImVector_ImDrawVert_empty, libcimgui), Bool, (Ptr{ImVector_ImDrawVert},), self)
end

function ImVector_int_empty(self)
    ccall((:ImVector_int_empty, libcimgui), Bool, (Ptr{ImVector_int},), self)
end

function ImVector_Pair_empty(self)
    ccall((:ImVector_Pair_empty, libcimgui), Bool, (Ptr{ImVector_Pair},), self)
end

function ImVector_ImFontPtr_empty(self)
    ccall((:ImVector_ImFontPtr_empty, libcimgui), Bool, (Ptr{ImVector_ImFontPtr},), self)
end

function ImVector_ImVec4_empty(self)
    ccall((:ImVector_ImVec4_empty, libcimgui), Bool, (Ptr{ImVector_ImVec4},), self)
end

function ImVector_ImDrawCmd_empty(self)
    ccall((:ImVector_ImDrawCmd_empty, libcimgui), Bool, (Ptr{ImVector_ImDrawCmd},), self)
end

function ImVector_ImDrawIdx_empty(self)
    ccall((:ImVector_ImDrawIdx_empty, libcimgui), Bool, (Ptr{ImVector_ImDrawIdx},), self)
end

function ImVector_ImVec2_empty(self)
    ccall((:ImVector_ImVec2_empty, libcimgui), Bool, (Ptr{ImVector_ImVec2},), self)
end

function ImVector_float_size(self)
    ccall((:ImVector_float_size, libcimgui), Cint, (Ptr{ImVector_float},), self)
end

function ImVector_ImWchar_size(self)
    ccall((:ImVector_ImWchar_size, libcimgui), Cint, (Ptr{ImVector_ImWchar},), self)
end

function ImVector_ImFontConfig_size(self)
    ccall((:ImVector_ImFontConfig_size, libcimgui), Cint, (Ptr{ImVector_ImFontConfig},), self)
end

function ImVector_ImFontGlyph_size(self)
    ccall((:ImVector_ImFontGlyph_size, libcimgui), Cint, (Ptr{ImVector_ImFontGlyph},), self)
end

function ImVector_TextRange_size(self)
    ccall((:ImVector_TextRange_size, libcimgui), Cint, (Ptr{ImVector_TextRange},), self)
end

function ImVector_CustomRect_size(self)
    ccall((:ImVector_CustomRect_size, libcimgui), Cint, (Ptr{ImVector_CustomRect},), self)
end

function ImVector_ImDrawChannel_size(self)
    ccall((:ImVector_ImDrawChannel_size, libcimgui), Cint, (Ptr{ImVector_ImDrawChannel},), self)
end

function ImVector_char_size(self)
    ccall((:ImVector_char_size, libcimgui), Cint, (Ptr{ImVector_char},), self)
end

function ImVector_ImTextureID_size(self)
    ccall((:ImVector_ImTextureID_size, libcimgui), Cint, (Ptr{ImVector_ImTextureID},), self)
end

function ImVector_ImDrawVert_size(self)
    ccall((:ImVector_ImDrawVert_size, libcimgui), Cint, (Ptr{ImVector_ImDrawVert},), self)
end

function ImVector_int_size(self)
    ccall((:ImVector_int_size, libcimgui), Cint, (Ptr{ImVector_int},), self)
end

function ImVector_Pair_size(self)
    ccall((:ImVector_Pair_size, libcimgui), Cint, (Ptr{ImVector_Pair},), self)
end

function ImVector_ImFontPtr_size(self)
    ccall((:ImVector_ImFontPtr_size, libcimgui), Cint, (Ptr{ImVector_ImFontPtr},), self)
end

function ImVector_ImVec4_size(self)
    ccall((:ImVector_ImVec4_size, libcimgui), Cint, (Ptr{ImVector_ImVec4},), self)
end

function ImVector_ImDrawCmd_size(self)
    ccall((:ImVector_ImDrawCmd_size, libcimgui), Cint, (Ptr{ImVector_ImDrawCmd},), self)
end

function ImVector_ImDrawIdx_size(self)
    ccall((:ImVector_ImDrawIdx_size, libcimgui), Cint, (Ptr{ImVector_ImDrawIdx},), self)
end

function ImVector_ImVec2_size(self)
    ccall((:ImVector_ImVec2_size, libcimgui), Cint, (Ptr{ImVector_ImVec2},), self)
end

function ImVector_float_size_in_bytes(self)
    ccall((:ImVector_float_size_in_bytes, libcimgui), Cint, (Ptr{ImVector_float},), self)
end

function ImVector_ImWchar_size_in_bytes(self)
    ccall((:ImVector_ImWchar_size_in_bytes, libcimgui), Cint, (Ptr{ImVector_ImWchar},), self)
end

function ImVector_ImFontConfig_size_in_bytes(self)
    ccall((:ImVector_ImFontConfig_size_in_bytes, libcimgui), Cint, (Ptr{ImVector_ImFontConfig},), self)
end

function ImVector_ImFontGlyph_size_in_bytes(self)
    ccall((:ImVector_ImFontGlyph_size_in_bytes, libcimgui), Cint, (Ptr{ImVector_ImFontGlyph},), self)
end

function ImVector_TextRange_size_in_bytes(self)
    ccall((:ImVector_TextRange_size_in_bytes, libcimgui), Cint, (Ptr{ImVector_TextRange},), self)
end

function ImVector_CustomRect_size_in_bytes(self)
    ccall((:ImVector_CustomRect_size_in_bytes, libcimgui), Cint, (Ptr{ImVector_CustomRect},), self)
end

function ImVector_ImDrawChannel_size_in_bytes(self)
    ccall((:ImVector_ImDrawChannel_size_in_bytes, libcimgui), Cint, (Ptr{ImVector_ImDrawChannel},), self)
end

function ImVector_char_size_in_bytes(self)
    ccall((:ImVector_char_size_in_bytes, libcimgui), Cint, (Ptr{ImVector_char},), self)
end

function ImVector_ImTextureID_size_in_bytes(self)
    ccall((:ImVector_ImTextureID_size_in_bytes, libcimgui), Cint, (Ptr{ImVector_ImTextureID},), self)
end

function ImVector_ImDrawVert_size_in_bytes(self)
    ccall((:ImVector_ImDrawVert_size_in_bytes, libcimgui), Cint, (Ptr{ImVector_ImDrawVert},), self)
end

function ImVector_int_size_in_bytes(self)
    ccall((:ImVector_int_size_in_bytes, libcimgui), Cint, (Ptr{ImVector_int},), self)
end

function ImVector_Pair_size_in_bytes(self)
    ccall((:ImVector_Pair_size_in_bytes, libcimgui), Cint, (Ptr{ImVector_Pair},), self)
end

function ImVector_ImFontPtr_size_in_bytes(self)
    ccall((:ImVector_ImFontPtr_size_in_bytes, libcimgui), Cint, (Ptr{ImVector_ImFontPtr},), self)
end

function ImVector_ImVec4_size_in_bytes(self)
    ccall((:ImVector_ImVec4_size_in_bytes, libcimgui), Cint, (Ptr{ImVector_ImVec4},), self)
end

function ImVector_ImDrawCmd_size_in_bytes(self)
    ccall((:ImVector_ImDrawCmd_size_in_bytes, libcimgui), Cint, (Ptr{ImVector_ImDrawCmd},), self)
end

function ImVector_ImDrawIdx_size_in_bytes(self)
    ccall((:ImVector_ImDrawIdx_size_in_bytes, libcimgui), Cint, (Ptr{ImVector_ImDrawIdx},), self)
end

function ImVector_ImVec2_size_in_bytes(self)
    ccall((:ImVector_ImVec2_size_in_bytes, libcimgui), Cint, (Ptr{ImVector_ImVec2},), self)
end

function ImVector_float_capacity(self)
    ccall((:ImVector_float_capacity, libcimgui), Cint, (Ptr{ImVector_float},), self)
end

function ImVector_ImWchar_capacity(self)
    ccall((:ImVector_ImWchar_capacity, libcimgui), Cint, (Ptr{ImVector_ImWchar},), self)
end

function ImVector_ImFontConfig_capacity(self)
    ccall((:ImVector_ImFontConfig_capacity, libcimgui), Cint, (Ptr{ImVector_ImFontConfig},), self)
end

function ImVector_ImFontGlyph_capacity(self)
    ccall((:ImVector_ImFontGlyph_capacity, libcimgui), Cint, (Ptr{ImVector_ImFontGlyph},), self)
end

function ImVector_TextRange_capacity(self)
    ccall((:ImVector_TextRange_capacity, libcimgui), Cint, (Ptr{ImVector_TextRange},), self)
end

function ImVector_CustomRect_capacity(self)
    ccall((:ImVector_CustomRect_capacity, libcimgui), Cint, (Ptr{ImVector_CustomRect},), self)
end

function ImVector_ImDrawChannel_capacity(self)
    ccall((:ImVector_ImDrawChannel_capacity, libcimgui), Cint, (Ptr{ImVector_ImDrawChannel},), self)
end

function ImVector_char_capacity(self)
    ccall((:ImVector_char_capacity, libcimgui), Cint, (Ptr{ImVector_char},), self)
end

function ImVector_ImTextureID_capacity(self)
    ccall((:ImVector_ImTextureID_capacity, libcimgui), Cint, (Ptr{ImVector_ImTextureID},), self)
end

function ImVector_ImDrawVert_capacity(self)
    ccall((:ImVector_ImDrawVert_capacity, libcimgui), Cint, (Ptr{ImVector_ImDrawVert},), self)
end

function ImVector_int_capacity(self)
    ccall((:ImVector_int_capacity, libcimgui), Cint, (Ptr{ImVector_int},), self)
end

function ImVector_Pair_capacity(self)
    ccall((:ImVector_Pair_capacity, libcimgui), Cint, (Ptr{ImVector_Pair},), self)
end

function ImVector_ImFontPtr_capacity(self)
    ccall((:ImVector_ImFontPtr_capacity, libcimgui), Cint, (Ptr{ImVector_ImFontPtr},), self)
end

function ImVector_ImVec4_capacity(self)
    ccall((:ImVector_ImVec4_capacity, libcimgui), Cint, (Ptr{ImVector_ImVec4},), self)
end

function ImVector_ImDrawCmd_capacity(self)
    ccall((:ImVector_ImDrawCmd_capacity, libcimgui), Cint, (Ptr{ImVector_ImDrawCmd},), self)
end

function ImVector_ImDrawIdx_capacity(self)
    ccall((:ImVector_ImDrawIdx_capacity, libcimgui), Cint, (Ptr{ImVector_ImDrawIdx},), self)
end

function ImVector_ImVec2_capacity(self)
    ccall((:ImVector_ImVec2_capacity, libcimgui), Cint, (Ptr{ImVector_ImVec2},), self)
end

function ImVector_float_clear(self)
    ccall((:ImVector_float_clear, libcimgui), Cvoid, (Ptr{ImVector_float},), self)
end

function ImVector_ImWchar_clear(self)
    ccall((:ImVector_ImWchar_clear, libcimgui), Cvoid, (Ptr{ImVector_ImWchar},), self)
end

function ImVector_ImFontConfig_clear(self)
    ccall((:ImVector_ImFontConfig_clear, libcimgui), Cvoid, (Ptr{ImVector_ImFontConfig},), self)
end

function ImVector_ImFontGlyph_clear(self)
    ccall((:ImVector_ImFontGlyph_clear, libcimgui), Cvoid, (Ptr{ImVector_ImFontGlyph},), self)
end

function ImVector_TextRange_clear(self)
    ccall((:ImVector_TextRange_clear, libcimgui), Cvoid, (Ptr{ImVector_TextRange},), self)
end

function ImVector_CustomRect_clear(self)
    ccall((:ImVector_CustomRect_clear, libcimgui), Cvoid, (Ptr{ImVector_CustomRect},), self)
end

function ImVector_ImDrawChannel_clear(self)
    ccall((:ImVector_ImDrawChannel_clear, libcimgui), Cvoid, (Ptr{ImVector_ImDrawChannel},), self)
end

function ImVector_char_clear(self)
    ccall((:ImVector_char_clear, libcimgui), Cvoid, (Ptr{ImVector_char},), self)
end

function ImVector_ImTextureID_clear(self)
    ccall((:ImVector_ImTextureID_clear, libcimgui), Cvoid, (Ptr{ImVector_ImTextureID},), self)
end

function ImVector_ImDrawVert_clear(self)
    ccall((:ImVector_ImDrawVert_clear, libcimgui), Cvoid, (Ptr{ImVector_ImDrawVert},), self)
end

function ImVector_int_clear(self)
    ccall((:ImVector_int_clear, libcimgui), Cvoid, (Ptr{ImVector_int},), self)
end

function ImVector_Pair_clear(self)
    ccall((:ImVector_Pair_clear, libcimgui), Cvoid, (Ptr{ImVector_Pair},), self)
end

function ImVector_ImFontPtr_clear(self)
    ccall((:ImVector_ImFontPtr_clear, libcimgui), Cvoid, (Ptr{ImVector_ImFontPtr},), self)
end

function ImVector_ImVec4_clear(self)
    ccall((:ImVector_ImVec4_clear, libcimgui), Cvoid, (Ptr{ImVector_ImVec4},), self)
end

function ImVector_ImDrawCmd_clear(self)
    ccall((:ImVector_ImDrawCmd_clear, libcimgui), Cvoid, (Ptr{ImVector_ImDrawCmd},), self)
end

function ImVector_ImDrawIdx_clear(self)
    ccall((:ImVector_ImDrawIdx_clear, libcimgui), Cvoid, (Ptr{ImVector_ImDrawIdx},), self)
end

function ImVector_ImVec2_clear(self)
    ccall((:ImVector_ImVec2_clear, libcimgui), Cvoid, (Ptr{ImVector_ImVec2},), self)
end

function ImVector_float_begin(self)
    ccall((:ImVector_float_begin, libcimgui), Ptr{Cfloat}, (Ptr{ImVector_float},), self)
end

function ImVector_ImWchar_begin(self)
    ccall((:ImVector_ImWchar_begin, libcimgui), Ptr{ImWchar}, (Ptr{ImVector_ImWchar},), self)
end

function ImVector_ImFontConfig_begin(self)
    ccall((:ImVector_ImFontConfig_begin, libcimgui), Ptr{ImFontConfig}, (Ptr{ImVector_ImFontConfig},), self)
end

function ImVector_ImFontGlyph_begin(self)
    ccall((:ImVector_ImFontGlyph_begin, libcimgui), Ptr{ImFontGlyph}, (Ptr{ImVector_ImFontGlyph},), self)
end

function ImVector_TextRange_begin(self)
    ccall((:ImVector_TextRange_begin, libcimgui), Ptr{TextRange}, (Ptr{ImVector_TextRange},), self)
end

function ImVector_CustomRect_begin(self)
    ccall((:ImVector_CustomRect_begin, libcimgui), Ptr{CustomRect}, (Ptr{ImVector_CustomRect},), self)
end

function ImVector_ImDrawChannel_begin(self)
    ccall((:ImVector_ImDrawChannel_begin, libcimgui), Ptr{ImDrawChannel}, (Ptr{ImVector_ImDrawChannel},), self)
end

function ImVector_char_begin(self)
    ccall((:ImVector_char_begin, libcimgui), Cstring, (Ptr{ImVector_char},), self)
end

function ImVector_ImTextureID_begin(self)
    ccall((:ImVector_ImTextureID_begin, libcimgui), Ptr{ImTextureID}, (Ptr{ImVector_ImTextureID},), self)
end

function ImVector_ImDrawVert_begin(self)
    ccall((:ImVector_ImDrawVert_begin, libcimgui), Ptr{ImDrawVert}, (Ptr{ImVector_ImDrawVert},), self)
end

function ImVector_int_begin(self)
    ccall((:ImVector_int_begin, libcimgui), Ptr{Cint}, (Ptr{ImVector_int},), self)
end

function ImVector_Pair_begin(self)
    ccall((:ImVector_Pair_begin, libcimgui), Ptr{Pair}, (Ptr{ImVector_Pair},), self)
end

function ImVector_ImFontPtr_begin(self)
    ccall((:ImVector_ImFontPtr_begin, libcimgui), Ptr{Ptr{ImFont}}, (Ptr{ImVector_ImFontPtr},), self)
end

function ImVector_ImVec4_begin(self)
    ccall((:ImVector_ImVec4_begin, libcimgui), Ptr{ImVec4}, (Ptr{ImVector_ImVec4},), self)
end

function ImVector_ImDrawCmd_begin(self)
    ccall((:ImVector_ImDrawCmd_begin, libcimgui), Ptr{ImDrawCmd}, (Ptr{ImVector_ImDrawCmd},), self)
end

function ImVector_ImDrawIdx_begin(self)
    ccall((:ImVector_ImDrawIdx_begin, libcimgui), Ptr{ImDrawIdx}, (Ptr{ImVector_ImDrawIdx},), self)
end

function ImVector_ImVec2_begin(self)
    ccall((:ImVector_ImVec2_begin, libcimgui), Ptr{ImVec2}, (Ptr{ImVector_ImVec2},), self)
end

function ImVector_float_begin_const(self)
    ccall((:ImVector_float_begin_const, libcimgui), Ptr{Cfloat}, (Ptr{ImVector_float},), self)
end

function ImVector_ImWchar_begin_const(self)
    ccall((:ImVector_ImWchar_begin_const, libcimgui), Ptr{ImWchar}, (Ptr{ImVector_ImWchar},), self)
end

function ImVector_ImFontConfig_begin_const(self)
    ccall((:ImVector_ImFontConfig_begin_const, libcimgui), Ptr{ImFontConfig}, (Ptr{ImVector_ImFontConfig},), self)
end

function ImVector_ImFontGlyph_begin_const(self)
    ccall((:ImVector_ImFontGlyph_begin_const, libcimgui), Ptr{ImFontGlyph}, (Ptr{ImVector_ImFontGlyph},), self)
end

function ImVector_TextRange_begin_const(self)
    ccall((:ImVector_TextRange_begin_const, libcimgui), Ptr{TextRange}, (Ptr{ImVector_TextRange},), self)
end

function ImVector_CustomRect_begin_const(self)
    ccall((:ImVector_CustomRect_begin_const, libcimgui), Ptr{CustomRect}, (Ptr{ImVector_CustomRect},), self)
end

function ImVector_ImDrawChannel_begin_const(self)
    ccall((:ImVector_ImDrawChannel_begin_const, libcimgui), Ptr{ImDrawChannel}, (Ptr{ImVector_ImDrawChannel},), self)
end

function ImVector_char_begin_const(self)
    ccall((:ImVector_char_begin_const, libcimgui), Cstring, (Ptr{ImVector_char},), self)
end

function ImVector_ImTextureID_begin_const(self)
    ccall((:ImVector_ImTextureID_begin_const, libcimgui), Ptr{ImTextureID}, (Ptr{ImVector_ImTextureID},), self)
end

function ImVector_ImDrawVert_begin_const(self)
    ccall((:ImVector_ImDrawVert_begin_const, libcimgui), Ptr{ImDrawVert}, (Ptr{ImVector_ImDrawVert},), self)
end

function ImVector_int_begin_const(self)
    ccall((:ImVector_int_begin_const, libcimgui), Ptr{Cint}, (Ptr{ImVector_int},), self)
end

function ImVector_Pair_begin_const(self)
    ccall((:ImVector_Pair_begin_const, libcimgui), Ptr{Pair}, (Ptr{ImVector_Pair},), self)
end

function ImVector_ImFontPtr_begin_const(self)
    ccall((:ImVector_ImFontPtr_begin_const, libcimgui), Ptr{Ptr{ImFont}}, (Ptr{ImVector_ImFontPtr},), self)
end

function ImVector_ImVec4_begin_const(self)
    ccall((:ImVector_ImVec4_begin_const, libcimgui), Ptr{ImVec4}, (Ptr{ImVector_ImVec4},), self)
end

function ImVector_ImDrawCmd_begin_const(self)
    ccall((:ImVector_ImDrawCmd_begin_const, libcimgui), Ptr{ImDrawCmd}, (Ptr{ImVector_ImDrawCmd},), self)
end

function ImVector_ImDrawIdx_begin_const(self)
    ccall((:ImVector_ImDrawIdx_begin_const, libcimgui), Ptr{ImDrawIdx}, (Ptr{ImVector_ImDrawIdx},), self)
end

function ImVector_ImVec2_begin_const(self)
    ccall((:ImVector_ImVec2_begin_const, libcimgui), Ptr{ImVec2}, (Ptr{ImVector_ImVec2},), self)
end

function ImVector_float_end(self)
    ccall((:ImVector_float_end, libcimgui), Ptr{Cfloat}, (Ptr{ImVector_float},), self)
end

function ImVector_ImWchar_end(self)
    ccall((:ImVector_ImWchar_end, libcimgui), Ptr{ImWchar}, (Ptr{ImVector_ImWchar},), self)
end

function ImVector_ImFontConfig_end(self)
    ccall((:ImVector_ImFontConfig_end, libcimgui), Ptr{ImFontConfig}, (Ptr{ImVector_ImFontConfig},), self)
end

function ImVector_ImFontGlyph_end(self)
    ccall((:ImVector_ImFontGlyph_end, libcimgui), Ptr{ImFontGlyph}, (Ptr{ImVector_ImFontGlyph},), self)
end

function ImVector_TextRange_end(self)
    ccall((:ImVector_TextRange_end, libcimgui), Ptr{TextRange}, (Ptr{ImVector_TextRange},), self)
end

function ImVector_CustomRect_end(self)
    ccall((:ImVector_CustomRect_end, libcimgui), Ptr{CustomRect}, (Ptr{ImVector_CustomRect},), self)
end

function ImVector_ImDrawChannel_end(self)
    ccall((:ImVector_ImDrawChannel_end, libcimgui), Ptr{ImDrawChannel}, (Ptr{ImVector_ImDrawChannel},), self)
end

function ImVector_char_end(self)
    ccall((:ImVector_char_end, libcimgui), Cstring, (Ptr{ImVector_char},), self)
end

function ImVector_ImTextureID_end(self)
    ccall((:ImVector_ImTextureID_end, libcimgui), Ptr{ImTextureID}, (Ptr{ImVector_ImTextureID},), self)
end

function ImVector_ImDrawVert_end(self)
    ccall((:ImVector_ImDrawVert_end, libcimgui), Ptr{ImDrawVert}, (Ptr{ImVector_ImDrawVert},), self)
end

function ImVector_int_end(self)
    ccall((:ImVector_int_end, libcimgui), Ptr{Cint}, (Ptr{ImVector_int},), self)
end

function ImVector_Pair_end(self)
    ccall((:ImVector_Pair_end, libcimgui), Ptr{Pair}, (Ptr{ImVector_Pair},), self)
end

function ImVector_ImFontPtr_end(self)
    ccall((:ImVector_ImFontPtr_end, libcimgui), Ptr{Ptr{ImFont}}, (Ptr{ImVector_ImFontPtr},), self)
end

function ImVector_ImVec4_end(self)
    ccall((:ImVector_ImVec4_end, libcimgui), Ptr{ImVec4}, (Ptr{ImVector_ImVec4},), self)
end

function ImVector_ImDrawCmd_end(self)
    ccall((:ImVector_ImDrawCmd_end, libcimgui), Ptr{ImDrawCmd}, (Ptr{ImVector_ImDrawCmd},), self)
end

function ImVector_ImDrawIdx_end(self)
    ccall((:ImVector_ImDrawIdx_end, libcimgui), Ptr{ImDrawIdx}, (Ptr{ImVector_ImDrawIdx},), self)
end

function ImVector_ImVec2_end(self)
    ccall((:ImVector_ImVec2_end, libcimgui), Ptr{ImVec2}, (Ptr{ImVector_ImVec2},), self)
end

function ImVector_float_end_const(self)
    ccall((:ImVector_float_end_const, libcimgui), Ptr{Cfloat}, (Ptr{ImVector_float},), self)
end

function ImVector_ImWchar_end_const(self)
    ccall((:ImVector_ImWchar_end_const, libcimgui), Ptr{ImWchar}, (Ptr{ImVector_ImWchar},), self)
end

function ImVector_ImFontConfig_end_const(self)
    ccall((:ImVector_ImFontConfig_end_const, libcimgui), Ptr{ImFontConfig}, (Ptr{ImVector_ImFontConfig},), self)
end

function ImVector_ImFontGlyph_end_const(self)
    ccall((:ImVector_ImFontGlyph_end_const, libcimgui), Ptr{ImFontGlyph}, (Ptr{ImVector_ImFontGlyph},), self)
end

function ImVector_TextRange_end_const(self)
    ccall((:ImVector_TextRange_end_const, libcimgui), Ptr{TextRange}, (Ptr{ImVector_TextRange},), self)
end

function ImVector_CustomRect_end_const(self)
    ccall((:ImVector_CustomRect_end_const, libcimgui), Ptr{CustomRect}, (Ptr{ImVector_CustomRect},), self)
end

function ImVector_ImDrawChannel_end_const(self)
    ccall((:ImVector_ImDrawChannel_end_const, libcimgui), Ptr{ImDrawChannel}, (Ptr{ImVector_ImDrawChannel},), self)
end

function ImVector_char_end_const(self)
    ccall((:ImVector_char_end_const, libcimgui), Cstring, (Ptr{ImVector_char},), self)
end

function ImVector_ImTextureID_end_const(self)
    ccall((:ImVector_ImTextureID_end_const, libcimgui), Ptr{ImTextureID}, (Ptr{ImVector_ImTextureID},), self)
end

function ImVector_ImDrawVert_end_const(self)
    ccall((:ImVector_ImDrawVert_end_const, libcimgui), Ptr{ImDrawVert}, (Ptr{ImVector_ImDrawVert},), self)
end

function ImVector_int_end_const(self)
    ccall((:ImVector_int_end_const, libcimgui), Ptr{Cint}, (Ptr{ImVector_int},), self)
end

function ImVector_Pair_end_const(self)
    ccall((:ImVector_Pair_end_const, libcimgui), Ptr{Pair}, (Ptr{ImVector_Pair},), self)
end

function ImVector_ImFontPtr_end_const(self)
    ccall((:ImVector_ImFontPtr_end_const, libcimgui), Ptr{Ptr{ImFont}}, (Ptr{ImVector_ImFontPtr},), self)
end

function ImVector_ImVec4_end_const(self)
    ccall((:ImVector_ImVec4_end_const, libcimgui), Ptr{ImVec4}, (Ptr{ImVector_ImVec4},), self)
end

function ImVector_ImDrawCmd_end_const(self)
    ccall((:ImVector_ImDrawCmd_end_const, libcimgui), Ptr{ImDrawCmd}, (Ptr{ImVector_ImDrawCmd},), self)
end

function ImVector_ImDrawIdx_end_const(self)
    ccall((:ImVector_ImDrawIdx_end_const, libcimgui), Ptr{ImDrawIdx}, (Ptr{ImVector_ImDrawIdx},), self)
end

function ImVector_ImVec2_end_const(self)
    ccall((:ImVector_ImVec2_end_const, libcimgui), Ptr{ImVec2}, (Ptr{ImVector_ImVec2},), self)
end

function ImVector_float_front(self)
    ccall((:ImVector_float_front, libcimgui), Ptr{Cfloat}, (Ptr{ImVector_float},), self)
end

function ImVector_ImWchar_front(self)
    ccall((:ImVector_ImWchar_front, libcimgui), Ptr{ImWchar}, (Ptr{ImVector_ImWchar},), self)
end

function ImVector_ImFontConfig_front(self)
    ccall((:ImVector_ImFontConfig_front, libcimgui), Ptr{ImFontConfig}, (Ptr{ImVector_ImFontConfig},), self)
end

function ImVector_ImFontGlyph_front(self)
    ccall((:ImVector_ImFontGlyph_front, libcimgui), Ptr{ImFontGlyph}, (Ptr{ImVector_ImFontGlyph},), self)
end

function ImVector_TextRange_front(self)
    ccall((:ImVector_TextRange_front, libcimgui), Ptr{TextRange}, (Ptr{ImVector_TextRange},), self)
end

function ImVector_CustomRect_front(self)
    ccall((:ImVector_CustomRect_front, libcimgui), Ptr{CustomRect}, (Ptr{ImVector_CustomRect},), self)
end

function ImVector_ImDrawChannel_front(self)
    ccall((:ImVector_ImDrawChannel_front, libcimgui), Ptr{ImDrawChannel}, (Ptr{ImVector_ImDrawChannel},), self)
end

function ImVector_char_front(self)
    ccall((:ImVector_char_front, libcimgui), Cstring, (Ptr{ImVector_char},), self)
end

function ImVector_ImTextureID_front(self)
    ccall((:ImVector_ImTextureID_front, libcimgui), Ptr{ImTextureID}, (Ptr{ImVector_ImTextureID},), self)
end

function ImVector_ImDrawVert_front(self)
    ccall((:ImVector_ImDrawVert_front, libcimgui), Ptr{ImDrawVert}, (Ptr{ImVector_ImDrawVert},), self)
end

function ImVector_int_front(self)
    ccall((:ImVector_int_front, libcimgui), Ptr{Cint}, (Ptr{ImVector_int},), self)
end

function ImVector_Pair_front(self)
    ccall((:ImVector_Pair_front, libcimgui), Ptr{Pair}, (Ptr{ImVector_Pair},), self)
end

function ImVector_ImFontPtr_front(self)
    ccall((:ImVector_ImFontPtr_front, libcimgui), Ptr{Ptr{ImFont}}, (Ptr{ImVector_ImFontPtr},), self)
end

function ImVector_ImVec4_front(self)
    ccall((:ImVector_ImVec4_front, libcimgui), Ptr{ImVec4}, (Ptr{ImVector_ImVec4},), self)
end

function ImVector_ImDrawCmd_front(self)
    ccall((:ImVector_ImDrawCmd_front, libcimgui), Ptr{ImDrawCmd}, (Ptr{ImVector_ImDrawCmd},), self)
end

function ImVector_ImDrawIdx_front(self)
    ccall((:ImVector_ImDrawIdx_front, libcimgui), Ptr{ImDrawIdx}, (Ptr{ImVector_ImDrawIdx},), self)
end

function ImVector_ImVec2_front(self)
    ccall((:ImVector_ImVec2_front, libcimgui), Ptr{ImVec2}, (Ptr{ImVector_ImVec2},), self)
end

function ImVector_float_front_const(self)
    ccall((:ImVector_float_front_const, libcimgui), Ptr{Cfloat}, (Ptr{ImVector_float},), self)
end

function ImVector_ImWchar_front_const(self)
    ccall((:ImVector_ImWchar_front_const, libcimgui), Ptr{ImWchar}, (Ptr{ImVector_ImWchar},), self)
end

function ImVector_ImFontConfig_front_const(self)
    ccall((:ImVector_ImFontConfig_front_const, libcimgui), Ptr{ImFontConfig}, (Ptr{ImVector_ImFontConfig},), self)
end

function ImVector_ImFontGlyph_front_const(self)
    ccall((:ImVector_ImFontGlyph_front_const, libcimgui), Ptr{ImFontGlyph}, (Ptr{ImVector_ImFontGlyph},), self)
end

function ImVector_TextRange_front_const(self)
    ccall((:ImVector_TextRange_front_const, libcimgui), Ptr{TextRange}, (Ptr{ImVector_TextRange},), self)
end

function ImVector_CustomRect_front_const(self)
    ccall((:ImVector_CustomRect_front_const, libcimgui), Ptr{CustomRect}, (Ptr{ImVector_CustomRect},), self)
end

function ImVector_ImDrawChannel_front_const(self)
    ccall((:ImVector_ImDrawChannel_front_const, libcimgui), Ptr{ImDrawChannel}, (Ptr{ImVector_ImDrawChannel},), self)
end

function ImVector_char_front_const(self)
    ccall((:ImVector_char_front_const, libcimgui), Cstring, (Ptr{ImVector_char},), self)
end

function ImVector_ImTextureID_front_const(self)
    ccall((:ImVector_ImTextureID_front_const, libcimgui), Ptr{ImTextureID}, (Ptr{ImVector_ImTextureID},), self)
end

function ImVector_ImDrawVert_front_const(self)
    ccall((:ImVector_ImDrawVert_front_const, libcimgui), Ptr{ImDrawVert}, (Ptr{ImVector_ImDrawVert},), self)
end

function ImVector_int_front_const(self)
    ccall((:ImVector_int_front_const, libcimgui), Ptr{Cint}, (Ptr{ImVector_int},), self)
end

function ImVector_Pair_front_const(self)
    ccall((:ImVector_Pair_front_const, libcimgui), Ptr{Pair}, (Ptr{ImVector_Pair},), self)
end

function ImVector_ImFontPtr_front_const(self)
    ccall((:ImVector_ImFontPtr_front_const, libcimgui), Ptr{Ptr{ImFont}}, (Ptr{ImVector_ImFontPtr},), self)
end

function ImVector_ImVec4_front_const(self)
    ccall((:ImVector_ImVec4_front_const, libcimgui), Ptr{ImVec4}, (Ptr{ImVector_ImVec4},), self)
end

function ImVector_ImDrawCmd_front_const(self)
    ccall((:ImVector_ImDrawCmd_front_const, libcimgui), Ptr{ImDrawCmd}, (Ptr{ImVector_ImDrawCmd},), self)
end

function ImVector_ImDrawIdx_front_const(self)
    ccall((:ImVector_ImDrawIdx_front_const, libcimgui), Ptr{ImDrawIdx}, (Ptr{ImVector_ImDrawIdx},), self)
end

function ImVector_ImVec2_front_const(self)
    ccall((:ImVector_ImVec2_front_const, libcimgui), Ptr{ImVec2}, (Ptr{ImVector_ImVec2},), self)
end

function ImVector_float_back(self)
    ccall((:ImVector_float_back, libcimgui), Ptr{Cfloat}, (Ptr{ImVector_float},), self)
end

function ImVector_ImWchar_back(self)
    ccall((:ImVector_ImWchar_back, libcimgui), Ptr{ImWchar}, (Ptr{ImVector_ImWchar},), self)
end

function ImVector_ImFontConfig_back(self)
    ccall((:ImVector_ImFontConfig_back, libcimgui), Ptr{ImFontConfig}, (Ptr{ImVector_ImFontConfig},), self)
end

function ImVector_ImFontGlyph_back(self)
    ccall((:ImVector_ImFontGlyph_back, libcimgui), Ptr{ImFontGlyph}, (Ptr{ImVector_ImFontGlyph},), self)
end

function ImVector_TextRange_back(self)
    ccall((:ImVector_TextRange_back, libcimgui), Ptr{TextRange}, (Ptr{ImVector_TextRange},), self)
end

function ImVector_CustomRect_back(self)
    ccall((:ImVector_CustomRect_back, libcimgui), Ptr{CustomRect}, (Ptr{ImVector_CustomRect},), self)
end

function ImVector_ImDrawChannel_back(self)
    ccall((:ImVector_ImDrawChannel_back, libcimgui), Ptr{ImDrawChannel}, (Ptr{ImVector_ImDrawChannel},), self)
end

function ImVector_char_back(self)
    ccall((:ImVector_char_back, libcimgui), Cstring, (Ptr{ImVector_char},), self)
end

function ImVector_ImTextureID_back(self)
    ccall((:ImVector_ImTextureID_back, libcimgui), Ptr{ImTextureID}, (Ptr{ImVector_ImTextureID},), self)
end

function ImVector_ImDrawVert_back(self)
    ccall((:ImVector_ImDrawVert_back, libcimgui), Ptr{ImDrawVert}, (Ptr{ImVector_ImDrawVert},), self)
end

function ImVector_int_back(self)
    ccall((:ImVector_int_back, libcimgui), Ptr{Cint}, (Ptr{ImVector_int},), self)
end

function ImVector_Pair_back(self)
    ccall((:ImVector_Pair_back, libcimgui), Ptr{Pair}, (Ptr{ImVector_Pair},), self)
end

function ImVector_ImFontPtr_back(self)
    ccall((:ImVector_ImFontPtr_back, libcimgui), Ptr{Ptr{ImFont}}, (Ptr{ImVector_ImFontPtr},), self)
end

function ImVector_ImVec4_back(self)
    ccall((:ImVector_ImVec4_back, libcimgui), Ptr{ImVec4}, (Ptr{ImVector_ImVec4},), self)
end

function ImVector_ImDrawCmd_back(self)
    ccall((:ImVector_ImDrawCmd_back, libcimgui), Ptr{ImDrawCmd}, (Ptr{ImVector_ImDrawCmd},), self)
end

function ImVector_ImDrawIdx_back(self)
    ccall((:ImVector_ImDrawIdx_back, libcimgui), Ptr{ImDrawIdx}, (Ptr{ImVector_ImDrawIdx},), self)
end

function ImVector_ImVec2_back(self)
    ccall((:ImVector_ImVec2_back, libcimgui), Ptr{ImVec2}, (Ptr{ImVector_ImVec2},), self)
end

function ImVector_float_back_const(self)
    ccall((:ImVector_float_back_const, libcimgui), Ptr{Cfloat}, (Ptr{ImVector_float},), self)
end

function ImVector_ImWchar_back_const(self)
    ccall((:ImVector_ImWchar_back_const, libcimgui), Ptr{ImWchar}, (Ptr{ImVector_ImWchar},), self)
end

function ImVector_ImFontConfig_back_const(self)
    ccall((:ImVector_ImFontConfig_back_const, libcimgui), Ptr{ImFontConfig}, (Ptr{ImVector_ImFontConfig},), self)
end

function ImVector_ImFontGlyph_back_const(self)
    ccall((:ImVector_ImFontGlyph_back_const, libcimgui), Ptr{ImFontGlyph}, (Ptr{ImVector_ImFontGlyph},), self)
end

function ImVector_TextRange_back_const(self)
    ccall((:ImVector_TextRange_back_const, libcimgui), Ptr{TextRange}, (Ptr{ImVector_TextRange},), self)
end

function ImVector_CustomRect_back_const(self)
    ccall((:ImVector_CustomRect_back_const, libcimgui), Ptr{CustomRect}, (Ptr{ImVector_CustomRect},), self)
end

function ImVector_ImDrawChannel_back_const(self)
    ccall((:ImVector_ImDrawChannel_back_const, libcimgui), Ptr{ImDrawChannel}, (Ptr{ImVector_ImDrawChannel},), self)
end

function ImVector_char_back_const(self)
    ccall((:ImVector_char_back_const, libcimgui), Cstring, (Ptr{ImVector_char},), self)
end

function ImVector_ImTextureID_back_const(self)
    ccall((:ImVector_ImTextureID_back_const, libcimgui), Ptr{ImTextureID}, (Ptr{ImVector_ImTextureID},), self)
end

function ImVector_ImDrawVert_back_const(self)
    ccall((:ImVector_ImDrawVert_back_const, libcimgui), Ptr{ImDrawVert}, (Ptr{ImVector_ImDrawVert},), self)
end

function ImVector_int_back_const(self)
    ccall((:ImVector_int_back_const, libcimgui), Ptr{Cint}, (Ptr{ImVector_int},), self)
end

function ImVector_Pair_back_const(self)
    ccall((:ImVector_Pair_back_const, libcimgui), Ptr{Pair}, (Ptr{ImVector_Pair},), self)
end

function ImVector_ImFontPtr_back_const(self)
    ccall((:ImVector_ImFontPtr_back_const, libcimgui), Ptr{Ptr{ImFont}}, (Ptr{ImVector_ImFontPtr},), self)
end

function ImVector_ImVec4_back_const(self)
    ccall((:ImVector_ImVec4_back_const, libcimgui), Ptr{ImVec4}, (Ptr{ImVector_ImVec4},), self)
end

function ImVector_ImDrawCmd_back_const(self)
    ccall((:ImVector_ImDrawCmd_back_const, libcimgui), Ptr{ImDrawCmd}, (Ptr{ImVector_ImDrawCmd},), self)
end

function ImVector_ImDrawIdx_back_const(self)
    ccall((:ImVector_ImDrawIdx_back_const, libcimgui), Ptr{ImDrawIdx}, (Ptr{ImVector_ImDrawIdx},), self)
end

function ImVector_ImVec2_back_const(self)
    ccall((:ImVector_ImVec2_back_const, libcimgui), Ptr{ImVec2}, (Ptr{ImVector_ImVec2},), self)
end

function ImVector_float_swap(self, rhs)
    ccall((:ImVector_float_swap, libcimgui), Cvoid, (Ptr{ImVector_float}, ImVector_float), self, rhs)
end

function ImVector_ImWchar_swap(self, rhs)
    ccall((:ImVector_ImWchar_swap, libcimgui), Cvoid, (Ptr{ImVector_ImWchar}, ImVector_ImWchar), self, rhs)
end

function ImVector_ImFontConfig_swap(self, rhs)
    ccall((:ImVector_ImFontConfig_swap, libcimgui), Cvoid, (Ptr{ImVector_ImFontConfig}, ImVector_ImFontConfig), self, rhs)
end

function ImVector_ImFontGlyph_swap(self, rhs)
    ccall((:ImVector_ImFontGlyph_swap, libcimgui), Cvoid, (Ptr{ImVector_ImFontGlyph}, ImVector_ImFontGlyph), self, rhs)
end

function ImVector_TextRange_swap(self, rhs)
    ccall((:ImVector_TextRange_swap, libcimgui), Cvoid, (Ptr{ImVector_TextRange}, ImVector_TextRange), self, rhs)
end

function ImVector_CustomRect_swap(self, rhs)
    ccall((:ImVector_CustomRect_swap, libcimgui), Cvoid, (Ptr{ImVector_CustomRect}, ImVector_CustomRect), self, rhs)
end

function ImVector_ImDrawChannel_swap(self, rhs)
    ccall((:ImVector_ImDrawChannel_swap, libcimgui), Cvoid, (Ptr{ImVector_ImDrawChannel}, ImVector_ImDrawChannel), self, rhs)
end

function ImVector_char_swap(self, rhs)
    ccall((:ImVector_char_swap, libcimgui), Cvoid, (Ptr{ImVector_char}, ImVector_char), self, rhs)
end

function ImVector_ImTextureID_swap(self, rhs)
    ccall((:ImVector_ImTextureID_swap, libcimgui), Cvoid, (Ptr{ImVector_ImTextureID}, ImVector_ImTextureID), self, rhs)
end

function ImVector_ImDrawVert_swap(self, rhs)
    ccall((:ImVector_ImDrawVert_swap, libcimgui), Cvoid, (Ptr{ImVector_ImDrawVert}, ImVector_ImDrawVert), self, rhs)
end

function ImVector_int_swap(self, rhs)
    ccall((:ImVector_int_swap, libcimgui), Cvoid, (Ptr{ImVector_int}, ImVector_int), self, rhs)
end

function ImVector_Pair_swap(self, rhs)
    ccall((:ImVector_Pair_swap, libcimgui), Cvoid, (Ptr{ImVector_Pair}, ImVector_Pair), self, rhs)
end

function ImVector_ImFontPtr_swap(self, rhs)
    ccall((:ImVector_ImFontPtr_swap, libcimgui), Cvoid, (Ptr{ImVector_ImFontPtr}, ImVector_ImFontPtr), self, rhs)
end

function ImVector_ImVec4_swap(self, rhs)
    ccall((:ImVector_ImVec4_swap, libcimgui), Cvoid, (Ptr{ImVector_ImVec4}, ImVector_ImVec4), self, rhs)
end

function ImVector_ImDrawCmd_swap(self, rhs)
    ccall((:ImVector_ImDrawCmd_swap, libcimgui), Cvoid, (Ptr{ImVector_ImDrawCmd}, ImVector_ImDrawCmd), self, rhs)
end

function ImVector_ImDrawIdx_swap(self, rhs)
    ccall((:ImVector_ImDrawIdx_swap, libcimgui), Cvoid, (Ptr{ImVector_ImDrawIdx}, ImVector_ImDrawIdx), self, rhs)
end

function ImVector_ImVec2_swap(self, rhs)
    ccall((:ImVector_ImVec2_swap, libcimgui), Cvoid, (Ptr{ImVector_ImVec2}, ImVector_ImVec2), self, rhs)
end

function ImVector_float__grow_capacity(self, sz)
    ccall((:ImVector_float__grow_capacity, libcimgui), Cint, (Ptr{ImVector_float}, Cint), self, sz)
end

function ImVector_ImWchar__grow_capacity(self, sz)
    ccall((:ImVector_ImWchar__grow_capacity, libcimgui), Cint, (Ptr{ImVector_ImWchar}, Cint), self, sz)
end

function ImVector_ImFontConfig__grow_capacity(self, sz)
    ccall((:ImVector_ImFontConfig__grow_capacity, libcimgui), Cint, (Ptr{ImVector_ImFontConfig}, Cint), self, sz)
end

function ImVector_ImFontGlyph__grow_capacity(self, sz)
    ccall((:ImVector_ImFontGlyph__grow_capacity, libcimgui), Cint, (Ptr{ImVector_ImFontGlyph}, Cint), self, sz)
end

function ImVector_TextRange__grow_capacity(self, sz)
    ccall((:ImVector_TextRange__grow_capacity, libcimgui), Cint, (Ptr{ImVector_TextRange}, Cint), self, sz)
end

function ImVector_CustomRect__grow_capacity(self, sz)
    ccall((:ImVector_CustomRect__grow_capacity, libcimgui), Cint, (Ptr{ImVector_CustomRect}, Cint), self, sz)
end

function ImVector_ImDrawChannel__grow_capacity(self, sz)
    ccall((:ImVector_ImDrawChannel__grow_capacity, libcimgui), Cint, (Ptr{ImVector_ImDrawChannel}, Cint), self, sz)
end

function ImVector_char__grow_capacity(self, sz)
    ccall((:ImVector_char__grow_capacity, libcimgui), Cint, (Ptr{ImVector_char}, Cint), self, sz)
end

function ImVector_ImTextureID__grow_capacity(self, sz)
    ccall((:ImVector_ImTextureID__grow_capacity, libcimgui), Cint, (Ptr{ImVector_ImTextureID}, Cint), self, sz)
end

function ImVector_ImDrawVert__grow_capacity(self, sz)
    ccall((:ImVector_ImDrawVert__grow_capacity, libcimgui), Cint, (Ptr{ImVector_ImDrawVert}, Cint), self, sz)
end

function ImVector_int__grow_capacity(self, sz)
    ccall((:ImVector_int__grow_capacity, libcimgui), Cint, (Ptr{ImVector_int}, Cint), self, sz)
end

function ImVector_Pair__grow_capacity(self, sz)
    ccall((:ImVector_Pair__grow_capacity, libcimgui), Cint, (Ptr{ImVector_Pair}, Cint), self, sz)
end

function ImVector_ImFontPtr__grow_capacity(self, sz)
    ccall((:ImVector_ImFontPtr__grow_capacity, libcimgui), Cint, (Ptr{ImVector_ImFontPtr}, Cint), self, sz)
end

function ImVector_ImVec4__grow_capacity(self, sz)
    ccall((:ImVector_ImVec4__grow_capacity, libcimgui), Cint, (Ptr{ImVector_ImVec4}, Cint), self, sz)
end

function ImVector_ImDrawCmd__grow_capacity(self, sz)
    ccall((:ImVector_ImDrawCmd__grow_capacity, libcimgui), Cint, (Ptr{ImVector_ImDrawCmd}, Cint), self, sz)
end

function ImVector_ImDrawIdx__grow_capacity(self, sz)
    ccall((:ImVector_ImDrawIdx__grow_capacity, libcimgui), Cint, (Ptr{ImVector_ImDrawIdx}, Cint), self, sz)
end

function ImVector_ImVec2__grow_capacity(self, sz)
    ccall((:ImVector_ImVec2__grow_capacity, libcimgui), Cint, (Ptr{ImVector_ImVec2}, Cint), self, sz)
end

function ImVector_float_resize(self, new_size)
    ccall((:ImVector_float_resize, libcimgui), Cvoid, (Ptr{ImVector_float}, Cint), self, new_size)
end

function ImVector_ImWchar_resize(self, new_size)
    ccall((:ImVector_ImWchar_resize, libcimgui), Cvoid, (Ptr{ImVector_ImWchar}, Cint), self, new_size)
end

function ImVector_ImFontConfig_resize(self, new_size)
    ccall((:ImVector_ImFontConfig_resize, libcimgui), Cvoid, (Ptr{ImVector_ImFontConfig}, Cint), self, new_size)
end

function ImVector_ImFontGlyph_resize(self, new_size)
    ccall((:ImVector_ImFontGlyph_resize, libcimgui), Cvoid, (Ptr{ImVector_ImFontGlyph}, Cint), self, new_size)
end

function ImVector_TextRange_resize(self, new_size)
    ccall((:ImVector_TextRange_resize, libcimgui), Cvoid, (Ptr{ImVector_TextRange}, Cint), self, new_size)
end

function ImVector_CustomRect_resize(self, new_size)
    ccall((:ImVector_CustomRect_resize, libcimgui), Cvoid, (Ptr{ImVector_CustomRect}, Cint), self, new_size)
end

function ImVector_ImDrawChannel_resize(self, new_size)
    ccall((:ImVector_ImDrawChannel_resize, libcimgui), Cvoid, (Ptr{ImVector_ImDrawChannel}, Cint), self, new_size)
end

function ImVector_char_resize(self, new_size)
    ccall((:ImVector_char_resize, libcimgui), Cvoid, (Ptr{ImVector_char}, Cint), self, new_size)
end

function ImVector_ImTextureID_resize(self, new_size)
    ccall((:ImVector_ImTextureID_resize, libcimgui), Cvoid, (Ptr{ImVector_ImTextureID}, Cint), self, new_size)
end

function ImVector_ImDrawVert_resize(self, new_size)
    ccall((:ImVector_ImDrawVert_resize, libcimgui), Cvoid, (Ptr{ImVector_ImDrawVert}, Cint), self, new_size)
end

function ImVector_int_resize(self, new_size)
    ccall((:ImVector_int_resize, libcimgui), Cvoid, (Ptr{ImVector_int}, Cint), self, new_size)
end

function ImVector_Pair_resize(self, new_size)
    ccall((:ImVector_Pair_resize, libcimgui), Cvoid, (Ptr{ImVector_Pair}, Cint), self, new_size)
end

function ImVector_ImFontPtr_resize(self, new_size)
    ccall((:ImVector_ImFontPtr_resize, libcimgui), Cvoid, (Ptr{ImVector_ImFontPtr}, Cint), self, new_size)
end

function ImVector_ImVec4_resize(self, new_size)
    ccall((:ImVector_ImVec4_resize, libcimgui), Cvoid, (Ptr{ImVector_ImVec4}, Cint), self, new_size)
end

function ImVector_ImDrawCmd_resize(self, new_size)
    ccall((:ImVector_ImDrawCmd_resize, libcimgui), Cvoid, (Ptr{ImVector_ImDrawCmd}, Cint), self, new_size)
end

function ImVector_ImDrawIdx_resize(self, new_size)
    ccall((:ImVector_ImDrawIdx_resize, libcimgui), Cvoid, (Ptr{ImVector_ImDrawIdx}, Cint), self, new_size)
end

function ImVector_ImVec2_resize(self, new_size)
    ccall((:ImVector_ImVec2_resize, libcimgui), Cvoid, (Ptr{ImVector_ImVec2}, Cint), self, new_size)
end

function ImVector_float_resizeT(self, new_size, v)
    ccall((:ImVector_float_resizeT, libcimgui), Cvoid, (Ptr{ImVector_float}, Cint, Cfloat), self, new_size, v)
end

function ImVector_ImWchar_resizeT(self, new_size, v)
    ccall((:ImVector_ImWchar_resizeT, libcimgui), Cvoid, (Ptr{ImVector_ImWchar}, Cint, ImWchar), self, new_size, v)
end

function ImVector_ImFontConfig_resizeT(self, new_size, v)
    ccall((:ImVector_ImFontConfig_resizeT, libcimgui), Cvoid, (Ptr{ImVector_ImFontConfig}, Cint, ImFontConfig), self, new_size, v)
end

function ImVector_ImFontGlyph_resizeT(self, new_size, v)
    ccall((:ImVector_ImFontGlyph_resizeT, libcimgui), Cvoid, (Ptr{ImVector_ImFontGlyph}, Cint, ImFontGlyph), self, new_size, v)
end

function ImVector_TextRange_resizeT(self, new_size, v)
    ccall((:ImVector_TextRange_resizeT, libcimgui), Cvoid, (Ptr{ImVector_TextRange}, Cint, TextRange), self, new_size, v)
end

function ImVector_CustomRect_resizeT(self, new_size, v)
    ccall((:ImVector_CustomRect_resizeT, libcimgui), Cvoid, (Ptr{ImVector_CustomRect}, Cint, CustomRect), self, new_size, v)
end

function ImVector_ImDrawChannel_resizeT(self, new_size, v)
    ccall((:ImVector_ImDrawChannel_resizeT, libcimgui), Cvoid, (Ptr{ImVector_ImDrawChannel}, Cint, ImDrawChannel), self, new_size, v)
end

function ImVector_char_resizeT(self, new_size, v)
    ccall((:ImVector_char_resizeT, libcimgui), Cvoid, (Ptr{ImVector_char}, Cint, UInt8), self, new_size, v)
end

function ImVector_ImTextureID_resizeT(self, new_size, v)
    ccall((:ImVector_ImTextureID_resizeT, libcimgui), Cvoid, (Ptr{ImVector_ImTextureID}, Cint, ImTextureID), self, new_size, v)
end

function ImVector_ImDrawVert_resizeT(self, new_size, v)
    ccall((:ImVector_ImDrawVert_resizeT, libcimgui), Cvoid, (Ptr{ImVector_ImDrawVert}, Cint, ImDrawVert), self, new_size, v)
end

function ImVector_int_resizeT(self, new_size, v)
    ccall((:ImVector_int_resizeT, libcimgui), Cvoid, (Ptr{ImVector_int}, Cint, Cint), self, new_size, v)
end

function ImVector_Pair_resizeT(self, new_size, v)
    ccall((:ImVector_Pair_resizeT, libcimgui), Cvoid, (Ptr{ImVector_Pair}, Cint, Pair), self, new_size, v)
end

function ImVector_ImFontPtr_resizeT(self, new_size, v)
    ccall((:ImVector_ImFontPtr_resizeT, libcimgui), Cvoid, (Ptr{ImVector_ImFontPtr}, Cint, Ptr{ImFont}), self, new_size, v)
end

function ImVector_ImVec4_resizeT(self, new_size, v)
    ccall((:ImVector_ImVec4_resizeT, libcimgui), Cvoid, (Ptr{ImVector_ImVec4}, Cint, ImVec4), self, new_size, v)
end

function ImVector_ImDrawCmd_resizeT(self, new_size, v)
    ccall((:ImVector_ImDrawCmd_resizeT, libcimgui), Cvoid, (Ptr{ImVector_ImDrawCmd}, Cint, ImDrawCmd), self, new_size, v)
end

function ImVector_ImDrawIdx_resizeT(self, new_size, v)
    ccall((:ImVector_ImDrawIdx_resizeT, libcimgui), Cvoid, (Ptr{ImVector_ImDrawIdx}, Cint, ImDrawIdx), self, new_size, v)
end

function ImVector_ImVec2_resizeT(self, new_size, v)
    ccall((:ImVector_ImVec2_resizeT, libcimgui), Cvoid, (Ptr{ImVector_ImVec2}, Cint, ImVec2), self, new_size, v)
end

function ImVector_float_reserve(self, new_capacity)
    ccall((:ImVector_float_reserve, libcimgui), Cvoid, (Ptr{ImVector_float}, Cint), self, new_capacity)
end

function ImVector_ImWchar_reserve(self, new_capacity)
    ccall((:ImVector_ImWchar_reserve, libcimgui), Cvoid, (Ptr{ImVector_ImWchar}, Cint), self, new_capacity)
end

function ImVector_ImFontConfig_reserve(self, new_capacity)
    ccall((:ImVector_ImFontConfig_reserve, libcimgui), Cvoid, (Ptr{ImVector_ImFontConfig}, Cint), self, new_capacity)
end

function ImVector_ImFontGlyph_reserve(self, new_capacity)
    ccall((:ImVector_ImFontGlyph_reserve, libcimgui), Cvoid, (Ptr{ImVector_ImFontGlyph}, Cint), self, new_capacity)
end

function ImVector_TextRange_reserve(self, new_capacity)
    ccall((:ImVector_TextRange_reserve, libcimgui), Cvoid, (Ptr{ImVector_TextRange}, Cint), self, new_capacity)
end

function ImVector_CustomRect_reserve(self, new_capacity)
    ccall((:ImVector_CustomRect_reserve, libcimgui), Cvoid, (Ptr{ImVector_CustomRect}, Cint), self, new_capacity)
end

function ImVector_ImDrawChannel_reserve(self, new_capacity)
    ccall((:ImVector_ImDrawChannel_reserve, libcimgui), Cvoid, (Ptr{ImVector_ImDrawChannel}, Cint), self, new_capacity)
end

function ImVector_char_reserve(self, new_capacity)
    ccall((:ImVector_char_reserve, libcimgui), Cvoid, (Ptr{ImVector_char}, Cint), self, new_capacity)
end

function ImVector_ImTextureID_reserve(self, new_capacity)
    ccall((:ImVector_ImTextureID_reserve, libcimgui), Cvoid, (Ptr{ImVector_ImTextureID}, Cint), self, new_capacity)
end

function ImVector_ImDrawVert_reserve(self, new_capacity)
    ccall((:ImVector_ImDrawVert_reserve, libcimgui), Cvoid, (Ptr{ImVector_ImDrawVert}, Cint), self, new_capacity)
end

function ImVector_int_reserve(self, new_capacity)
    ccall((:ImVector_int_reserve, libcimgui), Cvoid, (Ptr{ImVector_int}, Cint), self, new_capacity)
end

function ImVector_Pair_reserve(self, new_capacity)
    ccall((:ImVector_Pair_reserve, libcimgui), Cvoid, (Ptr{ImVector_Pair}, Cint), self, new_capacity)
end

function ImVector_ImFontPtr_reserve(self, new_capacity)
    ccall((:ImVector_ImFontPtr_reserve, libcimgui), Cvoid, (Ptr{ImVector_ImFontPtr}, Cint), self, new_capacity)
end

function ImVector_ImVec4_reserve(self, new_capacity)
    ccall((:ImVector_ImVec4_reserve, libcimgui), Cvoid, (Ptr{ImVector_ImVec4}, Cint), self, new_capacity)
end

function ImVector_ImDrawCmd_reserve(self, new_capacity)
    ccall((:ImVector_ImDrawCmd_reserve, libcimgui), Cvoid, (Ptr{ImVector_ImDrawCmd}, Cint), self, new_capacity)
end

function ImVector_ImDrawIdx_reserve(self, new_capacity)
    ccall((:ImVector_ImDrawIdx_reserve, libcimgui), Cvoid, (Ptr{ImVector_ImDrawIdx}, Cint), self, new_capacity)
end

function ImVector_ImVec2_reserve(self, new_capacity)
    ccall((:ImVector_ImVec2_reserve, libcimgui), Cvoid, (Ptr{ImVector_ImVec2}, Cint), self, new_capacity)
end

function ImVector_float_push_back(self, v)
    ccall((:ImVector_float_push_back, libcimgui), Cvoid, (Ptr{ImVector_float}, Cfloat), self, v)
end

function ImVector_ImWchar_push_back(self, v)
    ccall((:ImVector_ImWchar_push_back, libcimgui), Cvoid, (Ptr{ImVector_ImWchar}, ImWchar), self, v)
end

function ImVector_ImFontConfig_push_back(self, v)
    ccall((:ImVector_ImFontConfig_push_back, libcimgui), Cvoid, (Ptr{ImVector_ImFontConfig}, ImFontConfig), self, v)
end

function ImVector_ImFontGlyph_push_back(self, v)
    ccall((:ImVector_ImFontGlyph_push_back, libcimgui), Cvoid, (Ptr{ImVector_ImFontGlyph}, ImFontGlyph), self, v)
end

function ImVector_TextRange_push_back(self, v)
    ccall((:ImVector_TextRange_push_back, libcimgui), Cvoid, (Ptr{ImVector_TextRange}, TextRange), self, v)
end

function ImVector_CustomRect_push_back(self, v)
    ccall((:ImVector_CustomRect_push_back, libcimgui), Cvoid, (Ptr{ImVector_CustomRect}, CustomRect), self, v)
end

function ImVector_ImDrawChannel_push_back(self, v)
    ccall((:ImVector_ImDrawChannel_push_back, libcimgui), Cvoid, (Ptr{ImVector_ImDrawChannel}, ImDrawChannel), self, v)
end

function ImVector_char_push_back(self, v)
    ccall((:ImVector_char_push_back, libcimgui), Cvoid, (Ptr{ImVector_char}, UInt8), self, v)
end

function ImVector_ImTextureID_push_back(self, v)
    ccall((:ImVector_ImTextureID_push_back, libcimgui), Cvoid, (Ptr{ImVector_ImTextureID}, ImTextureID), self, v)
end

function ImVector_ImDrawVert_push_back(self, v)
    ccall((:ImVector_ImDrawVert_push_back, libcimgui), Cvoid, (Ptr{ImVector_ImDrawVert}, ImDrawVert), self, v)
end

function ImVector_int_push_back(self, v)
    ccall((:ImVector_int_push_back, libcimgui), Cvoid, (Ptr{ImVector_int}, Cint), self, v)
end

function ImVector_Pair_push_back(self, v)
    ccall((:ImVector_Pair_push_back, libcimgui), Cvoid, (Ptr{ImVector_Pair}, Pair), self, v)
end

function ImVector_ImFontPtr_push_back(self, v)
    ccall((:ImVector_ImFontPtr_push_back, libcimgui), Cvoid, (Ptr{ImVector_ImFontPtr}, Ptr{ImFont}), self, v)
end

function ImVector_ImVec4_push_back(self, v)
    ccall((:ImVector_ImVec4_push_back, libcimgui), Cvoid, (Ptr{ImVector_ImVec4}, ImVec4), self, v)
end

function ImVector_ImDrawCmd_push_back(self, v)
    ccall((:ImVector_ImDrawCmd_push_back, libcimgui), Cvoid, (Ptr{ImVector_ImDrawCmd}, ImDrawCmd), self, v)
end

function ImVector_ImDrawIdx_push_back(self, v)
    ccall((:ImVector_ImDrawIdx_push_back, libcimgui), Cvoid, (Ptr{ImVector_ImDrawIdx}, ImDrawIdx), self, v)
end

function ImVector_ImVec2_push_back(self, v)
    ccall((:ImVector_ImVec2_push_back, libcimgui), Cvoid, (Ptr{ImVector_ImVec2}, ImVec2), self, v)
end

function ImVector_float_pop_back(self)
    ccall((:ImVector_float_pop_back, libcimgui), Cvoid, (Ptr{ImVector_float},), self)
end

function ImVector_ImWchar_pop_back(self)
    ccall((:ImVector_ImWchar_pop_back, libcimgui), Cvoid, (Ptr{ImVector_ImWchar},), self)
end

function ImVector_ImFontConfig_pop_back(self)
    ccall((:ImVector_ImFontConfig_pop_back, libcimgui), Cvoid, (Ptr{ImVector_ImFontConfig},), self)
end

function ImVector_ImFontGlyph_pop_back(self)
    ccall((:ImVector_ImFontGlyph_pop_back, libcimgui), Cvoid, (Ptr{ImVector_ImFontGlyph},), self)
end

function ImVector_TextRange_pop_back(self)
    ccall((:ImVector_TextRange_pop_back, libcimgui), Cvoid, (Ptr{ImVector_TextRange},), self)
end

function ImVector_CustomRect_pop_back(self)
    ccall((:ImVector_CustomRect_pop_back, libcimgui), Cvoid, (Ptr{ImVector_CustomRect},), self)
end

function ImVector_ImDrawChannel_pop_back(self)
    ccall((:ImVector_ImDrawChannel_pop_back, libcimgui), Cvoid, (Ptr{ImVector_ImDrawChannel},), self)
end

function ImVector_char_pop_back(self)
    ccall((:ImVector_char_pop_back, libcimgui), Cvoid, (Ptr{ImVector_char},), self)
end

function ImVector_ImTextureID_pop_back(self)
    ccall((:ImVector_ImTextureID_pop_back, libcimgui), Cvoid, (Ptr{ImVector_ImTextureID},), self)
end

function ImVector_ImDrawVert_pop_back(self)
    ccall((:ImVector_ImDrawVert_pop_back, libcimgui), Cvoid, (Ptr{ImVector_ImDrawVert},), self)
end

function ImVector_int_pop_back(self)
    ccall((:ImVector_int_pop_back, libcimgui), Cvoid, (Ptr{ImVector_int},), self)
end

function ImVector_Pair_pop_back(self)
    ccall((:ImVector_Pair_pop_back, libcimgui), Cvoid, (Ptr{ImVector_Pair},), self)
end

function ImVector_ImFontPtr_pop_back(self)
    ccall((:ImVector_ImFontPtr_pop_back, libcimgui), Cvoid, (Ptr{ImVector_ImFontPtr},), self)
end

function ImVector_ImVec4_pop_back(self)
    ccall((:ImVector_ImVec4_pop_back, libcimgui), Cvoid, (Ptr{ImVector_ImVec4},), self)
end

function ImVector_ImDrawCmd_pop_back(self)
    ccall((:ImVector_ImDrawCmd_pop_back, libcimgui), Cvoid, (Ptr{ImVector_ImDrawCmd},), self)
end

function ImVector_ImDrawIdx_pop_back(self)
    ccall((:ImVector_ImDrawIdx_pop_back, libcimgui), Cvoid, (Ptr{ImVector_ImDrawIdx},), self)
end

function ImVector_ImVec2_pop_back(self)
    ccall((:ImVector_ImVec2_pop_back, libcimgui), Cvoid, (Ptr{ImVector_ImVec2},), self)
end

function ImVector_float_push_front(self, v)
    ccall((:ImVector_float_push_front, libcimgui), Cvoid, (Ptr{ImVector_float}, Cfloat), self, v)
end

function ImVector_ImWchar_push_front(self, v)
    ccall((:ImVector_ImWchar_push_front, libcimgui), Cvoid, (Ptr{ImVector_ImWchar}, ImWchar), self, v)
end

function ImVector_ImFontConfig_push_front(self, v)
    ccall((:ImVector_ImFontConfig_push_front, libcimgui), Cvoid, (Ptr{ImVector_ImFontConfig}, ImFontConfig), self, v)
end

function ImVector_ImFontGlyph_push_front(self, v)
    ccall((:ImVector_ImFontGlyph_push_front, libcimgui), Cvoid, (Ptr{ImVector_ImFontGlyph}, ImFontGlyph), self, v)
end

function ImVector_TextRange_push_front(self, v)
    ccall((:ImVector_TextRange_push_front, libcimgui), Cvoid, (Ptr{ImVector_TextRange}, TextRange), self, v)
end

function ImVector_CustomRect_push_front(self, v)
    ccall((:ImVector_CustomRect_push_front, libcimgui), Cvoid, (Ptr{ImVector_CustomRect}, CustomRect), self, v)
end

function ImVector_ImDrawChannel_push_front(self, v)
    ccall((:ImVector_ImDrawChannel_push_front, libcimgui), Cvoid, (Ptr{ImVector_ImDrawChannel}, ImDrawChannel), self, v)
end

function ImVector_char_push_front(self, v)
    ccall((:ImVector_char_push_front, libcimgui), Cvoid, (Ptr{ImVector_char}, UInt8), self, v)
end

function ImVector_ImTextureID_push_front(self, v)
    ccall((:ImVector_ImTextureID_push_front, libcimgui), Cvoid, (Ptr{ImVector_ImTextureID}, ImTextureID), self, v)
end

function ImVector_ImDrawVert_push_front(self, v)
    ccall((:ImVector_ImDrawVert_push_front, libcimgui), Cvoid, (Ptr{ImVector_ImDrawVert}, ImDrawVert), self, v)
end

function ImVector_int_push_front(self, v)
    ccall((:ImVector_int_push_front, libcimgui), Cvoid, (Ptr{ImVector_int}, Cint), self, v)
end

function ImVector_Pair_push_front(self, v)
    ccall((:ImVector_Pair_push_front, libcimgui), Cvoid, (Ptr{ImVector_Pair}, Pair), self, v)
end

function ImVector_ImFontPtr_push_front(self, v)
    ccall((:ImVector_ImFontPtr_push_front, libcimgui), Cvoid, (Ptr{ImVector_ImFontPtr}, Ptr{ImFont}), self, v)
end

function ImVector_ImVec4_push_front(self, v)
    ccall((:ImVector_ImVec4_push_front, libcimgui), Cvoid, (Ptr{ImVector_ImVec4}, ImVec4), self, v)
end

function ImVector_ImDrawCmd_push_front(self, v)
    ccall((:ImVector_ImDrawCmd_push_front, libcimgui), Cvoid, (Ptr{ImVector_ImDrawCmd}, ImDrawCmd), self, v)
end

function ImVector_ImDrawIdx_push_front(self, v)
    ccall((:ImVector_ImDrawIdx_push_front, libcimgui), Cvoid, (Ptr{ImVector_ImDrawIdx}, ImDrawIdx), self, v)
end

function ImVector_ImVec2_push_front(self, v)
    ccall((:ImVector_ImVec2_push_front, libcimgui), Cvoid, (Ptr{ImVector_ImVec2}, ImVec2), self, v)
end

function ImVector_float_erase(self, it)
    ccall((:ImVector_float_erase, libcimgui), Ptr{Cfloat}, (Ptr{ImVector_float}, Ptr{Cfloat}), self, it)
end

function ImVector_ImWchar_erase(self, it)
    ccall((:ImVector_ImWchar_erase, libcimgui), Ptr{ImWchar}, (Ptr{ImVector_ImWchar}, Ptr{ImWchar}), self, it)
end

function ImVector_ImFontConfig_erase(self, it)
    ccall((:ImVector_ImFontConfig_erase, libcimgui), Ptr{ImFontConfig}, (Ptr{ImVector_ImFontConfig}, Ptr{ImFontConfig}), self, it)
end

function ImVector_ImFontGlyph_erase(self, it)
    ccall((:ImVector_ImFontGlyph_erase, libcimgui), Ptr{ImFontGlyph}, (Ptr{ImVector_ImFontGlyph}, Ptr{ImFontGlyph}), self, it)
end

function ImVector_TextRange_erase(self, it)
    ccall((:ImVector_TextRange_erase, libcimgui), Ptr{TextRange}, (Ptr{ImVector_TextRange}, Ptr{TextRange}), self, it)
end

function ImVector_CustomRect_erase(self, it)
    ccall((:ImVector_CustomRect_erase, libcimgui), Ptr{CustomRect}, (Ptr{ImVector_CustomRect}, Ptr{CustomRect}), self, it)
end

function ImVector_ImDrawChannel_erase(self, it)
    ccall((:ImVector_ImDrawChannel_erase, libcimgui), Ptr{ImDrawChannel}, (Ptr{ImVector_ImDrawChannel}, Ptr{ImDrawChannel}), self, it)
end

function ImVector_char_erase(self, it)
    ccall((:ImVector_char_erase, libcimgui), Cstring, (Ptr{ImVector_char}, Cstring), self, it)
end

function ImVector_ImTextureID_erase(self, it)
    ccall((:ImVector_ImTextureID_erase, libcimgui), Ptr{ImTextureID}, (Ptr{ImVector_ImTextureID}, Ptr{ImTextureID}), self, it)
end

function ImVector_ImDrawVert_erase(self, it)
    ccall((:ImVector_ImDrawVert_erase, libcimgui), Ptr{ImDrawVert}, (Ptr{ImVector_ImDrawVert}, Ptr{ImDrawVert}), self, it)
end

function ImVector_int_erase(self, it)
    ccall((:ImVector_int_erase, libcimgui), Ptr{Cint}, (Ptr{ImVector_int}, Ptr{Cint}), self, it)
end

function ImVector_Pair_erase(self, it)
    ccall((:ImVector_Pair_erase, libcimgui), Ptr{Pair}, (Ptr{ImVector_Pair}, Ptr{Pair}), self, it)
end

function ImVector_ImFontPtr_erase(self, it)
    ccall((:ImVector_ImFontPtr_erase, libcimgui), Ptr{Ptr{ImFont}}, (Ptr{ImVector_ImFontPtr}, Ptr{Ptr{ImFont}}), self, it)
end

function ImVector_ImVec4_erase(self, it)
    ccall((:ImVector_ImVec4_erase, libcimgui), Ptr{ImVec4}, (Ptr{ImVector_ImVec4}, Ptr{ImVec4}), self, it)
end

function ImVector_ImDrawCmd_erase(self, it)
    ccall((:ImVector_ImDrawCmd_erase, libcimgui), Ptr{ImDrawCmd}, (Ptr{ImVector_ImDrawCmd}, Ptr{ImDrawCmd}), self, it)
end

function ImVector_ImDrawIdx_erase(self, it)
    ccall((:ImVector_ImDrawIdx_erase, libcimgui), Ptr{ImDrawIdx}, (Ptr{ImVector_ImDrawIdx}, Ptr{ImDrawIdx}), self, it)
end

function ImVector_ImVec2_erase(self, it)
    ccall((:ImVector_ImVec2_erase, libcimgui), Ptr{ImVec2}, (Ptr{ImVector_ImVec2}, Ptr{ImVec2}), self, it)
end

function ImVector_float_eraseTPtr(self, it, it_last)
    ccall((:ImVector_float_eraseTPtr, libcimgui), Ptr{Cfloat}, (Ptr{ImVector_float}, Ptr{Cfloat}, Ptr{Cfloat}), self, it, it_last)
end

function ImVector_ImWchar_eraseTPtr(self, it, it_last)
    ccall((:ImVector_ImWchar_eraseTPtr, libcimgui), Ptr{ImWchar}, (Ptr{ImVector_ImWchar}, Ptr{ImWchar}, Ptr{ImWchar}), self, it, it_last)
end

function ImVector_ImFontConfig_eraseTPtr(self, it, it_last)
    ccall((:ImVector_ImFontConfig_eraseTPtr, libcimgui), Ptr{ImFontConfig}, (Ptr{ImVector_ImFontConfig}, Ptr{ImFontConfig}, Ptr{ImFontConfig}), self, it, it_last)
end

function ImVector_ImFontGlyph_eraseTPtr(self, it, it_last)
    ccall((:ImVector_ImFontGlyph_eraseTPtr, libcimgui), Ptr{ImFontGlyph}, (Ptr{ImVector_ImFontGlyph}, Ptr{ImFontGlyph}, Ptr{ImFontGlyph}), self, it, it_last)
end

function ImVector_TextRange_eraseTPtr(self, it, it_last)
    ccall((:ImVector_TextRange_eraseTPtr, libcimgui), Ptr{TextRange}, (Ptr{ImVector_TextRange}, Ptr{TextRange}, Ptr{TextRange}), self, it, it_last)
end

function ImVector_CustomRect_eraseTPtr(self, it, it_last)
    ccall((:ImVector_CustomRect_eraseTPtr, libcimgui), Ptr{CustomRect}, (Ptr{ImVector_CustomRect}, Ptr{CustomRect}, Ptr{CustomRect}), self, it, it_last)
end

function ImVector_ImDrawChannel_eraseTPtr(self, it, it_last)
    ccall((:ImVector_ImDrawChannel_eraseTPtr, libcimgui), Ptr{ImDrawChannel}, (Ptr{ImVector_ImDrawChannel}, Ptr{ImDrawChannel}, Ptr{ImDrawChannel}), self, it, it_last)
end

function ImVector_char_eraseTPtr(self, it, it_last)
    ccall((:ImVector_char_eraseTPtr, libcimgui), Cstring, (Ptr{ImVector_char}, Cstring, Cstring), self, it, it_last)
end

function ImVector_ImTextureID_eraseTPtr(self, it, it_last)
    ccall((:ImVector_ImTextureID_eraseTPtr, libcimgui), Ptr{ImTextureID}, (Ptr{ImVector_ImTextureID}, Ptr{ImTextureID}, Ptr{ImTextureID}), self, it, it_last)
end

function ImVector_ImDrawVert_eraseTPtr(self, it, it_last)
    ccall((:ImVector_ImDrawVert_eraseTPtr, libcimgui), Ptr{ImDrawVert}, (Ptr{ImVector_ImDrawVert}, Ptr{ImDrawVert}, Ptr{ImDrawVert}), self, it, it_last)
end

function ImVector_int_eraseTPtr(self, it, it_last)
    ccall((:ImVector_int_eraseTPtr, libcimgui), Ptr{Cint}, (Ptr{ImVector_int}, Ptr{Cint}, Ptr{Cint}), self, it, it_last)
end

function ImVector_Pair_eraseTPtr(self, it, it_last)
    ccall((:ImVector_Pair_eraseTPtr, libcimgui), Ptr{Pair}, (Ptr{ImVector_Pair}, Ptr{Pair}, Ptr{Pair}), self, it, it_last)
end

function ImVector_ImFontPtr_eraseTPtr(self, it, it_last)
    ccall((:ImVector_ImFontPtr_eraseTPtr, libcimgui), Ptr{Ptr{ImFont}}, (Ptr{ImVector_ImFontPtr}, Ptr{Ptr{ImFont}}, Ptr{Ptr{ImFont}}), self, it, it_last)
end

function ImVector_ImVec4_eraseTPtr(self, it, it_last)
    ccall((:ImVector_ImVec4_eraseTPtr, libcimgui), Ptr{ImVec4}, (Ptr{ImVector_ImVec4}, Ptr{ImVec4}, Ptr{ImVec4}), self, it, it_last)
end

function ImVector_ImDrawCmd_eraseTPtr(self, it, it_last)
    ccall((:ImVector_ImDrawCmd_eraseTPtr, libcimgui), Ptr{ImDrawCmd}, (Ptr{ImVector_ImDrawCmd}, Ptr{ImDrawCmd}, Ptr{ImDrawCmd}), self, it, it_last)
end

function ImVector_ImDrawIdx_eraseTPtr(self, it, it_last)
    ccall((:ImVector_ImDrawIdx_eraseTPtr, libcimgui), Ptr{ImDrawIdx}, (Ptr{ImVector_ImDrawIdx}, Ptr{ImDrawIdx}, Ptr{ImDrawIdx}), self, it, it_last)
end

function ImVector_ImVec2_eraseTPtr(self, it, it_last)
    ccall((:ImVector_ImVec2_eraseTPtr, libcimgui), Ptr{ImVec2}, (Ptr{ImVector_ImVec2}, Ptr{ImVec2}, Ptr{ImVec2}), self, it, it_last)
end

function ImVector_float_erase_unsorted(self, it)
    ccall((:ImVector_float_erase_unsorted, libcimgui), Ptr{Cfloat}, (Ptr{ImVector_float}, Ptr{Cfloat}), self, it)
end

function ImVector_ImWchar_erase_unsorted(self, it)
    ccall((:ImVector_ImWchar_erase_unsorted, libcimgui), Ptr{ImWchar}, (Ptr{ImVector_ImWchar}, Ptr{ImWchar}), self, it)
end

function ImVector_ImFontConfig_erase_unsorted(self, it)
    ccall((:ImVector_ImFontConfig_erase_unsorted, libcimgui), Ptr{ImFontConfig}, (Ptr{ImVector_ImFontConfig}, Ptr{ImFontConfig}), self, it)
end

function ImVector_ImFontGlyph_erase_unsorted(self, it)
    ccall((:ImVector_ImFontGlyph_erase_unsorted, libcimgui), Ptr{ImFontGlyph}, (Ptr{ImVector_ImFontGlyph}, Ptr{ImFontGlyph}), self, it)
end

function ImVector_TextRange_erase_unsorted(self, it)
    ccall((:ImVector_TextRange_erase_unsorted, libcimgui), Ptr{TextRange}, (Ptr{ImVector_TextRange}, Ptr{TextRange}), self, it)
end

function ImVector_CustomRect_erase_unsorted(self, it)
    ccall((:ImVector_CustomRect_erase_unsorted, libcimgui), Ptr{CustomRect}, (Ptr{ImVector_CustomRect}, Ptr{CustomRect}), self, it)
end

function ImVector_ImDrawChannel_erase_unsorted(self, it)
    ccall((:ImVector_ImDrawChannel_erase_unsorted, libcimgui), Ptr{ImDrawChannel}, (Ptr{ImVector_ImDrawChannel}, Ptr{ImDrawChannel}), self, it)
end

function ImVector_char_erase_unsorted(self, it)
    ccall((:ImVector_char_erase_unsorted, libcimgui), Cstring, (Ptr{ImVector_char}, Cstring), self, it)
end

function ImVector_ImTextureID_erase_unsorted(self, it)
    ccall((:ImVector_ImTextureID_erase_unsorted, libcimgui), Ptr{ImTextureID}, (Ptr{ImVector_ImTextureID}, Ptr{ImTextureID}), self, it)
end

function ImVector_ImDrawVert_erase_unsorted(self, it)
    ccall((:ImVector_ImDrawVert_erase_unsorted, libcimgui), Ptr{ImDrawVert}, (Ptr{ImVector_ImDrawVert}, Ptr{ImDrawVert}), self, it)
end

function ImVector_int_erase_unsorted(self, it)
    ccall((:ImVector_int_erase_unsorted, libcimgui), Ptr{Cint}, (Ptr{ImVector_int}, Ptr{Cint}), self, it)
end

function ImVector_Pair_erase_unsorted(self, it)
    ccall((:ImVector_Pair_erase_unsorted, libcimgui), Ptr{Pair}, (Ptr{ImVector_Pair}, Ptr{Pair}), self, it)
end

function ImVector_ImFontPtr_erase_unsorted(self, it)
    ccall((:ImVector_ImFontPtr_erase_unsorted, libcimgui), Ptr{Ptr{ImFont}}, (Ptr{ImVector_ImFontPtr}, Ptr{Ptr{ImFont}}), self, it)
end

function ImVector_ImVec4_erase_unsorted(self, it)
    ccall((:ImVector_ImVec4_erase_unsorted, libcimgui), Ptr{ImVec4}, (Ptr{ImVector_ImVec4}, Ptr{ImVec4}), self, it)
end

function ImVector_ImDrawCmd_erase_unsorted(self, it)
    ccall((:ImVector_ImDrawCmd_erase_unsorted, libcimgui), Ptr{ImDrawCmd}, (Ptr{ImVector_ImDrawCmd}, Ptr{ImDrawCmd}), self, it)
end

function ImVector_ImDrawIdx_erase_unsorted(self, it)
    ccall((:ImVector_ImDrawIdx_erase_unsorted, libcimgui), Ptr{ImDrawIdx}, (Ptr{ImVector_ImDrawIdx}, Ptr{ImDrawIdx}), self, it)
end

function ImVector_ImVec2_erase_unsorted(self, it)
    ccall((:ImVector_ImVec2_erase_unsorted, libcimgui), Ptr{ImVec2}, (Ptr{ImVector_ImVec2}, Ptr{ImVec2}), self, it)
end

function ImVector_float_insert(self, it, v)
    ccall((:ImVector_float_insert, libcimgui), Ptr{Cfloat}, (Ptr{ImVector_float}, Ptr{Cfloat}, Cfloat), self, it, v)
end

function ImVector_ImWchar_insert(self, it, v)
    ccall((:ImVector_ImWchar_insert, libcimgui), Ptr{ImWchar}, (Ptr{ImVector_ImWchar}, Ptr{ImWchar}, ImWchar), self, it, v)
end

function ImVector_ImFontConfig_insert(self, it, v)
    ccall((:ImVector_ImFontConfig_insert, libcimgui), Ptr{ImFontConfig}, (Ptr{ImVector_ImFontConfig}, Ptr{ImFontConfig}, ImFontConfig), self, it, v)
end

function ImVector_ImFontGlyph_insert(self, it, v)
    ccall((:ImVector_ImFontGlyph_insert, libcimgui), Ptr{ImFontGlyph}, (Ptr{ImVector_ImFontGlyph}, Ptr{ImFontGlyph}, ImFontGlyph), self, it, v)
end

function ImVector_TextRange_insert(self, it, v)
    ccall((:ImVector_TextRange_insert, libcimgui), Ptr{TextRange}, (Ptr{ImVector_TextRange}, Ptr{TextRange}, TextRange), self, it, v)
end

function ImVector_CustomRect_insert(self, it, v)
    ccall((:ImVector_CustomRect_insert, libcimgui), Ptr{CustomRect}, (Ptr{ImVector_CustomRect}, Ptr{CustomRect}, CustomRect), self, it, v)
end

function ImVector_ImDrawChannel_insert(self, it, v)
    ccall((:ImVector_ImDrawChannel_insert, libcimgui), Ptr{ImDrawChannel}, (Ptr{ImVector_ImDrawChannel}, Ptr{ImDrawChannel}, ImDrawChannel), self, it, v)
end

function ImVector_char_insert(self, it, v)
    ccall((:ImVector_char_insert, libcimgui), Cstring, (Ptr{ImVector_char}, Cstring, UInt8), self, it, v)
end

function ImVector_ImTextureID_insert(self, it, v)
    ccall((:ImVector_ImTextureID_insert, libcimgui), Ptr{ImTextureID}, (Ptr{ImVector_ImTextureID}, Ptr{ImTextureID}, ImTextureID), self, it, v)
end

function ImVector_ImDrawVert_insert(self, it, v)
    ccall((:ImVector_ImDrawVert_insert, libcimgui), Ptr{ImDrawVert}, (Ptr{ImVector_ImDrawVert}, Ptr{ImDrawVert}, ImDrawVert), self, it, v)
end

function ImVector_int_insert(self, it, v)
    ccall((:ImVector_int_insert, libcimgui), Ptr{Cint}, (Ptr{ImVector_int}, Ptr{Cint}, Cint), self, it, v)
end

function ImVector_Pair_insert(self, it, v)
    ccall((:ImVector_Pair_insert, libcimgui), Ptr{Pair}, (Ptr{ImVector_Pair}, Ptr{Pair}, Pair), self, it, v)
end

function ImVector_ImFontPtr_insert(self, it, v)
    ccall((:ImVector_ImFontPtr_insert, libcimgui), Ptr{Ptr{ImFont}}, (Ptr{ImVector_ImFontPtr}, Ptr{Ptr{ImFont}}, Ptr{ImFont}), self, it, v)
end

function ImVector_ImVec4_insert(self, it, v)
    ccall((:ImVector_ImVec4_insert, libcimgui), Ptr{ImVec4}, (Ptr{ImVector_ImVec4}, Ptr{ImVec4}, ImVec4), self, it, v)
end

function ImVector_ImDrawCmd_insert(self, it, v)
    ccall((:ImVector_ImDrawCmd_insert, libcimgui), Ptr{ImDrawCmd}, (Ptr{ImVector_ImDrawCmd}, Ptr{ImDrawCmd}, ImDrawCmd), self, it, v)
end

function ImVector_ImDrawIdx_insert(self, it, v)
    ccall((:ImVector_ImDrawIdx_insert, libcimgui), Ptr{ImDrawIdx}, (Ptr{ImVector_ImDrawIdx}, Ptr{ImDrawIdx}, ImDrawIdx), self, it, v)
end

function ImVector_ImVec2_insert(self, it, v)
    ccall((:ImVector_ImVec2_insert, libcimgui), Ptr{ImVec2}, (Ptr{ImVector_ImVec2}, Ptr{ImVec2}, ImVec2), self, it, v)
end

function ImVector_float_contains(self, v)
    ccall((:ImVector_float_contains, libcimgui), Bool, (Ptr{ImVector_float}, Cfloat), self, v)
end

function ImVector_ImWchar_contains(self, v)
    ccall((:ImVector_ImWchar_contains, libcimgui), Bool, (Ptr{ImVector_ImWchar}, ImWchar), self, v)
end

function ImVector_char_contains(self, v)
    ccall((:ImVector_char_contains, libcimgui), Bool, (Ptr{ImVector_char}, UInt8), self, v)
end

function ImVector_int_contains(self, v)
    ccall((:ImVector_int_contains, libcimgui), Bool, (Ptr{ImVector_int}, Cint), self, v)
end

function ImVector_float_index_from_ptr(self, it)
    ccall((:ImVector_float_index_from_ptr, libcimgui), Cint, (Ptr{ImVector_float}, Ptr{Cfloat}), self, it)
end

function ImVector_ImWchar_index_from_ptr(self, it)
    ccall((:ImVector_ImWchar_index_from_ptr, libcimgui), Cint, (Ptr{ImVector_ImWchar}, Ptr{ImWchar}), self, it)
end

function ImVector_ImFontConfig_index_from_ptr(self, it)
    ccall((:ImVector_ImFontConfig_index_from_ptr, libcimgui), Cint, (Ptr{ImVector_ImFontConfig}, Ptr{ImFontConfig}), self, it)
end

function ImVector_ImFontGlyph_index_from_ptr(self, it)
    ccall((:ImVector_ImFontGlyph_index_from_ptr, libcimgui), Cint, (Ptr{ImVector_ImFontGlyph}, Ptr{ImFontGlyph}), self, it)
end

function ImVector_TextRange_index_from_ptr(self, it)
    ccall((:ImVector_TextRange_index_from_ptr, libcimgui), Cint, (Ptr{ImVector_TextRange}, Ptr{TextRange}), self, it)
end

function ImVector_CustomRect_index_from_ptr(self, it)
    ccall((:ImVector_CustomRect_index_from_ptr, libcimgui), Cint, (Ptr{ImVector_CustomRect}, Ptr{CustomRect}), self, it)
end

function ImVector_ImDrawChannel_index_from_ptr(self, it)
    ccall((:ImVector_ImDrawChannel_index_from_ptr, libcimgui), Cint, (Ptr{ImVector_ImDrawChannel}, Ptr{ImDrawChannel}), self, it)
end

function ImVector_char_index_from_ptr(self, it)
    ccall((:ImVector_char_index_from_ptr, libcimgui), Cint, (Ptr{ImVector_char}, Cstring), self, it)
end

function ImVector_ImTextureID_index_from_ptr(self, it)
    ccall((:ImVector_ImTextureID_index_from_ptr, libcimgui), Cint, (Ptr{ImVector_ImTextureID}, Ptr{ImTextureID}), self, it)
end

function ImVector_ImDrawVert_index_from_ptr(self, it)
    ccall((:ImVector_ImDrawVert_index_from_ptr, libcimgui), Cint, (Ptr{ImVector_ImDrawVert}, Ptr{ImDrawVert}), self, it)
end

function ImVector_int_index_from_ptr(self, it)
    ccall((:ImVector_int_index_from_ptr, libcimgui), Cint, (Ptr{ImVector_int}, Ptr{Cint}), self, it)
end

function ImVector_Pair_index_from_ptr(self, it)
    ccall((:ImVector_Pair_index_from_ptr, libcimgui), Cint, (Ptr{ImVector_Pair}, Ptr{Pair}), self, it)
end

function ImVector_ImFontPtr_index_from_ptr(self, it)
    ccall((:ImVector_ImFontPtr_index_from_ptr, libcimgui), Cint, (Ptr{ImVector_ImFontPtr}, Ptr{Ptr{ImFont}}), self, it)
end

function ImVector_ImVec4_index_from_ptr(self, it)
    ccall((:ImVector_ImVec4_index_from_ptr, libcimgui), Cint, (Ptr{ImVector_ImVec4}, Ptr{ImVec4}), self, it)
end

function ImVector_ImDrawCmd_index_from_ptr(self, it)
    ccall((:ImVector_ImDrawCmd_index_from_ptr, libcimgui), Cint, (Ptr{ImVector_ImDrawCmd}, Ptr{ImDrawCmd}), self, it)
end

function ImVector_ImDrawIdx_index_from_ptr(self, it)
    ccall((:ImVector_ImDrawIdx_index_from_ptr, libcimgui), Cint, (Ptr{ImVector_ImDrawIdx}, Ptr{ImDrawIdx}), self, it)
end

function ImVector_ImVec2_index_from_ptr(self, it)
    ccall((:ImVector_ImVec2_index_from_ptr, libcimgui), Cint, (Ptr{ImVector_ImVec2}, Ptr{ImVec2}), self, it)
end

function igGET_FLT_MAX()
    ccall((:igGET_FLT_MAX, libcimgui), Cfloat, ())
end

function igColorConvertRGBtoHSV(r, g, b, out_h, out_s, out_v)
    ccall((:igColorConvertRGBtoHSV, libcimgui), Cvoid, (Cfloat, Cfloat, Cfloat, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}), r, g, b, out_h, out_s, out_v)
end

function igColorConvertHSVtoRGB(h, s, v, out_r, out_g, out_b)
    ccall((:igColorConvertHSVtoRGB, libcimgui), Cvoid, (Cfloat, Cfloat, Cfloat, Ptr{Cfloat}, Ptr{Cfloat}, Ptr{Cfloat}), h, s, v, out_r, out_g, out_b)
end

function ImVector_ImWchar_create()
    ccall((:ImVector_ImWchar_create, libcimgui), Ptr{ImVector_ImWchar}, ())
end

function ImVector_ImWchar_Init(p)
    ccall((:ImVector_ImWchar_Init, libcimgui), Cvoid, (Ptr{ImVector_ImWchar},), p)
end

function ImVector_ImWchar_UnInit(p)
    ccall((:ImVector_ImWchar_UnInit, libcimgui), Cvoid, (Ptr{ImVector_ImWchar},), p)
end
