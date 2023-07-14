local keymap = vim.keymap

keymap.set('n', '<C-a>', 'gg<S-v>G')

-- tabs
keymap.set('n', 'te', ':tabedit<Return>', { silent = true})
-- split
keymap.set('n', 'ss', ':split<Return><C-w>w', { silent = true })
keymap.set('n', 'sv', ':vsplit<Return><C-w>w', {silent = true})


-- resize window
keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
