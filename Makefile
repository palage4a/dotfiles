vim-tmux:
	#VIM
	rm ~/.vimrc -f | true
	ln -s $(PWD)/vimrc ~/.vimrc | true
	#TMUX
	rm ~/.tmux.conf -f | true
	ln -s $(PWD)/tmux.conf ~/.tmux.conf | true
coc-i3-code:
	#COC NVIM
	rm ~/.config/nvim/coc-settings.json | true
	mkdir ~/.config/nvim | true
	ln -s $(PWD)/coc-settings.json ~/.config/nvim/coc-settings.json | true
	#I3WM
	rm ~/.Xresources -rf | true
	rm ~/.config/i3/config | true
	mkdir ~/.config/i3 | true
	ln -s $(PWD)/i3 ~/.config/i3/config | true
	ln -s $(PWD)/compton.conf ~/.config/compton/compton.conf | true
	ln -s $(PWD)/Xresources ~/.Xresources | true
	#ZSHRC
	rm ~/.zshrc -f | true
	rm ~/.zprofile -f | true
	ln -s $(PWD)/zprofile ~/.zprofile | true
	ln -s $(PWD)/zshrc ~/.zshrc | true
	#VSCODE
	rm ~/.config/Code/User/settings.json -f | true
	rm ~/.config/Code/User/keybindings.json -f | true
	mkdir ~/.config/Code/User/ -p | true
	ln -s $(PWD)/vscode/settings.json ~/.config/Code/User/settings.json | true
	ln -s $(PWD)/vscode/keybindings.json ~/.config/Code/User/keybindings.json | true
light-scheme:
	#NVIM
	rm ~/.config/nvim/init.vim -f | true
	ln -s $(PWD)/light/init.vim ~/.config/nvim/init.vim | true
	#KITTY COLOR SCHEME LIGHT
	rm ~/.config/kitty/kitty.conf -f | true
	ln -s $(PWD)/light/kitty.conf ~/.config/kitty/kitty.conf | true
dark-scheme:
	#NVIM
	rm ~/.config/nvim/init.vim -f | true
	ln -s $(PWD)/dark/init.vim ~/.config/nvim/init.vim | true
	#KITTY COLOR SCHEME LIGHT
	rm ~/.config/kitty/kitty.conf -f | true
	ln -s $(PWD)/dark/kitty.conf ~/.config/kitty/kitty.conf | true
create-new-workspace:
	sudo apt update; sudo apt full-upgrade -y | true
	sudo apt install git tmux neovim python3-pip zsh compton curl ctags scrot | true
	sudo pip3 install pipenv neovim
	ln -s $(PWD)/gitconfig ~/.gitconfig | true
	sudo snap install code --classic | true
	sudo snap install telegram-desktop --classic | true
	sudo snap install node --classic --channel 12 | true
	sudo npm i -g neovim | true
	sudo snap install ripgrep --classic | true
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions;

