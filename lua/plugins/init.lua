vim.cmd [[packadd packer.nvim]]

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local packer = require('packer')
return packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  use "petertriho/nvim-scrollbar"

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    }
  }

  use 'marko-cerovac/material.nvim'
  use 'nvim-lua/plenary.nvim'

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'

  use 'hrsh7th/nvim-cmp'
  use 'saadparwaiz1/cmp_luasnip'
  use({
    "L3MON4D3/LuaSnip",
    tag = "v<CurrentMajor>.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    run = "make install_jsregexp"
  })
  -- набор готовых сниппетов для всех языков, включая go
  use 'rafamadriz/friendly-snippets'

  --go lib usage
  use('ray-x/go.nvim')
  use('ray-x/guihua.lua')
  use("mfussenegger/nvim-dap")
  use("leoluz/nvim-dap-go")
  use({
    "rcarriga/nvim-dap-ui",
	requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
  })
  use("nvim-neotest/neotest")
  use("nvim-neotest/neotest-go")

  use 'neovim/nvim-lspconfig'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use("Mofiqul/vscode.nvim")

  use {
    'nvim-telescope/telescope.nvim',
  }

  use 'nvim-telescope/telescope-file-browser.nvim'
  use {
    'akinsho/bufferline.nvim',
    tag = "*",
    requires = 'nvim-tree/nvim-web-devicons',
  }

  use('onsails/lspkind-nvim')
  use({
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    requires = {
      "nvim-lua/plenary.nvim",
    },
  })

  use({
    "lewis6991/gitsigns.nvim"
  })

  use({"windwp/nvim-autopairs"})

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use('rcarriga/nvim-notify')
  if packer_bootstrap then
    packer.sync()
  end
end)

