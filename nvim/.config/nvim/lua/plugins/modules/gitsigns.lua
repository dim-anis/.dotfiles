return {
	"lewis6991/gitsigns.nvim",
	opts = {
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
		on_attach = function(buffer)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
			end

			map("n", "<leader>gp", gs.prev_hunk, "[G]o to [P]revious Hunk")
			map("n", "<leader>gn", gs.next_hunk, "[G]o to [N]ext Hunk")
			map("n", "<leader>ph", gs.preview_hunk, "[P]review [H]unk")
		end,
	},
}
