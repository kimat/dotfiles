-- vim.treesitter.language.register("embedded_template", "html")
vim.cmd.autocmd "BufRead,BufNewFile *.ejs se filetype=html"
return {
  {
    -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "RRethy/nvim-treesitter-endwise",
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    build = ":TSUpdate",
    config = function()
      -- set foldmethod=expr
      -- set foldexpr=nvim_treesitter#foldexpr()
      -- require'nvim-treesitter.install'.compilers = {'gcc'}
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
      require("nvim-treesitter.configs").setup {
        -- context_commentstring = { enable = true, enable_autocmd = false }, -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
        endwise = { enable = true }, -- https://github.com/RRethy/nvim-treesitter-endwise
        autotag = { -- https://github.com/windwp/nvim-ts-autotag
          enable = true,
        },
        -- textobjects = {enable = true},
        -- rainbow = { enable = true },
        indent = { enable = true, disable = {} },
        folding = { enable = true },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
        ensure_installed = {
          "vimdoc",
          -- "ruby",
          "bash",
          "dockerfile",
          "gitignore",
          "hcl",
          "html",
          "embedded_template",
          "javascript",
          "json",
          "lua",
          "nix",
          "python",
          "terraform",
          "vim",
          "yaml",
          "markdown",
          "embedded_template",
          "hurl",
        },
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    config = function()
      require("nvim-treesitter.configs").setup {
        textobjects = {
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [",,"] = "@function.outer",
              [",a"] = "@parameter.inner",
              -- [",m"] = "@class.outer"
            },
            goto_previous_start = { [",z"] = "@parameter.inner" },
          },
          swap = {
            enable = true,
            swap_next = { [",l"] = "@parameter.inner" },
            swap_previous = { [",h"] = "@parameter.inner" },
          },
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["ac"] = "@class.outer",
              ["af"] = "@function.outer",
              ["ar"] = "@block.outer",
              ["ic"] = "@class.inner",
              ["if"] = "@function.inner",
              ["ir"] = "@block.inner",
            },
          },
        },
      }
    end,
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
}
