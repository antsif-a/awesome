local awful     = require "awful"
local beautiful = require "beautiful"

local toggle_menu_widget = require "widgets.togglemenu"

local launcher = awful.widget.launcher({
    menu = toggle_menu_widget,
    image = beautiful.awesome_subico
})

return launcher
