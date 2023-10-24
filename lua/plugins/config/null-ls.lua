return function()

  local status_mason_null_ls_ok; mason_null_ls = pcall(require, "")
  if not status_mason_null_ls_ok then
    return
  end

  local status_null_ls_ok, null_ls = pcall(require, "null-ls")
  if not status_null_ls_ok then
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

  local opts_null = {

  }

  mason_null_ls.setup(opts_mason)
  null_ls.setup(opts_null)
end

