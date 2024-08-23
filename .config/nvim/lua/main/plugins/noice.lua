return {
	"folke/noice.nvim",
	config = function()
		require("noice").setup({
			cmdline = {
				enabled = true,
				view = "cmdline_popup",
				format = {
					cmdline = { pattern = "^:", icon = "", lang = "vim" },
					search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
					search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
					filter = { title = " Command ", pattern = "^:%s*!", icon = "$ ", lang = "bash" },
					lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
					help = { pattern = "^:%s*he?l?p?%s+", icon = "󰋖" },
				},
			},
			messages = {
				enabled = true, -- enables the Noice messages UI
				view = "notify", -- default view for messages
				view_error = "notify", -- view for errors
				view_warn = "notify", -- view for warnings
				view_history = "messages", -- view for :messages
				view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
			},
			popupmenu = {
				enabled = false,
				backend = "nui", 
				kind_icons = {}, 
			},
			redirect = {
				view = "popup",
				filter = { event = "msg_show" },
			},
			commands = {
				history = {
					view = "popup",
					opts = {
						enter = true,
						format = "details",
						position = "50%",
						size = {
							width = "90%",
							height = "80%",
						},
					},
					filter = {
						any = {
							{ event = "notify" },
							{ error = true },
							{ warning = true },
							{ event = "msg_show", kind = { "" } },
							{ event = "lsp", kind = "message" },
						},
					},
				},
				all = {
					view = "popup",
					opts = {
						enter = true,
						format = "details",
						position = "50%",
						size = {
							width = "90%",
							height = "80%",
						},
					},
				},
				last = {
					view = "popup",
					opts = { enter = true, format = "details" },
					filter = {
						any = {
							{ event = "notify" },
							{ error = true },
							{ warning = true },
							{ event = "msg_show", kind = { "" } },
							{ event = "lsp", kind = "message" },
						},
					},
					filter_opts = { count = 1 },
				},
				errors = {
					view = "popup",
					opts = { enter = true, format = "details" },
					filter = { error = true },
					filter_opts = { reverse = true },
				},
			},
			notify = {
				enabled = true,
				view = "notify",
				replace = false,
			},
			lsp = {
				progress = {
					enabled = true,
					format = "lsp_progress",
					format_done = "lsp_progress_done",
					throttle = 10 / 30, -- frequency to update lsp progress message
					view = "mini",
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = false,
					["vim.lsp.util.stylize_markdown"] = false,
					["cmp.entry.get_documentation"] = false,
				},
				hover = {
					enabled = true,
					silent = false,
					view = "hover",
					opts = {},
				},
				signature = {
					enabled = true,
					auto_open = {
						enabled = true,
						trigger = true, 
						luasnip = true,
						throttle = 50,
					},
					view = nil,
					opts = {},
				},
				message = {
					enabled = true,
					view = "notify",
					opts = {},
				},
				documentation = {
					view = "hover",
					opts = {
						lang = "markdown",
						replace = true,
						render = "plain",
						format = { "{message}" },
						position = { row = 2, col = 2 },
						size = {
							max_width = math.floor(0.8 * vim.api.nvim_win_get_width(0)),
							max_height = 15,
						},
						border = {
							style = "rounded",
						},
						win_options = {
							concealcursor = "n",
							conceallevel = 0,
							winhighlight = {
								Normal = "CmpPmenu",
								FloatBorder = "DiagnosticSignInfo",
							},
						},
					},
				},
			},
			markdown = {
				hover = {
					["|(%S-)|"] = vim.cmd.help,
					["%[.-%]%((%S-)%)"] = require("noice.util").open,
				},
				highlights = {
					["|%S-|"] = "@text.reference",
					["@%S+"] = "@parameter",
					["^%s*(Parameters:)"] = "@text.title",
					["^%s*(Return:)"] = "@text.title",
					["^%s*(See also:)"] = "@text.title",
					["{%S-}"] = "@parameter",
				},
			},
			health = {
				checker = true,
			},
			smart_move = {
				enabled = true, -- you can disable this behaviour here
				excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" },
			},
			presets = {
				bottom_search = false, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = true, -- enables an input dialog for inc-rename.nvim
			},
			throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
			views = {
				split = {
					win_options = {
						winhighlight = { Normal = "Normal" },
						winblend = 0,
					},
				},
				popup = {
					win_options = {
						winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticSignInfo" },
						winblend = 0,
					},
				},
				mini = {
					win_options = {
						winhighlight = { Normal = "Normal" },
						winblend = 0,
					},
				},
				vsplit = {
					win_options = {
						winhighlight = { Normal = "Normal" },
						winblend = 0,
					},
				},
			},
			cmdline_popup = {}, ---@see section on views
			routes = {
				{
					filter = {
						event = "msg_show",
						find = "Some options have changed, please run `:Neotree migrations` to see the changes",
					},
					opts = {
						skip = true,
					},
				},
				{
					filter = {
						event = "msg_show",
						any = {
							min_width = 20,
							min_height = 2,
						},
					},
					view = "split",
				},
			},
			status = {},
			format = {
				lsp_progress_done = {
					{ " ", hl_group = "NoiceLspProgressSpinner" },
					{ "{data.progress.title} ", hl_group = "NoiceLspProgressTitle" },
					{ "{data.progress.client} ", hl_group = "NoiceLspProgressClient" },
				},
			}, 
		})

		require("notify").setup({
			background_colour = "#000000",
		})

		vim.keymap.set("n", "<leader>no", "<cmd>Noice<CR>")
		vim.keymap.set("n", "<leader>na", "<cmd>Noice all <CR>")
		vim.keymap.set("n", "<leader>nq", function()
			require("notify").dismiss({ silent = true, pending = true })
		end)
	end
}
