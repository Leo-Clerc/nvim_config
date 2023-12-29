return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        cmd = {
          "LspInstall",
          "LspUninstall",
        },
        config = require "plugins.config.mason-lspconfig"
      },
    },
    -- config = require "plugins.config.lspconfig"
  },
}
