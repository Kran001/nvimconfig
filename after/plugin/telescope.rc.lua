local setup, telescope = pcall(require, 'telescope')
if (not setup) then return end

local actions = require('telescope.actions')

telescope.setup {
  defaults = {
    hidden = true,
    mappings = {
      n = {
        ['C-o'] = actions.move_selection_next,
        ['C-p'] = actions.move_selection_previous,
        ['q'] = actions.close
      }
    }
  },

  pickers = {
    find_files = {
      hidden = true,
      file_ignore_patterns = { ".git/", "vendor", "bin", "go.sum" },
    },
    live_grep = {
      additional_args = function()
        return {"--hidden"}
      end,
      file_ignore_patterns = { ".git/", "vendor", "bin", "go.sum" },
    },
    buffers = {
      initial_mode = 'normal'
    },
  },
}

local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', opts)
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', opts)
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opts)
