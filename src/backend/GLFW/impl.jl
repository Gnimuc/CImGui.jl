Base.convert(::Type{Cint}, x::GLFW.Key) = Cint(x)

@enum GlfwClientApi GlfwClientApi_Unknown GlfwClientApi_OpenGL GlfwClientApi_Vulkan

function igImplGlfw_Init(window::GLFW.Window, install_callbacks, client_api::GlfwClientApi)
    global g_Window = window
    global g_Time = 0.0

    # setup back-end capabilities flags
    io = igGetIO()
    backend_flags::UInt32 = ImGuiIO_Get_BackendFlags(io)
    backend_flags |= ImGuiBackendFlags_HasMouseCursors
    backend_flags |= ImGuiBackendFlags_HasSetMousePos
    ImGuiIO_Set_BackendFlags(io, backend_flags)
    # ImGuiIO_Set_BackendPlatformName(io, "imgui_impl_glfw")
    # keyboard mapping
    ImGuiIO_Set_KeyMap(io, ImGuiKey_Tab, GLFW.KEY_TAB)
    ImGuiIO_Set_KeyMap(io, ImGuiKey_LeftArrow, GLFW.KEY_LEFT)
    ImGuiIO_Set_KeyMap(io, ImGuiKey_RightArrow, GLFW.KEY_RIGHT)
    ImGuiIO_Set_KeyMap(io, ImGuiKey_UpArrow, GLFW.KEY_UP)
    ImGuiIO_Set_KeyMap(io, ImGuiKey_DownArrow, GLFW.KEY_DOWN)
    ImGuiIO_Set_KeyMap(io, ImGuiKey_PageUp, GLFW.KEY_PAGE_UP)
    ImGuiIO_Set_KeyMap(io, ImGuiKey_PageDown, GLFW.KEY_PAGE_DOWN)
    ImGuiIO_Set_KeyMap(io, ImGuiKey_Home, GLFW.KEY_HOME)
    ImGuiIO_Set_KeyMap(io, ImGuiKey_End, GLFW.KEY_END)
    ImGuiIO_Set_KeyMap(io, ImGuiKey_Insert, GLFW.KEY_INSERT)
    ImGuiIO_Set_KeyMap(io, ImGuiKey_Delete, GLFW.KEY_DELETE)
    ImGuiIO_Set_KeyMap(io, ImGuiKey_Backspace, GLFW.KEY_BACKSPACE)
    ImGuiIO_Set_KeyMap(io, ImGuiKey_Space, GLFW.KEY_SPACE)
    ImGuiIO_Set_KeyMap(io, ImGuiKey_Enter, GLFW.KEY_ENTER)
    ImGuiIO_Set_KeyMap(io, ImGuiKey_Escape, GLFW.KEY_ESCAPE)
    ImGuiIO_Set_KeyMap(io, ImGuiKey_A, GLFW.KEY_A)
    ImGuiIO_Set_KeyMap(io, ImGuiKey_C, GLFW.KEY_C)
    ImGuiIO_Set_KeyMap(io, ImGuiKey_V, GLFW.KEY_V)
    ImGuiIO_Set_KeyMap(io, ImGuiKey_X, GLFW.KEY_X)
    ImGuiIO_Set_KeyMap(io, ImGuiKey_Y, GLFW.KEY_Y)
    ImGuiIO_Set_KeyMap(io, ImGuiKey_Z, GLFW.KEY_Z)

    # io.SetClipboardTextFn = ImGui_ImplGlfw_SetClipboardText;
    # io.GetClipboardTextFn = ImGui_ImplGlfw_GetClipboardText;
    # io.ClipboardUserData = g_Window;
    # GC.@preserve io begin
    #     io_blob.SetClipboardTextFn[] = g_ImplGlfw_SetClipboardText
    #     io_blob.GetClipboardTextFn[] = g_ImplGlfw_GetClipboardText
    #     io_blob.ClipboardUserData[] = Ptr{Cvoid}(g_Window.handle)
    # end

    g_MouseCursors[ImGuiMouseCursor_Arrow+1] = GLFW.CreateStandardCursor(GLFW.ARROW_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_TextInput+1] = GLFW.CreateStandardCursor(GLFW.IBEAM_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_ResizeAll+1] = GLFW.CreateStandardCursor(GLFW.ARROW_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_ResizeNS+1] = GLFW.CreateStandardCursor(GLFW.VRESIZE_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_ResizeEW+1] = GLFW.CreateStandardCursor(GLFW.HRESIZE_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_ResizeNESW+1] = GLFW.CreateStandardCursor(GLFW.ARROW_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_ResizeNWSE+1] = GLFW.CreateStandardCursor(GLFW.ARROW_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_Hand+1] = GLFW.CreateStandardCursor(GLFW.HAND_CURSOR)

    # if install_callbacks
    #     GLFW.SetMouseButtonCallback(window, igImplGlfw_MouseButtonCallback)
    #     GLFW.SetScrollCallback(window, igImplGlfw_ScrollCallback)
    #     GLFW.SetKeyCallback(window, igImplGlfw_KeyCallback)
    #     GLFW.SetCharCallback(window, igImplGlfw_CharCallback)
    # end

    global g_ClientApi = client_api
    return true;
