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
  
  -- Install language servers automatically and LSP config
  use {
      "williamboman/nvim-lsp-installer",
      "neovim/nvim-lspconfig",
  }
  
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  
  use { 'L3MON4D3/LuaSnip' }
  use {
    'hrsh7th/nvim-cmp',
    -- config = function ()
    --   require'cmp'.setup {
    --   snippet = {
    --     expand = function(args)
    --       require'luasnip'.lsp_expand(args.body)
    --     end
    --   },
  
    --   sources = {
    --     { name = 'luasnip' },
    --     -- more sources
    --   },
    -- }
    -- end
  }
  use { 'saadparwaiz1/cmp_luasnip' }
  use 'rafamadriz/friendly-snippets'
  
  use 'nvim-lua/plenary.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'

end)
