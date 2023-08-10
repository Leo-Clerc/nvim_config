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
  -- TODO: Add other buttons. One with telescope, I guess ?
  local buttons = {
    dashboard.button( "e", " New file" , ":ene <BAR> startinsert <CR>"),
    dashboard.button( "SPC f f", "󰱼 Search file" , ":lua require('telescope.builtin').find_files()<CR>"),
    dashboard.button( "SPC f w", "󰈬 Search word", ":Telescope live_grep<CR>"),
    dashboard.button( "q", "󰩈 Quit", ":qa<CR>"),
  }
  local function footer()
    --local total_plugins =
    local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
    local version = vim.version()
    local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch
    return datetime .. "   " .. " plugins" .. nvim_version_info
end
  dashboard.section.header.val = logo
  dashboard.section.buttons.val = buttons
  dashboard.section.footer.val = footer()
  alpha.setup(dashboard.config)
end
