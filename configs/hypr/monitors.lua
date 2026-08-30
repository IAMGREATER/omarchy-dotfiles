-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 1
local omarchy_monitor_scale = 1

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))

-- Top-left: Acer display
hl.monitor({ output = "desc:Acer Technologies Acer KG271 0x8150BA1D", mode = "preferred", position = "0x0", scale = omarchy_monitor_scale })

-- Top-right: Iiyama display
hl.monitor({ output = "desc:Iiyama North America PL2530H 1154390701104", mode = "preferred", position = "1920x0", scale = omarchy_monitor_scale })

-- Bottom-center: Laptop display
hl.monitor({ output = "eDP-1", mode = "preferred", position = "960x1080", scale = omarchy_monitor_scale })

-- Fallback for any other / unconfigured displays
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })
