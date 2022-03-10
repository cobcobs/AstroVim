local M = {}

local utils = require "core.utils"
local config = utils.user_settings()
local colorscheme = config.colorscheme
local parsers = require("nvim-treesitter.parsers")
function _G.ensure_treesitter_language_installed()
	local lang = parsers.get_buf_lang()
	if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) then
		vim.schedule_wrap(function()
			vim.cmd("TSInstallSync " .. lang)
			vim.cmd([[e!]])
		end)()
	end
end

vim.cmd([[autocmd FileType * :lua ensure_treesitter_language_installed()]])

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

vim.cmd [[autocmd FileType * set formatoptions-=c formatoptions-=r formatoptions-=o]]

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
