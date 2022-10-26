vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.list = true
vim.opt.scrolloff = 25
vim.opt.colorcolumn = 80

-- TODO: rewrite in lua
vim.cmd [[autocmd FileType c,cpp,java,php,lua,md,typescript,javascript,python autocmd BufWritePre <buffer> %s/\s\+$//e]]

