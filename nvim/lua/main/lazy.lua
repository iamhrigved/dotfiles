local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

local plugins = {

	-- [[ Essentials: ]] --
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "jvgrootveld/telescope-zoxide" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"goolord/alpha-nvim",
		init = function()
			vim.b.miniindentscope_disable = true
		end,

		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"akinsho/toggleterm.nvim",
		cmd = "ToggleTerm",
		version = "*",
		config = true,
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
	},
	{
		"folke/noice.nvim",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
	},
	{
		"ojroques/nvim-bufdel",
		config = function() -- for keymappings, see remap.lua
			require("bufdel").setup({
				next = "alternate",
				quit = false,
			})
		end,
	},
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>ut", "<cmd>UndotreeToggle<CR>", {})
			vim.keymap.set("n", "<leader>uc", "<cmd>UndotreePersistUndo<CR>", {})
			vim.g.undotree_DiffCommand = "batdiff"
			vim.g.undotree_WindowLayout = 2
			vim.g.undotree_SplitWidth = 35
			vim.g.undotree_TreeVertShape = "⎪"
			vim.g.undotree_TreeSplitShape = "/"
			vim.g.undotree_TreeReturnShape = "\\"
		end,
	},

	-- [[ GIT ]] --
	{ "lewis6991/gitsigns.nvim" },

	-- [[ LSP, Autocompletions and, DAP : ]] --

	-- LSP and Formatting
	{
		"stevearc/conform.nvim",
		"mfussenegger/nvim-lint",
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig",
		{
			"zeioth/garbage-day.nvim",
			event = "VeryLazy",
			opts = {
				aggressive_mode = true,
				grace_period = 60, --seconds
				wakeup_delay = 5000, -- milliseconds
			},
		},
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-cmdline", -- for cmd auto complete
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-emoji",
		"uga-rosa/cmp-dictionary",
		"L3MON4D3/LuaSnip",
		"onsails/lspkind.nvim", -- for vscode like symbols for auto complete menu
	},

	-- Debugging
	{
		-- "mfussenegger/nvim-dap",
		-- "rcarriga/nvim-dap-ui",
		-- "nvim-neotest/nvim-nio",
		-- "theHamsta/nvim-dap-virtual-text",
	},

	-- Rust
	{
		"mrcjkb/rustaceanvim",
		ft = "rust",
		version = "^4", -- Recommended
	},

	--  [[ Themes: ]]      --

	{ "navarasu/onedark.nvim", event = "VimEnter" },
	-- { "akinsho/horizon.nvim", version = "*" },
	-- { "diegoulloao/neofusion.nvim", priority = 1000, config = true },
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	-- [[ General Purpose: ]] --

	{
		"kylechui/nvim-surround",
		version = "main",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	{
		"utilyre/barbecue.nvim",
		event = "LspAttach",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		event = "LspAttach",
		dependencies = {
			"kevinhwang91/promise-async",
			"luukvbaal/statuscol.nvim",
			"lewis6991/foldsigns.nvim",
		},
	},
	{
		"anuvyklack/windows.nvim",
		dependencies = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim",
			"echasnovski/mini.animate",
		},
	},
	{
		"folke/trouble.nvim",
		branch = "main",
		-- dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},

	"Wansmer/treesj",
	"folke/flash.nvim",
	"nvim-telescope/telescope-ui-select.nvim",
	"olimorris/persisted.nvim",
	"mistricky/codesnap.nvim",
	"stevearc/dressing.nvim",
	"tpope/vim-commentary",
	"RRethy/vim-illuminate",

	-- [[ Indentation Guides: ]] --

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
	},
	{
		"echasnovski/mini.indentscope",
		version = false,
		init = function()
			vim.b.miniindentscope_disable = true
		end,
	},
	"HiPhish/rainbow-delimiters.nvim",
}

require("lazy").setup(plugins, {
	install = {
		colorscheme = { "onedark" },
	},
	ui = {
		border = "rounded",
		title = " Lazy NVIM ",
		title_pos = "center",
	},
})

vim.keymap.set("n", "<leader>lz", "<cmd>Lazy<CR>")
