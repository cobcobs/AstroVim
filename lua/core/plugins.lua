local M = {}

local packer_status_ok, packer = pcall(require, "packer")
if not packer_status_ok then
  return
end

local utils = require "core.utils"
local config = utils.user_settings()

local astro_plugins = {
  -- Plugin manager
  ["wbthomason/packer.nvim"] = {
    "wbthomason/packer.nvim",
  },

  -- Optimiser
  ["lewis6991/impatient.nvim"] = {
    "lewis6991/impatient.nvim",
  },

  -- Lua functions
  ["nvim-lua/plenary.nvim"] = {
    "nvim-lua/plenary.nvim",
  },

  -- Popup API
  ["nvim-lua/popup.nvim"] = {
    "nvim-lua/popup.nvim",
  },

  -- Cursorhold fix
  ["antoinemadec/FixCursorHold.nvim"] = {
    "antoinemadec/FixCursorHold.nvim",
    event = "BufRead",
    config = function()
      vim.g.cursorhold_updatetime = 100
    end,
  },

  -- Icons
  ["kyazdani42/nvim-web-devicons"] = {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("configs.icons").config()
    end,
  },

  -- Bufferline
  ["akinsho/bufferline.nvim"] = {
    "akinsho/bufferline.nvim",
    after = "nvim-web-devicons",
    config = function()
      require("configs.bufferline").config()
    end,
    disable = not config.enabled.bufferline,
  },

  -- Better buffer closing
  ["moll/vim-bbye"] = {
    "moll/vim-bbye",
  },

  -- File explorer
  ["kyazdani42/nvim-tree.lua"] = {
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    commit = "8b27fd4",
    config = function()
      require("configs.nvim-tree").config()
    end,
    disable = not config.enabled.nvim_tree,
  },

  -- Statusline
  ["nvim-lualine/lualine.nvim"] = {
    "nvim-lualine/lualine.nvim",
    commit = "6a3d367",
    config = function()
      require("configs.lualine").config()
    end,
    disable = not config.enabled.lualine,
  },

  -- Syntax highlighting
  ["nvim-treesitter/nvim-treesitter"] = {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    event = "BufRead",
    cmd = {
      "TSInstall",
      "TSInstallInfo",
      "TSInstallSync",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
      "TSDisableAll",
      "TSEnableAll",
    },
    config = function()
      require("configs.treesitter").config()
    end,
    requires = {
      {
        -- Parenthesis highlighting
        "p00f/nvim-ts-rainbow",
        after = "nvim-treesitter",
        disable = not config.enabled.ts_rainbow,
      },
      {
        -- Autoclose tags
        "windwp/nvim-ts-autotag",
        after = "nvim-treesitter",
        disable = not config.enabled.ts_autotag,
      },
      {
        -- Context based commenting
        "JoosepAlviste/nvim-ts-context-commentstring",
        after = "nvim-treesitter",
      },
    },
  },

  -- Snippet engine
  ["L3MON4D3/LuaSnip"] = {
    "L3MON4D3/LuaSnip",
    config = function()
      local settings = require("core.utils").user_settings()
      local loader = require "luasnip/loaders/from_vscode"
      loader.lazy_load { paths = settings.overrides.luasnip.vscode_snippets_paths }
      loader.lazy_load()
    end,
    requires = {
      -- Snippet collections
      "rafamadriz/friendly-snippets",
    },
  },

  -- Completion engine
  ["hrsh7th/nvim-cmp"] = {
    "hrsh7th/nvim-cmp",
    event = "BufRead",
    config = function()
      require("configs.cmp").config()
    end,
  },

  -- Snippet completion source
  ["saadparwaiz1/cmp_luasnip"] = {
    "saadparwaiz1/cmp_luasnip",
    after = "nvim-cmp",
  },

  -- Buffer completion source
  ["hrsh7th/cmp-buffer"] = {
    "hrsh7th/cmp-buffer",
    after = "nvim-cmp",
  },

  -- Path completion source
  ["hrsh7th/cmp-path"] = {
    "hrsh7th/cmp-path",
    after = "nvim-cmp",
  },

  -- LSP completion source
  ["hrsh7th/cmp-nvim-lsp"] = {
    "hrsh7th/cmp-nvim-lsp",
  },

  -- LSP manager
  ["williamboman/nvim-lsp-installer"] = {
    "williamboman/nvim-lsp-installer",
    event = "BufRead",
    cmd = {
      "LspInstall",
      "LspInstallInfo",
      "LspPrintInstalled",
      "LspRestart",
      "LspStart",
      "LspStop",
      "LspUninstall",
      "LspUninstallAll",
    },
  },

  -- Built-in LSP
  ["neovim/nvim-lspconfig"] = {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    config = function()
      require "configs.lsp"
    end,
  },

  -- LSP enhancer
  ["tami5/lspsaga.nvim"] = {
    "tami5/lspsaga.nvim",
    event = "BufRead",
    config = function()
      require("configs.lsp.lspsaga").config()
    end,
    disable = not config.enabled.lspsaga,
  },

  -- LSP symbols
  ["simrat39/symbols-outline.nvim"] = {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    setup = function()
      require("configs.symbols-outline").setup()
    end,
    disable = not config.enabled.symbols_outline,
  },

  -- Formatting and linting
  ["jose-elias-alvarez/null-ls.nvim"] = {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufRead",
    config = function()
      require("user.null-ls").config()
    end,
  },

  -- Fuzzy finder
  ["nvim-telescope/telescope.nvim"] = {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = function()
      require("configs.telescope").config()
    end,
  },

  -- Fuzzy finder syntax support
  ["nvim-telescope/telescope-fzf-native.nvim"] = {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
  },

  -- Fuzzy finder for frecent files
  ["nvim-telescope/telescope-frecency.nvim"] = {
    "nvim-telescope/telescope-frecency.nvim",
    after = "telescope.nvim",
    requires = {"tami5/sqlite.lua"}
  },

  -- Fuzzy finder for projects
  ["ahmedkhalf/project.nvim"] = {
    "ahmedkhalf/project.nvim",
    after = "telescope.nvim",
    config = function()
      require("project_nvim").setup()
    end
  },

  -- Clear highlighting after search
  ["romainl/vim-cool"] = {
    "romainl/vim-cool",
    event = "CmdlineEnter"
  },

  -- Remember last place in file
  ["ethanholz/nvim-lastplace"] = {
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
    disable = not config.enabled.lastplace,
  },

  -- Git integration
  ["lewis6991/gitsigns.nvim"] = {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    config = function()
      require("configs.gitsigns").config()
    end,
    disable = not config.enabled.gitsigns,
  },

  -- Colorscheme
  ["rose-pine/neovim"] = {
    "rose-pine/neovim",
    as = "rose-pine",
    tag = "v1.*",
  },

  -- Color highlighting
  ["norcalli/nvim-colorizer.lua"] = {
    "norcalli/nvim-colorizer.lua",
    event = "BufRead",
    config = function()
      require("configs.colorizer").config()
    end,
    disable = not config.enabled.colorizer,
  },

  -- Autopairs
  ["windwp/nvim-autopairs"] = {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("configs.autopairs").config()
    end,
  },

  -- Terminal
  ["akinsho/nvim-toggleterm.lua"] = {
    "akinsho/nvim-toggleterm.lua",
    cmd = "ToggleTerm",
    config = function()
      require("configs.toggleterm").config()
    end,
    disable = not config.enabled.toggle_term,
  },

  -- Keymaps popup
  ["folke/which-key.nvim"] = {
    "folke/which-key.nvim",
    config = function()
      require("configs.which-key").config()
    end,
    disable = not config.enabled.which_key,
  },

  -- mini.nvim
  ["echasnovski/mini.nvim"] = {
    "echasnovski/mini.nvim",
    config = function()
      require("configs.mini").config()
    end,
    disable = not config.enabled.mini,
  },

  -- Get extra JSON schemas
  ["b0o/SchemaStore.nvim"] = { "b0o/SchemaStore.nvim" },
}

packer.startup {
  function(use)
    local plugins = astro_plugins

    -- Append user defined plugins
    if config.plugins and not vim.tbl_isempty(config.plugins) then
      for _, plugin in pairs(config.plugins) do
        table.insert(plugins, plugin)
      end
    end

    -- Load plugins!
    for _, plugin in pairs(require("core.utils").user_plugin_opts("plugins", plugins)) do
      use(plugin)
    end
  end,
  config = require("core.utils").user_plugin_opts("packer", {
    compile_path = config.packer_file,
    display = {
      open_fn = function()
        return require("packer.util").float { border = "none" }
      end,
      prompt_border = "none",
    },
    profile = {
      enable = true,
      threshold = 0.0001,
    },
    git = {
      clone_timeout = 300,
    },
    auto_clean = true,
    compile_on_sync = true,
  }),
}

return M
