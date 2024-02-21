return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	init = function()
		require("which-key").register({ o = { name = "+obsidian" } }, { prefix = "<leader>", mode = { "n", "v" } })
	end,
	keys = {
		{ "<leader>on", "<cmd>ObsidianNew<CR>", desc = "New Note" },
		{ "<leader>od", "<cmd>ObsidianToday<CR>", desc = "Todays Note" },
	},
	opts = {
		dir = "~/Documents/obsidian",
		notes_subdir = "./",
		ui = { enable = false },
		completion = {
			nvim_cpm = true,
			min_chars = 2,
		},
		preferred_link_style = "markdown",
		new_notes_location = "notes_subdir",
		mappings = {
			-- Open obsidian link.
			["fo"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			-- Toggle check-boxes.
			["<leader>ch"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true },
			},
		},
		prepend_note_id = true,
		-- Optional, customize how names/IDs for new notes are created.
		note_id_func = function(title)
			-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
			-- In this case a note with the title 'My new note' will be given an ID that looks
			-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
			local suffix = ""
			if title ~= nil then
				-- If title is given, transform it into valid file name.
				suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				-- If title is nil, just add 4 random uppercase letters to the suffix.
				for _ = 1, 4 do
					suffix = suffix .. string.char(math.random(65, 90))
				end
			end
			-- return tostring(os.date("%Y%m%d%H%M%S")) .. "-" .. suffix
			return tostring(os.time()) .. "-" .. suffix
		end,
		log_level = vim.log.levels.INFO,
		daily_notes = {
			folder = "/daily",
			-- Optional, if you want to change the date format for the ID of daily notes.
			date_format = "%Y-%m-%d",
			-- Optional, if you want to change the date format of the default alias of daily notes.
			alias_format = "%B %-d, %Y",
			-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
			-- template = "templates/daily.md",
		},
		templates = {
			subdir = "templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
			-- A map for custom variables, the key should be the variable and the value a function
			substitutions = {},
		},

		-- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
		-- URL it will be ignored but you can customize this behavior here.
		follow_url_func = function(url)
			-- Open the URL in the default web browser.
			vim.fn.jobstart({ "open", url }) -- Mac OS
			-- vim.fn.jobstart({"xdg-open", url})  -- linux
		end,

		-- Optional, set to true if you use the Obsidian Advanced URI plugin.
		-- https://github.com/Vinzent03/obsidian-advanced-uri
		use_advanced_uri = false,

		picker = {
			name = "telescope.nvim",
			mappings = {
				-- Create a new note from your query.
				new = "<C-x>",
				-- Insert a link to the selected note.
				insert_link = "<C-l>",
			},
		},
		-- Specify how to handle attachments.
		attachments = {
			img_folder = "assets/imgs",
		},
	},
}
