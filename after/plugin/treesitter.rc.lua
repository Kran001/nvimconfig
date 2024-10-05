local status, treesitter = pcall(require, 'nvim-treesitter.configs')
if (not status) then return end

-- ~/.config/nvim/lua/plugins/treesitter.lua
treesitter.setup({
  -- https://github.com/nvim-treesitter/nvim-treesitter
  auto_install = true,
  sync_install = false,
  ensure_installed = {
    "bash",
    "cpp",
    "gitignore",
    "http",
    "json",
    "javascript",
    "typescript",
    "css",
    "html",
    "markdown",
    "markdown_inline",
    "proto",
    "sql",
    "yaml",
    "go",
    "c",
    "lua",
    "vim",
    "query",
    "vimdoc",
    "graphql",
	"make",
    "cmake",
    "rust",
    "v"
  },
   
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
})

