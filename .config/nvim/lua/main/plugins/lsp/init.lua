vim.g.DiagnosticSigns = { ERROR = "󰚌 ", WARN = " ", HINT = "󰌵", INFO = " " }
vim.g.LspKinds = {
	Array = "",
	Boolean = "󰨙",
	Class = "",
	Constant = "󰏿",
	Constructor = "󱁤",
	Enum = "",
	EnumMember = "",
	Event = "",
	Field = "󰜢",
	File = "󰈙",
	Function = "󰡱",
	Interface = "",
	Key = "",
	Method = "󰡱",
	Module = "",
	Namespace = "󰦮",
	Null = "󰟢",
	Number = "",
	Object = "",
	Operator = "",
	Package = "",
	Property = "󰜢",
	String = "󰉿",
	Struct = "󰆼",
	TypeParameter = "",
	Variable = "󰀫󰂡",
}

-- Hyprland treesitter support
vim.filetype.add({
	pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})
-- Hyprland LSP support
vim.api.nvim_create_autocmd("BufAdd", {
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
	"antosha417/nvim-lsp-file-operations", -- see setup fn in neotree.lua
	require("main.plugins.lsp.lint"),
	require("main.plugins.lsp.formatter"),

	require("main.plugins.lsp.lsp_config"),

	require("main.plugins.lsp.treesj"),
	require("main.plugins.lsp.treesitter"),

	require("main.plugins.lsp.lightbulb"),
}
