if true then return {} end
-- return {
--   "adalessa/laravel.nvim",
--   dependencies = {
--     "tpope/vim-dotenv",
--     "nvim-telescope/telescope.nvim",
--     "MunifTanjim/nui.nvim",
--     "kevinhwang91/promise-async",
--     "nvim-neotest/nvim-nio",
--   },
--   cmd = { "Laravel" },
--   keys = {
--     { "<leader>la", ":Laravel artisan<cr>" },
--     { "<leader>lr", ":Laravel routes<cr>" },
--     { "<leader>lm", ":Laravel related<cr>" },
--   },
--   event = { "VeryLazy" },
--   opts = {
--     lsp_server = "intelephense",
--     features = { null_ls = { enable = false } },
--     view_directories = {
--       "resources/views",
--       "Modules/Planning/views", -- Adjust this path to where your Module actually lives
--     },
--   },
--   config = true,
-- }

return {
  "adalessa/laravel.nvim",
  dependencies = {
    "tpope/vim-dotenv",
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
    "kevinhwang91/promise-async",
    "nvim-neotest/nvim-nio",
  },
  -- Thay vì dùng cmd, ta dùng ft để đảm bảo plugin load khi mở file Laravel
  ft = { "php", "blade" },
  keys = {
    { "<leader>la", ":Laravel artisan<cr>", desc = "Laravel Artisan" },
    { "<leader>lr", ":Laravel routes<cr>", desc = "Laravel Routes" },
    { "<leader>lm", ":Laravel related<cr>", desc = "Laravel Related" },
  },
  opts = {
    lsp_server = "intelephense",
    features = {
      null_ls = { enable = false },
      diagnostics = { enable = false }, -- Tắt cái này để hết báo đỏ 'view not exists' lung tung
    },
  },
  config = function(_, opts)
    -- 1. Tự động quét view từ các module (Shift, Planning...)
    local view_paths = { "resources/views" }
    local success, detected = pcall(vim.fn.glob, "*/Views", true, true)
    if success and type(detected) == "table" then
      for _, path in ipairs(detected) do
        table.insert(view_paths, path)
      end
    end
    opts.view_directories = view_paths

    -- 2. Chạy setup an toàn
    local status, laravel = pcall(require, "laravel")
    if not status then
      vim.notify("Không thể load plugin laravel.nvim", vim.log.levels.ERROR)
      return
    end
    laravel.setup(opts)
  end,
}
