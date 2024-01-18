vim.g.material_style = "oceanic"
vim.cmd 'colorscheme material'

require('material').setup({
    -- ... other settings
    disable = {
        background = true,
    },
})

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

