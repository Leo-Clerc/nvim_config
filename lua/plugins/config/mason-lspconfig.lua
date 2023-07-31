return function()
  local status_mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not status_mason_lspconfig_ok then
    return
  end

  local opts = {
    ensure_installed = require "lsp.server_list"
  } 
  mason_lspconfig.setup(opts)

  handlers = require "lsp.handlers"
  mason_lspconfig.setup_handlers(handlers)
end

