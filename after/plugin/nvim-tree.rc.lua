local status, tree = pcall(require, 'nvim-tree')
if (not status) then return end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local api = require('nvim-tree.api')

local keymap = vim.keymap

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
  filters = {
	git_ignored = true,
    dotfiles = true,
  }
})

keymap.set('n', '<leader>t', api.tree.toggle, { silent = true }, {focus=true})
keymap.set('n', '?', api.tree.toggle_help, { silent = true }, {focus=true})
