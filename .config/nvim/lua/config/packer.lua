vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

  use 'wbthomason/packer.nvim'
  -- theme
  -- use {"ryanoasis/vim-devicons"}
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

  -- lsp and autocomplete
  use 'neovim/nvim-lspconfig'

  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'

  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

end)
