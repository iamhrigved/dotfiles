-- return {
-- 	"nvim-neo-tree/neo-tree.nvim",
-- 	branch = "v3.x",
-- 	config = function()
-- 		require("neo-tree").setup({
-- 			popup_border_style = "rounded",
-- 			enable_diagnostics = true,
-- 			window = {
-- 				width = 36,
-- 				mappings = {
-- 					["<space>"] = "",
-- 					["e"] = "",
-- 					["i"] = "open",
-- 					["m"] = "close_node",
-- 					["v"] = "move",
-- 					["s"] = "open_vsplit",
-- 					["S"] = "open_split",
-- 					["a"] = { "add", config = { show_path = "relative" } },
-- 					["H"] = "toggle_hidden",
-- 				},
-- 			},
-- 			filesystem = {
-- 				filtered_items = {
-- 					visible = nil,
-- 					hide_dotfiles = false,
-- 					hide_gitignored = false,
-- 				},
-- 				follow_current_file = {
-- 					enabled = true,
-- 					leave_dirs_open = false,
-- 				},
-- 				hijack_netrw_behavior = "open_default",
-- 			},
-- 			default_component_configs = {
-- 				git_status = {
-- 					symbols = {
-- 						-- Change type
-- 						added = "",
-- 						modified = "",
-- 						deleted = "󱎘",
-- 						renamed = "",
-- 						-- Status type
-- 						untracked = "",
-- 						ignored = "",
-- 						unstaged = "󰄱",
-- 						staged = "",
-- 						conflict = "",
-- 					},
-- 				},
-- 			},
-- 		})
--
-- 		vim.keymap.set("n", "<C-k>", "<cmd>Neotree toggle reveal left<cr>", {})
-- 		vim.keymap.set("n", "<leader>nf", "<cmd>Neotree float reveal<cr>", {})
--
-- 		require("lsp-file-operations").setup()
-- 	end,
-- }
