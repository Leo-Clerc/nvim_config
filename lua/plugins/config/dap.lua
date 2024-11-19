return function()
	local dap_status_ok, dap = pcall(require, "dap")
	if not dap_status_ok then
		vim.notify("Problem with dap")
		return
	end

  local adapters = dap.adapters
  local configurations = dap.configurations
	adapters.py = {
		type = "executable",
		-- command = "c:/python310/lib/site-packages",
		command = "os.getenv('HOME') .. '/.virtualenvs/tools/bin/python'",
		args = { "-m", "debugpy.adapter" },
		detached = false,
	}

	configurations.python = {
		name = "Launch file",
		type = "py",
		request = "launch",
		program = "$file",
	}
  adapters.gdb = {
    id = "gdb",
    type = "executable",
    command = "gdb",
    args = {'--quiet', '--interpreter=dap'},
  }
  dap.configuration.c = {
    {
      name = 
    }
  }

end
