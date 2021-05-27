Base.convert(::Type{Cint}, x::GLFW.Key) = Cint(x)

@enum GlfwClientApi GlfwClientApi_Unknown GlfwClientApi_OpenGL GlfwClientApi_Vulkan

const IMGUI_BACKEND_PLATFORM_NAME = "imgui_impl_glfw"

function ImGui_ImplGlfw_Init(window::GLFW.Window, install_callbacks::Bool, client_api::GlfwClientApi)
    g_Window[] = window
    g_Time[] = 0.0

    # setup back-end capabilities flags
    io::Ptr{ImGuiIO} = igGetIO()
    io.BackendFlags = unsafe_load(io.BackendFlags) | ImGuiBackendFlags_HasMouseCursors
    io.BackendFlags = unsafe_load(io.BackendFlags) | ImGuiBackendFlags_HasSetMousePos
    io.BackendFlags = unsafe_load(io.BackendFlags) | ImGuiBackendFlags_PlatformHasViewports
    # TODO: pending glfw 3.4
    # io.BackendFlags = unsafe_load(io.BackendFlags) | ImGuiBackendFlags_HasMouseHoveredViewport
    io.BackendPlatformName = pointer(IMGUI_BACKEND_PLATFORM_NAME)

    # keyboard mapping
    c_set!(io.KeyMap, ImGuiKey_Tab, GLFW.KEY_TAB)
    c_set!(io.KeyMap, ImGuiKey_LeftArrow, GLFW.KEY_LEFT)
    c_set!(io.KeyMap, ImGuiKey_RightArrow, GLFW.KEY_RIGHT)
    c_set!(io.KeyMap, ImGuiKey_UpArrow, GLFW.KEY_UP)
    c_set!(io.KeyMap, ImGuiKey_DownArrow, GLFW.KEY_DOWN)
    c_set!(io.KeyMap, ImGuiKey_PageUp, GLFW.KEY_PAGE_UP)
    c_set!(io.KeyMap, ImGuiKey_PageDown, GLFW.KEY_PAGE_DOWN)
    c_set!(io.KeyMap, ImGuiKey_Home, GLFW.KEY_HOME)
    c_set!(io.KeyMap, ImGuiKey_End, GLFW.KEY_END)
    c_set!(io.KeyMap, ImGuiKey_Insert, GLFW.KEY_INSERT)
    c_set!(io.KeyMap, ImGuiKey_Delete, GLFW.KEY_DELETE)
    c_set!(io.KeyMap, ImGuiKey_Backspace, GLFW.KEY_BACKSPACE)
    c_set!(io.KeyMap, ImGuiKey_Space, GLFW.KEY_SPACE)
    c_set!(io.KeyMap, ImGuiKey_Enter, GLFW.KEY_ENTER)
    c_set!(io.KeyMap, ImGuiKey_Escape, GLFW.KEY_ESCAPE)
    c_set!(io.KeyMap, ImGuiKey_KeyPadEnter, GLFW.KEY_KP_ENTER)
    c_set!(io.KeyMap, ImGuiKey_A, GLFW.KEY_A)
    c_set!(io.KeyMap, ImGuiKey_C, GLFW.KEY_C)
    c_set!(io.KeyMap, ImGuiKey_V, GLFW.KEY_V)
    c_set!(io.KeyMap, ImGuiKey_X, GLFW.KEY_X)
    c_set!(io.KeyMap, ImGuiKey_Y, GLFW.KEY_Y)
    c_set!(io.KeyMap, ImGuiKey_Z, GLFW.KEY_Z)

    # set clipboard
    io.SetClipboardTextFn = g_ImplGlfw_SetClipboardText[]
    io.GetClipboardTextFn = g_ImplGlfw_GetClipboardText[]
    io.ClipboardUserData = Ptr{Cvoid}(g_Window[].handle)

    # create mouse cursors
    g_MouseCursors[ImGuiMouseCursor_Arrow+1] = GLFW.CreateStandardCursor(GLFW.ARROW_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_TextInput+1] = GLFW.CreateStandardCursor(GLFW.IBEAM_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_ResizeNS+1] = GLFW.CreateStandardCursor(GLFW.VRESIZE_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_ResizeEW+1] = GLFW.CreateStandardCursor(GLFW.HRESIZE_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_Hand+1] = GLFW.CreateStandardCursor(GLFW.HAND_CURSOR)

    # prepare for GLFW 3.4+
    # g_MouseCursors[ImGuiMouseCursor_ResizeAll+1] = GLFW.CreateStandardCursor(GLFW.RESIZE_ALL_CURSOR)
    # g_MouseCursors[ImGuiMouseCursor_ResizeNESW+1] = GLFW.CreateStandardCursor(GLFW.RESIZE_NESW_CURSOR)
    # g_MouseCursors[ImGuiMouseCursor_ResizeNWSE+1] = GLFW.CreateStandardCursor(GLFW.RESIZE_NWSE_CURSOR)
    # g_MouseCursors[ImGuiMouseCursor_NotAllowed+1] = GLFW.CreateStandardCursor(GLFW.NOT_ALLOWED_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_ResizeAll+1] = GLFW.CreateStandardCursor(GLFW.ARROW_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_ResizeNESW+1] = GLFW.CreateStandardCursor(GLFW.ARROW_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_ResizeNWSE+1] = GLFW.CreateStandardCursor(GLFW.ARROW_CURSOR)
    g_MouseCursors[ImGuiMouseCursor_NotAllowed+1] = GLFW.CreateStandardCursor(GLFW.ARROW_CURSOR)

    if install_callbacks
        g_InstalledCallbacks[] = true
        GLFW.SetMouseButtonCallback(window, ImGui_ImplGlfw_MouseButtonCallback)
        GLFW.SetScrollCallback(window, ImGui_ImplGlfw_ScrollCallback)
        GLFW.SetKeyCallback(window, ImGui_ImplGlfw_KeyCallback)
        GLFW.SetCharCallback(window, ImGui_ImplGlfw_CharCallback)
    end

    # update monitors the first time
    ImGui_ImplGlfw_UpdateMonitors()
    GLFW.SetMonitorCallback(ImGui_ImplGlfw_MonitorCallback)

    # the mouse update function expect PlatformHandle to be filled for the main viewport
    main_viewport::Ptr{ImGuiViewport} = igGetMainViewport()
    main_viewport.PlatformHandle = Ptr{Cvoid}(g_Window[].handle)
    if Sys.iswindows()
        main_viewport.PlatformHandleRaw = ccall((:glfwGetWin32Window, GLFW.libglfw), Ptr{Cvoid}, (Ptr{Cvoid},), g_Window[].handle)
    end
    if unsafe_load(io.ConfigFlags) & ImGuiConfigFlags_ViewportsEnable != 0
        ImGui_ImplGlfw_InitPlatformInterface()
    end

    g_ClientApi[] = client_api
    return true
