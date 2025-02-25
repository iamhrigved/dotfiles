return {
	"nvim-telescope/telescope.nvim",
	config = function()
		local builtin = require("telescope.builtin")
		local trouble = require("trouble.sources.telescope")
		local z_utils = require("telescope._extensions.zoxide.utils")

		local function getVisualSelection()
			vim.cmd('noau normal! "vy"')
			local text = vim.fn.getreg("v")
			vim.fn.setreg("v", {})

			text = string.gsub(text, "\n", "")
			if #text > 0 then
				return text
			else
				return ""
			end
		end

		-- symlink support
		vim.keymap.set("n", "<leader>ff", function()
			return builtin.find_files({ follow = true })
		end, {})
		vim.keymap.set("n", "<leader>hh", builtin.help_tags, {})
		vim.keymap.set("n", "<leader>fw", function()
			return builtin.live_grep({ additional_args = { "-L" } })
		end, {})
		vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, {})
		vim.keymap.set("n", "<leader>ws", builtin.lsp_workspace_symbols, {})
		vim.keymap.set("n", "<leader>fz", builtin.current_buffer_fuzzy_find, {})
		vim.keymap.set("n", "<leader>gs", function()
			return builtin.grep_string({ additional_args = { "-L" } })
		end, {})
		vim.keymap.set("v", "gs", function()
			return builtin.grep_string({ additional_args = { "-L" }, default_text = getVisualSelection() })
		end, {})
		vim.keymap.set("n", "<leader>of", builtin.oldfiles, {})
		vim.keymap.set("n", "<leader>fc", builtin.commands, {})

		vim.keymap.set("n", "gr", builtin.lsp_references, {})
		vim.keymap.set("n", "gi", builtin.lsp_implementations, {})
		vim.keymap.set("n", "<leader>dg", builtin.diagnostics, {})
		vim.keymap.set("n", "dg", function()
			return builtin.diagnostics({ bufnr = 0 })
		end, {})

		require("telescope").setup({
			defaults = {
				layout_strategy = "horizontal",
				sorting_strategy = "ascending",
				mappings = {
					i = {
						["<c-t>"] = trouble.open,
						["<c-n>"] = require("telescope.actions").move_selection_next,
						["<c-e>"] = require("telescope.actions").move_selection_previous,
						["<C-s>"] = require("telescope.actions").select_vertical,
						["<C-h>"] = require("telescope.actions").select_horizontal,
					},
					n = { ["<c-t>"] = trouble.open },
				},
				layout_config = {
					prompt_position = "top",
					width = 0.85,
				},
			},
			pickers = {
				sorting_strategy = "ascending",
				current_buffer_fuzzy_find = {
					sorting_strategy = "ascending",
					theme = "dropdown",
					previewer = false,
					layout_config = {
						width = 0.6,
						height = 0.5,
					},
				},
			},
			extensions = {
				zoxide = {
					prompt_title = " Zoxide ",
					mappings = {
						default = {
							action = function(selection)
								vim.cmd("SessionSave")
								if vim.bo.filetype == "alpha" then
									vim.cmd("BufDel!")
								else
									vim.cmd("BufDelAll")
								end
								vim.cmd.cd(selection.path)
								require("oil").open(selection.path)
							end,
							after_action = function(selection)
								print('Switched to "' .. selection.path .. '"')
								vim.schedule(function()
									vim.cmd("silent SessionLoad")
								end)
							end,
						},
						["<C-s>"] = { action = z_utils.create_basic_command("split") },
						["<C-v>"] = { action = z_utils.create_basic_command("vsplit") },
						["<C-e>"] = { action = z_utils.create_basic_command("edit") },
						["<C-t>"] = {},
					},
				},
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				},
			},
		})
		require("telescope").load_extension("ui-select")
		require("telescope").load_extension("persisted")
		require("telescope").load_extension("zoxide")
		require("telescope").load_extension("fzf")
		vim.keymap.set("n", "<leader>cd", require("telescope").extensions.zoxide.list)
	end,
}
