require("persisted").setup({
	save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved
	silent = false, -- silent nvim message when sourcing session file
	use_git_branch = false, -- create session files based on the branch of a git enabled repository
	default_branch = "main", -- the branch to load if a session file is not found for the current branch
	autosave = true, -- automatically save session files when exiting Neovim
	should_autosave = function()
		-- do not autosave if the alpha dashboard is the current filetype
		if vim.bo.filetype == "alpha" then
			return false
		end
		return true
	end,
	autoload = false, -- automatically load the session for the cwd on Neovim startup
	on_autoload_no_session = {},
	follow_cwd = false, -- change session file name to match current working directory if it changes
	allowed_dirs = nil, -- table of dirs that the plugin will auto-save and auto-load from
	ignored_dirs = nil, -- table of dirs that are ignored when auto-saving and auto-loading
	ignored_branches = nil, -- table of branch patterns that are ignored for auto-saving and auto-loading
	telescope = {
		reset_prompt = false, -- Reset the Telescope prompt after an action?
		mappings = { -- table of mappings for the Telescope extension
			change_branch = "<c-b>",
			copy_session = "<c-c>",
			delete_session = "<c-d>",
		},
		icons = { -- icons displayed in the picker, set to nil to disable entirely
			branch = " ",
			dir = " ",
			selected = " ",
		},
	},
})

vim.keymap.set("n", "<leader>ss", "<cmd>Telescope persisted<CR>")

-- closing neo-tree when saving
vim.api.nvim_create_autocmd("User", {
	pattern = "PersistedSavePre",
	callback = function()
		vim.cmd("Neotree close")
	end,
})

-- opening neo-tree when loading
vim.api.nvim_create_autocmd("User", {
	pattern = "PersistedLoadPost",
	callback = function()
		local cwd = vim.fn.getcwd()
		require("neo-tree.command").execute({
			action = "close",
			dir = cwd,
		})
		local t = {}
		for i in string.gmatch(cwd, "([^/]+)") do
			table.insert(t, i)
		end
		vim.cmd("silent! bd! " .. t[#t]) -- weird buffer with name of the parent folder was getting created
		-- so had to find a way to delete it
	end,
})
vim.o.sessionoptions = "buffers,curdir,localoptions,folds,tabpages,winpos,winsize"
