# Julia wrapper for header: cimgui.h
# Automatically generated using Clang.jl


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

function igBeginChildStr(str_id, size, border, flags)
    ccall((:igBeginChildStr, libcimgui), Bool, (Cstring, ImVec2, Bool, ImGuiWindowFlags), str_id, size, border, flags)
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

function igGetContentRegionMax(pOut)
    ccall((:igGetContentRegionMax, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
end

function igGetContentRegionAvail(pOut)
    ccall((:igGetContentRegionAvail, libcimgui), Cvoid, (Ptr{ImVec2},), pOut)
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

function igGetScrollMaxX()
    ccall((:igGetScrollMaxX, libcimgui), Cfloat, ())
end

function igGetScrollMaxY()
    ccall((:igGetScrollMaxY, libcimgui), Cfloat, ())
end

function igSetScrollXFloat(scroll_x)
    ccall((:igSetScrollXFloat, libcimgui), Cvoid, (Cfloat,), scroll_x)
end

function igSetScrollYFloat(scroll_y)
    ccall((:igSetScrollYFloat, libcimgui), Cvoid, (Cfloat,), scroll_y)
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

function igGetStyleColorVec4(idx)
    ccall((:igGetStyleColorVec4, libcimgui), Ptr{ImVec4}, (ImGuiCol,), idx)
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
    ccall((:igPushIDStr, libcimgui), Cvoid, (Cstring,), str_id)
end

function igPushIDStrStr(str_id_begin, str_id_end)
    ccall((:igPushIDStrStr, libcimgui), Cvoid, (Cstring, Cstring), str_id_begin, str_id_end)
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

function igGetIDStrStr(str_id_begin, str_id_end)
    ccall((:igGetIDStrStr, libcimgui), ImGuiID, (Cstring, Cstring), str_id_begin, str_id_end)
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

function igComboStr_arr(label, current_item, items, items_count, popup_max_height_in_items)
    ccall((:igComboStr_arr, libcimgui), Bool, (Cstring, Ptr{Cint}, Ptr{Cstring}, Cint, Cint), label, current_item, items, items_count, popup_max_height_in_items)
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

function igDragScalar(label, data_type, p_data, v_speed, p_min, p_max, format, power)
    ccall((:igDragScalar, libcimgui), Bool, (Cstring, ImGuiDataType, Ptr{Cvoid}, Cfloat, Ptr{Cvoid}, Ptr{Cvoid}, Cstring, Cfloat), label, data_type, p_data, v_speed, p_min, p_max, format, power)
end

function igDragScalarN(label, data_type, p_data, components, v_speed, p_min, p_max, format, power)
    ccall((:igDragScalarN, libcimgui), Bool, (Cstring, ImGuiDataType, Ptr{Cvoid}, Cint, Cfloat, Ptr{Cvoid}, Ptr{Cvoid}, Cstring, Cfloat), label, data_type, p_data, components, v_speed, p_min, p_max, format, power)
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

function igSliderScalar(label, data_type, p_data, p_min, p_max, format, power)
    ccall((:igSliderScalar, libcimgui), Bool, (Cstring, ImGuiDataType, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Cstring, Cfloat), label, data_type, p_data, p_min, p_max, format, power)
end

function igSliderScalarN(label, data_type, p_data, components, p_min, p_max, format, power)
    ccall((:igSliderScalarN, libcimgui), Bool, (Cstring, ImGuiDataType, Ptr{Cvoid}, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Cstring, Cfloat), label, data_type, p_data, components, p_min, p_max, format, power)
end

function igVSliderFloat(label, size, v, v_min, v_max, format, power)
    ccall((:igVSliderFloat, libcimgui), Bool, (Cstring, ImVec2, Ptr{Cfloat}, Cfloat, Cfloat, Cstring, Cfloat), label, size, v, v_min, v_max, format, power)
end

function igVSliderInt(label, size, v, v_min, v_max, format)
    ccall((:igVSliderInt, libcimgui), Bool, (Cstring, ImVec2, Ptr{Cint}, Cint, Cint, Cstring), label, size, v, v_min, v_max, format)
end

function igVSliderScalar(label, size, data_type, p_data, p_min, p_max, format, power)
    ccall((:igVSliderScalar, libcimgui), Bool, (Cstring, ImVec2, ImGuiDataType, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Cstring, Cfloat), label, size, data_type, p_data, p_min, p_max, format, power)
end

function igInputText(label, buf, buf_size, flags, callback, user_data)
    ccall((:igInputText, libcimgui), Bool, (Cstring, Ptr{UInt8}, Csize_t, ImGuiInputTextFlags, ImGuiInputTextCallback, Ptr{Cvoid}), label, buf, buf_size, flags, callback, user_data)
end

function igInputTextMultiline(label, buf, buf_size, size, flags, callback, user_data)
    ccall((:igInputTextMultiline, libcimgui), Bool, (Cstring, Ptr{UInt8}, Csize_t, ImVec2, ImGuiInputTextFlags, ImGuiInputTextCallback, Ptr{Cvoid}), label, buf, buf_size, size, flags, callback, user_data)
end

function igInputTextWithHint(label, hint, buf, buf_size, flags, callback, user_data)
    ccall((:igInputTextWithHint, libcimgui), Bool, (Cstring, Ptr{UInt8}, Ptr{UInt8}, Csize_t, ImGuiInputTextFlags, ImGuiInputTextCallback, Ptr{Cvoid}), label, hint, buf, buf_size, flags, callback, user_data)
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

function igInputScalar(label, data_type, p_data, p_step, p_step_fast, format, flags)
    ccall((:igInputScalar, libcimgui), Bool, (Cstring, ImGuiDataType, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Cstring, ImGuiInputTextFlags), label, data_type, p_data, p_step, p_step_fast, format, flags)
end

function igInputScalarN(label, data_type, p_data, components, p_step, p_step_fast, format, flags)
    ccall((:igInputScalarN, libcimgui), Bool, (Cstring, ImGuiDataType, Ptr{Cvoid}, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Cstring, ImGuiInputTextFlags), label, data_type, p_data, components, p_step, p_step_fast, format, flags)
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

function igGetTreeNodeToLabelSpacing()
    ccall((:igGetTreeNodeToLabelSpacing, libcimgui), Cfloat, ())
end

function igCollapsingHeaderTreeNodeFlags(label, flags)
    ccall((:igCollapsingHeaderTreeNodeFlags, libcimgui), Bool, (Cstring, ImGuiTreeNodeFlags), label, flags)
end

function igCollapsingHeaderBoolPtr(label, p_open, flags)
    ccall((:igCollapsingHeaderBoolPtr, libcimgui), Bool, (Cstring, Ptr{Bool}, ImGuiTreeNodeFlags), label, p_open, flags)
end

function igSetNextItemOpen(is_open, cond)
    ccall((:igSetNextItemOpen, libcimgui), Cvoid, (Bool, ImGuiCond), is_open, cond)
end

function igSelectableBool(label, selected, flags, size)
    ccall((:igSelectableBool, libcimgui), Bool, (Cstring, Bool, ImGuiSelectableFlags, ImVec2), label, selected, flags, size)
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

function igPlotLinesFloatPtr(label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride)
    ccall((:igPlotLinesFloatPtr, libcimgui), Cvoid, (Cstring, Ptr{Cfloat}, Cint, Cint, Cstring, Cfloat, Cfloat, ImVec2, Cint), label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride)
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
    ccall((:igBeginPopupContextItem, libcimgui), Bool, (Cstring, ImGuiMouseButton), str_id, mouse_button)
end

function igBeginPopupContextWindow(str_id, mouse_button, also_over_items)
    ccall((:igBeginPopupContextWindow, libcimgui), Bool, (Cstring, ImGuiMouseButton, Bool), str_id, mouse_button, also_over_items)
end

function igBeginPopupContextVoid(str_id, mouse_button)
    ccall((:igBeginPopupContextVoid, libcimgui), Bool, (Cstring, ImGuiMouseButton), str_id, mouse_button)
end

function igBeginPopupModal(name, p_open, flags)
    ccall((:igBeginPopupModal, libcimgui), Bool, (Cstring, Ptr{Bool}, ImGuiWindowFlags), name, p_open, flags)
end

function igEndPopup()
    ccall((:igEndPopup, libcimgui), Cvoid, ())
end

function igOpenPopupOnItemClick(str_id, mouse_button)
    ccall((:igOpenPopupOnItemClick, libcimgui), Bool, (Cstring, ImGuiMouseButton), str_id, mouse_button)
end

function igIsPopupOpenStr(str_id)
    ccall((:igIsPopupOpenStr, libcimgui), Bool, (Cstring,), str_id)
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

function igGetBackgroundDrawList()
    ccall((:igGetBackgroundDrawList, libcimgui), Ptr{ImDrawList}, ())
end

function igGetForegroundDrawListNil()
    ccall((:igGetForegroundDrawListNil, libcimgui), Ptr{ImDrawList}, ())
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

function igCalcTextSize(pOut, text, text_end, hide_text_after_double_hash, wrap_width)
    ccall((:igCalcTextSize, libcimgui), Cvoid, (Ptr{ImVec2}, Cstring, Cstring, Bool, Cfloat), pOut, text, text_end, hide_text_after_double_hash, wrap_width)
end

function igColorConvertU32ToFloat4(pOut, in)
    ccall((:igColorConvertU32ToFloat4, libcimgui), Cvoid, (Ptr{ImVec4}, ImU32), pOut, in)
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

function igDebugCheckVersionAndDataLayout(version_str, sz_io, sz_style, sz_vec2, sz_vec4, sz_drawvert, sz_drawidx)
    ccall((:igDebugCheckVersionAndDataLayout, libcimgui), Bool, (Cstring, Csize_t, Csize_t, Csize_t, Csize_t, Csize_t, Csize_t), version_str, sz_io, sz_style, sz_vec2, sz_vec4, sz_drawvert, sz_drawidx)
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
    ccall((:ImGuiIO_AddInputCharacter, libcimgui), Cvoid, (Ptr{ImGuiIO}, UInt32), self, c)
end

function ImGuiIO_AddInputCharacterUTF16(self, c)
    ccall((:ImGuiIO_AddInputCharacterUTF16, libcimgui), Cvoid, (Ptr{ImGuiIO}, ImWchar16), self, c)
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

function ImGuiTextRange_ImGuiTextRangeNil()
    ccall((:ImGuiTextRange_ImGuiTextRangeNil, libcimgui), Ptr{ImGuiTextRange}, ())
end

function ImGuiTextRange_destroy(self)
    ccall((:ImGuiTextRange_destroy, libcimgui), Cvoid, (Ptr{ImGuiTextRange},), self)
end

function ImGuiTextRange_ImGuiTextRangeStr(_b, _e)
    ccall((:ImGuiTextRange_ImGuiTextRangeStr, libcimgui), Ptr{ImGuiTextRange}, (Cstring, Cstring), _b, _e)
end

function ImGuiTextRange_empty(self)
    ccall((:ImGuiTextRange_empty, libcimgui), Bool, (Ptr{ImGuiTextRange},), self)
end

function ImGuiTextRange_split(self, separator, out)
    ccall((:ImGuiTextRange_split, libcimgui), Cvoid, (Ptr{ImGuiTextRange}, UInt8, Ptr{ImVector_ImGuiTextRange}), self, separator, out)
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

function ImColor_HSV(pOut, self, h, s, v, a)
    ccall((:ImColor_HSV, libcimgui), Cvoid, (Ptr{ImColor}, Ptr{ImColor}, Cfloat, Cfloat, Cfloat, Cfloat), pOut, self, h, s, v, a)
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

function ImDrawList_AddRect(self, p_min, p_max, col, rounding, rounding_corners, thickness)
    ccall((:ImDrawList_AddRect, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImU32, Cfloat, ImDrawCornerFlags, Cfloat), self, p_min, p_max, col, rounding, rounding_corners, thickness)
end

function ImDrawList_AddRectFilled(self, p_min, p_max, col, rounding, rounding_corners)
    ccall((:ImDrawList_AddRectFilled, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImU32, Cfloat, ImDrawCornerFlags), self, p_min, p_max, col, rounding, rounding_corners)
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
    ccall((:ImDrawList_AddTextVec2, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImU32, Cstring, Cstring), self, pos, col, text_begin, text_end)
end

function ImDrawList_AddTextFontPtr(self, font, font_size, pos, col, text_begin, text_end, wrap_width, cpu_fine_clip_rect)
    ccall((:ImDrawList_AddTextFontPtr, libcimgui), Cvoid, (Ptr{ImDrawList}, Ptr{ImFont}, Cfloat, ImVec2, ImU32, Cstring, Cstring, Cfloat, Ptr{ImVec4}), self, font, font_size, pos, col, text_begin, text_end, wrap_width, cpu_fine_clip_rect)
end

function ImDrawList_AddPolyline(self, points, num_points, col, closed, thickness)
    ccall((:ImDrawList_AddPolyline, libcimgui), Cvoid, (Ptr{ImDrawList}, Ptr{ImVec2}, Cint, ImU32, Bool, Cfloat), self, points, num_points, col, closed, thickness)
end

function ImDrawList_AddConvexPolyFilled(self, points, num_points, col)
    ccall((:ImDrawList_AddConvexPolyFilled, libcimgui), Cvoid, (Ptr{ImDrawList}, Ptr{ImVec2}, Cint, ImU32), self, points, num_points, col)
end

function ImDrawList_AddBezierCurve(self, p1, p2, p3, p4, col, thickness, num_segments)
    ccall((:ImDrawList_AddBezierCurve, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImVec2, ImVec2, ImU32, Cfloat, Cint), self, p1, p2, p3, p4, col, thickness, num_segments)
end

function ImDrawList_AddImage(self, user_texture_id, p_min, p_max, uv_min, uv_max, col)
    ccall((:ImDrawList_AddImage, libcimgui), Cvoid, (Ptr{ImDrawList}, ImTextureID, ImVec2, ImVec2, ImVec2, ImVec2, ImU32), self, user_texture_id, p_min, p_max, uv_min, uv_max, col)
end

function ImDrawList_AddImageQuad(self, user_texture_id, p1, p2, p3, p4, uv1, uv2, uv3, uv4, col)
    ccall((:ImDrawList_AddImageQuad, libcimgui), Cvoid, (Ptr{ImDrawList}, ImTextureID, ImVec2, ImVec2, ImVec2, ImVec2, ImVec2, ImVec2, ImVec2, ImVec2, ImU32), self, user_texture_id, p1, p2, p3, p4, uv1, uv2, uv3, uv4, col)
end

function ImDrawList_AddImageRounded(self, user_texture_id, p_min, p_max, uv_min, uv_max, col, rounding, rounding_corners)
    ccall((:ImDrawList_AddImageRounded, libcimgui), Cvoid, (Ptr{ImDrawList}, ImTextureID, ImVec2, ImVec2, ImVec2, ImVec2, ImU32, Cfloat, ImDrawCornerFlags), self, user_texture_id, p_min, p_max, uv_min, uv_max, col, rounding, rounding_corners)
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

function ImDrawList_PathArcTo(self, center, radius, a_min, a_max, num_segments)
    ccall((:ImDrawList_PathArcTo, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, Cfloat, Cfloat, Cfloat, Cint), self, center, radius, a_min, a_max, num_segments)
end

function ImDrawList_PathArcToFast(self, center, radius, a_min_of_12, a_max_of_12)
    ccall((:ImDrawList_PathArcToFast, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, Cfloat, Cint, Cint), self, center, radius, a_min_of_12, a_max_of_12)
end

function ImDrawList_PathBezierCurveTo(self, p2, p3, p4, num_segments)
    ccall((:ImDrawList_PathBezierCurveTo, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImVec2, Cint), self, p2, p3, p4, num_segments)
end

function ImDrawList_PathRect(self, rect_min, rect_max, rounding, rounding_corners)
    ccall((:ImDrawList_PathRect, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, Cfloat, ImDrawCornerFlags), self, rect_min, rect_max, rounding, rounding_corners)
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

function ImDrawList_Clear(self)
    ccall((:ImDrawList_Clear, libcimgui), Cvoid, (Ptr{ImDrawList},), self)
end

function ImDrawList_ClearFreeMemory(self)
    ccall((:ImDrawList_ClearFreeMemory, libcimgui), Cvoid, (Ptr{ImDrawList},), self)
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
    ccall((:ImFontGlyphRangesBuilder_AddText, libcimgui), Cvoid, (Ptr{ImFontGlyphRangesBuilder}, Cstring, Cstring), self, text, text_end)
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

function ImFontAtlas_AddCustomRectRegular(self, id, width, height)
    ccall((:ImFontAtlas_AddCustomRectRegular, libcimgui), Cint, (Ptr{ImFontAtlas}, UInt32, Cint, Cint), self, id, width, height)
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
    ccall((:ImFont_GetDebugName, libcimgui), Cstring, (Ptr{ImFont},), self)
end

function ImFont_CalcTextSizeA(pOut, self, size, max_width, wrap_width, text_begin, text_end, remaining)
    ccall((:ImFont_CalcTextSizeA, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImFont}, Cfloat, Cfloat, Cfloat, Cstring, Cstring, Ptr{Cstring}), pOut, self, size, max_width, wrap_width, text_begin, text_end, remaining)
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

function ImFont_SetGlyphVisible(self, c, visible)
    ccall((:ImFont_SetGlyphVisible, libcimgui), Cvoid, (Ptr{ImFont}, ImWchar, Bool), self, c, visible)
end

function ImFont_SetFallbackChar(self, c)
    ccall((:ImFont_SetFallbackChar, libcimgui), Cvoid, (Ptr{ImFont}, ImWchar), self, c)
end

function ImFont_IsGlyphRangeUnused(self, c_begin, c_last)
    ccall((:ImFont_IsGlyphRangeUnused, libcimgui), Bool, (Ptr{ImFont}, UInt32, UInt32), self, c_begin, c_last)
end

function igImHashData(data, data_size, seed)
    ccall((:igImHashData, libcimgui), ImU32, (Ptr{Cvoid}, Csize_t, ImU32), data, data_size, seed)
end

function igImHashStr(data, data_size, seed)
    ccall((:igImHashStr, libcimgui), ImU32, (Cstring, Csize_t, ImU32), data, data_size, seed)
end

function igImAlphaBlendColors(col_a, col_b)
    ccall((:igImAlphaBlendColors, libcimgui), ImU32, (ImU32, ImU32), col_a, col_b)
end

function igImIsPowerOfTwo(v)
    ccall((:igImIsPowerOfTwo, libcimgui), Bool, (Cint,), v)
end

function igImUpperPowerOfTwo(v)
    ccall((:igImUpperPowerOfTwo, libcimgui), Cint, (Cint,), v)
end

function igImStricmp(str1, str2)
    ccall((:igImStricmp, libcimgui), Cint, (Cstring, Cstring), str1, str2)
end

function igImStrnicmp(str1, str2, count)
    ccall((:igImStrnicmp, libcimgui), Cint, (Cstring, Cstring, Csize_t), str1, str2, count)
end

function igImStrncpy(dst, src, count)
    ccall((:igImStrncpy, libcimgui), Cvoid, (Cstring, Cstring, Csize_t), dst, src, count)
end

function igImStrdup(str)
    ccall((:igImStrdup, libcimgui), Cstring, (Cstring,), str)
end

function igImStrdupcpy(dst, p_dst_size, str)
    ccall((:igImStrdupcpy, libcimgui), Cstring, (Cstring, Ptr{Csize_t}, Cstring), dst, p_dst_size, str)
end

function igImStrchrRange(str_begin, str_end, c)
    ccall((:igImStrchrRange, libcimgui), Cstring, (Cstring, Cstring, UInt8), str_begin, str_end, c)
end

function igImStrlenW(str)
    ccall((:igImStrlenW, libcimgui), Cint, (Ptr{ImWchar},), str)
end

function igImStreolRange(str, str_end)
    ccall((:igImStreolRange, libcimgui), Cstring, (Cstring, Cstring), str, str_end)
end

function igImStrbolW(buf_mid_line, buf_begin)
    ccall((:igImStrbolW, libcimgui), Ptr{ImWchar}, (Ptr{ImWchar}, Ptr{ImWchar}), buf_mid_line, buf_begin)
end

function igImStristr(haystack, haystack_end, needle, needle_end)
    ccall((:igImStristr, libcimgui), Cstring, (Cstring, Cstring, Cstring, Cstring), haystack, haystack_end, needle, needle_end)
end

function igImStrTrimBlanks(str)
    ccall((:igImStrTrimBlanks, libcimgui), Cvoid, (Cstring,), str)
end

function igImStrSkipBlank(str)
    ccall((:igImStrSkipBlank, libcimgui), Cstring, (Cstring,), str)
end

function igImParseFormatFindStart(format)
    ccall((:igImParseFormatFindStart, libcimgui), Cstring, (Cstring,), format)
end

function igImParseFormatFindEnd(format)
    ccall((:igImParseFormatFindEnd, libcimgui), Cstring, (Cstring,), format)
end

function igImParseFormatTrimDecorations(format, buf, buf_size)
    ccall((:igImParseFormatTrimDecorations, libcimgui), Cstring, (Cstring, Cstring, Csize_t), format, buf, buf_size)
end

function igImParseFormatPrecision(format, default_value)
    ccall((:igImParseFormatPrecision, libcimgui), Cint, (Cstring, Cint), format, default_value)
end

function igImCharIsBlankA(c)
    ccall((:igImCharIsBlankA, libcimgui), Bool, (UInt8,), c)
end

function igImCharIsBlankW(c)
    ccall((:igImCharIsBlankW, libcimgui), Bool, (UInt32,), c)
end

function igImTextStrToUtf8(buf, buf_size, in_text, in_text_end)
    ccall((:igImTextStrToUtf8, libcimgui), Cint, (Cstring, Cint, Ptr{ImWchar}, Ptr{ImWchar}), buf, buf_size, in_text, in_text_end)
end

function igImTextCharFromUtf8(out_char, in_text, in_text_end)
    ccall((:igImTextCharFromUtf8, libcimgui), Cint, (Ptr{UInt32}, Cstring, Cstring), out_char, in_text, in_text_end)
end

function igImTextStrFromUtf8(buf, buf_size, in_text, in_text_end, in_remaining)
    ccall((:igImTextStrFromUtf8, libcimgui), Cint, (Ptr{ImWchar}, Cint, Cstring, Cstring, Ptr{Cstring}), buf, buf_size, in_text, in_text_end, in_remaining)
end

function igImTextCountCharsFromUtf8(in_text, in_text_end)
    ccall((:igImTextCountCharsFromUtf8, libcimgui), Cint, (Cstring, Cstring), in_text, in_text_end)
end

function igImTextCountUtf8BytesFromChar(in_text, in_text_end)
    ccall((:igImTextCountUtf8BytesFromChar, libcimgui), Cint, (Cstring, Cstring), in_text, in_text_end)
end

function igImTextCountUtf8BytesFromStr(in_text, in_text_end)
    ccall((:igImTextCountUtf8BytesFromStr, libcimgui), Cint, (Ptr{ImWchar}, Ptr{ImWchar}), in_text, in_text_end)
end

function igImFileOpen(filename, mode)
    ccall((:igImFileOpen, libcimgui), ImFileHandle, (Cstring, Cstring), filename, mode)
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
    ccall((:igImFileLoadToMemory, libcimgui), Ptr{Cvoid}, (Cstring, Cstring, Ptr{Csize_t}, Cint), filename, mode, out_file_size, padding_bytes)
end

function igImPowFloat(x, y)
    ccall((:igImPowFloat, libcimgui), Cfloat, (Cfloat, Cfloat), x, y)
end

function igImPowdouble(x, y)
    ccall((:igImPowdouble, libcimgui), Cdouble, (Cdouble, Cdouble), x, y)
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

function igImBezierCalc(pOut, p1, p2, p3, p4, t)
    ccall((:igImBezierCalc, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2, ImVec2, ImVec2, ImVec2, Cfloat), pOut, p1, p2, p3, p4, t)
end

function igImBezierClosestPoint(pOut, p1, p2, p3, p4, p, num_segments)
    ccall((:igImBezierClosestPoint, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2, ImVec2, ImVec2, ImVec2, ImVec2, Cint), pOut, p1, p2, p3, p4, p, num_segments)
end

function igImBezierClosestPointCasteljau(pOut, p1, p2, p3, p4, p, tess_tol)
    ccall((:igImBezierClosestPointCasteljau, libcimgui), Cvoid, (Ptr{ImVec2}, ImVec2, ImVec2, ImVec2, ImVec2, ImVec2, Cfloat), pOut, p1, p2, p3, p4, p, tess_tol)
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
    ccall((:igImTriangleBarycentricCoords, libcimgui), Cvoid, (ImVec2, ImVec2, ImVec2, ImVec2, Cfloat, Cfloat, Cfloat), a, b, c, p, out_u, out_v, out_w)
end

function igImTriangleArea(a, b, c)
    ccall((:igImTriangleArea, libcimgui), Cfloat, (ImVec2, ImVec2, ImVec2), a, b, c)
end

function igImGetDirQuadrantFromDelta(dx, dy)
    ccall((:igImGetDirQuadrantFromDelta, libcimgui), ImGuiDir, (Cfloat, Cfloat), dx, dy)
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
    ccall((:ImVec2ih_ImVec2ihshort, libcimgui), Ptr{ImVec2ih}, (Int16, Int16), _x, _y)
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

function ImGuiWindowSettings_ImGuiWindowSettings()
    ccall((:ImGuiWindowSettings_ImGuiWindowSettings, libcimgui), Ptr{ImGuiWindowSettings}, ())
end

function ImGuiWindowSettings_destroy(self)
    ccall((:ImGuiWindowSettings_destroy, libcimgui), Cvoid, (Ptr{ImGuiWindowSettings},), self)
end

function ImGuiWindowSettings_GetName(self)
    ccall((:ImGuiWindowSettings_GetName, libcimgui), Cstring, (Ptr{ImGuiWindowSettings},), self)
end

function ImGuiSettingsHandler_ImGuiSettingsHandler()
    ccall((:ImGuiSettingsHandler_ImGuiSettingsHandler, libcimgui), Ptr{ImGuiSettingsHandler}, ())
end

function ImGuiSettingsHandler_destroy(self)
    ccall((:ImGuiSettingsHandler_destroy, libcimgui), Cvoid, (Ptr{ImGuiSettingsHandler},), self)
end

function ImGuiPopupData_ImGuiPopupData()
    ccall((:ImGuiPopupData_ImGuiPopupData, libcimgui), Ptr{ImGuiPopupData}, ())
end

function ImGuiPopupData_destroy(self)
    ccall((:ImGuiPopupData_destroy, libcimgui), Cvoid, (Ptr{ImGuiPopupData},), self)
end

function ImGuiColumnData_ImGuiColumnData()
    ccall((:ImGuiColumnData_ImGuiColumnData, libcimgui), Ptr{ImGuiColumnData}, ())
end

function ImGuiColumnData_destroy(self)
    ccall((:ImGuiColumnData_destroy, libcimgui), Cvoid, (Ptr{ImGuiColumnData},), self)
end

function ImGuiColumns_ImGuiColumns()
    ccall((:ImGuiColumns_ImGuiColumns, libcimgui), Ptr{ImGuiColumns}, ())
end

function ImGuiColumns_destroy(self)
    ccall((:ImGuiColumns_destroy, libcimgui), Cvoid, (Ptr{ImGuiColumns},), self)
end

function ImGuiColumns_Clear(self)
    ccall((:ImGuiColumns_Clear, libcimgui), Cvoid, (Ptr{ImGuiColumns},), self)
end

function ImDrawListSharedData_ImDrawListSharedData()
    ccall((:ImDrawListSharedData_ImDrawListSharedData, libcimgui), Ptr{ImDrawListSharedData}, ())
end

function ImDrawListSharedData_destroy(self)
    ccall((:ImDrawListSharedData_destroy, libcimgui), Cvoid, (Ptr{ImDrawListSharedData},), self)
end

function ImDrawListSharedData_SetCircleSegmentMaxError(self, max_error)
    ccall((:ImDrawListSharedData_SetCircleSegmentMaxError, libcimgui), Cvoid, (Ptr{ImDrawListSharedData}, Cfloat), self, max_error)
end

function ImDrawDataBuilder_Clear(self)
    ccall((:ImDrawDataBuilder_Clear, libcimgui), Cvoid, (Ptr{ImDrawDataBuilder},), self)
end

function ImDrawDataBuilder_ClearFreeMemory(self)
    ccall((:ImDrawDataBuilder_ClearFreeMemory, libcimgui), Cvoid, (Ptr{ImDrawDataBuilder},), self)
end

function ImDrawDataBuilder_FlattenIntoSingleLayer(self)
    ccall((:ImDrawDataBuilder_FlattenIntoSingleLayer, libcimgui), Cvoid, (Ptr{ImDrawDataBuilder},), self)
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

function ImGuiContext_ImGuiContext(shared_font_atlas)
    ccall((:ImGuiContext_ImGuiContext, libcimgui), Ptr{ImGuiContext}, (Ptr{ImFontAtlas},), shared_font_atlas)
end

function ImGuiContext_destroy(self)
    ccall((:ImGuiContext_destroy, libcimgui), Cvoid, (Ptr{ImGuiContext},), self)
end

function ImGuiWindowTempData_ImGuiWindowTempData()
    ccall((:ImGuiWindowTempData_ImGuiWindowTempData, libcimgui), Ptr{ImGuiWindowTempData}, ())
end

function ImGuiWindowTempData_destroy(self)
    ccall((:ImGuiWindowTempData_destroy, libcimgui), Cvoid, (Ptr{ImGuiWindowTempData},), self)
end

function ImGuiWindow_ImGuiWindow(context, name)
    ccall((:ImGuiWindow_ImGuiWindow, libcimgui), Ptr{ImGuiWindow}, (Ptr{ImGuiContext}, Cstring), context, name)
end

function ImGuiWindow_destroy(self)
    ccall((:ImGuiWindow_destroy, libcimgui), Cvoid, (Ptr{ImGuiWindow},), self)
end

function ImGuiWindow_GetIDStr(self, str, str_end)
    ccall((:ImGuiWindow_GetIDStr, libcimgui), ImGuiID, (Ptr{ImGuiWindow}, Cstring, Cstring), self, str, str_end)
end

function ImGuiWindow_GetIDPtr(self, ptr)
    ccall((:ImGuiWindow_GetIDPtr, libcimgui), ImGuiID, (Ptr{ImGuiWindow}, Ptr{Cvoid}), self, ptr)
end

function ImGuiWindow_GetIDInt(self, n)
    ccall((:ImGuiWindow_GetIDInt, libcimgui), ImGuiID, (Ptr{ImGuiWindow}, Cint), self, n)
end

function ImGuiWindow_GetIDNoKeepAliveStr(self, str, str_end)
    ccall((:ImGuiWindow_GetIDNoKeepAliveStr, libcimgui), ImGuiID, (Ptr{ImGuiWindow}, Cstring, Cstring), self, str, str_end)
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

function ImGuiItemHoveredDataBackup_ImGuiItemHoveredDataBackup()
    ccall((:ImGuiItemHoveredDataBackup_ImGuiItemHoveredDataBackup, libcimgui), Ptr{ImGuiItemHoveredDataBackup}, ())
end

function ImGuiItemHoveredDataBackup_destroy(self)
    ccall((:ImGuiItemHoveredDataBackup_destroy, libcimgui), Cvoid, (Ptr{ImGuiItemHoveredDataBackup},), self)
end

function ImGuiItemHoveredDataBackup_Backup(self)
    ccall((:ImGuiItemHoveredDataBackup_Backup, libcimgui), Cvoid, (Ptr{ImGuiItemHoveredDataBackup},), self)
end

function ImGuiItemHoveredDataBackup_Restore(self)
    ccall((:ImGuiItemHoveredDataBackup_Restore, libcimgui), Cvoid, (Ptr{ImGuiItemHoveredDataBackup},), self)
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
    ccall((:ImGuiTabBar_GetTabName, libcimgui), Cstring, (Ptr{ImGuiTabBar}, Ptr{ImGuiTabItem}), self, tab)
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
    ccall((:igFindWindowByName, libcimgui), Ptr{ImGuiWindow}, (Cstring,), name)
end

function igUpdateWindowParentAndRootLinks(window, flags, parent_window)
    ccall((:igUpdateWindowParentAndRootLinks, libcimgui), Cvoid, (Ptr{ImGuiWindow}, ImGuiWindowFlags, Ptr{ImGuiWindow}), window, flags, parent_window)
end

function igCalcWindowExpectedSize(pOut, window)
    ccall((:igCalcWindowExpectedSize, libcimgui), Cvoid, (Ptr{ImVec2}, Ptr{ImGuiWindow}), pOut, window)
end

function igIsWindowChildOf(window, potential_parent)
    ccall((:igIsWindowChildOf, libcimgui), Bool, (Ptr{ImGuiWindow}, Ptr{ImGuiWindow}), window, potential_parent)
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

function igMarkIniSettingsDirtyNil()
    ccall((:igMarkIniSettingsDirtyNil, libcimgui), Cvoid, ())
end

function igMarkIniSettingsDirtyWindowPtr(window)
    ccall((:igMarkIniSettingsDirtyWindowPtr, libcimgui), Cvoid, (Ptr{ImGuiWindow},), window)
end

function igCreateNewWindowSettings(name)
    ccall((:igCreateNewWindowSettings, libcimgui), Ptr{ImGuiWindowSettings}, (Cstring,), name)
end

function igFindWindowSettings(id)
    ccall((:igFindWindowSettings, libcimgui), Ptr{ImGuiWindowSettings}, (ImGuiID,), id)
end

function igFindOrCreateWindowSettings(name)
    ccall((:igFindOrCreateWindowSettings, libcimgui), Ptr{ImGuiWindowSettings}, (Cstring,), name)
end

function igFindSettingsHandler(type_name)
    ccall((:igFindSettingsHandler, libcimgui), Ptr{ImGuiSettingsHandler}, (Cstring,), type_name)
end

function igSetScrollXWindowPtr(window, new_scroll_x)
    ccall((:igSetScrollXWindowPtr, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Cfloat), window, new_scroll_x)
end

function igSetScrollYWindowPtr(window, new_scroll_y)
    ccall((:igSetScrollYWindowPtr, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Cfloat), window, new_scroll_y)
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

function igBeginChildEx(name, id, size_arg, border, flags)
    ccall((:igBeginChildEx, libcimgui), Bool, (Cstring, ImGuiID, ImVec2, Bool, ImGuiWindowFlags), name, id, size_arg, border, flags)
end

function igOpenPopupEx(id)
    ccall((:igOpenPopupEx, libcimgui), Cvoid, (ImGuiID,), id)
end

function igClosePopupToLevel(remaining, restore_focus_to_window_under_popup)
    ccall((:igClosePopupToLevel, libcimgui), Cvoid, (Cint, Bool), remaining, restore_focus_to_window_under_popup)
end

function igClosePopupsOverWindow(ref_window, restore_focus_to_window_under_popup)
    ccall((:igClosePopupsOverWindow, libcimgui), Cvoid, (Ptr{ImGuiWindow}, Bool), ref_window, restore_focus_to_window_under_popup)
end

function igIsPopupOpenID(id)
    ccall((:igIsPopupOpenID, libcimgui), Bool, (ImGuiID,), id)
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

function igSetNavID(id, nav_layer, focus_scope_id)
    ccall((:igSetNavID, libcimgui), Cvoid, (ImGuiID, Cint, ImGuiID), id, nav_layer, focus_scope_id)
end

function igSetNavIDWithRectRel(id, nav_layer, focus_scope_id, rect_rel)
    ccall((:igSetNavIDWithRectRel, libcimgui), Cvoid, (ImGuiID, Cint, ImGuiID, ImRect), id, nav_layer, focus_scope_id, rect_rel)
end

function igPushFocusScope(id)
    ccall((:igPushFocusScope, libcimgui), Cvoid, (ImGuiID,), id)
end

function igPopFocusScope()
    ccall((:igPopFocusScope, libcimgui), Cvoid, ())
end

function igGetFocusScopeID()
    ccall((:igGetFocusScopeID, libcimgui), ImGuiID, ())
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

function igBeginColumns(str_id, count, flags)
    ccall((:igBeginColumns, libcimgui), Cvoid, (Cstring, Cint, ImGuiColumnsFlags), str_id, count, flags)
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
    ccall((:igGetColumnsID, libcimgui), ImGuiID, (Cstring, Cint), str_id, count)
end

function igFindOrCreateColumns(window, id)
    ccall((:igFindOrCreateColumns, libcimgui), Ptr{ImGuiColumns}, (Ptr{ImGuiWindow}, ImGuiID), window, id)
end

function igGetColumnOffsetFromNorm(columns, offset_norm)
    ccall((:igGetColumnOffsetFromNorm, libcimgui), Cfloat, (Ptr{ImGuiColumns}, Cfloat), columns, offset_norm)
end

function igGetColumnNormFromOffset(columns, offset)
    ccall((:igGetColumnNormFromOffset, libcimgui), Cfloat, (Ptr{ImGuiColumns}, Cfloat), columns, offset)
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

function igTabBarQueueChangeTabOrder(tab_bar, tab, dir)
    ccall((:igTabBarQueueChangeTabOrder, libcimgui), Cvoid, (Ptr{ImGuiTabBar}, Ptr{ImGuiTabItem}, Cint), tab_bar, tab, dir)
end

function igTabItemEx(tab_bar, label, p_open, flags)
    ccall((:igTabItemEx, libcimgui), Bool, (Ptr{ImGuiTabBar}, Cstring, Ptr{Bool}, ImGuiTabItemFlags), tab_bar, label, p_open, flags)
end

function igTabItemCalcSize(pOut, label, has_close_button)
    ccall((:igTabItemCalcSize, libcimgui), Cvoid, (Ptr{ImVec2}, Cstring, Bool), pOut, label, has_close_button)
end

function igTabItemBackground(draw_list, bb, flags, col)
    ccall((:igTabItemBackground, libcimgui), Cvoid, (Ptr{ImDrawList}, ImRect, ImGuiTabItemFlags, ImU32), draw_list, bb, flags, col)
end

function igTabItemLabelAndCloseButton(draw_list, bb, flags, frame_padding, label, tab_id, close_button_id)
    ccall((:igTabItemLabelAndCloseButton, libcimgui), Bool, (Ptr{ImDrawList}, ImRect, ImGuiTabItemFlags, ImVec2, Cstring, ImGuiID, ImGuiID), draw_list, bb, flags, frame_padding, label, tab_id, close_button_id)
end

function igRenderText(pos, text, text_end, hide_text_after_hash)
    ccall((:igRenderText, libcimgui), Cvoid, (ImVec2, Cstring, Cstring, Bool), pos, text, text_end, hide_text_after_hash)
end

function igRenderTextWrapped(pos, text, text_end, wrap_width)
    ccall((:igRenderTextWrapped, libcimgui), Cvoid, (ImVec2, Cstring, Cstring, Cfloat), pos, text, text_end, wrap_width)
end

function igRenderTextClipped(pos_min, pos_max, text, text_end, text_size_if_known, align, clip_rect)
    ccall((:igRenderTextClipped, libcimgui), Cvoid, (ImVec2, ImVec2, Cstring, Cstring, Ptr{ImVec2}, ImVec2, Ptr{ImRect}), pos_min, pos_max, text, text_end, text_size_if_known, align, clip_rect)
end

function igRenderTextClippedEx(draw_list, pos_min, pos_max, text, text_end, text_size_if_known, align, clip_rect)
    ccall((:igRenderTextClippedEx, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, Cstring, Cstring, Ptr{ImVec2}, ImVec2, Ptr{ImRect}), draw_list, pos_min, pos_max, text, text_end, text_size_if_known, align, clip_rect)
end

function igRenderTextEllipsis(draw_list, pos_min, pos_max, clip_max_x, ellipsis_max_x, text, text_end, text_size_if_known)
    ccall((:igRenderTextEllipsis, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, Cfloat, Cfloat, Cstring, Cstring, Ptr{ImVec2}), draw_list, pos_min, pos_max, clip_max_x, ellipsis_max_x, text, text_end, text_size_if_known)
end

function igRenderFrame(p_min, p_max, fill_col, border, rounding)
    ccall((:igRenderFrame, libcimgui), Cvoid, (ImVec2, ImVec2, ImU32, Bool, Cfloat), p_min, p_max, fill_col, border, rounding)
end

function igRenderFrameBorder(p_min, p_max, rounding)
    ccall((:igRenderFrameBorder, libcimgui), Cvoid, (ImVec2, ImVec2, Cfloat), p_min, p_max, rounding)
end

function igRenderColorRectWithAlphaCheckerboard(draw_list, p_min, p_max, fill_col, grid_step, grid_off, rounding, rounding_corners_flags)
    ccall((:igRenderColorRectWithAlphaCheckerboard, libcimgui), Cvoid, (Ptr{ImDrawList}, ImVec2, ImVec2, ImU32, Cfloat, ImVec2, Cfloat, Cint), draw_list, p_min, p_max, fill_col, grid_step, grid_off, rounding, rounding_corners_flags)
end

function igRenderNavHighlight(bb, id, flags)
    ccall((:igRenderNavHighlight, libcimgui), Cvoid, (ImRect, ImGuiID, ImGuiNavHighlightFlags), bb, id, flags)
end

function igFindRenderedTextEnd(text, text_end)
    ccall((:igFindRenderedTextEnd, libcimgui), Cstring, (Cstring, Cstring), text, text_end)
end

function igLogRenderedText(ref_pos, text, text_end)
    ccall((:igLogRenderedText, libcimgui), Cvoid, (Ptr{ImVec2}, Cstring, Cstring), ref_pos, text, text_end)
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

function igTextEx(text, text_end, flags)
    ccall((:igTextEx, libcimgui), Cvoid, (Cstring, Cstring, ImGuiTextFlags), text, text_end, flags)
end

function igButtonEx(label, size_arg, flags)
    ccall((:igButtonEx, libcimgui), Bool, (Cstring, ImVec2, ImGuiButtonFlags), label, size_arg, flags)
end

function igCloseButton(id, pos)
    ccall((:igCloseButton, libcimgui), Bool, (ImGuiID, ImVec2), id, pos)
end

function igCollapseButton(id, pos)
    ccall((:igCollapseButton, libcimgui), Bool, (ImGuiID, ImVec2), id, pos)
end

function igArrowButtonEx(str_id, dir, size_arg, flags)
    ccall((:igArrowButtonEx, libcimgui), Bool, (Cstring, ImGuiDir, ImVec2, ImGuiButtonFlags), str_id, dir, size_arg, flags)
end

function igScrollbar(axis)
    ccall((:igScrollbar, libcimgui), Cvoid, (ImGuiAxis,), axis)
end

function igScrollbarEx(bb, id, axis, p_scroll_v, avail_v, contents_v, rounding_corners)
    ccall((:igScrollbarEx, libcimgui), Bool, (ImRect, ImGuiID, ImGuiAxis, Ptr{Cfloat}, Cfloat, Cfloat, ImDrawCornerFlags), bb, id, axis, p_scroll_v, avail_v, contents_v, rounding_corners)
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

function igButtonBehavior(bb, id, out_hovered, out_held, flags)
    ccall((:igButtonBehavior, libcimgui), Bool, (ImRect, ImGuiID, Ptr{Bool}, Ptr{Bool}, ImGuiButtonFlags), bb, id, out_hovered, out_held, flags)
end

function igDragBehavior(id, data_type, p_v, v_speed, p_min, p_max, format, power, flags)
    ccall((:igDragBehavior, libcimgui), Bool, (ImGuiID, ImGuiDataType, Ptr{Cvoid}, Cfloat, Ptr{Cvoid}, Ptr{Cvoid}, Cstring, Cfloat, ImGuiDragFlags), id, data_type, p_v, v_speed, p_min, p_max, format, power, flags)
end

function igSliderBehavior(bb, id, data_type, p_v, p_min, p_max, format, power, flags, out_grab_bb)
    ccall((:igSliderBehavior, libcimgui), Bool, (ImRect, ImGuiID, ImGuiDataType, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Cstring, Cfloat, ImGuiSliderFlags, Ptr{ImRect}), bb, id, data_type, p_v, p_min, p_max, format, power, flags, out_grab_bb)
end

function igSplitterBehavior(bb, id, axis, size1, size2, min_size1, min_size2, hover_extend, hover_visibility_delay)
    ccall((:igSplitterBehavior, libcimgui), Bool, (ImRect, ImGuiID, ImGuiAxis, Ptr{Cfloat}, Ptr{Cfloat}, Cfloat, Cfloat, Cfloat, Cfloat), bb, id, axis, size1, size2, min_size1, min_size2, hover_extend, hover_visibility_delay)
end

function igTreeNodeBehavior(id, flags, label, label_end)
    ccall((:igTreeNodeBehavior, libcimgui), Bool, (ImGuiID, ImGuiTreeNodeFlags, Cstring, Cstring), id, flags, label, label_end)
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
    ccall((:igDataTypeFormatString, libcimgui), Cint, (Cstring, Cint, ImGuiDataType, Ptr{Cvoid}, Cstring), buf, buf_size, data_type, p_data, format)
end

function igDataTypeApplyOp(data_type, op, output, arg_1, arg_2)
    ccall((:igDataTypeApplyOp, libcimgui), Cvoid, (ImGuiDataType, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}), data_type, op, output, arg_1, arg_2)
