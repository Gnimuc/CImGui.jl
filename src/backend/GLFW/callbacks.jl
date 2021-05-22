# custom callbacks
SetCustomMouseButtonCallback(x::Function) = g_CustomCallbackMousebutton[] = x
SetCustomScrollCallback(x::Function) = g_CustomCallbackScroll[] = x
SetCustomKeyCallback(x::Function) = g_CustomCallbackKey[] = x
SetCustomCharCallback(x::Function) = g_CustomCallbackChar[] = x

function ImGui_ImplGlfw_MouseButtonCallback(window::GLFW.Window, button::GLFW.MouseButton, action::GLFW.Action, mods::Cint)::Cvoid
    g_CustomCallbackMousebutton[] != C_NULL && g_CustomCallbackMousebutton[](window, button, action, mods)
    b = Cint(button)
    if action == GLFW.PRESS && b ≥ 0 && b < length(g_MouseJustPressed)
        g_MouseJustPressed[b+1] = true
    end
    return nothing
end

function ImGui_ImplGlfw_ScrollCallback(window::GLFW.Window, xoffset, yoffset)::Cvoid
    g_CustomCallbackScroll[] != C_NULL && g_CustomCallbackScroll[](window, xoffset, yoffset)
    io::Ptr{ImGuiIO} = igGetIO()
    io.MouseWheelH = unsafe_load(io.MouseWheelH) + Cfloat(xoffset)
    io.MouseWheel = unsafe_load(io.MouseWheel) + Cfloat(yoffset)
    return nothing
end

function ImGui_ImplGlfw_KeyCallback(window::GLFW.Window, key, scancode, action, mods)::Cvoid
    g_CustomCallbackKey[] != C_NULL && g_CustomCallbackKey[](window, key, scancode, action, mods)

    io::Ptr{ImGuiIO} = igGetIO()
    k = Cint(key)
    if k ≥ 0 && k < length(unsafe_load(io.KeysDown))
        if action == GLFW.PRESS
            c_set!(io.KeysDown, k, true)
            g_KeyOwnerWindows[k+1] = window
        end
        if action == GLFW.RELEASE
            c_set!(io.KeysDown, k, false)
            g_KeyOwnerWindows[k+1] = GLFW.Window(C_NULL)
        end
    end

    # modifiers are not reliable across systems
    io.KeyCtrl = c_get(io.KeysDown, GLFW.KEY_LEFT_CONTROL) || c_get(io.KeysDown, GLFW.KEY_RIGHT_CONTROL)
    io.KeyShift = c_get(io.KeysDown, GLFW.KEY_LEFT_SHIFT) || c_get(io.KeysDown, GLFW.KEY_RIGHT_SHIFT)
    io.KeyAlt = c_get(io.KeysDown, GLFW.KEY_LEFT_ALT) || c_get(io.KeysDown, GLFW.KEY_RIGHT_ALT)
    if Sys.iswindows()
        io.KeySuper = false
    else
        io.KeySuper = c_get(io.KeysDown, GLFW.KEY_LEFT_SUPER) || c_get(io.KeysDown, GLFW.KEY_RIGHT_SUPER)
    end

    return nothing
end

function ImGui_ImplGlfw_CharCallback(window::GLFW.Window, c)::Cvoid
    g_CustomCallbackChar[] != C_NULL && g_CustomCallbackChar[](window, c)
    0 < Cuint(c) < 0x10000 && ImGuiIO_AddInputCharacter(igGetIO(), c)
    return nothing
end

function ImGui_ImplGlfw_MonitorCallback(monitor::GLFW.Monitor, x::Cint)::Cvoid
    g_WantUpdateMonitors[] = true
    return nothing
end

function ImGui_ImplGlfw_WindowCloseCallback(window::GLFW.Window)::Cvoid
    viewport::Ptr{ImGuiViewport} = igFindViewportByPlatformHandle(window)
    if viewport != C_NULL
        viewport.PlatformRequestClose = true
    end
    return nothing
end

function ImGui_ImplGlfw_WindowPosCallback(window::GLFW.Window, x::Cint, y::Cint)::Cvoid
    viewport::Ptr{ImGuiViewport} = igFindViewportByPlatformHandle(window)
    if viewport != C_NULL
        data::Ptr{ImGuiViewportDataGlfw} = viewport.PlatformUserData
        if data != C_NULL
            ignore_event = igGetFrameCount() ≤ (unsafe_load(data.IgnoreWindowPosEventFrame) + 1)
            ignore_event && return nothing
        end
        viewport.PlatformRequestMove = true
    end
    return nothing
end

function ImGui_ImplGlfw_WindowSizeCallback(window::GLFW.Window, x::Cint, y::Cint)::Cvoid
    viewport::Ptr{ImGuiViewport} = igFindViewportByPlatformHandle(window)
    if viewport != C_NULL
        data::Ptr{ImGuiViewportDataGlfw} = viewport.PlatformUserData
        if data != C_NULL
            ignore_event = igGetFrameCount() ≤ (unsafe_load(data.IgnoreWindowSizeEventFrame) + 1)
            ignore_event && return nothing
        end
        viewport.PlatformRequestResize = true
    end
    return nothing
end
