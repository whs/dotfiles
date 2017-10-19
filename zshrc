DEFAULT_USER="whs"

export ZSH=$HOME/.oh-my-zsh

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(kubectl ssh-agent aws django docker)

zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle ':completion:*' rehash true # Automatically rehash

if which brew > /dev/null 2>&1; then
	plugins+=(brew)
fi

if [[ $OSTYPE == *darwin* ]]; then
	plugins+=(osx)
fi

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export EDITOR=nano
export LD_LIBRARY_PATH=/usr/local/lib
export VAGRANT_DEFAULT_PROVIDER=virtualbox
export PATH="$HOME/bin/:$HOME/.yarn/bin:$HOME/.cargo/bin:$PATH"

alias pacman="sudo pacman"
alias bc="bc -l"

if which dnf >/dev/null; then
	alias yum="sudo dnf"
fi
alias dnf="sudo dnf"

if which ninja-build >/dev/null; then
	alias ninja=ninja-build
fi

kubens() {
	kubectl config set-context $(kubectl config current-context) --namespace=$1
}

kubectx() {
	kubectl config use-context $1
}

if which direnv > /dev/null; then
	eval "$(direnv hook zsh)"7
fi

if [ -f ~/.zshrc.local ]; then
	source ~/.zshrc.local
fi
