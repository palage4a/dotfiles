
.PHONY: alacritty
alacritty:
	rm -rf ~/.config/alacritty
	mkdir -p ~/.config/alacritty
	ln -s $(PWD)/alacritty.toml ~/.config/alacritty/alacritty.toml

.PHONY: clangd
clangd:
	rm -rf ~/Library/Preferences/clangd;
	ln -s $(PWD)/clangd/ ~/Library/Preferences/;

.PHONY: helix
helix:
	rm -rf ~/.config/helix
	ln -s $(PWD)/helix ~/.config/helix

.PHONY: nvim
nvim:
	rm -rf ~/.config/nvim
	# git clone --depth 1 https://github.com/wbthomason/packer.nvim\
	#	~/.local/share/nvim/site/pack/packer/start/packer.nvim | true
	# ln -s $(PWD)/nvim ~/.config/nvim
	mkdir -p ~/.config/nvim
	ln -s $(PWD)/vimrc ~/.config/nvim/init.vim

fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install

.PHONY: gitconfig
gitconfig:
	rm -rf ~/.gitconfig
	ln -s $(PWD)/gitconfig ~/.gitconfig

vim:
	rm -rf ~/.vimrc
	ln -s $(PWD)/vimrc ~/.vimrc

tmux:
	rm -rf ~/.tmux.conf
	ln -s $(PWD)/tmux.conf ~/.tmux.conf

zsh:
	rm -rf ~/.oh-my-zsh
	curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh
	rm -rf ~/.zshrc
	ln -s $(PWD)/zshrc ~/.zshrc

.PHONY: scripts
scripts:
	rm -rf $(HOME)/bin/scripts
	mkdir -p $(HOME)/bin
	ln -s $(PWD)/scripts $(HOME)/bin/scripts
