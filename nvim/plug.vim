" Install vim-plug if not found
let data_dir = stdpath('data') . '/site'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:plug_home = stdpath('data') . '/plugged'

call plug#begin()

Plug 'tpope/vim-fugitive'
Plug 'cohama/lexima.vim'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'hoob3rt/lualine.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

