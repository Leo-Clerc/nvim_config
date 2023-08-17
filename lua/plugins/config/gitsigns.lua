return function()
  local status_gitsigns_ok, gitsigns = pcall(require, "gitsigns")
  if not status_gitsigns_ok then
    return
  end
  opts = {}
  gitsigns.setup(opts)
end
