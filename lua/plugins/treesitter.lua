return {
  "nvim-treesitter/nvim-treesitter",
  config = require "plugins.config.treesitter",
  lazy = false,
  build = ":TSUpdate"
}
