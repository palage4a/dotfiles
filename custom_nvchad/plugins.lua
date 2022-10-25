return {
    ["folke/which-key.nvim"] = {
        disable = false,
    },

    ["nvim-treesitter/nvim-treesitter-textobjects"] = {},

    ["nvim-treesitter/nvim-treesitter"] = {
        ensure_installed = {
            "vim",
            "json",
            "markdown",
            "c",
            "bash",
            "lua",
        },
        override_options = {
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<M-w>", -- maps in normal mode to init the node/scope selection
                    node_incremental = "<M-w>", -- increment to the upper named parent
                    node_decremental = "<M-C-w>", -- decrement to the previous node
                    scope_incremental = "<M-e>", -- increment to the upper scope (as defined in locals.scm)
                },
            },
            textobjects = {
                move = {
                    enable = true,
                    set_jumps = true,

                    goto_next_start = {
                        ["]p"] = "@parameter.inner",
                        ["]f"] = "@function.outer",
                        ["]]"] = "@block.outer",
                        -- ["]b"] = "@block.outer",
                    },
                    goto_previous_start = {
                        ["[p"] = "@parameter.inner",
                        ["[f"] = "@function.outer",
                        ["[["] = "@block.outer",
                        -- ["[b"] = "@block.outer",
                    },
                },

                select = {
                    enable = true,
                    lookahed = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",

                        ["ac"] = "@conditional.outer",
                        ["ic"] = "@conditional.inner",

                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",

                        ["ab"] = "@block.outer",
                        ["ib"] = "@block.inner",
                    },
                },
            },


        }
    }
}

