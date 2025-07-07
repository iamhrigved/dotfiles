local function autocmd(events, opts)
	vim.api.nvim_create_autocmd(events, opts)
end

-- Formatting on file save
-- Beside conform.lua

-- Highlight the text when yanking
autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.highlight.on_yank()
	end,
})

autocmd("BufEnter", {
	desc = "Change bufferline indicator color based on file icon color",
	callback = function()
		local file_name = vim.fn.expand("%:t")
		local file_type = vim.fn.expand("%:e") -- extension
		local _, color = require("nvim-web-devicons").get_icon_color(file_name, file_type)
		if color ~= nil then
			vim.cmd.hi("BufferLineIndicatorSelected guifg=" .. color)
			vim.cmd.hi("BufferLineCloseButtonSelected guifg=" .. color)
		end
	end,
})

-- updating lazy plugins when loading
-- autocmd("VimEnter", {
-- pattern = "*",
-- callback = function()
--  require("lazy").update({ show = false })
-- end,
-- })

-- -- pwd was not changing so had to do this
-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	pattern = "*",
-- 	callback = function()
-- 		vim.cmd.cd(vim.fn.expand("%:p:h"))
-- 	end,
-- })

autocmd({ "FocusLost", "WinLeave" }, {
	callback = function()
		vim.o.cursorline = false
	end,
})

autocmd({ "FocusGained", "WinEnter" }, {
	callback = function()
		if vim.bo.filetype == nil then
			return
		end
		if vim.bo.filetype == "alpha" then
			return
		end
		vim.o.cursorline = true
	end,
})

-- disabling cursorline when in TelescopePrompt
autocmd("FileType", {
	pattern = "TelescopePrompt",
	callback = function()
		vim.o.cursorline = false
	end,
})
