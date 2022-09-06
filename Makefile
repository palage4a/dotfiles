fonts:
	brew tap homebrew/cask-fonts
	brew install --cask font-hack-nerd-font

.PHONY: nvim
nvim:
	rm -rf ~/.config/nvim
	ln -s $(PWD)/nvim ~/.config/nvim
fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
vim:
	rm -rf ~/.vimrc
	ln -s $(PWD)/vimrc ~/.vimrc
	rm -rf ~/.gitconfig
	ln -s $(PWD)/gitconfig.vim ~/.gitconfig
tmux:
	rm -rf ~/.tmux.conf
	ln -s $(PWD)/tmux.conf ~/.tmux.conf
zsh:
	rm -rf ~/.oh-my-zsh
	curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh
	rm -rf ~/.zshrc
	ln -s $(PWD)/zshrc ~/.zshrc
code:
	mkdir -p "$(HOME)/Library/Applicasion Support/VSCodium/User" | true
	rm -rf "$(HOME)/Library/Application Support/VSCodium/User/settings.json" "$(HOME)/Library/Application Support/VSCodium/User/keybindings.json" | true
	ln -s "$(PWD)/settings.json" "$(HOME)/Library/Application Support/VSCodium/User/settings.json" | true
	ln -s "$(PWD)/keybindings.json" "$(HOME)/Library/Application Support/VSCodium/User/keybindings.json" | true
	ln -s "$(PWD)/snippets" "$(HOME)/Library/Application Support/VSCodium/User/snippets" | true
	rm -rf ~/.gitconfig
	ln -s $(PWD)/gitconfig.codium ~/.gitconfig
