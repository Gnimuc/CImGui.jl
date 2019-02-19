function ImGui_ImplGlfw_MouseButtonCallback(window::GLFW.Window, button::GLFW.MouseButton, action::GLFW.Action, mods::Cint)
    global g_MouseJustPressed
    b = Cint(button)
    if action == GLFW.PRESS && b ≥ 0 && b < length(g_MouseJustPressed)
        g_MouseJustPressed[b+1] = true
    end
end

function ImGui_ImplGlfw_ScrollCallback(window::GLFW.Window, xoffset, yoffset)
    io = igGetIO()
    io.MouseWheelH += Cfloat(xoffset)
    io.MouseWheel += Cfloat(yoffset)
end

function ImGui_ImplGlfw_KeyCallback(window::GLFW.Window, key, scancode, action, mods)
    io = igGetIO()
    action == GLFW.PRESS && Set_KeysDown(io, key, true)
    action == GLFW.RELEASE && Set_KeysDown(io, key, false)
    # modifiers are not reliable across systems
    io.KeyCtrl = Get_KeysDown(io, GLFW.KEY_LEFT_CONTROL) || Get_KeysDown(io, GLFW.KEY_RIGHT_CONTROL)
    io.KeyShift = Get_KeysDown(io, GLFW.KEY_LEFT_SHIFT) || Get_KeysDown(io, GLFW.KEY_RIGHT_SHIFT)
    io.KeyAlt = Get_KeysDown(io, GLFW.KEY_LEFT_ALT) || Get_KeysDown(io, GLFW.KEY_RIGHT_ALT)
    io.KeySuper = Get_KeysDown(io, GLFW.KEY_LEFT_SUPER) || Get_KeysDown(io, GLFW.KEY_RIGHT_SUPER)
end

function ImGui_ImplGlfw_CharCallback(window::GLFW.Window, c)
    io = igGetIO()
    0 < Cuint(c) < 0x10000 && AddInputCharacter(io, c)
end
