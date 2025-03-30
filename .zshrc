# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export XDG_DATA_DIRS="/run/current-system/sw/share:${XDG_DATA_DIRS}"
export GOPATH="$HOME/go"

autoload -Uz compinit
compinit -C
compinit -d ~/.cache/zsh/zcompdump7
ZSH_THEME="robbyrussell"
setopt NO_BEEP
VISUAL_BELL=true

plugins=(
    git
)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
 fi

eval "$(zoxide init zsh)"
export PATH="/Users/Sahil/.local/bin:$PATH"
export FZF_DEFAULT_OPTS='--height 40%'
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"

# Setup fzf previews
export FZF_CTRL_T_OPTS="--preview 'bat --color=always -n --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --icons=always --tree --color=always {} | head -200'"

function hs() {
    local selected_command
    if [ "$1" ]; then
        selected_command=$(fc -l 1 | grep "$1" | sed 's/^[[:space:]]*[0-9]\+[[:space:]]*//g' | fzf --tac)
    else
        selected_command=$(fc -l 1 | sed 's/^[[:space:]]*[0-9]\+[[:space:]]*//g' | fzf --tac)
    fi

    if [ -n "$selected_command" ]; then
        print -z "$selected_command"
    fi
}

function sw() {
    if [[ $# -lt 2 ]]; then
        echo "Usage: search_word_in_dir <directory_path> <search_term> [options]"
        echo "Options:"
        echo "  -i   Case-insensitive search"
        echo "  -l   Show only matching filenames"
        echo "  --exclude '*.pattern'  Exclude files matching pattern"
        echo "  --exclude-dir 'dir_name' Exclude directories"
        return 1
    fi

    local dir="$1"
    local term="$2"
    shift 2
    grep -rnw "$dir" -e "$term" "$@"
}

function gcp() {
    local commit_message="$1"
    local branch="${2:-main}"

    if [[ -z "$commit_message" ]]; then
        echo "No commit message provided. Are you sure you want to commit without a message? (y/n)"
        read -r confirm
        if [[ "$confirm" != "y" ]]; then
            echo "Commit aborted."
            return 1
        fi
        commit_message="Auto-commit"
    fi

    git add .
    git commit -m "$commit_message"
    git push origin "$branch"
}

function wifi() {
  connections=$(nmcli connection show | awk 'NR>1 {print NR-1 ": " $1}')
  if [ -z "$connections" ]; then
    echo "No connections found."
    return 1
  fi

  echo "Available connections:"
  echo "$connections"

  echo -n "Enter the number of the connection you want to connect to: "
  read connection_number

  selected_connection=$(echo "$connections" | awk -v num="$connection_number" -F": " '$1 == num {print $2}')
  if [ -z "$selected_connection" ]; then
    echo "Invalid selection. Please try again."
    return 1
  fi

  echo "Connecting to: $selected_connection"
  nmcli c up id "$selected_connection" --ask
}

eval "$(starship init zsh)"

alias nixco="zed /etc/nixos/configuration.nix"
alias nixbu="sudo nixos-rebuild switch"
alias nixgen="sudo nix-env -p /nix/var/nix/profiles/system --list-generations"
alias nixgendel="sudo nix-env -p /nix/var/nix/profiles/system --delete-generations"
alias hycon="cd ~/.config/hypr/"
alias nvcon="cd ~/.config/nvim/"
alias logout="sudo pkill -u sahil"
alias ...='cd ../../..'
alias gc="git add . && git commit -m"
alias gs="git status"
alias work="cd /mnt/Work/"
alias fman="compgen -c | fzf | xargs man"
alias nzo="~/scripts/zoxide_open_in_nvim.sh"
alias zed="zeditor"
alias btop="btop --utf-force"
alias sleep='systemctl suspend'
alias dotgit='/run/current-system/sw/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias vet=/home/sahil/go/bin/vet
alias vet-uv="/mnt/Work/Safe\ Dep/vet/vet-uv"
alias zh="zed ~/.zshrc"
