main-vim-config:
	rm ~/.vimrc -rf
	ln -s $(PWD)/init.vim ~/.vimrc
remote-vim-config:
	mv ~/.vimrc ~/.vimrc.backup
	echo 'export PATH=$$HOME/bin:$$PATH' >> ~/.profile
	ln -s $(PWD)/rg ~/bin/rg
	ln -s $(PWD)/init.vim ~/.vimrc
vim-install:
	sudo apt install vim-gtk3






vim: vim-install main-vim-config

zsh-config:
	rm ~/.zshrc -rf
	rm ~/.zprofile -rf
	ln -s $(PWD)/zprofile ~/.zprofile
	ln -s $(PWD)/zshrc ~/.zshrc
zsh-install:
	sudo apt install zsh 
	mkdir ~/.config/antigen 
	curl -L git.io/antigen > ~/.config/antigen/antigen.zsh 
zsh: zsh-install zsh-config






tmux-config:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 
	rm ~/.tmux.conf -rf 
	ln -s $(PWD)/tmux.conf ~/.tmux.conf 
tmux-install: 
	sudo apt install tmux
tmux: tmux-install tmux-config





chrome-install:
	curl -sSL https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - \
		&& echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list \
		&& sudo apt update \
		&& sudo apt install google-chrome-stable \
		&& true
chrome: chrome-install




vscode-install:
	curl -sSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \
		&& sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/ \
		&& sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' \
		&& sudo apt install apt-transport-https \
		&& sudo apt update \
		&& sudo apt install code \
		&& true
vscode: vscode-install


git-install:
	sudo apt install git
git-config:
	rm -rf ~/.gitconfig
	ln -s $(PWD)/gitconfig ~/.gitconfig
git: git-install git-config




full-upgrade:
	sudo apt update; sudo apt full-upgrade -y





python:
	sudo apt install python3
	sudo apt install python3-pip
	sudo pip3 install pipenv


telegram-install:
	sudo apt install telegram-desktop

telegram: telegram-install



# HIGH-LEVEL INSTALL
remote-machine: remote-vim-config
main-machine:  vim tmux zsh git python chrome vscode
