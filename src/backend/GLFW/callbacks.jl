function igImplGlfw_MouseButtonCallback(window::GLFW.Window, button::GLFW.MouseButton, action::GLFW.Action, mods::Cint)
    global g_MouseJustPressed
    b = Int(button)
    if action == GLFW.PRESS && b ≥ 0 && b < length(g_MouseJustPressed)
        g_MouseJustPressed[button+1] = true
    end
end

function igImplGlfw_ScrollCallback(window::GLFW.Window, xoffset, yoffset)
    io = igGetIO()
    io_blob = Blob{ImGuiIO}(Ptr{Cvoid}(io), 0, sizeof(ImGuiIO))
    io_blob.MouseWheelH[] += Cfloat(xoffset)
    io_blob.MouseWheel[] += Cfloat(yoffset)
end

function igImplGlfw_KeyCallback(window::GLFW.Window, key, scancode, action, mods)
    io = igGetIO()

    io_blob = Blob{ImGuiIO}(Ptr{Cvoid}(io), 0, sizeof(ImGuiIO))
    keysdown = collect(Bool, io_blob.KeysDown[])
    action == GLFW.PRESS && (keysdown[key+1] = true;)
    action == GLFW.RELEASE && (keysdown[key+1] = false;)

    # modifiers are not reliable across systems
    io_blob.KeyCtrl[] = keysdown[GLFW.KEY_LEFT_CONTROL+1] || keysdown[GLFW.KEY_RIGHT_CONTROL+1]
    io_blob.KeyShift[] = keysdown[GLFW.KEY_LEFT_SHIFT+1] || keysdown[GLFW.KEY_RIGHT_SHIFT+1]
    io_blob.KeyAlt[] = keysdown[GLFW.KEY_LEFT_ALT+1] || keysdown[GLFW.KEY_RIGHT_ALT+1]
    io_blob.KeySuper[] = keysdown[GLFW.KEY_LEFT_SUPER+1] || keysdown[GLFW.KEY_RIGHT_SUPER+1]

    io_blob.KeysDown[] = tuple(keysdown...)
end

function igImplGlfw_CharCallback(window::GLFW.Window, c)
    io = igGetIO()
    0 < c < 0x10000 && ImGuiIO_AddInputCharacter(io, c)
end
