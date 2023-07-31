return function()
  local status_mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not status_mason_lspconfig_ok then
    return
  end

  local opts = {
    ensure_installed = require "plugins.config.lsp.settings.server_list"
  } 
  mason_lspconfig.setup(opts)
end

