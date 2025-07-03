return {
	"lukas-reineke/indent-blankline.nvim",
	dependencies = {
		"HiPhish/rainbow-delimiters.nvim",
		{
			"echasnovski/mini.indentscope",
		},
	},
	config = function()
		require("mini.indentscope").setup({
			draw = {
				delay = 100,
				animation = require("mini.indentscope").gen_animation.quadratic({ easing = "in-out", duration = 15 }), -- <function: implements constant 20ms between steps>

				priority = 40,
			},
			mappings = { -- for more text-objects, see treesitter.lua
				object_scope = "is",
				object_scope_with_border = "as",
				goto_top = "",
				goto_bottom = "",
			},

			options = {
				border = "both",
				indent_at_cursor = true,
				try_as_border = true,
			},

			symbol = "│",
		})
		require("ibl").setup({
			indent = {
				char = "󰄾", -- 󰄾
				tab_char = "󰄾", -- 󰄾
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"help",
					"alpha",
					"dashboard",
					"neo-tree",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
					"undotree",
					"diff",
				},
			},
		})
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"help",
				"alpha",
				"dashboard",
				"neo-tree",
				"Trouble",
				"trouble",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
				"lazyterm",
				"undotree",
				"diff",
			},
			callback = function()
				vim.b.miniindentscope_disable = true
			end,
		})
		vim.g.rainbow_delimiters = {
			strategy = {
				[""] = require("rainbow-delimiters").strategy["global"],
				vim = require("rainbow-delimiters").strategy["local"],
			},
			query = {
				[""] = "rainbow-delimiters",
				lua = "rainbow-blocks",
			},
			priority = {
				[""] = 110,
				lua = 210,
			},
			highlight = {
				"RainbowDelimiterRed",
				"RainbowDelimiterYellow",
				"RainbowDelimiterBlue",
				"RainbowDelimiterOrange",
				"RainbowDelimiterGreen",
				"RainbowDelimiterViolet",
				"RainbowDelimiterCyan",
			},
		}
		vim.b.miniindentscope_disable = false
	end,
}
