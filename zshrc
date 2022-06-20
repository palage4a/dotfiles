export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin
export EDITOR='vim'
alias code="codium"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
