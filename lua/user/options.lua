local options = {
  backup = false,
  mouse = "a",
  number = true,
  relativenumber = true,
  termguicolors = true,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
