return function()
  local status_null_ls_ok, null_ls = pcall(require, "null-ls")
  if not status_null_ls_ok then
    vim.notify("Problem with none-ls")
    return
  end

  local status_mason_null_ok, mason_null = pcall(require, "mason-null-ls")
  if not status_mason_null_ok then
    vim.notify("Problem with mason-null-ls")
    return
  end

  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics

  local opts_mason = {
    ensure_installed = {
      "stylua",
      "jq",
      "black",
    }
  }

  local opts = {
    sources = {
      formatting.prettier.with {},
      formatting.black.with { extra_args = { "--fast" } },
      formatting.stylua,
      diagnostics.flake8,
    },
  }

  null_ls.setup(opts)
  mason_null.setup(opts_mason)
end
