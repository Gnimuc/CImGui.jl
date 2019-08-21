Base.convert(::Type{Cint}, x::GLFW.Key) = Cint(x)

@enum GlfwClientApi GlfwClientApi_Unknown GlfwClientApi_OpenGL GlfwClientApi_Vulkan

function ImGui_ImplGlfw_Init(window::GLFW.Window, install_callbacks::Bool, client_api::GlfwClientApi)
    global g_Window = window
    global g_Time = 0.0

    # setup back-end capabilities flags
    io = GetIO()
    io.BackendFlags |= ImGuiBackendFlags_HasMouseCursors
    io.BackendFlags |= ImGuiBackendFlags_HasSetMousePos
    io.BackendPlatformName = "imgui_impl_glfw"

    # keyboard mapping
    Set_KeyMap(io, ImGuiKey_Tab, GLFW.KEY_TAB)
    Set_KeyMap(io, ImGuiKey_LeftArrow, GLFW.KEY_LEFT)
    Set_KeyMap(io, ImGuiKey_RightArrow, GLFW.KEY_RIGHT)
    Set_KeyMap(io, ImGuiKey_UpArrow, GLFW.KEY_UP)
    Set_KeyMap(io, ImGuiKey_DownArrow, GLFW.KEY_DOWN)
    Set_KeyMap(io, ImGuiKey_PageUp, GLFW.KEY_PAGE_UP)
    Set_KeyMap(io, ImGuiKey_PageDown, GLFW.KEY_PAGE_DOWN)
    Set_KeyMap(io, ImGuiKey_Home, GLFW.KEY_HOME)
    Set_KeyMap(io, ImGuiKey_End, GLFW.KEY_END)
    Set_KeyMap(io, ImGuiKey_Insert, GLFW.KEY_INSERT)
    Set_KeyMap(io, ImGuiKey_Delete, GLFW.KEY_DELETE)
    Set_KeyMap(io, ImGuiKey_Backspace, GLFW.KEY_BACKSPACE)
    Set_KeyMap(io, ImGuiKey_Space, GLFW.KEY_SPACE)
    Set_KeyMap(io, ImGuiKey_Enter, GLFW.KEY_ENTER)
    Set_KeyMap(io, ImGuiKey_Escape, GLFW.KEY_ESCAPE)
    Set_KeyMap(io, ImGuiKey_A, GLFW.KEY_A)
    Set_KeyMap(io, ImGuiKey_C, GLFW.KEY_C)
    Set_KeyMap(io, ImGuiKey_V, GLFW.KEY_V)
    Set_KeyMap(io, ImGuiKey_X, GLFW.KEY_X)
    Set_KeyMap(io, ImGuiKey_Y, GLFW.KEY_Y)
    Set_KeyMap(io, ImGuiKey_Z, GLFW.KEY_Z)

    io.SetClipboardTextFn = g_ImplGlfw_SetClipboardText
    io.GetClipboardTextFn = g_ImplGlfw_GetClipboardText
    io.ClipboardUserData = Ptr{Cvoid}(g_Window.handle)

    g_MouseCursors[ImGuiMouseCursor_Arrow+1] = GLFW.CreateStandardCursor(GLFW.ARROW_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_TextInput+1] = GLFW.CreateStandardCursor(GLFW.IBEAM_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_ResizeAll+1] = GLFW.CreateStandardCursor(GLFW.ARROW_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_ResizeNS+1] = GLFW.CreateStandardCursor(GLFW.VRESIZE_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_ResizeEW+1] = GLFW.CreateStandardCursor(GLFW.HRESIZE_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_ResizeNESW+1] = GLFW.CreateStandardCursor(GLFW.ARROW_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_ResizeNWSE+1] = GLFW.CreateStandardCursor(GLFW.ARROW_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_Hand+1] = GLFW.CreateStandardCursor(GLFW.HAND_CURSOR)

    if install_callbacks
        GLFW.SetMouseButtonCallback(window, ImGui_ImplGlfw_MouseButtonCallback)
        GLFW.SetScrollCallback(window, ImGui_ImplGlfw_ScrollCallback)
        GLFW.SetKeyCallback(window, ImGui_ImplGlfw_KeyCallback)
        GLFW.SetCharCallback(window, ImGui_ImplGlfw_CharCallback)
    end

    global g_ClientApi = client_api
    return true;
