local awful         = require "awful"
local hotkeys_popup = require "awful.hotkeys_popup"
local beautiful     = require "beautiful"

local settings = require "settings"

local function show_hotkeys()
    hotkeys_popup.show_help(nil, awful.screen.focused())
end

local awesome_menu_buttons = {
    { "hotkeys",     show_hotkeys },
    { "manual",      settings.terminal .. "e man awesome" },
    { "edit config", settings.editor_cmd .. " " .. awesome.conffile },
    { "restart",     awesome.restart },
    { "quit",        function() awesome.quit() end}
}

local menu = awful.menu({
    items = {
        { "awesome", awesome_menu_buttons, beautiful.awesome_icon },
        { "open terminal", settings.terminal }
    }
})

return menu
