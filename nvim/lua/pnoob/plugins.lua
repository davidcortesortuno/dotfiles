-- This file can be loaded by calling `lua require('plugins')` from your init.vim

return require('packer').startup(function(use)
  
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
  
    -- Colorschemes
    use 'ellisonleao/gruvbox.nvim'
    use 'rebelot/kanagawa.nvim'
    
    -- Treesitter for better highlight
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
        -- run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }
    -- Make treesitter work with nvim spell
    use 'lewis6991/spellsitter.nvim'
    
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    
    use 'tpope/vim-surround'

    -- plenary: useful lua functions
    use 'nvim-lua/plenary.nvim'
    
    -- Install language servers automatically and LSP config
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        'jose-elias-alvarez/null-ls.nvim'
    }
    
    use { 'L3MON4D3/LuaSnip' }
    use {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/nvim-cmp',
    }
    use { 'saadparwaiz1/cmp_luasnip' }
    use 'rafamadriz/friendly-snippets'

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        -- tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
  
end)
