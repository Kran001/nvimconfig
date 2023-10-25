vim.cmd('autocmd!')

-- vim.wo.number = true

--vim.opt.autoindent = true
--vim.opt.showcmd = true
--vim.opt.laststatus = 2
--vim.opt.smarttab = true
--vim.opt.shiftwidth = 4
--vim.opt.tabstop = 4
--vim.opt.expandtab=true
--vim.opt.wrap = false
--vim.opt.list = false
--vim.opt.swapfile = false
--vim.opt.autoindent = true
--vim.opt.smartindent = true
--vim.opt.listchars = "eol:↲,tab:» ,trail:·,extends:<,precedes:>,conceal:┊,nbsp:␣"
--]]--

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
    foldnestmax = 3,
    foldminlines = 10,
    foldlevelstart = 999,
    backspace = { "indent", "eol", "start" },
    laststatus = 3,
    list = false,
    listchars = "eol:↲,tab:» ,trail:·,extends:<,precedes:>,conceal:┊,nbsp:␣",
    langmap = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz",
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.cmd([[
	set termguicolors
	lan en_US.UTF-8
]])

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

