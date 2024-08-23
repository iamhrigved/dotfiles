return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	config = function() 
		require("neo-tree").setup({
			popup_border_style = "rounded",
			enable_diagnostics = true,
			window = {
				width = 36,
				mappings = {
					["<space>"] = "",
					["l"] = "open",
					["h"] = "close_node",
					["s"] = "open_vsplit",
					["S"] = "open_split",
					["a"] = { "add", config = { show_path = "relative", } },
					["H"] = "toggle_hidden",
				}
			},
			filesystem = {
				filtered_items = {
					visible = nil,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = false,
				},
				hijack_netrw_behavior = "open_default",
			}
			,
		})

		vim.keymap.set("n", "<leader>nt", "<cmd>Neotree reveal left<cr>", {})
		vim.keymap.set("n", "<leader>nx", "<cmd>Neotree close<cr>", {})
		vim.keymap.set("n", "<leader>nf", "<cmd>Neotree float reveal<cr>", {})
	end,
}
