return {
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		build = ":TSUpdate",
		config = function()
			-- [[ Configure Treesitter ]]
			-- See `:help nvim-treesitter`
			-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				-- Add languages to be installed here that you want installed for treesitter
				ensure_installed = {
					"c",
					"go",
					"lua",
					"python",
					"rust",
					"tsx",
					"astro",
					"markdown",
					"markdown_inline",
					"javascript",
					"typescript",
					"vimdoc",
					"vim",
					"bash",
				},

				-- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
				auto_install = false,
				-- Install languages synchronously (only applied to `ensure_installed`)
				sync_install = false,
				-- You can specify additional Treesitter modules here: -- For example: -- playground = {--enable = true,-- },
				highlight = { enable = true },
				indent = { enable = true },
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<c-space>",
						node_incremental = "<c-space>",
						scope_incremental = "<c-s>",
						node_decremental = "<M-space>",
					},
				},
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
						keymaps = {
							-- You can use the capture groups defined in textobjects.scm
							["af"] = { query = "@function.outer", desc = "around a function" },
							["if"] = { query = "@function.inner", desc = "inner part of a function" },
							["ac"] = { query = "@class.outer", desc = "around a class" },
							["ic"] = { query = "@class.inner", desc = "inner part of a class" },
							["ai"] = { query = "@conditional.outer", desc = "around an if statement" },
							["ii"] = { query = "@conditional.inner", desc = "inner part of an if statement" },
							["al"] = { query = "@loop.outer", desc = "around a loop" },
							["il"] = { query = "@loop.inner", desc = "inner part of a loop" },
							["ap"] = { query = "@parameter.outer", desc = "around parameter" },
							["ip"] = { query = "@parameter.inner", desc = "inside a parameter" },
						},
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@parameter.inner"] = "v", -- charwise
							["@function.outer"] = "v", -- charwise
							["@conditional.outer"] = "V", -- linewise
							["@loop.outer"] = "V", -- linewise
							["@class.outer"] = "<c-v>", -- blockwise
						},
						include_surrounding_whitespace = false,
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = "@class.outer",
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner",
						},
					},
				},
			})
		end,
	},
}
