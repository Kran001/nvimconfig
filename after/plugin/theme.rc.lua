local status, theme = pcall(require, 'onedarkpro')
if (not status) then return end

vim.cmd [[ colorscheme vscode ]]

local iconStatus, treeIcons = pcall(require, 'nvim-web-devicons')
if (not iconStatus) then return end

treeIcons.setup {
  override = {
    zsh = {
      icon = "",
      color = "#428850",
      cterm_color = "65",
      name = "Zsh"
    },
  },
  color_icons = true,
  strict = true,
}

