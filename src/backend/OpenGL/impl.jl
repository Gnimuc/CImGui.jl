function igImplOpenGL3_Init()
    io = igGetIO()
    title = "imgui_impl_opengl3"
    GC.@preserve io title begin
        io_blob = Blob{ImGuiIO}(Ptr{Cvoid}(io), 0, sizeof(ImGuiIO))
        io_blob.BackendRendererName[] = Base.unsafe_convert(Cstring, title)
    end
    return true
end

igImplOpenGL3_Shutdown() = igImplOpenGL3_DestroyDeviceObjects()

function igImplOpenGL3_NewFrame()
    global g_FontTexture
    if g_FontTexture == 0
        igImplOpenGL3_CreateDeviceObjects()
    end
end

function igImplOpenGL3_RenderDrawData(draw_data)
    io = igGetIO()
    # avoid rendering when minimized, scale coordinates for retina displays
    GC.@preserve io draw_data begin
        io_blob = Blob{ImGuiIO}(Ptr{Cvoid}(io), 0, sizeof(ImGuiIO))
        fb_scale = io_blob.DisplayFramebufferScale[]
        draw_data_blob = Blob{ImDrawData}(Ptr{Cvoid}(draw_data), 0, sizeof(ImDrawData))
        disp_size = draw_data_blob.DisplaySize[]
        disp_pos = draw_data_blob.DisplayPos[]
        cmd_lists_count = draw_data_blob.CmdListsCount[]
        cmd_lists = unsafe_wrap(Vector{Ptr{ImDrawList}}, draw_data_blob.CmdLists[], cmd_lists_count)
    end
    fb_width = trunc(Cint, disp_size.x * fb_scale.x)
    fb_height = trunc(disp_size.y * fb_scale.y)
    (fb_width ≤ 0 || fb_height ≤ 0) && return nothing
    ImDrawData_ScaleClipRects(draw_data, fb_scale)

    # backup GL state
    last_active_texture = Ref{GLint}()
    glGetIntegerv(GL_ACTIVE_TEXTURE, last_active_texture)
    glActiveTexture(GL_TEXTURE0)
    last_program = Ref{GLint}(); glGetIntegerv(GL_CURRENT_PROGRAM, last_program)
    last_texture = Ref{GLint}(); glGetIntegerv(GL_TEXTURE_BINDING_2D, last_texture)
    last_sampler = Ref{GLint}(); glGetIntegerv(GL_SAMPLER_BINDING, last_sampler)
    last_array_buffer = Ref{GLint}(); glGetIntegerv(GL_ARRAY_BUFFER_BINDING, last_array_buffer)
    last_vertex_array = Ref{GLint}(); glGetIntegerv(GL_VERTEX_ARRAY_BINDING, last_vertex_array)
    last_polygon_mode = GLint[0,0]; glGetIntegerv(GL_POLYGON_MODE, last_polygon_mode)
    last_viewport = GLint[0,0,0,0]; glGetIntegerv(GL_VIEWPORT, last_viewport)
    last_scissor_box = GLint[0,0,0,0]; glGetIntegerv(GL_SCISSOR_BOX, last_scissor_box)
    last_blend_src_rgb = Ref{GLint}(); glGetIntegerv(GL_BLEND_SRC_RGB, last_blend_src_rgb)
    last_blend_dst_rgb = Ref{GLint}(); glGetIntegerv(GL_BLEND_DST_RGB, last_blend_dst_rgb)
    last_blend_src_alpha = Ref{GLint}(); glGetIntegerv(GL_BLEND_SRC_ALPHA, last_blend_src_alpha)
    last_blend_dst_alpha = Ref{GLint}(); glGetIntegerv(GL_BLEND_DST_ALPHA, last_blend_dst_alpha)
    last_blend_equation_rgb = Ref{GLint}(); glGetIntegerv(GL_BLEND_EQUATION_RGB, last_blend_equation_rgb)
    last_blend_equation_alpha = Ref{GLint}(); glGetIntegerv(GL_BLEND_EQUATION_ALPHA, last_blend_equation_alpha)
    last_enable_blend = glIsEnabled(GL_BLEND)
    last_enable_cull_face = glIsEnabled(GL_CULL_FACE)
    last_enable_depth_test = glIsEnabled(GL_DEPTH_TEST)
    last_enable_scissor_test = glIsEnabled(GL_SCISSOR_TEST)
    clip_origin_lower_left = true
    # last_clip_origin = Ref{GLint}(0); glGetIntegerv(GL_CLIP_ORIGIN, last_clip_origin)
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
    L = disp_pos.x
    R = disp_pos.x + disp_size.x
    T = disp_pos.y
    B = disp_pos.y + disp_size.y
    ortho_projection = GLfloat[2.0/(R-L), 0.0, 0.0, 0.0,
                               0.0, 2.0/(T-B), 0.0, 0.0,
                               0.0, 0.0, -1.0, 0.0,
                               (R+L)/(L-R), (T+B)/(B-T), 0.0, 1.0]

    glUseProgram(g_ShaderHandle)
    glUniform1i(g_AttribLocationTex, 0)
    glUniformMatrix4fv(g_AttribLocationProjMtx, 1, GL_FALSE, ortho_projection)
    glBindSampler(0, 0)

    # recreate the VAO every time
    vao_handle = Ref{GLuint}(0)
    glGenVertexArrays(1, vao_handle)
    glBindVertexArray(vao_handle[])
    glBindBuffer(GL_ARRAY_BUFFER, g_VboHandle)
    glEnableVertexAttribArray(g_AttribLocationPosition)
    glEnableVertexAttribArray(g_AttribLocationUV)
    glEnableVertexAttribArray(g_AttribLocationColor)
    idv_size = sizeof(ImDrawVert)
    pos_offset = fieldoffset(ImDrawVert, 1)
    uv_offset = fieldoffset(ImDrawVert, 2)
    col_offset = fieldoffset(ImDrawVert, 3)
    glVertexAttribPointer(g_AttribLocationPosition, 2, GL_FLOAT, GL_FALSE, idv_size, Ptr{GLvoid}(pos_offset))
    glVertexAttribPointer(g_AttribLocationUV, 2, GL_FLOAT, GL_FALSE, idv_size, Ptr{GLvoid}(uv_offset))
    glVertexAttribPointer(g_AttribLocationColor, 4, GL_UNSIGNED_BYTE, GL_TRUE, idv_size, Ptr{GLvoid}(col_offset))

    # draw
    for n = 1:cmd_lists_count
        idx_buffer_offset = Ref{ImDrawIdx}(0)
        cmd_list = cmd_lists[n]
        GC.@preserve cmd_list begin
            cmd_blob = Blob{ImDrawList}(Ptr{Cvoid}(cmd_list), 0, sizeof(ImDrawList))
            vtxbuffer = cmd_blob.VtxBuffer[]
            idxbuffer = cmd_blob.IdxBuffer[]
            cmdbuffer = cmd_blob.CmdBuffer[]
        end
        glBindBuffer(GL_ARRAY_BUFFER, g_VboHandle)
        glBufferData(GL_ARRAY_BUFFER, GLsizeiptr(vtxbuffer.Size) * sizeof(ImDrawVert), Ptr{GLvoid}(vtxbuffer.Data), GL_STREAM_DRAW)

        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, g_ElementsHandle)
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, GLsizeiptr(idxbuffer.Size) * sizeof(ImDrawIdx), Ptr{GLvoid}(idxbuffer.Data), GL_STREAM_DRAW)

        for cmd_i = 1:cmdbuffer.Size
            pcmd = cmdbuffer.Data
            GC.@preserve pcmd begin
                pcmd_blob = Blob{ImDrawCmd}(Ptr{Cvoid}(pcmd), 0, sizeof(ImDrawCmd))
                rect = pcmd_blob.ClipRect[]
                texid = pcmd_blob.TextureId[]
                elecount = pcmd_blob.ElemCount[]
            end
            # if (pcmd->UserCallback)
            #     # user callback (registered via ImDrawList_AddCallback)
            #     pcmd->UserCallback(cmd_list, pcmd);
            # else
                clip_rect = ImVec4(rect.x - disp_pos.x, rect.y - disp_pos.y, rect.z - disp_pos.x, rect.w - disp_pos.y)
                if clip_rect.x < fb_width && clip_rect.y < fb_height && clip_rect.z ≥ 0 && clip_rect.w ≥ 0
                    # Apply scissor/clipping rectangle
                    # if (clip_origin_lower_left)
                        ix = trunc(Cint, clip_rect.x)
                        iy = trunc(Cint, fb_height - clip_rect.w)
                        iz = trunc(Cint, clip_rect.z - clip_rect.x)
                        iw = trunc(Cint, clip_rect.w - clip_rect.y)
                        glScissor(ix, iy, iw, iw)
                    # else
                    #     glScissor((int)clip_rect.x, (int)clip_rect.y, (int)clip_rect.z, (int)clip_rect.w);
                    # end
                    # bind texture, draw
                    glBindTexture(GL_TEXTURE_2D, GLuint(texid))
                    format = sizeof(ImDrawIdx) == 2 ? GL_UNSIGNED_SHORT : GL_UNSIGNED_INT
                    glDrawElements(GL_TRIANGLES, elecount, format, idx_buffer_offset)
                end
            # end
            idx_buffer_offset += elem_count * Core.sizeof(ImDrawIdx)
        end
    end
    glDeleteVertexArrays(1, vao_handle)

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
    GC.@preserve io begin
        io_blob = Blob{ImGuiIO}(Ptr{Cvoid}(io), 0, sizeof(ImGuiIO))
        fonts = io_blob.Fonts[]

        pixels = Ref{Ptr{Cuchar}}(C_NULL)
        width = Ref{Cint}(0)
        height = Ref{Cint}(0)
        ImFontAtlas_GetTexDataAsRGBA32(fonts, pixels, width, height, C_NULL)

        # upload texture to graphics system
        last_texture = Ref{GLint}(0)
        glGetIntegerv(GL_TEXTURE_BINDING_2D, last_texture)
        font_tex_ref = Ref{GLuint}(g_FontTexture)
        glGenTextures(1, font_tex_ref)
        g_FontTexture = font_tex_ref[]
        glBindTexture(GL_TEXTURE_2D, g_FontTexture)
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR)
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
        glPixelStorei(GL_UNPACK_ROW_LENGTH, 0)
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width[], height[], 0, GL_RGBA, GL_UNSIGNED_BYTE, pixels[])

        # store our identifier
        ImFontAtlas_SetTexID(fonts, ImTextureID(Int(g_FontTexture)))
        # restore state
        glBindTexture(GL_TEXTURE_2D, last_texture[])

        # f = io_blob.FontDefault[]
        # f_blob = Blob{ImFont}(Ptr{Cvoid}(f), 0, sizeof(ImFont))
        # @show f_blob.ContainerAtlas[]
    end

    return true
