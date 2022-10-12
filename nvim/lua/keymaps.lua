-- telescope
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<space>ff', builtin.find_files, {})
vim.keymap.set('n', '<space>fr', builtin.live_grep, {})
vim.keymap.set('n', '<space>fb', builtin.buffers, {})
vim.keymap.set('n', '<space>fh', builtin.help_tags, {})
vim.keymap.set('n', '<space>gc', builtin.git_commits, {})
