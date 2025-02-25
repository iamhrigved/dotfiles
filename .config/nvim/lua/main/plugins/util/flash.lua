return {
	"folke/flash.nvim",
	config = function()
		require("flash").setup({
			modes = {
				char = {
					enabled = true,
					-- dynamic configuration for ftFT motions
					config = function(opts)
						-- autohide flash when in operator-pending mode
						opts.autohide = opts.autohide or (vim.fn.mode(true):find("no") and vim.v.operator == "y")

						-- disable jump labels when not enabled, when using a count,
						-- or when recording/executing registers
						opts.jump_labels = opts.jump_labels
							and vim.v.count == 0
							and vim.fn.reg_executing() == ""
							and vim.fn.reg_recording() == ""

						-- Show jump labels only in operator-pending mode
						-- opts.jump_labels = vim.v.count == 0 and vim.fn.mode(true):find("o")
					end,
					autohide = false,
					jump_labels = false,
					multi_line = true,
					label = { exclude = "hjkliardc" },
					keys = { "f", "F", "t", "T", ";", "," },
					---@alias Flash.CharActions table<string, "next" | "prev" | "right" | "left">
					char_actions = function(motion)
						return {
							[";"] = "next", -- set to `right` to always go right
							[","] = "prev", -- set to `left` to always go left
							[motion:lower()] = "next",
							[motion:upper()] = "prev",
						}
					end,
					search = { wrap = false },
					highlight = { backdrop = false },
					jump = { register = false },
				},
			},
		})

		vim.keymap.set({ "n", "x", "o" }, "s", function()
			require("flash").jump()
		end, {})
		vim.keymap.set({ "n" }, "S", function()
			require("flash").treesitter()
		end, {})
		vim.keymap.set({ "o", "x" }, "R", function()
			require("flash").treesitter_search()
		end, {})
		vim.keymap.set("c", "<C-c>", function()
			require("flash").toggle()
		end)

		-- find diagnostics
		vim.keymap.set("n", "<leader>fd", function()
			require("flash").jump({
				action = function(match, state)
					vim.api.nvim_win_call(match.win, function()
						vim.api.nvim_win_set_cursor(match.win, match.pos)
						vim.diagnostic.open_float()
					end)
					state:restore()
				end,
			})
		end)
	end,
}
