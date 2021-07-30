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

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

export DOCKER_CLIENT_TIMEOUT=120
export COMPOSE_HTTP_TIMEOUT=120

alias vim=nvim

vimft() {
    vim -c "set ft=$1"
}

export EDITOR='nvim'

# FOR NPM
NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$PATH:$NPM_PACKAGES/bin"
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/palage4a/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/palage4a/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/palage4a/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/palage4a/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
