if !exists('g:loaded_telescope') | finish | endif

nnoremap <silent> ;f <cmd>Telescope find_files<cr>
nnoremap <silent> ;s <cmd>Telescope lsp_document_symbols<cr>
nnoremap <silent> ;w <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
nnoremap <silent> ;t <cmd>Telescope treesitter<cr>
nnoremap <silent> ;c <cmd>Telescope commands<cr>
nnoremap <silent> ;r <cmd>Telescope live_grep<cr>
nnoremap <silent> ;b <cmd>Telescope buffers<cr>
nnoremap <silent> ;gb <cmd>Telescope git_branches<cr>
nnoremap <silent> ;gs <cmd>Telescope git_status<cr>


lua << EOF
local actions = require('telescope.actions')
-- Global remapping
------------------------------
require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  }
}
EOF

