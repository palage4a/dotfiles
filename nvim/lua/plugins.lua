vim.cmd [[packadd packer.nvim]]

local packer = require('packer')

packer.init({ ensure_dependencies = true })

packer.startup(function(use)
    use { 'wbthomason/packer.nvim' }

    -- Is using a standard Neovim install, i.e. built from source or using a
    -- provided appimage.
    use 'lewis6991/impatient.nvim'

    use { 'neovim/nvim-lspconfig',
        config = function()
            local opts = { noremap = true, silent = true }
            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
            -- Use an on_attach function to only map the following keys
            -- after the language server attaches to the current buffer
            local on_attach = function(_, bufnr)
                -- Enable completion triggered by <c-x><c-o>
                vim.g.omnifunc = true
                vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

                -- Mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
                -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
                -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
                -- vim.keymap.set('n', '<space>wl', function()
                --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                -- end, bufopts)
                vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
                vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
                vim.keymap.set('n', '<space>=', vim.lsp.buf.formatting, bufopts)
            end

            require('lspconfig')['sumneko_lua'].setup {
                on_attach = on_attach,
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            globals = { 'vim', 'box' },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            }
        end
    }

    use { 'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = { "c", "lua", "go", "javascript", "typescript" },
                auto_install = true,
                context_commentstring = {
                    enable = true,
                    enable_autocmd = false,
                },
                matchup = {
                    enable = true
                },
                highlight = {
                    enable = true, -- false will disable the whole extension
                },
                indent = {
                    -- enable = true -- it's break indenting in lua
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn",
                        node_incremental = "grn",
                        scope_incremental = "grc",
                        node_decremental = "grm",
                    },
                },
            }
        end
    }


    use { 'tpope/vim-surround' }
    use { 'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup({
                icons_enabled = false
            })
        end
    }


    use { 'folke/tokyonight.nvim',
        config = function()
            vim.cmd [[ colorscheme tokyonight ]]
        end }

    use { 'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use { 'windwp/nvim-autopairs', config = function()
        require('nvim-autopairs').setup {}
    end
    }

    use { "aserowy/tmux.nvim",
        config = function() require("tmux").setup({
                navigation = {
                    enable_default_keybindings = true,
                },
                resize = {
                    enable_default_keybindings = false,
                }
            })
        end
    }

    use { 'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<space>f', builtin.find_files, {})
            vim.keymap.set('n', '<space>/', builtin.live_grep, {})
        end
    }
end)
