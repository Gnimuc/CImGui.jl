Base.convert(::Type{Cint}, x::GLFW.Key) = Cint(x)

@enum GlfwClientApi GlfwClientApi_Unknown GlfwClientApi_OpenGL GlfwClientApi_Vulkan

function igImplGlfw_Init(window::GLFW.Window, install_callbacks, client_api::GlfwClientApi)
    global g_Window = window
    global g_Time = 0.0

    # setup back-end capabilities flags
    io = igGetIO()
    GC.@preserve io begin
        io_blob = Blob{ImGuiIO}(Ptr{Cvoid}(io), 0, sizeof(ImGuiIO))
        io_blob.BackendFlags[] = UInt32(io_blob.BackendFlags[]) | ImGuiBackendFlags_HasMouseCursors
        io_blob.BackendFlags[] = UInt32(io_blob.BackendFlags[]) | ImGuiBackendFlags_HasSetMousePos
        keymap = collect(Cint, io_blob.KeyMap[])
        # keyboard mapping
        keymap[ImGuiKey_Tab+1] = GLFW.KEY_TAB
        keymap[ImGuiKey_LeftArrow+1] = GLFW.KEY_LEFT
        keymap[ImGuiKey_RightArrow+1] = GLFW.KEY_RIGHT
        keymap[ImGuiKey_UpArrow+1] = GLFW.KEY_UP
        keymap[ImGuiKey_DownArrow+1] = GLFW.KEY_DOWN
        keymap[ImGuiKey_PageUp+1] = GLFW.KEY_PAGE_UP
        keymap[ImGuiKey_PageDown+1] = GLFW.KEY_PAGE_DOWN
        keymap[ImGuiKey_Home+1] = GLFW.KEY_HOME
        keymap[ImGuiKey_End+1] = GLFW.KEY_END
        keymap[ImGuiKey_Insert+1] = GLFW.KEY_INSERT
        keymap[ImGuiKey_Delete+1] = GLFW.KEY_DELETE
        keymap[ImGuiKey_Backspace+1] = GLFW.KEY_BACKSPACE
        keymap[ImGuiKey_Space+1] = GLFW.KEY_SPACE
        keymap[ImGuiKey_Enter+1] = GLFW.KEY_ENTER
        keymap[ImGuiKey_Escape+1] = GLFW.KEY_ESCAPE
        keymap[ImGuiKey_A+1] = GLFW.KEY_A
        keymap[ImGuiKey_C+1] = GLFW.KEY_C
        keymap[ImGuiKey_V+1] = GLFW.KEY_V
        keymap[ImGuiKey_X+1] = GLFW.KEY_X
        keymap[ImGuiKey_Y+1] = GLFW.KEY_Y
        keymap[ImGuiKey_Z+1] = GLFW.KEY_Z
        io_blob.KeyMap[] = tuple(keymap...)

        io_blob.SetClipboardTextFn[] = g_ImplGlfw_SetClipboardText
        io_blob.GetClipboardTextFn[] = g_ImplGlfw_GetClipboardText
        io_blob.ClipboardUserData[] = Ptr{Cvoid}(g_Window.handle)
    end

    g_MouseCursors[ImGuiMouseCursor_Arrow+1] = GLFW.CreateStandardCursor(GLFW.ARROW_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_TextInput+1] = GLFW.CreateStandardCursor(GLFW.IBEAM_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_ResizeAll+1] = GLFW.CreateStandardCursor(GLFW.ARROW_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_ResizeNS+1] = GLFW.CreateStandardCursor(GLFW.VRESIZE_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_ResizeEW+1] = GLFW.CreateStandardCursor(GLFW.HRESIZE_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_ResizeNESW+1] = GLFW.CreateStandardCursor(GLFW.ARROW_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_ResizeNWSE+1] = GLFW.CreateStandardCursor(GLFW.ARROW_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_Hand+1] = GLFW.CreateStandardCursor(GLFW.HAND_CURSOR)

    if install_callbacks
        GLFW.SetMouseButtonCallback(window, igImplGlfw_MouseButtonCallback)
        GLFW.SetScrollCallback(window, igImplGlfw_ScrollCallback)
        GLFW.SetKeyCallback(window, igImplGlfw_KeyCallback)
        GLFW.SetCharCallback(window, igImplGlfw_CharCallback)
    end

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
    for cursor_n = 1:ImGuiMouseCursor_COUNT
        glfwDestroyCursor(g_MouseCursors[cursor_n])
        g_MouseCursors[cursor_n] = GLFW.Cursor(C_NULL)
    end
    global g_ClientApi = GlfwClientApi_Unknown
