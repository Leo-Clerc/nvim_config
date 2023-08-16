return function()
  local status_mason_ok, mason = pcall(require, "mason")
  if not status_mason_ok then
    return
  end

  opts = {
      ui = {
          icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗"
          },
      },
  }
  mason.setup(opts)
  for _, plugin in ipairs { "mason-lspconfig"} do
  end
end
