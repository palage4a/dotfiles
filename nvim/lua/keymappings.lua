local bind = vim.keymap.set
local opts = { silent = true, noremap = true }

bind("n", "k", "gk", opts)
bind("n", "j", "gj", opts)

bind("n", ";;", "<cmd>lua require('telescope.builtin').git_files()<cr>", opts)
bind("n", ";f", "<cmd>lua require('telescope.builtin').find_files()<cr>", opts)
-- bind("n", ";l", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", opts)
bind("n", ";r", "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
bind("n", ";b", "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
bind("n", ";c", "<cmd>lua require('telescope.builtin').commands()<cr>", opts)
-- bind("n", "sd", "<cmd>lua require('telescope.builtin').diagnostics()<cr>", opts)
-- bind("n", "sc", "<cmd>lua require('telescope.builtin').git_commits()<cr>", opts)
bind("n", ";lr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts)
bind("n", ";ls", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", opts)
-- bind("n", ";he", "<cmd>lua require('telescope.builtin').help_tags()<cr>", opts)
-- bind("n", "<leader>r", "<cmd>source $MYVIMRC<cr>", opts)

