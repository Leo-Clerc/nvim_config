return function()
  local status_heirline_ok, heirline = pcall(require, "heirline")
  if not status_heirline_ok then
    return
  end
  local status_heirline_conditions_ok, conditions = pcall(require, "heirline.conditions")
  if not status_heirline_conditions_ok then
    return
  end
  local status_heirline_utils_ok, utils = pcall(require, "heirline.utils")
  if not status_heirline_utils_ok then
    return
  end

  local colors = {

  }

  -- Vim mode 
  local ViMode = {
    init = function(self)
      self.mode = vim.fn.mode(1)
    end,
    static = {
      mode_names = {
        n = "N",
        no = "N?",
        nov = "N?",
        noV = "N?",
        ["no\22"] = "N?",
        niI = "Ni",
        niR = "Nr",
        niV = "Nv",
        nt = "Nt",
        v = "V",
        vs = "Vs",
        V = "V_",
        Vs = "Vs",
        ["\22"] = "^V",
        ["\22s"] = "^V",
        s = "S",
        S = "S_",
        ["\19"] = "^S",
        i = "I",
        ic = "Ic",
        ix = "Ix",
        R = "R",
        Rc = "Rc",
        Rx = "Rx",
        Rv = "Rv",
        Rvc = "Rv",
        Rvx = "Rv",
        c = "C",
        cv = "Ex",
        r = "...",
        rm = "M",
        ["r?"] = "?",
        ["!"] = "!",
        t = "T",
      },
      -- mode_colors = {
      --   n = "red" ,
      --   i = "green",
      --   v = "cyan",
      --   V =  "cyan",
      --   ["\22"] =  "cyan",
      --   c =  "orange",
      --   s =  "purple",
      --   S =  "purple",
      --   ["\19"] =  "purple",
      --   R =  "orange",
      --   r =  "orange",
      --   ["!"] =  "red",
      --   t =  "red",
      -- }
    },
    provider = function(self)
      return "%2("..self.mode_names[self.mode].."%)"
    end,
    hl = function(self)
      local mode = self.mode:sub(1, 1) 
      return { fg = "gray", bold = true, } -- self.mode_colors[mode] for colors in comment before
    end,
    update = {
      "ModeChanged",
      pattern = "*:*",
      callback = vim.schedule_wrap(function()
        vim.cmd("redrawstatus")
      end),
    },
  }
  ViMode = utils.insert(ViMode, {provider = " ", hl = { fl = "gray" } })
  local FileNameBlock = {
      -- let's first set up some attributes needed by this component and it's children
      init = function(self)
          self.filename = vim.api.nvim_buf_get_name(0)
      end,
  }

  local FileIcon = {
      init = function(self)
          local filename = self.filename
          local extension = vim.fn.fnamemodify(filename, ":e")
          self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
      end,
      provider = function(self)
          return self.icon and (self.icon .. " ")
      end,
      hl = function(self)
          return { fg = self.icon_color }
      end
  }

  local FileName = {
      provider = function(self)
          -- first, trim the pattern relative to the current directory. For other
          -- options, see :h filename-modifers
          local filename = vim.fn.fnamemodify(self.filename, ":.")
          if filename == "" then return "[No Name]" end
          -- now, if the filename would occupy more than 1/4th of the available
          -- space, we trim the file path to its initials
          -- See Flexible Components section below for dynamic truncation
          if not conditions.width_percent_below(#filename, 0.25) then
              filename = vim.fn.pathshorten(filename)
          end
          return filename
      end,
      hl = { fg = "gray" }, -- utils.get_highlight("Directory").fg to get color of colorscheme
  }

  local FileFlags = {
      {
          condition = function()
              return vim.bo.modified
          end,
          provider = "[+]",
          hl = { fg = "gray" },
      },
      {
          condition = function()
              return not vim.bo.modifiable or vim.bo.readonly
          end,
          provider = "",
          hl = { fg = "gray" },
      },
  }

  -- Now, let's say that we want the filename color to change if the buffer is
  -- modified. Of course, we could do that directly using the FileName.hl field,
  -- but we'll see how easy it is to alter existing components using a "modifier"
  -- component

  local FileNameModifer = {
      hl = function()
          if vim.bo.modified then
              -- use `force` because we need to override the child's hl foreground
              return { fg = "gray", bold = true, force=true }
          end
      end,
  }

  -- let's add the children to our FileNameBlock component
  FileNameBlock = utils.insert(FileNameBlock,
      -- FileIcon,
      utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
      utils.insert(FileNameBlock, {provider = " ", hl = { fg = "gray" } }),

      FileFlags,
      { provider = '%<'} -- this means that the statusline is cut here when there's not enough space
  )

  local FileType = {
    provider = function()
      return string.upper(vim.bo.filetype)
    end,
    hl = { fg = utils.get_highlight("Type").fg, bold = true },
  }

  local Ruler = {
    provider = "%7(%l/%3L%):%2c %P",
    hl = { fg = "gray" }
  }

  Ruler = utils.insert(Ruler, {provider = " ", hl = { fg = "gray" } } )

  local  LSPActive = {
    condition = conditions.lsp_attached,
    update = {'LspAttach', 'LspDetach'},

    provider = function()
      local names = {}
      for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
        table.insert(names, server.name)
      end
      return " [" .. table.concat(names, " ") .. "]"
    end,
    hl = { fg = "gray", bold = true },
  }

  local Diagnostics = {

      condition = conditions.has_diagnostics,

      static = {
        error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
        warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
        info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
        hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
      },

      init = function(self)
          self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
          self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
          self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
          self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
      end,

      update = { "DiagnosticChanged", "BufEnter" },

      {
          provider = "![",
      },
      {
          provider = function(self)
              -- 0 is just another output, we can decide to print it or not!
              return self.errors > 0 and (self.error_icon .. self.errors .. " ")
          end,
          hl = { fg = "gray" },
      },
      {
          provider = function(self)
              return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
          end,
          hl = { fg = "gray" },
      },
      {
          provider = function(self)
              return self.info > 0 and (self.info_icon .. self.info .. " ")
          end,
          hl = { fg = "gray" },
      },
      {
          provider = function(self)
              return self.hints > 0 and (self.hint_icon .. self.hints)
          end,
          hl = { fg = "gray" },
      },
      {
          provider = "]",
      },
  }
  local statusline = {
    flexible = 1,
    {
    ViMode,
    FileNameBlock,
    -- FileType,
    Ruler,
    LSPActive,
    Diagnostics,
    },
  }

--   local TablineBufnr = {
--     provider = function(self)
--         return tostring(self.bufnr) .. ". "
--     end,
--     hl = "Comment",
-- }

  local TablineFileName = {
      provider = function(self)
          local filename = self.filename
          filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
          return filename
      end,
      hl = function(self)
          return { bold = self.is_active or self.is_visible, italic = true }
      end,
  }

  local TablineFileFlags = {
      {
          condition = function(self)
              return vim.api.nvim_buf_get_option(self.bufnr, "modified")
          end,
          provider = "[+]",
          hl = { fg = "gray" },
      },
      {
          condition = function(self)
              return not vim.api.nvim_buf_get_option(self.bufnr, "modifiable")
                  or vim.api.nvim_buf_get_option(self.bufnr, "readonly")
          end,
          provider = function(self)
              if vim.api.nvim_buf_get_option(self.bufnr, "buftype") == "terminal" then
                  return "  "
              else
                  return ""
              end
          end,
          hl = { fg = "gray" },
      },
  }

  local TablineFileNameBlock = {
      init = function(self)
          self.filename = vim.api.nvim_buf_get_name(self.bufnr)
      end,
      hl = function(self)
          if self.is_active then
              return "gray"
          -- why not?
          -- elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
          --     return { fg = "gray" }
          else
              return "TabLine"
          end
      end,
      on_click = {
          callback = function(_, minwid, _, button)
              if (button == "m") then -- close on mouse middle click
                  vim.schedule(function()
                      vim.api.nvim_buf_delete(minwid, { force = false })
                  end)
              else
                  vim.api.nvim_win_set_buf(0, minwid)
              end
          end,
          minwid = function(self)
              return self.bufnr
          end,
          name = "heirline_tabline_buffer_callback",
      },
      -- TablineBufnr,
      FileIcon, 
      TablineFileName,
      TablineFileFlags,
  }

  -- a nice "x" button to close the buffer
  local TablineCloseButton = {
      condition = function(self)
          return not vim.api.nvim_buf_get_option(self.bufnr, "modified")
      end,
      { provider = " " },
      {
          provider = "",
          hl = { fg = "gray" },
          on_click = {
              callback = function(_, minwid)
                  vim.schedule(function()
                      vim.api.nvim_buf_delete(minwid, { force = false })
                      vim.cmd.redrawtabline()
                  end)
              end,
              minwid = function(self)
                  return self.bufnr
              end,
              name = "heirline_tabline_close_buffer_callback",
          },
      },
  }

  local TablineBufferBlock = utils.surround({ "|", "" }, function(self) -- TODO: Find something to round the border, and color the "|"
      if self.is_active then
          return utils.get_highlight("TabLine").bg -- Yes, same color. But one day we'll put something lighter
      else
          return utils.get_highlight("TabLine").bg
      end
  end, { TablineFileNameBlock, TablineCloseButton })

  local get_bufs = function()
      return vim.tbl_filter(function(bufnr)
          return vim.api.nvim_buf_get_option(bufnr, "buflisted")
      end, vim.api.nvim_list_bufs())
  end

  local buflist_cache = {}

  vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "BufAdd", "BufDelete" }, {
      callback = function()
          vim.schedule(function()
              local buffers = get_bufs()
              for i, v in ipairs(buffers) do
                  buflist_cache[i] = v
              end
              for i = #buffers + 1, #buflist_cache do
                  buflist_cache[i] = nil
              end

              if #buflist_cache > 1 then
                  vim.o.showtabline = 2 -- always
              else
                  vim.o.showtabline = 1 -- only when #tabpages > 1
              end
          end)
      end,
  })

  local BufferLine = utils.make_buflist(
      TablineBufferBlock,
      { provider = " ", hl = { fg = "gray" } },
      { provider = " ", hl = { fg = "gray" } },
      -- out buf_func simply returns the buflist_cache
      function()
          return buflist_cache
      end,
      -- no cache, as we're handling everything ourselves
      false
  )

  local tabline = {
    BufferLine,
  }

  local opts = {
    statusline = statusline,
    tabline = tabline,
    opts = {
      colors = colors,
    },
  }
  heirline.setup(opts)
end
