return {
	"neovim/nvim-lspconfig",
	config = function()
		local DiagnosticSigns = vim.g.DiagnosticSigns
		DiagnosticSigns["priority"] = 10 -- NEVER CHANGE see gitsigns.lua

		vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<cr>") -- 'er' for popup and dg for telescope
		vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
		vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")

		-- default lsp config
		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP actions",
			callback = function(event)
				local opts = { buffer = event.buf }

				-- these will be buffer-local keybindings
				-- because they only work if you have an active language server

				vim.keymap.set("n", "<leader>k", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
				vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
				vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
				-- vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts) in telescope.lua
				vim.keymap.set("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
				-- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts) in telescope.lua
				vim.keymap.set("n", "gh", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
				vim.keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
				vim.keymap.set({ "n", "x" }, "<leader>fm", require("conform").format, opts)
				vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
				vim.keymap.set(
					"n",
					"<leader>ih",
					"<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>",
					opts
				)
			end,
		})

		require("mason").setup({
			ui = {
				height = 0.85,
				width = 0.8,
				border = "rounded",
				keymaps = {
					uninstall_package = "x",
				},
				icons = {
					package_installed = "󰸞",
					package_pending = "",
					package_uninstalled = "󱎘",
				},
			},
		})
		require("mason-lspconfig").setup()

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = DiagnosticSigns.ERROR,
					[vim.diagnostic.severity.WARN] = DiagnosticSigns.WARN,
					[vim.diagnostic.severity.HINT] = DiagnosticSigns.HINT,
					[vim.diagnostic.severity.INFO] = DiagnosticSigns.INFO,
				},
			},
			severity_sort = true,
			underline = true,
			update_in_insert = false,
			float = {
				-- UI.
				header = "Diagnostics:",
				border = "rounded",
				focusable = true,
			},
			virtual_text = {
				spacing = 4,
				virt_text_pos = "eol",
				source = "if_many",
				prefix = "󱓻 ",
			},
		})

		-- default capabilities and on_attatch functions:
		local default_capabilities = require("cmp_nvim_lsp").default_capabilities()
		default_capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}

		local default_on_attach = function(client, bufnr)
			print("Welcome to " .. vim.bo.filetype .. " programing!")
			vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })

			if client.server_capabilities.documentSymbolProvider then
				require("nvim-navic").attach(client, bufnr)
			end
		end

		-- default setup for differenet lsp's
		local setup = function(server, opts)
			local default_opts = {
				capabilities = default_capabilities,
				on_attach = default_on_attach,
			}
			for k, v in pairs(opts) do
				default_opts[k] = v
			end
			require("lspconfig")[server].setup(default_opts)
		end

		require("mason-lspconfig").setup({
			-- configuring all lsp installed via mason
			handlers = {
				function(server_name)
					print("arstarstarst: " .. server_name)
					setup(server_name, {})
				end,
			},
		})

		-- for Rust:
		vim.g.rustaceanvim = {
			tools = {
				float_win_config = {
					lang = "markdown",
					replace = true,
					render = "plain",
					position = { row = 2, col = 2 },
					max_width = 0.8 * vim.api.nvim_win_get_width(0),
					max_height = 15,
					border = "rounded",
					win_options = {
						-- concealcursor = "n",
						-- conceallevel = 3,
						winhighlight = {
							Normal = "Normal",
							FloatBorder = "FloatBorder",
						},
					},
				},
			},
			server = {
				capabilities = default_capabilities,
				on_attatch = default_on_attach,
				default_settings = {
					["rust-analyzer"] = {
						imports = {
							granularity = {
								group = "module",
							},
							prefix = "self",
						},
						cachePriming = { enable = true },
						cargo = {
							allFeatures = true,
						},
						diagnostics = {
							experimental = { enable = true },
						},
						checkOnSave = true,
					},
				},
			},
		}
	end,
}
