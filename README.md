# Dotfiles Setup

This repository contains my personal configuration files (dotfiles) for various applications, including:

- **Hyprland**
- **Neovim**
- **Kitty**
- **Zed**
- **Ghostty**
- **Waybar**
- **Zsh**
- **NixOS system configuration**

## Installation

To set up these dotfiles on a new system, follow these steps:

### 1. **Clone the Repository**

Since this uses a **bare git repository**, we need to set it up correctly.

```sh
git clone --bare git@github.com:your-username/dotfiles.git $HOME/.dotfiles
```

### 2. **Create an Alias for Managing Dotfiles**

To avoid conflicts with other Git repositories, define an alias:

```sh
alias dotgit='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
```

Make it persistent by adding it to your shell configuration:

```sh
echo "alias dotgit='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'" >> ~/.zshrc
source ~/.zshrc
```

### 3. **Checkout the Dotfiles**

```sh
dotgit checkout
```

If you see errors about existing files, move them to a backup folder and retry:

```sh
mkdir -p ~/.dotfiles-backup
dotgit checkout 2>&1 | grep "error:" | awk '{print $2}' | xargs -I{} mv {} ~/.dotfiles-backup/{}
dotgit checkout
```

### 4. **Set Git to Ignore Untracked Files**

```sh
dotgit config --local status.showUntrackedFiles no
```

### 5. **Manually Move NixOS Configuration**

The NixOS configuration is stored in `nixos-config/` inside this repository, but it needs to be placed in `/etc/nixos`:

```sh
sudo mv $HOME/nixos-config /etc/nixos
```

If `/etc/nixos` already exists, back it up first:

```sh
sudo mv /etc/nixos /etc/nixos-backup
sudo mv $HOME/nixos-config /etc/nixos
```

### 6. **Apply NixOS Configuration (If Using NixOS)**

```sh
sudo nixos-rebuild switch
```

## Updating Dotfiles

When making changes to configurations, use:

```sh
dotgit add ~/.config/<app> ~/.zshrc
```

Commit and push changes:

```sh
dotgit commit -m "Updated config"
dotgit push origin main
```

## Pulling Updates on Another System

On a new machine, after setting up the alias, simply pull updates:

```sh
dotgit pull origin main
```

If you made changes and want to sync them back:

```sh
dotgit add ~/.config/<app>
dotgit commit -m "Updated config"
dotgit push origin main
```

## Removing a Tracked File or Folder

To stop tracking a file (without deleting it locally):

```sh
dotgit rm --cached ~/.config/waybar -r
dotgit commit -m "Removed waybar config from tracking"
dotgit push origin main
```

To completely remove it from both Git and your system:

```sh
dotgit rm -r ~/.config/waybar
dotgit commit -m "Deleted waybar config"
dotgit push origin main
```

---
