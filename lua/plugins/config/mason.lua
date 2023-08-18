return function()
  local status_mason_ok, mason = pcall(require, "mason")
  if not status_mason_ok then
    return
  end

  opts = {
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
end
