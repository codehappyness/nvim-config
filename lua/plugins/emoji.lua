return {
  {
    "xiyaowong/telescope-emoji.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      {
        "<C-e>",
        function()
          require("telescope").extensions.emoji.emoji()
        end,
        --mode = "i", -- hoạt động trong insert mode
        desc = "Open emoji picker",
      },
    },
    config = function()
      local telescope = require("telescope")

      telescope.setup({
        extensions = {
          emoji = {
            action = function(emoji)
              -- emoji là table: { name = "", value = "", category = "", description = "" }

              -- Copy emoji vào clipboard
              vim.fn.setreg("*", emoji.value)
              --print([[Press p or "*p to paste this emoji: ]] .. emoji.value)

              -- Chèn emoji ngay vào vị trí con trỏ
              vim.api.nvim_put({ emoji.value }, "c", false, true)
            end,
          },
        },
      })

      -- Load extension
      telescope.load_extension("emoji")
    end,
  },
}