end

function igDataTypeApplyOpFromText(buf, initial_value_buf, data_type, p_data, format)
    ccall((:igDataTypeApplyOpFromText, libcimgui), Bool, (Cstring, Cstring, ImGuiDataType, Ptr{Cvoid}, Cstring), buf, initial_value_buf, data_type, p_data, format)
end

function igInputTextEx(label, hint, buf, buf_size, size_arg, flags, callback, user_data)
    ccall((:igInputTextEx, libcimgui), Bool, (Cstring, Cstring, Cstring, Cint, ImVec2, ImGuiInputTextFlags, ImGuiInputTextCallback, Ptr{Cvoid}), label, hint, buf, buf_size, size_arg, flags, callback, user_data)
end

function igTempInputText(bb, id, label, buf, buf_size, flags)
    ccall((:igTempInputText, libcimgui), Bool, (ImRect, ImGuiID, Cstring, Cstring, Cint, ImGuiInputTextFlags), bb, id, label, buf, buf_size, flags)
end

function igTempInputScalar(bb, id, label, data_type, p_data, format)
    ccall((:igTempInputScalar, libcimgui), Bool, (ImRect, ImGuiID, Cstring, ImGuiDataType, Ptr{Cvoid}, Cstring), bb, id, label, data_type, p_data, format)
