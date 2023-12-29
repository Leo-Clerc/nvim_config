return function()
  local status_null_ls_ok, null_ls = pcall(require, "null-ls")
  if not status_null_ls_ok then
    vim.notify("Problem with none-ls")
    return
  end

  local opts_mason = {
    sources = {
      ensure_installed = {
        'stylua',
        'jq',
        'mdl',
      },
      automatic_installation = true,
      handlers = {},
    },
  }

  null_ls.setup(opts_mason)
end
