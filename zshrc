source ~/.zplug/zplug

export LANG=en_US.UTF-8
export EDITOR=nano
DEFAULT_USER="whs"

alias pacman="sudo pacman"

if which dnf >/dev/null; then
	alias yum="sudo dnf"
fi
alias dnf="sudo dnf"

if which ninja-build >/dev/null; then
	alias ninja=ninja-build
fi

zplug "themes/agnoster", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/ssh-agent", from:oh-my-zsh
zplug "plugins/sublime", from:oh-my-zsh
zstyle :omz:plugins:ssh-agent agent-forwarding on
zplug "plugins/archlinux", from:oh-my-zsh, if: "which pacman"
zplug "plugins/brew", from:oh-my-zsh, if: "which brew"
zplug "plugins/osx", from:oh-my-zsh, if: "[[ $OSTYPE == *darwin* ]]"

# Automatically rehash
zstyle ':completion:*' rehash true

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load
