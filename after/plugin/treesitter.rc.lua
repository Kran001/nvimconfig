local status, treesitter = pcall(require, 'nvim-treesitter.configs')
if (not status) then return end

-- ~/.config/nvim/lua/plugins/treesitter.lua
treesitter.setup{
  -- список парсеров, список доступных парсеров можно посмотреть в документации
  -- либо устаналивать все, чтобы подсветка синтаксиса работала везде корректно
  -- https://github.com/nvim-treesitter/nvim-treesitter
  ensure_installed = 'all',
  sync_install = false,
  -- установка phpdoc падает на m1
  ignore_install = { 'phpdoc' },
  -- включить подсветку
  highlight = {
    enable = true,
    disable = {},
    additiional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true,
  },
}

