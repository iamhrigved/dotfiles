return {
	-- mandatory dependencies
	"nvim-tree/nvim-web-devicons",
	"nvim-lua/plenary.nvim",
	"christoomey/vim-tmux-navigator",
	"MunifTanjim/nui.nvim",
	"rcarriga/nvim-notify",

	-- telescope dependencies
	"jvgrootveld/telescope-zoxide",
	"nvim-telescope/telescope-ui-select.nvim",
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},

	-- treesitter dependencies
	"nvim-treesitter/nvim-treesitter-textobjects",

	-- basic plugins
	{
		"kylechui/nvim-surround",
		version = "main",
		event = "VeryLazy",
		opts = {},
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
}
