function igImplOpenGL3_Init()
    io = igGetIO()
    ImGuiIO_Set_BackendRendererName(io, "imgui_impl_opengl3")
    return true
end

igImplOpenGL3_Shutdown() = igImplOpenGL3_DestroyDeviceObjects()

function igImplOpenGL3_NewFrame()
    global g_FontTexture
    g_FontTexture == 0 && igImplOpenGL3_CreateDeviceObjects()
end

function igImplOpenGL3_RenderDrawData(draw_data)
    # avoid rendering when minimized, scale coordinates for retina displays
    io = igGetIO()
    disp_size = ImDrawData_Get_DisplaySize(draw_data)
    fb_scale = ImGuiIO_Get_DisplayFramebufferScale(io)
    fb_width = trunc(Cint, disp_size.x * fb_scale.x)
    fb_height = trunc(Cint, disp_size.y * fb_scale.y)
    (fb_width ≤ 0 || fb_height ≤ 0) && return nothing
    ImDrawData_ScaleClipRects(draw_data, fb_scale)

    # backup GL state
    last_active_texture = GLint(0); @c glGetIntegerv(GL_ACTIVE_TEXTURE, &last_active_texture)
    glActiveTexture(GL_TEXTURE0)
    last_program = GLint(0); @c glGetIntegerv(GL_CURRENT_PROGRAM, &last_program)
    last_texture = GLint(0); @c glGetIntegerv(GL_TEXTURE_BINDING_2D, &last_texture)
    last_sampler = GLint(0); @c glGetIntegerv(GL_SAMPLER_BINDING, &last_sampler)
    last_array_buffer = GLint(0); @c glGetIntegerv(GL_ARRAY_BUFFER_BINDING, &last_array_buffer)
    last_vertex_array = GLint(0); @c glGetIntegerv(GL_VERTEX_ARRAY_BINDING, &last_vertex_array)
    last_polygon_mode = GLint[0,0]; glGetIntegerv(GL_POLYGON_MODE, last_polygon_mode)
    last_viewport = GLint[0,0,0,0]; glGetIntegerv(GL_VIEWPORT, last_viewport)
    last_scissor_box = GLint[0,0,0,0]; glGetIntegerv(GL_SCISSOR_BOX, last_scissor_box)
    last_blend_src_rgb = GLint(0); @c glGetIntegerv(GL_BLEND_SRC_RGB, &last_blend_src_rgb)
    last_blend_dst_rgb = GLint(0); @c glGetIntegerv(GL_BLEND_DST_RGB, &last_blend_dst_rgb)
    last_blend_src_alpha = GLint(0); @c glGetIntegerv(GL_BLEND_SRC_ALPHA, &last_blend_src_alpha)
    last_blend_dst_alpha = GLint(0); @c glGetIntegerv(GL_BLEND_DST_ALPHA, &last_blend_dst_alpha)
    last_blend_equation_rgb = GLint(0); @c glGetIntegerv(GL_BLEND_EQUATION_RGB, &last_blend_equation_rgb)
    last_blend_equation_alpha = GLint(0); @c glGetIntegerv(GL_BLEND_EQUATION_ALPHA, &last_blend_equation_alpha)
    last_enable_blend = glIsEnabled(GL_BLEND)
    last_enable_cull_face = glIsEnabled(GL_CULL_FACE)
    last_enable_depth_test = glIsEnabled(GL_DEPTH_TEST)
    last_enable_scissor_test = glIsEnabled(GL_SCISSOR_TEST)
    clip_origin_lower_left = true
    # last_clip_origin = GLint(0); glGetIntegerv(GL_CLIP_ORIGIN, &last_clip_origin)
    # last_clip_origin == GL_UPPER_LEFT && (clip_origin_lower_left = false;)

    # setup render state:
    # - alpha-blending enabled
    # - no face culling
    # - no depth testing
    # - scissor enabled
    # - polygon fill
    glEnable(GL_BLEND)
    glBlendEquation(GL_FUNC_ADD)
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
    glDisable(GL_CULL_FACE)
    glDisable(GL_DEPTH_TEST)
    glEnable(GL_SCISSOR_TEST)
    glPolygonMode(GL_FRONT_AND_BACK, GL_FILL)

    # setup viewport, orthographic projection matrix
    glViewport(0, 0, GLsizei(fb_width), GLsizei(fb_height))
    disp_pos = ImDrawData_Get_DisplayPos(draw_data)
    L = disp_pos.x
    R = disp_pos.x + disp_size.x
    T = disp_pos.y
    B = disp_pos.y + disp_size.y
    ortho_projection = GLfloat[2.0/(R-L), 0.0, 0.0, 0.0,
                               0.0, 2.0/(T-B), 0.0, 0.0,
                               0.0, 0.0, -1.0, 0.0,
                               (R+L)/(L-R), (T+B)/(B-T), 0.0, 1.0]

    global g_ShaderHandle; global g_AttribLocationTex; global g_AttribLocationProjMtx;
    glUseProgram(g_ShaderHandle);
    glUniform1i(g_AttribLocationTex, 0);
    glUniformMatrix4fv(g_AttribLocationProjMtx, 1, GL_FALSE, ortho_projection)
    glBindSampler(0, 0)

    # recreate the VAO every time
    global g_VboHandle
    vao_handle = GLuint(0)
    @c glGenVertexArrays(1, &vao_handle)
    glBindVertexArray(vao_handle)
    glBindBuffer(GL_ARRAY_BUFFER, g_VboHandle)
    glEnableVertexAttribArray(g_AttribLocationPosition)
    glEnableVertexAttribArray(g_AttribLocationUV)
    glEnableVertexAttribArray(g_AttribLocationColor)
    idv_size = sizeof(ImDrawVert)
    pos_offset = fieldoffset(ImDrawVert, 1)
    uv_offset = fieldoffset(ImDrawVert, 2)
    col_offset = fieldoffset(ImDrawVert, 3)
    glVertexAttribPointer(g_AttribLocationPosition, 2, GL_FLOAT, GL_FALSE, idv_size, Ptr{GLCvoid}(pos_offset))
    glVertexAttribPointer(g_AttribLocationUV, 2, GL_FLOAT, GL_FALSE, idv_size, Ptr{GLCvoid}(uv_offset))
    glVertexAttribPointer(g_AttribLocationColor, 4, GL_UNSIGNED_BYTE, GL_TRUE, idv_size, Ptr{GLCvoid}(col_offset))

    # draw
    pos = ImDrawData_Get_DisplayPos(draw_data)
    cmd_lists_count = ImDrawData_Get_CmdListsCount(draw_data)
    for n = 0:cmd_lists_count-1
        idx_buffer_offset = Ptr{ImDrawIdx}(0)
        cmd_list = ImDrawData_Get_CmdLists(draw_data, n)
        vtx_buffer = ImDrawList_Get_VtxBuffer(cmd_list)
        idx_buffer = ImDrawList_Get_IdxBuffer(cmd_list)
        glBindBuffer(GL_ARRAY_BUFFER, g_VboHandle)
        glBufferData(GL_ARRAY_BUFFER, vtx_buffer.Size * sizeof(ImDrawVert), Ptr{GLCvoid}(vtx_buffer.Data), GL_STREAM_DRAW)

        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, g_ElementsHandle)
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, idx_buffer.Size * sizeof(ImDrawIdx), Ptr{GLCvoid}(idx_buffer.Data), GL_STREAM_DRAW)

        cmd_buffer = ImDrawList_Get_CmdBuffer(cmd_list)
        for cmd_i = 0:cmd_buffer.Size-1
            pcmd = cmd_buffer.Data + cmd_i * Core.sizeof(ImDrawCmd)
            elem_count = ImDrawCmd_Get_ElemCount(pcmd)
            if ImDrawCmd_Get_UserCallback(pcmd) != C_NULL
                @error "not implenmented yet"
                # user callback (registered via ImDrawList_AddCallback)
                # pcmd->UserCallback(cmd_list, pcmd);
            else
                # project scissor/clipping rectangles into framebuffer space
                rect = ImDrawCmd_Get_ClipRect(pcmd)
                clip_rect_x = (rect.x - pos.x);
                clip_rect_y = (rect.y - pos.y);
                clip_rect_z = (rect.z - pos.x);
                clip_rect_w = (rect.w - pos.y);
                if clip_rect_x < fb_width && clip_rect_y < fb_height && clip_rect_z ≥ 0 && clip_rect_w ≥ 0
                    # Apply scissor/clipping rectangle
                    if (clip_origin_lower_left)
                        ix = trunc(Cint, clip_rect_x)
                        iy = trunc(Cint, fb_height - clip_rect_w)
                        iz = trunc(Cint, clip_rect_z - clip_rect_x)
                        iw = trunc(Cint, clip_rect_w - clip_rect_y)
                    else
                        ix = trunc(Cint, clip_rect_x)
                        iy = trunc(Cint, clip_rect_y)
                        iz = trunc(Cint, clip_rect_z)
                        iw = trunc(Cint, clip_rect_w)
                    end
                    glScissor(ix, iy, iz, iw)
                    # bind texture, draw
                    glBindTexture(GL_TEXTURE_2D, UInt((ImDrawCmd_Get_TextureId(pcmd))))
                    format = sizeof(ImDrawIdx) == 2 ? GL_UNSIGNED_SHORT : GL_UNSIGNED_INT
                    glDrawElements(GL_TRIANGLES, GLsizei(elem_count), format, idx_buffer_offset)
                end
            end
            idx_buffer_offset += elem_count * Core.sizeof(ImDrawIdx)
        end
    end
    @c glDeleteVertexArrays(1, &vao_handle)

    # restore modified GL state
    glUseProgram(last_program)
    glBindTexture(GL_TEXTURE_2D, last_texture)
    glBindSampler(0, last_sampler)
    glActiveTexture(last_active_texture)
    glBindVertexArray(last_vertex_array)
    glBindBuffer(GL_ARRAY_BUFFER, last_array_buffer)
    glBlendEquationSeparate(last_blend_equation_rgb, last_blend_equation_alpha)
    glBlendFuncSeparate(last_blend_src_rgb, last_blend_dst_rgb, last_blend_src_alpha, last_blend_dst_alpha)
    last_enable_blend ? glEnable(GL_BLEND) : glDisable(GL_BLEND)
    last_enable_cull_face ? glEnable(GL_CULL_FACE) : glDisable(GL_CULL_FACE)
    last_enable_depth_test ? glEnable(GL_DEPTH_TEST) : glDisable(GL_DEPTH_TEST)
    last_enable_scissor_test ? glEnable(GL_SCISSOR_TEST) : glDisable(GL_SCISSOR_TEST)
    glPolygonMode(GL_FRONT_AND_BACK, GLenum(last_polygon_mode[1]))
    glViewport(last_viewport[1], last_viewport[2], GLsizei(last_viewport[3]), GLsizei(last_viewport[4]))
    glScissor(last_scissor_box[1], last_scissor_box[2], GLsizei(last_scissor_box[3]), GLsizei(last_scissor_box[4]))
