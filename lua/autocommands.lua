vim.api.nvim_create_autocmd({'BufWritePre'}, {
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.format({timeout = 3000})
  end
})