end

function ImGui_ImplGlfw_InitForOpenGL(window::GLFW.Window, install_callbacks::Bool)
    ImGui_ImplGlfw_Init(window, install_callbacks, GlfwClientApi_OpenGL)
end

function ImGui_ImplGlfw_InitForVulkan(window::GLFW.Window, install_callbacks::Bool)
    ImGui_ImplGlfw_Init(window, install_callbacks, GlfwClientApi_Vulkan)
end

function ImGui_ImplGlfw_InitForOther(window::GLFW.Window, install_callbacks::Bool)
    ImGui_ImplGlfw_Init(window, install_callbacks, GlfwClientApi_Unknown)
end

function ImGui_ImplGlfw_Shutdown()
    ImGui_ImplGlfw_ShutdownPlatformInterface()

    if g_InstalledCallbacks[]
        # FIXME
        g_InstalledCallbacks[] = false
    end

    for cursor_n = 1:ImGuiMouseCursor_COUNT
        GLFW.DestroyCursor(g_MouseCursors[cursor_n])
        g_MouseCursors[cursor_n] = GLFW.Cursor(C_NULL)
    end

    g_ClientApi[] = GlfwClientApi_Unknown
end

function ImGui_ImplGlfw_UpdateMousePosAndButtons()
    # update buttons
    io::Ptr{ImGuiIO} = igGetIO()
    for i = 1:length(g_MouseJustPressed)
        # if a mouse press event came, always pass it as "mouse held this frame",
        # so we don't miss click-release events that are shorter than 1 frame.
        mousedown = g_MouseJustPressed[i] || GLFW.GetMouseButton(g_Window[], GLFW.MouseButton(i-1))
        c_set!(io.MouseDown, i-1, mousedown)
        g_MouseJustPressed[i] = false
    end

    # update mouse position
    mouse_pos_backup = unsafe_load(io.MousePos)
    FLT_MAX = igGET_FLT_MAX()
    io.MousePos = ImVec2(-FLT_MAX, -FLT_MAX)
    io.MouseHoveredViewport = 0
    platform_io::Ptr{ImGuiPlatformIO} = igGetPlatformIO()
    vp = unsafe_load(platform_io.Viewports)
    viewport_ptrs = unsafe_wrap(Vector{Ptr{ImGuiViewport}}, vp.Data, vp.Size)
    for viewport in viewport_ptrs
        window = GLFW.Window(unsafe_load(viewport.PlatformHandle))
        @assert window != C_NULL

        is_focused = GLFW.GetWindowAttrib(window, GLFW.FOCUSED) != 0
        if is_focused
            if unsafe_load(io.WantSetMousePos)
                x = Cdouble(mouse_pos_backup.x - unsafe_load(viewport.Pos.x))
                y = Cdouble(mouse_pos_backup.y - unsafe_load(viewport.Pos.y))
                GLFW.SetCursorPos(window, x, y)
            else
                mouse_x::Cfloat, mouse_y::Cfloat = GLFW.GetCursorPos(window)
                if unsafe_load(io.ConfigFlags) & ImGuiConfigFlags_ViewportsEnable != 0
                    # Multi-viewport mode: mouse position in OS absolute coordinates (io.MousePos is (0,0) when the mouse is on the upper-left of the primary monitor)
                    window_x, window_y = GLFW.GetWindowPos(window)
                    io.MousePos = ImVec2(mouse_x + window_x, mouse_y + window_y)
                else
                    # Single viewport mode: mouse position in client window coordinates (io.MousePos is (0,0) when the mouse is on the upper-left corner of the app window)
                    io.MousePos = ImVec2(mouse_x, mouse_y)
                end
            end

        end
        md = unsafe_load(io.MouseDown)
        for i = 0:length(md)-1
            c_set!(io.MouseDown, i, (md[i+1] | GLFW.GetMouseButton(window, i)) != 0)
        end
    end
    # TODO: pending glfw 3.4 GLFW_HAS_MOUSE_PASSTHROUGH