end

function igTempInputIsActive(id)
    ccall((:igTempInputIsActive, libcimgui), Bool, (ImGuiID,), id)
end

function igGetInputTextState(id)
    ccall((:igGetInputTextState, libcimgui), Ptr{ImGuiInputTextState}, (ImGuiID,), id)
end

function igColorTooltip(text, col, flags)
    ccall((:igColorTooltip, libcimgui), Cvoid, (Cstring, Ptr{Cfloat}, ImGuiColorEditFlags), text, col, flags)
end

function igColorEditOptionsPopup(col, flags)
    ccall((:igColorEditOptionsPopup, libcimgui), Cvoid, (Ptr{Cfloat}, ImGuiColorEditFlags), col, flags)
end

function igColorPickerOptionsPopup(ref_col, flags)
    ccall((:igColorPickerOptionsPopup, libcimgui), Cvoid, (Ptr{Cfloat}, ImGuiColorEditFlags), ref_col, flags)
end

function igPlotEx(plot_type, label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, frame_size)
    ccall((:igPlotEx, libcimgui), Cint, (ImGuiPlotType, Cstring, Ptr{Cvoid}, Ptr{Cvoid}, Cint, Cint, Cstring, Cfloat, Cfloat, ImVec2), plot_type, label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, frame_size)
