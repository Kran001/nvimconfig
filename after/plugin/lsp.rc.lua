local status, lspconfig = pcall(require, 'lspconfig')
if (not status) then return end

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
lspconfig.util.default_config.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig.util.default_config,
  capabilities
)

local util = require('lspconfig/util')
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl= hl, numhl = hl })
end

vim.cmd [[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]]

local map = vim.keymap.set
local opts = { noremap=true, silent=true }

-- удалить ошибки диагностики в левом столбце (SignColumn)
--vim.diagnostic.config({signs=false})
-- стандартные горячие клавиши для работы с диагностикой
map('n', '<leader>e', vim.diagnostic.open_float, opts)
map('n', '[d', vim.diagnostic.goto_prev, opts)
map('n', ']d', vim.diagnostic.goto_next, opts)
map('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- стандартные горячие клавиши для LSP, больше в документации
-- https://github.com/neovim/nvim-lspconfig map('n', 'gD', vim.lsp.buf.declaration, bufopts)
map('n', 'gd', vim.lsp.buf.definition, {})
map('n', 'K', vim.lsp.buf.hover, {})
map('n', 'gi', vim.lsp.buf.implementation, {})
map('n', '<C-k>', vim.lsp.buf.signature_help, {})
map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, {})
map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, {})
map('n', '<leader>wl', function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, {})
map('n', '<leader>D', vim.lsp.buf.type_definition, {})
map('n', '<leader><C-r>', vim.lsp.buf.rename, {})
map('n', '<leader>ca', vim.lsp.buf.code_action, {})
map('n', 'gr', vim.lsp.buf.references, {})
--map('n', '<leader>f', vim.lsp.buf.formatting, {})

-- Languages settings 
-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-install
lspconfig.gopls.setup({
  capabilities = capabilities,
  cmd = { 'gopls', 'serve' },
  filetypes = { 'go', 'go.mod' },
  root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true
      },
      staticcheck = true,
    }
  },
  single_file_support = true,
})

local goStatus, go = pcall(require, 'go')
if goStatus then
  local goFmt = require('go.format')
  go.setup({
    lsp_keymaps = false,
    go='go', -- go command, can be go[default] or go1.18beta1
    goimport='gopls', -- goimport command, can be gopls[default] or goimport
    fillstruct = 'gopls', -- can be nil (use fillstruct, slower) and gopls
    gofmt = 'gofumpt', --gofmt cmd,
    max_line_len = 128, -- max line length in golines format, Target maximum line length for golines
    tag_transform = false, -- can be transform option("snakecase", "camelcase", etc) check gomodifytags for details and more options
    tag_options = 'json=omitempty',
    icons = false,
  })
  map('n', '<Space>8', "<cmd>GoPkgOutline<CR>", {})
  local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
      goFmt.goimport()
    end,
    group = format_sync_grp,
  })
end

lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

lspconfig.jsonnet_ls.setup {
  settings = {
    ext_vars = {
      foo = 'bar',
  	},
  	formatting = {
      -- default values
      Indent              = 2,
      MaxBlankLines       = 2,
      StringStyle         = 'single',
      CommentStyle        = 'slash',
      PrettyFieldNames    = true,
      PadArrays           = true,
      PadObjects          = true,
      SortImports         = true,
      UseImplicitPlus     = true,
      StripEverything     = false,
      StripComments       = false,
      StripAllButComments = false,
    },
  },
}

lspconfig.pyright.setup{}

