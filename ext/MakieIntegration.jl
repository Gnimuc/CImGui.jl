module MakieIntegration

import CImGui as ig
import ModernGL as gl
import GLFW
import GLMakie
import GLMakie.Makie as Makie


# Represents a single Figure to be shown as an ImGui image texture
struct ImMakieWindow
    glfw_window::GLFW.Window # Only needed for supporting GLMakie requirements
end

struct ImMakieFigure
    figure::GLMakie.Figure
    screen::GLMakie.Screen{ImMakieWindow}
end

const makie_context = Dict{ig.ImGuiID, ImMakieFigure}()

function destroy_context()
    for imfigure in values(makie_context)
        empty!(imfigure.figure)
    end

    empty!(makie_context)
end

Base.isopen(window::ImMakieWindow) = isopen(window.glfw_window)

# Specialization of Base.resize(::GLMakie.Screen, ::Int, ::Int) to not do GLFW things
# See: https://github.com/MakieOrg/Makie.jl/blob/4c4eaa1f3a7f7b3777a4b8ab38388a48c0eee6ce/GLMakie/src/screen.jl#L664
function Base.resize!(screen::GLMakie.Screen{ImMakieWindow}, w::Int, h::Int)
    fbscale = screen.px_per_unit[]
    fbw, fbh = round.(Int, fbscale .* (w, h))
    resize!(screen.framebuffer, fbw, fbh)
end

# Not sure if this is correct, it should probably be the figure size
GLMakie.framebuffer_size(window::ImMakieWindow) = GLMakie.framebuffer_size(window.glfw_window)

# ShaderAbstractions support
GLMakie.ShaderAbstractions.native_switch_context!(x::ImMakieWindow) = GLFW.MakeContextCurrent(x.glfw_window)
GLMakie.ShaderAbstractions.native_context_alive(x::ImMakieWindow) = GLFW.is_initialized() && x.glfw_window != C_NULL

# This is called by GLMakie.display() to set up connections to GLFW for
# mouse/keyboard events etc. We disable it explicitly because we deliver the
# events in an immediate-mode fashion within MakieFigure().
GLMakie.connect_screen(::GLMakie.Scene, ::GLMakie.Screen{ImMakieWindow}) = nothing

# Modified copy of apply_config!() with all GLFW/renderloop things removed
# See: https://github.com/MakieOrg/Makie.jl/blob/4c4eaa1f3a7f7b3777a4b8ab38388a48c0eee6ce/GLMakie/src/screen.jl#L343
function apply_config!(screen::GLMakie.Screen, config::GLMakie.ScreenConfig)
    screen.scalefactor[] = !isnothing(config.scalefactor) ? config.scalefactor : 1
    screen.px_per_unit[] = !isnothing(config.px_per_unit) ? config.px_per_unit : screen.scalefactor[]
    function replace_processor!(postprocessor, idx)
        fb = screen.framebuffer
        shader_cache = screen.shader_cache
        post = screen.postprocessors[idx]
        if post.constructor !== postprocessor
            GLMakie.destroy!(screen.postprocessors[idx])
            screen.postprocessors[idx] = postprocessor(fb, shader_cache)
        end

        nothing
    end

    replace_processor!(config.ssao ? GLMakie.ssao_postprocessor : GLMakie.empty_postprocessor, 1)
    replace_processor!(config.oit ? GLMakie.OIT_postprocessor : GLMakie.empty_postprocessor, 2)
    replace_processor!(config.fxaa ? GLMakie.fxaa_postprocessor : GLMakie.empty_postprocessor, 3)

    # Set the config
    screen.config = config
end

function draw_figure_tooltip(cursor_pos, image_size)
    help_str = "(?)"
    text_size = ig.CalcTextSize(help_str)
    text_pos = (cursor_pos.x + image_size[1] - text_size.x, cursor_pos.y)
    ig.AddText(ig.GetWindowDrawList(), text_pos, ig.IM_COL32_BLACK, help_str)
    hovering = ig.IsMouseHoveringRect(text_pos, (text_pos[1] + text_size.x, text_pos[2] + text_size.y))

    if hovering && ig.BeginTooltip()
        ig.PushTextWrapPos(ig.GetFontSize() * 35.0)
        ig.TextUnformatted("""
            Controls:
            - Scroll to zoom
            - Click and drag to rectangle select a region to zoom to
            - Right click and drag to pan
            - Shift + {x/y} and scroll to zoom along the X/Y axes
            - Ctrl + left click to reset the limits
            """)
        ig.PopTextWrapPos()
        ig.EndTooltip()
    end
end