end

function igImplOpenGL3_CreateFontsTexture()
    global g_FontTexture

    # build texture atlas
    io = igGetIO()
    fonts = ImGuiIO_Get_Fonts(io)
    pixels = Ptr{Cuchar}(C_NULL)
    width, height = Cint(0), Cint(0)
    @c ImFontAtlas_GetTexDataAsRGBA32(fonts, &pixels, &width, &height, C_NULL)

    # upload texture to graphics system
    last_texture = GLint(0)
    @c glGetIntegerv(GL_TEXTURE_BINDING_2D, &last_texture)
    @c glGenTextures(1, &g_FontTexture)
    glBindTexture(GL_TEXTURE_2D, g_FontTexture)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
    glPixelStorei(GL_UNPACK_ROW_LENGTH, 0)
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, pixels);

    # store our identifier
    ImFontAtlas_SetTexID(fonts, ImTextureID(Int(g_FontTexture)))
    # restore state
    glBindTexture(GL_TEXTURE_2D, last_texture)

    return true
end

function igImplOpenGL3_DestroyFontsTexture()
    global g_FontTexture
    if g_FontTexture != 0
        io = igGetIO()
        @c glDeleteTextures(1, &g_FontTexture)
        fonts = ImGuiIO_Get_Fonts(io)
        ImFontAtlas_SetTexID(fonts, ImTextureID(0))
        g_FontTexture = GLuint(0)
    end
