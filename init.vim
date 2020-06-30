setglobal nocompatible
setglobal pastetoggle=<F2>

if has('nvim')
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
      silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
else
    set t_Co=256
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif

call plug#begin('~/.vim/plugged')
  Plug 'scrooloose/nerdtree'
  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'sheerun/vim-polyglot'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-commentary'
  Plug 'jiangmiao/auto-pairs'
  Plug 'junegunn/fzf', { 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  let g:airline#extensions#tabline#enabled = 1
call plug#end()
colorscheme dracula

let mapleader = "\<space>"
nmap <leader><leader> :NERDTreeToggle<CR>
let g:fzf_preview_window = ''
"
" FZF
nnoremap <silent> <leader>ff  :GitFiles<CR>
nnoremap <silent> <leader>fg  :Files<CR>
nnoremap <silent> <leader>ft  :Filetypes<CR>
nnoremap <silent> <leader>fb  :Buffers<CR>
nnoremap <silent> <leader>fc  :Commands<CR>

"RG
nnoremap <silent> <leader>rw  :Rg <C-r><C-w><CR>
nnoremap <silent> <leader>rr  :Rg<CR>
nnoremap <silent> <leader>r'  :Rg<CR>'

set hidden
set number
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
set timeoutlen=1000 
set ttimeoutlen=0
set nobackup
set nowritebackup
set noswapfile
set tabstop=4
set shiftwidth=4
set expandtab
set si
set number
set hlsearch
set incsearch
set smartcase
set ignorecase
set noundofile

syntax enable
filetype plugin on
set path=**
set wildmenu
set fileencodings=utf-8,cp1251
set wrap
set magic
set mouse=a
