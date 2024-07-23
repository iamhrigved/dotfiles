require("toggleterm").setup({
	size = function(term)
		if term.direction == "horizontal" then
			return 15
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.3
		end
	end,
	open_mapping = [[<c-t>]],
	autochdir = true,
	highlights = {
		Normal = { link = "Normal" },
		NormalFloat = { link = "NormalFloat" },
		FloatBorder = { link = "FloatBorder" },
	},
	start_in_insert = true,
	insert_mappings = false,
	direction = "horizontal",
	float_opts = {
		border = "curved",
		width = math.floor(0.85 * vim.api.nvim_win_get_width(0)),
		height = math.floor(0.85 * vim.api.nvim_win_get_height(0)),
		title_pos = "center",
	},
	winbar = {
		enable = false,
	},
})
