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

      require("fzf-lua").setup {
        -- default_previewer = "cat",
        files = { fzf_ansi = "", file_icons = false, git_icons = false },
        preview_layout = "vertical",
        winopts = {
          height = 0.95,
          border = "none",
          preview_border = "rounded",
        },

        -- lsp = {
        --   code_actions = {
        --     previewer = "codeaction_native",
        --     preview_pager = "delta --side-by-side --width=$FZF_PREVIEW_COLUMNS",
        --   },
        -- },
        -- TODO bat theme not working because bright?
        -- bat = {
        --   cmd    = "bat",
        --   args   = "--style=numbers,changes --color always --theme ansi",
        --   theme  = 'ansi', -- bat preview theme (bat --list-themes)
        --   config = nil,            -- nil uses $BAT_CONFIG_PATH
        -- },
        -- fzf_binds = { -- fzf '--bind=' options
        --   'f2:toggle-preview', 'f3:toggle-preview-wrap',
        --   'shift-down:preview-page-down', 'shift-up:preview-page-up',
        --   'ctrl-a:beginning-of-line', 'ctrl-d:abort',
        --   'ctrl-u:unix-line-discard', 'ctrl-f:page-down', 'ctrl-b:page-up',
        --   'ctrl-a:toggle-all', 'ctrl-l:clear-screen'
        -- }
      }
    end,
  },
}
