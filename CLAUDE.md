# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managing development environment configurations for Bash, Vim/Neovim, and Tmux on Linux (Ubuntu).

## Setup Commands

```bash
# Initial setup - creates symlinks for all config files
./first_shot.sh

# Non-interactive mode (auto-yes to all prompts)
./first_shot.sh -y
```

The setup script creates symlinks from `~/.bashrc`, `~/.bash_profile`, `~/.vimrc`, `~/.tmux.conf`, `~/.config/mise/`, and `~/.config/git/` to this repository.

## Architecture

### Directory Structure
- `bash/` - Shell configuration (.bashrc, .bash_profile, alias.bash, functions/)
- `vim/` - Vim/Neovim configuration (.vimrc, init.vim)
- `tmux/` - Tmux configuration
- `_.config/` - XDG config directory contents (mise, git)

### Key Configuration Files
- `bash/.bashrc` - Main shell config, loads alias.bash and functions, sets up mise/direnv/fzf/nvm
- `bash/alias.bash` - All shell aliases (git, docker, vim, python, kubernetes, etc.)
- `vim/.vimrc` - Vim settings and fzf keybindings (Leader = Space)
- `vim/init.vim` - Neovim entry point (minimal, VSCode-aware)
- `_.config/mise/config.toml` - Tool version management (node, python, go, kubectl, etc.)

### Tool Integrations
Runtime version management is done via **mise** (not asdf). Key tools managed: Node.js, Python, Go, kubectl, fzf, neovim, terraform (tfenv).

Shell uses **vi mode** (`set -o vi`), **direnv** for per-directory env vars, **z** for directory jumping, and **fzf** for fuzzy finding.

## Common Aliases

- `sb` - source ~/.bashrc
- `vi` / `v` - nvim with tabs
- `cf` - cd to ghq-managed repo via fzf
- `dc` - docker compose
- `k` - kubectl
- `st`, `br`, `sw` - git status, branch, switch

## Code Style

EditorConfig is configured in `.editorconfig`:
- Shell scripts: 2 spaces, LF line endings
- YAML/TOML/JSON/Vim/Lua: 2 spaces
- UTF-8 encoding, trim trailing whitespace
