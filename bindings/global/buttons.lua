local awful = require "awful"
local gears = require "gears"

local togglemenu = require "widgets.togglemenu"

local buttons = gears.table.join(
    awful.button({}, 3, function () togglemenu:toggle() end),
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
)

return buttons
