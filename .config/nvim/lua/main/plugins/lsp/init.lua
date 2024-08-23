vim.g.DiagnosticSigns = { ERROR = "󰅙 ", WARN = " ", HINT = "󰌵", INFO = " " }
vim.g.LspKinds = {
	Class = "󰠱", --
	Color = "",
	Constant = "󰏿", -- 
	Constructor = "󱁤",
	Enum = "",
	EnumMember = "",
	Event = "", --
	Field = "󰜢",
	File = "󰈙",
	Folder = "󰉋",
	Function = "󰡱 ", --
	Interface = "", --
	Keyword = "󰌋",
	Method = "", --
	Module = "", --
	Operator = "󰆕",
	Property = "",
	Reference = "",
	Snippet = "", -- 
	Struct = "󰙅",
	Text = "󰉿", --
	TypeParameter = "",
	Unit = "",
	Value = "󰎠",
	Variable = "󰀫󰂡",
}

-- Hyprland treesitter support
vim.filetype.add({
	pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})
-- Hyprland LSP support
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.hl", "hypr*.conf" },
	callback = function(event)
		vim.lsp.start({
			name = "hyprlang",
			cmd = { "hyprls" },
			root_dir = vim.fn.getcwd(),
		})
	end,
})
-- Hyprland comment support
vim.api.nvim_create_autocmd("Filetype", {
	pattern = "hyprlang",
	callback = function()
		vim.bo.commentstring = "# %s"
	end,
})

return {
	-- cmp dependencies
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-emoji",
	"uga-rosa/cmp-dictionary",
	"onsails/lspkind.nvim",
	"L3MON4D3/LuaSnip",
	"windwp/nvim-autopairs",

	"mrcjkb/rustaceanvim",

	require("main.plugins.lsp.cmp_config"),

	require("main.plugins.lsp.barbecue"),

	-- lsp dependencies
	"SmiteshP/nvim-navic",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig",
	require("main.plugins.lsp.lint"),
	require("main.plugins.lsp.formatter"),

	require("main.plugins.lsp.lsp_config"),
}
