return {
  {
    "mcchrish/zenbones.nvim",
    lazy = false,
    priority = 1000,
    dependencies = { "rktjmp/lush.nvim", lazy = false, priority = 1001 },
    config = function()
      vim.cmd "colorscheme zenbones"
      vim.o.background = "light"
      vim.api.nvim_set_hl(0, "Cursor", { bg = "#65B8C1" })
      vim.api.nvim_set_hl(0, "Cursor2", { bg = "#65B8C1" })
      vim.api.nvim_set_hl(0, "MarkdownHBg", { bg = "#DEDEDE" })
      vim.api.nvim_set_hl(0, "MarkdownCodeBlock", { bg = "#fbfbfb" })
      -- Set guicursor
      vim.o.guicursor =
        "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor50"
    end,
  },
  { -- color highlight select code blocks:
    "shellRaining/hlchunk.nvim",
    enabled = true,
    -- event = "LazyFile",
    opts = {
      chunk = {
        enable = true,
        notify = true,
        use_treesitter = true,
        chars = {
          horizontal_line = "─",
          vertical_line = "│",
          left_top = "╭",
          left_bottom = "╰",
          right_arrow = "─",
          style = "black",
        },
      },
    },
  },
  -- {
  --   "norcalli/nvim-colorizer.lua",
  --   config = function()
  --     require("colorizer").setup { "css", "javascript", "html" }
  --   end,
  -- },


  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     -- load the colorscheme here
  --     vim.cmd [[colorscheme tokyonight]]
  --   end,
  -- },
  -- {
  --   "Th3Whit3Wolf/space-nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     -- vim.cmd 'colorscheme space-nvim'
  --     -- vim.o.background = "light"
  --   end,
  -- },
  -- {
  --   "folke/tokyonight.nvim",
  --   config = function()
  --     -- vim.g.tokyonight_italic_functions = false
  --     -- vim.g.tokyonight_style = "day"
  --     -- vim.g.tokyonight_transparent = true
  --     -- vim.cmd 'colorscheme tokyonight'
  --     -- vim.cmd 'hi CursorLine cterm=NONE ctermbg=lightblue guibg=lightblue'
  --   end,
  -- },
}
