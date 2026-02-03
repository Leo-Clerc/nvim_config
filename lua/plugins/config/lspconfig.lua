return function()
  local status_ok, lspconfig = pcall(require, "lspconfig")

  if not status_ok then
    vim.notify("problem with lsp config")
    return
  end

  -- vim.notify("Lspconfig loaded ?")
  lspconfig.setup()
end


