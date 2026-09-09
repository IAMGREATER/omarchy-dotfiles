#!/usr/bin/env bash
# Run this anytime you want to refresh the backup with your latest changes
# Then it auto-commits and pushes to GitHub.

set -e
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DATE=$(date +%d-%m-%Y)
MACHINE_ID=$(hostname)
MACHINE_BRANCH="machine/$(printf '%s' "$MACHINE_ID" | sed 's/[^A-Za-z0-9._-]/-/g; s/^-*//; s/-*$//')"
[ -n "$MACHINE_BRANCH" ] || MACHINE_BRANCH="machine/unknown"

echo "Syncing latest configs..."

# Configs
rsync -a --delete --exclude='*.bak*' ~/.config/hypr/            "$REPO_DIR/configs/hypr/"
rsync -a --delete --exclude='*.bak*' ~/.config/omarchy/         "$REPO_DIR/configs/omarchy/"
rsync -a --delete --exclude='*.bak*' ~/.config/systemd/user/    "$REPO_DIR/configs/systemd-user/"
[ -d ~/.config/easystroke-wayland ] && rsync -a --delete --exclude='*.bak*' ~/.config/easystroke-wayland/ "$REPO_DIR/configs/easystroke-wayland/"
[ -d ~/.config/voxtype ]            && rsync -a --delete --exclude='*.bak*' ~/.config/voxtype/            "$REPO_DIR/configs/voxtype/"
[ -d ~/.config/alacritty ]          && rsync -a --delete --exclude='*.bak*' ~/.config/alacritty/          "$REPO_DIR/configs/alacritty/"
[ -d ~/.config/ghostty ]            && rsync -a --delete --exclude='*.bak*' ~/.config/ghostty/            "$REPO_DIR/configs/ghostty/"
[ -d ~/.config/kitty ]              && rsync -a --delete --exclude='*.bak*' ~/.config/kitty/              "$REPO_DIR/configs/kitty/"
[ -d ~/.config/xournalpp ]          && rsync -a --delete --exclude='*.bak*' ~/.config/xournalpp/          "$REPO_DIR/configs/xournalpp/"
[ -d ~/.config/imv ]                && rsync -a --delete --exclude='*.bak*' ~/.config/imv/                "$REPO_DIR/configs/imv/"
[ -f ~/.config/starship.toml ]      && cp ~/.config/starship.toml "$REPO_DIR/configs/"
[ -d ~/.config/wireplumber ]        && rsync -a --delete --exclude='*.bak*' ~/.config/wireplumber/        "$REPO_DIR/configs/wireplumber/"
[ -d ~/.config/pipewire ]           && rsync -a --delete --exclude='*.bak*' ~/.config/pipewire/           "$REPO_DIR/configs/pipewire/"
[ -d ~/.config/Nextcloud ]          && mkdir -p "$REPO_DIR/configs/Nextcloud" && cp ~/.config/Nextcloud/nextcloud.cfg ~/.config/Nextcloud/sync-exclude.lst "$REPO_DIR/configs/Nextcloud/" 2>/dev/null || true

# Scripts
rsync -a ~/.local/bin/ "$REPO_DIR/scripts/local-bin/"
find "$REPO_DIR/scripts/local-bin/" -name "*.bak*" -delete
[ -f ~/.zshrc ]        && sed -E 's/(.*(KEY|TOKEN|SECRET).*=).*/\1"YOUR_SECRET_HERE"/' ~/.zshrc > "$REPO_DIR/scripts/zshrc" || true
[ -f ~/.bashrc ]       && sed -E 's/(.*(KEY|TOKEN|SECRET).*=).*/\1"YOUR_SECRET_HERE"/' ~/.bashrc > "$REPO_DIR/scripts/bashrc" || true
cp ~/.bash_profile "$REPO_DIR/scripts/bash_profile" 2>/dev/null || true

# Package lists
pacman -Qe --noconfirm > "$REPO_DIR/packages/pacman-explicit.txt"
pacman -Qm --noconfirm > "$REPO_DIR/packages/aur-packages.txt"
omarchy plugin list 2>/dev/null > "$REPO_DIR/packages/omarchy-plugins.txt" || true
omarchy plugin list 2>/dev/null | awk 'NR>1 && $2=="enabled" && $3=="third-party" {print $1}' > "$REPO_DIR/packages/omarchy-third-party-enabled.txt" || true
cp ~/.config/mise/config.toml "$REPO_DIR/packages/mise-tools.toml" 2>/dev/null || true

echo "Committing and pushing to GitHub..."
cd "$REPO_DIR"
current_branch=$(git branch --show-current)
if [ "$current_branch" = "main" ]; then
    if git show-ref --verify --quiet "refs/heads/$MACHINE_BRANCH"; then
        git switch "$MACHINE_BRANCH"
    elif git ls-remote --exit-code --heads origin "$MACHINE_BRANCH" >/dev/null 2>&1; then
        git fetch origin "$MACHINE_BRANCH"
        git switch --track "origin/$MACHINE_BRANCH"
    else
        git switch -c "$MACHINE_BRANCH"
    fi
elif [ "$current_branch" != "$MACHINE_BRANCH" ]; then
    echo "Refusing to back up from unexpected branch: $current_branch" >&2
    exit 1
fi
git add -A
git diff --cached --quiet && echo "Nothing changed — backup already up to date." && exit 0
git commit -m "Backup update ${DATE} [${MACHINE_ID}]"
git push --set-upstream origin "$MACHINE_BRANCH"

echo ""
echo "✅ Backup pushed to https://github.com/IAMGREATER/omarchy-dotfiles (${MACHINE_BRANCH})"
