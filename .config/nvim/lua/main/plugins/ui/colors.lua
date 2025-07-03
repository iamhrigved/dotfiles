local function rgb(c)
	c = string.lower(c)
	return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

local function darken(foreground, alpha, background)
	alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
	local bg = rgb(background or "#000000")
	local fg = rgb(foreground)

	local blendChannel = function(i)
		local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
		return math.floor(math.min(math.max(0, ret), 255) + 0.5)
	end

	return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

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
					background = false,
				},
				code_style = {
					comments = "italic",
					functions = "italic",
					keywords = "italic",
				},
				colors = {
					bg3 = "#24272e", -- lualine background color darkened by 20%
				}, -- Override default colors
			})
			-- vim.cmd("colorscheme tokyonight-storm")

			-- CUSTOM HIGHLIGHTS --
			vim.cmd("hi link DefaultGreen TSRainbowGreen")
			vim.cmd("hi link DefaultRed TSRainbowRed")
			vim.cmd("hi link DefaultOrange TSRainbowOrange")
			vim.cmd("hi link DefaultBlue TSRainbowBlue")
			vim.cmd("hi link DefaultCyan TSRainbowCyan")
			vim.cmd("hi link DefaultViolet TSRainbowViolet")
			vim.cmd("hi link DefaultYellow TSRainbowYellow")

			vim.cmd("hi DiagnosticUnderlineInfo cterm=undercurl gui=undercurl guisp=#48b0bd")

			vim.cmd("hi NormalFloat guibg=none")

			vim.cmd("hi! link FloatBorder DiagnosticInfo")
			vim.cmd("hi! link NeoTreeFloatTitle DiagnosticInfo")

			vim.cmd("hi! link Directory DefaultOrange")

			-- vim.cmd("hi! Visual guibg=#0a3960") -- #1b3159

			-- vim.cmd("hi! PmenuSel guibg=#0a3960 guifg=NONE gui=NONE cterm=NONE")

			-- vim.cmd("hi! link NotifyINFOIcon TSRainbowGreen")
			-- vim.cmd("hi! link NotifyINFOTitle TSRainbowGreen")
			--
			-- vim.cmd("hi! link NotifyERRORIcon TSRainbowRed")
			-- vim.cmd("hi! link NotifyERRORTitle TSRainbowRed")
			--
			-- vim.cmd("hi! link NotifyWARNIcon TSRainbowOrange")
			-- vim.cmd("hi! link NotifyWARNTitle TSRainbowOrange")
			--
			vim.cmd("hi! lualine_a_normal guibg=#81a1c1")

			vim.cmd("hi! link TelescopeSelection Visual")
			vim.cmd("hi! link TelescopeMatching CmpItemAbbrMatch")

			vim.cmd("hi! NeoTreeDirectoryIcon guifg=#c09553")
			vim.cmd("hi! link NeoTreeDirectoryName Normal")

			-- vim.cmd("hi! MiniIndentscopeSymbol guifg=#346a73")
			-- vim.cmd("hi! MiniIndentscopeSymbolOff guifg=#823c45")
			-- vim.cmd("hi! NonText guifg=#393E45")

			-- neovim v0.11.0
			vim.cmd("hi! WinBar guibg=NONE")
			vim.cmd("hi! WinBarNC guibg=NONE")
			vim.cmd("hi! StatusLine guibg=NONE")
			vim.cmd("hi! StatusLineNC guibg=NONE")
			vim.cmd("hi! TabLineFill guibg=NONE")

			vim.cmd("hi! link DiagnosticVirtualLinesError DiagnosticVirtualTextError")
			vim.cmd("hi! link DiagnosticVirtualLinesWarn DiagnosticVirtualTextWarn")
			vim.cmd("hi! link DiagnosticVirtualLinesHint DiagnosticVirtualTextHint")
			vim.cmd("hi! link DiagnosticVirtualLinesInfo DiagnosticVirtualTextInfo")
			vim.cmd("hi! link DiagnosticVirtualLinesOk DiagnosticVirtualTextOk")
		end,
	},
	{ "akinsho/horizon.nvim", version = "*" },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				transparent = true,
				styles = {
					functions = { italic = true },
					keywords = { italic = true },
					comments = { italic = true },
					sidebars = "transparent",
					floats = "transparent",
				},
				lualine_bold = true,

				on_colors = function(colors)
					-- for lualine transparency
					colors.bg_statusline = colors.none
				end,

				on_highlights = function(hl, color)
					hl.IncSearch = { bg = color.magenta, fg = color.black }

					hl.DiagnosticVirtualTextError = { bg = "none", fg = darken(color.error, 0.8) }
					hl.DiagnosticVirtualTextWarn = { bg = "none", fg = darken(color.warning, 0.8) }
					hl.DiagnosticVirtualTextInfo = { bg = "none", fg = darken(color.info, 0.8) }
					hl.DiagnosticVirtualTextHint = { bg = "none", fg = darken(color.hint, 0.8) }

					hl.GitSignsAdd = { fg = darken(color.green, 0.6) }
					hl.GitSignsChange = { fg = color.git.change }
					hl.GitSignsDelete = { fg = color.git.delete }

					hl.String = { fg = color.green, italic = true }

					hl.TabLineSel = { fg = color.black, bg = color.blue }
					hl.TabLine = { fg = color.black, bg = color.blue }

					hl.FlashLabel = { bg = color.red1, fg = color.black }

					hl.MiniIndentscopeSymbol = { fg = darken(color.blue, 0.7), nocombine = true }

					hl.BufferLineCloseButton = { fg = "none", bg = "none" }
				end,
			})

			-- vim.cmd.colorscheme("tokyonight-storm")
		end,
	},
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_foreground = "material"
			vim.g.gruvbox_material_enable_italic = true
			vim.g.gruvbox_material_transparent_background = 2
			vim.g.gruvbox_material_diagnostic_text_highlight = 0
			vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
			vim.g.gruvbox_material_current_word = "grey background"
			vim.g.gruvbox_material_inlay_hints_background = "dimmed"

			vim.api.nvim_create_autocmd("ColorScheme", {
				desc = "Applying custom highlights on gruvbox colorscheme",
				pattern = "gruvbox-material",
				callback = function()
					vim.cmd("hi! NormalFloat guibg=NONE")
					vim.cmd("hi! FloatBorder guibg=NONE")
				end,
			})

			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				transparent = true,
			})
		end,
	},
	{
		"tiagovla/tokyodark.nvim",
		config = function(_, opts)
			require("tokyodark").setup(opts) -- calling setup is optional
		end,
	},
}
