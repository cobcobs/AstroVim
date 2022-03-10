local config = {

  -- Set colorscheme
  colorscheme = "rose-pine",

  -- Add plugins
  plugins = {
    {
      "rose-pine/neovim",
      as = "rose-pine",
      tag = "v1.*",
    },
    {
			"ethanholz/nvim-lastplace",
			event = "BufRead",
			config = function()
				require("nvim-lastplace").setup({
					lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
					lastplace_ignore_filetype = {
						"gitcommit",
						"gitrebase",
						"svn",
						"hgcommit",
					},
					lastplace_open_folds = true,
				})
			end,
		},
    {
      "echasnovski/mini.nvim",
      config = function()
        require("mini.surround").setup()
        require("mini.comment").setup()
        require("mini.indentscope").setup {
          draw = {
              animation = require("mini.indentscope").gen_animation("none")
          },
          symbol = "│",
          try_as_border = true,
        }
      end,
    },
    { "romainl/vim-cool", event = "CmdlineEnter" },
  },

  overrides = {
    plugins = function(plugins)
      plugins["akinsho/nvim-toggleterm.lua"]["cmd"] = nil
      return plugins
    end,
    packer = {
      display = {
        prompt_border = "none",
      }
    },
    ["which-key"] = {
      window = {
        border = "none",
      }
    },
    treesitter = {
      ensure_installed = { "lua" },
    },
    bufferline = {
      options = {
        always_show_bufferline = false
      },
    },
    ["nvim-tree"] = {
      view = {
        mappings = {
          list = {
            { key = { "l", "<CR>", "o" }, action = "edit", mode = "n" },
            { key = "h", action = "close_node" },
            { key = "v", action = "vsplit" },
            { key = "C", action = "cd" },
          }
        }
      }
    },
    toggleterm = {
      open_mapping = [[<c-t>]],
      float_opts = {
        border = "none",
        highlights = {
          background = "NormalFloat"
        }
      }
    }
  },

  -- On/off virtual diagnostics text
  virtual_text = false,

  -- Disable default plugins
  enabled = {
    bufferline = true,
    nvim_tree = true,
    lualine = false,
    lspsaga = true,
    gitsigns = true,
    colorizer = true,
    toggle_term = true,
    comment = false,
    symbols_outline = true,
    indent_blankline = false,
    dashboard = true,
    which_key = true,
    neoscroll = true,
    ts_rainbow = true,
    ts_autotag = true,
  },

  packer_file = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",

  polish = function()
    local opts = { noremap = true, silent = true }
    local map = vim.api.nvim_set_keymap
    local set = vim.opt
    -- Set options
    set.title = true
    set.ruler = false
    set.showmode = false
    set.cmdheight = 1
    set.wrap = true
    set.cursorline = false
    set.laststatus = 0

    -- Set key bindings
    map("n", "cn", [[/\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgn]], opts)
    map("n", "cN", [[?\<<C-R>=expand('<cword>')<CR>\>\C<CR>``cgN]], opts)
    map("n", "j", "v:count ? 'j' : 'gj'", { noremap = true, expr = true })
    map("n", "k", "v:count ? 'k' : 'gk'", { noremap = true, expr = true })
    map("n", "<C-w>", "<C-w>", opts)
    map("n", "<C-q>", ":call QuickFixToggle()<CR>", opts)

    map("t", "<esc>", "<esc>", opts)

    -- Set autocommands and write functions
    vim.cmd [[
      augroup packer_conf
        autocmd!
        autocmd bufwritepost plugins.lua source <afile> | PackerSync
      augroup end
      autocmd insertenter * set norelativenumber
      autocmd insertleave * set relativenumber
      autocmd FileType dashboard lua vim.b.miniindentscope_disable = true
      autocmd TermOpen * lua vim.b.miniindentscope_disable = true

      function! QuickFixToggle()
        if empty(filter(getwininfo(), 'v:val.quickfix'))
          copen
        else
          cclose
        endif
      endfunction
    ]]
  end,
}

return config
