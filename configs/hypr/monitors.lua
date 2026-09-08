-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 1
local omarchy_monitor_scale = 1

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))

-- Top-left: Acer display (60Hz for standard CEA-861 HDMI/DP audio packet timing)
hl.monitor({ output = "desc:Acer Technologies Acer KG271 0x8150BA1D", mode = "1920x1080@60", position = "0x0", scale = omarchy_monitor_scale })

-- Top-right: Iiyama display
hl.monitor({ output = "desc:Iiyama North America PL2530H 1154390701104", mode = "preferred", position = "1920x0", scale = omarchy_monitor_scale })

-- Bottom-center: Laptop display
hl.monitor({ output = "eDP-1", mode = "preferred", position = "960x1080", scale = omarchy_monitor_scale })

-- Virtual / Dummy HDMI tablet display: OnePlus Pad (7:5 ratio), matching laptop height (1200) with narrower width (1680), centered below laptop
hl.monitor({ output = "HDMI-A-1", mode = "1680x1200@60", position = "1080x2280", scale = 1 })
hl.monitor({ output = "HEADLESS-[0-9]+", mode = "1680x1200@60", position = "1080x2280", scale = 1 })

-- Fallback for any other / unconfigured displays
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })
