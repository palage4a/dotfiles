main-vim-config:
	rm ~/.vimrc -rf
	ln -s $(PWD)/init.vim ~/.vimrc
remote-vim-config:
	mv ~/.vimrc ~/.vimrc.backup
	echo 'export PATH=$$HOME/bin:$$PATH' >> ~/.profile
	ln -s $(PWD)/rg ~/bin/rg
	ln -s $(PWD)/init.vim ~/.vimrc
vim-install:
	sudo dnf install gvim





kitty-conf:
	rm ~/.config/kitty/kitty.conf -rf
	ln -s $(PWD)/kitty.conf ~/.config/kitty/kitty.conf

kitty-install:
	sudo dnf install kityy
kitty:kitty-install kitty-conf

vim: vim-install main-vim-config

zsh-config:
	rm ~/.zshrc -rf
	rm ~/.zprofile -rf
	ln -s $(PWD)/zprofile ~/.zprofile
	ln -s $(PWD)/zshrc ~/.zshrc
zsh-install:
	sudo dnf install zsh 
	mkdir ~/.config/antigen 
	curl -L git.io/antigen > ~/.config/antigen/antigen.zsh 
zsh: zsh-install zsh-config



vscode-install:
	sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
	sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
	sudo dnf install code
vscode: vscode-install




tmux-config:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 
	rm ~/.tmux.conf -rf 
	ln -s $(PWD)/tmux.conf ~/.tmux.conf 
tmux-install: 
	sudo dnf install tmux
tmux: tmux-install tmux-config









git-install:
	sudo dnf install git
git-config:
	rm -rf ~/.gitconfig
	ln -s $(PWD)/gitconfig ~/.gitconfig
git: git-install git-config




full-upgrade:
	sudo apt update; sudo apt full-upgrade -y





python:
	sudo dnf install python3
	sudo dnf install python3-pip
	sudo pip3 install pipenv


telegram-install:
	sudo dnf install telegram-desktop

telegram: telegram-install



# HIGH-LEVEL INSTALL
remote-machine: remote-vim-config
main-machine:  vim tmux zsh git python telegram-desktop
