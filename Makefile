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

git-config:
	rm -rf ~/.gitconfig
	ln -s $(PWD)/gitconfig ~/.gitconfig
