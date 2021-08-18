fonts:
	brew tap homebrew/cask-fonts
	brew install --cask font-hack-nerd-font

nvim-install:
	brew install neovim
nvim-config: 
	rm -rf ~/.config/nvim 
	ln -s $(PWD)/nvim ~/.config/nvim
nvim: nvim-install nvim-config

vim-install:
	brew install vim
vim-config:
	rm -rf ~/.vimrc
	ln -s $(PWD)/vimrc ~/.vimrc
vim: vim-install vim-config

tmux-install:
	brew install tmux
tmux-config:
	rm -rf ~/.tmux.conf
	ln -s $(PWD)/tmux.conf ~/.tmux.conf
tmux: tmux-install tmux-config

zsh-config:
	rm -rf ~/.config/antigen ~/.zshrc ~/.zprofile
	mkdir ~/.config/antigen 
	curl -L git.io/antigen > ~/.config/antigen/antigen.zsh
	ln -s $(PWD)/zprofile ~/.zprofile
	ln -s $(PWD)/zshrc ~/.zshrc
zsh-install:
	brew install zsh
zsh: zsh-install zsh-config

git-config:
	rm -rf ~/.gitconfig
	ln -s $(PWD)/gitconfig ~/.gitconfig

code-config:
	rm -rf "$(HOME)/Library/Application Support/Code/User/settings.json" "$(HOME)/Library/Application Support/Code/User/keybindings.json" | true
	mkdir "$(HOME)/Library/Application Support/Code/User" -p | true
	ln -s "$(PWD)/settings.json" "$(HOME)/Library/Application Support/Code/User/settings.json" | true
	ln -s "$(PWD)/keybindings.json" "$(HOME)/Library/Application Support/Code/User/keybindings.json" | true
