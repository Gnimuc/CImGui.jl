# custom callbacks
SetCustomMouseButtonCallback(x::Function) = g_CustomCallbackMousebutton[] = x
SetCustomScrollCallback(x::Function) = g_CustomCallbackScroll[] = x
SetCustomKeyCallback(x::Function) = g_CustomCallbackKey[] = x
SetCustomCharCallback(x::Function) = g_CustomCallbackChar[] = x

function ImGui_ImplGlfw_MouseButtonCallback(window::GLFW.Window, button::GLFW.MouseButton, action::GLFW.Action, mods::Cint)
    g_CustomCallbackMousebutton[] != C_NULL && g_CustomCallbackMousebutton[](window, button, action, mods)
    b = Cint(button)
    if action == GLFW.PRESS && b ≥ 0 && b < length(g_MouseJustPressed)
        g_MouseJustPressed[b+1] = true
    end
end

function ImGui_ImplGlfw_ScrollCallback(window::GLFW.Window, xoffset, yoffset)
    g_CustomCallbackScroll[] != C_NULL && g_CustomCallbackScroll[](window, xoffset, yoffset)
    io = GetIO()
    io.MouseWheelH = unsafe_load(io.MouseWheelH) + Cfloat(xoffset)
    io.MouseWheel = unsafe_load(io.MouseWheel) + Cfloat(yoffset)
end

function ImGui_ImplGlfw_KeyCallback(window::GLFW.Window, key, scancode, action, mods)
    g_CustomCallbackKey[] != C_NULL && g_CustomCallbackKey[](window, key, scancode, action, mods)

    io = GetIO()
    action == GLFW.PRESS && Set_KeysDown(io, key, true)
    action == GLFW.RELEASE && Set_KeysDown(io, key, false)
    # modifiers are not reliable across systems
    io.KeyCtrl = Get_KeysDown(io, GLFW.KEY_LEFT_CONTROL) || Get_KeysDown(io, GLFW.KEY_RIGHT_CONTROL)
    io.KeyShift = Get_KeysDown(io, GLFW.KEY_LEFT_SHIFT) || Get_KeysDown(io, GLFW.KEY_RIGHT_SHIFT)
    io.KeyAlt = Get_KeysDown(io, GLFW.KEY_LEFT_ALT) || Get_KeysDown(io, GLFW.KEY_RIGHT_ALT)
    io.KeySuper = Get_KeysDown(io, GLFW.KEY_LEFT_SUPER) || Get_KeysDown(io, GLFW.KEY_RIGHT_SUPER)
end

function ImGui_ImplGlfw_CharCallback(window::GLFW.Window, c)
    g_CustomCallbackChar[] != C_NULL && g_CustomCallbackChar[](window, c)
    io = GetIO()
    0 < Cuint(c) < 0x10000 && AddInputCharacter(io, c)
end
