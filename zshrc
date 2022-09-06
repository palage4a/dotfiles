export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git tmux)
source $ZSH/oh-my-zsh.sh

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin

export VISUAL=vim
export EDITOR="$VISUAL"

alias code="codium"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
