vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  command = "set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20",
})

return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
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
        "javascript", -- Add more as needed
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

      -- 🪄 Enable folding via Treesitter
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
      vim.cmd.colorscheme "catppuccin"
    end,
  },

  {
    "karb94/neoscroll.nvim",
    lazy = false,
    config = function()
      -- First set Vim's native scroll setting to 8 lines
      vim.o.scroll = 8

      -- Directly map Ctrl+d and Ctrl+u to custom functions that scroll exactly 8 lines
      vim.keymap.set("n", "<C-d>", "8j", { noremap = true })
      vim.keymap.set("n", "<C-u>", "8k", { noremap = true })

      -- Then configure neoscroll for other scrolling actions
      require("neoscroll").setup {
        -- Remove C-d and C-u from neoscroll mappings since we're handling them directly
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
    ft = "prisma", -- Optional: lazy-load only for Prisma files
    config = function()
      -- Set Prisma-specific formatting options
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
      -- Add this view_options section
      view_options = {
        show_hidden = true, -- This will show hidden files
        is_always_hidden = function(name, _)
          -- Optional: you can exclude specific hidden files if needed
          return false -- Return false to show ALL files
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
      vim.keymap.set(
        "n",
        "<leader>uu",
        "<cmd>TroubleToggle<CR>",
        { silent = true, noremap = true, desc = "Toggle Trouble" }
      )
      vim.keymap.set(
        "n",
        "<leader>uw",
        "<cmd>TroubleToggle workspace_diagnostics<CR>",
        { silent = true, noremap = true, desc = "Workspace Diagnostics" }
      )
      vim.keymap.set(
        "n",
        "<leader>ud",
        "<cmd>TroubleToggle document_diagnostics<CR>",
        { silent = true, noremap = true, desc = "Document Diagnostics" }
      )
      vim.keymap.set(
        "n",
        "<leader>uc",
        "<cmd>TroubleClose<CR>",
        { silent = true, noremap = true, desc = "Close Trouble" }
      )
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = require("configs.telescope"),
    cmd = "Telescope", -- Optional: lazy-load on command
  },
}
