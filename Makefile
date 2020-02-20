install:
	ln -s $(PWD)/vimrc ~/.vimrc | true
	ln -s $(PWD)/init.vim ~/.config/nvim/init.vim | true
	ln -s $(PWD)/kitty.conf ~/.config/kitty/kitty.conf | true
	ln -s $(PWD)/coc-settings.json ~/.config/nvim/coc-settings.json | true
	ln -s $(PWD)/snippets ~/.vim/ | true
	ln -s $(PWD)/tmux.conf ~/.tmux.conf | true
	ln -s $(PWD)/i3 ~/.config/i3/config | true
