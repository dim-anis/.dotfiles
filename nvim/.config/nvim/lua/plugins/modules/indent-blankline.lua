return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  enabled = true,
  opts = {
    char = "┊",
    show_trailing_blankline_indent = false,
    show_current_context = false,
    show_first_indent_level = true,
    use_treesitter = true,
    buftype_exclude = { "terminal", "nofile" },
    filetype_exclude = {
      "help",
      "mason",
      "NvimTree",
    },
  },
  config = function()
    require('ibl').setup()
  end,
}
