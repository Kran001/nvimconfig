local status, bl = pcall(require, 'bufferline')
if (not status) then return end

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

vim.api.nvim_set_keymap('n', '<C-l>', '<cmd>BufferLineCycleNext<CR>', {silent=true})
vim.api.nvim_set_keymap('n', '<C-h>', '<cmd>BufferLineCyclePrev<CR>', {silent=true})
