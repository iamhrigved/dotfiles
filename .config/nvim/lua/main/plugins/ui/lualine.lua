return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local filename_with_icon = require("lualine.components.filename"):extend()
		filename_with_icon.apply_icon = require("lualine.components.filetype").apply_icon
		filename_with_icon.icon_hl_cache = {}

		local default_cond = function()
			if vim.api.nvim_win_get_width(0) > 50 then
				return true
			else
				return false
			end
		end

		local lsp_name = function()
			local lsps = vim.lsp.get_clients({ bufnr = 0 })
			local names = "  LSP ~"

			for _, lsp in pairs(lsps) do
				names = names .. " " .. lsp.name
			end

			local formatters = require("conform").list_formatters(0)

			for _, formatter in ipairs(formatters) do
				names = names .. " " .. formatter.name
			end
			return names
		end

		local lualine_lsp = { -- NvChad style LSP status line
			lsp_name,
			color = { fg = "#80a1c0" },
			cond = function()
				if #vim.lsp.get_clients({ bufnr = 0 }) > 0 then
					return true
				else
					return false
				end
			end,
		}

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" }, --  
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {
						"alpha",
						"neo-tree",
						"undotree",
						"diff",
					},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = true,
			},
			sections = {
				lualine_a = {
					{
						"mode",
						icon = "",
						separator = { left = "", right = "" },
						padding = 1,
						color = { gui = "bold" },
					},
				},
				lualine_b = {
					-- {
					-- 	function()
					-- 		return ""
					-- 	end,
					-- 	padding = 0,
					-- 	color = { bg = "#42464e", fg = "#24272e" },
					-- },
					{
						filename_with_icon,
						color = { gui = "italic" },
						colored = true,
					},
				},
				lualine_c = {
					{
						"branch",
						icon = "", -- 
						color = "Comment", --DefaultCyan
					},
					{
						"diff",
						diff_color = {
							added = "Comment", --DefaultGreen
							removed = "Comment", --DefaultRed
							modified = "Comment", --DefaultBlue
						},
						symbols = {
							added = "󰐖 ",
							modified = " ",
							removed = "󰍵 ",
						},
					},
				},
				lualine_x = {
					{
						require("noice").api.statusline.mode.get,
						cond = require("noice").api.statusline.mode.has,
						color = { fg = "#ff9e64" },
					},
					{
						require("noice").api.status.command.get,
						cond = require("noice").api.status.command.has,
						color = "DefaultYellow",
						timeout = 50,
					},
					lualine_lsp,
				},
				lualine_y = {
					{
						"searchcount",
						timeout = 200,
						maxcount = 999,
					},
					{
						"progress",
						cond = default_cond,
					},
					-- {
					-- 	function()
					-- 		return ""
					-- 	end,
					-- 	padding = 0,
					-- 	color = { bg = "#42464e", fg = "#24272e" },
					-- 	cond = default_cond,
					-- },
				},
				lualine_z = {
					{
						"location",
						separator = { left = "", right = "" },
					},
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = { "filename" },
				lualine_c = { "filetype" },
				lualine_x = {},
				lualine_y = { "progress", "location" },
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
