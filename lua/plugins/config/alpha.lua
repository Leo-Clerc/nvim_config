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
  local triforce = {
    "                                                      ",
    "                             ██                       ",
    "                            ████                      ",
    "                           ██████                     ",
    "                          ████████                    ",
    "                         ██████████                   ",
    "                        ████████████                  ",
    "                       ██████████████                 ",
    "                      ████████████████                ",
    "                     ██████████████████               ",
    "                    ████████████████████              ",
    "                                                    ",
    "                  ██                  ██            ",
    "                 ████                ████           ",
    "                ██████              ██████          ",
    "               ████████            ████████         ",
    "              ██████████          ██████████        ",
    "             ████████████        ████████████       ",
    "            ██████████████      ██████████████      ",
    "           ████████████████    ████████████████     ",
    "          ██████████████████  ██████████████████    ",
    "         ████████████████████████████████████████   ",
 }
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
  -- TODO: Add other buttons. One with telescope, I guess ?
  local buttons = {
    dashboard.button( "e", "o New file" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "q", "x Quit", ":qa<CR>"),
  }
  local function footer()
    --local total_plugins =
    local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
    local version = vim.version()
    local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch
    return datetime .. "   " .. " plugins" .. nvim_version_info
end
  dashboard.section.header.val = triforce
  dashboard.section.buttons.val = buttons
  dashboard.section.footer.val = footer()
  alpha.setup(dashboard.config)
end
