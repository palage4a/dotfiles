vim-install:
	brew install ripgrep neovim -y
vim-config: 
	rm ~/.config/nvim -rf
	mkdir ~/.config/nvim
	ln -s $(PWD)/init.vim ~/.config/nvim/init.vim
vim: vim-install main-vim-config

zsh-config:
	rm ~/.config/antigen -rf
	mkdir ~/.config/antigen 
	curl -L git.io/antigen > ~/.config/antigen/antigen.zsh
	sudo chsh -s /usr/bin/zsh
	chsh -s /usr/bin/zsh
	rm ~/.zshrc -rf
	rm ~/.zprofile -rf
	ln -s $(PWD)/zprofile ~/.zprofile
	ln -s $(PWD)/zshrc ~/.zshrc
zsh-install:
	brew install zsh
zsh: zsh-install zsh-config

tmux-config:
	rm ~/.tmux.conf -rf 
	# rm ~/.tmux/plugins -rf
	# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 
	ln -s $(PWD)/tmux.conf ~/.tmux.conf 
tmux-install: 
	sudo apt install tmux -y
tmux: tmux-install tmux-config

code-config:
	mkdir "$(HOME)/Library/Application Support/Code/User" -p | true
	rm -rf "$(HOME)/Library/Application Support/Code/User/settings.json" | true
	ln -s "$(PWD)/settings.json" "$(HOME)/Library/Application Support/Code/User/settings.json" | true
	rm -rf "$(HOME)/Library/Application Support/Code/User/keybindings.json" | true
	ln -s "$(PWD)/keybindings.json" "$(HOME)/Library/Application Support/Code/User/keybindings.json" | true
