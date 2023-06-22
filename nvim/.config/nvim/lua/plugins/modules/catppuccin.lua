return {
  "catppuccin/nvim",
  name = "catppuccin",
  enabled = true,
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      -- flavour = "frappe",
      -- flavour = "macchiato"
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}
