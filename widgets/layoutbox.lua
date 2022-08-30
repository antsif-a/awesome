local awful = require "awful"
local gears = require "gears"

local function layoutbox(s)
    local lb = awful.widget.layoutbox(s)
    lb:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc(1)  end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),
        awful.button({}, 4, function() awful.layout.inc(1)  end),
        awful.button({}, 5, function() awful.layout.inc(-1) end)
    ))

    return lb
end

return layoutbox
