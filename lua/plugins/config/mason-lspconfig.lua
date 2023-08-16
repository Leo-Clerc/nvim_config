return function()
  local status_mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not status_mason_lspconfig_ok then
    return
  end

  local signs = require "icons.lsp"

  for _, sign in ipairs( signs ) do
    vim.fn.sign_define(sign.name, sign)
  end

  local opts = {
    ensure_installed = require "lsp.server_list"
  } 
  mason_lspconfig.setup(opts)

  local handlers = require "lsp.handlers"
  mason_lspconfig.setup_handlers(handlers)
end

