return {
  {
    "ibhagwan/fzf-lua",
    lazy = false,
    dependencies = { "vijaymarupudi/nvim-fzf", "nvim-tree/nvim-web-devicons" },
    -- 'kyazdani42/nvim-web-devicons'
    -- optional for icons
    -- use {'vijaymarupudi/nvim-fzf-commands'}
    config = function()
      Map("n", "mo", "<Cmd>FzfLua files<CR>")
      Map("n", "ml", "<Cmd>FzfLua buffers<CR>")
      Map(
        "n",
        "mt",
        "<Cmd>lua require('fzf-lua').files({ cwd = '~/my/tips' })<CR>"
      )
      Map(
        "n",
        "mc",
        "<Cmd>lua require('fzf-lua').files({ cmd = 'cat ~/.config/marks/configs' })<CR>"
      )
      Map("n", "mm", "<Cmd>lua require('fzf-lua').files({ cwd = '~/my' })<CR>")
      Map("n", "ga", "<Cmd>FzfLua lsp_code_actions<CR>")

      -- so :h<enter> shows a fzf menu to open a man page
      vim.cmd.cnoreabbrev(
        "<expr> h",
        'getcmdtype() == ":" && getcmdline() == "h" ? "H" : "h"'
      )
      vim.api.nvim_create_user_command("H", function()
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
