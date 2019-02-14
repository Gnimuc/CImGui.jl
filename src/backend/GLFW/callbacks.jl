function igImplGlfw_MouseButtonCallback(window::GLFW.Window, button::GLFW.MouseButton, action::GLFW.Action, mods::Cint)
    global g_MouseJustPressed
    b = Int(button)
    if action == GLFW.PRESS && b ≥ 0 && b < length(g_MouseJustPressed)
        g_MouseJustPressed[b+1] = true
    end
end

function igImplGlfw_ScrollCallback(window::GLFW.Window, xoffset, yoffset)
    io = igGetIO()
    mouse_wheel_h = ImGuiIO_Get_MouseWheelH(io)
    mouse_wheel = ImGuiIO_Get_MouseWheel(io)
    mouse_wheel_h += Cfloat(xoffset)
    mouse_wheel += Cfloat(yoffset)
    ImGuiIO_Set_MouseWheelH(io, mouse_wheel_h)
    ImGuiIO_Set_MouseWheel(io, mouse_wheel)
end

function igImplGlfw_KeyCallback(window::GLFW.Window, key, scancode, action, mods)
    io = igGetIO()
    action == GLFW.PRESS && ImGuiIO_Set_KeysDown(io, key, true)
    action == GLFW.RELEASE && ImGuiIO_Set_KeysDown(io, key, false)
    # modifiers are not reliable across systems
    ImGuiIO_Set_KeyCtrl(io, ImGuiIO_Get_KeysDown(io, GLFW.KEY_LEFT_CONTROL) || ImGuiIO_Get_KeysDown(io, GLFW.KEY_RIGHT_CONTROL))
    ImGuiIO_Set_KeyShift(io, ImGuiIO_Get_KeysDown(io, GLFW.KEY_LEFT_SHIFT) || ImGuiIO_Get_KeysDown(io, GLFW.KEY_RIGHT_SHIFT))
    ImGuiIO_Set_KeyAlt(io, ImGuiIO_Get_KeysDown(io, GLFW.KEY_LEFT_ALT) || ImGuiIO_Get_KeysDown(io, GLFW.KEY_RIGHT_ALT))
    ImGuiIO_Set_KeySuper(io, ImGuiIO_Get_KeysDown(io, GLFW.KEY_LEFT_SUPER) || ImGuiIO_Get_KeysDown(io, GLFW.KEY_RIGHT_SUPER))
end

function igImplGlfw_CharCallback(window::GLFW.Window, c)
    io = igGetIO()
    0 < Int(c) < 0x10000 && ImGuiIO_AddInputCharacter(io, c)
end
