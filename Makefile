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
	sudo apt install ripgrep neovim -y
vim: vim-install main-vim-config


########## KITTY ##############
kitty-conf:
	rm ~/.config/kitty/kitty.conf -rf
	mkdir ~/.config/kitty | true
	ln -s $(PWD)/kitty.conf ~/.config/kitty/kitty.conf
kitty-install:
	sudo apt install kitty -y
kitty:kitty-install kitty-conf


########## ZSH ##############
zsh-config:
	rm ~/.zshrc -rf
	rm ~/.zprofile -rf
	ln -s $(PWD)/zprofile ~/.zprofile
	ln -s $(PWD)/zshrc ~/.zshrc
zsh-install:
	sudo apt install zsh -y
	rm ~/.config/antigen -rf
	mkdir ~/.config/antigen 
	curl -L git.io/antigen > ~/.config/antigen/antigen.zsh
	sudo chsh -s /usr/bin/zsh
	chsh -s /usr/bin/zsh
zsh: zsh-install zsh-config


########## TMUX ##############
tmux-config:
	rm ~/.tmux.conf -rf 
	# rm ~/.tmux/plugins -rf
	# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 
	ln -s $(PWD)/tmux.conf ~/.tmux.conf 
tmux-install: 
	sudo apt install tmux -y
tmux: tmux-install tmux-config


########## GIT ##############
git-config:
	rm -rf ~/.gitconfig
	ln -s $(PWD)/gitconfig ~/.gitconfig
git-install:
	sudo apt install git -y
git: git-install git-config


########## PYTHON 3 ##############
python:
	sudo apt install python3 python3-pip -y
	sudo pip3 install pipenv

########## TELEGRAM ##############
telegram-install:
	sudo snap install telegram-desktop --classic

telegram: telegram-install
	
########## I3 ##############
i3-install:
	sudo apt install i3 i3status rofi nitrogen dmenu -y
i3-config:
	rm -rf ~/.config/i3/config
	ln -s $(PWD)/i3 ~/.config/i3/config
i3: i3-install i3-config

########## AWESOME WM ##############
awesome-install:
	sudo apt install awesome -y
awesome-config:
	rm -rf ~/.config/awesome
	mkdir ~/.config/awesome
	ln -s $(PWD)/rc.lua ~/.config/awesome/rc.lua
awesome: awesome-install awesome-config

########## GOOGLE CRHOME ##############
chrome:
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
	sudo apt update
	sudo apt install google-chrome-stable -y

########## VS CODE ##############
code:
	wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
	sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
	sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
	sudo apt install apt-transport-https
	sudo apt update
	sudo apt install code -y # or code-insiders


########## TOOLLBOX ##############
toolbox:
	./jetbrains-toolbox.sh
	jetbrains-toolbox


######### NODE ####################
node-install:
	sudo snap install node --channel=14 --classic
node: node-install

########## DOCKER ##############
docker-install:
	sudo apt update -y
	sudo apt-get install -y \
			apt-transport-https \
			ca-certificates \
			curl \
			software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo apt-key fingerprint 0EBFCD88
	sudo add-apt-repository \
		 "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
		 $(lsb_release -cs) \
		 stable"
	sudo apt-get update -y
	sudo apt-get install -y docker-ce
	sudo apt-get install -y python3 python3-pip
	sudo pip3 install docker-compose
docker-config:
	sudo groupadd docker | true
	sudo usermod -aG docker $(USER) | true
	sudo newgrp docker | true
	docker run hello-world
	sudo systemctl enable docker | true
docker: docker-install docker-config


###### GCC #######
gcc-install:
	sudo apt install gcc -y
gcc: gcc-install

########## SNAPD ##############
snap-install:
	sudo apt install snapd -y | true
snap-config:
	sudo ln -s /var/lib/snapd/snap/ /snap | true
snap: snap-install snap-config

####### PRE ######
pre:
	sudo apt install curl -y
	xrandr --output eDP-1 --scale 0.75x0.75
	# touch ~/.config/kwinrc | true
	# sed -i 's/BorderlessMaximizedWindows=false/BorderlessMaximizedWindows=true/g' ~/.config/kwinrc | true
	### need run `kwin --replace` from krunner
custom-bin:
	rm ~/bin -rf | true
	ln -s  $(PWD)/bin $(HOME)/bin | true

gestures:
	rm ~/.config/libinput-gestures.conf -rf | true
	ln -s  $(PWD)/gestures.conf $(HOME)/.config/libinput-gestures.conf | true
	
###############################
########## HIGHLEVEL ##########
###############################
remote-machine: remote-vim-config
main-machine:  pre git vim zsh python telegram code chrome snap docker node gcc toolbox tmux kitty
windows: vim tmux
