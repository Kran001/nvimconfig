local status, tree = pcall(require, 'nvim-tree')
if (not status) then return end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local api = require('nvim-tree.api')

local map = vim.keymap.set

local function my_on_attach(bufnr)
  -- default mappings
  api.config.mappings.default_on_attach(bufnr)
end

tree.setup({
  on_attach = my_on_attach,
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  git = {
    enable = true,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  filters = {
    git_ignored = true,
    dotfiles = true,
  }
})

map('n', '<leader>t', api.tree.toggle, { silent = true })
map('n', '?', api.tree.toggle_help, { silent = true})
