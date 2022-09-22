return require('packer').startup({
    function(use)
        use { 'wbthomason/packer.nvim' }
        -- speeding up
        use { 'lewis6991/impatient.nvim' }
        use { 'nathom/filetype.nvim' }
        use { 'tpope/vim-sensible' }


        use {
            'nvim-treesitter/nvim-treesitter',
            run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
        }
        use { 'cohama/lexima.vim' }
        use { 'kyazdani42/nvim-web-devicons' }
        use { 'tpope/vim-commentary' }
        use { 'tpope/vim-surround' }
        use { 'habamax/vim-sugarlily' }
        use { 'feline-nvim/feline.nvim',
        after = "nvim-web-devicons",
        config = function()
            require('feline').setup({
                -- preset = 'noicon'
            })
        end
    }
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
end
})

