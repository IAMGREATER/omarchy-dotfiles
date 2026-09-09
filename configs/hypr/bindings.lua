-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Toggle touchscreen pen/stylus input
o.bind("INSERT", "Toggle touchscreen pen input", "toggle-pen")
-- Mirador (workspace overview)
hl.unbind("SUPER + A")
o.bind("SUPER + A", "Mirador workspace overview", "omarchy-shell shell hide expose.window-overview; omarchy-shell shell toggle mirador '{}'")

-- Exposé (macOS-style window overview)
hl.unbind("SUPER + ALT + A")
o.bind("SUPER + ALT + A", "Exposé window overview", "omarchy-shell shell hide mirador; omarchy-shell shell toggle expose.window-overview '{}'")

-- Move active window between monitors/screens
hl.unbind("SUPER + ALT + LEFT")
o.bind("SUPER + ALT + LEFT", "Move window to left monitor", "move-window-screen left")

hl.unbind("SUPER + ALT + RIGHT")
o.bind("SUPER + ALT + RIGHT", "Move window to right monitor", "move-window-screen right")

o.bind("SUPER + CTRL + ALT + LEFT", "Move window to left monitor", "move-window-screen left")
o.bind("SUPER + CTRL + ALT + RIGHT", "Move window to right monitor", "move-window-screen right")

-- Windows 11-style window snapping (Super + Arrow keys)
hl.unbind("SUPER + LEFT")
o.bind("SUPER + LEFT", "Snap window to left half", "omarchy-window-snap left")

hl.unbind("SUPER + RIGHT")
o.bind("SUPER + RIGHT", "Snap window to right half", "omarchy-window-snap right")

hl.unbind("SUPER + UP")
o.bind("SUPER + UP", "Maximize window / Snap to top", "omarchy-window-snap up")

hl.unbind("SUPER + DOWN")
o.bind("SUPER + DOWN", "Restore window / Snap to bottom", "omarchy-window-snap down")

-- Corner quadrant snapping shortcuts (Home/End/PgUp/PgDn & Shift/Ctrl combinations)
hl.unbind("SUPER + Home")
o.bind("SUPER + Home", "Snap window to top-left quarter", "omarchy-window-snap top-left")
o.bind("SUPER + Prior", "Snap window to top-right quarter", "omarchy-window-snap top-right")
o.bind("SUPER + End", "Snap window to bottom-left quarter", "omarchy-window-snap bottom-left")
o.bind("SUPER + Next", "Snap window to bottom-right quarter", "omarchy-window-snap bottom-right")

hl.unbind("SUPER + SHIFT + UP")
o.bind("SUPER + SHIFT + UP", "Snap window to top-left quarter", "omarchy-window-snap top-left")
hl.unbind("SUPER + SHIFT + DOWN")
o.bind("SUPER + SHIFT + DOWN", "Snap window to bottom-left quarter", "omarchy-window-snap bottom-left")
o.bind("SUPER + CTRL + UP", "Snap window to top-right quarter", "omarchy-window-snap top-right")
o.bind("SUPER + CTRL + DOWN", "Snap window to bottom-right quarter", "omarchy-window-snap bottom-right")

-- Individual window height adjustments (works on tiled & floating windows)
hl.unbind("SUPER + P")
o.bind("SUPER + P", "Toggle free-height mode on window", "omarchy-window-height toggle")
hl.unbind("SUPER + ALT + UP")
o.bind("SUPER + ALT + UP", "Expand window height", "omarchy-window-height expand")
hl.unbind("SUPER + ALT + DOWN")
o.bind("SUPER + ALT + DOWN", "Shrink window height", "omarchy-window-height shrink")
hl.unbind("SUPER + ALT + V")
o.bind("SUPER + ALT + V", "Maximize window vertically", "omarchy-window-snap vertical")
hl.unbind("SUPER + ALT + C")
o.bind("SUPER + ALT + C", "Cycle window state (Maximize / Pop-up / Original)", "omarchy-window-snap cycle-up")

-- Window width adjustments (Super + Minus: move line left, Super + Equal/Plus: move line right)
hl.unbind("SUPER + code:20")
hl.unbind("SUPER + minus")
o.bind("SUPER + code:20", "Resize window to the left", "omarchy-window-snap resize-left")
o.bind("SUPER + minus", "Resize window to the left", "omarchy-window-snap resize-left")

hl.unbind("SUPER + code:21")
hl.unbind("SUPER + equal")
hl.unbind("SUPER + plus")
o.bind("SUPER + code:21", "Resize window to the right", "omarchy-window-snap resize-right")
o.bind("SUPER + equal", "Resize window to the right", "omarchy-window-snap resize-right")
o.bind("SUPER + plus", "Resize window to the right", "omarchy-window-snap resize-right")

-- Alt + Tab window cycling: focuses AND raises the window to top of z-order
hl.unbind("ALT + TAB")
hl.unbind("ALT + SHIFT + TAB")
o.bind("ALT + TAB", "Cycle and raise next window", "omarchy-window-cycle next")
o.bind("ALT + SHIFT + TAB", "Cycle and raise previous window", "omarchy-window-cycle prev")

-- Toggle Calculator (open on first press, dismiss on second press)
hl.unbind("XF86Calculator")
o.bind("XF86Calculator", "Toggle calculator", "toggle-calculator")

hl.unbind("SUPER + CTRL + Q")
o.bind("SUPER + CTRL + Q", "Toggle calculator", "toggle-calculator")

-- Toggle AI Agent Tokens and Quota panel
o.bind("SUPER + U", "Toggle AI agent tokens panel", "toggle-agent-tokens")

-- Launch GitHub Copilot CLI
o.bind("SUPER + SHIFT + CTRL + C", "GitHub Copilot CLI", "copilot-cli")







