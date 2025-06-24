-- ~/.config/nvim/lua/custom/plugins.lua

return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require("custom.configs.conform"),
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("custom.configs.lspconfig")
    end,
  },

  {
    "kamykn/spelunker.vim",
    config = function()
      vim.g.spelunker_check_type = "all"
      vim.g.spelunker_highlight_type = "spell"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldenable = true
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup {
        custom_highlights = function(colors)
          return {
            Cursor = { bg = colors.surface2, fg = colors.base },
            CursorLine = { bg = colors.surface0 },
          }
        end,
      }
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  {
    "karb94/neoscroll.nvim",
    lazy = false,
    config = function()
      vim.o.scroll = 8
      vim.keymap.set("n", "<C-d>", "8j", { noremap = true })
      vim.keymap.set("n", "<C-u>", "8k", { noremap = true })

      require("neoscroll").setup {
        mappings = { "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
        hide_cursor = true,
        stop_eof = true,
        respect_scrolloff = false,
        cursor_scrolls_alone = true,
      }
    end,
  },

  {
    "prisma/vim-prisma",
    ft = "prisma",
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "prisma",
        callback = function()
          vim.bo.tabstop = 2
          vim.bo.shiftwidth = 2
          vim.bo.softtabstop = 2
          vim.bo.expandtab = true
        end,
      })
    end,
  },

  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    opts = {
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          return false
        end,
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "TroubleToggle", "Trouble" },
    config = function()
      require("trouble").setup {}
      vim.keymap.set("n", "<leader>uu", "<cmd>TroubleToggle<CR>", { silent = true, noremap = true, desc = "Toggle Trouble" })
      vim.keymap.set("n", "<leader>uw", "<cmd>TroubleToggle workspace_diagnostics<CR>", { silent = true, noremap = true, desc = "Workspace Diagnostics" })
      vim.keymap.set("n", "<leader>ud", "<cmd>TroubleToggle document_diagnostics<CR>", { silent = true, noremap = true, desc = "Document Diagnostics" })
      vim.keymap.set("n", "<leader>uc", "<cmd>TroubleClose<CR>", { silent = true, noremap = true, desc = "Close Trouble" })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("custom.configs.telescope")
    end,
    cmd = "Telescope",
  },
}
