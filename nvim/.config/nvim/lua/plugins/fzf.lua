return {
  {
    "ibhagwan/fzf-lua",
    lazy = false,
    dependencies = { "vijaymarupudi/nvim-fzf", "nvim-tree/nvim-web-devicons" },
    -- 'kyazdani42/nvim-web-devicons'
    -- optional for icons
    -- use {'vijaymarupudi/nvim-fzf-commands'}
    config = function()
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
    end,
  },
}
