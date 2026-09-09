-- Extra autostart processes.
-- o.launch_on_start("my-service")

-- Prefer user command overrides over packaged Omarchy commands.
hl.env("PATH", os.getenv("HOME") .. "/.local/bin:" .. (os.getenv("PATH") or ""))
