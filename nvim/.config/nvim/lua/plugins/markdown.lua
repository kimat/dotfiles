return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {},
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("render-markdown").setup {
        sign = {
          -- Turn on / off sign rendering
          enabled = false,
          -- Applies to background of sign text
          highlight = "RenderMarkdownSign",
        },
      }
    end,
  },
  {
    "plasticboy/vim-markdown",
    config = function()
      vim.g.vim_markdown_no_default_key_mappings = 1
      vim.g.vim_markdown_new_list_item_indent = 0
      vim.g.vim_markdown_no_extensions_in_markdown = 1
      vim.g.vim_markdown_folding_style_pythonic = 1
      vim.g.vim_markdown_override_foldtext = 0
      vim.g.vim_markdown_folding_level = 1
    end,
  },
  {
    "previm/previm", -- ⚠️ viml based
    ft = "markdown",
    config = function()
      vim.g.previm_open_cmd = "firefox"
      vim.g.previm_plantuml_imageprefix = "http://localhost:8080/plantuml/img/"
    end,
  },
  -- {
  --   "OXY2DEV/markview.nvim",
  --   lazy = "false",
  --   -- dependencies = { "nvim-tree/nvim-web-devicons" },
  --   config = function()
  --     require("markview").setup()
  --   end,
  -- },
  -- {
  --   "lukas-reineke/headlines.nvim",
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  --   config = true, -- or `opts = {}`
  -- },
}
