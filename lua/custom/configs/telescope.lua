
-- ~/.config/nvim/lua/custom/configs/telescope.lua

local actions = require("telescope.actions")

require("telescope").setup({
  defaults = {
    hidden = true,
    file_ignore_patterns = { ".git/", "node_modules/" },
    mappings = {
      i = {
        ["<Esc>"] = actions.close,
      },
    },
  },
})

vim.keymap.set("n", "<leader>ff", function()
  require("telescope.builtin").find_files({ hidden = true })
end, { desc = "Find files (hidden too)" })
