-- local dap = require("dap")
-- local dapui = require("dapui")

-- dapui.setup()
-- require("nvim-dap-virtual-text").setup()

-- dap.listeners.before.attach.dapui_config = function()
-- 	dapui.open()
-- end
-- dap.listeners.before.launch.dapui_config = function()
-- 	dapui.open()
-- end
-- dap.listeners.before.event_terminated.dapui_config = function()
-- 	dapui.close()
-- end
-- dap.listeners.before.event_exited.dapui_config = function()
-- 	dapui.close()
-- end

-- vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
-- vim.keymap.set("n", "<leader>dx", dap.terminate)
-- vim.keymap.set("n", "<leader>dc", dap.continue)
-- vim.keymap.set("n", "<leader>di", dap.step_into)
-- vim.keymap.set("n", "<leader>do", dap.step_over)
