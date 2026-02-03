return function()
  local status_mason_ok, mason = pcall(require, "mason")
  if not status_mason_ok then
    return
  end

  local opts = {
      PATH = "prepend",
      ui = {
          icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗"
          },
      },
  }
  mason.setup(opts)

  --TODO: Put mason-lspconfig setup here to make sure things go in the correct order.

  local status_masondap_ok, masondap = pcall(require, "mason-nvim-dap")
  if not status_masondap_ok then
    return
  end

  local masondap_opts = {
    ensure_installed = require "dap.dap_list" ,
    handlers = require "dap.handlers"
  }

  masondap.setup(masondap_opts)
  -- require("mason-lspconfig")
  local status_mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not status_mason_lspconfig_ok then
    vim.notify("mason_lspconfig unavailable, but in mason file")
  end
  local signs = require "icons.lsp"

  for _, sign in ipairs( signs ) do
    vim.fn.sign_define(sign.name, sign)
  end

  local opts = {
    ensure_installed = require "lsp.server_list"
  }
  -- mason_lspconfig.setup(opts)
  local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
  if not lspconfig_status_ok then
    vim.notify("Problems with lspconfig")
    return
  end
end
