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
				javascript = { "prettierd", "prettier" },
				json = { "prettier", "prettierd" },
				jsonc = { "prettier", "prettierd" },
				markdown = { "prettier" },
				rust = { "rustfmt" },
			},
		})
	end,
}
