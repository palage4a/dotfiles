vim:
	sudo apt install vim | true
	rm ~/.vimrc -f | true
	ln -s $(PWD)/vimrc ~/.vimrc | true
neovim:
	sudo apt install neovim | true
	sudo pip3 install neovim | true
	sudo npm i -g neovim | true
	rm ~/.config/nvim | true
	ln -s $(PWD)/light/init.vim ~/.config/nvim/init.vim | true

	rm ~/.config/nvim/coc-settings.json | true
	ln -s $(PWD)/coc-settings.json ~/.config/nvim/coc-settings.json | true
zsh:
	mkdir ~/.config/antigen
	curl -L git.io/antigen > ~/.config/antigen/antigen.zsh
	rm ~/.zshrc -f | true
	rm ~/.zprofile -f | true
	ln -s $(PWD)/zprofile ~/.zprofile | true
	ln -s $(PWD)/zshrc ~/.zshrc | true
kitty:
	sudo apt install kitty | true
	rm ~/.config/kitty/kitty.conf -f | true
	ln -s $(PWD)/light/kitty.conf ~/.config/kitty/kitty.conf | true
tmux:
	sudo apt install tmux | true
	rm ~/.tmux.conf -f | true
	ln -s $(PWD)/tmux.conf ~/.tmux.conf | true
	rm ~/.tmuxtheme -f | true
	ln -s $(PWD)/tmuxtheme ~/.tmuxtheme | true

doom-emacs:
	sudo apt install emacs | true
	git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d | true
	~/.emacs.d/bin/doom install | true
	rm ~/.doom.d -f | true
	ln -s $(PWD)/doom.d ~/.doom.d | true

git:
	sudo apt install git | true
	rm -rf ~/.gitconfig | true
	ln -s $(PWD)/gitconfig ~/.gitconfig | true
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
remote-machine: full-upgrade vim tmux

main-machine: remote-machine snaps git zsh doom-emacs kitty python neovim
