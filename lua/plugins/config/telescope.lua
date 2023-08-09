return function()
  local status_telescope_ok, telescope = pcall(require, "telescope")
  if not status_telescope_ok then
    vim.notify("Telescope isn't ok")
  end
  local opts = {
    defaults = {
      mappings = {

      },
      preview = {
        treesitter = true,
      },
    },
  }
  telescope.setup(opts)
end
