-- Enable sloppy focus, so that focus follows mouse.
return function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
end
