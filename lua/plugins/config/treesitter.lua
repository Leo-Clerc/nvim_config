return function()
  local status_treesitter_ok, treesitter = pcall(require, "nvim-treesitter.configs")
  if not status_treesitter_ok then
    vim.notify("Problem with Treesitter")
  end
  local opts = {
    ensure_installed = "all",
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      disable = {"glsl"},
      aditional_vim_regex_highlighting = false,
    },
  }
  treesitter.setup(opts)
end
