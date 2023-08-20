local options = {
  backup = false,
  showmode = false,
  swapfile = false,
  mouse = "a",
  autoindent = true,
  smartindent = true,
  showtabline = 0,
  expandtab = true,
  tabstop = 2,
  shiftwidth = 2,
  number = true,
  relativenumber = true,
  termguicolors = true,
  numberwidth = 4,
  wrap = false,
  fillchars = { eob = " "},
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.loader.enable()
