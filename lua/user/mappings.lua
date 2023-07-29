local opts = { noremap = true, silent = true}

local keymap = vim.api.nvim_set_keymap

-- Remap leader key
keymap("n","<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Windows management

keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)

keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- Keybinding for french azerty. Change boolean if qwerty. Or delete, obviously
local azerty = true

if azerty then
  keymap("n", "à", "@", opts)
  keymap("n", "è", "`", opts)
  keymap("n", "é", "~", opts)
  keymap("n", "µ", "#", opts)
  keymap("n", "ç", "{", opts)
  keymap("n", "<C-ç>", "}", opts)
  keymap("n", "ç", "{", opts)
  keymap("n", "^", "^<Space>", opts)
  keymap("i", "§", "\\", opts)
end

-- Buffer

keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<S-l>", ":bnext<CR>", opts)

-- Useful miscalleneous mappings

keymap("n","<C-u>", "<C-u>zz", opts)
keymap("n","<C-d>", "<C-d>zz", opts)
keymap("n","<C-d>", "<C-d>zz", opts)

-- Nvim tree :
local nvim_tree_available, _ = pcall(require, "plugins.nvim-tree")
if nvim_tree_available then
  keymap('n', '<Leader>e', ":NvimTreeToggle<CR>", opts)
  keymap('n', '<Leader>o', ":NvimTreeFocus<CR>", opts)
else
  vim.notify("nvim-tree isn't available")
  return
end
