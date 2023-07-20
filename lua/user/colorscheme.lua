local colorscheme = "everforest"

local availableColorscheme, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
  if not availableColorscheme then
    vim.notify("colorscheme " .. colorscheme .. " not available!")
    return
  end
