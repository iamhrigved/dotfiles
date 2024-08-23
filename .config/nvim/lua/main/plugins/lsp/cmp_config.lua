return {
	"hrsh7th/nvim-cmp",
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")

		--- Function to preview snippet before completion with nvim-cmp
		function CmpBefore(entry, vim_item)
			if entry.completion_item.snippet then
				local snippet_value = entry.completion_item.snippet.value
				local parsed_snippet = vim.lsp.util.parse_snippet(snippet_value)
				local snippet_preview = str.oneline(str.oneline(parsed_snippet))
				vim_item.abbr = snippet_preview
			elseif #vim_item.abbr > 15 then
				vim_item.abbr = string.sub(vim_item.abbr, 1, 20) .. "..."
			end
			if vim_item.menu ~= nil then
				if #vim_item.menu > 12 then
					vim_item.menu = string.sub(vim_item.menu, 1, 12) .. "..."
				end
			end
			if entry.source.name == "buffer" then
				vim_item.kind = "󰈬 Buffer"
			end
			return vim_item
		end

		local lspKindFormat = lspkind.cmp_format({
			mode = "symbol_text",
			maxwidth = 20,
			ellipsis_char = "...",
			show_labelDetails = false,
			before = CmpBefore,

			symbol_map = vim.g.LspKinds,
		})
		-- basic autocomplete
		cmp.setup({
			sources = {
				{ name = "nvim_lsp" },
				{ name = "buffer" },
				{ name = "emoji" },
			},

			window = {
				documentation = {
					scrollbar = "|",
					max_height = 15,
					max_width = math.floor(0.8 * vim.api.nvim_win_get_width(0)),
					winhighlight = "Normal:CmpPmenu,Search:None,CursorLine:Pmenu,CmpBorder:FlaotBorder", -- border will be the same as border of Noice cmdline_popup
					border = "rounded",
				},

				completion = {
					col_offset = 0,
					side_padding = 1,
					scrollbar = "|",
					winhighlight = "Normal:CmpPmenu,CursorLine:Visual,Search:None,CmpBorder:FloatBorder", -- border will be the same as border of Noice cmdline_popup
					border = "rounded",
				},
			},
			preselect = "item",
			completion = {
				completeopt = "menu,menuone,preview,noinsert",
			},
			formatting = {
				fields = { "abbr", "menu", "kind" },
				format = function(entry, vim_item)
					local item = lspKindFormat(entry, vim_item)
					item.kind = item.kind .. " "
					return item
				end,
			},

			mapping = cmp.mapping.preset.insert({
				["<Tab>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-c>"] = cmp.mapping.abort(),
				["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
			}),

			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},

			experimental = {
				ghost_text = true,
			},

			performance = {
				max_view_entries = 15,
			},
		})

		-- autocomplete for command line
		--`/` cmdline setup.
		cmp.setup.cmdline("/", {
			mapping = cmp.mapping.preset.cmdline({
				["<Tab>"] = { c = cmp.mapping.confirm({ select = true }) },
				["<C-Space>"] = { c = cmp.mapping.complete() },
				["<C-k>"] = { c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }) },
				["<C-j>"] = { c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }) },
				["<C-c>"] = { c = cmp.mapping.abort() },
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp_document_symbol" },
			}, {
				{ name = "buffer" },
			}),
		})

		-- `:` cmdline setup.
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline({
				["<Tab>"] = { c = cmp.mapping.confirm({ select = true }) },
				["<C-Space>"] = { c = cmp.mapping.complete() },
				["<C-k>"] = { c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }) },
				["<C-j>"] = { c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }) },
				["<C-c>"] = { c = cmp.mapping.abort() },
			}),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{
					name = "cmdline",
					option = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
			window = {
				completion = {
					scrollbar = "|",
				},
			},
		})

		-- config for autopairs.
		require("nvim-autopairs").setup() -- initialize the plugin
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
