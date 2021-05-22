#----------------------------------------
# OpenGL    GLSL      GLSL
# version   version   string
#----------------------------------------
#  2.0       110       "#version 110"
#  2.1       120
#  3.0       130
#  3.1       140
#  3.2       150       "#version 150"
#  3.3       330
#  4.0       400
#  4.1       410       "#version 410 core"
#  4.2       420
#  4.3       430
#  ES 2.0    100       "#version 100"
#  ES 3.0    300       "#version 300 es"
#----------------------------------------

const IMGUI_BACKEND_RENDERER_NAME = "imgui_impl_opengl3"

function ImGui_ImplOpenGL3_RenderWindow(viewport::Ptr{ImGuiViewport}, userdata::Ptr{Cvoid})::Cvoid
    vp = unsafe_load(viewport)
    if !(vp.Flags & ImGuiViewportFlags_NoRendererClear) != 0
        glClearColor(0.0f0, 0.0f0, 0.0f0, 1.0f0)
        glClear(GL_COLOR_BUFFER_BIT)
    end
    ImGui_ImplOpenGL3_RenderDrawData(Ptr{ImDrawData}(vp.DrawData))
end

function ImGui_ImplOpenGL3_InitPlatformInterface()
    platform_io::Ptr{ImGuiPlatformIO} = igGetPlatformIO()
    fptr = @cfunction(ImGui_ImplOpenGL3_RenderWindow, Cvoid, (Ptr{ImGuiViewport}, Ptr{Cvoid}))
    platform_io.Renderer_RenderWindow = fptr
end

ImGui_ImplOpenGL3_ShutdownPlatformInterface() = igDestroyPlatformWindows()

function ImGui_ImplOpenGL3_Init(glsl_version::Integer=150)
    io::Ptr{ImGuiIO} = GetIO()
    io.BackendRendererName = pointer(IMGUI_BACKEND_RENDERER_NAME)
    io.BackendFlags = unsafe_load(io.BackendFlags) | ImGuiBackendFlags_RendererHasVtxOffset  # version ≥ 320
    io.BackendFlags = unsafe_load(io.BackendFlags) | ImGuiBackendFlags_RendererHasViewports

    g_GlslVersion[] = glsl_version

    if unsafe_load(io.ConfigFlags) & ImGuiConfigFlags_ViewportsEnable != 0
        ImGui_ImplOpenGL3_InitPlatformInterface()
    end

    return true
end

function ImGui_ImplOpenGL3_Shutdown()
    ImGui_ImplOpenGL3_ShutdownPlatformInterface()
    ImGui_ImplOpenGL3_DestroyDeviceObjects()
end

ImGui_ImplOpenGL3_NewFrame() = !ImFontAtlas_IsBuilt(GetIO().Fonts) && ImGui_ImplOpenGL3_CreateDeviceObjects()

