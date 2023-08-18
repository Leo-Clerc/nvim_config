return function()

  local status_cmp_dap_ok, cmp_dap = pcall(require, "cmp-dap")
  if not status_cmp_dap_ok then
    return
  end

  local opts = {
      { "dap-repl", "dapui_watches", "dapui_hover" },
      {
      sources = {
        { name = "dap" },
      },
    },
  }

  cmp_dap.setup(opts)
end

