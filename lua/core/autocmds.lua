local M = {}

local utils = require "core.utils"
local config = utils.user_settings()
local colorscheme = config.colorscheme

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]]

vim.cmd [[
  augroup packer_conf
    autocmd!
    autocmd bufwritepost plugins.lua source <afile> | PackerSync
  augroup end
]]

vim.cmd [[
  autocmd insertenter * set norelativenumber
  autocmd insertleave * set relativenumber
]]

vim.cmd [[autocmd TermOpen * lua vim.b.miniindentscope_disable = true]]

vim.cmd(string.format(
  [[
    augroup colorscheme
      autocmd!
      autocmd VimEnter * colorscheme %s
      autocmd Colorscheme * highlight! link LspFloatWinNormal NormalFloat
      autocmd Colorscheme * source $HOME/.config/nvim/lua/core/colors.lua
    augroup end]],
  colorscheme
))

vim.cmd [[
  command! AstroUpdate lua require('core.utils').update()
]]

return M
