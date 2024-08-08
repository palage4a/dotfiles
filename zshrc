export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git z)
source $ZSH/oh-my-zsh.sh

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin

alias gdtl="git difftool"
alias gmtl="git mergetool"

ulimit -n 10240

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/bin:$PATH"

export PATH="$HOME/Library/Python/3.9/bin:$PATH"

export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/opt/ruby@3.0/bin:$PATH"
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export PATH="/usr/local/opt/openjdk/bin:$PATH"
export CPPFLAGS="-I/usr/local/opt/openjdk/include"
export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"

export PATH="$PATH:$HOME/sdk/macos/current"
export VISUAL=nvim
export EDITOR="$VISUAL"

export PATH="$PATH:$HOME/bin/scripts"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
