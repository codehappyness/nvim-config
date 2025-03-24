return {
  "nvim-treesitter/nvim-treesitter",
  version = false, -- last release is way too old and doesn't work on Windows
  build = ":TSUpdate",
  event = { "LazyFile", "VeryLazy" },
  lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
  init = function(plugin)
    -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
    -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
    -- no longer trigger the **nvim-treesitter** module to be loaded in time.
    -- Luckily, the only things that those plugins need are the custom queries, which we make available
    -- during startup.
    require("lazy.core.loader").add_to_rtp(plugin)
    require("nvim-treesitter.query_predicates")
  end,
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  keys = {
    { "<c-space>", desc = "Increment Selection" },
    { "<bs>",      desc = "Decrement Selection", mode = "x" },
  },
  opts_extend = { "ensure_installed" },
  ---@type TSConfig
  ---@diagnostic disable-next-line: missing-fields
  dependencies = {
    -- Add nvim-ts-autotag
    "windwp/nvim-ts-autotag",
    -- "nvim-treesitter/nvim-treesitter-context",
    -- "HiPhish/nvim-ts-rainbow2",
    -- "HiPhish/rainbow-delimiters.nvim",
    "nvim-treesitter/playground",
    "windwp/nvim-autopairs",
    "posva/vim-vue",
    "andymass/vim-matchup",
  },
  -- https://github.com/nvim-treesitter/playground#query-linter
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  },

  playground = {
    enable = true,
    disable = {},
    updatetime = 25,        -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = true, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    },
  },
  opts = {
    -- highlight = { enable = true, additional_vim_regex_highlighting = false },
    indent = { enable = true },
    --rainbow = {
    --  enable = true,
    --  extended_mode = true, -- Bật highlight cho cả dấu `{}` lồng nhau
    --  max_file_lines = nil, -- Không giới hạn số dòng
    --},
    autotag = {
      -- Setup autotag using treesitter config.
      enable = true,
    },
    matchup = {
      enable = true, -- Bật match-up highlight
    },
    ensure_installed = {
      "bash",
      "php",
      "blade",
      "c",
      "diff",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "jsonc",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "rust",
      "printf",
      "python",
      "query",
      "regex",
      "toml",
      "tsx",
      "rust",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
    textobjects = {
      move = {
        enable = true,
        goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
        goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
        goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
        goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
      },
    },
  },
  ---@param opts TSConfig
  config = function(_, opts)
    ---@class ParserInfo[]
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.blade = {
      install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = {
          "src/parser.c",
          -- 'src/scanner.cc',
        },
        branch = "main",
        -- generate_requires_npm = true,
        -- requires_generate_from_grammar = true,
      },
      filetype = "blade",
    }
    -- in my settings
    -- Filetypes --
    vim.filetype.add({
      pattern = {
        [".*%.blade%.php"] = "blade",
      },
    })

    -- MDX
    vim.filetype.add({
      extension = {
        mdx = "mdx",
      },
    })
    vim.treesitter.language.register("markdown", "mdx")
    require("nvim-treesitter.configs").setup(opts)
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, { "markdown", "markdown_inline" })
    end
    if type(opts.ensure_installed) == "table" then
      opts.ensure_installed = LazyVim.dedup(opts.ensure_installed)
    end
    require("nvim-treesitter.configs").setup(opts)
    --local rainbow = require("rainbow-delimiters")

    --vim.g.rainbow_delimiters = {
    --  strategy = {
    --    [""] = rainbow.strategy.global,
    --  },
    --  query = {
    --    [""] = "rainbow-delimiters",
    --  },
    --  highlight = {
    --    "RainbowDelimiterRed",
    --    "RainbowDelimiterYellow",
    --    "RainbowDelimiterBlue",
    --    "RainbowDelimiterOrange",
    --    "RainbowDelimiterGreen",
    --    "RainbowDelimiterViolet",
    --    "RainbowDelimiterCyan",
    --  },
    --}
  end,
}
