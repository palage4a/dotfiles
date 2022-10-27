local M = {}

M.general = {
  n = {
    [";"] = {":", "command mode", opts = {nowait = true}}
  }
}

M.telescope = {
    n = {
        ['gr'] = {":lua require('telescope.builtin').lsp_references()<CR>"},
        ['<space>fd'] = {":lua require('telescope.builtin').lsp_document_symbols()<cr>"},
        ['<space>fs'] = {":lua require('telescope.builtin').lsp_workspace_symbols()<cr>"},
    }
}

return M