function ImGui_ImplOpenGL3_SetupRenderState(draw_data, fb_width::Cint, fb_height::Cint, vertex_array_object::GLuint)
    # setup render state:
    # - alpha-blending enabled
    # - no face culling
    # - no depth testing
    # - scissor enabled
    # - polygon fill
    glEnable(GL_BLEND)
    glBlendEquation(GL_FUNC_ADD)
    glBlendFuncSeparate(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA, GL_ONE, GL_ONE_MINUS_SRC_ALPHA)
    glDisable(GL_CULL_FACE)
    glDisable(GL_DEPTH_TEST)
    glDisable(GL_STENCIL_TEST)
    glEnable(GL_SCISSOR_TEST)

    g_GlslVersion[] > 310 && glDisable(GL_PRIMITIVE_RESTART)

    glPolygonMode(GL_FRONT_AND_BACK, GL_FILL)

    # setup viewport, orthographic projection matrix
    glViewport(0, 0, GLsizei(fb_width), GLsizei(fb_height))
    disp_pos = unsafe_load(draw_data.DisplayPos)
    disp_size = unsafe_load(draw_data.DisplaySize)
    L = disp_pos.x
    R = disp_pos.x + disp_size.x
    T = disp_pos.y
    B = disp_pos.y + disp_size.y
    ortho_projection = GLfloat[2.0/(R-L), 0.0, 0.0, 0.0,
                               0.0, 2.0/(T-B), 0.0, 0.0,
                               0.0, 0.0, -1.0, 0.0,
                               (R+L)/(L-R), (T+B)/(B-T), 0.0, 1.0]

    glUseProgram(g_ShaderHandle[])
    glUniform1i(g_AttribLocationTex[], 0)
    glUniformMatrix4fv(g_AttribLocationProjMtx[], 1, GL_FALSE, ortho_projection)
    g_GlslVersion[] > 330 && glBindSampler(0, 0)

    glBindVertexArray(vertex_array_object)
    glBindBuffer(GL_ARRAY_BUFFER, g_VboHandle[])
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, g_ElementsHandle[])
    glEnableVertexAttribArray(g_AttribLocationVtxPos[])
    glEnableVertexAttribArray(g_AttribLocationVtxUV[])
    glEnableVertexAttribArray(g_AttribLocationVtxColor[])
    pos_offset = fieldoffset(ImDrawVert, 1)
    uv_offset = fieldoffset(ImDrawVert, 2)
    col_offset = fieldoffset(ImDrawVert, 3)
    glVertexAttribPointer(g_AttribLocationVtxPos[],   2, GL_FLOAT,         GL_FALSE, sizeof(ImDrawVert), Ptr{GLCvoid}(pos_offset))
    glVertexAttribPointer(g_AttribLocationVtxUV[],    2, GL_FLOAT,         GL_FALSE, sizeof(ImDrawVert), Ptr{GLCvoid}(uv_offset))
    glVertexAttribPointer(g_AttribLocationVtxColor[], 4, GL_UNSIGNED_BYTE, GL_TRUE,  sizeof(ImDrawVert), Ptr{GLCvoid}(col_offset))
end

