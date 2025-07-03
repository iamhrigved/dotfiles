return {
	"RRethy/vim-illuminate",
	config = function()
		local ill = require("illuminate")

		ill.configure({
			delay = 100,
		})

		vim.keymap.set("n", "<M-k>", ill.goto_next_reference)
		vim.keymap.set("n", "<M-p>", ill.goto_prev_reference)
	end,

	-- see highlights in colors.lua
}
