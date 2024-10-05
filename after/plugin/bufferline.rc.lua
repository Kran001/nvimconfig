local status, bl = pcall(require, 'bufferline')
if (not status) then return end

local map = vim.keymap.set
bl.setup{
  options = {
    mode = "tabs",
    diagnostics = "nvim_lsp",
    always_show_bufferline = true,
    show_buffer_close_icons = true,
    show_close_icon = false,
    color_icons = true,
  },
}

map('n', '<C-l>', '<cmd>BufferLineCycleNext<CR>', {silent=true})
map('n', '<C-h>', '<cmd>BufferLineCyclePrev<CR>', {silent=true})
