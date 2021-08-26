fonts:
	brew tap homebrew/cask-fonts
	brew install --cask font-hack-nerd-font

nvim: 
	rm -rf ~/.config/nvim 
	ln -s $(PWD)/nvim ~/.config/nvim

fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install

vim:
	rm -rf ~/.vimrc
	ln -s $(PWD)/vimrc ~/.vimrc
tmux:
	rm -rf ~/.tmux.conf
	ln -s $(PWD)/tmux.conf ~/.tmux.conf

zsh:
	rm -rf ~/.config/antigen ~/.zshrc ~/.zprofile
	mkdir ~/.config/antigen 
	curl -L git.io/antigen > ~/.config/antigen/antigen.zsh
	ln -s $(PWD)/zprofile ~/.zprofile
	ln -s $(PWD)/zshrc ~/.zshrc

git:
	rm -rf ~/.gitconfig
	ln -s $(PWD)/gitconfig.nvim ~/.gitconfig

code:
	mkdir -p "$(HOME)/Library/Applicasion Support/Code/User" | true
	rm -rf "$(HOME)/Library/Application Support/Code/User/settings.json" "$(HOME)/Library/Application Support/Code/User/keybindings.json" | true
	ln -s "$(PWD)/settings.json" "$(HOME)/Library/Application Support/Code/User/settings.json" | true
	ln -s "$(PWD)/keybindings.json" "$(HOME)/Library/Application Support/Code/User/keybindings.json" | true
	rm -rf ~/.gitconfig
	ln -s $(PWD)/gitconfig.code ~/.gitconfig