function ig.MakieFigure(title_id::String, f::GLMakie.Figure; auto_resize_x=true, auto_resize_y=false, tooltip=true)
    ig.PushID(title_id)
    id = ig.GetID(title_id)

    if !haskey(makie_context, id)
        # The code in this block combines the screen creation code from
        # GLMakie.empty_screen() and the screen configuration code from
        # GLMakie.Screen().
        # See:
        # - https://github.com/MakieOrg/Makie.jl/blob/4c4eaa1f3a7f7b3777a4b8ab38388a48c0eee6ce/GLMakie/src/screen.jl#L223
        # - https://github.com/MakieOrg/Makie.jl/blob/4c4eaa1f3a7f7b3777a4b8ab38388a48c0eee6ce/GLMakie/src/screen.jl#L388
        window = ig.current_window()
        makie_window = ImMakieWindow(window)
        GLMakie.ShaderAbstractions.switch_context!(makie_window)
        shader_cache = GLMakie.GLAbstraction.ShaderCache(makie_window)

        fb = GLMakie.GLFramebuffer((10, 10))
        gl.glBindFramebuffer(gl.GL_FRAMEBUFFER, 0) # Have to unbind after creating the framebuffer
        postprocessors = [
            GLMakie.empty_postprocessor(),
            GLMakie.empty_postprocessor(),
            GLMakie.empty_postprocessor(),
            GLMakie.to_screen_postprocessor(fb, shader_cache)
        ]

        screen = GLMakie.Screen(makie_window, shader_cache, fb,
                                nothing, false,
                                nothing,
                                Dict{WeakRef, GLMakie.ScreenID}(),
                                GLMakie.ScreenArea[],
                                Tuple{GLMakie.ZIndex, GLMakie.ScreenID, GLMakie.RenderObject}[],
                                postprocessors,
                                Dict{UInt64, GLMakie.RenderObject}(),
                                Dict{UInt32, GLMakie.AbstractPlot}(),
                                true)
        config = Makie.merge_screen_config(GLMakie.ScreenConfig, Dict{Symbol, Any}())
        apply_config!(screen, config)

        makie_context[id] = ImMakieFigure(f, screen)
        scene = Makie.get_scene(f)
        scene.events.window_open[] = true
        display(screen, f)
    end

    imfigure = makie_context[id]
    scene = Makie.get_scene(f)

    region_avail = ig.GetContentRegionAvail()
    region_size = (Int(region_avail.x), Int(region_avail.y))
    scene_size = size(scene)
    new_size = (auto_resize_x ? region_size[1] : scene_size[1],
                auto_resize_y ? region_size[2] : scene_size[2])

    if scene_size != new_size && all(new_size .> 0)
        @debug "resizing $(scene_size) -> $(new_size)"
        scene.events.window_area[] = GLMakie.Rect2i(0, 0, Int(new_size[1]), Int(new_size[2]))
        resize!(f, new_size[1], new_size[2])
    end

    do_render = GLMakie.requires_update(imfigure.screen)
    if do_render
        @debug "rendering"
        GLMakie.render_frame(imfigure.screen)
    end

    # The color texture is what we need to render as an image. We add it to the
    # drawlist and then create an InvisibleButton of the same size to create a
    # space in the layout that can respond to key presses and clicks etc (which
    # a regular Image() can't do).
    color_buffer = imfigure.screen.framebuffer.buffers[:color]
    drawlist = ig.GetWindowDrawList()
    cursor_pos = ig.GetCursorScreenPos()
    image_size = size(color_buffer)
    ig.AddImage(drawlist,
                Ptr{Cvoid}(Int(color_buffer.id)),
                cursor_pos,
                (cursor_pos.x + image_size[1], cursor_pos.y + image_size[2]),
                (0, 1), (1, 0))

    # Draw tooltip
    if tooltip
        draw_figure_tooltip(cursor_pos, image_size)
    end

    ig.InvisibleButton("figure_image", size(color_buffer))

    # Update the scene events
    if scene.events.hasfocus[] != ig.IsItemHovered()
        scene.events.hasfocus[] = ig.IsItemHovered()
    end
    if scene.events.entered_window[] != ig.IsItemHovered()
        scene.events.entered_window[] = ig.IsItemHovered()
    end

    io = ig.GetIO()
    if ig.IsItemHovered()
        # Update the mouse position
        pos = ig.GetMousePos()
        cursor_pos = ig.GetCursorScreenPos()
        item_spacing = unsafe_load(ig.GetStyle().ItemSpacing.y)
        new_pos = (pos.x - cursor_pos.x, abs(pos.y - cursor_pos.y) - item_spacing)
        if new_pos != scene.events.mouseposition[]
            scene.events.mouseposition[] = new_pos
        end

        # Update the mouse buttons
        for (igkey, makiekey) in ((ig.ImGuiKey_MouseLeft, Makie.Mouse.left),
                                  (ig.ImGuiKey_MouseRight, Makie.Mouse.right))
            if ig.IsKeyPressed(igkey)
                scene.events.mousebutton[] = Makie.MouseButtonEvent(makiekey, Makie.Mouse.press)
            elseif ig.IsKeyReleased(igkey)
                scene.events.mousebutton[] = Makie.MouseButtonEvent(makiekey, Makie.Mouse.release)
            end
        end

        # Update the scroll rate
        wheel_y = unsafe_load(io.MouseWheel)
        wheel_x = unsafe_load(io.MouseWheelH)
        if (wheel_x, wheel_y) != scene.events.scroll[]
            scene.events.scroll[] = (wheel_x, wheel_y)
        end

        # Update pressed and released keys. For now we only support X/Y/left
        # Ctrl because those are the ones that Makie uses by default and to do
        # it properly for all keys we need to make a mapping from ImGuiKey's to
        # GLFW keys.
        for (igkey, glfwkey) in ((ig.lib.ImGuiKey_X, Int(GLFW.KEY_X)),
                                 (ig.lib.ImGuiKey_Y, Int(GLFW.KEY_Y)),
                                 (ig.lib.ImGuiKey_LeftCtrl, Int(GLFW.KEY_LEFT_CONTROL)))
            if ig.IsKeyPressed(igkey)
                scene.events.keyboardbutton[] = Makie.KeyEvent(Makie.Keyboard.Button(glfwkey), Makie.Keyboard.press)
            elseif ig.IsKeyReleased(igkey)
                scene.events.keyboardbutton[] = Makie.KeyEvent(Makie.Keyboard.Button(glfwkey), Makie.Keyboard.release)
            end
        end
    end

    ig.PopID()

    return do_render
end

function __init__()
    ig.atrenderexit(destroy_context)
end

end
