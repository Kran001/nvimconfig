vim.cmd [[packadd packer.nvim]]

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local packer = require('packer')
return packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
  	'nvim-tree/nvim-tree.lua',
	requires = {
	  'nvim-tree/nvim-web-devicons',
	} 
  }
  --themes
  use 'olimorris/onedarkpro.nvim'

  -- набор Lua функций, используется как зависимость в большинстве
  -- плагинов, где есть работа с асинхронщиной
  use 'nvim-lua/plenary.nvim'

   -- зависимости для движка автодополнения
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'

  -- движок автодополнения для LSP
  use 'hrsh7th/nvim-cmp'
  use 'saadparwaiz1/cmp_luasnip'
  use({
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	tag = "v<CurrentMajor>.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!:).
	run = "make install_jsregexp"
  })
  -- набор готовых сниппетов для всех языков, включая go
  use 'rafamadriz/friendly-snippets'

  --go lib usage
  use('ray-x/go.nvim')
  use('ray-x/guihua.lua')
  use("mfussenegger/nvim-dap")
  use("leoluz/nvim-dap-go")
  use("rcarriga/nvim-dap-ui")
  use("nvim-neotest/neotest")
  use("nvim-neotest/neotest-go")

  -- конфиги для LSP серверов, нужен для простой настройки и
  -- возможности добавления новых серверов
  use 'neovim/nvim-lspconfig'
  -- парсер для всех языков программирования, цветной код как в твоем
  -- любимом IDE
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }

  use {
    'nvim-telescope/telescope.nvim',
  }

  use 'nvim-telescope/telescope-file-browser.nvim'
  use {
    'akinsho/bufferline.nvim', 
    tag = "*", 
    requires = 'nvim-tree/nvim-web-devicons',
  }

  -- иконки в выпадающем списке автодополнений (прямо как в vscode)
  use('onsails/lspkind-nvim')

  use({
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    requires = {
        "nvim-lua/plenary.nvim",
    },
  })

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use('rcarriga/nvim-notify')
  if packer_bootstrap then
    packer.sync()
  end
end)

