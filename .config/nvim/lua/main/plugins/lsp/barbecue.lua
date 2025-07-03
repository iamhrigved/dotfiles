return {
	"utilyre/barbecue.nvim",
	config = function()
		require("barbecue").setup({
			exclude_filetypes = { "toggleterm" },
			theme = "tokyonight-storm",
			kinds = vim.g.LspKinds,
		})
	end,
}
