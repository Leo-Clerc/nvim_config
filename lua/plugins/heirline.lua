return {
  "rebelot/heirline.nvim",
  config = require "plugins.config.heirline",
  lazy = true,
  event = "BufEnter",
  dependencies = {
    "neovim/nvim-lspconfig",
  }
}
