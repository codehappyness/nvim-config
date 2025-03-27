--return {
--  "folke/tokyonight.nvim",
--  lazy = true,
--  opts = { style = "moon", transparent = true },
--}

return {
  "craftzdog/solarized-osaka.nvim",
  lazy = true,
  priority = 1000,
  opts = function()
    return {
      transparent = true,
    }
  end,
}
