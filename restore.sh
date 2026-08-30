#!/usr/bin/env bash
# ==============================================================================
# Omarchy Full System Restore Script
# User: subi (IAMGREATER on GitHub)
# Last updated: 30-08-2026
#
# Run this on a fresh Omarchy install to restore all settings, apps & plugins.
# ==============================================================================

set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
USER_HOME="$HOME"  # Works for any username on any machine

echo ""
echo "============================================================"
echo "   Omarchy Full Restore - Starting..."
echo "============================================================"
echo ""

# ── STEP 1: Install official packages ────────────────────────────────────────
echo "[1/7] Installing packages from pacman..."
sudo pacman -S --needed --noconfirm $(awk '{print $1}' "$REPO_DIR/packages/pacman-explicit.txt" | tr '\n' ' ') 2>/dev/null || true
echo "      Done."

# ── STEP 2: Install AUR packages ─────────────────────────────────────────────
echo "[2/7] Installing AUR packages..."
if command -v yay &>/dev/null; then
    yay -S --needed --noconfirm $(awk '{print $1}' "$REPO_DIR/packages/aur-packages.txt" | tr '\n' ' ') 2>/dev/null || true
else
    echo "      yay not found - install yay first then re-run for AUR packages."
fi
echo "      Done."

# ── STEP 3: Install mise tools (node, gh, etc.) ───────────────────────────────
echo "[3/7] Installing mise tools..."
if command -v mise &>/dev/null; then
    cp "$REPO_DIR/packages/mise-tools.toml" "$HOME/.config/mise/config.toml"
    mise install
else
    echo "      mise not found - install mise first then re-run."
fi
echo "      Done."

# ── STEP 4: Restore config files ─────────────────────────────────────────────
echo "[4/7] Restoring ~/.config files..."
mkdir -p "$USER_HOME/.config"
rsync -a "$REPO_DIR/configs/hypr/"                "$USER_HOME/.config/hypr/"
rsync -a "$REPO_DIR/configs/omarchy/"             "$USER_HOME/.config/omarchy/"
rsync -a "$REPO_DIR/configs/systemd-user/"        "$USER_HOME/.config/systemd/user/"
[ -d "$REPO_DIR/configs/easystroke-wayland" ] && rsync -a "$REPO_DIR/configs/easystroke-wayland/"  "$USER_HOME/.config/easystroke-wayland/"
[ -d "$REPO_DIR/configs/voxtype" ]             && rsync -a "$REPO_DIR/configs/voxtype/"            "$USER_HOME/.config/voxtype/"
[ -d "$REPO_DIR/configs/alacritty" ]           && rsync -a "$REPO_DIR/configs/alacritty/"          "$USER_HOME/.config/alacritty/"
[ -d "$REPO_DIR/configs/ghostty" ]             && rsync -a "$REPO_DIR/configs/ghostty/"            "$USER_HOME/.config/ghostty/"
[ -d "$REPO_DIR/configs/kitty" ]               && rsync -a "$REPO_DIR/configs/kitty/"              "$USER_HOME/.config/kitty/"
[ -d "$REPO_DIR/configs/xournalpp" ]           && rsync -a "$REPO_DIR/configs/xournalpp/"          "$USER_HOME/.config/xournalpp/"
[ -f "$REPO_DIR/configs/starship.toml" ]       && cp "$REPO_DIR/configs/starship.toml"             "$USER_HOME/.config/starship.toml"
echo "      Done."

# ── STEP 5: Restore custom scripts ───────────────────────────────────────────
echo "[5/7] Restoring ~/.local/bin scripts..."
mkdir -p "$USER_HOME/.local/bin"
rsync -a "$REPO_DIR/scripts/local-bin/"  "$USER_HOME/.local/bin/"
chmod +x "$USER_HOME/.local/bin/"* 2>/dev/null || true
[ -f "$REPO_DIR/scripts/zshrc" ]        && cp "$REPO_DIR/scripts/zshrc"        "$USER_HOME/.zshrc"
[ -f "$REPO_DIR/scripts/bashrc" ]       && cp "$REPO_DIR/scripts/bashrc"       "$USER_HOME/.bashrc"
[ -f "$REPO_DIR/scripts/bash_profile" ] && cp "$REPO_DIR/scripts/bash_profile" "$USER_HOME/.bash_profile"
echo "      Done."

# ── STEP 6: Restore Omarchy plugins ──────────────────────────────────────────
echo "[6/7] Re-enabling Omarchy third-party plugins..."
if command -v omarchy &>/dev/null; then
    while IFS= read -r plugin_id; do
        [ -z "$plugin_id" ] && continue
        echo "      Enabling: $plugin_id"
        omarchy plugin add "$plugin_id" --enable 2>/dev/null || \
        omarchy plugin enable "$plugin_id" 2>/dev/null || true
    done < "$REPO_DIR/packages/omarchy-third-party-enabled.txt"
else
    echo "      omarchy command not found - skipping plugin restore."
fi
echo "      Done."

# ── STEP 7: Reload services ───────────────────────────────────────────────────
echo "[7/7] Reloading systemd user services..."
systemctl --user daemon-reload
systemctl --user enable --now weazystroke.service       2>/dev/null || true
systemctl --user enable --now omarchy-window-restore.service 2>/dev/null || true
systemctl --user enable --now omarchy-aero-snap.service      2>/dev/null || true
systemctl --user enable --now voxtype.service                2>/dev/null || true
hyprctl reload 2>/dev/null || true
echo "      Done."

echo ""
echo "============================================================"
echo "   Restore complete! Log out and back in (or reboot)."
echo "   For WeazyStroke gestures, clone:"
echo "   https://github.com/IAMGREATER/WeazyStroke"
echo "   branch: custom-omarchy-gestures"
echo "   then run: ./reinstall.sh"
echo "============================================================"
echo ""
