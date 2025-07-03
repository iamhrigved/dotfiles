return {
	require("main.plugins.ui.alpha"),
	require("main.plugins.ui.animate"),
	-- require("main.plugins.ui.nvchadui"),
	require("main.plugins.ui.bufferline"),
	require("main.plugins.ui.indent"),
	require("main.plugins.ui.lualine"),
	require("main.plugins.ui.oil"),
	require("main.plugins.ui.noice"),
	require("main.plugins.ui.telescope"),
	require("main.plugins.ui.illuminate"),
	require("main.plugins.ui.colors"),

	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
}
