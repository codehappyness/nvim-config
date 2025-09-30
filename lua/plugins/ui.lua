return {
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "Selections to be",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })
      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }
      opts.presets.lsp_doc_border = true
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
    },
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>",   "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        --separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },
  -- animations
  {
    "nvim-mini/mini.animate",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.scroll = {
        enable = false,
      }
    end,
  },
  -- filename
  --{
  --  "b0o/incline.nvim",
  --  dependencies = { "craftzdog/solarized-osaka.nvim" },
  --  event = "BufReadPre",
  --  priority = 1200,
  --  config = function()
  --    local colors = require("solarized-osaka.colors").setup()
  --    require("incline").setup({
  --      highlight = {
  --        groups = {
  --          InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
  --          InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
  --        },
  --      },
  --      window = { margin = { vertical = 0, horizontal = 1 } },
  --      hide = {
  --        cursorline = true,
  --      },
  --      render = function(props)
  --        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
  --        if vim.bo[props.buf].modified then
  --          filename = "[+] " .. filename
  --        end

  --        local icon, color = require("nvim-web-devicons").get_icon_color(filename)
  --        return { { icon, guifg = color }, { " " }, { filename } }
  --      end,
  --    })
  --  end,
  --},
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
      local logo = [[
 ██████╗ ██████╗ ██████╗ ███████╗██╗  ██╗ █████╗ ██████╗ ██████╗ ██╗   ██╗███╗   ██╗███████╗███████╗███████╗
██╔════╝██╔═══██╗██╔══██╗██╔════╝██║  ██║██╔══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝████╗  ██║██╔════╝██╔════╝██╔════╝
██║     ██║   ██║██║  ██║█████╗  ███████║███████║██████╔╝██████╔╝ ╚████╔╝ ██╔██╗ ██║█████╗  ███████╗███████╗
██║     ██║   ██║██║  ██║██╔══╝  ██╔══██║██╔══██║██╔═══╝ ██╔═══╝   ╚██╔╝  ██║╚██╗██║██╔══╝  ╚════██║╚════██║
╚██████╗╚██████╔╝██████╔╝███████╗██║  ██║██║  ██║██║     ██║        ██║   ██║ ╚████║███████╗███████║███████║
 ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝        ╚═╝   ╚═╝  ╚═══╝╚══════╝╚══════╝╚══════╝
      ]]
      --logo = string.rep("\n", 8) .. logo .. "\n\n"
      local header_lines = vim.split(logo, "\n", { trimempty = true })
      require("dashboard").setup({
        --theme = "hyper",
        config = {
          header = header_lines,
        },
        -- config
      })
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },

}
