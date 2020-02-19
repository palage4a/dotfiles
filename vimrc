set nobackup
set nowritebackup
set noswapfile
set tabstop=2
set shiftwidth=2
set expandtab
set si
set number
set hlsearch
set incsearch
set smartcase
set ignorecase
highlight Comment ctermfg=green

set statusline=%F
set nocompatible
syntax enable
filetype plugin on
set path+=**
set wildmenu
set fileencodings=utf-8,cp1251
if !has('nvim')
    if !isdirectory($HOME . "/.local/vim/undo")
        call mkdir($HOME . "/.local/vim/undo", "p", 0700)
    endif
    set undodir=~/.local/vim/undo
endif
set undofile
