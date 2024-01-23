local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

-- Remap leader key
keymap("n", "<Space>", "<Nop>", opts)
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
keymap("n", "<Space>qq", ":bdelete<CR>", opts)

-- Useful miscalleneous mappings

keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)

-- Nvim tree :
local nvim_tree_available, _ = pcall(require, "plugins.nvim-tree")
if nvim_tree_available then
	keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", opts)
	keymap("n", "<Leader>o", ":NvimTreeFocus<CR>", opts)
else
	vim.notify("nvim-tree isn't available")
	return
end

-- Telescope
keymap("n", "<Leader>ff", ':lua require("telescope.builtin").find_files()<CR>', opts)
keymap("n", "<Leader>fw", ":Telescope live_grep<CR>", opts)
keymap("n", "<Leader>fgf", ':lua require("telescope.builtin").git_files()<CR>', opts)
keymap("n", "<Leader>fgC", ':lua require("telescope.builtin").git_commits()<CR>', opts)
keymap("n", "<Leader>fgc", ':lua require("telescope.builtin").git_bcommits()<CR>', opts)
keymap("n", "<Leader>fb", ':lua require("telescope.builtin").buffers()<CR>', opts)

-- Fugitive
keymap("n", "<Leader>gg", ":vert bo G<CR>", opts)
keymap("n", "<Leader>gb", ":bo G blame<CR>", opts)
keymap("n", "<Leader>gss", ":G stash<CR>", opts)
keymap("n", "<Leader>gsp", ":G stash -p<CR>", opts)
keymap("n", "<Leader>gcc", ":G commit<CR>", opts)
keymap("n", "<Leader>gce", ":G commit --amend<CR>", opts)
keymap("n", "<Leader>gcm", ":G commit --amend --no-edit<CR>", opts)
keymap("n", "<Leader>gpp", ":G push<CR>", opts)
keymap("n", "<Leader>gpl", ":G pull<CR>", opts)
keymap("n", "<Leader>gll", ":vert bo G log<CR>", opts)
keymap("n", "<Leader>gls", ":vert bo G log --oneline<CR>", opts)

-- Mine-sweeper

keymap("n", "<Leader>pp", ":MineSweep hard -t<CR>", opts)

-- Harpoon
keymap("n", "<Space>hh", ':lua require("harpoon.mark").add_file()<CR>', opts)
keymap("n", "<Space>hm", ':lua require("harpoon.ui").toggle_quick_menu()<CR>', opts)
keymap("n", "<Space>h&", ':lua require("harpoon.ui").nav_file(1)<CR>', opts)
keymap("n", "<Space>hé", ':lua require("harpoon.ui").nav_file(2)<CR>', opts)
keymap("n", '<Space>h"', ':lua require("harpoon.ui").nav_file(3)<CR>', opts)
keymap("n", "<Space>h'", ':lua require("harpoon.ui").nav_file(4)<CR>', opts)
keymap("n", "<Space>h(", ':lua require("harpoon.ui").nav_file(5)<CR>', opts)
keymap("n", "<Space>h-", ':lua require("harpoon.ui").nav_file(6)<CR>', opts)

-- Help
