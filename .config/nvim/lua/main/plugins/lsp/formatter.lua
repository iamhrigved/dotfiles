return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			-- please see eventlistners.lua for autocmd
			format_on_save = {
				timeout_ms = 2000,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "isort", "black" },
				-- Use a sub-list to run only the first available formatter
				javascript = { "prettier" },
				json = { "prettier" },
				javascriptreact = { "prettier" },

				jsonc = { "prettier" },
				markdown = { "prettier" },
				rust = { "rustfmt" },
				haskell = { "fourmolu" },
			},

			formatters = {
				prettier = {
					prepend_args = { "--tab-width", "4" },
				},
			},
		})
	end,
}
