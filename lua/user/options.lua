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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "plaintex",
  callback = function()
    vim.bo.filetype = "tex"
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt.wrap = true
    vim.opt.linebreak = true
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "text",
  callback = function()
    vim.opt.wrap = true
    vim.opt.linebreak = true
  end,
})
vim.loader.enable()
