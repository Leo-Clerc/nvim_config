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
      mode_colors = {
        n = "red" ,
        i = "green",
        v = "cyan",
        V =  "cyan",
        ["\22"] =  "cyan",
        c =  "orange",
        s =  "purple",
        S =  "purple",
        ["\19"] =  "purple",
        R =  "orange",
        r =  "orange",
        ["!"] =  "red",
        t =  "red",
      }
    },
    provider = function(self)
      return "%2("..self.mode_names[self.mode].."%)"
    end,
    hl = function(self)
      local mode = self.mode:sub(1, 1) 
      return { fg = self.mode_colors[mode], bold = true, }
    end,
    update = {
      "ModeChanged",
      pattern = "*:*",
      callback = vim.schedule_wrap(function()
        vim.cmd("redrawstatus")
      end),
    },
  }
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
      hl = { fg = utils.get_highlight("Directory").fg },
  }

  local FileFlags = {
      {
          condition = function()
              return vim.bo.modified
          end,
          provider = "[+]",
          hl = { fg = "green" },
      },
      {
          condition = function()
              return not vim.bo.modifiable or vim.bo.readonly
          end,
          provider = "",
          hl = { fg = "orange" },
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
              return { fg = "cyan", bold = true, force=true }
          end
      end,
  }

  -- let's add the children to our FileNameBlock component
  FileNameBlock = utils.insert(FileNameBlock,
      FileIcon,
      utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
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
  }

  local statusline = {
    ViMode,
    FileNameBlock,
    -- FileType,
    Ruler,
  }

  local opts = {
    statusline = statusline,
    opts = {
      colors = colors,
    }
  }
  heirline.setup(opts)
end
