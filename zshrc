source ~/.config/antigen/antigen.zsh
# Load the oh-my-zsh's library.
antigen use oh-my-zsh
# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle z
antigen bundle git
antigen bundle tmux
antigen bundle npm
antigen bundle extract
antigen bundle docker
antigen bundle command-not-found
# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle pawel-slowik/zsh-term-title
# Load the theme.
antigen theme amuse
# Tell Antigen that you're done.
antigen apply

export PATH=/snap/bin:$HOME/bin:$PATH

alias pw="poweroff"
alias vim="gvim -v"

export EDITOR='vim'

# FOR NPM
NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$PATH:$NPM_PACKAGES/bin"
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