end

function igImplOpenGL3_DestroyFontsTexture()
    if g_FontTexture != 0
        font_tex_ref = Ref{GLuint}(g_FontTexture)
        glDeleteTextures(1, font_tex_ref)
        g_FontTexture = font_tex_ref[]

        io = igGetIO()
        GC.@preserve io draw_data begin
            io_blob = Blob{ImGuiIO}(Ptr{Cvoid}(io), 0, sizeof(ImGuiIO))
            fonts = io_blob.Fonts[]
            ImFontAtlas_SetTexID(fonts, ImTextureID(0))
        end
        g_FontTexture = 0
    end
end

function igImplOpenGL3_CreateDeviceObjects()
    # backup GL state
    last_texture = Ref{GLint}(0); glGetIntegerv(GL_TEXTURE_BINDING_2D, last_texture)
    last_array_buffer = Ref{GLint}(0); glGetIntegerv(GL_ARRAY_BUFFER_BINDING, last_array_buffer)
    last_vertex_array = Ref{GLint}(0); glGetIntegerv(GL_VERTEX_ARRAY_BINDING, last_vertex_array)

    vertex_shader = read(joinpath(@__DIR__, "vertex.glsl"), String)
    global g_VertHandle = glCreateShader(GL_VERTEX_SHADER)
    glShaderSource(g_VertHandle, 1, Ptr{GLchar}[pointer(vertex_shader)], C_NULL)
    glCompileShader(g_VertHandle)
    status_ref = Ref{GLint}(-1)
    glGetShaderiv(g_VertHandle, GL_COMPILE_STATUS, status_ref)
    if status_ref[] != GL_TRUE
        max_length_ref = Ref{GLsizei}(0)
        glGetShaderiv(g_VertHandle, GL_INFO_LOG_LENGTH, max_length_ref)
        actual_length_ref = Ref{GLsizei}(0)
        log = Vector{GLchar}(undef, max_length_ref[])
        glGetShaderInfoLog(g_VertHandle, max_length_ref[], actual_length_ref, log)
        @error "[GL]: failed to compile vertex shader: $(g_VertHandle): $(String(log))"
    end

    fragment_shader = read(joinpath(@__DIR__, "fragment.glsl"), String)
    g_FragHandle = glCreateShader(GL_FRAGMENT_SHADER)
    glShaderSource(g_FragHandle, 1, Ptr{GLchar}[pointer(fragment_shader)], C_NULL)
    glCompileShader(g_FragHandle)
    status_ref = Ref{GLint}(-1)
    glGetShaderiv(g_FragHandle, GL_COMPILE_STATUS, status_ref)
    if status_ref[] != GL_TRUE
        max_length_ref = Ref{GLsizei}(0)
        glGetShaderiv(g_FragHandle, GL_INFO_LOG_LENGTH, max_length_ref)
        actual_length_ref = Ref{GLsizei}(0)
        log = Vector{GLchar}(undef, max_length_ref[])
        glGetShaderInfoLog(g_FragHandle, max_length_ref[], actual_length_ref, log)
        @error "[GL]: failed to compile fragment shader: $(g_FragHandle): $(String(log))"
    end

    g_ShaderHandle = glCreateProgram()
    glAttachShader(g_ShaderHandle, g_VertHandle)
    glAttachShader(g_ShaderHandle, g_FragHandle)
    glLinkProgram(g_ShaderHandle)
    status_ref = Ref{GLint}(-1)
    glGetProgramiv(g_ShaderHandle, GL_LINK_STATUS, status_ref)
    @assert status_ref[] == GL_TRUE

    g_AttribLocationTex = glGetUniformLocation(g_ShaderHandle, "Texture")
    g_AttribLocationProjMtx = glGetUniformLocation(g_ShaderHandle, "ProjMtx")
    g_AttribLocationPosition = glGetAttribLocation(g_ShaderHandle, "Position")
    g_AttribLocationUV = glGetAttribLocation(g_ShaderHandle, "UV")
    g_AttribLocationColor = glGetAttribLocation(g_ShaderHandle, "Color")

    # create buffers
    vbo_ref = Ref{GLuint}()
    glGenBuffers(1, vbo_ref)
    g_VboHandle = vbo_ref[]

    ebo_ref = Ref{GLuint}()
    glGenBuffers(1, ebo_ref)
    g_ElementsHandle = ebo_ref[]

    igImplOpenGL3_CreateFontsTexture()

    # restore modified GL state
    glBindTexture(GL_TEXTURE_2D, last_texture[])
    glBindBuffer(GL_ARRAY_BUFFER, last_array_buffer[])
    glBindVertexArray(last_vertex_array[])

    return true;
end

function igImplOpenGL3_DestroyDeviceObjects()
    global g_VboHandle
    global g_ElementsHandle
    global g_ShaderHandle
    global g_VertHandle
    global g_FragHandle
    if g_VboHandle != 0
        vbo_ref = Ref(g_VboHandle)
        glDeleteBuffers(1, vbo_ref)
        g_VboHandle = 0
    end

    if g_ElementsHandle != 0
        ebo_ref = Ref(g_ElementsHandle)
        glDeleteBuffers(1, ebo_ref)
        g_ElementsHandle = 0
    end

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
