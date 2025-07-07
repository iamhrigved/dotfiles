return {
	-- mandatory dependencies
	"nvim-tree/nvim-web-devicons",
	"nvim-lua/plenary.nvim",
	"MunifTanjim/nui.nvim",
	"rcarriga/nvim-notify",

	-- telescope dependencies
	"jvgrootveld/telescope-zoxide",
	"nvim-telescope/telescope-ui-select.nvim",
	"nvim-telescope/telescope-frecency.nvim",
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},

	-- treesitter dependencies
	"nvim-treesitter/nvim-treesitter-textobjects",

	-- basic plugins
	{
		"kylechui/nvim-surround",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"ojroques/nvim-bufdel",
		config = function()
			require("bufdel").setup({
				next = "alternate",
				quit = false,
			})
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = "npm install",
	},
}
