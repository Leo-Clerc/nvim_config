return function()
  local status_bufferline_ok, bufferline = pcall(require, "bufferline")
  if not status_bufferline_ok then
    return
  end
  opts = {
    options = {
      mode = "buffers",
      style_preset = bufferline.style_preset.default,
    },
  }
  -- bufferline.setup(opts)
end