function ImGui_ImplOpenGL3_RenderDrawData(draw_data)
    # avoid rendering when minimized, scale coordinates for retina displays
    fb_width = trunc(Cint, unsafe_load(draw_data.DisplaySize).x * unsafe_load(draw_data.FramebufferScale).x)
    fb_height = trunc(Cint, unsafe_load(draw_data.DisplaySize).y * unsafe_load(draw_data.FramebufferScale).y)
    (fb_width ≤ 0 || fb_height ≤ 0) && return nothing

    # backup GL state
    last_active_texture = GLint(0); @c glGetIntegerv(GL_ACTIVE_TEXTURE, &last_active_texture)
    glActiveTexture(GL_TEXTURE0)
    last_program = GLint(0); @c glGetIntegerv(GL_CURRENT_PROGRAM, &last_program)
    last_texture = GLint(0); @c glGetIntegerv(GL_TEXTURE_BINDING_2D, &last_texture)
    last_sampler = GLint(0); @c glGetIntegerv(GL_SAMPLER_BINDING, &last_sampler)
    last_array_buffer = GLint(0); @c glGetIntegerv(GL_ARRAY_BUFFER_BINDING, &last_array_buffer)
    last_vertex_array_object = GLint(0); @c glGetIntegerv(GL_VERTEX_ARRAY_BINDING, &last_vertex_array_object)
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
    # if g_GlslVersion[] > 450
    #     last_clip_origin = GLint(0)
    #     @c glGetIntegerv(GL_CLIP_ORIGIN, &last_clip_origin)
    #     last_clip_origin == GL_UPPER_LEFT && (clip_origin_lower_left = false;)
    # end
    vertex_array_object = GLuint(0)
    @c glGenVertexArrays(1, &vertex_array_object)
    ImGui_ImplOpenGL3_SetupRenderState(draw_data, fb_width, fb_height, vertex_array_object)

    # will project scissor/clipping rectangles into framebuffer space
    clip_off = unsafe_load(draw_data.DisplayPos)         # (0,0) unless using multi-viewports
    clip_scale = unsafe_load(draw_data.FramebufferScale) # (1,1) unless using retina display which are often (2,2)

    # render command lists
    data = unsafe_load(draw_data)
    cmd_lists = unsafe_wrap(Vector{Ptr{ImDrawList}}, data.CmdLists, data.CmdListsCount)
    for cmd_list in cmd_lists
        vtx_buffer = cmd_list.VtxBuffer |> unsafe_load
        idx_buffer = cmd_list.IdxBuffer |> unsafe_load
        # glBindBuffer(GL_ARRAY_BUFFER, g_VboHandle[])
        glBufferData(GL_ARRAY_BUFFER, vtx_buffer.Size * sizeof(ImDrawVert), Ptr{GLCvoid}(vtx_buffer.Data), GL_STREAM_DRAW)

        # glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, g_ElementsHandle[])
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, idx_buffer.Size * sizeof(ImDrawIdx), Ptr{GLCvoid}(idx_buffer.Data), GL_STREAM_DRAW)

        cmd_buffer = cmd_list.CmdBuffer |> unsafe_load
        for cmd_i = 0:cmd_buffer.Size-1
            pcmd = cmd_buffer.Data + cmd_i * sizeof(ImDrawCmd)
            elem_count = unsafe_load(pcmd.ElemCount)
            if unsafe_load(pcmd.UserCallback) != C_NULL
                # user callback (registered via ImDrawList_AddCallback)
                ccall(unsafe_load(pcmd.UserCallback), Cvoid, (Ptr{ImDrawList}, Ptr{ImDrawCmd}), cmd_list, pcmd)
            else
                # project scissor/clipping rectangles into framebuffer space
                rect = unsafe_load(pcmd.ClipRect)
                clip_rect_x = (rect.x - clip_off.x) * clip_scale.x
                clip_rect_y = (rect.y - clip_off.y) * clip_scale.y
                clip_rect_z = (rect.z - clip_off.x) * clip_scale.x
                clip_rect_w = (rect.w - clip_off.y) * clip_scale.y
                if clip_rect_x < fb_width && clip_rect_y < fb_height && clip_rect_z ≥ 0 && clip_rect_w ≥ 0
                    # apply scissor/clipping rectangle
                    if clip_origin_lower_left
                        ix = trunc(Cint, clip_rect_x)
                        iy = trunc(Cint, fb_height - clip_rect_w)
                        iz = trunc(Cint, clip_rect_z - clip_rect_x)
                        iw = trunc(Cint, clip_rect_w - clip_rect_y)
                    else
                        # support for GL 4.5's glClipControl(GL_UPPER_LEFT)
                        ix = trunc(Cint, clip_rect_x)
                        iy = trunc(Cint, clip_rect_y)
                        iz = trunc(Cint, clip_rect_z)
                        iw = trunc(Cint, clip_rect_w)
                    end
                    glScissor(ix, iy, iz, iw)
                    # bind texture, draw
                    glBindTexture(GL_TEXTURE_2D, UInt(unsafe_load(pcmd.TextureId)))
                    format = sizeof(ImDrawIdx) == 2 ? GL_UNSIGNED_SHORT : GL_UNSIGNED_INT
                    glDrawElementsBaseVertex(GL_TRIANGLES, GLsizei(elem_count), format, Ptr{Cvoid}(unsafe_load(pcmd.IdxOffset) * sizeof(ImDrawIdx)), GLint(unsafe_load(pcmd.VtxOffset)))
                end
            end
        end
    end
    @c glDeleteVertexArrays(1, &vertex_array_object)

    # restore modified GL state
    glUseProgram(last_program)
    glBindTexture(GL_TEXTURE_2D, last_texture)
    g_GlslVersion[] > 330 && glBindSampler(0, last_sampler)
    glActiveTexture(last_active_texture)
    glBindVertexArray(last_vertex_array_object)
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

function ImGui_ImplOpenGL3_CreateFontsTexture()
    # build texture atlas
    fonts = unsafe_load(igGetIO().Fonts)
    pixels = Ptr{Cuchar}(C_NULL)
    width, height = Cint(0), Cint(0)
    @c GetTexDataAsRGBA32(fonts, &pixels, &width, &height)

    # upload texture to graphics system
    last_texture = GLint(0)
    @c glGetIntegerv(GL_TEXTURE_BINDING_2D, &last_texture)
    new_texture = GLuint(0)
    @c glGenTextures(1, &new_texture)
    glBindTexture(GL_TEXTURE_2D, new_texture)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
    glPixelStorei(GL_UNPACK_ROW_LENGTH, 0)
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, pixels)
    push!(g_FontTextures, new_texture)

    # store our identifier
    SetTexID(fonts, ImTextureID(Int(new_texture)))

    # restore state
    glBindTexture(GL_TEXTURE_2D, last_texture)

    return true
