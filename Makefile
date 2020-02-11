install:
	ln -s $(PWD)/vimrc ~/.vimrc | true
	ln -s $(PWD)/init.vim ~/.config/nvim/init.vim | true
	ln -s $(PWD)/snippets ~/.vim/ | true
	ln -s $(PWD)/tmux.conf ~/.tmux.conf | true
	ln -s $(PWD)/i3 ~/.config/i3/config | true
