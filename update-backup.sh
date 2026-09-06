#!/usr/bin/env bash
# Run this anytime you want to refresh the backup with your latest changes
# Then it auto-commits and pushes to GitHub.

set -e
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DATE=$(date +%d-%m-%Y)

echo "Syncing latest configs..."

# Configs
rsync -a --delete ~/.config/hypr/            "$REPO_DIR/configs/hypr/"
rsync -a --delete ~/.config/omarchy/         "$REPO_DIR/configs/omarchy/"
rsync -a --delete ~/.config/systemd/user/    "$REPO_DIR/configs/systemd-user/"
[ -d ~/.config/easystroke-wayland ] && rsync -a --delete ~/.config/easystroke-wayland/ "$REPO_DIR/configs/easystroke-wayland/"
[ -d ~/.config/voxtype ]            && rsync -a --delete ~/.config/voxtype/            "$REPO_DIR/configs/voxtype/"
[ -d ~/.config/alacritty ]          && rsync -a --delete ~/.config/alacritty/          "$REPO_DIR/configs/alacritty/"
[ -d ~/.config/ghostty ]            && rsync -a --delete ~/.config/ghostty/            "$REPO_DIR/configs/ghostty/"
[ -d ~/.config/kitty ]              && rsync -a --delete ~/.config/kitty/              "$REPO_DIR/configs/kitty/"
[ -d ~/.config/xournalpp ]          && rsync -a --delete ~/.config/xournalpp/          "$REPO_DIR/configs/xournalpp/"
[ -f ~/.config/starship.toml ]      && cp ~/.config/starship.toml "$REPO_DIR/configs/"
[ -d ~/.config/Nextcloud ]          && mkdir -p "$REPO_DIR/configs/Nextcloud" && cp ~/.config/Nextcloud/nextcloud.cfg ~/.config/Nextcloud/sync-exclude.lst "$REPO_DIR/configs/Nextcloud/" 2>/dev/null || true

# Scripts
rsync -a ~/.local/bin/ "$REPO_DIR/scripts/local-bin/"
find "$REPO_DIR/scripts/local-bin/" -name "*.bak*" -delete
cp ~/.zshrc        "$REPO_DIR/scripts/zshrc"        2>/dev/null || true
cp ~/.bashrc       "$REPO_DIR/scripts/bashrc"       2>/dev/null || true
cp ~/.bash_profile "$REPO_DIR/scripts/bash_profile" 2>/dev/null || true

# Package lists
pacman -Qe --noconfirm > "$REPO_DIR/packages/pacman-explicit.txt"
pacman -Qm --noconfirm > "$REPO_DIR/packages/aur-packages.txt"
omarchy plugin list 2>/dev/null > "$REPO_DIR/packages/omarchy-plugins.txt" || true
omarchy plugin list 2>/dev/null | awk 'NR>1 && $2=="enabled" && $3=="third-party" {print $1}' > "$REPO_DIR/packages/omarchy-third-party-enabled.txt" || true
cp ~/.config/mise/config.toml "$REPO_DIR/packages/mise-tools.toml" 2>/dev/null || true

echo "Committing and pushing to GitHub..."
cd "$REPO_DIR"
git add -A
git diff --cached --quiet && echo "Nothing changed — backup already up to date." && exit 0
git commit -m "Backup update ${DATE}"
git push origin main

echo ""
echo "✅ Backup pushed to https://github.com/IAMGREATER/omarchy-dotfiles"
