local setup, telescope = pcall(require, 'telescope')
if (not setup) then return end

local actions = require('telescope.actions')

telescope.setup {
  defaults = {
    hidden = true,
    mappings = {
      n = {
        ['q'] = actions.close
      }
    }
  },

  pickers = {
    find_files = {
      hidden = true,
      file_ignore_patterns = { ".git/", "vendor", "bin", "go.sum" },
    },
    buffers = {
      -- начинать в normal моде при открытии списка буферов
      initial_mode = 'normal'
    },
  },
}

local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}
-- горячие клавиши
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', opts)
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', opts)
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opts)
