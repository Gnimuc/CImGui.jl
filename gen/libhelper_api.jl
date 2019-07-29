# Julia wrapper for header: helper.h
# Automatically generated using Clang.jl


function ImGuiIO_Get_ConfigFlags(io)
    ccall((:ImGuiIO_Get_ConfigFlags, libcimgui_helper), ImGuiConfigFlags, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_BackendFlags(io)
    ccall((:ImGuiIO_Get_BackendFlags, libcimgui_helper), ImGuiBackendFlags, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_DisplaySize(io)
    ccall((:ImGuiIO_Get_DisplaySize, libcimgui_helper), ImVec2, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_DeltaTime(io)
    ccall((:ImGuiIO_Get_DeltaTime, libcimgui_helper), Cfloat, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_IniSavingRate(io)
    ccall((:ImGuiIO_Get_IniSavingRate, libcimgui_helper), Cfloat, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_IniFilename(io)
    ccall((:ImGuiIO_Get_IniFilename, libcimgui_helper), Cstring, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_LogFilename(io)
    ccall((:ImGuiIO_Get_LogFilename, libcimgui_helper), Cstring, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_MouseDoubleClickTime(io)
    ccall((:ImGuiIO_Get_MouseDoubleClickTime, libcimgui_helper), Cfloat, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_MouseDoubleClickMaxDist(io)
    ccall((:ImGuiIO_Get_MouseDoubleClickMaxDist, libcimgui_helper), Cfloat, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_MouseDragThreshold(io)
    ccall((:ImGuiIO_Get_MouseDragThreshold, libcimgui_helper), Cfloat, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_KeyMap(io, i)
    ccall((:ImGuiIO_Get_KeyMap, libcimgui_helper), Cint, (Ptr{ImGuiIO}, Cint), io, i)
end

function ImGuiIO_Get_KeyRepeatDelay(io)
    ccall((:ImGuiIO_Get_KeyRepeatDelay, libcimgui_helper), Cfloat, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_KeyRepeatRate(io)
    ccall((:ImGuiIO_Get_KeyRepeatRate, libcimgui_helper), Cfloat, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_UserData(io)
    ccall((:ImGuiIO_Get_UserData, libcimgui_helper), Ptr{Cvoid}, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_Fonts(io)
    ccall((:ImGuiIO_Get_Fonts, libcimgui_helper), Ptr{ImFontAtlas}, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_FontGlobalScale(io)
    ccall((:ImGuiIO_Get_FontGlobalScale, libcimgui_helper), Cfloat, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_FontAllowUserScaling(io)
    ccall((:ImGuiIO_Get_FontAllowUserScaling, libcimgui_helper), Bool, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_FontDefault(io)
    ccall((:ImGuiIO_Get_FontDefault, libcimgui_helper), Ptr{ImFont}, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_DisplayFramebufferScale(io)
    ccall((:ImGuiIO_Get_DisplayFramebufferScale, libcimgui_helper), ImVec2, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_MouseDrawCursor(io)
    ccall((:ImGuiIO_Get_MouseDrawCursor, libcimgui_helper), Bool, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_ConfigMacOSXBehaviors(io)
    ccall((:ImGuiIO_Get_ConfigMacOSXBehaviors, libcimgui_helper), Bool, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_ConfigInputTextCursorBlink(io)
    ccall((:ImGuiIO_Get_ConfigInputTextCursorBlink, libcimgui_helper), Bool, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_ConfigWindowsResizeFromEdges(io)
    ccall((:ImGuiIO_Get_ConfigWindowsResizeFromEdges, libcimgui_helper), Bool, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_ConfigWindowsMoveFromTitleBarOnly(io)
    ccall((:ImGuiIO_Get_ConfigWindowsMoveFromTitleBarOnly, libcimgui_helper), Bool, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_BackendPlatformName(io)
    ccall((:ImGuiIO_Get_BackendPlatformName, libcimgui_helper), Cstring, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_BackendRendererName(io)
    ccall((:ImGuiIO_Get_BackendRendererName, libcimgui_helper), Cstring, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_BackendPlatformUserData(io)
    ccall((:ImGuiIO_Get_BackendPlatformUserData, libcimgui_helper), Ptr{Cvoid}, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_BackendRendererUserData(io)
    ccall((:ImGuiIO_Get_BackendRendererUserData, libcimgui_helper), Ptr{Cvoid}, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_BackendLanguageUserData(io)
    ccall((:ImGuiIO_Get_BackendLanguageUserData, libcimgui_helper), Ptr{Cvoid}, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_ImeWindowHandle(io)
    ccall((:ImGuiIO_Get_ImeWindowHandle, libcimgui_helper), Ptr{Cvoid}, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_RenderDrawListsFnUnused(io)
    ccall((:ImGuiIO_Get_RenderDrawListsFnUnused, libcimgui_helper), Ptr{Cvoid}, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_MousePos(io)
    ccall((:ImGuiIO_Get_MousePos, libcimgui_helper), ImVec2, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_MouseDown(io, i)
    ccall((:ImGuiIO_Get_MouseDown, libcimgui_helper), Bool, (Ptr{ImGuiIO}, Cint), io, i)
end

function ImGuiIO_Get_MouseWheel(io)
    ccall((:ImGuiIO_Get_MouseWheel, libcimgui_helper), Cfloat, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_MouseWheelH(io)
    ccall((:ImGuiIO_Get_MouseWheelH, libcimgui_helper), Cfloat, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_KeyCtrl(io)
    ccall((:ImGuiIO_Get_KeyCtrl, libcimgui_helper), Bool, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_KeyShift(io)
    ccall((:ImGuiIO_Get_KeyShift, libcimgui_helper), Bool, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_KeyAlt(io)
    ccall((:ImGuiIO_Get_KeyAlt, libcimgui_helper), Bool, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_KeySuper(io)
    ccall((:ImGuiIO_Get_KeySuper, libcimgui_helper), Bool, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_KeysDown(io, i)
    ccall((:ImGuiIO_Get_KeysDown, libcimgui_helper), Bool, (Ptr{ImGuiIO}, Cint), io, i)
end

function ImGuiIO_Get_NavInputs(io, i)
    ccall((:ImGuiIO_Get_NavInputs, libcimgui_helper), Cfloat, (Ptr{ImGuiIO}, Cint), io, i)
end

function ImGuiIO_Get_WantCaptureMouse(io)
    ccall((:ImGuiIO_Get_WantCaptureMouse, libcimgui_helper), Bool, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_WantCaptureKeyboard(io)
    ccall((:ImGuiIO_Get_WantCaptureKeyboard, libcimgui_helper), Bool, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_WantTextInput(io)
    ccall((:ImGuiIO_Get_WantTextInput, libcimgui_helper), Bool, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_WantSetMousePos(io)
    ccall((:ImGuiIO_Get_WantSetMousePos, libcimgui_helper), Bool, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_WantSaveIniSettings(io)
    ccall((:ImGuiIO_Get_WantSaveIniSettings, libcimgui_helper), Bool, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_NavActive(io)
    ccall((:ImGuiIO_Get_NavActive, libcimgui_helper), Bool, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_NavVisible(io)
    ccall((:ImGuiIO_Get_NavVisible, libcimgui_helper), Bool, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_Framerate(io)
    ccall((:ImGuiIO_Get_Framerate, libcimgui_helper), Cfloat, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_MetricsRenderVertices(io)
    ccall((:ImGuiIO_Get_MetricsRenderVertices, libcimgui_helper), Cint, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_MetricsRenderIndices(io)
    ccall((:ImGuiIO_Get_MetricsRenderIndices, libcimgui_helper), Cint, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_MetricsRenderWindows(io)
    ccall((:ImGuiIO_Get_MetricsRenderWindows, libcimgui_helper), Cint, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_MetricsActiveWindows(io)
    ccall((:ImGuiIO_Get_MetricsActiveWindows, libcimgui_helper), Cint, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_MetricsActiveAllocations(io)
    ccall((:ImGuiIO_Get_MetricsActiveAllocations, libcimgui_helper), Cint, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_MouseDelta(io)
    ccall((:ImGuiIO_Get_MouseDelta, libcimgui_helper), ImVec2, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_MousePosPrev(io)
    ccall((:ImGuiIO_Get_MousePosPrev, libcimgui_helper), ImVec2, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Get_MouseClickedPos(io, i)
    ccall((:ImGuiIO_Get_MouseClickedPos, libcimgui_helper), ImVec2, (Ptr{ImGuiIO}, Cint), io, i)
end

function ImGuiIO_Get_MouseClickedTime(io, i)
    ccall((:ImGuiIO_Get_MouseClickedTime, libcimgui_helper), Cdouble, (Ptr{ImGuiIO}, Cint), io, i)
end

function ImGuiIO_Get_MouseClicked(io, i)
    ccall((:ImGuiIO_Get_MouseClicked, libcimgui_helper), Bool, (Ptr{ImGuiIO}, Cint), io, i)
end

function ImGuiIO_Get_MouseDoubleClicked(io, i)
    ccall((:ImGuiIO_Get_MouseDoubleClicked, libcimgui_helper), Bool, (Ptr{ImGuiIO}, Cint), io, i)
end

function ImGuiIO_Get_MouseReleased(io, i)
    ccall((:ImGuiIO_Get_MouseReleased, libcimgui_helper), Bool, (Ptr{ImGuiIO}, Cint), io, i)
end

function ImGuiIO_Get_MouseDownOwned(io, i)
    ccall((:ImGuiIO_Get_MouseDownOwned, libcimgui_helper), Bool, (Ptr{ImGuiIO}, Cint), io, i)
end

function ImGuiIO_Get_MouseDownDuration(io, i)
    ccall((:ImGuiIO_Get_MouseDownDuration, libcimgui_helper), Cfloat, (Ptr{ImGuiIO}, Cint), io, i)
end

function ImGuiIO_Get_MouseDownDurationPrev(io, i)
    ccall((:ImGuiIO_Get_MouseDownDurationPrev, libcimgui_helper), Cfloat, (Ptr{ImGuiIO}, Cint), io, i)
end

function ImGuiIO_Get_MouseDragMaxDistanceAbs(io, i)
    ccall((:ImGuiIO_Get_MouseDragMaxDistanceAbs, libcimgui_helper), ImVec2, (Ptr{ImGuiIO}, Cint), io, i)
end

function ImGuiIO_Get_MouseDragMaxDistanceSqr(io, i)
    ccall((:ImGuiIO_Get_MouseDragMaxDistanceSqr, libcimgui_helper), Cfloat, (Ptr{ImGuiIO}, Cint), io, i)
end

function ImGuiIO_Get_KeysDownDuration(io, i)
    ccall((:ImGuiIO_Get_KeysDownDuration, libcimgui_helper), Cfloat, (Ptr{ImGuiIO}, Cint), io, i)
end

function ImGuiIO_Get_KeysDownDurationPrev(io, i)
    ccall((:ImGuiIO_Get_KeysDownDurationPrev, libcimgui_helper), Cfloat, (Ptr{ImGuiIO}, Cint), io, i)
end

function ImGuiIO_Get_NavInputsDownDuration(io, i)
    ccall((:ImGuiIO_Get_NavInputsDownDuration, libcimgui_helper), Cfloat, (Ptr{ImGuiIO}, Cint), io, i)
end

function ImGuiIO_Get_NavInputsDownDurationPrev(io, i)
    ccall((:ImGuiIO_Get_NavInputsDownDurationPrev, libcimgui_helper), Cfloat, (Ptr{ImGuiIO}, Cint), io, i)
end

function ImGuiIO_Get_InputQueueCharacters(io)
    ccall((:ImGuiIO_Get_InputQueueCharacters, libcimgui_helper), ImVector_ImWchar, (Ptr{ImGuiIO},), io)
end

function ImGuiIO_Set_ConfigFlags(io, x)
    ccall((:ImGuiIO_Set_ConfigFlags, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, ImGuiConfigFlags), io, x)
end

function ImGuiIO_Set_BackendFlags(io, x)
    ccall((:ImGuiIO_Set_BackendFlags, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, ImGuiBackendFlags), io, x)
end

function ImGuiIO_Set_DisplaySize(io, x)
    ccall((:ImGuiIO_Set_DisplaySize, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, ImVec2), io, x)
end

function ImGuiIO_Set_DeltaTime(io, x)
    ccall((:ImGuiIO_Set_DeltaTime, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cfloat), io, x)
end

function ImGuiIO_Set_IniSavingRate(io, x)
    ccall((:ImGuiIO_Set_IniSavingRate, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cfloat), io, x)
end

function ImGuiIO_Set_IniFilename(io, x)
    ccall((:ImGuiIO_Set_IniFilename, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cstring), io, x)
end

function ImGuiIO_Set_LogFilename(io, x)
    ccall((:ImGuiIO_Set_LogFilename, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cstring), io, x)
end

function ImGuiIO_Set_MouseDoubleClickTime(io, x)
    ccall((:ImGuiIO_Set_MouseDoubleClickTime, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cfloat), io, x)
end

function ImGuiIO_Set_MouseDoubleClickMaxDist(io, x)
    ccall((:ImGuiIO_Set_MouseDoubleClickMaxDist, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cfloat), io, x)
end

function ImGuiIO_Set_MouseDragThreshold(io, x)
    ccall((:ImGuiIO_Set_MouseDragThreshold, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cfloat), io, x)
end

function ImGuiIO_Set_KeyMap(io, i, x)
    ccall((:ImGuiIO_Set_KeyMap, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cint, Cint), io, i, x)
end

function ImGuiIO_Set_KeyRepeatDelay(io, x)
    ccall((:ImGuiIO_Set_KeyRepeatDelay, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cfloat), io, x)
end

function ImGuiIO_Set_KeyRepeatRate(io, x)
    ccall((:ImGuiIO_Set_KeyRepeatRate, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cfloat), io, x)
end

function ImGuiIO_Set_UserData(io, x)
    ccall((:ImGuiIO_Set_UserData, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Ptr{Cvoid}), io, x)
end

function ImGuiIO_Set_Fonts(io, x)
    ccall((:ImGuiIO_Set_Fonts, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Ptr{ImFontAtlas}), io, x)
end

function ImGuiIO_Set_FontGlobalScale(io, x)
    ccall((:ImGuiIO_Set_FontGlobalScale, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cfloat), io, x)
end

function ImGuiIO_Set_FontAllowUserScaling(io, x)
    ccall((:ImGuiIO_Set_FontAllowUserScaling, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Bool), io, x)
end

function ImGuiIO_Set_FontDefault(io, x)
    ccall((:ImGuiIO_Set_FontDefault, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Ptr{ImFont}), io, x)
end

function ImGuiIO_Set_DisplayFramebufferScale(io, x)
    ccall((:ImGuiIO_Set_DisplayFramebufferScale, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, ImVec2), io, x)
end

function ImGuiIO_Set_MouseDrawCursor(io, x)
    ccall((:ImGuiIO_Set_MouseDrawCursor, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Bool), io, x)
end

function ImGuiIO_Set_ConfigMacOSXBehaviors(io, x)
    ccall((:ImGuiIO_Set_ConfigMacOSXBehaviors, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Bool), io, x)
end

function ImGuiIO_Set_ConfigInputTextCursorBlink(io, x)
    ccall((:ImGuiIO_Set_ConfigInputTextCursorBlink, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Bool), io, x)
end

function ImGuiIO_Set_ConfigWindowsResizeFromEdges(io, x)
    ccall((:ImGuiIO_Set_ConfigWindowsResizeFromEdges, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Bool), io, x)
end

function ImGuiIO_Set_ConfigWindowsMoveFromTitleBarOnly(io, x)
    ccall((:ImGuiIO_Set_ConfigWindowsMoveFromTitleBarOnly, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Bool), io, x)
end

function ImGuiIO_Set_BackendPlatformName(io, x)
    ccall((:ImGuiIO_Set_BackendPlatformName, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cstring), io, x)
end

function ImGuiIO_Set_BackendRendererName(io, x)
    ccall((:ImGuiIO_Set_BackendRendererName, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cstring), io, x)
end

function ImGuiIO_Set_BackendPlatformUserData(io, x)
    ccall((:ImGuiIO_Set_BackendPlatformUserData, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Ptr{Cvoid}), io, x)
end

function ImGuiIO_Set_BackendRendererUserData(io, x)
    ccall((:ImGuiIO_Set_BackendRendererUserData, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Ptr{Cvoid}), io, x)
end

function ImGuiIO_Set_BackendLanguageUserData(io, x)
    ccall((:ImGuiIO_Set_BackendLanguageUserData, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Ptr{Cvoid}), io, x)
end

function ImGuiIO_Set_GetClipboardTextFn(io, x)
    ccall((:ImGuiIO_Set_GetClipboardTextFn, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Ptr{Cvoid}), io, x)
end

function ImGuiIO_Set_SetClipboardTextFn(io, x)
    ccall((:ImGuiIO_Set_SetClipboardTextFn, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Ptr{Cvoid}), io, x)
end

function ImGuiIO_Set_ClipboardUserData(io, x)
    ccall((:ImGuiIO_Set_ClipboardUserData, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Ptr{Cvoid}), io, x)
end

function ImGuiIO_Set_ImeSetInputScreenPosFn(io, x)
    ccall((:ImGuiIO_Set_ImeSetInputScreenPosFn, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Ptr{Cvoid}), io, x)
end

function ImGuiIO_Set_ImeWindowHandle(io, x)
    ccall((:ImGuiIO_Set_ImeWindowHandle, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Ptr{Cvoid}), io, x)
end

function ImGuiIO_Set_RenderDrawListsFnUnused(io, x)
    ccall((:ImGuiIO_Set_RenderDrawListsFnUnused, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Ptr{Cvoid}), io, x)
end

function ImGuiIO_Set_MousePos(io, x)
    ccall((:ImGuiIO_Set_MousePos, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, ImVec2), io, x)
end

function ImGuiIO_Set_MouseDown(io, i, x)
    ccall((:ImGuiIO_Set_MouseDown, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cint, Bool), io, i, x)
end

function ImGuiIO_Set_MouseWheel(io, x)
    ccall((:ImGuiIO_Set_MouseWheel, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cfloat), io, x)
end

function ImGuiIO_Set_MouseWheelH(io, x)
    ccall((:ImGuiIO_Set_MouseWheelH, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cfloat), io, x)
end

function ImGuiIO_Set_KeyCtrl(io, x)
    ccall((:ImGuiIO_Set_KeyCtrl, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Bool), io, x)
end

function ImGuiIO_Set_KeyShift(io, x)
    ccall((:ImGuiIO_Set_KeyShift, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Bool), io, x)
end

function ImGuiIO_Set_KeyAlt(io, x)
    ccall((:ImGuiIO_Set_KeyAlt, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Bool), io, x)
end

function ImGuiIO_Set_KeySuper(io, x)
    ccall((:ImGuiIO_Set_KeySuper, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Bool), io, x)
end

function ImGuiIO_Set_KeysDown(io, i, x)
    ccall((:ImGuiIO_Set_KeysDown, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cint, Bool), io, i, x)
end

function ImGuiIO_Set_NavInputs(io, i, x)
    ccall((:ImGuiIO_Set_NavInputs, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cint, Cfloat), io, i, x)
end

function ImGuiIO_Set_WantCaptureMouse(io, x)
    ccall((:ImGuiIO_Set_WantCaptureMouse, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Bool), io, x)
end

function ImGuiIO_Set_WantCaptureKeyboard(io, x)
    ccall((:ImGuiIO_Set_WantCaptureKeyboard, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Bool), io, x)
end

function ImGuiIO_Set_WantTextInput(io, x)
    ccall((:ImGuiIO_Set_WantTextInput, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Bool), io, x)
end

function ImGuiIO_Set_WantSetMousePos(io, x)
    ccall((:ImGuiIO_Set_WantSetMousePos, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Bool), io, x)
end

function ImGuiIO_Set_WantSaveIniSettings(io, x)
    ccall((:ImGuiIO_Set_WantSaveIniSettings, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Bool), io, x)
end

function ImGuiIO_Set_NavActive(io, x)
    ccall((:ImGuiIO_Set_NavActive, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Bool), io, x)
end

function ImGuiIO_Set_NavVisible(io, x)
    ccall((:ImGuiIO_Set_NavVisible, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Bool), io, x)
end

function ImGuiIO_Set_Framerate(io, x)
    ccall((:ImGuiIO_Set_Framerate, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cfloat), io, x)
end

function ImGuiIO_Set_MetricsRenderVertices(io, x)
    ccall((:ImGuiIO_Set_MetricsRenderVertices, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cint), io, x)
end

function ImGuiIO_Set_MetricsRenderIndices(io, x)
    ccall((:ImGuiIO_Set_MetricsRenderIndices, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cint), io, x)
end

function ImGuiIO_Set_MetricsRenderWindows(io, x)
    ccall((:ImGuiIO_Set_MetricsRenderWindows, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cint), io, x)
end

function ImGuiIO_Set_MetricsActiveWindows(io, x)
    ccall((:ImGuiIO_Set_MetricsActiveWindows, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cint), io, x)
end

function ImGuiIO_Set_MetricsActiveAllocations(io, x)
    ccall((:ImGuiIO_Set_MetricsActiveAllocations, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cint), io, x)
end

function ImGuiIO_Set_MouseDelta(io, x)
    ccall((:ImGuiIO_Set_MouseDelta, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, ImVec2), io, x)
end

function ImGuiIO_Set_MousePosPrev(io, x)
    ccall((:ImGuiIO_Set_MousePosPrev, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, ImVec2), io, x)
end

function ImGuiIO_Set_MouseClickedPos(io, i, x)
    ccall((:ImGuiIO_Set_MouseClickedPos, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cint, ImVec2), io, i, x)
end

function ImGuiIO_Set_MouseClickedTime(io, i, x)
    ccall((:ImGuiIO_Set_MouseClickedTime, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cint, Cdouble), io, i, x)
end

function ImGuiIO_Set_MouseClicked(io, i, x)
    ccall((:ImGuiIO_Set_MouseClicked, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cint, Bool), io, i, x)
end

function ImGuiIO_Set_MouseDoubleClicked(io, i, x)
    ccall((:ImGuiIO_Set_MouseDoubleClicked, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cint, Bool), io, i, x)
end

function ImGuiIO_Set_MouseReleased(io, i, x)
    ccall((:ImGuiIO_Set_MouseReleased, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cint, Bool), io, i, x)
end

function ImGuiIO_Set_MouseDownOwned(io, i, x)
    ccall((:ImGuiIO_Set_MouseDownOwned, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cint, Bool), io, i, x)
end

function ImGuiIO_Set_MouseDownDuration(io, i, x)
    ccall((:ImGuiIO_Set_MouseDownDuration, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cint, Cfloat), io, i, x)
end

function ImGuiIO_Set_MouseDownDurationPrev(io, i, x)
    ccall((:ImGuiIO_Set_MouseDownDurationPrev, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cint, Cfloat), io, i, x)
end

function ImGuiIO_Set_MouseDragMaxDistanceAbs(io, i, x)
    ccall((:ImGuiIO_Set_MouseDragMaxDistanceAbs, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cint, ImVec2), io, i, x)
end

function ImGuiIO_Set_MouseDragMaxDistanceSqr(io, i, x)
    ccall((:ImGuiIO_Set_MouseDragMaxDistanceSqr, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cint, Cfloat), io, i, x)
end

function ImGuiIO_Set_KeysDownDuration(io, i, x)
    ccall((:ImGuiIO_Set_KeysDownDuration, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cint, Cfloat), io, i, x)
end

function ImGuiIO_Set_KeysDownDurationPrev(io, i, x)
    ccall((:ImGuiIO_Set_KeysDownDurationPrev, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cint, Cfloat), io, i, x)
end

function ImGuiIO_Set_NavInputsDownDuration(io, i, x)
    ccall((:ImGuiIO_Set_NavInputsDownDuration, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cint, Cfloat), io, i, x)
end

function ImGuiIO_Set_NavInputsDownDurationPrev(io, i, x)
    ccall((:ImGuiIO_Set_NavInputsDownDurationPrev, libcimgui_helper), Cvoid, (Ptr{ImGuiIO}, Cint, Cfloat), io, i, x)
end

function ImGuiStyle_Get_Alpha(s)
    ccall((:ImGuiStyle_Get_Alpha, libcimgui_helper), Cfloat, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_WindowPadding(s)
    ccall((:ImGuiStyle_Get_WindowPadding, libcimgui_helper), ImVec2, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_WindowRounding(s)
    ccall((:ImGuiStyle_Get_WindowRounding, libcimgui_helper), Cfloat, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_WindowBorderSize(s)
    ccall((:ImGuiStyle_Get_WindowBorderSize, libcimgui_helper), Cfloat, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_WindowMinSize(s)
    ccall((:ImGuiStyle_Get_WindowMinSize, libcimgui_helper), ImVec2, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_WindowTitleAlign(s)
    ccall((:ImGuiStyle_Get_WindowTitleAlign, libcimgui_helper), ImVec2, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_ChildRounding(s)
    ccall((:ImGuiStyle_Get_ChildRounding, libcimgui_helper), Cfloat, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_ChildBorderSize(s)
    ccall((:ImGuiStyle_Get_ChildBorderSize, libcimgui_helper), Cfloat, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_PopupRounding(s)
    ccall((:ImGuiStyle_Get_PopupRounding, libcimgui_helper), Cfloat, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_PopupBorderSize(s)
    ccall((:ImGuiStyle_Get_PopupBorderSize, libcimgui_helper), Cfloat, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_FramePadding(s)
    ccall((:ImGuiStyle_Get_FramePadding, libcimgui_helper), ImVec2, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_FrameRounding(s)
    ccall((:ImGuiStyle_Get_FrameRounding, libcimgui_helper), Cfloat, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_FrameBorderSize(s)
    ccall((:ImGuiStyle_Get_FrameBorderSize, libcimgui_helper), Cfloat, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_ItemSpacing(s)
    ccall((:ImGuiStyle_Get_ItemSpacing, libcimgui_helper), ImVec2, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_ItemInnerSpacing(s)
    ccall((:ImGuiStyle_Get_ItemInnerSpacing, libcimgui_helper), ImVec2, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_TouchExtraPadding(s)
    ccall((:ImGuiStyle_Get_TouchExtraPadding, libcimgui_helper), ImVec2, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_IndentSpacing(s)
    ccall((:ImGuiStyle_Get_IndentSpacing, libcimgui_helper), Cfloat, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_ColumnsMinSpacing(s)
    ccall((:ImGuiStyle_Get_ColumnsMinSpacing, libcimgui_helper), Cfloat, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_ScrollbarSize(s)
    ccall((:ImGuiStyle_Get_ScrollbarSize, libcimgui_helper), Cfloat, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_ScrollbarRounding(s)
    ccall((:ImGuiStyle_Get_ScrollbarRounding, libcimgui_helper), Cfloat, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_GrabMinSize(s)
    ccall((:ImGuiStyle_Get_GrabMinSize, libcimgui_helper), Cfloat, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_GrabRounding(s)
    ccall((:ImGuiStyle_Get_GrabRounding, libcimgui_helper), Cfloat, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_TabRounding(s)
    ccall((:ImGuiStyle_Get_TabRounding, libcimgui_helper), Cfloat, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_TabBorderSize(s)
    ccall((:ImGuiStyle_Get_TabBorderSize, libcimgui_helper), Cfloat, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_ButtonTextAlign(s)
    ccall((:ImGuiStyle_Get_ButtonTextAlign, libcimgui_helper), ImVec2, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_SelectableTextAlign(s)
    ccall((:ImGuiStyle_Get_SelectableTextAlign, libcimgui_helper), ImVec2, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_DisplayWindowPadding(s)
    ccall((:ImGuiStyle_Get_DisplayWindowPadding, libcimgui_helper), ImVec2, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_DisplaySafeAreaPadding(s)
    ccall((:ImGuiStyle_Get_DisplaySafeAreaPadding, libcimgui_helper), ImVec2, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_MouseCursorScale(s)
    ccall((:ImGuiStyle_Get_MouseCursorScale, libcimgui_helper), Cfloat, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_AntiAliasedLines(s)
    ccall((:ImGuiStyle_Get_AntiAliasedLines, libcimgui_helper), Bool, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_AntiAliasedFill(s)
    ccall((:ImGuiStyle_Get_AntiAliasedFill, libcimgui_helper), Bool, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_CurveTessellationTol(s)
    ccall((:ImGuiStyle_Get_CurveTessellationTol, libcimgui_helper), Cfloat, (Ptr{ImGuiStyle},), s)
end

function ImGuiStyle_Get_Colors(s, i)
    ccall((:ImGuiStyle_Get_Colors, libcimgui_helper), ImVec4, (Ptr{ImGuiStyle}, Cint), s, i)
end

function ImGuiStyle_Set_Alpha(s, v)
    ccall((:ImGuiStyle_Set_Alpha, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, Cfloat), s, v)
end

function ImGuiStyle_Set_WindowPadding(s, v)
    ccall((:ImGuiStyle_Set_WindowPadding, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, ImVec2), s, v)
end

function ImGuiStyle_Set_WindowRounding(s, v)
    ccall((:ImGuiStyle_Set_WindowRounding, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, Cfloat), s, v)
end

function ImGuiStyle_Set_WindowBorderSize(s, v)
    ccall((:ImGuiStyle_Set_WindowBorderSize, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, Cfloat), s, v)
end

function ImGuiStyle_Set_WindowMinSize(s, v)
    ccall((:ImGuiStyle_Set_WindowMinSize, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, ImVec2), s, v)
end

function ImGuiStyle_Set_WindowTitleAlign(s, v)
    ccall((:ImGuiStyle_Set_WindowTitleAlign, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, ImVec2), s, v)
end

function ImGuiStyle_Set_ChildRounding(s, v)
    ccall((:ImGuiStyle_Set_ChildRounding, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, Cfloat), s, v)
end

function ImGuiStyle_Set_ChildBorderSize(s, v)
    ccall((:ImGuiStyle_Set_ChildBorderSize, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, Cfloat), s, v)
end

function ImGuiStyle_Set_PopupRounding(s, v)
    ccall((:ImGuiStyle_Set_PopupRounding, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, Cfloat), s, v)
end

function ImGuiStyle_Set_PopupBorderSize(s, v)
    ccall((:ImGuiStyle_Set_PopupBorderSize, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, Cfloat), s, v)
end

function ImGuiStyle_Set_FramePadding(s, v)
    ccall((:ImGuiStyle_Set_FramePadding, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, ImVec2), s, v)
end

function ImGuiStyle_Set_FrameRounding(s, v)
    ccall((:ImGuiStyle_Set_FrameRounding, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, Cfloat), s, v)
end

function ImGuiStyle_Set_FrameBorderSize(s, v)
    ccall((:ImGuiStyle_Set_FrameBorderSize, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, Cfloat), s, v)
end

function ImGuiStyle_Set_ItemSpacing(s, v)
    ccall((:ImGuiStyle_Set_ItemSpacing, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, ImVec2), s, v)
end

function ImGuiStyle_Set_ItemInnerSpacing(s, v)
    ccall((:ImGuiStyle_Set_ItemInnerSpacing, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, ImVec2), s, v)
end

function ImGuiStyle_Set_TouchExtraPadding(s, v)
    ccall((:ImGuiStyle_Set_TouchExtraPadding, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, ImVec2), s, v)
end

function ImGuiStyle_Set_IndentSpacing(s, v)
    ccall((:ImGuiStyle_Set_IndentSpacing, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, Cfloat), s, v)
end

function ImGuiStyle_Set_ColumnsMinSpacing(s, v)
    ccall((:ImGuiStyle_Set_ColumnsMinSpacing, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, Cfloat), s, v)
end

function ImGuiStyle_Set_ScrollbarSize(s, v)
    ccall((:ImGuiStyle_Set_ScrollbarSize, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, Cfloat), s, v)
end

function ImGuiStyle_Set_ScrollbarRounding(s, v)
    ccall((:ImGuiStyle_Set_ScrollbarRounding, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, Cfloat), s, v)
end

function ImGuiStyle_Set_GrabMinSize(s, v)
    ccall((:ImGuiStyle_Set_GrabMinSize, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, Cfloat), s, v)
end

function ImGuiStyle_Set_GrabRounding(s, v)
    ccall((:ImGuiStyle_Set_GrabRounding, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, Cfloat), s, v)
end

function ImGuiStyle_Set_TabRounding(s, v)
    ccall((:ImGuiStyle_Set_TabRounding, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, Cfloat), s, v)
end

function ImGuiStyle_Set_TabBorderSize(s, v)
    ccall((:ImGuiStyle_Set_TabBorderSize, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, Cfloat), s, v)
end

function ImGuiStyle_Set_ButtonTextAlign(s, v)
    ccall((:ImGuiStyle_Set_ButtonTextAlign, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, ImVec2), s, v)
end

function ImGuiStyle_Set_SelectableTextAlign(s, v)
    ccall((:ImGuiStyle_Set_SelectableTextAlign, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, ImVec2), s, v)
end

function ImGuiStyle_Set_DisplayWindowPadding(s, v)
    ccall((:ImGuiStyle_Set_DisplayWindowPadding, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, ImVec2), s, v)
end

function ImGuiStyle_Set_DisplaySafeAreaPadding(s, v)
    ccall((:ImGuiStyle_Set_DisplaySafeAreaPadding, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, ImVec2), s, v)
end

function ImGuiStyle_Set_MouseCursorScale(s, v)
    ccall((:ImGuiStyle_Set_MouseCursorScale, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, Cfloat), s, v)
end

function ImGuiStyle_Set_AntiAliasedLines(s, v)
    ccall((:ImGuiStyle_Set_AntiAliasedLines, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, Bool), s, v)
end

function ImGuiStyle_Set_AntiAliasedFill(s, v)
    ccall((:ImGuiStyle_Set_AntiAliasedFill, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, Bool), s, v)
end

function ImGuiStyle_Set_CurveTessellationTol(s, v)
    ccall((:ImGuiStyle_Set_CurveTessellationTol, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, Cfloat), s, v)
end

function ImGuiStyle_Set_Colors(s, i, v)
    ccall((:ImGuiStyle_Set_Colors, libcimgui_helper), Cvoid, (Ptr{ImGuiStyle}, Cint, ImVec4), s, i, v)
end

function ImDrawData_Get_Valid(data)
    ccall((:ImDrawData_Get_Valid, libcimgui_helper), Bool, (Ptr{ImDrawData},), data)
end

function ImDrawData_Get_CmdLists(data, i)
    ccall((:ImDrawData_Get_CmdLists, libcimgui_helper), Ptr{ImDrawList}, (Ptr{ImDrawData}, Cint), data, i)
end

function ImDrawData_Get_CmdListsCount(data)
    ccall((:ImDrawData_Get_CmdListsCount, libcimgui_helper), Cint, (Ptr{ImDrawData},), data)
end

function ImDrawData_Get_TotalIdxCount(data)
    ccall((:ImDrawData_Get_TotalIdxCount, libcimgui_helper), Cint, (Ptr{ImDrawData},), data)
end

function ImDrawData_Get_TotalVtxCount(data)
    ccall((:ImDrawData_Get_TotalVtxCount, libcimgui_helper), Cint, (Ptr{ImDrawData},), data)
end

function ImDrawData_Get_DisplayPos(data)
    ccall((:ImDrawData_Get_DisplayPos, libcimgui_helper), ImVec2, (Ptr{ImDrawData},), data)
end

function ImDrawData_Get_DisplaySize(data)
    ccall((:ImDrawData_Get_DisplaySize, libcimgui_helper), ImVec2, (Ptr{ImDrawData},), data)
end

function ImDrawData_Get_FramebufferScale(data)
    ccall((:ImDrawData_Get_FramebufferScale, libcimgui_helper), ImVec2, (Ptr{ImDrawData},), data)
end

function ImDrawList_Get_CmdBuffer(list)
    ccall((:ImDrawList_Get_CmdBuffer, libcimgui_helper), ImVector_ImDrawCmd, (Ptr{ImDrawList},), list)
end

function ImDrawList_Get_IdxBuffer(list)
    ccall((:ImDrawList_Get_IdxBuffer, libcimgui_helper), ImVector_ImDrawIdx, (Ptr{ImDrawList},), list)
end

function ImDrawList_Get_VtxBuffer(list)
    ccall((:ImDrawList_Get_VtxBuffer, libcimgui_helper), ImVector_ImDrawVert, (Ptr{ImDrawList},), list)
end

function ImDrawCmd_Get_ElemCount(cmd)
    ccall((:ImDrawCmd_Get_ElemCount, libcimgui_helper), UInt32, (Ptr{ImDrawCmd},), cmd)
end

function ImDrawCmd_Get_ClipRect(cmd)
    ccall((:ImDrawCmd_Get_ClipRect, libcimgui_helper), ImVec4, (Ptr{ImDrawCmd},), cmd)
end

function ImDrawCmd_Get_TextureId(cmd)
    ccall((:ImDrawCmd_Get_TextureId, libcimgui_helper), ImTextureID, (Ptr{ImDrawCmd},), cmd)
end

function ImDrawCmd_Get_UserCallback(cmd)
    ccall((:ImDrawCmd_Get_UserCallback, libcimgui_helper), ImDrawCallback, (Ptr{ImDrawCmd},), cmd)
end

function ImDrawCmd_Get_UserCallbackData(cmd)
    ccall((:ImDrawCmd_Get_UserCallbackData, libcimgui_helper), Ptr{Cvoid}, (Ptr{ImDrawCmd},), cmd)
end

function ImGuiSizeCallbackData_Get_UserData(data)
    ccall((:ImGuiSizeCallbackData_Get_UserData, libcimgui_helper), Ptr{Cvoid}, (Ptr{ImGuiSizeCallbackData},), data)
end

function ImGuiSizeCallbackData_Get_Pos(data)
    ccall((:ImGuiSizeCallbackData_Get_Pos, libcimgui_helper), ImVec2, (Ptr{ImGuiSizeCallbackData},), data)
end

function ImGuiSizeCallbackData_Get_CurrentSize(data)
    ccall((:ImGuiSizeCallbackData_Get_CurrentSize, libcimgui_helper), ImVec2, (Ptr{ImGuiSizeCallbackData},), data)
end

function ImGuiSizeCallbackData_Get_DesiredSize(data)
    ccall((:ImGuiSizeCallbackData_Get_DesiredSize, libcimgui_helper), ImVec2, (Ptr{ImGuiSizeCallbackData},), data)
end

function ImGuiSizeCallbackData_Set_DesiredSize(data, x)
    ccall((:ImGuiSizeCallbackData_Set_DesiredSize, libcimgui_helper), Cvoid, (Ptr{ImGuiSizeCallbackData}, ImVec2), data, x)
end

function ImFontAtlas_Get_Locked(f)
    ccall((:ImFontAtlas_Get_Locked, libcimgui_helper), Bool, (Ptr{ImFontAtlas},), f)
end

function ImFontAtlas_Get_Flags(f)
    ccall((:ImFontAtlas_Get_Flags, libcimgui_helper), ImFontAtlasFlags, (Ptr{ImFontAtlas},), f)
end

function ImFontAtlas_Get_TexID(f)
    ccall((:ImFontAtlas_Get_TexID, libcimgui_helper), ImTextureID, (Ptr{ImFontAtlas},), f)
end

function ImFontAtlas_Get_TexDesiredWidth(f)
    ccall((:ImFontAtlas_Get_TexDesiredWidth, libcimgui_helper), Cint, (Ptr{ImFontAtlas},), f)
end

function ImFontAtlas_Get_TexGlyphPadding(f)
    ccall((:ImFontAtlas_Get_TexGlyphPadding, libcimgui_helper), Cint, (Ptr{ImFontAtlas},), f)
end

function ImFontAtlas_Get_TexPixelsAlpha8(f)
    ccall((:ImFontAtlas_Get_TexPixelsAlpha8, libcimgui_helper), Ptr{Cuchar}, (Ptr{ImFontAtlas},), f)
end

function ImFontAtlas_Get_TexPixelsRGBA32(f)
    ccall((:ImFontAtlas_Get_TexPixelsRGBA32, libcimgui_helper), Ptr{UInt32}, (Ptr{ImFontAtlas},), f)
end

function ImFontAtlas_Get_TexWidth(f)
    ccall((:ImFontAtlas_Get_TexWidth, libcimgui_helper), Cint, (Ptr{ImFontAtlas},), f)
end

function ImFontAtlas_Get_TexHeight(f)
    ccall((:ImFontAtlas_Get_TexHeight, libcimgui_helper), Cint, (Ptr{ImFontAtlas},), f)
end

function ImFontAtlas_Get_TexUvScale(f)
    ccall((:ImFontAtlas_Get_TexUvScale, libcimgui_helper), ImVec2, (Ptr{ImFontAtlas},), f)
end

function ImFontAtlas_Get_TexUvWhitePixel(f)
    ccall((:ImFontAtlas_Get_TexUvWhitePixel, libcimgui_helper), ImVec2, (Ptr{ImFontAtlas},), f)
end
