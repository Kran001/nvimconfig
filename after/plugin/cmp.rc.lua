
local cmpStatus, cmp = pcall(require, 'cmp')
if (not cmpStatus) then return end

local lspkind = require('lspkind')
local luasnip = require('luasnip')

local select_opts = {behavior = cmp.SelectBehavior.Insert}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  window = {
    documentation = cmp.config.window.bordered()
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1

      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, {'i', 's'}),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, {'i', 's'}),
    ['<C-y>'] = cmp.mapping.confirm({ select = false }),
    ['<C-Space>'] = cmp.mapping.confirm({ select = false }),
--    ['<C-y>'] = cmp.mapping.complete(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-u>'] = cmp.mapping.scroll_docs(4),
    ['<C-p>'] = cmp.mapping.select_next_item(select_opts),
  }),
  formatting = {
    format = lspkind.cmp_format({ wirth_text = false })
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'luasnip' },
  })
})


