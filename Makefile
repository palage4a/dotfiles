main-vim-config:
	rm ~/.config/nvim/init.vim -rf
	ln -s $(PWD)/init.vim ~/.config/nvim/init.vim
remote-vim-config:
	mv ~/.vimrc ~/.vimrc.backup
	mkdir ~/bin
	echo 'export PATH=$$HOME/bin:$$PATH' >> ~/.profile
	ln -s $(PWD)/rg ~/bin/rg
	ln -s $(PWD)/init.vim ~/.vimrc
vim-install:
	sudo dnf install neovim
vim: vim-install main-vim-config





kitty-conf:
	rm ~/.config/kitty/kitty.conf -rf
	mkdir ~/.config/kitty | true
	ln -s $(PWD)/kitty.conf ~/.config/kitty/kitty.conf
kitty-install:
	sudo dnf install kitty
kitty:kitty-install kitty-conf


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
	sudo snap install code --classic
vscode: vscode-install




tmux-config:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 
	rm ~/.tmux.conf -rf 
	ln -s $(PWD)/tmux.conf ~/.tmux.conf 
	export TMUX_PLUGIN_MANAGER=$(HOME)/.tmux/plugins
	~/.tmux/plugins/tpm/bin/install_plugins
tmux-install: 
	sudo dnf install tmux
tmux: tmux-install tmux-config









git-config:
	rm -rf ~/.gitconfig
	ln -s $(PWD)/gitconfig ~/.gitconfig
git-install:
	sudo dnf install git
git: git-install git-config




python:
	sudo dnf install python3
	sudo dnf install python3-pip
	sudo pip3 install pipenv



telegram-install:
	sudo dnf install telegram-desktop

telegram: telegram-install
	

pycharm:
	sudo snap install pycharm-professional --edge --classic
webstorm:
	sudo snap install webstorm --edge --classic
phpstorm:
	sudo snap install phpstorm --edge --classic
ides: webstorm pycharm phpstorm


docker-install:
	sudo dnf install docker docker-compose -y
docker-config:
	sudo groupadd docker | true
	sudo usermod -aG docker $(USER) | true
	sudo newgrp docker | true
docker: docker-install docker-config



snap-install:
	sudo dnf install snapd -y | true
snap-config:
	sudo ln -s /var/lib/snapd/snap/ /snap | true
snap: snap-install snap-config


# HIGH-LEVEL INSTALL
remote-machine: remote-vim-config
main-machine:  git vim tmux zsh python telegram vscode kitty snap ides docker
