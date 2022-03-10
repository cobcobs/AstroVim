local M = {}

function M.config()
  require("mini.surround").setup()
  require("mini.comment").setup()
  require("mini.indentscope").setup {
    draw = {
        animation = require("mini.indentscope").gen_animation("none")
    },
    symbol = "│",
    try_as_border = true,
  }

  local my_items = {
    { name = "New File", action = ":ene", section = "Commands"},
    { name = "Configuration", action = ":e $HOME/.config/nvim/lua/user/settings.lua", section = "Commands"},
    { name = "File", action = ":Telescope find_files", section = "Commands"},
    { name = "Grep", action = ":Telescope live_grep", section = "Commands"},
    { name = "Frecency", action = ":Telescope frecency", section = "Commands"},
    { name = "Project", action = ":Telescope projects", section = "Commands"},
    { name = "Quit", action = ":q", section = "Commands"},
  }

  local starter = require('mini.starter')
  starter.setup({
    items = my_items,
    footer = "AstroVim",
    content_hooks = {
      starter.gen_hook.adding_bullet(),
      starter.gen_hook.aligning('center', 'center'),
    },
  })
end

return M
