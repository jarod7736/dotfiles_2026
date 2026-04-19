# Dotfiles Repo Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Migrate curated dotfiles into a GNU Stow-based repo at `~/workspace/dotfiles_2026` so any machine can be bootstrapped with `./install.sh`.

**Architecture:** Each dotfile family lives in its own Stow package subdirectory (e.g., `zsh/`, `git/`). Running `stow --target=$HOME <package>` from the repo root creates symlinks in `~`. Machine-specific config lives in untracked `*.local` files sourced by the tracked configs.

**Tech Stack:** GNU Stow, zsh, bash, git

---

## File Map

| Path in repo | Symlinked to | Notes |
|---|---|---|
| `zsh/.zshrc` | `~/.zshrc` | Remove hardcoded secrets first |
| `zsh/.zshenv` | `~/.zshenv` | |
| `zsh/.zprofile` | `~/.zprofile` | |
| `bash/.bashrc` | `~/.bashrc` | |
| `bash/.bash_logout` | `~/.bash_logout` | |
| `git/.gitconfig` | `~/.gitconfig` | Add `[include]` for `.gitconfig.local` |
| `git/.gitignore` | `~/.gitignore` | Global gitignore |
| `vim/.vimrc` | `~/.vimrc` | |
| `byobu/.byobu/` | `~/.byobu/` | Exclude `.ssh-agent` runtime symlink |
| `claude/.claude/` | `~/.claude/` | Exclude `plugins/`, `projects/` |
| `install.sh` | — | Stow runner |
| `.gitignore` | — | Repo-level secrets + OS noise exclusions |

---

## Task 1: Repo .gitignore and package directories

**Files:**
- Create: `.gitignore`
- Create: `zsh/`, `bash/`, `git/`, `vim/`, `byobu/`, `claude/` (package dirs)

- [ ] **Step 1: Verify working directory**

```bash
cd ~/workspace/dotfiles_2026
ls
```

Expected output: `README.md  .git  docs/`

- [ ] **Step 2: Create package directories**

```bash
mkdir -p zsh bash git vim byobu claude
```

- [ ] **Step 3: Write repo .gitignore**

Create `.gitignore` at repo root with this content:

```gitignore
# Machine-local overrides (never commit)
*.local

# Secrets
.env
*.pem
*.p8
*.key
*.p12
*.pfx

# OS noise
.DS_Store
Thumbs.db

# Claude runtime/session data
claude/.claude/projects/
claude/.claude/plugins/
claude/.claude/.credentials.json
claude/.claude/todos/

# Byobu runtime
byobu/.byobu/.ssh-agent
```

- [ ] **Step 4: Commit scaffold**

```bash
git add .gitignore zsh bash git vim byobu claude
git commit -m "chore: scaffold stow package directories and .gitignore"
```

---

## Task 2: Sanitize .zshrc — remove hardcoded secrets

**Files:**
- Modify: `~/.zshrc` — remove `ANTHROPIC_API_KEY` export lines

> **Why this is first:** `.zshrc` currently exports `ANTHROPIC_API_KEY` in plaintext. If this is committed to git without sanitizing, the key is permanently in git history. Move it to `~/.zshrc.local` before any git operations on this file.

- [ ] **Step 1: Verify the secret is present**

```bash
grep -n "ANTHROPIC_API_KEY\|ANTRHOPIC_API_KEY" ~/.zshrc
```

Expected: one or two lines containing the key export.

- [ ] **Step 2: Note the key value**

Copy the value from the output above. You will need it for `.zshrc.local`.

- [ ] **Step 3: Remove secret lines from .zshrc**

Open `~/.zshrc` and delete the lines matching:

```zsh
export ANTRHOPIC_API_KEY="sk-ant-..."
export ANTHROPIC_API_KEY="sk-ant-..."
```

- [ ] **Step 4: Create ~/.zshrc.local with the secret**

```bash
cat > ~/.zshrc.local << 'EOF'
# Machine-local overrides — not tracked in git

export ANTHROPIC_API_KEY="<paste-key-here>"
EOF
```

Replace `<paste-key-here>` with the actual key value from Step 2.

- [ ] **Step 5: Verify .zshrc no longer contains the key**

```bash
grep -n "ANTHROPIC_API_KEY" ~/.zshrc
```

Expected: no output.

- [ ] **Step 6: Verify .zshrc.local sources correctly**

```bash
source ~/.zshrc.local && echo $ANTHROPIC_API_KEY | cut -c1-10
```

Expected: prints first 10 chars of the key (confirms it loads).

---

## Task 3: Migrate zsh package

**Files:**
- Create: `zsh/.zshrc`, `zsh/.zshenv`, `zsh/.zprofile`
- Symlinked from: `~/.zshrc`, `~/.zshenv`, `~/.zprofile`

