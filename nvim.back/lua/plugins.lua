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
        requires = { 'nvim-treesitter/nvim-treesitter-textobjects' },
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
                -- incremental_selection = {
                --     enable = true,
                --     keymaps = {
                --         init_selection = "gnn",
                --         node_incremental = "grn",
                --         scope_incremental = "grc",
                --         node_decremental = "grm",
                --     },
                -- },
                textobjects = {
                    select = {
                        enable = true,

                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,

                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ab"] = "@block.outer",
                            ["ib"] = "@block.inner",
                            -- You can optionally set descriptions to the mappings (used in the desc parameter of
                            -- nvim_buf_set_keymap) which plugins like which-key display
                            ["aC"] = "@class.outer",
                            ["iC"] = "@class.inner",
                            ["ac"] = "@conditional.outer",
                            ["ic"] = "@conditional.inner",
                            ["aü"] = "@conditional.outer",
                            ["iü"] = "@conditional.inner",
                            ["ae"] = "@block.outer",
                            ["ie"] = "@block.inner",
                            ["al"] = "@loop.outer",
                            ["il"] = "@loop.inner",
                            ["is"] = "@statement.inner",
                            ["as"] = "@statement.outer",
                            ["ad"] = "@lhs.inner",
                            ["id"] = "@rhs.inner",
                            ["am"] = "@call.outer",
                            ["im"] = "@call.inner",
                            ["iM"] = "@frame.inner",
                            ["aM"] = "@frame.outer",
                            ["ai"] = "@parameter.outer",
                            ["ii"] = "@parameter.inner"
                        },
                        -- You can choose the select mode (default is charwise 'v')
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * method: eg 'v' or 'o'
                        -- and should return the mode ('v', 'V', or '<c-v>') or a table
                        -- mapping query_strings to modes.
                        selection_modes = {
                            ['@parameter.outer'] = 'v', -- charwise
                            ['@function.outer'] = 'V', -- linewise
                            ['@class.outer'] = '<c-v>', -- blockwise
                        },
                        -- If you set this to `true` (default is `false`) then any textobject is
                        -- extended to include preceding or succeeding whitespace. Succeeding
                        -- whitespace has priority in order to act similarly to eg the built-in
                        -- `ap`.
                        --
                        -- Can also be a function which gets passed a table with the keys
                        -- * query_string: eg '@function.inner'
                        -- * selection_mode: eg 'v'
                        -- and should return true of false
                        include_surrounding_whitespace = true,
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
            require('telescope').setup {
                defaults = {
                },
                pickers = {
                    find_files = {
                        theme = 'dropdown',
                    }
                }
            }
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<space>ff', builtin.find_files, {})
            vim.keymap.set('n', '<space>fw', builtin.live_grep, {})
        end
    }
end)
