vim.cmd('autocmd!')

local options = {
  tabstop = 4,
  shiftwidth = 4,
  softtabstop = 4,
  number = true,
  relativenumber = true,
  cursorline = true,
  completeopt = { "menu", "menuone", "noselect", "noinsert" },
  encoding = "utf-8",
  signcolumn = "yes",
  swapfile = false,
  autoindent = true,
  smartindent = true,
  scrolloff = 15,
  undofile = true,
  ignorecase = true,
  incsearch = true,
  ruler = true,
  wildmenu = true,
  colorcolumn = "120",
  foldmethod = "indent",
  foldnestmax = 4,
  foldminlines = 10,
  foldlevelstart = 999,
  backspace = { "indent", "eol", "start" },
  laststatus = 4,
  list = false,
  listchars = "eol:↲,tab:» ,trail:·,extends:<,precedes:>,conceal:┊,nbsp:␣",
  langmap = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd([[
  lan en_US.UTF-8
  hi DiagnosticError guifg=Red
  hi DiagnosticWarn  guifg=DarkOrange
  hi DiagnosticInfo  guifg=Blue
  hi DiagnosticHint  guifg=Green
]])

vim.o.termguicolors = true

-- switch to absolute line numbers in insert mode
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  callback = function()
    vim.opt.relativenumber = false
    vim.opt.cursorline = false
  end,
})

-- switch to relative line numbers in normal mode
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  callback = function()
    vim.opt.relativenumber = true
    vim.opt.cursorline = true
  end,
})

