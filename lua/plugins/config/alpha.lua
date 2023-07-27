return function()
  local status_ok, alpha = pcall(require, "alpha")
  if not status_ok then
    return
  end
  local theme_ok, dashboard = pcall(require, "alpha.themes.dashboard")
  if not theme_ok then
    return
  end
  -- Change the logo here
  local logo = {
    "                             ^                        ",
    "                            / \\                      ",
    "                           /   \\                     ",
    "                          /     \\                    ",
    "                         /       \\                   ",
    "                        /         \\                  ",
    "                       /           \\                 ",
    "                      /             \\                ",
    "                     /               \\               ",
    "                    /_________________\\              ",
    "                   / \\               / \\            ",
    "                  /   \\             /   \\           ",
    "                 /     \\           /     \\          ",
    "                /       \\         /       \\         ",
    "               /         \\       /         \\        ",
    "              /           \\     /           \\       ",
    "             /             \\   /             \\      ",
    "            /_______________\\ /_______________\\     ",
  }
  local function footer()
    --local total_plugins =
    local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
    local version = vim.version()
    local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch
    return datetime .. "   " .. " plugins" .. nvim_version_info
end
  dashboard.section.header.val = logo
  dashboard.section.footer.val = footer()
  alpha.setup(dashboard.config)
end
