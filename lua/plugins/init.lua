vim.cmd [[packadd packer.nvim]]

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
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

  -- парсер для всех языков программирования, цветной код как в твоем
  -- любимом IDE
  use 'ray-x/go.nvim'
  use 'ray-x/guihua.lua' 
  -- конфиги для LSP серверов, нужен для простой настройки и
  -- возможности добавления новых серверов
  use 'neovim/nvim-lspconfig'
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function()
        -- так подгружается конфигурация конкретного плагина
        -- ~/.config/nvim/lua/plugins/treesitter.lua
        require('plugins.treesitter') 
      end
  }
  
  use {
    'nvim-telescope/telescope.nvim',
    config = function()
      require('plugins.telescope')
    end
  }

  use 'nvim-telescope/telescope-file-browser.nvim'

  -- иконки в выпадающем списке автодополнений (прямо как в vscode)
  use('onsails/lspkind-nvim')

  if packer_bootstrap then
    require('packer').sync()
  end
end)

