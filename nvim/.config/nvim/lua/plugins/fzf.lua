vim.pack.add {
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/vijaymarupudi/nvim-fzf",
  "https://github.com/nvim-tree/nvim-web-devicons",
}

vim.api.nvim_create_user_command("H", function()
  -- user commands
  require("fzf-lua").helptags {
    winopts = { preview = { layout = "horizontal" } },
  }
end, { nargs = "?" })

require("fzf-lua").setup {
  winopts = {
    preview = {
      layout = "vertical",
    },
    height = 0.95,
    border = "none",
  },
  files = { file_icons = false, git_icons = false },
}
