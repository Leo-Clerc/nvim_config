return {
"mfussenegger/nvim-dap",
  dependencies = {
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = { "nvim-dap" },
      cmd = { "DapInstall", "DapUninstall" },
      opts = { handlers = {} },
    },
    {
      "rcarriga/nvim-dap-ui",
      opts = { floating = { border = "rounded" } },
      config = require "plugins.config.nvim-dap-ui",
    },
    {
      "rcarriga/cmp-dap",
      dependencies = { "nvim-cmp" },
      config = require "plugins.config.cmp-dap",
    },
  },
  event = "BufEnter",}
