# Claude Home Config

This is Jarod Belshaw's home-level Claude Code configuration. It applies across all projects on this machine.

## About Me

- Running WSL2 (Ubuntu) on Windows
- Daily tools: zsh, byobu, vim, git, Claude Code
- Work across multiple systems — keeping a common base config in sync matters

## Dotfiles Repo

My dotfiles live at `~/workspace/dotfiles_2026` and are managed with GNU Stow.

**To add a new dotfile to the repo:**
```bash
cd ~/workspace/dotfiles_2026
mkdir -p newpkg
mv ~/.<file> newpkg/.<file>
stow --target=$HOME newpkg
git add newpkg && git commit -m "feat: add newpkg package"
git push origin main
```

**Machine-local overrides (not tracked in git):**
- `~/.zshrc.local` — secrets, machine-specific PATH, etc.
- `~/.gitconfig.local` — work email, signing key, etc.

## How to Behave

- **Be concise.** Short responses unless detail is clearly needed.
- **No emojis** unless I ask for them.
- **Don't summarize what you just did** at the end of responses — I can read the diff.
- **Don't add features I didn't ask for.** Fix the thing, don't improve everything around it.
- **Prefer editing existing files** over creating new ones.
- **No speculative abstractions.** Build what the task requires, nothing more.
- **Secrets stay out of git.** If you see credentials in a file about to be committed, stop and fix it first.
