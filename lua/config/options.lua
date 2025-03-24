-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
vim.opt.clipboard = "unnamedplus"
-- Config for fold
vim.opt.foldmethod = "manual"

vim.opt.conceallevel = 2
vim.opt.concealcursor = "nc"

vim.opt.foldmethod = "marker"
vim.opt.foldmarker = "#region,#endregion"


vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = true
-- In case you don't want to use `:LazyExtras`,
-- then you need to set the option below.
vim.g.lazyvim_picker = "snacks"

--vim.cmd [[
--  set showmatch
--  hi MatchParen cterm=bold ctermbg=none guifg=#ffcc00 guibg=none
--]]
--
-- vim.cmd [[
--   hi MatchParen guifg=white guibg=#ff5f5f gui=bold
-- ]]


vim.g.matchup_matchparen_offscreen = { method = "popup" }

vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  command = "let g:matchup_matchparen_enabled = 0",
})

