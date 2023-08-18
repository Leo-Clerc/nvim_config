return function()
  local status_nvim_dap_ui_ok, dapui = pcall(require, "nvim-dap")
  if not status_nvim_dap_ui_ok then
    return
  end

  local status_dap_ok, dap = pcall(require, "dap")
  if not status_dap_ok then
    return
  end

  local opts = {}
  dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
  dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
  dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

  dapui.setup(opts)

end
