fonts:
	brew tap homebrew/cask-fonts
	brew install --cask font-hack-nerd-font

vim-install:
	brew install neovim
vim-config: 
	rm -rf ~/.config/nvim 
	ln -s $(PWD)/nvim ~/.config/nvim
vim: vim-install vim-config

rg-install:
	brew install ripgrep
rg: rg-install

tmux-install:
	brew install tmux
tmux-config:
	rm -rf ~/.tmux.* ~/tmux.*
	ln -s $(PWD)/tmux/tmux.conf ~/.tmux.conf
	ln -s $(PWD)/tmux/tmux.powerline.conf ~/.tmux.powerline.conf
	ln -s $(PWD)/tmux/tmux.osx.conf ~/.tmux.osx.conf

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

code-config:
	mkdir "$(HOME)/Library/Application Support/Code/User" -p | true
	rm -rf "$(HOME)/Library/Application Support/Code/User/settings.json" | true
	rm -rf "$(HOME)/Library/Application Support/Code/User/keybindings.json" | true
	ln -s "$(PWD)/settings.json" "$(HOME)/Library/Application Support/Code/User/settings.json" | true
	ln -s "$(PWD)/keybindings.json" "$(HOME)/Library/Application Support/Code/User/keybindings.json" | true

git-config:
	rm -rf ~/.gitconfig
	ln -s $(PWD)/gitconfig ~/.gitconfig
