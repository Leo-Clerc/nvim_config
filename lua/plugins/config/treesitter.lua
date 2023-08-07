return function()
  local status_treesitter_ok, treesitter = pcall(require, "nvim-treesitter.configs")
  opts = {
    ensure_installed = "all",
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      disable = {},
      aditional_vim_regex_highlighting = false,
    },
  }
  treesitter.setup(opts)
end
