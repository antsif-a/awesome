-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
-- pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require "gears"
local awful = require "awful"

-- Widget and layout library
local wibox = require "wibox"

-- Theme handling library
local beautiful = require "beautiful"

-- Notification library
local menubar = require "menubar"

-- Runtime settings
local settings       = require "settings"

-- Bindings
local globalkeys     = require "bindings.global.keys"
local globalbuttons  = require "bindings.global.buttons"
local clientkeys     = require "bindings.client.keys"
local clientbuttons  = require "bindings.client.buttons"

-- Widgets
local launcher       = require "widgets.launcher"
local textclock      = require "widgets.textclock"
local keyboardlayout = require "widgets.keyboardlayout"
local tasklist       = require "widgets.tasklist"
local taglist        = require "widgets.taglist"
local layoutbox      = require "widgets.layoutbox"

-- Signals
local focus             = require "signals.client.focus"
local unfocus           = require "signals.client.unfocus"
local manage            = require "signals.client.manage"
local mouse_enter       = require "signals.client.mouse::enter"
local request_titlebars = require "signals.client.request::titlebars"
local property_geometry = require "signals.screen.property::geometry"

-- Error handling
require "errorhandling"

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("/home/andrew/.config/awesome/theme.lua")

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- Menubar configuration
menubar.utils.terminal = settings.terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar

-- Create a wibox for each screen and add it

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end

    -- Each screen has its own tag table.
    local names = { "main", "www", "games", "4", "5", "6", "7", "8", "9" }
    awful.tag(names, s, awful.layout.suit.tile)

    -- Create the wibox
    s.wibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.wibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            launcher,
            taglist(s),
            awful.widget.prompt(),
        },
        tasklist(s), -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            keyboardlayout,
            wibox.widget.systray(),
            textclock,
            layoutbox(s),
        },
    }
end)
-- }}}

-- {{{ Global bindings
root.keys(globalkeys)
root.buttons(globalbuttons)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    },

    -- Add titlebars to normal clients and dialogs
    {
        rule_any = {
            type = { "normal", "dialog" }
        },
        properties = {
            titlebars_enabled = false
        }
    },
}
-- }}}

-- {{{ Signals
screen.connect_signal("property::geometry", property_geometry)

client.connect_signal("manage", manage)

client.connect_signal("request::titlebars", request_titlebars)

client.connect_signal("mouse::enter", mouse_enter)

client.connect_signal("focus", focus)
client.connect_signal("unfocus", unfocus)
-- }}}
