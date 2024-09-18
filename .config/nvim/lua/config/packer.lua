vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

  use 'wbthomason/packer.nvim'
  -- theme
  -- use {"ryanoasis/vim-devicons"}
  -- use { "catppuccin/nvim", as = "catppuccin" }
  use { "savq/melange-nvim", as = "melange" }
  -- fzf
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.5',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
	  'nvim-treesitter/nvim-treesitter',
	  run = ':TSUpdate'
  }
  use 'nvim-treesitter/playground'
  use 'theprimeagen/harpoon' -- best navigation tool, like ever
  use 'mbbill/undotree'
  use 'tpope/vim-fugitive'

  -- Lf integration (file manager)
  --use 'ptzz/lf.vim'
  --use 'voldikss/vim-floaterm'

  -- lsp-zero, I hope I learn how to set this up myself someday TT
  use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v4.x',
      requires = {
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},

        -- LSP Support
        {'neovim/nvim-lspconfig'},
        -- Autocompletion
        {'hrsh7th/nvim-cmp'},
        {'hrsh7th/cmp-nvim-lsp'},
        {'L3MON4D3/LuaSnip'},
      }
    }
end)
