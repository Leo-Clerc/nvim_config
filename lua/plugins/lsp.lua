return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "williaboman/mason-lspconfig.nvim",
        cmd = {
          "LspInstall",
          "LspUninstall",
        },
      },
    },
    config = require "plugins.config.lsp"
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "jay-babu/mason-null-ls.nvim",
      cmd = { "NullLsInstall", "NullLsUninstall" }
    },
  }
}
