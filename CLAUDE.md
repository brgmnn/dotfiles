# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository using GNU Stow for managing configuration files across different applications and environments. The repository contains configuration files for various tools including vim, zsh, alacritty, git, and custom scripts.

## Architecture

The repository follows GNU Stow's directory structure pattern where each subdirectory represents a "package" of related configuration files:

- Each top-level directory (e.g., `vim/`, `zsh/`, `alacritty/`) contains configuration files structured as they would appear in the home directory
- Files are symlinked to the home directory using GNU Stow commands
- The directory structure mirrors the target filesystem hierarchy

## Common Commands

### Installing/Managing Dotfiles
```bash
# Install a configuration package
stow vim

# Uninstall a configuration package  
stow -D vim

# Reinstall/reload a configuration package
stow -R vim

# Install to a specific target directory
stow -t /home/user vim
```

### macOS Configuration
```bash
# Apply macOS defaults and restart system services
./macos/configure.sh
```

## Key Components

- **bin/.bin/**: Custom utility scripts and tools
- **vim/.vimrc**: Vim configuration with vim-plug plugin manager
- **zsh/.zshrc**: ZSH configuration with Antigen plugin management
- **alacritty/**: Terminal emulator configuration
- **git/**: Git configuration and aliases
- **macos/**: macOS-specific defaults and configuration

## Development Workflow

When modifying dotfiles:
1. Edit files within their respective package directories
2. Test changes by restowing the package: `stow -R <package-name>`
3. Reload terminals/applications to pick up changes
4. For new files, remember to restow to create new symlinks