- [ ] **Step 1: Simulate stow to check for conflicts (dry run)**

```bash
cd ~/workspace/dotfiles_2026
stow --simulate --target=$HOME zsh 2>&1
```

Expected: no output (no conflicts). If output shows conflicts, the originals still exist and need to be moved first.

- [ ] **Step 2: Copy zsh files into package**

```bash
cp ~/.zshrc zsh/.zshrc
cp ~/.zshenv zsh/.zshenv
cp ~/.zprofile zsh/.zprofile
```

- [ ] **Step 3: Add .zshrc.local source line to zsh/.zshrc**

Open `zsh/.zshrc` and add this at the very end of the file:

```zsh
# Machine-local overrides (not tracked in git)
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
```

- [ ] **Step 4: Remove originals from home**

```bash
rm ~/.zshrc ~/.zshenv ~/.zprofile
```

- [ ] **Step 5: Stow the zsh package**

```bash
cd ~/workspace/dotfiles_2026
stow --target=$HOME zsh
```

Expected: no output (success is silent in stow).

- [ ] **Step 6: Verify symlinks exist**

```bash
ls -la ~/.zshrc ~/.zshenv ~/.zprofile
```

Expected output (paths will vary by your username):
```
~/.zshrc   -> /home/jarod7736/workspace/dotfiles_2026/zsh/.zshrc
~/.zshenv  -> /home/jarod7736/workspace/dotfiles_2026/zsh/.zshenv
~/.zprofile -> /home/jarod7736/workspace/dotfiles_2026/zsh/.zprofile
```

- [ ] **Step 7: Verify shell still loads**

```bash
zsh -c 'echo "zsh loads ok"'
```

Expected: `zsh loads ok`

- [ ] **Step 8: Commit**

```bash
cd ~/workspace/dotfiles_2026
git add zsh/
git commit -m "feat: add zsh package (zshrc, zshenv, zprofile)"
```

---

## Task 4: Migrate bash package

**Files:**
- Create: `bash/.bashrc`, `bash/.bash_logout`
- Symlinked from: `~/.bashrc`, `~/.bash_logout`

- [ ] **Step 1: Dry run**

```bash
cd ~/workspace/dotfiles_2026
stow --simulate --target=$HOME bash 2>&1
```

Expected: no output.

- [ ] **Step 2: Copy bash files into package**

```bash
cp ~/.bashrc bash/.bashrc
cp ~/.bash_logout bash/.bash_logout
```

- [ ] **Step 3: Remove originals**

```bash
rm ~/.bashrc ~/.bash_logout
```

- [ ] **Step 4: Stow bash package**

```bash
cd ~/workspace/dotfiles_2026
stow --target=$HOME bash
```

- [ ] **Step 5: Verify symlinks**

```bash
ls -la ~/.bashrc ~/.bash_logout
```

Expected: both are symlinks pointing into the repo.

- [ ] **Step 6: Commit**

```bash
cd ~/workspace/dotfiles_2026
git add bash/
git commit -m "feat: add bash package (bashrc, bash_logout)"
```

---

## Task 5: Migrate git package

**Files:**
- Create: `git/.gitconfig`, `git/.gitignore`
- Symlinked from: `~/.gitconfig`, `~/.gitignore`

- [ ] **Step 1: Dry run**

```bash
cd ~/workspace/dotfiles_2026
stow --simulate --target=$HOME git 2>&1
```

Expected: no output.

- [ ] **Step 2: Copy git files into package**

```bash
cp ~/.gitconfig git/.gitconfig
cp ~/.gitignore git/.gitignore
```

- [ ] **Step 3: Add .gitconfig.local include to git/.gitconfig**

Open `git/.gitconfig` and add this block at the end:

```ini
[include]
	path = ~/.gitconfig.local
```

- [ ] **Step 4: Remove originals**

```bash
rm ~/.gitconfig ~/.gitignore
```

- [ ] **Step 5: Stow git package**

```bash
cd ~/workspace/dotfiles_2026
stow --target=$HOME git
```

- [ ] **Step 6: Verify symlinks**

```bash
ls -la ~/.gitconfig ~/.gitignore
```

Expected: both are symlinks pointing into the repo.

- [ ] **Step 7: Verify git still works**

```bash
git config user.email
```

Expected: your email address (e.g., `jarod7736@gmail.com`)

- [ ] **Step 8: Commit**

```bash
cd ~/workspace/dotfiles_2026
git add git/
git commit -m "feat: add git package (gitconfig with local include, gitignore)"
```

---

## Task 6: Migrate vim package

**Files:**
- Create: `vim/.vimrc`
- Symlinked from: `~/.vimrc`

- [ ] **Step 1: Dry run**

```bash
cd ~/workspace/dotfiles_2026
stow --simulate --target=$HOME vim 2>&1
```

