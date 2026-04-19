# Dotfiles Repo Design

**Date:** 2026-04-19
**Status:** Approved

## Goal

A git repository of curated dotfiles that can bootstrap a new machine and keep a common base config in sync across multiple systems.

## Approach

GNU Stow manages symlinks. Files live in the repo organized as Stow packages. Running `stow --target=$HOME <package>` creates symlinks from `~` into the repo. Edits on any machine are immediately tracked in git.

## Repo Structure

```
dotfiles_2026/
├── zsh/
│   ├── .zshrc
│   ├── .zshenv
│   └── .zprofile
├── bash/
│   ├── .bashrc
│   └── .bash_logout
├── git/
│   ├── .gitconfig
│   └── .gitignore        ← global gitignore
├── vim/
│   └── .vimrc
├── byobu/
│   └── .byobu/
├── claude/
│   └── .claude/
├── install.sh
└── README.md
```

## What Is Tracked

| Package | Files |
|---|---|
| `zsh` | `.zshrc`, `.zshenv`, `.zprofile` |
| `bash` | `.bashrc`, `.bash_logout` |
| `git` | `.gitconfig`, `.gitignore` (global) |
| `vim` | `.vimrc` |
| `byobu` | `.byobu/` |
| `claude` | `.claude/` |

## What Is Excluded

- **Credentials:** `.ssh/`, `.gnupg/`, `.aws/`, `.kube/`, `.databrickscfg`
- **History:** `.zsh_history`, `.bash_history`
- **Runtime state:** `.cache/`, `.local/`, `.config/`
- **Large tool caches:** `.cargo/`, `.gradle/`, `.m2/`, `.arduino15/`
- **Session data:** `.claude.json`

## Install Script

`install.sh` at the repo root:
- Verifies `stow` is installed; exits with instructions if not
- Runs `stow --target=$HOME --restow <package>` for each package
- Accepts optional package names as arguments to install a subset (e.g., `./install.sh zsh git`)

## Machine-Local Overrides

Host-specific config lives in untracked local files sourced at the end of each config:

- `.zshrc` sources `~/.zshrc.local` if it exists
- `.gitconfig` includes `~/.gitconfig.local` via `[include] path = ~/.gitconfig.local`

These local files are gitignored and created per-machine for custom `PATH`, work credentials, or host-specific settings.

## .gitignore

The repo `.gitignore` will exclude:
- `*.local` files
- Common secrets patterns (`.env`, `*.pem`, `*.p8`, `*.key`)
- OS noise (`.DS_Store`)
