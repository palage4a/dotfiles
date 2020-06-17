vim-config:
	mv ~/.vimrc ~/.vimrc.backup | true
	echo 'export PATH=$$HOME/bin:$$PATH' >> ~/.profile
	ln -s $(PWD)/rg ~/bin/rg | true
	ln -s $(PWD)/init.vim ~/.vimrc | true

neovim-config:
	rm ~/.config/nvim/init.vim -f | true
	rm ~/.config/nvim/coc-settings.json -f | true
	ln -s $(PWD)/init.vim ~/.config/nvim/init.vim | true
	ln -s $(PWD)/coc-settings.json ~/.config/nvim/coc-settings.json | true
neovim-install:
	sudo apt install neovim | true
	sudo pip3 install neovim | true
	sudo npm i -g neovim | true
neovim: neovim-install neovim-config

zsh-config:
	rm ~/.zshrc -rf | true
	rm ~/.zprofile -rf | true
	ln -s $(PWD)/zprofile ~/.zprofile | true
	ln -s $(PWD)/zshrc ~/.zshrc | true
zsh-install:
	sudo apt install zsh
	mkdir ~/.config/antigen
	curl -L git.io/antigen > ~/.config/antigen/antigen.zsh
zsh: zsh-install zsh-config

kitty-config:
	rm ~/.config/kitty/kitty.conf -rf | true
	ln -s $(PWD)/kitty.conf ~/.config/kitty/kitty.conf | true
kitty-intall:
	sudo apt install kitty
kitty: kitty-install kitty-config

tmux-config:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	rm ~/.tmux.conf -rf
	ln -s $(PWD)/tmux.conf ~/.tmux.conf
tmux-install: 
	sudo apt install tmux | true
tmux: tmux-install tmux-config

git-install:
	sudo apt install git | true
git-config:
	rm -rf ~/.gitconfig | true
	ln -s $(PWD)/gitconfig ~/.gitconfig | true
git: git-install git-config

full-upgrade:
	sudo apt update; sudo apt full-upgrade -y | true
python:
	sudo apt install python3 | true
	sudo apt install python3-pip | true
	sudo pip3 install pipenv | true
snaps:
	sudo snap install node --classic --channel 12 | true
	sudo snap install code --classic | true
	sudo snap install telegram-desktop --classic | true
	sudo snap install ripgrep --classic | true

# HIGH-LEVEL INSTALL
remote-machine: vim-config
main-machine: neovim tmux snaps git zsh doom-emacs kitty python neovim
