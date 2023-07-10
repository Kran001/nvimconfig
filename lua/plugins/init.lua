vim.cmd [[packadd packer.nvim]]

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

    -- набор Lua функций, используется как зависимость в большинстве
  -- плагинов, где есть работа с асинхронщиной
  use 'nvim-lua/plenary.nvim'

  -- конфиги для LSP серверов, нужен для простой настройки и
  -- возможности добавления новых серверов
  use 'neovim/nvim-lspconfig'

  -- зависимости для движка автодополнения
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'

  -- движок автодополнения для LSP
  use 'hrsh7th/nvim-cmp'

  -- парсер для всех языков программирования, цветной код как в твоем
  -- любимом IDE
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

  if packer_bootstrap then
    require('packer').sync()
  end
end)
