export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git tmux z)
source $ZSH/oh-my-zsh.sh

export TERM=xterm-256color
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin

alias gdtl="git difftool"
alias gmtl="git mergetool"

ulimit -n 10240

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/opt/llvm/bin:$PATH"

