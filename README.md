# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Packages

| Package | Contents |
|---|---|
| `zsh` | `.zshrc`, `.zshenv`, `.zprofile` |
| `bash` | `.bashrc`, `.bash_logout` |
| `git` | `.gitconfig`, `.gitignore` |
| `vim` | `.vimrc` |
| `byobu` | `.byobu/` |
| `claude` | `.claude/` |

## Bootstrap a new machine

**Prerequisites:** `git`, `stow`

```bash
# Ubuntu/Debian
sudo apt install stow

# Clone the repo
git clone https://github.com/<your-username>/dotfiles_2026.git ~/workspace/dotfiles_2026

# Install all packages
cd ~/workspace/dotfiles_2026
./install.sh

# Or install specific packages
./install.sh zsh git
```

## Machine-local overrides

Create these files on each machine (not tracked in git):

**`~/.zshrc.local`** — machine-specific shell config:
```zsh
export ANTHROPIC_API_KEY="..."
export PATH="$PATH:/some/machine/specific/path"
```

**`~/.gitconfig.local`** — machine-specific git config:
```ini
[user]
    email = work@company.com
    signingkey = ABCD1234
```

## Adding a new dotfile

1. Create the package directory: `mkdir -p newpkg`
2. Move the file: `mv ~/.<file> newpkg/.<file>`
3. Stow it: `stow --target=$HOME newpkg`
4. Commit: `git add newpkg && git commit -m "feat: add newpkg package"`
