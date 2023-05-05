return {
  'lukas-reineke/indent-blankline.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  enabled = true,
  opts = {
    char = '┊',
    show_trailing_blankline_indent = false,
    show_current_context = false,
  },
}
