return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = require "plugins.config.alpha"
}
