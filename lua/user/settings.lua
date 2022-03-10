local config = {

  -- Set colorscheme
  colorscheme = "rose-pine",

  overrides = {
    plugins = function(plugins)
      plugins["akinsho/nvim-toggleterm.lua"]["cmd"] = nil
      return plugins
    end,
  },

  -- On/off virtual diagnostics text
  virtual_text = false,

  packer_file = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
}

return config
