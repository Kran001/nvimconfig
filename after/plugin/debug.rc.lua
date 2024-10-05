local dap = require("dap")
local dapui = require("dapui")
local gdap = require("dap-go")
--- local vtdap = require("nvim-dap-virtual-text")

gdap.setup()
dapui.setup({})

dap.adapters.delve = {
  type = 'server',
  port = '${port}',
  executable = {
    command = 'dlv',
    args = {'dap', '-l', '127.0.0.1:${port}'},
  }
}

local scratchCfg = {
  type = "delve",
  name = "Scratch no args",
  request = "launch",
  program = "./${relativeFileDirname}",
  showLog = true,
  dlvToolPath = vim.fn.exepath('dlv'),  -- Adjust to where delve is installed
  args = {"--local-config-enabled", "--bind-localhost"},
}

local standardDebug = {
  type = 'delve',
  name = 'Debug';
  request = 'launch';
  showLog = true;
  program = "${file}";
  dlvToolPath = vim.fn.exepath('dlv'),  -- Adjust to where delve is installed
  args = {"--local-config-enabled", "--bind-localhost"},
}

table.insert(dap.configurations.go, scratchCfg)
table.insert(dap.configurations.go, standardDebug)

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

local k = require("user.utils").keymap
k("n", "<F5>", ":lua require'dap'.continue()<CR>")
k("n", "<F3>", ":lua require'dap'.step_over()<CR>")
k("n", "<F2>", ":lua require'dap'.step_into()<CR>")
k("n", "<F12>", ":lua require'dap'.step_out()<CR>")
k("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
k("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
k("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
k("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>")
k("n", "<leader>dt", ":lua require'dap-go'.debug_test()<CR>")

local namespace = vim.api.nvim_create_namespace("dap-hlng")
vim.api.nvim_set_hl(namespace, 'DapBreakpoint', { fg='#eaeaeb', bg='#ffffff' })
vim.api.nvim_set_hl(namespace, 'DapLogPoint', { fg='#eaeaeb', bg='#ffffff' })
vim.api.nvim_set_hl(namespace, 'DapStopped', { fg='#eaeaeb', bg='#ffffff' })
vim.fn.sign_define('DapBreakpoint', { text='◉ ', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text='ﳁ', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl= 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text='', texthl='DapLogPoint', linehl='DapLogPoint', numhl= 'DapLogPoint' })
vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })
