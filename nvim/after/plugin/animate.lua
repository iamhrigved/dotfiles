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
		enable = true,
		timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
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
		enable = false,
	},
	open = {
		enable = false,
	},
	close = {
		enable = false,
	},
})
vim.cmd("hi MiniAnimateCursor guifg=#c0caf5")