end

function igImplOpenGL3_CreateDeviceObjects()
    # backup GL state
    last_texture, last_array_buffer, last_vertex_array = GLint(0), GLint(0), GLint(0)
    @c glGetIntegerv(GL_TEXTURE_BINDING_2D, &last_texture)
    @c glGetIntegerv(GL_ARRAY_BUFFER_BINDING, &last_array_buffer)
    @c glGetIntegerv(GL_VERTEX_ARRAY_BINDING, &last_vertex_array)

    vertex_shader = read(joinpath(@__DIR__, "vertex.glsl"), String)
    global g_VertHandle = glCreateShader(GL_VERTEX_SHADER)
    glShaderSource(g_VertHandle, 1, Ptr{GLchar}[pointer(vertex_shader)], C_NULL)
    glCompileShader(g_VertHandle)
    status = GLint(-1)
    @c glGetShaderiv(g_VertHandle, GL_COMPILE_STATUS, &status)
    if status != GL_TRUE
        max_length = GLsizei(0)
        @c glGetShaderiv(g_VertHandle, GL_INFO_LOG_LENGTH, &max_length)
        actual_length = GLsizei(0)
        log = Vector{GLchar}(undef, max_length)
        @c glGetShaderInfoLog(g_VertHandle, max_length, &actual_length, log)
        @error "[GL]: failed to compile vertex shader: $(g_VertHandle): $(String(log))"
    end

    fragment_shader = read(joinpath(@__DIR__, "fragment.glsl"), String)
    global g_FragHandle = glCreateShader(GL_FRAGMENT_SHADER)
    glShaderSource(g_FragHandle, 1, Ptr{GLchar}[pointer(fragment_shader)], C_NULL)
    glCompileShader(g_FragHandle)
    status = GLint(-1)
    @c glGetShaderiv(g_FragHandle, GL_COMPILE_STATUS, &status)
    if status != GL_TRUE
        max_length = GLsizei(0)
        @c glGetShaderiv(g_FragHandle, GL_INFO_LOG_LENGTH, &max_length)
        actual_length = GLsizei(0)
        log = Vector{GLchar}(undef, max_length)
        @c glGetShaderInfoLog(g_FragHandle, max_length, &actual_length, log)
        @error "[GL]: failed to compile fragment shader: $(g_FragHandle): $(String(log))"
    end

    global g_ShaderHandle = glCreateProgram()
    glAttachShader(g_ShaderHandle, g_VertHandle)
    glAttachShader(g_ShaderHandle, g_FragHandle)
    glLinkProgram(g_ShaderHandle)
    status = GLint(-1)
    @c glGetProgramiv(g_ShaderHandle, GL_LINK_STATUS, &status)
    @assert status == GL_TRUE

    global g_AttribLocationTex = glGetUniformLocation(g_ShaderHandle, "Texture")
    global g_AttribLocationProjMtx = glGetUniformLocation(g_ShaderHandle, "ProjMtx")
    global g_AttribLocationPosition = glGetAttribLocation(g_ShaderHandle, "Position")
    global g_AttribLocationUV = glGetAttribLocation(g_ShaderHandle, "UV")
    global g_AttribLocationColor = glGetAttribLocation(g_ShaderHandle, "Color")

    # create buffers
    global g_VboHandle; global g_ElementsHandle;
    @c glGenBuffers(1, &g_VboHandle)
    @c glGenBuffers(1, &g_ElementsHandle)

    igImplOpenGL3_CreateFontsTexture()

    # restore modified GL state
    glBindTexture(GL_TEXTURE_2D, last_texture)
    glBindBuffer(GL_ARRAY_BUFFER, last_array_buffer)
    glBindVertexArray(last_vertex_array)

    return true;
end

function igImplOpenGL3_DestroyDeviceObjects()
    global g_VboHandle
    global g_ElementsHandle
    global g_ShaderHandle
    global g_VertHandle
    global g_FragHandle
    g_VboHandle != 0 && @c glDeleteBuffers(1, &g_VboHandle)
    g_ElementsHandle != 0 && @c glDeleteBuffers(1, &g_ElementsHandle)
    g_VboHandle = g_ElementsHandle = GLuint(0)

    g_ShaderHandle != 0 && g_VertHandle != 0 && glDetachShader(g_ShaderHandle, g_VertHandle)

    g_VertHandle != 0 && glDeleteShader(g_VertHandle)
    g_VertHandle = 0

    g_ShaderHandle != 0 && g_FragHandle != 0 && glDetachShader(g_ShaderHandle, g_FragHandle)
    g_FragHandle != 0 && glDeleteShader(g_FragHandle)
    g_FragHandle = 0

    g_ShaderHandle != 0 && glDeleteProgram(g_ShaderHandle)
    g_ShaderHandle = 0

    igImplOpenGL3_DestroyFontsTexture()
end
