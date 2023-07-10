-- ~/.config/nvim/lua/plugins/treesitter.lua
require('nvim-treesitter.configs').setup{
  -- список парсеров, список доступных парсеров можно посмотреть в документации
  -- либо устаналивать все, чтобы подсветка синтаксиса работала везде корректно
  -- https://github.com/nvim-treesitter/nvim-treesitter
  ensure_installed = 'all',
  -- установка phpdoc падает на m1
  ignore_install = { 'phpdoc' },
  -- включить подсветку
  highlight = { enable = true }
}
