var documenterSearchIndex = {"docs": [

{
    "location": "#",
    "page": "Introduction",
    "title": "Introduction",
    "category": "page",
    "text": ""
},

{
    "location": "#CImGui-1",
    "page": "Introduction",
    "title": "CImGui",
    "category": "section",
    "text": "This package provides a Julia language wrapper for cimgui: a thin c-api wrapper programmatically generated for the excellent C++ immediate mode gui Dear ImGui. Dear ImGui is mainly for creating content creation tools and visualization / debug tools. You could browse Gallery to get an idea of its use cases."
},

{
    "location": "#Installation-1",
    "page": "Introduction",
    "title": "Installation",
    "category": "section",
    "text": "pkg> add CImGui"
},

{
    "location": "#Usage-1",
    "page": "Introduction",
    "title": "Usage",
    "category": "section",
    "text": "The API provided in this package is as close as possible to the original C++ API. When translating C++ code to Julia, please follow the tips below:Replace ImGui:: to CImGui.;\nusing LibCImGui to import all of the ImGuiXXX types into the current namespace;\nMember function calling should be translated in Julia style: fonts.AddFont(cfg) => CImGui.Add(fonts, cfg);\nPrefer to define colors as Vector{Cfloat} instead of CImGui.ImVec4;\nCSyntax.jl provides two useful macros: @c for translating C\'s & operator on immutables and @cstatic-block for emulating C\'s static keyword;\npointer arithmetic: &A[n] should be translated to pointer(A) + n * sizeof(T)As mentioned before, this package aims to provide the same user experience as the original C++ API, so any high-level abstraction should go into a more high-level package."
},

{
    "location": "#LibCImGui-1",
    "page": "Introduction",
    "title": "LibCImGui",
    "category": "section",
    "text": "LibCImGui is a thin wrapper over cimgui. It\'s one-to-one mapped to the original cimgui APIs. By using CImGui.LibCImGui, all of the ImGui-prefixed types, enums and ig-prefixed functions are imported into the current namespace."
},

{
    "location": "#Backend-1",
    "page": "Introduction",
    "title": "Backend",
    "category": "section",
    "text": "The default backend is based on ModernGL and GLFW which are stable and under actively maintained. Other popular backends like SFML and SDL could be added in the future if someone would invest time to make these packages work in post Julia 1.0 era."
},

{
    "location": "#License-1",
    "page": "Introduction",
    "title": "License",
    "category": "section",
    "text": "Only the Julia code in this repo is released under MIT license. Other assets such as those fonts in the fonts folder are released under their own license."
},

{
    "location": "api/#",
    "page": "API Reference",
    "title": "API Reference",
    "category": "page",
    "text": ""
},

{
    "location": "api/#CImGui.AcceptDragDropPayload",
    "page": "API Reference",
    "title": "CImGui.AcceptDragDropPayload",
    "category": "function",
    "text": "AcceptDragDropPayload(type, flags=ImGuiDragDropFlags_(0)) -> Ptr{ImGuiPayload}\n\nnote: BETA API\nMissing Demo code. API may evolve.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddBezierCurve",
    "page": "API Reference",
    "title": "CImGui.AddBezierCurve",
    "category": "function",
    "text": "AddBezierCurve(handle::Ptr{ImDrawList}, pos0, cp0, cp1, pos1, col, thickness, num_segments=0)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddCallback-Tuple{Ptr{CImGui.LibCImGui.ImDrawList},Any,Any}",
    "page": "API Reference",
    "title": "CImGui.AddCallback",
    "category": "method",
    "text": "AddCallback(handle::Ptr{ImDrawList}, callback, callback_data)\n\nYour rendering function must check for UserCallback in ImDrawCmd and call the function instead of rendering triangles.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddCircle",
    "page": "API Reference",
    "title": "CImGui.AddCircle",
    "category": "function",
    "text": "AddCircle(handle::Ptr{ImDrawList}, centre, radius, col, num_segments=12, thickness=1.0)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddCircleFilled",
    "page": "API Reference",
    "title": "CImGui.AddCircleFilled",
    "category": "function",
    "text": "AddCircleFilled(handle::Ptr{ImDrawList}, centre, radius, col, num_segments=12)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddConvexPolyFilled-Tuple{Ptr{CImGui.LibCImGui.ImDrawList},Any,Any,Any}",
    "page": "API Reference",
    "title": "CImGui.AddConvexPolyFilled",
    "category": "method",
    "text": "AddConvexPolyFilled(handle::Ptr{ImDrawList}, points, num_points, col)\n\nnote: Note\nAnti-aliased filling requires points to be in clockwise order.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddDrawCmd-Tuple{Ptr{CImGui.LibCImGui.ImDrawList}}",
    "page": "API Reference",
    "title": "CImGui.AddDrawCmd",
    "category": "method",
    "text": "AddDrawCmd(handle::Ptr{ImDrawList})\n\nThis is useful if you need to forcefully create a new draw call (to allow for dependent rendering / blending). Otherwise primitives are merged into the same draw-call as much as possible.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddFont-Tuple{Ptr{CImGui.LibCImGui.ImFontAtlas},Any}",
    "page": "API Reference",
    "title": "CImGui.AddFont",
    "category": "method",
    "text": "AddFont(self::Ptr{ImFontAtlas}, font_cfg) -> Ptr{ImFont}\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddFontDefault",
    "page": "API Reference",
    "title": "CImGui.AddFontDefault",
    "category": "function",
    "text": "AddFontDefault(self::Ptr{ImFontAtlas}, font_cfg=C_NULL) -> Ptr{ImFont}\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddFontFromFileTTF",
    "page": "API Reference",
    "title": "CImGui.AddFontFromFileTTF",
    "category": "function",
    "text": "AddFontFromFileTTF(self::Ptr{ImFontAtlas}, filename, size_pixels, font_cfg=C_NULL, glyph_ranges=C_NULL) -> Ptr{ImFont}\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddFontFromMemoryCompressedBase85TTF",
    "page": "API Reference",
    "title": "CImGui.AddFontFromMemoryCompressedBase85TTF",
    "category": "function",
    "text": "AddFontFromMemoryCompressedBase85TTF(self::Ptr{ImFontAtlas}, compressed_font_data_base85, size_pixels, font_cfg=C_NULL, glyph_ranges=C_NULL) -> Ptr{ImFont}\n\n\'compressedfontdata_base85\' still owned by caller.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddFontFromMemoryCompressedTTF",
    "page": "API Reference",
    "title": "CImGui.AddFontFromMemoryCompressedTTF",
    "category": "function",
    "text": "AddFontFromMemoryCompressedTTF(self::Ptr{ImFontAtlas}, compressed_font_data, compressed_font_size, size_pixels, font_cfg=C_NULL, glyph_ranges=C_NULL) -> Ptr{ImFont}\n\n\'compressedfontdata\' still owned by caller.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddFontFromMemoryTTF",
    "page": "API Reference",
    "title": "CImGui.AddFontFromMemoryTTF",
    "category": "function",
    "text": "AddFontFromMemoryTTF(self::Ptr{ImFontAtlas}, font_data, font_size, size_pixels, font_cfg=C_NULL, glyph_ranges=C_NULL) -> Ptr{ImFont}\n\nnote: Note\nTransfer ownership of \'ttfdata\' to ImFontAtlas! Will be deleted after destruction of the atlas. Set `fontcfg.FontDataOwnedByAtlas=false` to keep ownership of your data and it won\'t be freed.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddImage",
    "page": "API Reference",
    "title": "CImGui.AddImage",
    "category": "function",
    "text": "AddImage(handle::Ptr{ImDrawList}, user_texture_id, a, b, uv_a=(0,0), uv_b=(1,1), col=0xffffffff)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddImageQuad",
    "page": "API Reference",
    "title": "CImGui.AddImageQuad",
    "category": "function",
    "text": "AddImageQuad(handle::Ptr{ImDrawList}, user_texture_id, a, b, c, d, uv_a=(0,0), uv_b=(1,0), uv_c=(1,1), uv_d=(0,1), col=0xffffffff)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddImageRounded",
    "page": "API Reference",
    "title": "CImGui.AddImageRounded",
    "category": "function",
    "text": "AddImageRounded(handle::Ptr{ImDrawList}, user_texture_id, a, b, uv_a, uv_b, col, rounding, rounding_corners=ImDrawCornerFlags_All)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddInputCharacter-Tuple{Ptr{CImGui.LibCImGui.ImGuiIO},Any}",
    "page": "API Reference",
    "title": "CImGui.AddInputCharacter",
    "category": "method",
    "text": "AddInputCharacter(io::Ptr{ImGuiIO}, c)\n\nAdd new character into InputCharacters[].\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddInputCharactersUTF8-Tuple{Ptr{CImGui.LibCImGui.ImGuiIO},Any}",
    "page": "API Reference",
    "title": "CImGui.AddInputCharactersUTF8",
    "category": "method",
    "text": "AddInputCharactersUTF8(io::Ptr{ImGuiIO}, utf8_chars)\n\nAdd new characters into InputCharacters[] from an UTF-8 string.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddLine",
    "page": "API Reference",
    "title": "CImGui.AddLine",
    "category": "function",
    "text": "AddLine(handle::Ptr{ImDrawList}, a, b, col, thickness=1.0)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddPolyline-Tuple{Ptr{CImGui.LibCImGui.ImDrawList},Any,Any,Any,Any,Any}",
    "page": "API Reference",
    "title": "CImGui.AddPolyline",
    "category": "method",
    "text": "AddPolyline(handle::Ptr{ImDrawList}, points, num_points, col, closed, thickness)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddQuad",
    "page": "API Reference",
    "title": "CImGui.AddQuad",
    "category": "function",
    "text": "AddQuad(handle::Ptr{ImDrawList}, a, b, c, d, col, thickness=1.0)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddQuadFilled-Tuple{Ptr{CImGui.LibCImGui.ImDrawList},Any,Any,Any,Any,Any}",
    "page": "API Reference",
    "title": "CImGui.AddQuadFilled",
    "category": "method",
    "text": "AddQuadFilled(handle::Ptr{ImDrawList}, a, b, c, d, col)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddRect",
    "page": "API Reference",
    "title": "CImGui.AddRect",
    "category": "function",
    "text": "AddRect(handle::Ptr{ImDrawList}, a, b, col, rounding=0.0, rounding_corners_flags=ImDrawCornerFlags_All, thickness=1.0)\n\nArguments\n\na: upper-left\nb: lower-right\nrounding_corners_flags: 4-bits corresponding to which corner to round\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddRectFilled",
    "page": "API Reference",
    "title": "CImGui.AddRectFilled",
    "category": "function",
    "text": "AddRectFilled(handle::Ptr{ImDrawList}, a, b, col, rounding=0.0, rounding_corners_flags=ImDrawCornerFlags_All)\n\nArguments\n\na: upper-left\nb: lower-right\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddRectFilledMultiColor-Tuple{Ptr{CImGui.LibCImGui.ImDrawList},Any,Any,Any,Any,Any,Any}",
    "page": "API Reference",
    "title": "CImGui.AddRectFilledMultiColor",
    "category": "method",
    "text": "AddRectFilledMultiColor(handle::Ptr{ImDrawList}, a, b, col_upr_left, col_upr_right, col_bot_right, col_bot_left)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddText",
    "page": "API Reference",
    "title": "CImGui.AddText",
    "category": "function",
    "text": "AddText(handle::Ptr{ImDrawList}, pos, col, text_begin, text_end=C_NULL)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddText",
    "page": "API Reference",
    "title": "CImGui.AddText",
    "category": "function",
    "text": "AddText(handle::Ptr{ImDrawList}, font::Ptr{ImFont}, font_size, pos, col, text_begin, text_end=C_NULL, wrap_width=0.0, cpu_fine_clip_rect=C_NULL)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddTriangle",
    "page": "API Reference",
    "title": "CImGui.AddTriangle",
    "category": "function",
    "text": "AddTriangle(handle::Ptr{ImDrawList}, a, b, c, col, thickness=1.0)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AddTriangleFilled-Tuple{Ptr{CImGui.LibCImGui.ImDrawList},Any,Any,Any,Any}",
    "page": "API Reference",
    "title": "CImGui.AddTriangleFilled",
    "category": "method",
    "text": "AddTriangleFilled(handle::Ptr{ImDrawList}, a, b, c, col)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.AlignTextToFramePadding-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.AlignTextToFramePadding",
    "category": "method",
    "text": "AlignTextToFramePadding()\n\nVertically align upcoming text baseline to FramePadding.y so that it will align properly to regularly framed items (call if you have text on a line before a framed item).\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Append",
    "page": "API Reference",
    "title": "CImGui.Append",
    "category": "function",
    "text": "Append(handle::Ptr{ImGuiTextBuffer}, str, str_end=C_NULL)\n\nText buffer for logging/accumulating text.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ArrowButton-Tuple{Any,Any}",
    "page": "API Reference",
    "title": "CImGui.ArrowButton",
    "category": "method",
    "text": "ArrowButton(str_id, dir) -> Bool\n\nReturn true when the value has been changed or when pressed/selected. Create a square button with an arrow shape.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Begin",
    "page": "API Reference",
    "title": "CImGui.Begin",
    "category": "function",
    "text": "Begin(name, p_open=C_NULL, flags=0) -> Bool\n\nPush window to the stack and start appending to it.\n\nUsage\n\nyou may append multiple times to the same window during the same frame.\npassing p_open != C_NULL shows a window-closing widget in the upper-right corner of the window,   which clicking will set the boolean to false when clicked.\nBegin return false to indicate the window is collapsed or fully clipped, so you   may early out and omit submitting anything to the window.\n\nnote: Note\nAlways call a matching End for each Begin call, regardless of its return value. This is due to legacy reason and is inconsistent with most other functions (such as BeginMenu/EndMenu, BeginPopup/EndPopup, etc.) where the EndXXX call should only be called if the corresponding BeginXXX function returned true.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Begin",
    "page": "API Reference",
    "title": "CImGui.Begin",
    "category": "function",
    "text": "Begin(handle::Ptr{ImGuiListClipper}, items_count, items_height=-1.0)\n\nAutomatically called by constructor if you passed items_count or by Step in Step 1.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Begin-Tuple{Ptr{CImGui.LibCImGui.ImGuiTextBuffer}}",
    "page": "API Reference",
    "title": "CImGui.Begin",
    "category": "method",
    "text": "Begin(handle::Ptr{ImGuiTextBuffer}) -> Cstring\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.BeginChild",
    "page": "API Reference",
    "title": "CImGui.BeginChild",
    "category": "function",
    "text": "BeginChild(str_id, size=(0,0), border=false, flags=0) -> Bool\nBeginChild(id::Integer, size=(0,0), border=false, flags=0) -> Bool\n\nUse child windows to begin into a self-contained independent scrolling/clipping regions within a host window. Child windows can embed their own child.\n\nReturn false to indicate the window is collapsed or fully clipped, so you may early out and omit submitting anything to the window.\n\nFor each independent axis of size:\n\nx == 0.0: use remaining host window size\nx > 0.0: fixed size\nx < 0.0: use remaining window size minus abs(size)\n\nEach axis can use a different mode, e.g. ImVec2(0,400).\n\nnote: Note\nAlways call a matching EndChild for each BeginChild call, regardless of its return value. This is due to legacy reason and is inconsistent with most other functions (such as BeginMenu/EndMenu, BeginPopup/EndPopup, etc.) where the EndXXX call should only be called if the corresponding BeginXXX function returned true.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.BeginChildFrame",
    "page": "API Reference",
    "title": "CImGui.BeginChildFrame",
    "category": "function",
    "text": "BeginChildFrame(id, size, flags=0) -> Bool\n\nHelper to create a child window / scrolling region that looks like a normal widget frame.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.BeginCombo",
    "page": "API Reference",
    "title": "CImGui.BeginCombo",
    "category": "function",
    "text": "BeginCombo(label, preview_value, flags=0) -> Bool\n\nThe new BeginCombo/EndCombo api allows you to manage your contents and selection state however you want it, by creating e.g. Selectable items.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.BeginDragDropSource",
    "page": "API Reference",
    "title": "CImGui.BeginDragDropSource",
    "category": "function",
    "text": "BeginDragDropSource(flags=ImGuiDragDropFlags_(0)) -> bool\n\nCall when the current item is active. If this return true, you can call SetDragDropPayload + EndDragDropSource.\n\nnote: BETA API\nMissing Demo code. API may evolve.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.BeginDragDropTarget-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.BeginDragDropTarget",
    "category": "method",
    "text": "BeginDragDropTarget() -> bool\n\nCall after submitting an item that may receive a payload. If this returns true, you can call AcceptDragDropPayload + EndDragDropTarget.\n\nnote: BETA API\nMissing Demo code. API may evolve.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.BeginGroup-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.BeginGroup",
    "category": "method",
    "text": "BeginGroup()\n\nLock horizontal starting position + capture group bounding box into one \"item\", so you can use IsItemHovered or layout primitives such as SameLine on whole group, etc.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.BeginMainMenuBar-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.BeginMainMenuBar",
    "category": "method",
    "text": "BeginMainMenuBar() -> Bool\n\nCreate and append to a full screen menu-bar.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.BeginMenu",
    "page": "API Reference",
    "title": "CImGui.BeginMenu",
    "category": "function",
    "text": "BeginMenu(label, enabled=true) -> Bool\n\nCreate a sub-menu entry. only call EndMenu() if this returns true!\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.BeginMenuBar-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.BeginMenuBar",
    "category": "method",
    "text": "BeginMenuBar() -> Bool\n\nAppend to menu-bar of current window (requires ImGuiWindowFlags_MenuBar flag set on parent window).\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.BeginPopup",
    "page": "API Reference",
    "title": "CImGui.BeginPopup",
    "category": "function",
    "text": "BeginPopup(str_id, flags=0) -> Bool\n\nReturn true if the popup is open, and you can start outputting to it.\n\nnote: Note\nOnly call EndPopup if BeginPopup returns true!\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.BeginPopupContextItem",
    "page": "API Reference",
    "title": "CImGui.BeginPopupContextItem",
    "category": "function",
    "text": "BeginPopupContextItem(str_id=C_NULL, mouse_button=1) -> Bool\n\nHelper to open and begin popup when clicked on last item. if you can pass a CNULL strid only if the previous item had an id. If you want to use that on a non-interactive item such as Text you need to pass in an explicit ID here.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.BeginPopupContextVoid",
    "page": "API Reference",
    "title": "CImGui.BeginPopupContextVoid",
    "category": "function",
    "text": "BeginPopupContextVoid(str_id=C_NULL, mouse_button=1) -> Bool\n\nHelper to open and begin popup when clicked in void (where there are no imgui windows).\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.BeginPopupContextWindow",
    "page": "API Reference",
    "title": "CImGui.BeginPopupContextWindow",
    "category": "function",
    "text": "BeginPopupContextWindow(str_id=C_NULL, mouse_button=1, also_over_items=true) -> Bool\n\nHelper to open and begin popup when clicked on current window.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.BeginPopupModal",
    "page": "API Reference",
    "title": "CImGui.BeginPopupModal",
    "category": "function",
    "text": "BeginPopupModal(name, p_open=C_NULL, flags=0) -> Bool\n\nModal dialog (regular window with title bar, block interactions behind the modal window, can\'t close the modal window by clicking outside).\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.BeginTabBar",
    "page": "API Reference",
    "title": "CImGui.BeginTabBar",
    "category": "function",
    "text": "igBeginTabBar(str_id, flags=ImGuiTabBarFlags_(0)) -> Bool\n\nCreate and append into a TabBar.\n\nnote: BETA API\nAPI may evolve!\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.BeginTabItem",
    "page": "API Reference",
    "title": "CImGui.BeginTabItem",
    "category": "function",
    "text": "BeginTabItem(label, p_open=C_NULL, flags=ImGuiTabItemFlags_(0)) -> Bool\n\nnote: BETA API\nAPI may evolve!\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.BeginTooltip-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.BeginTooltip",
    "category": "method",
    "text": "BeginTooltip()\n\nBegin/append a tooltip window to create full-featured tooltip (with any kind of items).\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Build-Tuple{Ptr{CImGui.LibCImGui.ImFontAtlas}}",
    "page": "API Reference",
    "title": "CImGui.Build",
    "category": "method",
    "text": "Build(self::Ptr{ImFontAtlas}) -> Bool\n\nBuild pixels data. This is called automatically for you by the GetTexData*** functions.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Bullet-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.Bullet",
    "category": "method",
    "text": "Bullet()\n\nDraw a small circle and keep the cursor on the same line. advance cursor x position by GetTreeNodeToLabelSpacing(), same distance that TreeNode() uses\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.BulletText-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.BulletText",
    "category": "method",
    "text": "BulletText(formatted_text)\n\nShortcut for Bullet+Text.\n\nwarning: Limited support\nFormatting is not supported which means you need to pass a formatted string to this function. It\'s recommended to use Julia stdlib Printf\'s @sprintf as a workaround when translating C/C++ code to Julia.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Button",
    "page": "API Reference",
    "title": "CImGui.Button",
    "category": "function",
    "text": "Button(label) -> Bool\nButton(label, size) -> Bool\n\nReturn true when the value has been changed or when pressed/selected.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.C_str-Tuple{Ptr{CImGui.LibCImGui.ImGuiTextBuffer}}",
    "page": "API Reference",
    "title": "CImGui.C_str",
    "category": "method",
    "text": "C_str(handle::Ptr{ImGuiTextBuffer}) -> Cstring\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.CalcItemWidth-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.CalcItemWidth",
    "category": "method",
    "text": "CalcItemWidth() -> Cfloat\n\nReturn width of item given pushed settings and current cursor position.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.CalcListClipping-NTuple{4,Any}",
    "page": "API Reference",
    "title": "CImGui.CalcListClipping",
    "category": "method",
    "text": "CalcListClipping(items_count, items_height, out_items_display_start, out_items_display_end)\n\nCalculate coarse clipping for large list of evenly sized items. Prefer using the ImGuiListClipper higher-level helper if you can.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.CalcTextSize",
    "page": "API Reference",
    "title": "CImGui.CalcTextSize",
    "category": "function",
    "text": "CalcTextSize(text, text_end=C_NULL, hide_text_after_double_hash=false, wrap_width=-1) -> ImVec2\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.CaptureKeyboardFromApp",
    "page": "API Reference",
    "title": "CImGui.CaptureKeyboardFromApp",
    "category": "function",
    "text": "CaptureKeyboardFromApp(capture=true)\n\nManually override io.WantCaptureKeyboard flag next frame (said flag is entirely left for your application to handle). e.g. force capture keyboard when your widget is being hovered.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.CaptureMouseFromApp",
    "page": "API Reference",
    "title": "CImGui.CaptureMouseFromApp",
    "category": "function",
    "text": "CaptureMouseFromApp(capture=true)\n\nManually override io.WantCaptureMouse flag next frame (said flag is entirely left for your application to handle).\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ChannelsMerge-Tuple{Ptr{CImGui.LibCImGui.ImDrawList}}",
    "page": "API Reference",
    "title": "CImGui.ChannelsMerge",
    "category": "method",
    "text": "ChannelsMerge(handle::Ptr{ImDrawList})\n\ntip: Tip\nUse to simulate layers. By switching channels to can render out-of-order (e.g. submit   foreground primitives before background primitives)\nUse to minimize draw calls (e.g. if going back-and-forth between multiple non-overlapping   clipping rectangles, prefer to append into separate channels then merge at the end)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ChannelsSetCurrent-Tuple{Ptr{CImGui.LibCImGui.ImDrawList},Any}",
    "page": "API Reference",
    "title": "CImGui.ChannelsSetCurrent",
    "category": "method",
    "text": "ChannelsSetCurrent(handle::Ptr{ImDrawList}, channel_index)\n\ntip: Tip\nUse to simulate layers. By switching channels to can render out-of-order (e.g. submit   foreground primitives before background primitives)\nUse to minimize draw calls (e.g. if going back-and-forth between multiple non-overlapping   clipping rectangles, prefer to append into separate channels then merge at the end)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ChannelsSplit-Tuple{Ptr{CImGui.LibCImGui.ImDrawList},Any}",
    "page": "API Reference",
    "title": "CImGui.ChannelsSplit",
    "category": "method",
    "text": "ChannelsSplit(handle::Ptr{ImDrawList}, channels_count)\n\ntip: Tip\nUse to simulate layers. By switching channels to can render out-of-order (e.g. submit   foreground primitives before background primitives)\nUse to minimize draw calls (e.g. if going back-and-forth between multiple non-overlapping   clipping rectangles, prefer to append into separate channels then merge at the end)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Checkbox-Tuple{Any,Any}",
    "page": "API Reference",
    "title": "CImGui.Checkbox",
    "category": "method",
    "text": "Checkbox(label, v) -> Bool\n\nReturn true when the value has been changed or when pressed/selected.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.CheckboxFlags-Tuple{Any,Any,Any}",
    "page": "API Reference",
    "title": "CImGui.CheckboxFlags",
    "category": "method",
    "text": "CheckboxFlags(label, flags, flags_value) -> Bool\n\nReturn true when the value has been changed or when pressed/selected.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Clear-Tuple{Ptr{CImGui.LibCImGui.ImDrawList}}",
    "page": "API Reference",
    "title": "CImGui.Clear",
    "category": "method",
    "text": "Clear(handle::Ptr{ImDrawList})\n\nnote: Note\nAll primitives needs to be reserved via PrimReserve beforehand!\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Clear-Tuple{Ptr{CImGui.LibCImGui.ImFontAtlas}}",
    "page": "API Reference",
    "title": "CImGui.Clear",
    "category": "method",
    "text": "Clear(self::Ptr{ImFontAtlas})\n\nClear all input and output.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Clear-Tuple{Ptr{CImGui.LibCImGui.ImGuiTextBuffer}}",
    "page": "API Reference",
    "title": "CImGui.Clear",
    "category": "method",
    "text": "Clear(handle::Ptr{ImGuiTextBuffer})\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ClearFonts-Tuple{Ptr{CImGui.LibCImGui.ImFontAtlas}}",
    "page": "API Reference",
    "title": "CImGui.ClearFonts",
    "category": "method",
    "text": "ClearFonts(self::Ptr{ImFontAtlas})\n\nClear output font data (glyphs storage, UV coordinates).\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ClearFreeMemory-Tuple{Ptr{CImGui.LibCImGui.ImDrawList}}",
    "page": "API Reference",
    "title": "CImGui.ClearFreeMemory",
    "category": "method",
    "text": "ClearFreeMemory(handle::Ptr{ImDrawList})\n\nnote: Note\nAll primitives needs to be reserved via PrimReserve beforehand!\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ClearInputCharacters-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.ClearInputCharacters",
    "category": "method",
    "text": "ClearInputCharacters(io)\n\nClear the text input buffer manually.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ClearInputData-Tuple{Ptr{CImGui.LibCImGui.ImFontAtlas}}",
    "page": "API Reference",
    "title": "CImGui.ClearInputData",
    "category": "method",
    "text": "ClearInputData(self::Ptr{ImFontAtlas})\n\nClear input data (all ImFontConfig structures including sizes, TTF data, glyph ranges, etc.) = all the data used to build the texture and fonts.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ClearTexData-Tuple{Ptr{CImGui.LibCImGui.ImFontAtlas}}",
    "page": "API Reference",
    "title": "CImGui.ClearTexData",
    "category": "method",
    "text": "ClearTexData(self::Ptr{ImFontAtlas})\n\nClear output texture data (CPU side). Saves RAM once the texture has been copied to graphics memory.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Clipper",
    "page": "API Reference",
    "title": "CImGui.Clipper",
    "category": "function",
    "text": "Clipper(items_count=-1, items_height=-1.0) -> Ptr{ImGuiListClipper}\n\nManually clip large list of items.\n\nIf you are submitting lots of evenly spaced items and you have a random access to the list, you can perform coarse clipping based on visibility to save yourself from processing those items at all.\n\nIf you are submitting lots of evenly spaced items and you have a random access to the list, you can perform coarse clipping based on visibility to save yourself from processing those items at all.\n\nThe clipper calculates the range of visible items and advance the cursor to compensate for the non-visible items we have skipped. ImGui already clip items based on their bounds but it needs to measure text size to do so. Coarse clipping before submission makes this cost and your own data fetching/submission cost null.\n\nExample\n\nclipper = CImGui.Clipper(1000) # we have 1000 elements, evenly spaced.\nwhile CImGui.Step()\n    dis_start = CImGui.Get(clipper, :DisplayStart)\n    dis_end = CImGui.Get(clipper, :DisplayEnd)-1\n    foreach(i->CImGui.Text(\"line number $i\"), dis_start:dis_end)\nend\n\nStep 0: the clipper let you process the first element, regardless of it being visible or not,   so we can measure the element height (step skipped if we passed a known height as second   arg to constructor).\nStep 1: the clipper infer height from first element, calculate the actual range of elements   to display, and position the cursor before the first element.\n(Step 2: dummy step only required if an explicit items_height was passed to constructor   or Begin and user call Step. Does nothing and switch to Step 3.)\nStep 3: the clipper validate that we have reached the expected Y position (corresponding   to element DisplayEnd), advance the cursor to the end of the list and then returns false   to end the loop.\n\nArguments\n\nitems_count: use -1 to ignore (you can call Begin later).   use INT_MAX if you don\'t know how many items you have (in which case the cursor won\'t   be advanced in the final step).\nitems_height: use -1.0 to be calculated automatically on first step.   otherwise pass in the distance between your items, typically GetTextLineHeightWithSpacing   or GetFrameHeightWithSpacing. If you don\'t specify an items_height, you NEED to call   Step. If you specify items_height you may call the old Begin/End   api directly, but prefer calling Step.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.CloneOutput-Tuple{Ptr{CImGui.LibCImGui.ImDrawList}}",
    "page": "API Reference",
    "title": "CImGui.CloneOutput",
    "category": "method",
    "text": "CloneOutput(handle::Ptr{ImDrawList}) -> Ptr{ImDrawList}\n\nCreate a clone of the CmdBuffer/IdxBuffer/VtxBuffer.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.CloseCurrentPopup-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.CloseCurrentPopup",
    "category": "method",
    "text": "CloseCurrentPopup()\n\nClose the popup we have begin-ed into. clicking on a MenuItem or Selectable automatically close the current popup.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.CollapsingHeader",
    "page": "API Reference",
    "title": "CImGui.CollapsingHeader",
    "category": "function",
    "text": "CollapsingHeader(label, flags=ImGuiTreeNodeFlags_(0)) -> Bool\n\nIf returning true the header is open. Doesn\'t indent nor push on ID stack. User doesn\'t have to call TreePop.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.CollapsingHeader",
    "page": "API Reference",
    "title": "CImGui.CollapsingHeader",
    "category": "function",
    "text": "CollapsingHeader(label, p_open::Ref, flags=ImGuiTreeNodeFlags_(0)) -> Bool\n\nWhen p_open isn\'t C_NULL, display an additional small close button on upper right of the header.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ColorButton",
    "page": "API Reference",
    "title": "CImGui.ColorButton",
    "category": "function",
    "text": "ColorButton(desc_id, col, flags=0, size=(0,0))\n\nDisplay a colored square/button, hover for details, return true when pressed.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ColorConvertFloat4ToU32-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.ColorConvertFloat4ToU32",
    "category": "method",
    "text": "ColorConvertFloat4ToU32(in) -> ImU32\n\nConvert ImVec4 color to ImU32. You could use Base.convert(::Type{ImU32}, x::ImVec4) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ColorConvertU32ToFloat4-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.ColorConvertU32ToFloat4",
    "category": "method",
    "text": "ColorConvertU32ToFloat4(in) -> ImVec4\n\nConvert ImU32 color to ImVec4. You could use Base.convert(::Type{ImVec4}, x::ImU32) instead.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ColorEdit3",
    "page": "API Reference",
    "title": "CImGui.ColorEdit3",
    "category": "function",
    "text": "ColorEdit3(label, col, flags=0) -> Bool\n\ntip: Tip\nthis function has a little colored preview square that can be left-clicked to open a picker, and right-clicked to open an option menu.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ColorEdit4",
    "page": "API Reference",
    "title": "CImGui.ColorEdit4",
    "category": "function",
    "text": "ColorEdit4(label, col, flags=0) -> Bool\n\ntip: Tip\nthis function has a little colored preview square that can be left-clicked to open a picker, and right-clicked to open an option menu.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ColorPicker3",
    "page": "API Reference",
    "title": "CImGui.ColorPicker3",
    "category": "function",
    "text": "ColorPicker3(label, col, flags=0)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ColorPicker4",
    "page": "API Reference",
    "title": "CImGui.ColorPicker4",
    "category": "function",
    "text": "ColorPicker4(label, col, flags=0, ref_col=C_NULL)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Columns",
    "page": "API Reference",
    "title": "CImGui.Columns",
    "category": "function",
    "text": "Columns(count=1, id=C_NULL, border=true)\n\nwarning: Work in progress!\nYou can also use SameLine(pos_x) for simplified columns. The columns API is work-in-progress and rather lacking (columns are arguably the worst part of dear imgui at the moment!)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Combo",
    "page": "API Reference",
    "title": "CImGui.Combo",
    "category": "function",
    "text": "Combo(label, current_item, items_getter::Union{Ptr,Base.CFunction}, data, items_count, popup_max_height_in_items=-1) -> Bool\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Combo",
    "page": "API Reference",
    "title": "CImGui.Combo",
    "category": "function",
    "text": "Combo(label, current_item, items_separated_by_zeros, popup_max_height_in_items=-1) -> Bool\n\nSeparate items with   within a string, end item-list with   . e.g. One Two Three \n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Combo",
    "page": "API Reference",
    "title": "CImGui.Combo",
    "category": "function",
    "text": "Combo(label, current_item, items::Vector, items_count, popup_max_height_in_items=-1) -> Bool\n\nThe old Combo api are helpers over BeginCombo/EndCombo which are kept available for convenience purpose.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.CreateContext-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.CreateContext",
    "category": "method",
    "text": "CreateContext() -> Ptr{ImGuiContext}\nCreateContext(shared_font_atlas::Ptr{ImFontAtlas}) -> Ptr{ImGuiContext}\n\nReturn a handle of ImGuiContext.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Destroy-Tuple{Ptr{CImGui.LibCImGui.ImGuiListClipper}}",
    "page": "API Reference",
    "title": "CImGui.Destroy",
    "category": "method",
    "text": "Destroy(handle::Ptr{ImGuiListClipper})\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Destroy-Tuple{Ptr{CImGui.LibCImGui.ImGuiTextBuffer}}",
    "page": "API Reference",
    "title": "CImGui.Destroy",
    "category": "method",
    "text": "Destroy(handle::Ptr{ImGuiTextBuffer})\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.DestroyContext-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.DestroyContext",
    "category": "method",
    "text": "DestroyContext()\nDestroyContext(ctx::Ptr{ImGuiContext})\n\nDestroy ImGuiContext. DestroyContext() will destroy current context.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.DragFloat",
    "page": "API Reference",
    "title": "CImGui.DragFloat",
    "category": "function",
    "text": "DragFloat(label, v, v_speed=1.0, v_min=0.0, v_max=0.0, format=\"%.3f\", power=1.0) -> Bool\n\nIf v_min >= v_max we have no bound.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.DragFloat2",
    "page": "API Reference",
    "title": "CImGui.DragFloat2",
    "category": "function",
    "text": "DragFloat2(label, v, v_speed=1.0, v_min=0.0, v_max=0.0, format=\"%.3f\", power=1.0) -> Bool\n\nThe expected number of elements to be accessible in v is 2.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.DragFloat3",
    "page": "API Reference",
    "title": "CImGui.DragFloat3",
    "category": "function",
    "text": "DragFloat3(label, v, v_speed=1.0, v_min=0.0, v_max=0.0, format=\"%.3f\", power=1.0) -> Bool\n\nThe expected number of elements to be accessible in v is 3.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.DragFloat4",
    "page": "API Reference",
    "title": "CImGui.DragFloat4",
    "category": "function",
    "text": "DragFloat4(label, v, v_speed=1.0, v_min=0.0, v_max=0.0, format=\"%.3f\", power=1.0) -> Bool\n\nThe expected number of elements to be accessible in v is 4.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.DragFloatRange2",
    "page": "API Reference",
    "title": "CImGui.DragFloatRange2",
    "category": "function",
    "text": "DragFloatRange2(label, v_current_min, v_current_max, v_speed=1.0, v_min=0.0, v_max=0.0, format=\"%.3f\", format_max=C_NULL, power=1.0) -> Bool\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.DragInt",
    "page": "API Reference",
    "title": "CImGui.DragInt",
    "category": "function",
    "text": "DragInt(label, v, v_speed=1.0, v_min=0, v_max=0, format=\"%d\")\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.DragInt2",
    "page": "API Reference",
    "title": "CImGui.DragInt2",
    "category": "function",
    "text": "DragInt2(label, v, v_speed=1.0, v_min=0, v_max=0, format=\"%d\")\n\nThe expected number of elements to be accessible in v is 2.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.DragInt3",
    "page": "API Reference",
    "title": "CImGui.DragInt3",
    "category": "function",
    "text": "DragInt3(label, v, v_speed=1.0, v_min=0, v_max=0, format=\"%d\")\n\nThe expected number of elements to be accessible in v is 3.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.DragInt4",
    "page": "API Reference",
    "title": "CImGui.DragInt4",
    "category": "function",
    "text": "DragInt4(label, v, v_speed=1.0, v_min=0, v_max=0, format=\"%d\")\n\nThe expected number of elements to be accessible in v is 4.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.DragIntRange2",
    "page": "API Reference",
    "title": "CImGui.DragIntRange2",
    "category": "function",
    "text": "DragIntRange2(label, v_current_min, v_current_max, v_speed=1.0, v_min=0, v_max=0, format=\"%d\", format_max=C_NULL)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.DragScalar",
    "page": "API Reference",
    "title": "CImGui.DragScalar",
    "category": "function",
    "text": "DragScalar(label, data_type, v, v_speed, v_min=C_NULL, v_max=C_NULL, format=C_NULL, power=1.0)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.DragScalarN",
    "page": "API Reference",
    "title": "CImGui.DragScalarN",
    "category": "function",
    "text": "DragScalarN(label, data_type, v, components, v_speed, v_min=C_NULL, v_max=C_NULL, format=C_NULL, power=1.0)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Dummy-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.Dummy",
    "category": "method",
    "text": "Dummy(size)\nDummy(x, y)\n\nAdd a dummy item of given size.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Empty-Tuple{Ptr{CImGui.LibCImGui.ImGuiTextBuffer}}",
    "page": "API Reference",
    "title": "CImGui.Empty",
    "category": "method",
    "text": "Empty(handle::Ptr{ImGuiTextBuffer}) -> Bool\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.End-Tuple{Ptr{CImGui.LibCImGui.ImGuiListClipper}}",
    "page": "API Reference",
    "title": "CImGui.End",
    "category": "method",
    "text": "End(handle::Ptr{ImGuiListClipper})\n\nAutomatically called on the last call of Step that returns false.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.End-Tuple{Ptr{CImGui.LibCImGui.ImGuiTextBuffer}}",
    "page": "API Reference",
    "title": "CImGui.End",
    "category": "method",
    "text": "End(handle::Ptr{ImGuiTextBuffer}) -> Cstring\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.End-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.End",
    "category": "method",
    "text": "End()\n\nPop window from the stack. See also Begin.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.EndChild-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.EndChild",
    "category": "method",
    "text": "EndChild()\n\nSee also BeginChild.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.EndChildFrame-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.EndChildFrame",
    "category": "method",
    "text": "EndChildFrame()\n\nnote: Note\nAlways call EndChildFrame() regardless of BeginChildFrame return values which indicates a collapsed/clipped window.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.EndCombo-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.EndCombo",
    "category": "method",
    "text": "EndCombo()\n\nnote: Note\nOnly call EndCombo if BeginCombo returns true!\n\nSee also BeginCombo.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.EndDragDropSource-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.EndDragDropSource",
    "category": "method",
    "text": "EndDragDropSource()\n\nnote: Note\nOnly call EndDragDropSource() if BeginDragDropSource returns true!\n\nnote: BETA API\nMissing Demo code. API may evolve.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.EndDragDropTarget-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.EndDragDropTarget",
    "category": "method",
    "text": "EndDragDropTarget()\n\nnote: Note\nOnly call EndDragDropTarget if BeginDragDropTarget returns true!\n\nnote: BETA API\nMissing Demo code. API may evolve.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.EndFrame-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.EndFrame",
    "category": "method",
    "text": "EndFrame()\n\nCalling this function ends the ImGui frame. This function is automatically called by Render, so you likely don\'t need to call it yourself directly. If you don\'t need to render data (skipping rendering), you may call EndFrame but you\'ll have wasted CPU already! If you don\'t need to render, better to not create any imgui windows and not call NewFrame at all!\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.EndGroup-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.EndGroup",
    "category": "method",
    "text": "EndGroup()\n\nSee BeginGroup.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.EndMainMenuBar-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.EndMainMenuBar",
    "category": "method",
    "text": "EndMainMenuBar()\n\nnote: Note\nOnly call EndMainMenuBar if BeginMainMenuBar returns true!\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.EndMenu-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.EndMenu",
    "category": "method",
    "text": "EndMenu()\n\nnote: Note\nOnly call EndMenu if BeginMenu returns true!\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.EndMenuBar-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.EndMenuBar",
    "category": "method",
    "text": "EndMenuBar()\n\nnote: Note\nOnly call EndMenuBar if BeginMenuBar returns true!\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.EndPopup-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.EndPopup",
    "category": "method",
    "text": "EndPopup()\n\nSee BeginPopup, BeginPopupContextItem, BeginPopupContextWindow, BeginPopupContextVoid, BeginPopupModal.\n\nnote: Note\nOnly call EndPopup if BeginPopupXXX() returns true!\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.EndTabBar-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.EndTabBar",
    "category": "method",
    "text": "EndTabBar()\n\nOnly call EndTabBar if BeginTabBar returns true!\n\nnote: BETA API\nAPI may evolve!\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.EndTabItem-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.EndTabItem",
    "category": "method",
    "text": "EndTabItem()\n\nOnly call EndTabItem if BeginTabItem returns true!\n\nnote: BETA API\nAPI may evolve!\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.EndTooltip-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.EndTooltip",
    "category": "method",
    "text": "EndTooltip()\n\nSee BeginTooltip.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetClipRectMax-Tuple{Ptr{CImGui.LibCImGui.ImDrawList}}",
    "page": "API Reference",
    "title": "CImGui.GetClipRectMax",
    "category": "method",
    "text": "GetClipRectMax(handle::Ptr{ImDrawList}) -> ImVec2\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetClipRectMin-Tuple{Ptr{CImGui.LibCImGui.ImDrawList}}",
    "page": "API Reference",
    "title": "CImGui.GetClipRectMin",
    "category": "method",
    "text": "GetClipRectMin(handle::Ptr{ImDrawList}) -> ImVec2\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetClipboardText-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetClipboardText",
    "category": "method",
    "text": "GetClipboardText() -> String\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetColorU32",
    "page": "API Reference",
    "title": "CImGui.GetColorU32",
    "category": "function",
    "text": "GetColorU32(r, g, b, a) -> ImU32\nGetColorU32(col::ImVec4) -> ImU32\nGetColorU32(col::ImU32) -> ImU32\nGetColorU32(idx::Integer, alpha_mul=1.0) -> ImU32\n\nRetrieve given style color with style alpha applied and optional extra alpha multiplier.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetColumnIndex-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetColumnIndex",
    "category": "method",
    "text": "GetColumnIndex() -> Cint\n\nReturn current column index.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetColumnOffset",
    "page": "API Reference",
    "title": "CImGui.GetColumnOffset",
    "category": "function",
    "text": "GetColumnOffset(column_index=-1) -> Cfloat\n\nGet position of column line (in pixels, from the left side of the contents region). Pass -1 to use current column, otherwise 0..GetColumnsCount() inclusive. Column 0 is typically 0.0.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetColumnWidth",
    "page": "API Reference",
    "title": "CImGui.GetColumnWidth",
    "category": "function",
    "text": "GetColumnWidth(column_index=-1) -> Cfloat\n\nReturn column width (in pixels). Pass -1 to use current column.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetColumnsCount-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetColumnsCount",
    "category": "method",
    "text": "GetColumnsCount() -> Cint\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetContentRegionAvail-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetContentRegionAvail",
    "category": "method",
    "text": "GetContentRegionAvail() -> ImVec2\n\nReturn GetContentRegionMax() - GetCursorPos().\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetContentRegionAvailWidth-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetContentRegionAvailWidth",
    "category": "method",
    "text": "GetContentRegionAvailWidth() -> Cfloat\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetContentRegionMax-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetContentRegionMax",
    "category": "method",
    "text": "GetContentRegionMax() -> ImVec2\n\nCurrent content boundaries (typically window boundaries including scrolling, or current column boundaries), in windows coordinates.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetCurrentContext-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetCurrentContext",
    "category": "method",
    "text": "GetCurrentContext() -> Ptr{ImGuiContext}\n\nReturn a handle of the current context.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetCursorPos-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetCursorPos",
    "category": "method",
    "text": "GetCursorPos() -> ImVec2\n\nReturn cursor position which is relative to window position.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetCursorPosX-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetCursorPosX",
    "category": "method",
    "text": "GetCursorPosX() -> Cfloat\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetCursorPosY-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetCursorPosY",
    "category": "method",
    "text": "GetCursorPosY() -> Cfloat\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetCursorScreenPos-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetCursorScreenPos",
    "category": "method",
    "text": "GetCursorScreenPos() -> ImVec2\n\nReturn cursor position in absolute screen coordinates [0..io.DisplaySize]. This is useful to work with ImDrawList API.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetCursorStartPos-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetCursorStartPos",
    "category": "method",
    "text": "GetCursorStartPos() -> ImVec2\n\nReturn initial cursor position.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetDragDropPayload-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetDragDropPayload",
    "category": "method",
    "text": "GetDragDropPayload() -> Ptr{ImGuiPayload}\n\nPeek directly into the current payload from anywhere. May return C_NULL. Use IsDataType to test for the payload type.\n\nnote: BETA API\nMissing Demo code. API may evolve.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetDrawData-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetDrawData",
    "category": "method",
    "text": "GetDrawData() -> Ptr{ImDrawData}\n\nReturn a handle of ImDrawData which is valid after Render and until the next call to NewFrame. This is what you have to render.\n\nwarning: Obsolete\nThis used to be passed to your ImGuiIO.RenderDrawListsFn function.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetDrawListSharedData-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetDrawListSharedData",
    "category": "method",
    "text": "GetDrawListSharedData() -> Ptr{ImDrawListSharedData}\n\nThis function might be used when creating your own ImDrawList instances.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetFont-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetFont",
    "category": "method",
    "text": "GetFont() -> Ptr{ImFont}\n\nGet current font.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetFontSize-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetFontSize",
    "category": "method",
    "text": "GetFontSize() -> Cfloat\n\nGet current font size (= height in pixels) of current font with current scale applied.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetFontTexUvWhitePixel-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetFontTexUvWhitePixel",
    "category": "method",
    "text": "GetFontTexUvWhitePixel() -> ImVec2\n\nGet UV coordinate for a while pixel, useful to draw custom shapes via the ImDrawList API.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetFrameCount-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetFrameCount",
    "category": "method",
    "text": "GetFrameCount() -> Cint\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetFrameHeight-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetFrameHeight",
    "category": "method",
    "text": "GetFrameHeight() -> Cfloat\n\nReturn FontSize + ImGuiStyle.FramePadding.y * 2.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetFrameHeightWithSpacing-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetFrameHeightWithSpacing",
    "category": "method",
    "text": "GetFrameHeightWithSpacing() -> Cfloat\n\nReturn FontSize + ImGuiStyle.FramePadding.y * 2 + ImGuiStyle.ItemSpacing.y (distance in pixels between 2 consecutive lines of framed widgets).\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetGlyphRangesChineseFull-Tuple{Ptr{CImGui.LibCImGui.ImFontAtlas}}",
    "page": "API Reference",
    "title": "CImGui.GetGlyphRangesChineseFull",
    "category": "method",
    "text": "GetGlyphRangesChineseFull(self::Ptr{ImFontAtlas}) -> Ptr{ImWchar}\n\nDefault + Half-Width + Japanese Hiragana/Katakana + full set of about 21000 CJK Unified Ideographs.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetGlyphRangesChineseSimplifiedCommon-Tuple{Ptr{CImGui.LibCImGui.ImFontAtlas}}",
    "page": "API Reference",
    "title": "CImGui.GetGlyphRangesChineseSimplifiedCommon",
    "category": "method",
    "text": "GetGlyphRangesChineseSimplifiedCommon(self::Ptr{ImFontAtlas}) -> Ptr{ImWchar}\n\nDefault + Half-Width + Japanese Hiragana/Katakana + set of 2500 CJK Unified Ideographs for common simplified Chinese.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetGlyphRangesCyrillic-Tuple{Ptr{CImGui.LibCImGui.ImFontAtlas}}",
    "page": "API Reference",
    "title": "CImGui.GetGlyphRangesCyrillic",
    "category": "method",
    "text": "GetGlyphRangesCyrillic(self::Ptr{ImFontAtlas}) -> Ptr{ImWchar}\n\nDefault + about 400 Cyrillic characters.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetGlyphRangesDefault-Tuple{Ptr{CImGui.LibCImGui.ImFontAtlas}}",
    "page": "API Reference",
    "title": "CImGui.GetGlyphRangesDefault",
    "category": "method",
    "text": "GetGlyphRangesDefault(self::Ptr{ImFontAtlas}) -> Ptr{ImWchar}\n\nBasic Latin, Extended Latin.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetGlyphRangesJapanese-Tuple{Ptr{CImGui.LibCImGui.ImFontAtlas}}",
    "page": "API Reference",
    "title": "CImGui.GetGlyphRangesJapanese",
    "category": "method",
    "text": "GetGlyphRangesJapanese(self::Ptr{ImFontAtlas}) -> Ptr{ImWchar}\n\nDefault + Hiragana, Katakana, Half-Width, Selection of 1946 Ideographs.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetGlyphRangesKorean-Tuple{Ptr{CImGui.LibCImGui.ImFontAtlas}}",
    "page": "API Reference",
    "title": "CImGui.GetGlyphRangesKorean",
    "category": "method",
    "text": "GetGlyphRangesKorean(self::Ptr{ImFontAtlas}) -> Ptr{ImWchar}\n\nDefault + Korean characters.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetGlyphRangesThai-Tuple{Ptr{CImGui.LibCImGui.ImFontAtlas}}",
    "page": "API Reference",
    "title": "CImGui.GetGlyphRangesThai",
    "category": "method",
    "text": "GetGlyphRangesThai(self::Ptr{ImFontAtlas}) -> Ptr{ImWchar}\n\nDefault + Thai characters.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetID-Tuple{AbstractString}",
    "page": "API Reference",
    "title": "CImGui.GetID",
    "category": "method",
    "text": "GetID(str_id::AbstractString) -> ImGuiID\nGetID(str_id_begin::AbstractString, str_id_end::AbstractString) -> ImGuiID\nGetID(ptr_id::Ptr) -> ImGuiID\n\nCalculate unique ID (hash of whole ID stack + given parameter). e.g. if you want to query into ImGuiStorage yourself.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetIO-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetIO",
    "category": "method",
    "text": "GetIO() -> Ptr{ImGuiIO}\n\nReturn a handle of ImGuiIO which is for accessing the IO structure:\n\nmouse/keyboard/gamepad inputs\ntime\nvarious configuration options/flags\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetItemRectMax-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetItemRectMax",
    "category": "method",
    "text": "GetItemRectMax() -> ImVec2\n\nReturn bounding rectangle of last item, in screen space. See Demo Window under \"Widgets->Querying Status\" for an interactive visualization of many of those functions.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetItemRectMin-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetItemRectMin",
    "category": "method",
    "text": "GetItemRectMin() -> ImVec2\n\nReturn bounding rectangle of last item, in screen space. See Demo Window under \"Widgets->Querying Status\" for an interactive visualization of many of those functions.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetItemRectSize-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetItemRectSize",
    "category": "method",
    "text": "GetItemRectSize() -> ImVec2\n\nReturn size of last item, in screen space. See Demo Window under \"Widgets->Querying Status\" for an interactive visualization of many of those functions.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetKeyIndex-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.GetKeyIndex",
    "category": "method",
    "text": "GetKeyIndex(imgui_key) -> Cint\n\nMap ImGuiKey_* values into user\'s key index. == io.KeyMap[key]\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetKeyPressedAmount-Tuple{Any,Any,Any}",
    "page": "API Reference",
    "title": "CImGui.GetKeyPressedAmount",
    "category": "method",
    "text": "GetKeyPressedAmount(key_index, repeat_delay, rate) -> Cint\n\nUses provided repeat rate/delay. Return a count, most often 0 or 1 but might be >1 if RepeatRate is small enough that DeltaTime > RepeatRate\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetMouseCursor-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetMouseCursor",
    "category": "method",
    "text": "GetMouseCursor() -> ImGuiMouseCursor\n\nGet desired cursor type, reset in ImGui::NewFrame(), this is updated during the frame. valid before Render. If you use software rendering by setting io.MouseDrawCursor ImGui will render those for you.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetMouseDragDelta",
    "page": "API Reference",
    "title": "CImGui.GetMouseDragDelta",
    "category": "function",
    "text": "GetMouseDragDelta(button=0, lock_threshold=-1.0) -> ImVec2\n\nDragging amount since clicking. if lock_threshold < -1.0f uses io.MouseDraggingThreshold.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetMousePos-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetMousePos",
    "category": "method",
    "text": "GetMousePos() -> ImVec2\n\nShortcut to ImGui::GetIO().MousePos provided by user, to be consistent with other calls.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetMousePosOnOpeningCurrentPopup-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetMousePosOnOpeningCurrentPopup",
    "category": "method",
    "text": "GetMousePosOnOpeningCurrentPopup() -> ImVec2\n\nRetrieve backup of mouse position at the time of opening popup we have BeginPopup into.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetOverlayDrawList-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetOverlayDrawList",
    "category": "method",
    "text": "GetOverlayDrawList() -> Ptr{ImDrawList}\n\nThis draw list will be the last rendered one, useful to quickly draw overlays shapes/text.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetScrollMaxX-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetScrollMaxX",
    "category": "method",
    "text": "GetScrollMaxX() -> Cfloat\n\nReturn maximum scrolling amount ~~ ContentSize.X - WindowSize.X.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetScrollMaxY-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetScrollMaxY",
    "category": "method",
    "text": "GetScrollMaxY() -> Cfloat\n\nReturn maximum scrolling amount ~~ ContentSize.Y - WindowSize.Y.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetScrollX-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetScrollX",
    "category": "method",
    "text": "GetScrollX() -> Cfloat\n\nReturn scrolling amount [0..GetScrollMaxX()]. See also GetScrollMaxX.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetScrollY-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetScrollY",
    "category": "method",
    "text": "GetScrollY() -> Cfloat\n\nReturn scrolling amount [0..GetScrollMaxY()].\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetStateStorage-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetStateStorage",
    "category": "method",
    "text": "GetStateStorage()\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetStyle-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetStyle",
    "category": "method",
    "text": "GetStyle() -> Ptr{ImGuiStyle}\n\nReturn a handle of ImGuiStyle which is for accessing the Style structure (colors, sizes).\n\nnote: Note\nAlways use PushStyleColor, PushStyleVar to modify style mid-frame.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetStyleColorName-Tuple{Integer}",
    "page": "API Reference",
    "title": "CImGui.GetStyleColorName",
    "category": "method",
    "text": "GetStyleColorName(idx::Integer) -> String\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetStyleColorVec4-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.GetStyleColorVec4",
    "category": "method",
    "text": "GetStyleColorVec4(idx) -> ImVec4\n\nRetrieve style color as stored in [ImGuiStyle] structure. Use to feed back into PushStyleColor, otherwise use GetColorU32 to get style color with style alpha baked in.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetTexDataAsAlpha8",
    "page": "API Reference",
    "title": "CImGui.GetTexDataAsAlpha8",
    "category": "function",
    "text": "GetTexDataAsAlpha8(self::Ptr{ImFontAtlas}, out_pixels, out_width, out_height, out_bytes_per_pixel=C_NULL)\n\n1 byte per-pixel.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetTexDataAsRGBA32",
    "page": "API Reference",
    "title": "CImGui.GetTexDataAsRGBA32",
    "category": "function",
    "text": "GetTexDataAsRGBA32(self::Ptr{ImFontAtlas}, out_pixels, out_width, out_height, out_bytes_per_pixel=C_NULL)\n\n4 bytes-per-pixel.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetTextLineHeight-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetTextLineHeight",
    "category": "method",
    "text": "GetTextLineHeight() -> Cfloat\n\nReturn FontSize.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetTextLineHeightWithSpacing-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetTextLineHeightWithSpacing",
    "category": "method",
    "text": "GetTextLineHeightWithSpacing() -> Cfloat\n\nReturn FontSize + ImGuiStyle.ItemSpacing.y (distance in pixels between 2 consecutive lines of text).\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetTime-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetTime",
    "category": "method",
    "text": "GetTime() -> Cdouble\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetTreeNodeToLabelSpacing-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetTreeNodeToLabelSpacing",
    "category": "method",
    "text": "GetTreeNodeToLabelSpacing()\n\nHorizontal distance preceding label when using TreeNode*() or Bullet() == (g.FontSize + style.FramePadding.x*2) for a regular unframed TreeNode.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetVersion-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetVersion",
    "category": "method",
    "text": "GetVersion() -> Cstring\n\nGet the compiled version string e.g. \"1.23\"\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetWindowContentRegionMax-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetWindowContentRegionMax",
    "category": "method",
    "text": "GetWindowContentRegionMax() -> ImVec2\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetWindowContentRegionMin-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetWindowContentRegionMin",
    "category": "method",
    "text": "GetWindowContentRegionMin() -> ImVec2\n\nReturn content boundaries min (roughly (0,0)-Scroll), in window coordinates.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetWindowContentRegionWidth-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetWindowContentRegionWidth",
    "category": "method",
    "text": "GetWindowContentRegionWidth() -> ImVec2\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetWindowDrawList-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetWindowDrawList",
    "category": "method",
    "text": "GetWindowDrawList() -> Ptr{ImDrawList}\n\nReturn draw list associated to the window, to append your own drawing primitives.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetWindowHeight-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetWindowHeight",
    "category": "method",
    "text": "GetWindowHeight() -> Cfloat\n\nReturn current window height (shortcut for GetWindowSize().y).\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetWindowPos-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetWindowPos",
    "category": "method",
    "text": "GetWindowPos() -> ImVec2\n\nReturn current window position in screen space (useful if you want to do your own drawing via the ImDrawList API.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetWindowSize-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetWindowSize",
    "category": "method",
    "text": "GetWindowSize() -> ImVec2\n\nReturn current window size.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.GetWindowWidth-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.GetWindowWidth",
    "category": "method",
    "text": "GetWindowWidth() -> Cfloat\n\nReturn current window width (shortcut for GetWindowSize().x).\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.HSV",
    "page": "API Reference",
    "title": "CImGui.HSV",
    "category": "function",
    "text": "HSV(h, s, v, a=1.0) -> ImVec4\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Image",
    "page": "API Reference",
    "title": "CImGui.Image",
    "category": "function",
    "text": "Image(user_texture_id, size, uv0=(0,0), uv1=(1,1), tint_col=(1,1,1,1), border_col=(0,0,0,0))\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ImageButton",
    "page": "API Reference",
    "title": "CImGui.ImageButton",
    "category": "function",
    "text": "ImageButton(user_texture_id, size, uv0=(0,0), uv1=(1,1), frame_padding=-1, bg_col=(0,0,0,0), tint_col=(1,1,1,1)) -> Bool\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Indent",
    "page": "API Reference",
    "title": "CImGui.Indent",
    "category": "function",
    "text": "Indent()\nIndent(indent_w)\n\nMove content position toward the right, by ImGuiStyle.IndentSpacing or indent_w if indent_w != 0.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.InputDouble",
    "page": "API Reference",
    "title": "CImGui.InputDouble",
    "category": "function",
    "text": "InputDouble(label, v, step=0.0, step_fast=0.0, format=\"%.6f\", flags=0) -> Bool\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.InputFloat",
    "page": "API Reference",
    "title": "CImGui.InputFloat",
    "category": "function",
    "text": "InputFloat(label, v, step=0, step_fast=0, format=\"%.3f\", flags=0) -> Bool\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.InputFloat2",
    "page": "API Reference",
    "title": "CImGui.InputFloat2",
    "category": "function",
    "text": "InputFloat2(label, v, format=\"%.3f\", flags=0) -> Bool\n\nThe expected number of elements to be accessible in v is 2.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.InputFloat3",
    "page": "API Reference",
    "title": "CImGui.InputFloat3",
    "category": "function",
    "text": "InputFloat3(label, v, format=\"%.3f\", flags=0) -> Bool\n\nThe expected number of elements to be accessible in v is 3.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.InputFloat4",
    "page": "API Reference",
    "title": "CImGui.InputFloat4",
    "category": "function",
    "text": "InputFloat4(label, v, format=\"%.3f\", flags=0) -> Bool\n\nThe expected number of elements to be accessible in v is 4.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.InputInt",
    "page": "API Reference",
    "title": "CImGui.InputInt",
    "category": "function",
    "text": "InputInt(label, v, step=1, step_fast=100, flags=0) -> Bool\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.InputInt2",
    "page": "API Reference",
    "title": "CImGui.InputInt2",
    "category": "function",
    "text": "InputInt2(label, v, flags=0) -> Bool\n\nThe expected number of elements to be accessible in v is 2.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.InputInt3",
    "page": "API Reference",
    "title": "CImGui.InputInt3",
    "category": "function",
    "text": "InputInt3(label, v, flags=0) -> Bool\n\nThe expected number of elements to be accessible in v is 3.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.InputInt4",
    "page": "API Reference",
    "title": "CImGui.InputInt4",
    "category": "function",
    "text": "InputInt4(label, v, flags=0) -> Bool\n\nThe expected number of elements to be accessible in v is 4.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.InputScalar",
    "page": "API Reference",
    "title": "CImGui.InputScalar",
    "category": "function",
    "text": "InputScalar(label, data_type, v, step=C_NULL, step_fast=C_NULL, format=C_NULL, flags=0) -> Bool\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.InputScalarN",
    "page": "API Reference",
    "title": "CImGui.InputScalarN",
    "category": "function",
    "text": "InputScalarN(label, data_type, v, components, step=C_NULL, step_fast=C_NULL, format=C_NULL, flags=0) -> Bool\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.InputText",
    "page": "API Reference",
    "title": "CImGui.InputText",
    "category": "function",
    "text": "InputText(label, buf, buf_size, flags=0, callback=C_NULL, user_data=C_NULL) -> Bool\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.InputTextMultiline",
    "page": "API Reference",
    "title": "CImGui.InputTextMultiline",
    "category": "function",
    "text": "InputTextMultiline(label, buf, buf_size, size=(0,0), flags=0, callback=C_NULL, user_data=C_NULL) -> Bool\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.InvisibleButton-Tuple{Any,Any}",
    "page": "API Reference",
    "title": "CImGui.InvisibleButton",
    "category": "method",
    "text": "InvisibleButton(str_id, size) -> Bool\n\nReturn true when the value has been changed or when pressed/selected. Create a button without the visuals, useful to build custom behaviors using the public api along with IsItemActive, IsItemHovered, etc.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsAnyItemActive-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.IsAnyItemActive",
    "category": "method",
    "text": "IsAnyItemActive() -> Bool\n\nSee Demo Window under \"Widgets->Querying Status\" for an interactive visualization of many of those functions.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsAnyItemFocused-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.IsAnyItemFocused",
    "category": "method",
    "text": " IsAnyItemFocused() -> Bool\n\nSee Demo Window under \"Widgets->Querying Status\" for an interactive visualization of many of those functions.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsAnyItemHovered-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.IsAnyItemHovered",
    "category": "method",
    "text": "IsAnyItemHovered() -> Bool\n\nSee Demo Window under \"Widgets->Querying Status\" for an interactive visualization of many of those functions.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsAnyMouseDown-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.IsAnyMouseDown",
    "category": "method",
    "text": "IsAnyMouseDown() -> Bool\n\nIs any mouse button held.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsBuilt-Tuple{Ptr{CImGui.LibCImGui.ImFontAtlas}}",
    "page": "API Reference",
    "title": "CImGui.IsBuilt",
    "category": "method",
    "text": "IsBuilt(self::Ptr{ImFontAtlas}) -> Bool\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsItemActivated-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.IsItemActivated",
    "category": "method",
    "text": "IsItemActivated() -> Bool\n\nWas the last item just made active (item was previously inactive).\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsItemActive-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.IsItemActive",
    "category": "method",
    "text": "IsItemActive() -> Bool\n\nIs the last item active? (e.g. button being held, text field being edited. This will continuously return true while holding mouse button on an item. Items that don\'t interact will always return false) See Demo Window under \"Widgets->Querying Status\" for an interactive visualization of many of those functions.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsItemClicked",
    "page": "API Reference",
    "title": "CImGui.IsItemClicked",
    "category": "function",
    "text": "IsItemClicked() -> Bool\nIsItemClicked(mouse_button=0) -> Bool\n\nIs the last item clicked? (e.g. button/node just clicked on) == IsMouseClicked(mouse_button) && IsItemHovered. See Demo Window under \"Widgets->Querying Status\" for an interactive visualization of many of those functions.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsItemDeactivated-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.IsItemDeactivated",
    "category": "method",
    "text": "IsItemDeactivated() -> Bool\n\nWas the last item just made inactive (item was previously active). Useful for Undo/Redo patterns with widgets that requires continuous editing. See Demo Window under \"Widgets->Querying Status\" for an interactive visualization of many of those functions.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsItemDeactivatedAfterEdit-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.IsItemDeactivatedAfterEdit",
    "category": "method",
    "text": "IsItemDeactivatedAfterEdit() -> Bool\n\nWas the last item just made inactive and made a value change when it was active? (e.g. Slider/Drag moved). Useful for Undo/Redo patterns with widgets that requires continuous editing. Note that you may get false positives (some widgets such as Combo/ListBox/Selectable will return true even when clicking an already selected item). See Demo Window under \"Widgets->Querying Status\" for an interactive visualization of many of those functions.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsItemEdited-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.IsItemEdited",
    "category": "method",
    "text": "IsItemEdited() -> Bool\n\nDid the last item modify its underlying value this frame? or was pressed? This is generally the same as the \"bool\" return value of many widgets. See Demo Window under \"Widgets->Querying Status\" for an interactive visualization of many of those functions.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsItemFocused-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.IsItemFocused",
    "category": "method",
    "text": "IsItemFocused() -> Bool\n\nIs the last item focused for keyboard/gamepad navigation? See Demo Window under \"Widgets->Querying Status\" for an interactive visualization of many of those functions.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsItemHovered",
    "page": "API Reference",
    "title": "CImGui.IsItemHovered",
    "category": "function",
    "text": "IsItemHovered(flags=ImGuiHoveredFlags_(0)) -> Bool\n\nIs the last item hovered? (and usable, aka not blocked by a popup, etc.). See the output of CImGui.GetFlags(CImGui.ImGuiHoveredFlags_) for options:\n\nusing CImGui, Markdown\nCImGui.ShowFlags(CImGui.ImGuiHoveredFlags_) |> Markdown.parse\n\nSee Demo Window under \"Widgets->Querying Status\" for an interactive visualization of many of those functions.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsItemVisible-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.IsItemVisible",
    "category": "method",
    "text": "IsItemVisible() -> Bool\n\nIs the last item visible? (items may be out of sight because of clipping/scrolling). See Demo Window under \"Widgets->Querying Status\" for an interactive visualization of many of those functions.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsKeyDown-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.IsKeyDown",
    "category": "method",
    "text": "IsKeyDown(user_key_index) -> Bool\n\nIs key being held. == io.KeysDown[userkeyindex]. note that imgui doesn\'t know the semantic of each entry of io.KeysDown[]. Use your own indices/enums according to how your backend/engine stored them into io.KeysDown[]!\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsKeyPressed",
    "page": "API Reference",
    "title": "CImGui.IsKeyPressed",
    "category": "function",
    "text": "IsKeyPressed(user_key_index, repeat=true) -> Bool\n\nWas key pressed (went from !Down to Down). If repeat=true, uses io.KeyRepeatDelay / KeyRepeatRate.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsKeyReleased-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.IsKeyReleased",
    "category": "method",
    "text": "IsKeyReleased(user_key_index) -> Bool\n\nWas key released (went from Down to !Down).\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsMouseClicked",
    "page": "API Reference",
    "title": "CImGui.IsMouseClicked",
    "category": "function",
    "text": "IsMouseClicked(button, repeat=false) -> Bool\n\nDid mouse button clicked (went from !Down to Down) (0=left, 1=right, 2=middle)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsMouseDoubleClicked-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.IsMouseDoubleClicked",
    "category": "method",
    "text": "IsMouseDoubleClicked(button) -> Bool\n\nDid mouse button double-clicked. a double-click returns false in IsMouseClicked. Uses io.MouseDoubleClickTime.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsMouseDown-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.IsMouseDown",
    "category": "method",
    "text": "IsMouseDown(button) -> Bool\n\nIs mouse button held (0=left, 1=right, 2=middle).\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsMouseDragging",
    "page": "API Reference",
    "title": "CImGui.IsMouseDragging",
    "category": "function",
    "text": "IsMouseDragging(button=0, lock_threshold=-1.0) -> Bool\n\nIs mouse dragging. If lock_threshold < -1.0f uses io.MouseDraggingThreshold.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsMouseHoveringRect",
    "page": "API Reference",
    "title": "CImGui.IsMouseHoveringRect",
    "category": "function",
    "text": "IsMouseHoveringRect(r_min, r_max, clip=true) -> Bool\n\nIs mouse hovering given bounding rect (in screen space). Clipped by current clipping settings, but disregarding of other consideration of focus/window ordering/popup-block.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsMousePosValid",
    "page": "API Reference",
    "title": "CImGui.IsMousePosValid",
    "category": "function",
    "text": "IsMousePosValid(mouse_pos=C_NULL) -> Bool\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsMouseReleased-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.IsMouseReleased",
    "category": "method",
    "text": "IsMouseReleased(button) -> Bool\n\nDid mouse button released (went from Down to !Down).\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsPopupOpen-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.IsPopupOpen",
    "category": "method",
    "text": "IsPopupOpen(str_id) -> Bool\n\nReturn true if the popup is open.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsRectVisibleVec2-Tuple{Any,Any}",
    "page": "API Reference",
    "title": "CImGui.IsRectVisibleVec2",
    "category": "method",
    "text": "IsRectVisibleVec2(rect_min::ImVec2, rect_max::ImVec2) -> Bool\nIsRectVisibleVec2(rect_min::NTuple{2}, rect_max::NTuple{2}) -> Bool\n\nTest if rectangle (in screen space) is visible / not clipped. to perform coarse clipping on user\'s side.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsWindowAppearing-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.IsWindowAppearing",
    "category": "method",
    "text": "IsWindowAppearing() -> Bool\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsWindowCollapsed-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.IsWindowCollapsed",
    "category": "method",
    "text": "IsWindowCollapsed() -> Bool\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsWindowFocused",
    "page": "API Reference",
    "title": "CImGui.IsWindowFocused",
    "category": "function",
    "text": "IsWindowFocused(flags=0) -> Bool\n\nIs current window focused? or its root/child, depending on flags. See the output of CImGui.GetFlags(CImGui.ImGuiFocusedFlags_) for options:\n\nusing CImGui, Markdown\nCImGui.ShowFlags(CImGui.ImGuiFocusedFlags_) |> Markdown.parse\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.IsWindowHovered",
    "page": "API Reference",
    "title": "CImGui.IsWindowHovered",
    "category": "function",
    "text": "IsWindowHovered(flags=0) -> Bool\n\nIs current window hovered (and typically: not blocked by a popup/modal)? See the output of CImGui.GetFlags(CImGui.ImGuiHoveredFlags_) for options:\n\nusing CImGui, Markdown\nCImGui.ShowFlags(CImGui.ImGuiHoveredFlags_) |> Markdown.parse\n\nnote: Note\nIf you are trying to check whether your mouse should be dispatched to imgui or to your app, you should use the ImGuiIO.WantCaptureMouse boolean for that! Please read the FAQ!\n\ntip: FAQ\nQ: How can I tell whether to dispatch mouse/keyboard to imgui or to my application?A: You can read the ImGuiIO.WantCaptureMouse, ImGuiIO.WantCaptureKeyboard and ImGuiIO.WantTextInput flags from the ImGuiIO structure, for example:if CImGui.Get_WantCaptureMouse(CImGui.GetIO())\n    # ...\nendWhen ImGuiIO.WantCaptureMouse is set, imgui wants to use your mouse state, and you   may want to discard/hide the inputs from the rest of your application.\nWhen ImGuiIO.WantCaptureKeyboard is set, imgui wants to use your keyboard state,   and you may want to discard/hide the inputs from the rest of your application.\nWhen ImGuiIO.WantTextInput is set to may want to notify your OS to popup an on-screen   keyboard, if available (e.g. on a mobile phone, or console OS).\n\nnote: Note\nYou should always pass your mouse/keyboard inputs to imgui, even when the  ImGuiIO.WantCaptureXXX flag are set false. This is because imgui needs to detect that you  clicked in the void to unfocus its own windows.\nThe ImGuiIO.WantCaptureMouse is more accurate that any attempt to \"check if the mouse  is hovering a window\" (don\'t do that!). It handle mouse dragging correctly (both dragging  that started over your application or over an imgui window) and handle e.g. modal windows  blocking inputs. Those flags are updated by NewFrame. Preferably read the flags  after calling NewFrame if you can afford it, but reading them before is also  perfectly fine, as the bool toggle fairly rarely. If you have on a touch device, you  might find use for an early call to UpdateHoveredWindowAndCaptureFlags().\nText input widget releases focus on \"Return KeyDown\", so the subsequent \"Return KeyUp\"  event that your application receive will typically have ImGuiIO.WantCaptureKeyboard=false.  Depending on your application logic it may or not be inconvenient. You might want to  track which key-downs were targeted for Dear ImGui, e.g. with an array of bool, and  filter out the corresponding key-ups.)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.LabelText-Tuple{Any,Any}",
    "page": "API Reference",
    "title": "CImGui.LabelText",
    "category": "method",
    "text": "LabelText(label, formatted_text)\n\nDisplay text+label aligned the same way as value+label widgets.\n\nwarning: Limited support\nFormatting is not supported which means you need to pass a formatted string to this function. It\'s recommended to use Julia stdlib Printf\'s @sprintf as a workaround when translating C/C++ code to Julia.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ListBox",
    "page": "API Reference",
    "title": "CImGui.ListBox",
    "category": "function",
    "text": "ListBox(label, current_item, items, items_count, height_in_items=-1)\nListBox(label, current_item, items_getter::Ptr{Cvoid}, data::Ptr{Cvoid}, items_count, height_in_items=-1)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ListBoxFooter-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.ListBoxFooter",
    "category": "method",
    "text": "ListBoxFooter()\n\nTerminate the scrolling region.\n\nnote: Note\nOnly call ListBoxFooter() if ListBoxHeader returned true!\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ListBoxHeader",
    "page": "API Reference",
    "title": "CImGui.ListBoxHeader",
    "category": "function",
    "text": "ListBoxHeader(label, size=(0,0))\nListBoxHeader(label, items_count::Integer, height_in_items=-1)\n\nUse if you want to reimplement ListBox will custom data or interactions. If the function return true, you can output elements then call ListBoxFooter afterwards.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.LoadIniSettingsFromDisk-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.LoadIniSettingsFromDisk",
    "category": "method",
    "text": "LoadIniSettingsFromDisk(ini_filename)\n\nCall after CreateContext and before the first call to NewFrame. NewFrame automatically calls LoadIniSettingsFromDisk(ImGuiIO.IniFilename).\n\ntip: Tip\nThe disk functions are automatically called if ImGuiIO.IniFilename != CNULL (default is \"imgui.ini\"). Set ImGuiIO.IniFilename to CNULL to load/save manually. Read ImGuiIO.WantSaveIniSettings description about handling .ini saving manually.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.LoadIniSettingsFromMemory",
    "page": "API Reference",
    "title": "CImGui.LoadIniSettingsFromMemory",
    "category": "function",
    "text": "LoadIniSettingsFromMemory(ini_data, ini_size=0)\n\nCall after CreateContext and before the first call to NewFrame to provide .ini data from your own data source.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.LogButtons-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.LogButtons",
    "category": "method",
    "text": "LogButtons()\n\nDisplay buttons for logging to tty/file/clipboard.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.LogFinish-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.LogFinish",
    "category": "method",
    "text": "LogFinish()\n\nStop logging (close file, etc.)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.LogText-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.LogText",
    "category": "method",
    "text": "LogText(formatted_text)\n\nPass text data straight to log without being displayed.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.LogToClipboard",
    "page": "API Reference",
    "title": "CImGui.LogToClipboard",
    "category": "function",
    "text": "LogToClipboard(max_depth=-1)\n\nStart logging to OS clipboard.\n\nAll text output from interface is captured to clipboard. By default, tree nodes are automatically opened during logging.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.LogToFile",
    "page": "API Reference",
    "title": "CImGui.LogToFile",
    "category": "function",
    "text": "LogToFile(max_depth=-1, filename=C_NULL)\n\nStart logging to file.\n\nAll text output from interface is captured to file. By default, tree nodes are automatically opened during logging.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.LogToTTY",
    "page": "API Reference",
    "title": "CImGui.LogToTTY",
    "category": "function",
    "text": "LogToTTY(max_depth=-1)\n\nStart logging to tty.\n\nAll text output from interface is captured to tty. By default, tree nodes are automatically opened during logging.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.MenuItem",
    "page": "API Reference",
    "title": "CImGui.MenuItem",
    "category": "function",
    "text": "MenuItem(label, shortcut=C_NULL, selected::Bool=false, enabled::Bool=true) -> Bool\nMenuItem(label, shortcut, selected::Ref, enabled::Bool=true) -> Bool\n\nReturn true when activated. Shortcuts are displayed for convenience but not processed by ImGui at the moment.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.NewFrame-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.NewFrame",
    "category": "method",
    "text": "NewFrame()\n\nStart a new ImGui frame. You can submit any command from this point until Render or EndFrame.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.NewLine-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.NewLine",
    "category": "method",
    "text": "NewLine()\n\nUndo a SameLine.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.NextColumn-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.NextColumn",
    "category": "method",
    "text": "NextColumn()\n\nNext column, defaults to current row or next row if the current row is finished.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.OpenPopup-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.OpenPopup",
    "category": "method",
    "text": "OpenPopup(str_id)\n\nCall to mark popup as open (don\'t call every frame!). Popups are closed when user click outside, or if CloseCurrentPopup is called within a BeginPopup/EndPopup block. By default, Selectable/MenuItem are calling CloseCurrentPopup. Popup identifiers are relative to the current ID-stack (so OpenPopup and BeginPopup needs to be at the same level).\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.OpenPopupOnItemClick",
    "page": "API Reference",
    "title": "CImGui.OpenPopupOnItemClick",
    "category": "function",
    "text": "OpenPopupOnItemClick(str_id=C_NULL, mouse_button=1) -> Bool\n\nHelper to open popup when clicked on last item (note: actually triggers on the mouse released event to be consistent with popup behaviors). return true when just opened.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PathArcTo",
    "page": "API Reference",
    "title": "CImGui.PathArcTo",
    "category": "function",
    "text": "PathArcTo(handle::Ptr{ImDrawList}, centre, radius, a_min, a_max, num_segments=10)\n\nStateful path API, add points then finish with PathFillConvex or PathStroke.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PathArcToFast-Tuple{Ptr{CImGui.LibCImGui.ImDrawList},Any,Any,Any,Any}",
    "page": "API Reference",
    "title": "CImGui.PathArcToFast",
    "category": "method",
    "text": "PathArcToFast(handle::Ptr{ImDrawList}, centre, radius, a_min_of_12, a_max_of_12)\n\nStateful path API, add points then finish with PathFillConvex or PathStroke.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PathBezierCurveTo",
    "page": "API Reference",
    "title": "CImGui.PathBezierCurveTo",
    "category": "function",
    "text": "PathBezierCurveTo(handle::Ptr{ImDrawList}, p1, p2, p3, num_segments=0)\n\nStateful path API, add points then finish with PathFillConvex or PathStroke.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PathClear-Tuple{Ptr{CImGui.LibCImGui.ImDrawList}}",
    "page": "API Reference",
    "title": "CImGui.PathClear",
    "category": "method",
    "text": "PathClear(handle::Ptr{ImDrawList})\n\nStateful path API, add points then finish with PathFillConvex or PathStroke.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PathFillConvex-Tuple{Ptr{CImGui.LibCImGui.ImDrawList},Any}",
    "page": "API Reference",
    "title": "CImGui.PathFillConvex",
    "category": "method",
    "text": "PathFillConvex(handle::Ptr{ImDrawList}, col)\n\nnote: Note\nAnti-aliased filling requires points to be in clockwise order.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PathLineTo-Tuple{Ptr{CImGui.LibCImGui.ImDrawList},Any}",
    "page": "API Reference",
    "title": "CImGui.PathLineTo",
    "category": "method",
    "text": "PathLineTo(handle::Ptr{ImDrawList}, pos)\n\nStateful path API, add points then finish with PathFillConvex or PathStroke.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PathLineToMergeDuplicate-Tuple{Ptr{CImGui.LibCImGui.ImDrawList},Any}",
    "page": "API Reference",
    "title": "CImGui.PathLineToMergeDuplicate",
    "category": "method",
    "text": "PathLineToMergeDuplicate(handle::Ptr{ImDrawList}, pos)\n\nStateful path API, add points then finish with PathFillConvex or PathStroke.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PathRect",
    "page": "API Reference",
    "title": "CImGui.PathRect",
    "category": "function",
    "text": "PathRect(handle::Ptr{ImDrawList}, rect_min, rect_max, rounding=0.0, rounding_corners_flags=ImDrawCornerFlags_All)\n\nStateful path API, add points then finish with PathFillConvex or PathStroke.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PathStroke",
    "page": "API Reference",
    "title": "CImGui.PathStroke",
    "category": "function",
    "text": "PathStroke(handle::Ptr{ImDrawList}, col, closed, thickness=1.0)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PlotHistogram",
    "page": "API Reference",
    "title": "CImGui.PlotHistogram",
    "category": "function",
    "text": "PlotHistogram(label, values, values_count, values_offset=0, overlay_text=C_NULL, scale_min=FLT_MAX, scale_max=FLT_MAX, graph_size=(0,0), stride=sizeof(Cfloat))\nPlotHistogram(label, values_getter::Ptr, data::Ptr, values_count, values_offset=0, overlay_text=C_NULL, scale_min=FLT_MAX, scale_max=FLT_MAX, graph_size=ImVec2(0,0))\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PlotLines",
    "page": "API Reference",
    "title": "CImGui.PlotLines",
    "category": "function",
    "text": "PlotLines(label, values, values_count::Integer, values_offset=0, overlay_text=C_NULL, scale_min=FLT_MAX, scale_max=FLT_MAX, graph_size=(0,0), stride=sizeof(Cfloat))\nPlotLines(label, values_getter::Ptr, data::Ptr, values_count, values_offset=0, overlay_text=C_NULL, scale_min=FLT_MAX, scale_max=FLT_MAX, graph_size=(0,0))\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PopAllowKeyboardFocus-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.PopAllowKeyboardFocus",
    "category": "method",
    "text": "PopAllowKeyboardFocus()\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PopButtonRepeat-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.PopButtonRepeat",
    "category": "method",
    "text": "PopButtonRepeat()\n\nSee PushButtonRepeat.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PopClipRect-Tuple{Ptr{CImGui.LibCImGui.ImDrawList}}",
    "page": "API Reference",
    "title": "CImGui.PopClipRect",
    "category": "method",
    "text": "PopClipRect(handle::Ptr{ImDrawList})\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PopClipRect-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.PopClipRect",
    "category": "method",
    "text": "PopClipRect()\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PopFont-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.PopFont",
    "category": "method",
    "text": "PopFont()\n\nSee PushFont.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PopID-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.PopID",
    "category": "method",
    "text": "PopID()\n\nSee PushID.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PopItemWidth-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.PopItemWidth",
    "category": "method",
    "text": "PopItemWidth()\n\nSee PushItemWidth.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PopStyleColor",
    "page": "API Reference",
    "title": "CImGui.PopStyleColor",
    "category": "function",
    "text": "PopStyleColor(count=1)\n\nSee PushStyleColor.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PopStyleVar",
    "page": "API Reference",
    "title": "CImGui.PopStyleVar",
    "category": "function",
    "text": "PopStyleVar(count=1)\n\nSee PushStyleVar.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PopTextWrapPos-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.PopTextWrapPos",
    "category": "method",
    "text": "PopTextWrapPos()\n\nSee PushTextWrapPos.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PopTextureID-Tuple{Ptr{CImGui.LibCImGui.ImDrawList}}",
    "page": "API Reference",
    "title": "CImGui.PopTextureID",
    "category": "method",
    "text": "PopTextureID(handle::Ptr{ImDrawList})\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PrimQuadUV-Tuple{Ptr{CImGui.LibCImGui.ImDrawList},Any,Any,Any,Any,Any,Any,Any,Any,Any}",
    "page": "API Reference",
    "title": "CImGui.PrimQuadUV",
    "category": "method",
    "text": "PrimQuadUV(handle::Ptr{ImDrawList}, a, b, c, d, uv_a, uv_b, uv_c, uv_d, col)\n\nnote: Note\nAll primitives needs to be reserved via PrimReserve beforehand!\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PrimRect-Tuple{Ptr{CImGui.LibCImGui.ImDrawList},Any,Any,Any}",
    "page": "API Reference",
    "title": "CImGui.PrimRect",
    "category": "method",
    "text": "PrimRect(handle::Ptr{ImDrawList}, a, b, col)\n\nAxis aligned rectangle (composed of two triangles).\n\nnote: Note\nAll primitives needs to be reserved via PrimReserve beforehand!\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PrimRectUV-Tuple{Ptr{CImGui.LibCImGui.ImDrawList},Any,Any,Any,Any,Any}",
    "page": "API Reference",
    "title": "CImGui.PrimRectUV",
    "category": "method",
    "text": "PrimRectUV(handle::Ptr{ImDrawList}, a, b, uv_a, uv_b, col)\n\nnote: Note\nAll primitives needs to be reserved via PrimReserve beforehand!\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PrimReserve-Tuple{Ptr{CImGui.LibCImGui.ImDrawList},Any,Any}",
    "page": "API Reference",
    "title": "CImGui.PrimReserve",
    "category": "method",
    "text": "PrimReserve(handle::Ptr{ImDrawList}, idx_count, vtx_count)\n\nnote: Note\nAll primitives needs to be reserved via PrimReserve beforehand!\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PrimVtx-Tuple{Ptr{CImGui.LibCImGui.ImDrawList},Any,Any,Any}",
    "page": "API Reference",
    "title": "CImGui.PrimVtx",
    "category": "method",
    "text": "PrimVtx(handle::Ptr{ImDrawList}, pos, uv, col)\n\nnote: Note\nAll primitives needs to be reserved via PrimReserve beforehand!\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PrimWriteIdx-Tuple{Ptr{CImGui.LibCImGui.ImDrawList},Any}",
    "page": "API Reference",
    "title": "CImGui.PrimWriteIdx",
    "category": "method",
    "text": "PrimWriteIdx(handle::Ptr{ImDrawList}, idx)\n\nnote: Note\nAll primitives needs to be reserved via PrimReserve beforehand!\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PrimWriteVtx-Tuple{Ptr{CImGui.LibCImGui.ImDrawList},Any,Any,Any}",
    "page": "API Reference",
    "title": "CImGui.PrimWriteVtx",
    "category": "method",
    "text": "PrimWriteVtx(handle::Ptr{ImDrawList}, pos, uv, col)\n\nnote: Note\nAll primitives needs to be reserved via PrimReserve beforehand!\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ProgressBar",
    "page": "API Reference",
    "title": "CImGui.ProgressBar",
    "category": "function",
    "text": "ProgressBar(fraction, size_arg=(-1,0), overlay=C_NULL)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PushAllowKeyboardFocus-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.PushAllowKeyboardFocus",
    "category": "method",
    "text": "PushAllowKeyboardFocus(allow_keyboard_focus)\n\nAllow focusing using TAB/Shift-TAB, enabled by default but you can disable it for certain widgets.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PushButtonRepeat-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.PushButtonRepeat",
    "category": "method",
    "text": "PushButtonRepeat(repeat)\n\nIn \"repeat\" mode, Button*() functions return repeated true in a typematic manner (using ImGuiIO.KeyRepeatDelay/ImGuiIO.KeyRepeatRate setting). Note that you can call IsItemActive after any Button() to tell if the button is held in the current frame.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PushClipRect-Tuple{Any,Any,Any}",
    "page": "API Reference",
    "title": "CImGui.PushClipRect",
    "category": "method",
    "text": "PushClipRect(clip_rect_min, clip_rect_max, intersect_with_current_clip_rect)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PushClipRect-Tuple{Ptr{CImGui.LibCImGui.ImDrawList},Any,Any,Any}",
    "page": "API Reference",
    "title": "CImGui.PushClipRect",
    "category": "method",
    "text": "PushClipRect(handle::Ptr{ImDrawList}, clip_rect_min, clip_rect_max, intersect_with_current_clip_rect)\n\nRender-level scissoring. This is passed down to your render function but not used for CPU-side coarse clipping. Prefer using higher-level PushClipRect to affect logic (hit-testing and widget culling).\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PushClipRectFullScreen-Tuple{Ptr{CImGui.LibCImGui.ImDrawList}}",
    "page": "API Reference",
    "title": "CImGui.PushClipRectFullScreen",
    "category": "method",
    "text": "PushClipRectFullScreen(handle::Ptr{ImDrawList})\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PushFont-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.PushFont",
    "category": "method",
    "text": "PushFont(font)\n\nUse C_NULL as a shortcut to push default font.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PushID-Tuple{AbstractString}",
    "page": "API Reference",
    "title": "CImGui.PushID",
    "category": "method",
    "text": "PushID(ptr_id::Ptr)\nPushID(int_id::Integer)\nPushID(str_id::AbstractString)\nPushID(str_id_begin::AbstractString, str_id_end::AbstractString)\n\nPush identifier into the ID stack. IDs are hash of the entire stack!\n\nnote: Note\nRead the FAQ for more details about how ID are handled in dear imgui. If you are creating widgets in a loop you most likely want to push a unique identifier (e.g. object pointer, loop index) to uniquely differentiate them. You can also use the \"##foobar\" syntax within widget label to distinguish them from each others.\n\ntip: FAQ\nQ: How can I have multiple widgets with the same label or without a label?Q: I have multiple widgets with the same label, and only the first one works. Why is that?A: A primer on labels and the ID Stack...Dear ImGui internally need to uniquely identify UI elements. Elements that are typically not clickable (such as calls to the Text functions) don\'t need an ID. Interactive widgets (such as calls to Button buttons) need a unique ID. Unique ID are used internally to track active widgets and occasionally associate state to widgets. Unique ID are implicitly built from the hash of multiple elements that identify the \"path\" to the UI element.Unique ID are often derived from a string label:CImGui.Button(\"OK\")          # Label = \"OK\",     ID = hash of (..., \"OK\")\nCImGui.Button(\"Cancel\")      # Label = \"Cancel\", ID = hash of (..., \"Cancel\")ID are uniquely scoped within windows, tree nodes, etc. which all pushes to the ID stack.   Having two buttons labeled \"OK\" in different windows or different tree locations is fine.   We used \"...\" above to signify whatever was already pushed to the ID stack previously:CImGui.Begin(\"MyWindow\")\nCImGui.Button(\"OK\")          # Label = \"OK\",     ID = hash of (\"MyWindow\", \"OK\")\nCImGui.End()If you have a same ID twice in the same location, you\'ll have a conflict:CImGui.Button(\"OK\")\nCImGui.Button(\"OK\")          # ID collision! Interacting with either button will trigger the first one.Fear not! this is easy to solve and there are many ways to solve it!Solving ID conflict in a simple/local context:   When passing a label you can optionally specify extra ID information within string itself.   Use ## to pass a complement to the ID that won\'t be visible to the end-user.   This helps solving the simple collision cases when you know e.g. at compilation time which items   are going to be created:CImGui.Begin(\"MyWindow\")\nCImGui.Button(\"Play\")        # Label = \"Play\",   ID = hash of (\"MyWindow\", \"Play\")\nCImGui.Button(\"Play##foo1\")  # Label = \"Play\",   ID = hash of (\"MyWindow\", \"Play##foo1\")  # Different from above\nCImGui.Button(\"Play##foo2\")  # Label = \"Play\",   ID = hash of (\"MyWindow\", \"Play##foo2\")  # Different from above\nCImGui.End()If you want to completely hide the label, but still need an ID:CImGui.Checkbox(\"##On\", &b)  # Label = \"\", ID = hash of (..., \"##On\") # No visible label, just a checkbox!Occasionally/rarely you might want change a label while preserving a constant ID. This allowsyou to animate labels. For example you may want to include varying information in a window title bar,  but windows are uniquely identified by their ID. Use ### to pass a label that isn\'t part of ID:CImGui.Button(\"Hello###ID\")  # Label = \"Hello\",  ID = hash of (..., \"ID\")\nCImGui.Button(\"World###ID\")  # Label = \"World\",  ID = hash of (..., \"ID\") # Same as above, even though the label looks different\nbuf = @sprintf(\"My game (%f FPS)###MyGame\", fps)\nCImGui.Begin(buf)            # Variable title,   ID = hash of \"MyGame\"Solving ID conflict in a more general manner:Use PushID() / PopID() to create scopes and manipulate the ID stack, as to avoid ID conflicts  within the same window. This is the most convenient way of distinguishing ID when iterating and  creating many UI elements programmatically.  You can push a pointer, a string or an integer value into the ID stack.  Remember that ID are formed from the concatenation of everything in the ID stack!CImGui.Begin(\"Window\")\nfor i = 0:100-1\n    CImGui.PushID(i)         # Push i to the id tack\n    CImGui.Button(\"Click\")   # Label = \"Click\",  ID = Hash of (\"Window\", i, \"Click\")\n    CImGui.PopID()\nend\nEnd()More example showing that you can stack multiple prefixes into the ID stack:CImGui.Button(\"Click\")       # Label = \"Click\",  ID = hash of (..., \"Click\")\nCImGui.PushID(\"node\")\nCImGui.Button(\"Click\")       # Label = \"Click\",  ID = hash of (..., \"node\", \"Click\")\n    CImGui.PushID(my_ptr)\n    CImGui.Button(\"Click\") # Label = \"Click\",  ID = hash of (..., \"node\", my_ptr, \"Click\")\n    CImGui.PopID()\nCImGui.PopID()Tree nodes implicitly creates a scope for you by calling PushID().CImGui.Button(\"Click\")     # Label = \"Click\",  ID = hash of (..., \"Click\")\nif CImGui.TreeNode(\"node\")\n    CImGui.Button(\"Click\") # Label = \"Click\",  ID = hash of (..., \"node\", \"Click\")\n    CImGui.TreePop()\nendWhen working with trees, ID are used to preserve the open/close state of each tree node.   Depending on your use cases you may want to use strings, indices or pointers as ID.\ne.g. when following a single pointer that may change over time, using a static string as ID   will preserve your node open/closed state when the targeted object change.\ne.g. when displaying a list of objects, using indices or pointers as ID will preserve the   node open/closed state differently. See what makes more sense in your situation!\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PushItemWidth-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.PushItemWidth",
    "category": "method",
    "text": "PushItemWidth(item_width)\n\nPush width of items for the common item+label case, pixels:\n\nitem_width == 0: default to ~2/3 of windows width\nitem_width > 0: width in pixels\nitem_width < 0: align xx pixels to the right of window (so -1.0 always align width to the right side)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PushStyleColor-Tuple{Any,Any}",
    "page": "API Reference",
    "title": "CImGui.PushStyleColor",
    "category": "method",
    "text": "PushStyleColor(idx, col)\nPushStyleColor(idx, col::Integer)\n\nSee also GetStyleColorVec4, TextColored, TextDisabled.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PushStyleVar-Tuple{Any,Any}",
    "page": "API Reference",
    "title": "CImGui.PushStyleVar",
    "category": "method",
    "text": "PushStyleVar(idx, val)\nPushStyleVar(idx, val::Real)\n\nSee also GetStyle.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PushTextWrapPos",
    "page": "API Reference",
    "title": "CImGui.PushTextWrapPos",
    "category": "function",
    "text": "PushTextWrapPos(wrap_pos_x=0.0)\n\nWord-wrapping for Text*() commands:\n\nwrap_pos_x < 0: no wrapping\nwrap_pos_x == 0: wrap to end of window (or column)\nwrap_pos_x > 0: wrap at wrap_pos_x position in window local space\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.PushTextureID-Tuple{Ptr{CImGui.LibCImGui.ImDrawList},Any}",
    "page": "API Reference",
    "title": "CImGui.PushTextureID",
    "category": "method",
    "text": "PushTextureID(handle::Ptr{ImDrawList}, texture_id)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.RadioButton-Tuple{Any,Bool}",
    "page": "API Reference",
    "title": "CImGui.RadioButton",
    "category": "method",
    "text": "RadioButton(label, active::Bool) -> Bool\nRadioButton(label, v::Ref, v_button::Integer) -> Bool\n\nReturn true when the value has been changed or when pressed/selected.\n\nExample\n\nif RadioButton(\"one\", my_value==1)\n    my_value = 1\nend\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.RectVisible-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.RectVisible",
    "category": "method",
    "text": "RectVisible(size) -> Bool\nRectVisible(x, y) -> Bool\n\nTest if rectangle (of given size, starting from cursor position) is visible / not clipped.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Render-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.Render",
    "category": "method",
    "text": "Render()\n\nCalling this function ends the ImGui frame. This function finalizes the draw data.\n\nwarning: Obsolete\nOptionally call ImGuiIO.RenderDrawListsFn if set. Nowadays, prefer calling your render function yourself.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Reserve-Tuple{Ptr{CImGui.LibCImGui.ImGuiTextBuffer}}",
    "page": "API Reference",
    "title": "CImGui.Reserve",
    "category": "method",
    "text": "Reserve(handle::Ptr{ImGuiTextBuffer})\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ResetMouseDragDelta",
    "page": "API Reference",
    "title": "CImGui.ResetMouseDragDelta",
    "category": "function",
    "text": "ResetMouseDragDelta(button=0)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SameLine",
    "page": "API Reference",
    "title": "CImGui.SameLine",
    "category": "function",
    "text": "SameLine(local_pos_x=0.0, spacing_w=-1.0)\n\nCall this function between widgets or groups to layout them horizontally.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SaveIniSettingsToDisk-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.SaveIniSettingsToDisk",
    "category": "method",
    "text": "SaveIniSettingsToDisk(ini_filename)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SaveIniSettingsToMemory",
    "page": "API Reference",
    "title": "CImGui.SaveIniSettingsToMemory",
    "category": "function",
    "text": "SaveIniSettingsToMemory(out_ini_size=C_NULL)\n\nReturn a zero-terminated string with the .ini data which you can save by your own mean. Call when ImGuiIO.WantSaveIniSettings is set, then save data by your own mean and clear ImGuiIO.WantSaveIniSettings.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Selectable",
    "page": "API Reference",
    "title": "CImGui.Selectable",
    "category": "function",
    "text": "Selectable(label, selected::Bool=false, flags=0, size=(0,0)) -> Bool\nSelectable(label, p_selected::Ref, flags=0, sizeImVec2(0,0)) -> Bool\n\nReturn true if is clicked, so you can modify your selection state:\n\nsize.x == 0.0: use remaining width\nsize.x > 0.0: specify width\nsize.y == 0.0: use label height\nsize.y > 0.0: specify height\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Separator-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.Separator",
    "category": "method",
    "text": "Separator()\n\nSeparator, generally horizontal. But inside a menu bar or in horizontal layout mode, it becomes a vertical separator.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetClipboardText-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.SetClipboardText",
    "category": "method",
    "text": "SetClipboardText(text)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetColorEditOptions-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.SetColorEditOptions",
    "category": "method",
    "text": "SetColorEditOptions(flags)\n\nInitialize current options (generally on application startup) if you want to select a default format, picker type, etc. User will be able to change many settings, unless you pass the _NoOptions flag to your calls.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetColumnOffset-Tuple{Any,Any}",
    "page": "API Reference",
    "title": "CImGui.SetColumnOffset",
    "category": "method",
    "text": "SetColumnOffset(column_index, offset_x)\n\nSet position of column line (in pixels, from the left side of the contents region). Pass -1 to use current column.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetColumnWidth-Tuple{Any,Any}",
    "page": "API Reference",
    "title": "CImGui.SetColumnWidth",
    "category": "method",
    "text": "SetColumnWidth(column_index, width)\n\nSet column width (in pixels). Pass -1 to use current column.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetCurrentContext-Tuple{Ptr{Nothing}}",
    "page": "API Reference",
    "title": "CImGui.SetCurrentContext",
    "category": "method",
    "text": "SetCurrentContext(ctx::Ptr{ImGuiContext})\n\nSet current context to ctx.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetCursorPos-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.SetCursorPos",
    "category": "method",
    "text": "SetCursorPos(x, y)\nSetCursorPos(local_pos)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetCursorPosX-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.SetCursorPosX",
    "category": "method",
    "text": "SetCursorPosX(local_x)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetCursorPosY-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.SetCursorPosY",
    "category": "method",
    "text": "SetCursorPosX(local_y)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetCursorScreenPos-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.SetCursorScreenPos",
    "category": "method",
    "text": "SetCursorScreenPos(pos)\nSetCursorScreenPos(x, y)\n\nSet cursor position in absolute screen coordinates [0..io.DisplaySize].\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetDragDropPayload",
    "page": "API Reference",
    "title": "CImGui.SetDragDropPayload",
    "category": "function",
    "text": "SetDragDropPayload(type, data, size, cond=ImGuiCond_(1)) -> bool\n\ntype is a user defined string of maximum 32 characters. Strings starting with \'_\' are reserved for dear imgui internal types. Data is copied and held by imgui.\n\nnote: BETA API\nMissing Demo code. API may evolve.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetItemAllowOverlap-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.SetItemAllowOverlap",
    "category": "method",
    "text": "SetItemAllowOverlap()\n\nAllow last item to be overlapped by a subsequent item. Sometimes useful with invisible buttons, selectables, etc. to catch unused area. See Demo Window under \"Widgets->Querying Status\" for an interactive visualization of many of those functions.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetItemDefaultFocus-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.SetItemDefaultFocus",
    "category": "method",
    "text": "SetItemDefaultFocus()\n\nMake last item the default focused item of a window.\n\ntip: Tip\nPrefer using SetItemDefaultFocus over if (IsWindowAppearing()) SetScrollHereY() when applicable to signify \"this is the default item\").\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetKeyboardFocusHere",
    "page": "API Reference",
    "title": "CImGui.SetKeyboardFocusHere",
    "category": "function",
    "text": "SetKeyboardFocusHere(offset=0)\n\nFocus keyboard on the next widget. Use positive offset to access sub components of a multiple component widget. Use -1 to access previous widget.\n\ntip: Tip\nPrefer using SetItemDefaultFocus over if (IsWindowAppearing()) SetScrollHereY() when applicable to signify \"this is the default item\").\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetMouseCursor-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.SetMouseCursor",
    "category": "method",
    "text": "SetMouseCursor(type)\n\nSet desired cursor type.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetNextTreeNodeOpen",
    "page": "API Reference",
    "title": "CImGui.SetNextTreeNodeOpen",
    "category": "function",
    "text": "SetNextTreeNodeOpen(is_open, cond=0)\n\nSet next TreeNode/CollapsingHeader open state.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetNextWindowBgAlpha-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.SetNextWindowBgAlpha",
    "category": "method",
    "text": "SetNextWindowBgAlpha(alpha)\n\nSet next window background color alpha. Helper to easily modify ImGuiCol_WindowBg/ChildBg/PopupBg. You may also use ImGuiWindowFlags_NoBackground.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetNextWindowCollapsed",
    "page": "API Reference",
    "title": "CImGui.SetNextWindowCollapsed",
    "category": "function",
    "text": "SetNextWindowCollapsed(collapsed, cond=0)\n\nSet next window collapsed state. Call before Begin.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetNextWindowContentSize-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.SetNextWindowContentSize",
    "category": "method",
    "text": "SetNextWindowContentSize(size)\nSetNextWindowContentSize(x, y)\n\nSet next window content size (~ enforce the range of scrollbars). Not including window decorations (title bar, menu bar, etc.). Set an axis to 0.0 to leave it automatic. Call before Begin.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetNextWindowFocus-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.SetNextWindowFocus",
    "category": "method",
    "text": "SetNextWindowFocus()\n\nSet next window to be focused / front-most. Call before Begin.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetNextWindowPos",
    "page": "API Reference",
    "title": "CImGui.SetNextWindowPos",
    "category": "function",
    "text": "SetNextWindowPos(pos, cond=0, pivot=(0,0))\n\nSet next window position. Call before Begin. use pivot=(0.5,0.5) to center on given point, etc.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetNextWindowSize",
    "page": "API Reference",
    "title": "CImGui.SetNextWindowSize",
    "category": "function",
    "text": "SetNextWindowSize(size, cond=0)\n\nSet next window size. Set axis to 0.0 to force an auto-fit on this axis. Call before Begin.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetNextWindowSizeConstraints",
    "page": "API Reference",
    "title": "CImGui.SetNextWindowSizeConstraints",
    "category": "function",
    "text": "SetNextWindowSizeConstraints(size_min, size_max, custom_callback=C_NULL, custom_callback_data=C_NULL)\n\nSet next window size limits. Use -1,-1 on either X/Y axis to preserve the current size. Use callback to apply non-trivial programmatic constraints.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetScrollFromPosY",
    "page": "API Reference",
    "title": "CImGui.SetScrollFromPosY",
    "category": "function",
    "text": "SetScrollFromPosY(local_y, center_y_ratio=0.5)\n\nAdjust scrolling amount to make given position valid. Use GetCursorPos or GetCursorStartPos+offset to get valid positions.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetScrollHereY",
    "page": "API Reference",
    "title": "CImGui.SetScrollHereY",
    "category": "function",
    "text": "SetScrollHereY(center_y_ratio=0.5)\n\nAdjust scrolling amount to make current cursor position visible.\n\ncenter_y_ratio == 0.0: top\ncenter_y_ratio == 0.5: center\ncenter_y_ratio == 1.0: bottom\n\nWhen using to make a \"default/current item\" visible, consider using SetItemDefaultFocus instead.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetScrollX-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.SetScrollX",
    "category": "method",
    "text": "SetScrollX(scroll_x)\n\nSet scrolling amount [0..GetScrollMaxX()].\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetScrollY-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.SetScrollY",
    "category": "method",
    "text": "SetScrollY(scroll_y)\n\nSet scrolling amount [0..GetScrollMaxY()].\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetStateStorage-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.SetStateStorage",
    "category": "method",
    "text": "SetStateStorage(storage)\n\nReplace current window storage with our own (if you want to manipulate it yourself, typically clear subsection of it)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetTabItemClosed-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.SetTabItemClosed",
    "category": "method",
    "text": "SetTabItemClosed(tab_or_docked_window_label)\n\nNotify TabBar or Docking system of a closed tab/window ahead (useful to reduce visual flicker on reorderable tab bars). For tab-bar: call after BeginTabBar() and before Tab submissions. Otherwise call with a window name.\n\nnote: BETA API\nAPI may evolve!\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetTexID-Tuple{Ptr{CImGui.LibCImGui.ImFontAtlas},Any}",
    "page": "API Reference",
    "title": "CImGui.SetTexID",
    "category": "method",
    "text": "SetTexID(self::Ptr{ImFontAtlas}, id)\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetTooltip-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.SetTooltip",
    "category": "method",
    "text": "SetTooltip(formatted_text)\n\nSet a text-only tooltip, typically use with IsItemHovered. Overidde any previous call to SetTooltip.\n\nwarning: Limited support\nFormatting is not supported which means you need to pass a formatted string to this function. It\'s recommended to use Julia stdlib Printf\'s @sprintf as a workaround when translating C/C++ code to Julia.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetWindowCollapsed",
    "page": "API Reference",
    "title": "CImGui.SetWindowCollapsed",
    "category": "function",
    "text": "SetWindowCollapsedBool(collapsed, cond=0)\n\nSet current window collapsed state.\n\nwarning: Not recommended!\nThis function is not recommended! Prefer using SetNextWindowCollapsed.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetWindowCollapsed",
    "page": "API Reference",
    "title": "CImGui.SetWindowCollapsed",
    "category": "function",
    "text": "SetWindowCollapsed(name::AbstractString, collapsed, cond=0)\n\nSet named window collapsed state.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetWindowFocus-Tuple{Ptr{Nothing}}",
    "page": "API Reference",
    "title": "CImGui.SetWindowFocus",
    "category": "method",
    "text": "SetWindowFocus(name::Ptr{Cvoid})\nSetWindowFocus(name::AbstractString)\n\nSet named window to be focused / front-most. Use C_NULL to remove focus.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetWindowFocus-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.SetWindowFocus",
    "category": "method",
    "text": "SetWindowFocus()\n\nSet current window to be focused / front-most.\n\nwarning: Not recommended!\nThis function is not recommended! Prefer using SetNextWindowFocus.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetWindowFontScale-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.SetWindowFontScale",
    "category": "method",
    "text": "SetWindowFontScale(scale)\n\nSet font scale. Adjust ImGuiIO.FontGlobalScale if you want to scale all windows.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetWindowPos",
    "page": "API Reference",
    "title": "CImGui.SetWindowPos",
    "category": "function",
    "text": "SetWindowPos(pos, cond=0)\n\nSet current window position - call within Begin/End.\n\nwarning: Not recommended!\nThis function is not recommended! Prefer using SetNextWindowPos, as this may incur tearing and side-effects.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetWindowPos",
    "page": "API Reference",
    "title": "CImGui.SetWindowPos",
    "category": "function",
    "text": "SetWindowPosStr(name::AbstractString, pos, cond=0)\n\nSet named window position.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetWindowSize",
    "page": "API Reference",
    "title": "CImGui.SetWindowSize",
    "category": "function",
    "text": "SetWindowSize(size, cond=0)\n\nSet current window size - call within Begin/End. Set to (0,0) to force an auto-fit.\n\nwarning: Not recommended!\nThis function is not recommended! Prefer using SetNextWindowSize, as this may incur tearing and minor side-effects.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SetWindowSize",
    "page": "API Reference",
    "title": "CImGui.SetWindowSize",
    "category": "function",
    "text": "SetWindowSizeStr(name::AbstractString, size, cond=0)\n\nSet named window size. Set axis to 0.0 to force an auto-fit on this axis.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ShowAboutWindow",
    "page": "API Reference",
    "title": "CImGui.ShowAboutWindow",
    "category": "function",
    "text": "ShowAboutWindow()\nShowAboutWindow(p_open=C_NULL)\n\nCreate about window. Display Dear ImGui version, credits and build/system information.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ShowDemoWindow",
    "page": "API Reference",
    "title": "CImGui.ShowDemoWindow",
    "category": "function",
    "text": "ShowDemoWindow()\nShowDemoWindow(p_open=C_NULL)\n\nCreate demo/test window. Demonstrate most ImGui features.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ShowFontSelector-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.ShowFontSelector",
    "category": "method",
    "text": "ShowFontSelector(label)\n\nAdd font selector block (not a window), essentially a combo listing the loaded fonts.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ShowMetricsWindow",
    "page": "API Reference",
    "title": "CImGui.ShowMetricsWindow",
    "category": "function",
    "text": "ShowMetricsWindow()\nShowMetricsWindow(p_open=C_NULL)\n\nCreate metrics window. Display Dear ImGui internals: draw commands (with individual draw calls and vertices), window list, basic internal state, etc.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ShowStyleEditor",
    "page": "API Reference",
    "title": "CImGui.ShowStyleEditor",
    "category": "function",
    "text": "ShowStyleEditor()\nShowStyleEditor(ref=C_NULL)\n\nAdd style editor block (not a window). You can pass in a reference ImGuiStyle structure to compare to, revert to and save to (else it uses the default style).\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ShowStyleSelector-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.ShowStyleSelector",
    "category": "method",
    "text": "ShowStyleSelector()\nShowStyleSelector(label)\n\nAdd style selector block (not a window), essentially a combo listing the default styles.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ShowUserGuide-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.ShowUserGuide",
    "category": "method",
    "text": "ShowUserGuide()\n\nAdd basic help/info block (not a window): how to manipulate ImGui as a end-user (mouse/keyboard controls).\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Size-Tuple{Ptr{CImGui.LibCImGui.ImGuiTextBuffer}}",
    "page": "API Reference",
    "title": "CImGui.Size",
    "category": "method",
    "text": "Size(handle::Ptr{ImGuiTextBuffer}) -> Cint\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SliderAngle",
    "page": "API Reference",
    "title": "CImGui.SliderAngle",
    "category": "function",
    "text": "SliderAngle(label, v_rad, v_degrees_min=-360.0, v_degrees_max=360.0, format=\"%.0f deg\") -> Bool\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SliderFloat",
    "page": "API Reference",
    "title": "CImGui.SliderFloat",
    "category": "function",
    "text": "SliderFloat(label, v, v_min, v_max, format=\"%.3f\", power=1.0) -> Bool\n\nCreate a slider widget.\n\ntip: Tip\nctrl+click on a slider to input with keyboard. manually input values aren\'t clamped, can go off-bounds.\n\nArguments\n\nformat: adjust format to decorate the value with a prefix or a suffix for in-slider labels or unit display\n\"%.3f\" -> 1.234\n\"%5.2f secs\" -> 01.23 secs\n\"Biscuit: %.0f\" -> Biscuit: 1\npower: use power != 1.0 for power curve sliders\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SliderFloat2",
    "page": "API Reference",
    "title": "CImGui.SliderFloat2",
    "category": "function",
    "text": "SliderFloat2(label, v, v_min, v_max, format=\"%.3f\", power=1.0) -> Bool\n\nThe expected number of elements to be accessible in v is 2.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SliderFloat3",
    "page": "API Reference",
    "title": "CImGui.SliderFloat3",
    "category": "function",
    "text": "SliderFloat3(label, v, v_min, v_max, format=\"%.3f\", power=1.0) -> Bool\n\nThe expected number of elements to be accessible in v is 3.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SliderFloat4",
    "page": "API Reference",
    "title": "CImGui.SliderFloat4",
    "category": "function",
    "text": "SliderFloat4(label, v, v_min, v_max, format=\"%.3f\", power=1.0) -> Bool\n\nThe expected number of elements to be accessible in v is 4.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SliderInt",
    "page": "API Reference",
    "title": "CImGui.SliderInt",
    "category": "function",
    "text": "SliderInt(label, v, v_min, v_max, format=\"%d\") -> Bool\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SliderInt2",
    "page": "API Reference",
    "title": "CImGui.SliderInt2",
    "category": "function",
    "text": "SliderInt2(label, v, v_min, v_max, format=\"%d\") -> Bool\n\nThe expected number of elements to be accessible in v is 2.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SliderInt3",
    "page": "API Reference",
    "title": "CImGui.SliderInt3",
    "category": "function",
    "text": "SliderInt3(label, v, v_min, v_max, format=\"%d\") -> Bool\n\nThe expected number of elements to be accessible in v is 3.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SliderInt4",
    "page": "API Reference",
    "title": "CImGui.SliderInt4",
    "category": "function",
    "text": "SliderInt4(label, v, v_min, v_max, format=\"%d\") -> Bool\n\nThe expected number of elements to be accessible in v is 4.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SliderScalar",
    "page": "API Reference",
    "title": "CImGui.SliderScalar",
    "category": "function",
    "text": "SliderScalar(label, data_type, v, v_min, v_max, format=C_NULL, power=1.0) -> Bool\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SliderScalarN",
    "page": "API Reference",
    "title": "CImGui.SliderScalarN",
    "category": "function",
    "text": "SliderScalarN(label, data_type, v, components, v_min, v_max, format=C_NULL, power=1.0) -> Bool\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.SmallButton-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.SmallButton",
    "category": "method",
    "text": "SmallButton(label) -> Bool\n\nReturn true when the value has been changed or when pressed/selected. It creates a button with FramePadding=(0,0) to easily embed within text.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Spacing-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.Spacing",
    "category": "method",
    "text": "Spacing()\n\nAdd vertical spacing.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Step-Tuple{Ptr{CImGui.LibCImGui.ImGuiListClipper}}",
    "page": "API Reference",
    "title": "CImGui.Step",
    "category": "method",
    "text": "Step(handle::Ptr{ImGuiListClipper}) -> Bool\n\nCall until it returns false. The DisplayStart/DisplayEnd fields will be set and you can process/draw those items.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.StyleColorsClassic-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.StyleColorsClassic",
    "category": "method",
    "text": "StyleColorsClassic()\n\nUse the classic imgui style.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.StyleColorsDark-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.StyleColorsDark",
    "category": "method",
    "text": "StyleColorsDark()\n\nUse the new, recommended style. This is also the default style.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.StyleColorsLight-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.StyleColorsLight",
    "category": "method",
    "text": "StyleColorsLight()\n\nThis style is best used with borders and a custom, thicker font.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Text-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.Text",
    "category": "method",
    "text": "Text(formatted_text)\n\nCreate a text widget.\n\nwarning: Limited support\nFormatting is not supported which means you need to pass a formatted string to this function. It\'s recommended to use Julia stdlib Printf\'s @sprintf as a workaround when translating C/C++ code to Julia.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.TextBuffer-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.TextBuffer",
    "category": "method",
    "text": "TextBuffer() -> Ptr{ImGuiTextBuffer}\n\nHelper: Growable text buffer for logging/accumulating text\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.TextColored-Tuple{Any,Any}",
    "page": "API Reference",
    "title": "CImGui.TextColored",
    "category": "method",
    "text": "TextColored(col, formatted_text)\n\nShortcut for PushStyleColor(ImGuiCol_Text, col); Text(text); PopStyleColor();.\n\nwarning: Limited support\nFormatting is not supported which means you need to pass a formatted string to this function. It\'s recommended to use Julia stdlib Printf\'s @sprintf as a workaround when translating C/C++ code to Julia.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.TextDisabled-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.TextDisabled",
    "category": "method",
    "text": "TextDisabled(formatted_text)\n\nShortcut for PushStyleColor(ImGuiCol_Text, style.Colors[ImGuiCol_TextDisabled]); Text(text); PopStyleColor();.\n\nwarning: Limited support\nFormatting is not supported which means you need to pass a formatted string to this function. It\'s recommended to use Julia stdlib Printf\'s @sprintf as a workaround when translating C/C++ code to Julia.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.TextUnformatted",
    "page": "API Reference",
    "title": "CImGui.TextUnformatted",
    "category": "function",
    "text": "TextUnformatted(text, text_end=C_NULL)\n\nRaw text without formatting. Roughly equivalent to Text(\"%s\", text) but:\n\ndoesn\'t require null terminated string if text_end is specified;\nit\'s faster, no memory copy is done, no buffer size limits, recommended for long chunks of text.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.TextWrapped-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.TextWrapped",
    "category": "method",
    "text": "TextWrapped(formatted_text)\n\nShortcut for PushTextWrapPos(0.0f); Text(text); PopTextWrapPos();. Note that this won\'t work on an auto-resizing window if there\'s no other widgets to extend the window width, yoy may need to set a size using SetNextWindowSize.\n\nwarning: Limited support\nFormatting is not supported which means you need to pass a formatted string to this function. It\'s recommended to use Julia stdlib Printf\'s @sprintf as a workaround when translating C/C++ code to Julia.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.TreeAdvanceToLabelPos-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.TreeAdvanceToLabelPos",
    "category": "method",
    "text": "TreeAdvanceToLabelPos()\n\nAdvance cursor x position by GetTreeNodeToLabelSpacing.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.TreeNode-Tuple{AbstractString}",
    "page": "API Reference",
    "title": "CImGui.TreeNode",
    "category": "method",
    "text": "TreeNode(label::AbstractString) -> Bool\n\nTreeNode functions return true when the node is open, in which case you need to also call TreePop when you are finished displaying the tree node contents.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.TreeNode-Tuple{Any,Any}",
    "page": "API Reference",
    "title": "CImGui.TreeNode",
    "category": "method",
    "text": "TreeNode(str_id, formatted_text) -> Bool\n\nHelper variation to completely decorelate the id from the displayed string. Read the FAQ in PushID\'s\' doc about why and how to use ID. To align arbitrary text at the same level as a TreeNode you can use Bullet.\n\nwarning: Limited support\nFormatting is not supported which means you need to pass a formatted string to this function. It\'s recommended to use Julia stdlib Printf\'s @sprintf as a workaround when translating C/C++ code to Julia.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.TreeNode-Tuple{Ptr,Any}",
    "page": "API Reference",
    "title": "CImGui.TreeNode",
    "category": "method",
    "text": "TreeNodePtr(ptr_id::Ptr, formatted_text) -> Bool\n\nHelper variation to completely decorelate the id from the displayed string. Read the FAQ in PushID\'s\' doc about why and how to use ID. To align arbitrary text at the same level as a TreeNode you can use Bullet.\n\nwarning: Limited support\nFormatting is not supported which means you need to pass a formatted string to this function. It\'s recommended to use Julia stdlib Printf\'s @sprintf as a workaround when translating C/C++ code to Julia.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.TreeNodeEx",
    "page": "API Reference",
    "title": "CImGui.TreeNodeEx",
    "category": "function",
    "text": "TreeNodeEx(label, flags=0) -> Bool\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.TreeNodeEx-Tuple{Any,Any,Any}",
    "page": "API Reference",
    "title": "CImGui.TreeNodeEx",
    "category": "method",
    "text": "TreeNodeEx(str_id, flags, formatted_text) -> Bool\n\nwarning: Limited support\nFormatting is not supported which means you need to pass a formatted string to this function. It\'s recommended to use Julia stdlib Printf\'s @sprintf as a workaround when translating C/C++ code to Julia.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.TreeNodeEx-Tuple{Ptr,Any,Any}",
    "page": "API Reference",
    "title": "CImGui.TreeNodeEx",
    "category": "method",
    "text": "TreeNodeEx(ptr_id::Ptr, flags, formatted_text) -> Bool\n\nwarning: Limited support\nFormatting is not supported which means you need to pass a formatted string to this function. It\'s recommended to use Julia stdlib Printf\'s @sprintf as a workaround when translating C/C++ code to Julia.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.TreePop-Tuple{}",
    "page": "API Reference",
    "title": "CImGui.TreePop",
    "category": "method",
    "text": "TreePop()\n\nUnindent + PopID.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.TreePush",
    "page": "API Reference",
    "title": "CImGui.TreePush",
    "category": "function",
    "text": "TreePush(ptr_id::Ptr=C_NULL)\n\nIndent + PushID. Already called by TreeNode when returning true, but you can call TreePush/TreePop yourself if desired.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.TreePush-Tuple{Any}",
    "page": "API Reference",
    "title": "CImGui.TreePush",
    "category": "method",
    "text": "TreePush(str_id)\n\nIndent + PushID. Already called by TreeNode when returning true, but you can call TreePush/TreePop yourself if desired.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.Unindent",
    "page": "API Reference",
    "title": "CImGui.Unindent",
    "category": "function",
    "text": "Unindent()\nUnindent(indent_w)\n\nMove content position back to the left, by ImGuiStyle.IndentSpacing or indent_w if indent_w != 0.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.UpdateClipRect-Tuple{Ptr{CImGui.LibCImGui.ImDrawList}}",
    "page": "API Reference",
    "title": "CImGui.UpdateClipRect",
    "category": "method",
    "text": "UpdateClipRect(handle::Ptr{ImDrawList})\n\nnote: Note\nAll primitives needs to be reserved via PrimReserve beforehand!\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.UpdateTextureID-Tuple{Ptr{CImGui.LibCImGui.ImDrawList}}",
    "page": "API Reference",
    "title": "CImGui.UpdateTextureID",
    "category": "method",
    "text": "UpdateTextureID(handle::Ptr{ImDrawList})\n\nnote: Note\nAll primitives needs to be reserved via PrimReserve beforehand!\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.VSliderFloat",
    "page": "API Reference",
    "title": "CImGui.VSliderFloat",
    "category": "function",
    "text": "VSliderFloat(label, size, v, v_min, v_max, format=\"%.3f\", power=1.0) -> Bool\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.VSliderInt",
    "page": "API Reference",
    "title": "CImGui.VSliderInt",
    "category": "function",
    "text": "VSliderInt(label, size, v, v_min, v_max, format=\"%d\") -> Bool\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.VSliderScalar",
    "page": "API Reference",
    "title": "CImGui.VSliderScalar",
    "category": "function",
    "text": "VSliderScalar(label, size, data_type, v, v_min, v_max, format=C_NULL, power=1.0) -> Bool\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ValueBool-Tuple{Any,Any}",
    "page": "API Reference",
    "title": "CImGui.ValueBool",
    "category": "method",
    "text": "ValueBool(prefix, b)\n\nOutput single value in \"name: value\" format.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ValueFloat",
    "page": "API Reference",
    "title": "CImGui.ValueFloat",
    "category": "function",
    "text": "ValueFloat(prefix, v, float_format=C_NULL)\n\nOutput single value in \"name: value\" format.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ValueInt-Tuple{Any,Any}",
    "page": "API Reference",
    "title": "CImGui.ValueInt",
    "category": "method",
    "text": "ValueInt(prefix, v)\n\nOutput single value in \"name: value\" format.\n\n\n\n\n\n"
},

{
    "location": "api/#CImGui.ValueUint-Tuple{Any,Any}",
    "page": "API Reference",
    "title": "CImGui.ValueUint",
    "category": "method",
    "text": "ValueUint(prefix, v)\n\nOutput single value in \"name: value\" format.\n\n\n\n\n\n"
},

{
    "location": "api/#API-Reference-1",
    "page": "API Reference",
    "title": "API Reference",
    "category": "section",
    "text": "Modules = [CImGui]\nOrder   = [:constant, :function, :type]"
},

]}