end

function ImGui_ImplGlfw_InitForOpenGL(window::GLFW.Window, install_callbacks::Bool)
    ImGui_ImplGlfw_Init(window, install_callbacks, GlfwClientApi_OpenGL)
end

function ImGui_ImplGlfw_InitForVulkan(window::GLFW.Window, install_callbacks::Bool)
    ImGui_ImplGlfw_Init(window, install_callbacks, GlfwClientApi_Vulkan)
end

function ImGui_ImplGlfw_Shutdown()
    global g_MouseCursors
    for cursor_n = 1:ImGuiMouseCursor_COUNT
        GLFW.DestroyCursor(g_MouseCursors[cursor_n])
        g_MouseCursors[cursor_n] = GLFW.Cursor(C_NULL)
    end
    global g_ClientApi = GlfwClientApi_Unknown
end

function ImGui_ImplGlfw_UpdateMousePosAndButtons()
    global g_Window
    global g_MouseJustPressed
    # update buttons
    io = GetIO()
    for i = 1:length(g_MouseJustPressed)
        # if a mouse press event came, always pass it as "mouse held this frame",
        # so we don't miss click-release events that are shorter than 1 frame.
        mousedown = g_MouseJustPressed[i] || GLFW.GetMouseButton(g_Window, GLFW.MouseButton(i-1))
        Set_MouseDown(io, i-1, mousedown)
        g_MouseJustPressed[i] = false
    end

    # update mouse position
    mouse_pos_backup = io.MousePos
    io.MousePos = ImVec2(-FLT_MAX, -FLT_MAX)
    if GLFW.GetWindowAttrib(g_Window, GLFW.FOCUSED) != 0
        if io.WantSetMousePos
            GLFW.SetCursorPos(g_Window, Cdouble(mouse_pos_backup.x), Cdouble(mouse_pos_backup.y))
        else
            mouse_x, mouse_y = GLFW.GetCursorPos(g_Window)
            io.MousePos = ImVec2(Cfloat(mouse_x), Cfloat(mouse_y))
        end
    end
end

function ImGui_ImplGlfw_UpdateMouseCursor()
    global g_Window
    global g_MouseCursors

    io = GetIO()
    if (io.ConfigFlags & ImGuiConfigFlags_NoMouseCursorChange) != 0 ||
        GLFW.GetInputMode(g_Window, GLFW.CURSOR) == GLFW.CURSOR_DISABLED
        return nothing
    end

    imgui_cursor = GetMouseCursor()
    if imgui_cursor == ImGuiMouseCursor_None || io.MouseDrawCursor
        # hide OS mouse cursor if imgui is drawing it or if it wants no cursor
        GLFW.SetInputMode(g_Window, GLFW.CURSOR, GLFW.CURSOR_HIDDEN)
    else
        # show OS mouse cursor
        cursor = g_MouseCursors[imgui_cursor+1]
        GLFW.SetCursor(g_Window, cursor.handle != C_NULL ? g_MouseCursors[imgui_cursor+1] : g_MouseCursors[ImGuiMouseCursor_Arrow+1])
        GLFW.SetInputMode(g_Window, GLFW.CURSOR, GLFW.CURSOR_NORMAL)
    end

    return nothing
end