end

function igImplGlfw_UpdateMousePosAndButtons()
    global g_MouseJustPressed
    # update buttons
    io = igGetIO()
    GC.@preserve io begin
        io_blob = Blob{ImGuiIO}(Ptr{Cvoid}(io), 0, sizeof(ImGuiIO))
        mouse = collect(Bool, io_blob.MouseDown[])
        for i = 1:length(mouse)
            mouse[i] = g_MouseJustPressed[i] || GLFW.GetMouseButton(g_Window, GLFW.MouseButton(i-1))
            g_MouseJustPressed[i] = false
        end
        io_blob.MouseDown[] = tuple(mouse...)

        # update mouse position
        mouse_pos_backup = io_blob.MousePos[]
        io_blob.MousePos[] = ImVec2(-1, -1)
        focused = GLFW.GetWindowAttrib(g_Window, GLFW.FOCUSED)
        if Bool(focused)
            if io_blob.WantSetMousePos[]
                GLFW.SetCursorPos(g_Window, Cdouble(mouse_pos_backup.x), Cdouble(mouse_pos_backup.y))
            else
                mouse_x, mouse_y = GLFW.GetCursorPos(g_Window)
                io_blob.MousePos[] = ImVec2(Cfloat(mouse_x), Cfloat(mouse_y))
            end
        end
    end
end

function igImplGlfw_UpdateMouseCursor()
    global g_Window
    global g_MouseCursors
    io = igGetIO()
    GC.@preserve io begin
        io_blob = Blob{ImGuiIO}(Ptr{Cvoid}(io), 0, sizeof(ImGuiIO))
        cfg_flags = io_blob.ConfigFlags[]
        mouse_draw_cursor = io_blob.MouseDrawCursor[]
    end

    if Bool(UInt32(cfg_flags) & ImGuiConfigFlags_NoMouseCursorChange) ||
        GLFW.GetInputMode(g_Window, GLFW.CURSOR) == GLFW.CURSOR_DISABLED
        return nothing
    end

    imgui_cursor = igGetMouseCursor()
    if imgui_cursor == ImGuiMouseCursor_None || mouse_draw_cursor
        # hide OS mouse cursor if imgui is drawing it or if it wants no cursor
        GLFW.SetInputMode(g_Window, GLFW.CURSOR, GLFW_CURSOR_HIDDEN)
    else
        # show OS mouse cursor
        cursor = g_MouseCursors[imgui_cursor+1]
        GLFW.SetCursor(g_Window, cursor.handle != C_NULL ? g_MouseCursors[imgui_cursor+1] : g_MouseCursors[ImGuiMouseCursor_Arrow+1])
        GLFW.SetInputMode(g_Window, GLFW.CURSOR, GLFW.CURSOR_NORMAL)
    end
end

function igImplGlfw_NewFrame()
    global g_Time
    io = igGetIO()
    # setup display size
    w, h = GLFW.GetWindowSize(g_Window)
    display_w, display_h = GLFW.GetFramebufferSize(g_Window)
    GC.@preserve io begin
        io_blob = Blob{ImGuiIO}(Ptr{Cvoid}(io), 0, sizeof(ImGuiIO))
        io_blob.DisplaySize[] = ImVec2(Cfloat(w), Cfloat(h))
        w_scale = w > 0 ? Cfloat(display_w / w) : 0
        h_scale = h > 0 ? Cfloat(display_h / h) : 0
        io_blob.DisplayFramebufferScale[] = ImVec2(w_scale, h_scale)
        # setup time step
        current_time = ccall((:glfwGetTime, GLFW.lib), Cdouble, ())
        io_blob.DeltaTime[] = g_Time > 0.0 ? Cfloat(current_time - g_Time) : Cfloat(1.0/60.0)
        g_Time = current_time
        fonts = io_blob.Fonts[]
    end
    @assert ImFontAtlas_IsBuilt(fonts)

    igImplGlfw_UpdateMousePosAndButtons()
    igImplGlfw_UpdateMouseCursor()
end
