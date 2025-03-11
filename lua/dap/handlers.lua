return {
  function (config)
    require('mason-nvim-dap').default_setup(config)
  end,
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
				name = "Launch file",
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
    require('mason-nvim-dap').default_setup({})
	end,
  codelldb = function(config)
    local dap = require('dap')
    dap.adapters.codelldb = {
      id = "lldb",
      type = "server",
      port = "${port}",
      executable = {
        command = vim.fn.stdpath("data") .. '\\mason\\bin\\codelldb',
        args = {"--port", "${port}"},
      },
    }
    dap.configurations.c = {{
      name = "Run server (codelldb)",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '\\', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = {},
      console = 'integratedTerminal',
      },
    require('mason-nvim-dap').default_setup({})
  }
  end
}
