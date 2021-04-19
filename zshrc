source ~/.config/antigen/antigen.zsh
# Load the oh-my-zsh's library.
antigen use oh-my-zsh
# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle z
antigen bundle zmv
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
antigen theme robbyrussell
# Tell Antigen that you're done.
antigen apply

export PATH=/snap/bin:$HOME/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

alias pw="poweroff"
alias vi="nvim -u ~/.clean.vim" 

vimft() {
    vim -c "set ft=$1"
}

export EDITOR='nvim'

# FOR NPM
NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$PATH:$NPM_PACKAGES/bin"
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
