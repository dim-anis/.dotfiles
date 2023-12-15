local Util = require("./util")

return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = "*",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"jvgrootveld/telescope-zoxide",
			"nvim-tree/nvim-web-devicons",
			"ThePrimeagen/harpoon",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			"nvim-telescope/telescope-ui-select.nvim",
			"telescope-dap.nvim",
		},
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				defaults = {
					theme = "dropdown",
					previewer = true,
					file_ignore_patterns = { "node_modules", "package-lock.json" },
					initial_mode = "insert",
					select_strategy = "reset",
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					layout_config = {
						width = 0.75,
						height = 0.75,
						prompt_position = "top",
						preview_cutoff = 120,
					},
					path_display = { "smart" },
					winblend = 0,
					border = {},
					borderchars = nil,
					color_devicons = true,
					set_env = { ["COLORTERM"] = "truecolor" },
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--smart-case",
						"--hidden",
						"--glob=!.git/",
					},
				},
				pickers = {
					find_files = {
						hidden = true,
						previewer = false,
						layout_config = {
							horizontal = {
								width = 0.5,
								height = 0.4,
								preview_width = 0.6,
							},
						},
					},
					git_files = {
						hidden = true,
						previewer = false,
						layout_config = {
							horizontal = {
								width = 0.5,
								height = 0.4,
								preview_width = 0.6,
							},
						},
					},
					live_grep = {
						--@usage don't include the filename in the search results
						only_sort_text = true,
						previewer = true,
						layout_config = {
							horizontal = {
								width = 0.9,
								height = 0.75,
								preview_width = 0.6,
							},
						},
					},
					grep_string = {
						--@usage don't include the filename in the search results
						only_sort_text = true,
						previewer = true,
						layout_config = {
							horizontal = {
								width = 0.9,
								height = 0.75,
								preview_width = 0.6,
							},
						},
					},
					buffers = {
						-- initial_mode = "normal",
						previewer = false,
						mappings = {
							i = {
								["<c-d>"] = "delete_buffer",
							},
						},
						layout_config = {
							horizontal = {
								width = 0.5,
								height = 0.4,
								preview_width = 0.6,
							},
						},
					},
					lsp_references = {
						show_line = false,
						layout_config = {
							horizontal = {
								width = 0.9,
								height = 0.75,
								preview_width = 0.6,
							},
						},
					},
					treesitter = {
						show_line = false,
						sorting_strategy = nil,
						layout_config = {
							horizontal = {
								width = 0.9,
								height = 0.75,
								preview_width = 0.6,
							},
						},
						symbols = {
							"class",
							"function",
							"method",
							"interface",
							"type",
							"const",
							"variable",
							"property",
							"constructor",
							"module",
							"struct",
							"trait",
							"field",
						},
					},
				},
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					},
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							previewer = false,
							initial_mode = "normal",
							sorting_strategy = "ascending",
							layout_strategy = "horizontal",
							layout_config = {
								horizontal = {
									width = 0.5,
									height = 0.4,
									preview_width = 0.6,
								},
							},
						}),
					},
				},
			})
			telescope.load_extension("fzf")
			telescope.load_extension("ui-select")
			telescope.load_extension("dap")
			telescope.load_extension("zoxide")
		end,
		keys = {
			{ "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search Current Buffer" },
			{ "<leader>gf", "<cmd>Telescope git_files<cr>", desc = "Search [G]it [F]iles" },
			{ "<leader>sF", Util.telescope("files"), desc = "[S]earch [F]iles (root dir)" },
			{ "<leader>sf", Util.telescope("files", { cwd = false }), desc = "[S]earch [F]iles (cwd)" },
			{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "[S]earch [H]elp" },
			{
				"<leader>sW",
				Util.telescope("grep_string"),
				desc = "[S]earch current [W]ord (root dir)",
			},
			{
				"<leader>sw",
				Util.telescope("grep_string", { cwd = false }),
				desc = "[S]earch current [W]ord (cwd)",
			},
			{
				"<leader>sG",
				Util.telescope("live_grep"),
				desc = "[S]earch by [G]rep (root dir)",
			},
			{ "<leader>sg", Util.telescope("live_grep", { cwd = false }), desc = "[S]earch by [G]rep (cwd)" },
			{
				"<leader>sd",
				"<cmd>Telescope diagnostics bufnr=0<cr>",
				desc = "[S]earch [D]iagnostics (document)",
			},
			{
				"<leader>sD",
				"<cmd>Telescope diagnostics<cr>",
				desc = "[S]earch [D]iagnostics (workspace)",
			},
			{
				"<leader>?",
				"<cmd>Telescope oldfiles<cr>",
				desc = "[?] Find recently opened files",
			},
			{ "<leader><space>", "<cmd>Telescope buffers<cr>", desc = "[ ] Find existing buffers" },
		},
	},
}
