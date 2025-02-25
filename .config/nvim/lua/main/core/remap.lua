vim.g.mapleader = " "

local default_opts = { noremap = true }
local noremap = function(mode, key, action, opts)
    if opts == {} then
        opts = default_opts
    end
    vim.keymap.set(mode, key, action, opts)
end

-- NOTE: All keybindings are changed for the Colemak-DH layout!

-- escape from insert mode
-- noremap("i", "en", "<Esc>") -- use CapsLock for esc

noremap("i", "<C-m>", "<C-left>")
noremap("i", "<C-i>", "<C-right>")
noremap("i", "<C-n>", "<C-o>_")
noremap("i", "<C-e>", "<C-o>$")

noremap({ "n", "x" }, "m", "h")
noremap({ "n", "x" }, "n", "j")
noremap({ "n", "x" }, "e", "k")
noremap({ "n" }, "i", "l")

noremap({ "n", "x" }, "h", "m")
noremap({ "n", "x" }, "j", "e")
noremap({ "n", "x" }, "k", "n")
noremap({ "n", "x" }, "l", "i")
noremap({ "n", "x" }, "H", "M")
noremap({ "n", "x" }, "J", "E")
noremap({ "n", "x" }, "K", "N")
noremap({ "n", "x" }, "L", "I")

-- window navigation keybindings
noremap("n", "<C-m>", "<C-w>h")
noremap("n", "<C-n>", "<C-w>j")
noremap("n", "<C-e>", "<C-w>k")
noremap("n", "<C-i>", "<C-w>l")

-- noremap("n", "<C-d>", "<C-d>zz")
-- noremap("n", "<C-u>", "<C-u>zz")

-- move 5 lines up and down
noremap("n", "E", "5k")
noremap("n", "N", "5j")

-- moving visual lines/blocks etc
noremap("v", "E", ":m '<-2<CR>gv=gv")
noremap("v", "N", ":m '>+1<CR>gv=gv")

-- preserve the text pasted in visual mode
noremap("v", "p", '"_dP') -- delete into the null register and paste
noremap("v", "D", '"_d')  -- just delete into the null register in visual mode
noremap({ "v", "n" }, "<C-c>", '"+y')
-- to paste, just do C-S-v

-- window resizing keybindings
noremap("n", "<C-up>", "<C-w>2+")
noremap("n", "<C-down>", "<C-w>2-")
noremap("n", "<C-left>", "<C-w>5<")
noremap("n", "<C-right>", "<C-w>5>")

-- selection keybindings
-- noremap("n", "n", "nzz")
-- noremap("n", "N", "Nzz")
noremap("n", "<leader>hx", "<cmd>noh<CR>") -- clear highlights
noremap("i", "<Tab>", "    ")              -- add 4 spaces when tab is pressed

-- split keybindings
noremap("n", "<leader>sh", "<cmd>split<CR>")
noremap("n", "<leader>sv", "<cmd>vsplit<CR>")
noremap("n", "<leader>x", vim.cmd.BufDel)
noremap("n", "<leader>X", vim.cmd.BufDelOthers)
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

-- terminal keymaps
noremap("t", "<esc><esc>", "<C-\\><C-n>")
