"Syntax
set nocompatible
syntax enable
filetype plugin on

"Fuzzy finding
set path+=**
set wildmenu

" Tags
command! MakeTags !ctags -R .

let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

set nobackup
set nowritebackup
set nowb
set noswapfile
set ttyfast
set lazyredraw
set tabstop=2
set shiftwidth=2
set expandtab
set si
set number
set hlsearch
set incsearch
set smartcase
set ignorecase
set ruler
set cursorline
set showcmd
highlight Comment ctermfg=green

set laststatus=2
set statusline=%F

let mapleader = "\<Space>"

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if empty(glob('~/.local/bin/ack'))
  silent !curl -fLo ~/.local/bin/ack --create-dirs
    \ https://beyondgrep.com/ack-v3.3.1 && chmod 0755 ~/.local/bin/ack
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree'
call plug#end()

noreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>b :Buffers<CR>

nmap j gj
nmap k gk

nmap <C-m> :NERDTreeFind<CR>
nmap <silent> <leader><leader> :NERDTreeToggle<CR>
unmap <CR>