end

function igShadeVertsLinearColorGradientKeepAlpha(draw_list, vert_start_idx, vert_end_idx, gradient_p0, gradient_p1, col0, col1)
    ccall((:igShadeVertsLinearColorGradientKeepAlpha, libcimgui), Cvoid, (Ptr{ImDrawList}, Cint, Cint, ImVec2, ImVec2, ImU32, ImU32), draw_list, vert_start_idx, vert_end_idx, gradient_p0, gradient_p1, col0, col1)
end

function igShadeVertsLinearUV(draw_list, vert_start_idx, vert_end_idx, a, b, uv_a, uv_b, clamp)
    ccall((:igShadeVertsLinearUV, libcimgui), Cvoid, (Ptr{ImDrawList}, Cint, Cint, ImVec2, ImVec2, ImVec2, ImVec2, Bool), draw_list, vert_start_idx, vert_end_idx, a, b, uv_a, uv_b, clamp)
end

function igGcCompactTransientWindowBuffers(window)
    ccall((:igGcCompactTransientWindowBuffers, libcimgui), Cvoid, (Ptr{ImGuiWindow},), window)
end

function igGcAwakeTransientWindowBuffers(window)
    ccall((:igGcAwakeTransientWindowBuffers, libcimgui), Cvoid, (Ptr{ImGuiWindow},), window)
