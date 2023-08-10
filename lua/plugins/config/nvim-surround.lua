return function()
  local status_surround_ok, surround = pcall(require, "nvim-surround")
  if not status_surround_ok then
    return
  end

  surround.setup()
end
