return function()
  local status_ok, lspconfig = pcall(require, lspconfig)

  if not status_ok then
    return
  end

  lspconfig.setup()
  require "plugins.config.lsp.mason-lspconfig"
  require "plugins.config.lsp.null-ls"
end


