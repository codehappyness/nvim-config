-- if true then return {} end
-- return {
--   -- Yêu cầu Mason tự động cài đặt các công cụ cần thiết cho Spring Boot
--   {
--     "williamboman/mason.nvim",
--     opts = function(_, opts)
--       opts.ensure_installed = opts.ensure_installed or {}
--       vim.list_extend(opts.ensure_installed, {
--         "spring-boot-tools", -- Hỗ trợ auto-complete cho properties/yml của Spring
--         "java-debug-adapter", -- Cần thiết để debug
--         "java-test",         -- Cần thiết để chạy Unit Test
--       })
--     end,
--   },
-- }
return {
    "elmcgill/springboot-nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "mfussenegger/nvim-jdtls"
    },
    config = function()
        local springboot_nvim = require("springboot-nvim")
        vim.keymap.set('n', '<leader>Jr', springboot_nvim.boot_run, {desc = "Spring Boot Run Project"})
        vim.keymap.set('n', '<leader>Jc', springboot_nvim.generate_class, {desc = "Java Create Class"})
        vim.keymap.set('n', '<leader>Ji', springboot_nvim.generate_interface, {desc = "Java Create Interface"})
        vim.keymap.set('n', '<leader>Je', springboot_nvim.generate_enum, {desc = "Java Create Enum"})
        springboot_nvim.setup({})
    end
}