end

function ImGui_ImplOpenGL3_DestroyFontsTexture()
    io::Ptr{ImGuiIO} = GetIO()
    glDeleteTextures(length(g_FontTextures), g_FontTextures)
    SetTexID(unsafe_load(io.Fonts), ImTextureID(0))
    empty!(g_FontTextures)
end

function ImGui_ImplOpenGL3_CreateDeviceObjects()
    vertex_shader_glsl_130 = """
        #version $(g_GlslVersion[])
        uniform mat4 ProjMtx;
        in vec2 Position;
        in vec2 UV;
        in vec4 Color;
        out vec2 Frag_UV;
        out vec4 Frag_Color;
        void main()
        {
            Frag_UV = UV;
            Frag_Color = Color;
            gl_Position = ProjMtx * vec4(Position.xy,0,1);
        }"""

    vertex_shader_glsl_410_core = """
        #version $(g_GlslVersion[])
        layout (location = 0) in vec2 Position;
        layout (location = 1) in vec2 UV;
        layout (location = 2) in vec4 Color;
        uniform mat4 ProjMtx;
        out vec2 Frag_UV;
        out vec4 Frag_Color;
        void main()
        {
            Frag_UV = UV;
            Frag_Color = Color;
            gl_Position = ProjMtx * vec4(Position.xy,0,1);
        }"""

    fragment_shader_glsl_130 = """
        #version $(g_GlslVersion[])
        uniform sampler2D Texture;
        in vec2 Frag_UV;
        in vec4 Frag_Color;
        out vec4 Out_Color;
        void main()
        {
            Out_Color = Frag_Color * texture(Texture, Frag_UV.st);
        }"""

    fragment_shader_glsl_410_core = """
        #version $(g_GlslVersion[])
        in vec2 Frag_UV;
        in vec4 Frag_Color;
        uniform sampler2D Texture;
        layout (location = 0) out vec4 Out_Color;
        void main()
        {
            Out_Color = Frag_Color * texture(Texture, Frag_UV.st);
        }"""

    if g_GlslVersion[] == 410
        vertex_shader = vertex_shader_glsl_410_core
        fragment_shader = fragment_shader_glsl_410_core
    else
        vertex_shader = vertex_shader_glsl_130
        fragment_shader = fragment_shader_glsl_130
    end

    # backup GL state
    last_texture, last_array_buffer, last_vertex_array_object = GLint(0), GLint(0), GLint(0)
    @c glGetIntegerv(GL_TEXTURE_BINDING_2D, &last_texture)
    @c glGetIntegerv(GL_ARRAY_BUFFER_BINDING, &last_array_buffer)
    @c glGetIntegerv(GL_VERTEX_ARRAY_BINDING, &last_vertex_array_object)

    g_VertHandle[] = glCreateShader(GL_VERTEX_SHADER)
    glShaderSource(g_VertHandle[], 1, Ptr{GLchar}[pointer(vertex_shader)], C_NULL)
    glCompileShader(g_VertHandle[])
    status = GLint(-1)
    @c glGetShaderiv(g_VertHandle[], GL_COMPILE_STATUS, &status)
    if status != GL_TRUE
        max_length = GLsizei(0)
        @c glGetShaderiv(g_VertHandle[], GL_INFO_LOG_LENGTH, &max_length)
        actual_length = GLsizei(0)
        log = Vector{GLchar}(undef, max_length)
        @c glGetShaderInfoLog(g_VertHandle[], max_length, &actual_length, log)
        @error "[GL]: failed to compile vertex shader: $(g_VertHandle[]): $(String(log))"
    end

    g_FragHandle[] = glCreateShader(GL_FRAGMENT_SHADER)
    glShaderSource(g_FragHandle[], 1, Ptr{GLchar}[pointer(fragment_shader)], C_NULL)
    glCompileShader(g_FragHandle[])
    status = GLint(-1)
    @c glGetShaderiv(g_FragHandle[], GL_COMPILE_STATUS, &status)
    if status != GL_TRUE
        max_length = GLsizei(0)
        @c glGetShaderiv(g_FragHandle[], GL_INFO_LOG_LENGTH, &max_length)
        actual_length = GLsizei(0)
        log = Vector{GLchar}(undef, max_length)
        @c glGetShaderInfoLog(g_FragHandle[], max_length, &actual_length, log)
        @error "[GL]: failed to compile fragment shader: $(g_FragHandle[]): $(String(log))"
    end

    g_ShaderHandle[] = glCreateProgram()
    glAttachShader(g_ShaderHandle[], g_VertHandle[])
    glAttachShader(g_ShaderHandle[], g_FragHandle[])
    glLinkProgram(g_ShaderHandle[])
    status = GLint(-1)
    @c glGetProgramiv(g_ShaderHandle[], GL_LINK_STATUS, &status)
    @assert status == GL_TRUE

    g_AttribLocationTex[] = glGetUniformLocation(g_ShaderHandle[], "Texture")
    g_AttribLocationProjMtx[] = glGetUniformLocation(g_ShaderHandle[], "ProjMtx")
    g_AttribLocationVtxPos[] = glGetAttribLocation(g_ShaderHandle[], "Position")
    g_AttribLocationVtxUV[] = glGetAttribLocation(g_ShaderHandle[], "UV")
    g_AttribLocationVtxColor[] = glGetAttribLocation(g_ShaderHandle[], "Color")

    # create buffers
    glGenBuffers(1, g_VboHandle)
    glGenBuffers(1, g_ElementsHandle)

    ImGui_ImplOpenGL3_CreateFontsTexture()

    # restore modified GL state
    glBindTexture(GL_TEXTURE_2D, last_texture)
    glBindBuffer(GL_ARRAY_BUFFER, last_array_buffer)
    glBindVertexArray(last_vertex_array_object)

    return true;
