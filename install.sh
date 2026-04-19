#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ALL_PACKAGES=(zsh bash git vim byobu claude)

# Verify stow is installed
if ! command -v stow &>/dev/null; then
  echo "ERROR: GNU Stow is not installed."
  echo "  Ubuntu/Debian: sudo apt install stow"
  echo "  macOS:         brew install stow"
  exit 1
fi

# Determine which packages to install
if [[ $# -gt 0 ]]; then
  PACKAGES=("$@")
else
  PACKAGES=("${ALL_PACKAGES[@]}")
fi

echo "Installing dotfiles from: $DOTFILES_DIR"
echo "Target: $HOME"
echo "Packages: ${PACKAGES[*]}"
echo ""

cd "$DOTFILES_DIR"

for pkg in "${PACKAGES[@]}"; do
  if [[ ! -d "$pkg" ]]; then
    echo "WARNING: Package '$pkg' not found, skipping."
    continue
  fi
  echo "  Stowing $pkg..."
  stow --target="$HOME" --restow "$pkg"
done

echo ""
echo "Done. Remember to create machine-local overrides if needed:"
echo "  ~/.zshrc.local    — zsh overrides (PATH, secrets, etc.)"
echo "  ~/.gitconfig.local — git overrides (work email, signing key, etc.)"