Expected: no output.

- [ ] **Step 2: Copy .vimrc into package**

```bash
cp ~/.vimrc vim/.vimrc
```

- [ ] **Step 3: Remove original**

```bash
rm ~/.vimrc
```

- [ ] **Step 4: Stow vim package**

```bash
cd ~/workspace/dotfiles_2026
stow --target=$HOME vim
```

- [ ] **Step 5: Verify symlink**

```bash
ls -la ~/.vimrc
```

Expected: symlink pointing into the repo.

- [ ] **Step 6: Commit**

```bash
cd ~/workspace/dotfiles_2026
git add vim/
git commit -m "feat: add vim package (vimrc)"
```

---

## Task 7: Migrate byobu package

**Files:**
- Create: `byobu/.byobu/` (directory with config files)
- Symlinked from: `~/.byobu/` contents

Note: `.byobu/.ssh-agent` is a runtime symlink pointing to `/tmp/...` — do NOT copy it. It is already excluded in the repo `.gitignore`.

- [ ] **Step 1: Copy byobu config files (excluding runtime symlink)**

```bash
cp -r ~/.byobu/ byobu/.byobu/
rm -f byobu/.byobu/.ssh-agent
```

- [ ] **Step 2: Dry run**

```bash
cd ~/workspace/dotfiles_2026
stow --simulate --target=$HOME byobu 2>&1
```

If there are conflicts (because `~/.byobu/` already exists), stow will unfold and symlink individual files inside it. Conflicts only error if individual files already exist AND are not symlinks. If you get conflicts, remove the originals:

```bash
# Only if dry run shows conflicts:
rm -rf ~/.byobu
```

- [ ] **Step 3: Stow byobu package**

```bash
cd ~/workspace/dotfiles_2026
stow --target=$HOME byobu
```

- [ ] **Step 4: Verify**

```bash
ls -la ~/.byobu/
```

Expected: `.byobu/` exists and individual files are symlinks into the repo (or the whole dir is a symlink to the repo's `byobu/.byobu/`).

- [ ] **Step 5: Commit**

```bash
cd ~/workspace/dotfiles_2026
git add byobu/
git commit -m "feat: add byobu package"
```

---

## Task 8: Migrate claude package

**Files:**
- Create: `claude/.claude/` (directory)
- Symlinked from: `~/.claude/`

The `plugins/` and `projects/` subdirectories are excluded by `.gitignore` (regeneratable or project-specific). Only settings, CLAUDE.md, keybindings, and memory are tracked.

- [ ] **Step 1: Copy ~/.claude into package**

```bash
cp -r ~/.claude/ claude/.claude/
```

- [ ] **Step 2: Remove originals that will be symlinked**

```bash
rm -rf ~/.claude
```

- [ ] **Step 3: Dry run**

```bash
cd ~/workspace/dotfiles_2026
stow --simulate --target=$HOME claude 2>&1
```

Expected: no output.

- [ ] **Step 4: Stow claude package**

```bash
cd ~/workspace/dotfiles_2026
stow --target=$HOME claude
```

- [ ] **Step 5: Verify**

```bash
ls -la ~/.claude
```

Expected: `~/.claude` is a symlink to `~/workspace/dotfiles_2026/claude/.claude/`.

- [ ] **Step 6: Verify Claude Code still works**

```bash
claude --version
```

Expected: prints version string without error.

- [ ] **Step 7: Commit**

```bash
cd ~/workspace/dotfiles_2026
git add claude/
git commit -m "feat: add claude package (.claude config dir)"
```

---

## Task 9: Write install.sh

**Files:**
- Create: `install.sh`

- [ ] **Step 1: Write install.sh**

Create `install.sh` at the repo root:

```bash
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
```

- [ ] **Step 2: Make it executable**

```bash
chmod +x install.sh
```

- [ ] **Step 3: Test dry run (no --restow, just verify it runs)**

```bash
./install.sh --help 2>&1 || true
bash -n install.sh && echo "syntax ok"
```

Expected: `syntax ok`

- [ ] **Step 4: Test with a single package**

```bash
./install.sh zsh
```

Expected: `Stowing zsh...` and no errors. Symlinks already exist so `--restow` is idempotent.

- [ ] **Step 5: Commit**

```bash
cd ~/workspace/dotfiles_2026
git add install.sh
git commit -m "feat: add install.sh stow runner with package selection"
```

---

## Task 10: Update README

**Files:**
- Modify: `README.md`

- [ ] **Step 1: Write README**

Replace the contents of `README.md` with:

```markdown
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
```

- [ ] **Step 2: Commit**

```bash
cd ~/workspace/dotfiles_2026
git add README.md
git commit -m "docs: update README with bootstrap instructions and package list"
```
