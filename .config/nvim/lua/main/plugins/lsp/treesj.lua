return {
	"Wansmer/treesj",
	config = function()
		require("treesj").setup({
			use_default_keymaps = false,
			max_join_length = 400,
		})
		vim.keymap.set("n", "<leader>j", require("treesj").toggle)

		vim.keymap.set("n", "<leader>J", function()
			require("treesj").toggle({ split = { recursive = true } })
		end)
	end,
}
