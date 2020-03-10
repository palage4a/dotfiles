portable:
	#VIM
	ln -s $(PWD)/vimrc ~/.vimrc | true
	#TMUX
	ln -s $(PWD)/tmux.conf ~/.tmux.conf | true
full:
	#VIM
	ln -s $(PWD)/vimrc ~/.vimrc | true
	#NVIM
	ln -s $(PWD)/init.vim ~/.config/nvim/init.vim | true
	ln -s $(PWD)/coc-settings.json ~/.config/nvim/coc-settings.json | true
	#KITTY COLOR SCHEME
	ln -s $(PWD)/kitty.conf ~/.config/kitty/kitty.conf | true
	#TMUX
	ln -s $(PWD)/tmux.conf ~/.tmux.conf | true
	#I3WM
	ln -s $(PWD)/i3 ~/.config/i3/config | true
	ln -s $(PWD)/compton.con ~/.config/compton/compton.conf | true
	#ZSHRC
	ln -s $(PWD)/zprofile ~/.zprofile | true
	ln -s $(PWD)/zshrc ~/.zshrc | true
	#VSCODE
	ln -s $(PWD)/vscode/settings.json ~/.config/Code/User/settings.json | true
	ln -s $(PWD)/vscode/keybindings.json ~/.config/Code/User/keybindings.json | true
