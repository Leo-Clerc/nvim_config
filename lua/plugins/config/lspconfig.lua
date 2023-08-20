return function()
  local status_ok, lspconfig = pcall(require, lspconfig)

  if not status_ok then
    return
  end

  vim.notify("Lspconfig loaded ?")
  lspconfig.setup()
end


