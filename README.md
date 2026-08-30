# omarchy-dotfiles

> **Full backup of my Omarchy Linux setup** — configs, packages, plugins, and custom scripts.  
> If my laptop dies, I clone this and run `./restore.sh`.

---

## 💻 My System

- **OS:** [Omarchy](https://omarchy.com) (Arch Linux based)
- **Window Manager:** Hyprland
- **Terminal:** Ghostty / Foot / Alacritty
- **Shell:** Zsh

---

## 📁 What's In Here

| Folder | Contents |
|---|---|
| `configs/hypr/` | Hyprland config — monitors, keybindings, window rules, input, autostart |
| `configs/omarchy/` | Omarchy shell, menus, extensions config |
| `configs/systemd-user/` | Custom user services (WeazyStroke, window restore, aero-snap, voxtype) |
| `configs/easystroke-wayland/` | Gesture definitions (imported from Easystroke Kubuntu) |
| `configs/voxtype/` | Voice dictation config |
| `configs/alacritty/` `ghostty/` `kitty/` | Terminal configs |
| `configs/xournalpp/` | Note-taking app config |
| `scripts/local-bin/` | All custom scripts (`toggle-pen`, `move-window-screen`, `omarchy-window-*`, etc.) |
| `scripts/zshrc` `bashrc` | Shell configs |
| `packages/pacman-explicit.txt` | All explicitly installed pacman packages |
| `packages/aur-packages.txt` | AUR packages |
| `packages/omarchy-plugins.txt` | Full Omarchy plugin list |
| `packages/omarchy-third-party-enabled.txt` | Third-party plugins to re-enable |
| `packages/mise-tools.toml` | mise tools (node, gh, claude, codex) |

---

## 🔧 Key Customisations Made

### Hyprland / Input
- Multi-monitor layout: Acer + Iiyama external, laptop screen underneath
- 4-finger touchpad swipe to move windows between monitors
- XP-Pen tablet locked to laptop screen (`eDP-1`)
- `toggle-pen` shortcut key to enable/disable stylus (stops erratic pointer)
- UK locale & date format (`en_GB.UTF-8`)
- Numlock on by default, right Alt = emoji key, CapsLock restored

### Omarchy Shell & Plugins
- Custom omarchy menu entries for Antigravity (AGY)
- 20+ third-party plugins enabled (Mirador, Expose, Dock, Blip, etc.)

### Custom Services
- **WeazyStroke** — mouse gesture daemon (custom C++ fork: [IAMGREATER/WeazyStroke](https://github.com/IAMGREATER/WeazyStroke/tree/custom-omarchy-gestures))
- **omarchy-window-restore** — remembers window positions/sizes
- **omarchy-aero-snap** — Windows-style window snapping
- **voxtype** — voice dictation to terminal

### VAULT Automount
- External NTFS drive auto-mounts at `/run/media/subi/VAULT` via `/etc/fstab`

---

## 🚀 How to Restore on a Fresh Install

```bash
# 1. Install Omarchy first (follow omarchy.com)

# 2. Clone this repo
git clone https://github.com/IAMGREATER/omarchy-dotfiles ~/omarchy-dotfiles

# 3. Run the restore script
cd ~/omarchy-dotfiles
chmod +x restore.sh
./restore.sh

# 4. For WeazyStroke gestures (optional - compile from source):
git clone https://github.com/IAMGREATER/WeazyStroke ~/WeazyStroke
cd ~/WeazyStroke
git checkout custom-omarchy-gestures
./reinstall.sh
```

---

## 🔄 Updating This Backup

Run this from your terminal to sync the latest changes:

```bash
cd ~/omarchy-dotfiles && ./update-backup.sh
```

---

## 📅 Backup History

| Date | Notes |
|---|---|
| 28-08-2026 | Initial backup — WeazyStroke, window management, multi-monitor, pen toggle |
| 30-08-2026 | Updated — all configs, scripts, full package list, plugin list |
