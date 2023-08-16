return function()

  local status_cmp_dap_ok, cmp_dap = pcall(require, "cmp-dap")
  if not status_cmp_dap_ok then
    return
  end

  local opts = {}

  cmp_dap.setup(opts)
end

