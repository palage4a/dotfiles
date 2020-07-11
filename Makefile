main-vim-config:
	rm ~/.vimrc -rf
	ln -s $(PWD)/init.vim ~/.vimrc
remote-vim-config:
	mv ~/.vimrc ~/.vimrc.backup
	echo 'export PATH=$$HOME/bin:$$PATH' >> ~/.profile
	ln -s $(PWD)/rg ~/bin/rg
	ln -s $(PWD)/init.vim ~/.vimrc
vim-install:
	sudo apt install vim-gtk3






vim: vim-install main-vim-config

zsh-config:
	rm ~/.zshrc -rf
	rm ~/.zprofile -rf
	ln -s $(PWD)/zprofile ~/.zprofile
	ln -s $(PWD)/zshrc ~/.zshrc
zsh-install:
	sudo apt install zsh 
	mkdir ~/.config/antigen 
	curl -L git.io/antigen > ~/.config/antigen/antigen.zsh 
zsh: zsh-install zsh-config






tmux-config:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 
	rm ~/.tmux.conf -rf 
	ln -s $(PWD)/tmux.conf ~/.tmux.conf 
tmux-install: 
	sudo apt install tmux
tmux: tmux-install tmux-config










git-install:
	sudo apt install git
git-config:
	rm -rf ~/.gitconfig
	ln -s $(PWD)/gitconfig ~/.gitconfig
git: git-install git-config




full-upgrade:
	sudo apt update; sudo apt full-upgrade -y





python:
	sudo apt install python3
	sudo apt install python3-pip
	sudo pip3 install pipenv




snaps:
	sudo snap install node --classic --channel 12
	sudo snap install code --classic
	sudo snap install telegram-desktop --classic
	sudo snap install ripgrep --classic




# HIGH-LEVEL INSTALL
remote-machine: remote-vim-config
main-machine:  vim tmux zsh git python snaps
