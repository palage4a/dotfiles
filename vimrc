filetype plugin indent on
syntax on
set laststatus=2
set path+=**
set noswapfile
set incsearch
set title
set expandtab
set tabstop=4
set shiftwidth=4
set expandtab
set hlsearch
set autoindent
set autowrite
set autoread
set number
set ruler
set ignorecase
set smartcase
set modelines=1
set timeoutlen=0

set wildignore+=*/node_modules/*
set wildignore+=*/sdk/*
set wildignore+=*/tmp/*

noremap <silent> k gk
noremap <silent> j gj
noremap <silent> 0 g0
noremap <silent> $ g$

colorscheme ron
