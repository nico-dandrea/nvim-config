-- Set the leader key to space
vim.g.mapleader = " "

-- Open the Ex mode (file explorer) with <leader>pv
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Visual mode: Move selected line/block of text up or down
-- Move selected lines down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- Move selected lines up
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Normal mode: Enhancements for navigation and editing
-- Join lines without moving the cursor
vim.keymap.set("n", "J", "mzJ`z")
-- Scroll down half a screen and center the cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- Scroll up half a screen and center the cursor
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- Move to the next search result and center the cursor
vim.keymap.set("n", "n", "nzzzv")
-- Move to the previous search result and center the cursor
vim.keymap.set("n", "N", "Nzzzv")
-- Restart the LSP server
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

-- Integration with the "vim-with-me" plugin
-- Start a collaborative session
vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
-- Stop the collaborative session
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- Paste over currently selected text without yanking it
-- Greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copy to system clipboard
-- Next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
-- Copy line to system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete text without yanking it
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- Disable the Q key in normal mode
vim.keymap.set("n", "Q", "<nop>")
-- Open tmux sessionizer (commented out)
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- Format the current buffer with LSP
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Navigate quickfix list and center the cursor
-- Next item in quickfix list
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- Previous item in quickfix list
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- Next item in location list
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- Previous item in location list
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Substitute current word under cursor globally
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Insert Go error handling snippet
vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

-- Open the Neovim configuration file for theprimeagen's packer setup
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>")

-- Run CellularAutomaton make_it_rain (some plugin functionality)
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

-- Source the current file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
