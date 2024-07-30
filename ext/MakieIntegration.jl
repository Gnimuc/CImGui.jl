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
GLMakie.framebuffer_size(window::ImMakieWindow) = GLMakie.framebuffer_size(window.glfw_window)
GLMakie.scale_factor(window::ImMakieWindow) = GLMakie.scale_factor(window.glfw_window)
GLMakie.reopen!(x::GLMakie.Screen{ImMakieWindow}) = x
GLMakie.set_screen_visibility!(::GLMakie.Screen{ImMakieWindow}, ::Bool) = nothing

# ShaderAbstractions support
GLMakie.ShaderAbstractions.native_switch_context!(x::ImMakieWindow) = GLFW.MakeContextCurrent(x.glfw_window)
GLMakie.ShaderAbstractions.native_context_alive(x::ImMakieWindow) = GLFW.is_initialized() && x.glfw_window != C_NULL

# This is called by GLMakie.display() to set up connections to GLFW for
# mouse/keyboard events etc. We disable it explicitly because we deliver the
# events in an immediate-mode fashion within MakieFigure().
GLMakie.connect_screen(::GLMakie.Scene, ::GLMakie.Screen{ImMakieWindow}) = nothing

function ig.MakieFigure(title_id::String, f::GLMakie.Figure; auto_resize_x=true, auto_resize_y=false)
    ig.PushID(title_id)
    id = ig.GetID(title_id)

    if !haskey(makie_context, id)
        window = ig.current_window()
        makie_window = ImMakieWindow(window)
        screen = GLMakie.Screen(; window=makie_window, start_renderloop=false)

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
        pos = ig.GetMousePos()
        cursor_pos = ig.GetCursorScreenPos()
        item_spacing = unsafe_load(ig.GetStyle().ItemSpacing.y)
        new_pos = (pos.x - cursor_pos.x, abs(pos.y - cursor_pos.y) - item_spacing)
        if new_pos != scene.events.mouseposition[]
            scene.events.mouseposition[] = new_pos
        end

        for (igkey, makiekey) in ((ig.ImGuiKey_MouseLeft, Makie.Mouse.left),
                                  (ig.ImGuiKey_MouseRight, Makie.Mouse.right))
            if ig.IsKeyPressed(igkey)
                scene.events.mousebutton[] = Makie.MouseButtonEvent(makiekey, Makie.Mouse.press)
            elseif ig.IsKeyReleased(igkey)
                scene.events.mousebutton[] = Makie.MouseButtonEvent(makiekey, Makie.Mouse.release)
            end
        end

        wheel_y = unsafe_load(io.MouseWheel)
        wheel_x = unsafe_load(io.MouseWheelH)
        if (wheel_x, wheel_y) != scene.events.scroll[]
            scene.events.scroll[] = (wheel_x, wheel_y)
        end

    end

    ig.PopID()

    return do_render
end

function __init__()
    ig.atrenderexit(destroy_context)
end

end
