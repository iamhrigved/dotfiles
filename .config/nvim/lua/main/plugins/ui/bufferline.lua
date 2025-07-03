return {
	"akinsho/bufferline.nvim",
	config = function()
		local DiagnosticSigns = vim.g.DiagnosticSigns

		require("bufferline").setup({
			options = {
				mode = "buffers", -- set to "tabs" to only show tabpages instead
				themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
				numbers = function(opts)
					-- return string.format("%s", opts.raise(opts.ordinal))
				end,
				close_command = "bdelete! %d", -- can be a string | function, | false see "Mouse actions"
				right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
				left_mouse_command = "buffer %d", -- can be a string | function, | false see "Mouse actions"
				middle_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
				indicator = {
					icon = "", --▍▐ this should be omitted if indicator style is not 'icon'
					style = "icon",
				},
				buffer_close_icon = "", -- 
				modified_icon = "●",
				close_icon = "", --
				hover = {
					enabled = true,
					delay = 1,
					reveal = { "close" }, -- { "close" },
				},
				left_trunc_marker = "",
				right_trunc_marker = "",
				style_preset = {
					require("bufferline").style_preset.no_italic,
				},
				max_name_length = 15,
				max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
				truncate_names = true, -- whether or not tab names should be truncated
				tab_size = 16,
				diagnostics = "nvim_lsp",
				offsets = {
					{
						filetype = "neo-tree",
						text = "File Explorer",
						text_align = "center",
						seperator = true,
						highlight = "NeoTreeRootName",
					},
					{
						filetype = "oil",
						text = "Oil Explorer",
						text_align = "center",
						seperator = true,
						highlight = "NeoTreeRootName",
					},
					{
						filetype = "undotree",
						text = "Undo Tree",
						text_align = "center",
						seperator = true,
						highlight = "NeoTreeRootName",
					},
					{
						filetype = "diff",
						text = "Undo Diff",
						text_align = "center",
						seperator = true,
						highlight = "NeoTreeRootName",
					},
				},
				color_icons = true,
				separator_style = { "  ", "  " },
				custom_areas = {
					right = function()
						local result = {}
						local severity = vim.diagnostic.severity
						local errorc = #vim.diagnostic.get(0, { severity = severity.ERROR })
						local warningc = #vim.diagnostic.get(0, { severity = severity.WARN })
						local infoc = #vim.diagnostic.get(0, { severity = severity.INFO })
						local hintc = #vim.diagnostic.get(0, { severity = severity.HINT })

						if errorc ~= 0 then
							table.insert(result, {
								text = DiagnosticSigns["ERROR"] .. errorc .. "  ",
								link = "DiagnosticSignError",
							})
						end

						if warningc ~= 0 then
							table.insert(result, {
								text = DiagnosticSigns["WARN"] .. warningc .. "  ",
								link = "DiagnosticSignWarn",
							})
						end

						if hintc ~= 0 then
							table.insert(
								result,
								{ text = DiagnosticSigns["HINT"] .. " " .. hintc .. "  ", link = "DiagnosticSignHint" }
							)
						end

						if infoc ~= 0 then
							table.insert(
								result,
								{ text = DiagnosticSigns["INFO"] .. infoc .. "  ", link = "DiagnosticSignInfo" }
							)
						end
						table.insert(result, { text = "   " })
						return result
					end,
				},
			},
			highlights = {
				fill = {
					fg = "",
					bg = "",
				},
				background = {
					fg = "",
					bg = "",
				},
			},
		})

		vim.keymap.set("n", "<leader>bl", "<cmd>BufferLinePick<CR>", { noremap = true })
		vim.keymap.set("n", "I", "<cmd>BufferLineCycleNext<CR>", { noremap = true })
		vim.keymap.set("n", "M", "<cmd>BufferLineCyclePrev<CR>", { noremap = true })
	end,
}

-- see eventlistners for iconhl autocmd
