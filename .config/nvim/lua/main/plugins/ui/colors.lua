return {
	{
		"navarasu/onedark.nvim",
		config = function()
			require("onedark").setup({
				style = "darker",
				transparent = true,
				ending_tildes = false,
				lualine = {
					transparent = true,
				},
				diagnostics = {
					darker = true,
					undercurl = true,
					background = true,
				},
				colors = {
					bg3 = "#2d3139", -- lualine background color
				}, -- Override default colors
			})
			vim.cmd("colorscheme onedark")

			-- CUSTOM HIGHLIGHTS --
			vim.cmd("hi link DefaultGreen TSRainbowGreen")
			vim.cmd("hi link DefaultRed TSRainbowRed")
			vim.cmd("hi link DefaultOrange TSRainbowOrange")
			vim.cmd("hi link DefaultBlue TSRainbowBlue")
			vim.cmd("hi link DefaultCyan TSRainbowCyan")
			vim.cmd("hi link DefaultViolet TSRainbowViolet")
			vim.cmd("hi link DefaultYellow TSRainbowYellow")

			vim.cmd("hi NormalFloat guibg=none")

			vim.cmd("hi! link FloatBorder DiagnosticInfo")
			vim.cmd("hi! link NeoTreeFloatTitle DiagnosticInfo")

			vim.cmd("hi! VisualIlluminate ctermbg=242 guibg=#323641")
			vim.cmd("hi! Visual guibg=#1b3159")

			vim.cmd("hi! link NotifyINFOIcon TSRainbowGreen")
			vim.cmd("hi! link NotifyINFOTitle TSRainbowGreen")

			vim.cmd("hi! link NotifyERRORIcon TSRainbowRed")
			vim.cmd("hi! link NotifyERRORTitle TSRainbowRed")

			vim.cmd("hi! link NotifyWARNIcon TSRainbowOrange")
			vim.cmd("hi! link NotifyWARNTitle TSRainbowOrange")

			vim.cmd("hi! lualine_a_normal guibg=#81a1c1")

			vim.cmd("hi! link TelescopeSelection Visual")
			vim.cmd("hi! link TelescopeMatching CmpItemAbbrMatch")

			vim.cmd("hi! NeoTreeDirectoryIcon guifg=#c09553")
			vim.cmd("hi! link NeoTreeDirectoryName Normal")

			vim.cmd("hi! MiniIndentscopeSymbol guifg=#346a73")
			vim.cmd("hi! MiniIndentscopeSymbolOff guifg=#823c45")
			vim.cmd("hi! NonText guifg=#393E45")

			vim.cmd("hi! FlashLabel guibg=#e55561 guifg=#1f2329")

			vim.cmd("hi MiniAnimateCursor guifg=#c0caf5")

			-- colors formed by mixing default colors with bg colors
			vim.cmd("hi GitSignsAdd guifg=#57704a")
			vim.cmd("hi GitSignsChange guifg=#37658b")
		end,
	},
	{ "akinsho/horizon.nvim", version = "*" },
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"tiagovla/tokyodark.nvim",
		opts = {
			-- custom options here
		},
		config = function(_, opts)
			require("tokyodark").setup(opts) -- calling setup is optional
		end,
	},
}
