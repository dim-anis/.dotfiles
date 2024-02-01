return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		tag = "0.1.5",
		event = "VimEnter",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"jvgrootveld/telescope-zoxide",
			{
				"nvim-tree/nvim-web-devicons",
				opts = {
					override_by_extension = {
						astro = {
							icon = "",
							color = "#EF8547",
							name = "astro",
						},
					},
				},
			},
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

			vim.keymap.set(
				"n",
				"<leader><space>",
				require("telescope.builtin").buffers,
				{ desc = "[ ] Find existing buffers" }
			)

			local function telescope_live_grep_open_files()
				require("telescope.builtin").live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end

			vim.keymap.set("n", "<leader>s/", telescope_live_grep_open_files, { desc = "[S]earch [/] in Open Files" })
			vim.keymap.set(
				"n",
				"<leader>ss",
				require("telescope.builtin").builtin,
				{ desc = "[S]earch [S]elect Telescope" }
			)

			vim.keymap.set("n", "<leader>/", function()
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily earch in current buffer" })

			vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
			vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "[S]earch [H]elp" })
			vim.keymap.set(
				"n",
				"<leader>sw",
				require("telescope.builtin").grep_string,
				{ desc = "[S]earch current [W]ord (root dir)" }
			)
			vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sG", ":LiveGrepGitRoot<cr>", { desc = "[S]earch by [G]rep on Git Root" })
			vim.keymap.set(
				"n",
				"<leader>sd",
				require("telescope.builtin").diagnostics,
				{ desc = "[S]earch [D]iagnostics" }
			)
			vim.keymap.set(
				"n",
				"<leader>?",
				require("telescope.builtin").oldfiles,
				{ desc = "[?] Find recently opened files" }
			)
		end,
	},
}
