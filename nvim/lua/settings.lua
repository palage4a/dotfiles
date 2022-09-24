local options = {
	spelllang  = 'en_us,ru',
	langmap    = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz',
	clipboard      = "unnamed,unnamedplus",   --- Copy-paste between vim and everything else
	-- cmdheight      = 3,                       --- Give more space for displaying messages
	-- completeopt    = "menu,menuone,noselect", --- Better autocompletion
	cursorline     = true,                    --- Highlight of current line
	-- emoji          = false,                   --- Fix emoji display
	-- expandtab      = true,                    --- Use spaces instead of tabs
	-- foldcolumn     = "0",
	-- foldnestmax    = 0,
	-- foldlevel      = 99,                      --- Using ufo provider need a large value
	-- foldlevelstart = 99,                      --- Expand all folds by default
	ignorecase     = true,                    --- Needed for smartcase
	-- laststatus     = 3,                       --- Have a global statusline at the bottom instead of one for each window
	lazyredraw     = true,                    --- Makes macros faster & prevent errors in complicated mappings
	-- mouse          = "a",                     --- Enable mouse
	number     = true, --- Shows current line number
	-- pumheight      = 10,                      --- Max num of items in completion menu
	-- relativenumber = false,                    --- Enables relative number
	-- scrolloff      = 4,                       --- Always keep space when scrolling to bottom/top edge
	shiftwidth     = 4,                       --- Change a number of space characeters inseted for indentation
	showtabline    = 1,                       --- Always show tabs
	signcolumn = "yes:1", --- Add extra sign column next to line number
	smartcase      = true, --- Uses case in search
	smartindent    = true,                    --- Makes indenting smart
	smarttab       = true,                    --- Makes tabbing smarter will realize you have 2 vs 4
	splitright     = true,                    --- vertical splits will automatically be to the right
	softtabstop    = 4,                       --- Insert 2 spaces for a tab
	-- swapfile       = false,                   --- swap not needed
	tabstop        = 4,                       --- Insert 2 spaces for a tab
	termguicolors  = true,                    --- Correct terminal colors
	-- timeoutlen     = 200,                     --- Faster completion (cannot be lower than 200 because then commenting doesn't work)
	undofile       = true, --- Sets undo to file
	-- updatetime     = 100,                     --- Faster completion
	-- viminfo        = "'1000",                 --- Increase the size of file history
	-- wildignore     = "*node_modules/**",      --- Don't search inside Node.js modules (works for gutentag)
	wrap           = false,                   --- Display long lines as just one line
	writebackup    = false,                   --- Not needed
	-- omnifunc       = 'true'

	-- Neovim defaults
	autoindent     = true,                    --- Good auto indent
	backspace      = "indent,eol,start",      --- Making sure backspace works
	backup         = false,                   --- Recommended by coc
	-- conceallevel   = 0,                       --- Show `` in markdown files
	encoding       = "utf-8",                 --- The encoding displayed
	-- errorbells     = false,                   --- Disables sound effect for errors
	fileencoding   = "utf-8",                 --- The encoding written to file
	incsearch      = true,                    --- Start searching before pressing enter
	showmode       = false,                   --- Don't show things like -- INSERT -- anymore
}

local globals = {
	mapleader = ' ', --- Map leader key to SPC
	loaded = 1,
	loaded_netrwPlugin = 1,
	-- speeddating_no_mappings     = 1,          --- Disable default mappings for speeddating
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

for k, v in pairs(globals) do
	vim.g[k] = v
end

