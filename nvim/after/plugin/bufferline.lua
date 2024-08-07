local DiagnosticSigns = vim.g.DiagnosticSigns

local bufferline = require("bufferline")
bufferline.setup({
	options = {
		mode = "buffers", -- set to "tabs" to only show tabpages instead
		themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
		numbers = "none", --| "ordinal" | "buffer_id" | "both", --| function({ ordinal, id, lower, raise }): string,
		close_command = "bdelete! %d", -- can be a string | function, | false see "Mouse actions"
		right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
		left_mouse_command = "buffer %d", -- can be a string | function, | false see "Mouse actions"
		middle_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
		indicator = {
			icon = "▎", -- ▎this should be omitted if indicator style is not 'icon'
			style = "icon",
		},
		buffer_close_icon = "󰅖 ",
		modified_icon = "●",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 15,
		max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
		truncate_names = true, -- whether or not tab names should be truncated
		tab_size = 18,
		diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = false,
		-- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
		diagnostics_indicator = nil, -- function(count, level, diagnostics_dict, context)
		--local diagnostics = " "
		--for e, c in pairs(diagnostics_dict) do
		--	diagnostics = diagnostics .. c .. " " .. signs[e] .. " "
		--end

		--return diagnostics
		--end,
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
		style_preset = {
			--bufferline.style_preset.minimal,
			--bufferline.style_preset.no_italic,
			--bufferline.style_preset.no_bold,
		},
		color_icons = true,
		separator_style = { "", "" },
		custom_areas = {
			right = function()
				local result = {}
				local severity = vim.diagnostic.severity
				local errorc = #vim.diagnostic.get(0, { severity = severity.ERROR })
				local warningc = #vim.diagnostic.get(0, { severity = severity.WARN })
				local infoc = #vim.diagnostic.get(0, { severity = severity.INFO })
				local hintc = #vim.diagnostic.get(0, { severity = severity.HINT })

				if errorc ~= 0 then
					table.insert(
						result,
						{ text = DiagnosticSigns["Error"] .. " " .. errorc .. "  ", link = "DiagnosticSignError" }
					)
				end

				if warningc ~= 0 then
					table.insert(
						result,
						{ text = DiagnosticSigns["Warn"] .. " " .. warningc .. "  ", link = "DiagnosticSignWarn" }
					)
				end

				if hintc ~= 0 then
					table.insert(
						result,
						{ text = DiagnosticSigns["Hint"] .. " " .. hintc .. "  ", link = "DiagnosticSignHint" }
					)
				end

				if infoc ~= 0 then
					table.insert(
						result,
						{ text = DiagnosticSigns["Info"] .. " " .. infoc .. "  ", link = "DiagnosticSignInfo" }
					)
				end
				table.insert(result, { text = "   " })
				return result
			end,
		},
	},
})

vim.cmd("hi! link BufferLineModifiedSelected NeoTreeGitModified")

vim.keymap.set("n", "<leader>bl", "<cmd>Neotree close<CR> <cmd>BufferLinePick<CR>", { noremap = true })
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { noremap = true })
vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { noremap = true })

-- see eventlistners for iconhl autocmd