end

function igDebugDrawItemRect(col)
    ccall((:igDebugDrawItemRect, libcimgui), Cvoid, (ImU32,), col)
end

function igDebugStartItemPicker()
    ccall((:igDebugStartItemPicker, libcimgui), Cvoid, ())
end

function igImFontAtlasBuildWithStbTruetype(atlas)
    ccall((:igImFontAtlasBuildWithStbTruetype, libcimgui), Bool, (Ptr{ImFontAtlas},), atlas)
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

function igImFontAtlasBuildMultiplyCalcLookupTable(out_table, in_multiply_factor)
    ccall((:igImFontAtlasBuildMultiplyCalcLookupTable, libcimgui), Cvoid, (Ptr{Cuchar}, Cfloat), out_table, in_multiply_factor)
end

function igImFontAtlasBuildMultiplyRectAlpha8(table, pixels, x, y, w, h, stride)
    ccall((:igImFontAtlasBuildMultiplyRectAlpha8, libcimgui), Cvoid, (Ptr{Cuchar}, Ptr{Cuchar}, Cint, Cint, Cint, Cint, Cint), table, pixels, x, y, w, h, stride)
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

function ImVector_ImWchar_destroy(self)
    ccall((:ImVector_ImWchar_destroy, libcimgui), Cvoid, (Ptr{ImVector_ImWchar},), self)
end

function ImVector_ImWchar_Init(p)
    ccall((:ImVector_ImWchar_Init, libcimgui), Cvoid, (Ptr{ImVector_ImWchar},), p)
end

function ImVector_ImWchar_UnInit(p)
    ccall((:ImVector_ImWchar_UnInit, libcimgui), Cvoid, (Ptr{ImVector_ImWchar},), p)
end
