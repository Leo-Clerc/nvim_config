return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "jay-babu/mason-nvim-dap.nvim",
      cmd = { "DapInstall", "DapUninstall" },
      opts = { handlers = {} },
      config = require("plugins.config.mason-nvim-dap"),
    },
    {
      "rcarriga/nvim-dap-ui",
      opts = { floating = { border = "rounded" } },
      config = require("plugins.config.nvim-dap-ui"),
      lazy = false,
      dependencies = {
        "folke/neodev.nvim",
        config = function()
              require("neodev").setup({ plugins = { "nvim-dap-ui" }, types = true, }) -- Move this eventually
        end,
      },
    },
    {
      "rcarriga/cmp-dap",
      dependencies = { "nvim-cmp" },
      config = require("plugins.config.cmp-dap"),
    },
  },
  event = "BufEnter",
}
