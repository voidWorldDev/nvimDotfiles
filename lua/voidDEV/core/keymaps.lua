-- lua/kickstart/core/keymaps.lua
--[[
  Vim/Neovim Mode Strings Reference (used in vim.keymap.set / vim.api.nvim_set_keymap)

  Mode   | Description
  -------|---------------------------------------------------------
  "n"    | Normal mode
  "i"    | Insert mode
  "v"    | Visual mode (includes Select mode)
  "x"    | Visual mode only (excludes Select mode)
  "s"    | Select mode
  "o"    | Operator-pending mode
  "t"    | Terminal mode
  "c"    | Command-line mode
  ""     | Normal, Visual, Select, and Operator-pending (like old :map)
  "!"    | Insert and Command-line mode (like old :map!)

  You can also pass a table of modes to apply one mapping to multiple modes:
    keymap({ "n", "v" }, "<leader>y", '"+y', opts)
--]]
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Better window navigation
keymap("n", "<A-h>", "<C-w>h", opts)
keymap("n", "<A-j>", "<C-w>j", opts)
keymap("n", "<A-k>", "<C-w>k", opts)
keymap("n", "<A-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<leader>bd", ":bdelete<CR>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Terminal
keymap("n", "<leader>tv", ":vsplit | terminal zsh<CR>", { noremap = true, silent = true, desc = "Vertical terminal" })
keymap("n", "<leader>th", ":split | terminal zsh<CR>", { noremap = true, silent = true, desc = "Vertical terminal" })
keymap("t", "<A-q>", "<C-\\><C-n>", opts)

vim.keymap.set({ "n", "x" }, "d", '"_d')
vim.keymap.set({ "n", "x" }, "c", '"_c')
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("x", "y", "ygv", { noremap = true, silent = true })
