local options = {
	spelllang         = 'en_us,ru',
	langmap           = 'ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz',
	clipboard         = "unnamed,unnamedplus",   --- Copy-paste between vim and everything else
	completeopt       = "menu,menuone,noselect", --- Better autocompletion
	cursorline        = true,                    --- Highlight of current line
	ignorecase        = true,                    --- Needed for smartcase
	smartcase         = true,                    --- Uses case in search
	lazyredraw        = true,                    --- Makes macros faster & prevent errors in complicated mappings
	number            = true,                    --- Shows current line number
	shiftwidth        = 4,                       --- Change a number of space characeters inseted for indentation
	showtabline       = 1,                       --- Always show tabs
	smartindent       = true,                    --- Makes indenting smart
	smarttab          = true,                    --- Makes tabbing smarter will realize you have 2 vs 4
	splitright        = true,                    --- vertical splits will automatically be to the right
	softtabstop       = 4,                       --- Insert 2 spaces for a tab
	tabstop           = 4,                       --- Insert 2 spaces for a tab
	termguicolors     = true,                    --- Correct terminal colors
	undofile          = true,                    --- Sets undo to file
	wrap              = false,                   --- Display long lines as just one line
	writebackup       = false,                   --- Not needed
	autoindent        = true,                    --- Good auto indent
	backspace         = "indent,eol,start",      --- Making sure backspace works
	backup            = false,                   --- Recommended by coc
	encoding          = "utf-8",                 --- The encoding displayed

	fileencoding      = "utf-8",                 --- The encoding written to file
	incsearch         = true,                    --- Start searching before pressing enter
	showmode          = false,                   --- Don't show things like -- INSERT -- anymore
	signcolumn        = "yes:1",                 --- Add extra sign column next to line number

	title = true,
	ruler = true,
	-- laststatus = 2,  -- no need with line
	-- swapfile = false,
	-- timeoutlen = 0,

	-- autowrite = true,
	-- autoread = true,
	-- modelines=1, -- dont now what is it

	-- emoji             = false,                   --- Fix emoji display
	-- expandtab         = true,                    --- Use spaces instead of tabs
	-- foldcolumn        = "0",
	-- foldnestmax       = 0,
	-- foldlevel         = 99,                      --- Using ufo provider need a large value
	-- foldlevelstart    = 99,                      --- Expand all folds by default
	-- pumheight         = 10,                      --- Max num of items in completion menu
	-- mouse             = "a",                     --- Enable mouse
	-- relativenumber    = false,                    --- Enables relative number
	-- scrolloff         = 4,                       --- Always keep space when scrolling to bottom/top edge
	-- swapfile          = false,                   --- swap not needed
	-- timeoutlen        = 200,                     --- Faster completion (cannot be lower than 200 because then commenting doesn't work)
	-- updatetime        = 100,                     --- Faster completion
	-- viminfo           = "'1000",                 --- Increase the size of file history
	-- wildignore        = "*node_modules/**",      --- Don't search inside Node.js modules (works for gutentag)
	-- omnifunc          = 'true',
	-- conceallevel      = 0,                       --- Show `` in markdown files
	-- errorbells        = false,                   --- Disables sound effect for errors
	-- cmdheight         = 3,                       --- Give more space for displaying messages
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

-- vim.opt.path = vim.opt.path + '**'

