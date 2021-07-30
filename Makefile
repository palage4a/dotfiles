vim-install:
	brew install ripgrep neovim -y
vim-config: 
	rm ~/.config/nvim -rf
	mkdir ~/.config/nvim
	ln -s $(PWD)/init.vim ~/.config/nvim/init.vim
vim: vim-install main-vim-config

rg-install:
	brew install ripgrep
rg-config:
	rm -rf ~/.ripgreprc
	ln -s $(PWD)/ripgreprc ~/.ripgreprc
rg: rg-install rg-config

tmux-install:
	brew install tmux
tmux-config:
	rm -rf ~/.tmux.conf
	ln -s $(PWD)/tmux.conf ~/.tmux.conf

tmux: tmux-install tmux-config

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

code-config:
	mkdir "$(HOME)/Library/Application Support/Code/User" -p | true
	rm -rf "$(HOME)/Library/Application Support/Code/User/settings.json" | true
	ln -s "$(PWD)/settings.json" "$(HOME)/Library/Application Support/Code/User/settings.json" | true
	rm -rf "$(HOME)/Library/Application Support/Code/User/keybindings.json" | true
	ln -s "$(PWD)/keybindings.json" "$(HOME)/Library/Application Support/Code/User/keybindings.json" | true
