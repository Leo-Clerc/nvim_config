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
    config = require "plugins.config.lspconfig"
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "jay-babu/mason-null-ls.nvim",
      cmd = { "NullLsInstall", "NullLsUninstall" }
    },
    config = require "plugins.config.null-ls"
  }
}