end

function ImGui_ImplOpenGL3_DestroyDeviceObjects()
    g_VboHandle[] != 0 && glDeleteBuffers(1, g_VboHandle)
    g_ElementsHandle[] != 0 && glDeleteBuffers(1, g_ElementsHandle)
    g_VboHandle[] = g_ElementsHandle[] = GLuint(0)

    g_ShaderHandle[] != 0 && g_VertHandle != 0 && glDetachShader(g_ShaderHandle[], g_VertHandle[])

    g_VertHandle[] != 0 && glDeleteShader(g_VertHandle[])
    g_VertHandle[] = 0

    g_ShaderHandle[] != 0 && g_FragHandle[] != 0 && glDetachShader(g_ShaderHandle[], g_FragHandle[])
    g_FragHandle[] != 0 && glDeleteShader(g_FragHandle[])
    g_FragHandle[] = 0

    g_ShaderHandle[] != 0 && glDeleteProgram(g_ShaderHandle[])
    g_ShaderHandle[] = 0

    ImGui_ImplOpenGL3_DestroyFontsTexture()
    for (k,v) in g_ImageTexture
        ImGui_ImplOpenGL3_DestroyImageTexture(v)
    end
end

function ImGui_ImplOpenGL3_CreateImageTexture(image_width, image_height; format=GL_RGBA, type=GL_UNSIGNED_BYTE)
    id = GLuint(0)
    @c glGenTextures(1, &id)
    glBindTexture(GL_TEXTURE_2D, id)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR)
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR)
    glPixelStorei(GL_UNPACK_ROW_LENGTH, 0)
    glTexImage2D(GL_TEXTURE_2D, 0, format, GLsizei(image_width), GLsizei(image_height), 0, format, type, C_NULL)
    g_ImageTexture[id] = id
    return Int(id)
end

function ImGui_ImplOpenGL3_UpdateImageTexture(id, image_data, image_width, image_height; format=GL_RGBA, type=GL_UNSIGNED_BYTE)
    glBindTexture(GL_TEXTURE_2D, g_ImageTexture[id])
    glTexSubImage2D(GL_TEXTURE_2D, 0, 0, 0, GLsizei(image_width), GLsizei(image_height), format, type, image_data)
end

function ImGui_ImplOpenGL3_DestroyImageTexture(id)
    id = g_ImageTexture[id]
    @c glDeleteTextures(1, &id)
    delete!(g_ImageTexture, id)
    return true
end
