#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"
TARGET_DIR="$HOME/.config"

cd "$DOTFILES_DIR" || {
    echo "Failed to cd into $DOTFILES_DIR"
    exit 1
}

PACKAGES=(
    alacritty
    ghostty
    i3
    kitty
    nvim
    tmux
    zsh
)

echo "Stowing dotfiles..."

for pkg in "${PACKAGES[@]}"; do
    echo "→ Stowing $pkg"
    stow -t "$TARGET_DIR/$pkg" "$pkg"
done

echo "✅ All selected packages have been stowed."