function ImGui_ImplGlfw_NewFrame(window::Union{GLFW.Window,Nothing}=nothing)
    global g_Time
    global g_Window
    window != nothing && (g_Window = window;)
    io = GetIO()
    @assert ImFontAtlas_IsBuilt(io.Fonts) "Font atlas not built! It is generally built by the renderer back-end. Missing call to renderer _NewFrame() function? e.g. ImGui_ImplOpenGL3_NewFrame()."

    # setup display size (every frame to accommodate for window resizing)
    w, h = GLFW.GetWindowSize(g_Window)
    display_w, display_h = GLFW.GetFramebufferSize(g_Window)
    io.DisplaySize = ImVec2(Cfloat(w), Cfloat(h))
    w_scale = w > 0 ? Cfloat(display_w / w) : 0f0
    h_scale = h > 0 ? Cfloat(display_h / h) : 0f0
    io.DisplayFramebufferScale = ImVec2(w_scale, h_scale)

    # setup time step
    current_time = ccall((:glfwGetTime, GLFW.libglfw), Cdouble, ())
    io.DeltaTime = g_Time > 0.0 ? Cfloat(current_time - g_Time) : Cfloat(1.0/60.0)
    g_Time = current_time

    ImGui_ImplGlfw_UpdateMousePosAndButtons()
    ImGui_ImplGlfw_UpdateMouseCursor()

    # TODO: Gamepad navigation mapping
    # ImGui_ImplGlfw_UpdateGamepads()
end

# function ImGui_ImplGlfw_UpdateGamepads()
#     io = GetIO()
#     memset(io.NavInputs, 0, sizeof(io.NavInputs));
#     io.ConfigFlags & ImGuiConfigFlags_NavEnableGamepad == 0 && return
#
#     # update gamepad inputs
#     MAP_BUTTON(NAV_NO, BUTTON_NO) = buttons_count > BUTTON_NO && buttons[BUTTON_NO] == GLFW.PRESS && Set_NavInputs(io, NAV_NO, 1.0f0)
#     function MAP_ANALOG(NAV_NO, AXIS_NO, V0, V1)
#         v = (axes_count > AXIS_NO) ? axes[AXIS_NO] : V0
#         v = (v - V0) / (V1 - V0)
#         v > 1.0 && (v = 1.0)
#         Get_NavInputs(io, NAV_NO) < v && Set_NavInputs(io, NAV_NO, v)
#     end
#     axes_count = Cint(0)
#     buttons_count = Cint(0)
#     axes = @c GLFW.GetJoystickAxes(GLFW.JOYSTICK_1, &axes_count)
#     buttons = GLFW.GetJoystickButtons(GLFW.JOYSTICK_1, &buttons_count)
#     MAP_BUTTON(ImGuiNavInput_Activate,   0)     # Cross / A
#     MAP_BUTTON(ImGuiNavInput_Cancel,     1)     # Circle / B
#     MAP_BUTTON(ImGuiNavInput_Menu,       2)     # Square / X
#     MAP_BUTTON(ImGuiNavInput_Input,      3)     # Triangle / Y
#     MAP_BUTTON(ImGuiNavInput_DpadLeft,   13)    # D-Pad Left
#     MAP_BUTTON(ImGuiNavInput_DpadRight,  11)    # D-Pad Right
#     MAP_BUTTON(ImGuiNavInput_DpadUp,     10)    # D-Pad Up
#     MAP_BUTTON(ImGuiNavInput_DpadDown,   12)    # D-Pad Down
#     MAP_BUTTON(ImGuiNavInput_FocusPrev,  4)     # L1 / LB
#     MAP_BUTTON(ImGuiNavInput_FocusNext,  5)     # R1 / RB
#     MAP_BUTTON(ImGuiNavInput_TweakSlow,  4)     # L1 / LB
#     MAP_BUTTON(ImGuiNavInput_TweakFast,  5)     # R1 / RB
#     MAP_ANALOG(ImGuiNavInput_LStickLeft, 0,  -0.3,  -0.9)
#     MAP_ANALOG(ImGuiNavInput_LStickRight,0,  +0.3,  +0.9)
#     MAP_ANALOG(ImGuiNavInput_LStickUp,   1,  +0.3,  +0.9)
#     MAP_ANALOG(ImGuiNavInput_LStickDown, 1,  -0.3,  -0.9)
#     if axes_count > 0 && buttons_count > 0
#         io.BackendFlags |= ImGuiBackendFlags_HasGamepad
#     else
#         io.BackendFlags &= ~ImGuiBackendFlags_HasGamepad
#     end
# end
