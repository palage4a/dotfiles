########## VIM ##############
main-vim-config:
	rm ~/.config/nvim -rf
	mkdir ~/.config/nvim
	ln -s $(PWD)/init.vim ~/.config/nvim/init.vim
remote-vim-config:
	mv ~/.vimrc ~/.vimrc.backup | true
	mkdir ~/bin | true
	echo 'export PATH=$$HOME/bin:$$PATH' >> ~/.profile
	ln -s $(PWD)/rg ~/bin/rg | true
	ln -s $(PWD)/init.vim ~/.vimrc | true
vim-install:
	sudo apt install ripgrep
	sudo apt install neovim
vim: vim-install main-vim-config




########## KITTY ##############
kitty-conf:
	rm ~/.config/kitty/kitty.conf -rf
	mkdir ~/.config/kitty | true
	ln -s $(PWD)/kitty.conf ~/.config/kitty/kitty.conf
kitty-install:
	sudo apt install kitty
kitty:kitty-install kitty-conf


########## ZSH ##############
zsh-config:
	rm ~/.zshrc -rf
	rm ~/.zprofile -rf
	ln -s $(PWD)/zprofile ~/.zprofile
	ln -s $(PWD)/zshrc ~/.zshrc
zsh-install:
	sudo apt install zsh 
	rm ~/.config/antigen -rf
	mkdir ~/.config/antigen 
	curl -L git.io/antigen > ~/.config/antigen/antigen.zsh
	sudo chsh -s /usr/bin/zsh
zsh: zsh-install zsh-config


########## TMUX ##############
tmux-config:
	rm ~/.tmux.conf -rf 
	rm ~/.tmux/plugins -rf
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 
	ln -s $(PWD)/tmux.conf ~/.tmux.conf 
	export TMUX_PLUGIN_MANAGER=$(HOME)/.tmux/plugins
	~/.tmux/plugins/tpm/bin/install_plugins
tmux-install: 
	sudo apt install tmux
tmux: tmux-install tmux-config


########## GIT ##############
git-config:
	rm -rf ~/.gitconfig
	ln -s $(PWD)/gitconfig ~/.gitconfig
git-install:
	sudo apt install git
git: git-install git-config


########## PYTHON 3 ##############
python:
	sudo apt install python3
	sudo apt install python3-pip
	sudo pip3 install pipenv

######### GO ###########
########## TELEGRAM ##############
telegram-install:
	sudo snap install telegram-desktop --classic

telegram: telegram-install
	
########## I3 ##############
i3-install:
	sudo apt install i3 i3status rofi nitrogen dmenu
i3-config:
	rm -rf ~/.config/i3/config
	ln -s $(PWD)/i3 ~/.config/i3/config
i3: i3-install i3-config


awesome-install:
	sudo apt install awesome
awesome-config:
	rm -rf ~/.config/awesome
	mkdir ~/.config/awesome
	ln -s $(PWD)/rc.lua ~/.config/awesome/rc.lua
awesome: awesome-install awesome-config


chrome:
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
	sudo apt update
	sudo apt install google-chrome-stable

code:
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
	sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
	sudo apt install apt-transport-https
	sudo apt update
	sudo apt install code # or code-insiders


########## TOOLLBOX ##############
toolbox:
	./jetbrains-toolbox.sh
	jetbrains-toolbox


node-install:
	sudo snap install node --channel=12 --classic
node: node-install

########## DOCKER ##############
docker-install:
	sudo apt-get remove docker docker-engine docker.io containerd runc | true
	sudo apt-get install \
		apt-transport-https \
		ca-certificates \
		curl \
		gnupg-agent \
		software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo apt-key fingerprint 0EBFCD88
	sudo add-apt-repository \
   		"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   		$(lsb_release -cs) \
   		stable"
	sudo apt-get update
	sudo apt-get install docker-ce docker-ce-cli containerd.io docker.io
	sudo apt install docker-compose -y
	
docker-config:
	sudo groupadd docker
	sudo usermod -aG docker $USER
	sudo newgrp docker
	docker run hello-world
	sudo systemctl enable docker
docker: docker-install docker-config


gcc-install:
	sudo apt install gcc-c++
gcc: gcc-install

########## SNAPD ##############
snap-install:
	sudo apt install snapd -y | true
snap-config:
	sudo ln -s /var/lib/snapd/snap/ /snap | true
snap: snap-install snap-config

####### PRE ######
pre:
	sudo apt install curl
###############################
########## HIGHLEVEL ##########
###############################
remote-machine: remote-vim-config
main-machine:  pre git vim zsh python telegram code chrome snap docker node gcc
