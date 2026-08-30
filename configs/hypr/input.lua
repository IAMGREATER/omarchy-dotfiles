-- Keep only your personal input overrides here. Uncommented settings below
-- replace Omarchy's defaults.

-- Keyboard layout and options.
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
  input = {
    -- Right Alt is the Compose (emoji/symbol) key; CapsLock functions normally.
    kb_options = "compose:ralt",

    -- Start with numlock on by default.
    numlock_by_default = true,

    -- Focus follows mouse pointer; raise happens only on click
    follow_mouse = 1,
    float_switch_override_focus = 1,
    mouse_refocus = true,

    touchpad = {
      -- Use natural (inverse) scrolling.
      natural_scroll = true,

      -- Use two-finger clicks for right-click instead of lower-right corner.
      clickfinger_behavior = true,

      -- Control the speed of your scrolling.
      scroll_factor = 0.4,

      -- Enable the touchpad while typing.
      disable_while_typing = false,
    },
  },
})

-- App-specific touchpad scroll speeds.
-- o.window("(Alacritty|kitty|foot)", { scroll_touchpad = 1.5 })
-- o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.2 })


-- Function to cycle active window across monitors according to user layout
local function cycle_window_monitor(direction)
  pcall(function()
    local win = hl.get_active_window()
    if not win then return end

    local cur_mon = hl.get_active_monitor()
    if not cur_mon then return end

    local raw_mons = hl.get_monitors()
    local mons = {}
    for _, m in ipairs(raw_mons) do
      if not m.disabled then
        table.insert(mons, m)
      end
    end
    if #mons <= 1 then return end

    if #mons == 2 then
      for _, m in ipairs(mons) do
        if m.name ~= cur_mon.name then
          hl.dispatch(hl.dsp.window.move({ monitor = m.name }))
          return
        end
      end
      return
    end

    -- Identify Top-Left, Top-Right, and Bottom monitors
    local min_y = math.huge
    for _, m in ipairs(mons) do
      if m.y < min_y then min_y = m.y end
    end

    local top_mons = {}
    local bottom_mons = {}
    for _, m in ipairs(mons) do
      if math.abs(m.y - min_y) <= 200 then
        table.insert(top_mons, m)
      else
        table.insert(bottom_mons, m)
      end
    end

    table.sort(top_mons, function(a, b) return a.x < b.x end)
    table.sort(bottom_mons, function(a, b) return a.x < b.x end)

    local top_left = top_mons[1]
    local top_right = top_mons[#top_mons]
    local bottom = bottom_mons[1] or top_mons[2]

    local target = nil
    local is_left = (direction == "left" or direction == "l")

    if cur_mon.name == bottom.name then
      -- Bottom monitor: Left -> Top-Left; Right -> Top-Right
      target = is_left and top_left or top_right
    elseif cur_mon.name == top_left.name then
      -- Top-Left monitor: Left -> Bottom; Right -> Top-Right
      target = is_left and bottom or top_right
    elseif cur_mon.name == top_right.name then
      -- Top-Right monitor: Left -> Top-Left; Right -> Bottom
      target = is_left and top_left or bottom
    else
      target = is_left and top_left or top_right
    end

    if target and target.name ~= cur_mon.name then
      hl.dispatch(hl.dsp.window.move({ monitor = target.name }))
    end
  end)
end

-- 3-finger swipe gestures:
-- Swipe left: Snap window to left half
-- Swipe right: Snap window to right half
-- Swipe up: Cycle window state (Maximized -> Centered Pop-up -> Original)
-- Swipe down: Send window behind
hl.gesture({
  fingers = 3,
  direction = "left",
  disable_inhibit = true,
  action = function()
    hl.dispatch(hl.dsp.exec_cmd("omarchy-window-snap left"))
  end,
})

hl.gesture({
  fingers = 3,
  direction = "right",
  disable_inhibit = true,
  action = function()
    hl.dispatch(hl.dsp.exec_cmd("omarchy-window-snap right"))
  end,
})

hl.gesture({
  fingers = 3,
  direction = "up",
  disable_inhibit = true,
  action = function()
    hl.dispatch(hl.dsp.exec_cmd("omarchy-window-snap cycle-up"))
  end,
})

hl.gesture({
  fingers = 3,
  direction = "down",
  disable_inhibit = true,
  action = function()
    hl.dispatch(hl.dsp.exec_cmd("omarchy-window-send-behind"))
  end,
})




-- 4-finger swipe gestures:
-- Swipe up: Toggle Exposé (auto-closes Mirador if open)
-- Swipe down: Toggle Mirador (auto-closes Exposé if open)
-- Swipe left: Move active window to previous/left monitor
-- Swipe right: Move active window to next/right monitor
hl.gesture({
  fingers = 4,
  direction = "up",
  disable_inhibit = true,
  action = function()
    hl.dispatch(hl.dsp.exec_cmd("omarchy-shell shell hide mirador; omarchy-shell shell toggle expose.window-overview '{}'"))
  end,
})

hl.gesture({
  fingers = 4,
  direction = "down",
  disable_inhibit = true,
  action = function()
    hl.dispatch(hl.dsp.exec_cmd("omarchy-shell shell hide expose.window-overview; omarchy-shell shell toggle mirador '{}'"))
  end,
})

hl.gesture({
  fingers = 4,
  direction = "left",
  disable_inhibit = true,
  action = function()
    hl.dispatch(hl.dsp.exec_cmd("move-window-screen left"))
  end,
})

hl.gesture({
  fingers = 4,
  direction = "right",
  disable_inhibit = true,
  action = function()
    hl.dispatch(hl.dsp.exec_cmd("move-window-screen right"))
  end,
})


-- Tablet / Stylus and Cursor configuration
hl.config({
  cursor = {
    warp_back_after_non_mouse_input = false,
    no_warps = false,
  },
  input = {
    tablet = {
      output = "eDP-1",
    },
    touchdevice = {
      output = "eDP-1",
    },
  },
})

-- Map laptop touchscreen pen/stylus, finger touch, and XP-Pen tablet directly to the laptop display (eDP-1)
hl.device({
  name = "wacom-hid-5365-pen",
  output = "eDP-1",
})
hl.device({
  name = "wacom-hid-5365-finger",
  output = "eDP-1",
})
hl.device({
  name = "xp-pen-deco-02-stylus",
  output = "eDP-1",
})

-- Float and center XP-Pen configuration GUI
o.window("org.omarchy.xppen-config", {
  float = true,
  center = true,
  size = "720 680",
})


