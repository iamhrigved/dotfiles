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

-- updating lazy plugins when loading
-- autocmd("VimEnter", {
-- pattern = "*",
-- callback = function()
--  require("lazy").update({ show = false })
-- end,
-- })

-- pwd was not changing so had to do this
vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		vim.cmd.cd(vim.fn.expand("%:p:h"))
	end,
})

autocmd("BufNew", {
	desc = "Disable statusline in startup screen",
	callback = function()
		if vim.bo.filetype == "alpha" then
			vim.go.laststatus = 0
		end
		-- vim.b.miniindentscope_disable = true
	end,
})

autocmd("BufUnload", {
	buffer = 0,
	desc = "Enable statusline after startup screen",
	callback = function()
		if vim.bo.filetype == "alpha" then
			vim.go.laststatus = 3 -- 2 for multiple status, 3 for global status
			vim.g.miniindentscope_disable = false
			vim.b.miniindentscope_disable = false
		end
	end,
})

-- NOTE: the iconhl function is re-written in the ~/.local/share/nvim/lazy/bufferline.nvim/lua/bufferline/config.lua file

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
