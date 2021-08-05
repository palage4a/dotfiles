if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

Plug 'tpope/vim-fugitive'
Plug 'cohama/lexima.vim'

if has("nvim")
  Plug 'hoob3rt/lualine.nvim'
  Plug 'kristijanhusak/defx-git'
  Plug 'kristijanhusak/defx-icons'
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'neovim/nvim-lspconfig'
  Plug 'glepnir/lspsaga.nvim'
  Plug 'folke/lsp-colors.nvim'
  Plug 'nvim-lua/completion-nvim'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'nvim-lua/popup.nvim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nanotech/jellybeans.vim'
endif

call plug#end()

