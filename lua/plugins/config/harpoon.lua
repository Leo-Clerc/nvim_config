return function()
  status_harpoon_ok, harpoon = pcall(require, "harpoon")
  if not status_harpoon_ok then
    return
  end
  opts = {}
  harpoon.setup()
end
