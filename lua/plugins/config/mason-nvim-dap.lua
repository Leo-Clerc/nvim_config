return function()
  local mason_dap_status, mason_dap = pcall(require, "mason-nvim-dap")
  if not mason_dap_status then
    vim.notify("Problem with mason dap")
  end
  local opts = {
    ensure_installed = require("dap.dap_list"),
    handlers = require("dap.handlers"),
  }
  mason_dap.setup(opts)
end