end

function igImplGlfw_InitForOpenGL(window::GLFW.Window, install_callbacks::Bool)
    igImplGlfw_Init(window, install_callbacks, GlfwClientApi_OpenGL)
end

function igImplGlfw_InitForVulkan(window::GLFW.Window, install_callbacks::Bool)
    igImplGlfw_Init(window, install_callbacks, GlfwClientApi_Vulkan)
end

function igImplGlfw_Shutdown()
    global g_MouseCursors
    for cursor_n = 1:Int(ImGuiMouseCursor_COUNT)
        GLFW.DestroyCursor(g_MouseCursors[cursor_n])
        g_MouseCursors[cursor_n] = GLFW.Cursor(C_NULL)
    end
    global g_ClientApi = GlfwClientApi_Unknown
end

function igImplGlfw_UpdateMousePosAndButtons()
    # global g_MouseJustPressed
    # # update buttons
    # io = igGetIO()
    # mouse_down =
    #
    # GC.@preserve io begin
    #     io_blob = Blob{ImGuiIO}(Ptr{Cvoid}(io), 0, sizeof(ImGuiIO))
    #     mouse = collect(Bool, io_blob.MouseDown[])
    #     for i = 1:length(mouse)
    #         mouse[i] = g_MouseJustPressed[i] || GLFW.GetMouseButton(g_Window, GLFW.MouseButton(i-1))
    #         g_MouseJustPressed[i] = false
    #     end
    #     io_blob.MouseDown[] = tuple(mouse...)
    #
    #     # update mouse position
    #     mouse_pos_backup = io_blob.MousePos[]
    #     io_blob.MousePos[] = ImVec2(-1, -1)
    #     focused = GLFW.GetWindowAttrib(g_Window, GLFW.FOCUSED)
    #     if Bool(focused)
    #         if io_blob.WantSetMousePos[]
    #             GLFW.SetCursorPos(g_Window, Cdouble(mouse_pos_backup.x), Cdouble(mouse_pos_backup.y))
    #         else
    #             mouse_x, mouse_y = GLFW.GetCursorPos(g_Window)
    #             io_blob.MousePos[] = ImVec2(Cfloat(mouse_x), Cfloat(mouse_y))
    #         end
    #     end
    # end
end

function igImplGlfw_UpdateMouseCursor()
    global g_Window
    global g_MouseCursors

    io = igGetIO()
    if Bool(UInt32(ImGuiIO_Get_ConfigFlags(io)) & ImGuiConfigFlags_NoMouseCursorChange) ||
        GLFW.GetInputMode(g_Window, GLFW.CURSOR) == GLFW.CURSOR_DISABLED
        return nothing
    end

    imgui_cursor = igGetMouseCursor()
    if imgui_cursor == ImGuiMouseCursor_None || ImGuiIO_Get_MouseDrawCursor(io)
        # hide OS mouse cursor if imgui is drawing it or if it wants no cursor
        GLFW.SetInputMode(g_Window, GLFW.CURSOR, GLFW_CURSOR_HIDDEN)
    else
        # show OS mouse cursor
        cursor = g_MouseCursors[imgui_cursor+1]
        GLFW.SetCursor(g_Window, cursor.handle != C_NULL ? g_MouseCursors[imgui_cursor+1] : g_MouseCursors[ImGuiMouseCursor_Arrow+1])
        GLFW.SetInputMode(g_Window, GLFW.CURSOR, GLFW.CURSOR_NORMAL)
    end

    return nothing
end

function igImplGlfw_NewFrame()
    global g_Time
    io = igGetIO()
    fonts = ImGuiIO_Get_Fonts(io)
    @assert ImFontAtlas_IsBuilt(fonts)

    # setup display size
    w, h = GLFW.GetWindowSize(g_Window)
    display_w, display_h = GLFW.GetFramebufferSize(g_Window)
    ImGuiIO_Set_DisplaySize(io, ImVec2(Cfloat(w), Cfloat(h)))
    w_scale = w > 0 ? Cfloat(display_w / w) : 0
    h_scale = h > 0 ? Cfloat(display_h / h) : 0
    ImGuiIO_Set_DisplayFramebufferScale(io, ImVec2(w_scale, h_scale))

    # setup time step
    current_time = ccall((:glfwGetTime, GLFW.lib), Cdouble, ())
    ImGuiIO_Set_DeltaTime(io, g_Time > 0.0 ? Cfloat(current_time - g_Time) : Cfloat(1.0/60.0))
    g_Time = current_time

    igImplGlfw_UpdateMousePosAndButtons()
    igImplGlfw_UpdateMouseCursor()
end
