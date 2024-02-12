return {
	"folke/zen-mode.nvim",
	opts = {
		window = {
			backdrop = 1,
			width = 120,
			height = 1,
			options = {
				signcolumn = "no",
				number = false,
				relativenumber = false,
			},
		},
		plugins = {
			tmux = { enabled = false },
		},
	},
}
