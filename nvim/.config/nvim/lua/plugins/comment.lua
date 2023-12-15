return {
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
	},
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
				end,
			},
		},
		config = function(_, opts)
			vim.g.skip_ts_context_commentstring_module = true
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
			require("mini.comment").setup(opts)
		end,
	},
}
