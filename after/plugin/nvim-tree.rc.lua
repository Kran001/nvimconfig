
local status, tree = pcall(require, 'nvim-tree')
if (not status) then return end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.termguicolors = true

local api = require('nvim-tree.api')

local keymap = vim.keymap

local function my_on_attach(bufnr)
  
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

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
  filter = {
    dotfiles = true, 
  }
})

keymap.set('n', '<leader>t', api.tree.toggle, { silent = true }, {focus=true})