end

function ImGui_ImplGlfw_UpdateMouseCursor()
    io::Ptr{ImGuiIO} = igGetIO()
    if (unsafe_load(io.ConfigFlags) & ImGuiConfigFlags_NoMouseCursorChange != 0) ||
        GLFW.GetInputMode(g_Window[], GLFW.CURSOR) == GLFW.CURSOR_DISABLED
        return nothing
    end

    imgui_cursor = igGetMouseCursor()
    platform_io::Ptr{ImGuiPlatformIO} = igGetPlatformIO()
    vp = unsafe_load(platform_io.Viewports)
    viewport_ptrs = unsafe_wrap(Vector{Ptr{ImGuiViewport}}, vp.Data, vp.Size)
    for viewport in viewport_ptrs
        window = GLFW.Window(unsafe_load(viewport.PlatformHandle))
        @assert window != C_NULL
        if imgui_cursor == ImGuiMouseCursor_None || unsafe_load(io.MouseDrawCursor)
            # hide OS mouse cursor if imgui is drawing it or if it wants no cursor
            GLFW.SetInputMode(window, GLFW.CURSOR, GLFW.CURSOR_HIDDEN)
        else
            # show OS mouse cursor
            cursor = g_MouseCursors[imgui_cursor+1]
            GLFW.SetCursor(window, cursor.handle != C_NULL ? g_MouseCursors[imgui_cursor+1] : g_MouseCursors[ImGuiMouseCursor_Arrow+1])
            GLFW.SetInputMode(window, GLFW.CURSOR, GLFW.CURSOR_NORMAL)
        end
    end

    return nothing
