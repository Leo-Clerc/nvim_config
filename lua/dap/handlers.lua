return {
	python = function(config)
		local dap = require("dap")
		dap.adapters.python = {
			type = "executable",
			-- command = "python ~/debugpy/adapter", -- This will definitely need some change
			-- command = os.getenv("HOME") .. "/.virtualenvs/tools/bin/python",
			command = "C:/users/leo20/AppData/local/.virtualenvs/debugpy/Scripts/pythonw",
			args = {
				"-m",
				"debugpy.adapter",
			},
		}
		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "launch file",
				program = "${file}",
        -- TODO: Check if this is useful
        -- pythonPath = function()
        --   -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
        --   -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
        --   -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
        --   local cwd = vim.fn.getcwd()
        --   if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        --     return cwd .. '/venv/bin/python'
        --   elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        --     return cwd .. '/.venv/bin/python'
        --   else
        --     return vim.fn.getenv('LOCALAPPDATA') .. '/.virtualenvs/debugpy/Scripts/pythonw'
        --   end
        -- end;
			},
		}
	end,
}
