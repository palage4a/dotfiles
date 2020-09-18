########## VIM ##############
main-vim-config:
	rm ~/.config/nvim/init.vim -rf
	ln -s $(PWD)/init.vim ~/.config/nvim/init.vim
remote-vim-config:
	mv ~/.vimrc ~/.vimrc.backup | true
	mkdir ~/bin | true
	echo 'export PATH=$$HOME/bin:$$PATH' >> ~/.profile
	ln -s $(PWD)/rg ~/bin/rg | true
	ln -s $(PWD)/init.vim ~/.vimrc | true
vim-install:
	sudo dnf install ripgrep
	sudo dnf install neovim
vim: vim-install main-vim-config




########## KITTY ##############
kitty-conf:
	rm ~/.config/kitty/kitty.conf -rf
	mkdir ~/.config/kitty | true
	ln -s $(PWD)/kitty.conf ~/.config/kitty/kitty.conf
kitty-install:
	sudo dnf install kitty
kitty:kitty-install kitty-conf


########## ZSH ##############
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


########## TMUX ##############
tmux-config:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 
	rm ~/.tmux.conf -rf 
	ln -s $(PWD)/tmux.conf ~/.tmux.conf 
	export TMUX_PLUGIN_MANAGER=$(HOME)/.tmux/plugins
	~/.tmux/plugins/tpm/bin/install_plugins
tmux-install: 
	sudo dnf install tmux
tmux: tmux-install tmux-config


########## GIT ##############
git-config:
	rm -rf ~/.gitconfig
	ln -s $(PWD)/gitconfig ~/.gitconfig
git-install:
	sudo dnf install git
git: git-install git-config


########## PYTHON 3 ##############
python:
	sudo dnf install python3
	sudo dnf install python3-pip
	sudo pip3 install pipenv


########## TELEGRAM ##############
telegram-install:
	sudo snap install telegram-desktop --classic

telegram: telegram-install
	
########## I3 ##############
i3-install:
	sudo dnf install i3 i3status rofi nitrogen dmenu
i3-config:
	rm -rf ~/.config/i3/config
	ln -s $(PWD)/i3 ~/.config/i3/config
i3: i3-install i3-config


awesome-install:
	sudo dnf install awesome
awesome-config:
	rm -rf ~/.config/awesome
	mkdir ~/.config/awesome
	ln -s $(PWD)/rc.lua ~/.config/awesome/rc.lua
awesome: awesome-install awesome-config

########## IDE'S ##############
pycharm:
	sudo snap install pycharm-professional --edge --classic
webstorm:
	sudo snap install webstorm --edge --classic
phpstorm:
	sudo snap install phpstorm --edge --classic
code:
	sudo snap install code --classic	
ides: code webstorm pycharm phpstorm


node-install:
	sudo snap install node --channel=12 --classic
node: node-install

########## DOCKER ##############
docker-install:
	sudo dnf install docker docker-compose -y
	sudo systemctl enable docker
docker-config:
	sudo groupadd docker | true
	sudo usermod -aG docker $(USER) | true
	sudo systemctl restart docker
	sudo newgrp docker | true
	sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0" | true
	sudo sed -i 's/FirewallBackend=nftables/FirewallBackend=iptables/g' /etc/firewalld/firewalld.conf | true
	sudo systemctl restart firewalld docker | true
docker: docker-install docker-config


gcc-install:
	sudo dnf install gcc-c++
gcc: gcc-install

########## SNAPD ##############
snap-install:
	sudo dnf install snapd -y | true
snap-config:
	sudo ln -s /var/lib/snapd/snap/ /snap | true
snap: snap-install snap-config


###############################
########## HIGHLEVEL ##########
###############################
remote-machine: remote-vim-config
main-machine:  git vim tmux zsh python telegram kitty snap ides docker node gcc
