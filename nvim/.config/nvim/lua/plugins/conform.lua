return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      sqlfluff = {},
    },
    formatters_by_ft = {
      sql = { "sqlfluff" },
      tex = { "latexindent" },
    },
  },
}
