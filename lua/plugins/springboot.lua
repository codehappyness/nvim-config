return {
  -- Yêu cầu Mason tự động cài đặt spring-boot-tools
  {
    "mason.nvim",
    opts = function(_, opts)
      opts.registries = opts.registries or {
        "github:mason-org/mason-registry",
      }
      -- Thêm registry của nvim-java vào để tìm thấy spring-boot-tools
      if not vim.tbl_contains(opts.registries, "github:nvim-java/mason-registry") then
        table.insert(opts.registries, 1, "github:nvim-java/mason-registry")
      end

      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "vscode-spring-boot-tools", -- Hỗ trợ auto-complete cho properties/yml của Spring
      })
    end,
  },
  -- Plugin springboot-nvim để chạy project Spring Boot nhanh và generate code
  {
    "elmcgill/springboot-nvim",
    ft = { "java", "xml" },
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
  },
  -- Plugin hỗ trợ Spring Boot autocomplete (application.properties/yml, annotations)
  {
    "JavaHello/spring-boot.nvim",
    ft = { "java", "yaml", "jproperties" },
    dependencies = {
      "mfussenegger/nvim-jdtls",
      "ibhagwan/fzf-lua",
    },
    opts = {},
  },
  -- Ép nvim-jdtls sử dụng nhánh master (mới nhất) thay vì bản tag 0.2.0 cũ để tránh thiếu module jdtls.tests
  {
    "mfussenegger/nvim-jdtls",
    version = false,
  }
}
