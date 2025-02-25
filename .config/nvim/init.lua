-- put this in your main init.lua file ( before lazy setup )
-- vim.g.base46_cache = vim.fn.stdpath("data") .. "/base46_cache/"

require("main.core")
require("main.lazy")

-- after lazy setup
-- dofile(vim.g.base46_cache .. "defaults")
-- dofile(vim.g.base46_cache .. "statusline")
