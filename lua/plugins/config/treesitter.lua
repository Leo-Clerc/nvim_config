return function()
  local status_treesitter_ok, treesitter = pcall(require, "nvim-treesitter")
  if not status_treesitter_ok then
    vim.notify("Treesitter unavailable")
    return
  end
  local opts = {
    ensure_installed = {
      "rust",
      "python",
      "typescript",
      "javascript"
    },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      disable = {--[[ "glsl" ]]},
      aditional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
  }
  treesitter.setup(opts)
  treesitter.install(opts.ensure_installed)
end
