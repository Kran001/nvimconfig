local status, lspconfig = pcall(require, 'lspconfig')
if (not status) then return end

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
lspconfig.util.default_config.lsp_capabilities = vim.tbl_deep_extend( 'force',
  lspconfig.util.default_config,
  lsp_capabilities
)

local map = vim.keymap.set

local lsp_attach = function (client, bufnr)
  if client.server_capabilities.inlayHintProvider then
	vim.lsp.inlay_hint.enable(true, {
	bufnr = bufnr,
  })
  end

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
end

local util = require('lspconfig/util')
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl= hl, numhl = hl })
end


local opts = { noremap=true, silent=true }
map('n', '<leader>e', vim.diagnostic.open_float, opts)
map('n', '[d', vim.diagnostic.goto_prev, opts)
map('n', ']d', vim.diagnostic.goto_next, opts)
map('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Languages settings 
-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-install
local goStatus, go = pcall(require, 'go')
if goStatus then
  local goFmt = require('go.format')
  lspconfig.gopls.setup({
    capabilities = lsp_capabilities,
	on_attach = lsp_attach,
    cmd = { 'gopls', 'serve' },
    event = { "BufReadPre", "BufNewFile" },
    filetypes = { 'go', 'go.mod' },
    root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
          shadow = true
        },
		hints = {
           assignVariableTypes = false,
           compositeLiteralFields = false,
           compositeLiteralTypes = true,
           constantValues = true,
           functionTypeParameters = false,
           parameterNames = false,
           rangeVariableTypes = true,
        },
        staticcheck = true,
      }
    },
    single_file_support = true,
  })

  go.setup({
	capabilities = lsp_capabilities,
    lsp_keymaps = false,
    go='go', -- go command, can be go[default] or go1.18beta1
    goimports='gopls', -- goimport command, can be gopls[default] or goimport
    fillstruct = 'gopls', -- can be nil (use fillstruct, slower) and gopls
    gofmt = 'gopls', --gofmt cmd,
	--gofmt = 'gofumpt', --gofmt cmd,
    tag_transform = false, -- can be transform option("snakecase", "camelcase", etc) check gomodifytags for details and more options
    tag_options = 'json=omitempty',
    icons = false,
  })

  vim.api.nvim_create_autocmd('BufReadPre', {
    pattern= '*.go',
    callback= function()
      map('n', '<Space>8', "<cmd>GoPkgOutline<CR>", {silent=true})
  	end,
  })

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
  event = { "BufReadPre", "BufNewFile" },
  filetypes = {"lua"},
  on_attach = lsp_attach,
  capabilities = lsp_capabilities,
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
  event = { "BufReadPre", "BufNewFile" },
  capabilities = lsp_capabilities,
  on_attach = lsp_attach,
  settings = {
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

lspconfig.pyright.setup{
  event = { "BufReadPre", "BufNewFile" },
}

lspconfig.clangd.setup({
  cmd = {'clangd', '--background-index', '--clang-tidy', '--log=verbose', '--query-driver=/usr/bin/clang++'},
  capabilities = lsp_capabilities,
  on_attach = lsp_attach,
  init_options = {
    fallbackFlags = { '-std=c++17' },
  },
})