end

function Base.getproperty(x::Ptr{ImGuiPlatformMonitor}, f::Symbol)
    f === :MainPos && return Ptr{ImVec2}(x + 0)
    f === :MainSize && return Ptr{ImVec2}(x + 8)
    f === :WorkPos && return Ptr{ImVec2}(x + 16)
    f === :WorkSize && return Ptr{ImVec2}(x + 24)
    f === :DpiScale && return Ptr{Cfloat}(x + 32)
    return getfield(x, f)
end

function Base.setproperty!(x::Ptr{ImGuiPlatformMonitor}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

function ImGui_ImplGlfw_UpdateMonitors()
    platform_io::Ptr{ImGuiPlatformIO} = igGetPlatformIO()
	glfw_monitors = GLFW.GetMonitors()
    monitors_count = Ref{Cint}(length(glfw_monitors))
    monitors_ptr::Ptr{ImGuiPlatformMonitor} = Libc.malloc(monitors_count[] * sizeof(ImGuiPlatformMonitor))
    for n = 0:monitors_count[]-1
        glfw_monitor = glfw_monitors[n+1]
        x, y = GLFW.GetMonitorPos(glfw_monitor)
        vid_mode = GLFW.GetVideoMode(glfw_monitor)
        main_pos, work_pos = ImVec2(x, y), ImVec2(x, y)
        main_size, work_size = ImVec2(vid_mode.width, vid_mode.height), ImVec2(vid_mode.width, vid_mode.height)
        x_scale, y_scale = GLFW.GetMonitorContentScale(glfw_monitor)
        mptr::Ptr{ImGuiPlatformMonitor} = monitors_ptr + n * sizeof(ImGuiPlatformMonitor)
        mptr.MainPos = ImVec2(x, y)
        mptr.MainSize = ImVec2(vid_mode.width, vid_mode.height)
        mptr.WorkPos = ImVec2(x, y)
        mptr.WorkSize = ImVec2(vid_mode.width, vid_mode.height)
        mptr.DpiScale = x_scale
    end
    platform_io.Monitors = ImVector_ImGuiPlatformMonitor(monitors_count[], monitors_count[], monitors_ptr)
    g_WantUpdateMonitors[] = false
end

function ImGui_ImplGlfw_NewFrame()
    io::Ptr{ImGuiIO} = igGetIO()
    @assert ImFontAtlas_IsBuilt(unsafe_load(io.Fonts)) "Font atlas not built! It is generally built by the renderer back-end. Missing call to renderer _NewFrame() function? e.g. ImGui_ImplOpenGL3_NewFrame()."

    # setup display size (every frame to accommodate for window resizing)
    w, h = GLFW.GetWindowSize(g_Window[])
    display_w, display_h = GLFW.GetFramebufferSize(g_Window[])
    io.DisplaySize = ImVec2(Cfloat(w), Cfloat(h))
    w_scale = w > 0 ? Cfloat(display_w / w) : 0f0
    h_scale = h > 0 ? Cfloat(display_h / h) : 0f0
    io.DisplayFramebufferScale = ImVec2(w_scale, h_scale)
    g_WantUpdateMonitors[] && ImGui_ImplGlfw_UpdateMonitors()

    # setup time step
    current_time = ccall((:glfwGetTime, GLFW.libglfw), Cdouble, ())
    io.DeltaTime = g_Time[] > 0.0 ? Cfloat(current_time - g_Time[]) : Cfloat(1.0/60.0)
    g_Time[] = current_time

    ImGui_ImplGlfw_UpdateMousePosAndButtons()
    ImGui_ImplGlfw_UpdateMouseCursor()

    # TODO: Gamepad navigation mapping
    # ImGui_ImplGlfw_UpdateGamepads()
end

function ImGui_ImplGlfw_CreateWindow(viewport::Ptr{ImGuiViewport})
    data::Ptr{ImGuiViewportDataGlfw} = Libc.malloc(sizeof(ImGuiViewportDataGlfw))
    viewport.PlatformUserData = data

    GLFW.WindowHint(GLFW.VISIBLE, false)
    GLFW.WindowHint(GLFW.FOCUSED, false)
    GLFW.WindowHint(GLFW.FOCUS_ON_SHOW, false)
    GLFW.WindowHint(GLFW.DECORATED, (unsafe_load(viewport.Flags) & ImGuiViewportFlags_NoDecoration != 0) ? false : true)
    GLFW.WindowHint(GLFW.FLOATING, unsafe_load(viewport.Flags) & ImGuiViewportFlags_TopMost != 0)

    share_window = g_ClientApi[] == GlfwClientApi_OpenGL ? g_Window[] : GLFW.Window(C_NULL)
    window_size = unsafe_load(viewport.Size)
    wx, wy = trunc(Cint, window_size.x), trunc(Cint, window_size.y)
    data_Window = GLFW.CreateWindow(wx, wy, "No Title Yet", GLFW.Monitor(C_NULL), share_window)
    viewport.PlatformHandle = data_Window.handle
    if Sys.iswindows()
        viewport.PlatformHandleRaw = ccall((:glfwGetWin32Window, GLFW.libglfw), Ptr{Cvoid}, (GLFW.Window,), data_Window)
    end
    pos = unsafe_load(viewport.Pos)
    px, py = trunc(Cint, pos.x), trunc(Cint, pos.y)
    GLFW.SetWindowPos(data_Window, px, py)

    # install callbacks
    GLFW.SetMouseButtonCallback(data_Window, ImGui_ImplGlfw_MouseButtonCallback)
    GLFW.SetScrollCallback(data_Window, ImGui_ImplGlfw_ScrollCallback)
    GLFW.SetKeyCallback(data_Window, ImGui_ImplGlfw_KeyCallback)
    GLFW.SetCharCallback(data_Window, ImGui_ImplGlfw_CharCallback)
    GLFW.SetCharCallback(data_Window, ImGui_ImplGlfw_WindowCloseCallback)
    GLFW.SetCharCallback(data_Window, ImGui_ImplGlfw_WindowPosCallback)
    GLFW.SetCharCallback(data_Window, ImGui_ImplGlfw_WindowSizeCallback)
    if g_ClientApi[] == GlfwClientApi_OpenGL
        GLFW.MakeContextCurrent(data_Window)
        GLFW.SwapInterval(0)
    end

    data.Window = data_Window.handle
    data.WindowOwned = true
    data.IgnoreWindowPosEventFrame = -1
    data.IgnoreWindowSizeEventFrame = -1

    return nothing
end

function ImGui_ImplGlfw_DestroyWindow(viewport::Ptr{ImGuiViewport})
    data::Ptr{ImGuiViewportDataGlfw} = unsafe_load(viewport.PlatformUserData)
    if data != C_NULL
        if unsafe_load(data.WindowOwned)
            # release any keys that were pressed in the window being destroyed and are still held down,
            # because we will not receive any release events after window is destroyed.
            win = GLFW.Window(unsafe_load(data.Window))
            for i = 0:length(g_KeyOwnerWindows)-1
                if g_KeyOwnerWindows[i+1].handle == win.handle
                    ImGui_ImplGlfw_KeyCallback(win, i, 0, GLFW.RELEASE, 0)
                end
            end
            GLFW.DestroyWindow(win)
        end
        data.Window = C_NULL
        Libc.free(data)
    end
    viewport.PlatformUserData = C_NULL
    viewport.PlatformHandle = C_NULL
    return nothing
end

function ImGui_ImplGlfw_ShowWindow(viewport::Ptr{ImGuiViewport})
    data::Ptr{ImGuiViewportDataGlfw} = unsafe_load(viewport.PlatformUserData)
    if Sys.iswindows()
        # FIXME
    end
    GLFW.ShowWindow(GLFW.Window(unsafe_load(data.Window)))
    return nothing
end

function ImGui_ImplGlfw_GetWindowPos(viewport::Ptr{ImGuiViewport})
    data::Ptr{ImGuiViewportDataGlfw} = unsafe_load(viewport.PlatformUserData)
    x, y = GLFW.GetWindowPos(GLFW.Window(unsafe_load(data.Window)))
    return ImVec2(Cfloat(x), Cfloat(y))
end

function ImGui_ImplGlfw_SetWindowPos(viewport::Ptr{ImGuiViewport}, pos::ImVec2)
    data::Ptr{ImGuiViewportDataGlfw} = unsafe_load(viewport.PlatformUserData)
    data.IgnoreWindowPosEventFrame = igGetFrameCount()
    x, y = trunc(Cint, pos.x), trunc(Cint, pos.y)
    GLFW.SetWindowPos(GLFW.Window(unsafe_load(data.Window)), x, y)
    return nothing
end

function ImGui_ImplGlfw_GetWindowSize(viewport::Ptr{ImGuiViewport})
    data::Ptr{ImGuiViewportDataGlfw} = unsafe_load(viewport.PlatformUserData)
    w, h = GLFW.GetWindowSize(GLFW.Window(unsafe_load(data.Window)))
    return ImVec2(Cfloat(w), Cfloat(h))
end

function ImGui_ImplGlfw_SetWindowSize(viewport::Ptr{ImGuiViewport}, size::ImVec2)
    data::Ptr{ImGuiViewportDataGlfw} = unsafe_load(viewport.PlatformUserData)
    data.IgnoreWindowSizeEventFrame = igGetFrameCount()
    x, y = trunc(Cint, size.x), trunc(Cint, size.y)
    GLFW.SetWindowSize(GLFW.Window(unsafe_load(data.Window)), x, y)
    return nothing
end

function ImGui_ImplGlfw_SetWindowTitle(viewport::Ptr{ImGuiViewport}, title::Ptr{Cchar})
    data::Ptr{ImGuiViewportDataGlfw} = unsafe_load(viewport.PlatformUserData)
    ccall((:glfwSetWindowTitle, GLFW.libglfw), Cvoid, (GLFW.Window, Ptr{Cchar}), GLFW.Window(unsafe_load(data.Window)), title)
    return nothing
end

function ImGui_ImplGlfw_SetWindowFocus(viewport::Ptr{ImGuiViewport})
    data::Ptr{ImGuiViewportDataGlfw} = unsafe_load(viewport.PlatformUserData)
    GLFW.FocusWindow(GLFW.Window(unsafe_load(data.Window)))
    return nothing
end

function ImGui_ImplGlfw_GetWindowFocus(viewport::Ptr{ImGuiViewport})
    data::Ptr{ImGuiViewportDataGlfw} = unsafe_load(viewport.PlatformUserData)
    return GLFW.GetWindowAttrib(GLFW.Window(unsafe_load(data.Window)), GLFW.FOCUSED) != 0
end

function ImGui_ImplGlfw_GetWindowMinimized(viewport::Ptr{ImGuiViewport})
    data::Ptr{ImGuiViewportDataGlfw} = unsafe_load(viewport.PlatformUserData)
    return GLFW.GetWindowAttrib(GLFW.Window(unsafe_load(data.Window)), GLFW.ICONIFIED) != 0
end

function ImGui_ImplGlfw_SetWindowAlpha(viewport::Ptr{ImGuiViewport}, alpha::Cfloat)
    data::Ptr{ImGuiViewportDataGlfw} = unsafe_load(viewport.PlatformUserData)
    GLFW.SetWindowOpacity(GLFW.Window(unsafe_load(data.Window)), alpha)
    return nothing
end

function ImGui_ImplGlfw_RenderWindow(viewport::Ptr{ImGuiViewport}, userdata::Ptr{Cvoid})
    data::Ptr{ImGuiViewportDataGlfw} = unsafe_load(viewport.PlatformUserData)
    if g_ClientApi[] == GlfwClientApi_OpenGL
        GLFW.MakeContextCurrent(GLFW.Window(unsafe_load(data.Window)))
    end
    return nothing
end

function ImGui_ImplGlfw_SwapBuffers(viewport::Ptr{ImGuiViewport}, userdata::Ptr{Cvoid})
    data::Ptr{ImGuiViewportDataGlfw} = unsafe_load(viewport.PlatformUserData)
    if g_ClientApi[] == GlfwClientApi_OpenGL
        GLFW.MakeContextCurrent(GLFW.Window(unsafe_load(data.Window)))
        GLFW.SwapBuffers(GLFW.Window(unsafe_load(data.Window)))
    end
    return nothing
end

function ImGui_ImplGlfw_InitPlatformInterface()
    # register platform interface (will be coupled with a renderer interface)
    platform_io::Ptr{ImGuiPlatformIO} = igGetPlatformIO()
    platform_io.Platform_CreateWindow = @cfunction(ImGui_ImplGlfw_CreateWindow, Cvoid, (Ptr{ImGuiViewport},))
    platform_io.Platform_DestroyWindow = @cfunction(ImGui_ImplGlfw_DestroyWindow, Cvoid, (Ptr{ImGuiViewport},))
    platform_io.Platform_ShowWindow = @cfunction(ImGui_ImplGlfw_ShowWindow, Cvoid, (Ptr{ImGuiViewport},))
    platform_io.Platform_SetWindowPos = @cfunction(ImGui_ImplGlfw_SetWindowPos, Cvoid, (Ptr{ImGuiViewport}, ImVec2))
    platform_io.Platform_GetWindowPos = @cfunction(ImGui_ImplGlfw_GetWindowPos, ImVec2, (Ptr{ImGuiViewport},))
    platform_io.Platform_SetWindowSize = @cfunction(ImGui_ImplGlfw_SetWindowSize, Cvoid, (Ptr{ImGuiViewport}, ImVec2))
    platform_io.Platform_GetWindowSize = @cfunction(ImGui_ImplGlfw_GetWindowSize, ImVec2, (Ptr{ImGuiViewport},))
    platform_io.Platform_SetWindowFocus = @cfunction(ImGui_ImplGlfw_SetWindowFocus, Cvoid, (Ptr{ImGuiViewport},))
    platform_io.Platform_GetWindowFocus = @cfunction(ImGui_ImplGlfw_GetWindowFocus, Bool, (Ptr{ImGuiViewport},))
    platform_io.Platform_GetWindowMinimized = @cfunction(ImGui_ImplGlfw_GetWindowMinimized, Bool, (Ptr{ImGuiViewport},))
    platform_io.Platform_SetWindowTitle = @cfunction(ImGui_ImplGlfw_SetWindowTitle, Cvoid, (Ptr{ImGuiViewport}, Ptr{Cchar}))
    platform_io.Platform_RenderWindow = @cfunction(ImGui_ImplGlfw_RenderWindow, Cvoid, (Ptr{ImGuiViewport}, Ptr{Cvoid}))
    platform_io.Platform_SwapBuffers = @cfunction(ImGui_ImplGlfw_SwapBuffers, Cvoid, (Ptr{ImGuiViewport}, Ptr{Cvoid}))
    platform_io.Platform_SetWindowAlpha = @cfunction(ImGui_ImplGlfw_SetWindowAlpha, Cvoid, (Ptr{ImGuiViewport}, Cfloat))

    # register main window handle (which is owned by the main application, not by us)
    # this is mostly for simplicity and consistency, so that our code (e.g. mouse handling etc.) can use same logic for main and secondary viewports.
    main_viewport::Ptr{ImGuiViewport} = igGetMainViewport()
    data::Ptr{ImGuiViewportDataGlfw} = Libc.malloc(sizeof(ImGuiViewportDataGlfw))
    data.Window = g_Window[].handle
    data.WindowOwned = false
    data.IgnoreWindowPosEventFrame = -1
    data.IgnoreWindowSizeEventFrame = -1
    main_viewport.PlatformUserData = data
    main_viewport.PlatformHandle = Ptr{Cvoid}(g_Window[].handle)

    return nothing
end

ImGui_ImplGlfw_ShutdownPlatformInterface() = nothing
