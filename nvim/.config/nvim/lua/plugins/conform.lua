return {
	{
		"stevearc/conform.nvim",
		dependencies = { "mason.nvim" },
		lazy = true,
		cmd = "ConformInfo",
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = false, timeout_ms = 500, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
			{
				"leader>cF",
				function()
					require("conform").format({ formatters = { "injected" } })
				end,
				mode = { "n", "v" },
				desc = "Format Injected Langs",
			},
		},
		opts = {
			formatters_by_ft = {
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				javascriptreact = { { "prettierd", "prettier" } },
				typescriptreact = { { "prettierd", "prettier" } },
				json = { { "prettierd", "prettier" } },
				css = { { "prettierd", "prettier" } },
				html = { { "prettierd", "prettier" } },
				markdown = { { "prettierd", "prettier" } },
				lua = { "stylua" },
			},
			formatters = {},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 500,
			},
		},
		config = function(_, opts)
			opts.formatters = opts.formatters or {}
			for name, formatter in pairs(opts.formatters) do
				if type(formatter) == "table" then
					local ok, defaults = pcall(require, "conform.formatters." .. name)
					if ok and type(defaults) == "table" then
						opts.formatters[name] = vim.tbl_deep_extend("force", {}, defaults, formatter)
					end
				end
			end
			require("conform").setup(opts)
		end,
	},
}
