return {
  "catppuccin/nvim",
  name = "catppuccin",
  enabled = true,
  lazy = false,
  priority = 1000,
  opts = {
    integrations = {
      cmp = true,
      gitsigns = true,
      indent_blankline = { enabled = true },
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      mini = true,
      telescope = true,
      treesitter = true,
      which_key = true,
      dap = true,
      mason = true,
      fidget = true,
    },
  },
  config = function()
    vim.cmd.colorscheme("catppuccin")
  end,
}

-- return {
--   "rebelot/kanagawa.nvim",
--   priority = 1000,
--   config = function()
--     require("kanagawa").setup({
--       colors = {
--         theme = {
--           all = {
--             ui = {
--               bg_gutter = "none"
--             }
--           }
--         }
--       }
--     })
--     vim.cmd.colorscheme "kanagawa"
--   end,
-- }
