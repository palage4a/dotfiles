return require('packer').startup(function(use)
	use { 'wbthomason/packer.nvim' }
	--
	-- speeding up
	use { 'lewis6991/impatient.nvim' }
	use { 'nathom/filetype.nvim' }
	use { 'tpope/vim-sensible' }

	use { 'neovim/nvim-lspconfig',
		config = function()
			local opts = { noremap = true, silent = true }
			vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
			vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
			vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
			vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

			-- Use an on_attach function to only map the following keys
			-- after the language server attaches to the current buffer
			local on_attach = function(client, bufnr)
				-- Enable completion triggered by <c-x><c-o>
				-- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

				-- Mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local bufopts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
				vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
				vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
				vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
				vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
				vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
				vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
				vim.keymap.set('n', '<space>wl', function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, bufopts)
				vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
				vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
				vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
				vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
				vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
			end

			local lsp_flags = {
				-- This is the default in Nvim 0.7+
				debounce_text_changes = 150,
			}

			require('lspconfig')['sumneko_lua'].setup {
				on_attach = on_attach,
				flags = lsp_flags,
				settings = {
					Lua = {
						runtime = {
							-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
							version = 'LuaJIT',
						},
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { 'vim' },
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
	use { 'hrsh7th/nvim-cmp',
		config = function()
			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local cmp = require('cmp')
			if not cmp then return end
			local luasnip = require('luasnip')
			if not luasnip then return end
			cmp.setup({
				performance = {
					debounce = 150,
				},
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						luasnip.lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = {
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
				-- mapping = cmp.mapping.preset.insert({
				-- 	['<C-b>'] = cmp.mapping.scroll_docs(-4),
				-- 	['<C-f>'] = cmp.mapping.scroll_docs(4),
				-- 	['<C-Space>'] = cmp.mapping.complete(),
				-- 	['<C-e>'] = cmp.mapping.abort(),
				-- 	['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				-- }),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					-- { name = 'vsnip' }, -- For vsnip users.
					{ name = 'luasnip' }, -- For luasnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					-- { name = 'snippy' }, -- For snippy users.
				}, { { name = 'buffer' } })
			})
			for _, v in pairs({ '/', '?' }) do
				cmp.setup.cmdline(v, {
					mapping = cmp.mapping.preset.cmdline(),
					sources = {
						{ name = 'buffer' }
					}
				})
			end

			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' }
				}, {
					{ name = 'cmdline' }
				})
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
		end
	}
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'

	use 'L3MON4D3/LuaSnip'

	use { 'nvim-treesitter/nvim-treesitter',
		run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
		config = function()
			require('nvim-treesitter.configs').setup {
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

	use { 'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup {}
		end }

	use {
		'numToStr/Comment.nvim',
		config = function()
			-- local ts_comment_integration = require('ts_context_commentstring.integrations.comment_nvim')
			require('Comment').setup({
				-- pre_hook = ts_comment_integration.create_pre_hook(),
			})
		end
	}

	use { 'tpope/vim-surround' }

	use 'habamax/vim-sugarlily'
	use { 'marko-cerovac/material.nvim',
		run = function()
			require('material').setup {
				lualine_style = 'stealth',
			}
		end
	}

	use { 'kyazdani42/nvim-web-devicons' }

	use { 'nvim-lualine/lualine.nvim',
		config = function()
			require('lualine').setup {}
		end
	}
	-- use { 'feline-nvim/feline.nvim',
	-- 	after = "nvim-web-devicons",
	-- 	config = function() require('feline').setup {} end
	-- }
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.0',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}

	use({
		"aserowy/tmux.nvim",
		config = function() require("tmux").setup() end
	})

end)
