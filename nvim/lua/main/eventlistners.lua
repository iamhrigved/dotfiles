local function autocmd(events, opts)
	vim.api.nvim_create_autocmd(events, opts)
end

-- Formatting on file save
autocmd("BufWritePre", {
	desc = "Formatting on file save, and saving the current session",
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

-- Highlight the text when yanking
autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	callback = function()
		vim.highlight.on_yank()
	end,
})

autocmd("VimLeavePre", {
	callback = function()
		vim.cmd("!cd " .. vim.fn.gencwd())
	end,
})

autocmd("User", {
	pattern = "AlphaReady",
	desc = "Disable statusline in startup screen",
	callback = function()
		vim.go.laststatus = 0
		vim.b.miniindentscope_disable = true
	end,
})

autocmd("BufUnload", {
	buffer = 0,
	-- pattern = 'AlphaClosed',
	desc = "Enable statusline after startup screen",
	callback = function()
		vim.go.laststatus = 3 -- 2 for multiple status, 3 for global status
	end,
})

autocmd("BufEnter", {
	desc = "Changing the name of ToggleTerm when we enter it",
	callback = function()
		vim.schedule(function()
			if vim.o.filetype == "toggleterm" then
				vim.cmd("file Terminal | startinsert")
				vim.o.foldcolumn = "0" --important
				vim.cmd("WindowsDisableAutowidth") --important
			end
		end)
	end,
})
autocmd("BufLeave", {
	callback = function()
		vim.cmd("WindowsEnableAutowidth") --important
	end,
})

autocmd("BufEnter", {
	desc = "Disabling Windows plugin when entering a trouble window",
	callback = function()
		vim.schedule(function()
			if vim.o.filetype == "trouble" then
				vim.cmd("WindowsDisableAutowidth")
			end
		end)
	end,
})

autocmd("BufLeave", {
	desc = "Enabling Windows plugin when leaving a trouble window",
	callback = function()
		vim.schedule(function()
			if vim.o.filetype == "trouble" then
				vim.cmd("WindowsEnableAutowidth")
			end
		end)
	end,
})

local get_icon_hl = function()
	local filename = vim.fn.expand("%:t")
	local _, color = require("nvim-web-devicons").get_icon_color(filename)
	if color == nil then
		return ""
	end
	local hlcmd = "hi! BufferLineIndicatorSelected guifg=" .. color
	return hlcmd
end

autocmd("BufEnter", {
	desc = "Changing the BufferLineIndicatorSelected highlight according to the color of icon",
	callback = function()
		vim.cmd(get_icon_hl())
	end,
})

-- autocmd("InsertLeave", {
-- 	callback = function()
-- 		vim.schedule(function()
-- 			if vim.bo.filetype ~= "rust" then
-- 				return
-- 			end
-- 			vim.cmd("silent! w")
-- 		end)
-- 	end,
-- })

autocmd("FocusLost", {
	callback = function()
		vim.cmd("lua ForceLualineFocusLost = true")
	end,
})
autocmd("FocusGained", {
	callback = function()
		vim.cmd("lua ForceLualineFocusLost = nil")
	end,
})

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

autocmd("FileType", {
	pattern = "TelescopePrompt",
	callback = function()
		vim.o.cursorline = false
	end,
})
