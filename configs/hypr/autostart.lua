-- Extra autostart processes.
-- o.launch_on_start("my-service")

-- Restore touchscreen pen disabled state on login/startup if previously toggled off
o.exec_on_start("toggle-pen restore")

-- 3-finger swipe daemon to map 3-finger swipe up/down to Super + Alt + F
o.exec_on_start("3finger-swipe-daemon")

