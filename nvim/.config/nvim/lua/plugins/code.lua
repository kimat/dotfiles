return {
  {
    -- ⚠️ viml based plugin
    "tpope/vim-rails",
  },
  {
    -- ⚠️ viml based plugin
    "bogado/file-line",
  },
  {
    "gbprod/yanky.nvim",
    opts = {},
  },
  {
    -- ⚠️ viml based plugin
    "tpope/vim-fugitive",
  },
  {
    -- ⚠️ viml based plugin
    "editorconfig/editorconfig-vim",
  },
  -- reformat text
  {
    "Wansmer/treesj",
    keys = { "<space>m", "<space>j", "<space>s" },
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
    config = function()
      require("treesj").setup {
        use_default_keymaps = true,
      }
    end,
  },
  { "godlygeek/tabular" },
  { "cuducos/yaml.nvim" },
}
