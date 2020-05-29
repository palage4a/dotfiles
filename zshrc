# If you come from bash you might have to change your $PATH.
export PATH=$HOME/go/bin:$HOME/.local/go/bin:/snap/bin:$HOME/bin:$PATH
source ~/.config/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle z
antigen bundle git
antigen bundle tmux
antigen bundle npm
antigen bundle extract
antigen bundle command-not-found

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle g-plane/zsh-yarn-autocompletions

# Load the theme.
antigen theme amuse

# Tell Antigen that you're done.
antigen apply

export EDITOR='nvim'
alias vim=nvim
alias pw="poweroff"

# FOR NPM
NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$PATH:$NPM_PACKAGES/bin"
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ivan/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ivan/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ivan/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ivan/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

