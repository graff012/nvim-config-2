
-- ~/.config/nvim/lua/custom/configs/lspconfig.lua

local lspconfig = require("lspconfig")

-- Example: configure Lua language server
lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
}

-- You can add more language server setups below
