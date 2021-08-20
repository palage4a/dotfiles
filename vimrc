scriptencoding utf-8

set nocompatible
set number
set fileencodings=utf-8,latin
set encoding=utf-8
set title
set autoindent
set nobackup
set hlsearch
set incsearch
set cmdheight=1
set laststatus=2
set expandtab
"let loaded_matchparen = 1
set shell=zsh
set backupskip=/tmp/*,/private/tmp/*

set nosc noru
" Don't redraw while executing macros (good performance config)
set lazyredraw
set showmatch
" How many tenths of a second to blink when matching brackets
"set mat=2
" Ignore case when searching
set ignorecase
" Be smart when using tabs ;)
set smarttab
"
" indents
filetype plugin indent on
set shiftwidth=2
set tabstop=2
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
set backspace=start,eol,indent
" Finding files - Search down into subfolders
set path+=**
set wildignore+=*/node_modules/*

" JavaScript
au BufNewFile,BufRead *.es6 setf javascript
" TypeScript
au BufNewFile,BufRead *.tsx setf typescriptreact
" Markdown
au BufNewFile,BufRead *.md set filetype=markdown
" Flow
au BufNewFile,BufRead *.flow set filetype=javascript
" Golang
au BufNewFile,BufRead *.go set filetype=go
" Python
au BufNewFile,BufRead *.py set filetype=python

nnoremap j gj
nnoremap k gk

syntax enable
set termguicolors
set background=dark
