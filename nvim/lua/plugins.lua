return require('packer').startup({
	function(use)
		use { 'wbthomason/packer.nvim' }
		-- speeding up
		use { 'lewis6991/impatient.nvim' }
		use { 'nathom/filetype.nvim' }
		use { 'tpope/vim-sensible' }


		use { 'neovim/nvim-lspconfig' }
		use {'hrsh7th/nvim-cmp',
			config = function()
				require('cmp').setup {
					-- snippet = {
					-- 	-- REQUIRED - you must specify a snippet engine
					-- 	expand = function(args)
					-- 		vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
					-- 		-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					-- 		-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
					-- 		-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					-- 	end,
					-- },
					window = {
						-- completion = cmp.config.window.bordered(),
						-- documentation = cmp.config.window.bordered(),
					},
					mapping = cmp.mapping.preset.insert({
						['<C-b>'] = cmp.mapping.scroll_docs(-4),
						['<C-f>'] = cmp.mapping.scroll_docs(4),
						['<C-Space>'] = cmp.mapping.complete(),
						['<C-e>'] = cmp.mapping.abort(),
						['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					}),
					sources = cmp.config.sources({
						{ name = 'nvim_lsp' },
						-- { name = 'vsnip' }, -- For vsnip users.
						-- { name = 'luasnip' }, -- For luasnip users.
						-- { name = 'ultisnips' }, -- For ultisnips users.
						-- { name = 'snippy' }, -- For snippy users.
					}, { { name = 'buffer' } })
				}
			end
		}
		use 'hrsh7th/cmp-nvim-lsp'
		use 'hrsh7th/cmp-buffer'
		use 'hrsh7th/cmp-path'
		use 'hrsh7th/cmp-cmdline'


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
						enable = true
					},
				}
			end
		}
		use { 'cohama/lexima.vim' }
		use { 'kyazdani42/nvim-web-devicons' }
		use { 'tpope/vim-commentary' }
		use { 'tpope/vim-surround' }
		use { 'habamax/vim-sugarlily' }
		use { 'feline-nvim/feline.nvim',
			after = "nvim-web-devicons",
			config = function() require('feline').setup{} end
		}
		use { 'nvim-telescope/telescope.nvim', tag = '0.1.0',
			requires = { {'nvim-lua/plenary.nvim'} }
		}
	end
})

