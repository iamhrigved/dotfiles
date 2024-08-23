vim.g.mapleader = " "

local opts = { noremap = true }
local noremap = function(mode, key, action)
	vim.keymap.set(mode, key, action, opts)
end

-- escape from insert mode
noremap("i", "kj", "<Esc>")
-- nn to write in next line in insert mode
noremap("i", "nn", "<C-o>o")

noremap({ "i", "c" }, "<C-h>", "<C-left>")
noremap({ "i", "c" }, "<C-l>", "<C-right>")
noremap({ "i" }, "<C-j>", "<C-o>_")
noremap({ "i" }, "<C-k>", "<C-o>$")

-- window navigation keybindings
noremap("n", "<C-h>", "<C-w>h")
noremap("n", "<C-l>", "<C-w>l")
noremap("n", "<C-j>", "<C-w>j")
noremap("n", "<C-k>", "<C-w>k")

-- moving visual lines/blocks etc
noremap("v", "K", ":m '<-2<CR>gv=gv")
noremap("v", "J", ":m '>+1<CR>gv=gv")

-- preserve the text pasted in visual mode
noremap("v", "p", '"_dP') -- delete into the null register and paste
noremap("v", "D", '"_d') -- just delete into the null register
noremap("n", "dd", "_dd")
noremap({ "v", "n" }, "<C-c>", '"+y')
-- to paste, just do C-S-v

-- window resizing keybindings
noremap("n", "<C-up>", "<C-w>2+")
noremap("n", "<C-down>", "<C-w>2-")
noremap("n", "<C-left>", "<C-w>5<")
noremap("n", "<C-right>", "<C-w>5>")

-- selection keybindings
noremap("n", "n", "nzz")
noremap("n", "N", "Nzz")
noremap("n", "<leader>hx", "<cmd>noh<CR>")

noremap("n", "<CR>", "o<Esc>")

-- Neotree keybindings
noremap("n", "<leader>nt", "<cmd>Neotree filesystem reveal left<CR>")
noremap("n", "<leader>nx", "<cmd>Neotree close<CR>")
noremap("n", "<leader>nf", "<cmd>Neotree float reveal<CR>")
noremap("n", "<leader>ng", "<cmd>Neotree git_status left<CR>")

-- split keybindings
noremap("n", "<leader>sh", "<cmd>split<CR>")
noremap("n", "<leader>sv", "<cmd>vsplit<CR>")
noremap("n", "<leader>bd", function()
	vim.cmd("BufDel!")
end)
noremap("n", "<leader>bD", function()
	vim.cmd("BufDelOthers!")
end)
noremap("n", "<leader>sx", function()
	if #vim.api.nvim_list_wins() <= 1 then
		return
	end
	local bufnr = vim.api.nvim_get_current_buf()
	local modifiable = vim.api.nvim_buf_get_option(bufnr, "modifiable")
	if modifiable then
		vim.cmd("silent w | bd!")
	else
		vim.cmd("bd!")
	end
end)

-- terminal keybindings for toggleterm
function _G.set_terminal_keymaps()
	local termopts = { buffer = 0, noremap = true }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], termopts)
	vim.keymap.set("t", "kj", [[<C-\><C-n>]], termopts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], termopts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], termopts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], termopts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], termopts)
	vim.keymap.set("t", "<c-w>", [[<c-\><c-n><c-w>]], termopts)
	vim.keymap.set("t", "<C-up>", "<C-w>+", termopts)
	vim.keymap.set("t", "<C-down>", "<C-w>-", termopts)
	vim.keymap.set("t", "<C-left>", "<C-w>5<", termopts)
	vim.keymap.set("t", "<C-right>", "<C-w>5>", termopts)
end
