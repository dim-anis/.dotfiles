return {
	"echasnovski/mini.ai",
	version = false,
	opts = {
		mappings = {
			-- Main textobject prefixes
			around = "a",
			inside = "i",

			-- Next/last variants
			around_next = "an",
			inside_next = "in",
			around_last = "al",
			inside_last = "il",

			-- Move cursor to corresponding edge of `a` textobject
			goto_left = "g[",
			goto_right = "g]",
		},
	},
}
