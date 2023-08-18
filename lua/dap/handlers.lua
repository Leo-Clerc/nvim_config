return {
  function(config)
    require('mason-nvim-dap').default_setup(config)
  end,
  python = function(config)
    config.adapters = {
      type = "executable",
      command = "/usr/bin/python3",
      args = {
        "-m",
        "debugpy.adapter",
      },
    }
    require('mason-nvim-dap').default_setup(config)
  end
}
