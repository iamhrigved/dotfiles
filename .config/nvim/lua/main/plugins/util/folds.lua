return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async", "luukvbaal/statuscol.nvim" },
	config = function()
		vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
		vim.o.foldcolumn = "1" -- '0' is not bad
		vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true -- set fold before loading the plugin

		local builtin = require("statuscol.builtin")

		local foldVirtualText = function(virtText, lnum, endLnum, width, truncate)
			local newVirtText = {}

			local foldedLines = endLnum - lnum
			local totalLines = vim.api.nvim_buf_line_count(0)
			local suffix = (" ........... 󰁂 %d:%d%% "):format(foldedLines, (foldedLines + 1) / totalLines * 100)
			local sufWidth = vim.fn.strdisplaywidth(suffix)
			local targetWidth = width - sufWidth
			local curWidth = 0

			for _, chunk in ipairs(virtText) do
				local chunkText = chunk[1]
				local chunkWidth = vim.fn.strdisplaywidth(chunkText)
				if targetWidth > curWidth + chunkWidth then
					table.insert(newVirtText, chunk)
				else
					chunkText = truncate(chunkText, targetWidth - curWidth)
					local hlGroup = chunk[2]
					table.insert(newVirtText, { chunkText, hlGroup })
					chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if curWidth + chunkWidth < targetWidth then
						suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
					end
					break
				end
				curWidth = curWidth + chunkWidth
			end

			table.insert(newVirtText, { suffix, "MoreMsg" })
			return newVirtText
		end

		vim.cmd("hi! MoreMsg guifg=#3f84bd gui=none")
		vim.cmd("hi! Folded guibg=#1d2a41")

		require("ufo").setup({
			open_fold_hl_timeout = 200,
			fold_virt_text_handler = foldVirtualText,
			preview = {
				win_config = {
					border = "rounded",
					winhighlight = "Normal:Normal",
					winblend = 0,
				},
				mappings = {
					scrollU = "<C-u>",
					scrollD = "<C-d>",
					jumpTop = "[",
					jumpBot = "]",
				},
			},
		})

		require("statuscol").setup({
			relculright = false,
			ft_ignore = { "neo-tree", "toggleterm" },
			segments = {
				-- { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
				{
					text = { " %s" },
					click = "v:lua.ScSa",
				},
				{
					text = { "", builtin.lnumfunc, " " },
					click = "v:lua.ScLa",
				},
			},
		})

		vim.keymap.set("n", "zt", "za") -- toggle fold
		vim.keymap.set("n", "zT", "zA")
		vim.keymap.set("n", "zR", require("ufo").openAllFolds)
		vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
		vim.keymap.set("n", "zp", require("ufo").peekFoldedLinesUnderCursor)
	end,
}
