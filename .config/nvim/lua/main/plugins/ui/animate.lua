return {
	"echasnovski/mini.animate",
	config = function()
		local animate = require("mini.animate")
		local mouse_scrolled = false

		-- don't use animate when scrolling with mouse (from LazyVim)
		for _, scroll in ipairs({ "Up", "Down" }) do
			local key = "<ScrollWheel" .. scroll .. ">"
			vim.keymap.set({ "", "i" }, key, function()
				mouse_scrolled = true
				return key
			end, { expr = true })
		end

		animate.setup({
			cursor = {
				enable = false, -- kitty can generate the animation
			},

			scroll = {
				enable = true,
				timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
				subscroll = animate.gen_subscroll.equal({
					predicate = function(total_scroll)
						if mouse_scrolled then
							mouse_scrolled = false
							return false
						end
						return total_scroll > 1
					end,
				}),
			},

			resize = {
				timing = animate.gen_timing.linear({ duration = 50, unit = "total" }),
			},
			open = {
				enable = false,
			},
			close = {
				enable = false,
			},
		})
	end,
}
