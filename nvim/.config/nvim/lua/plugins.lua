local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

plugins = {
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     -- load the colorscheme here
  --     vim.cmd [[colorscheme tokyonight]]
  --   end,
  -- },
  {
    "mcchrish/zenbones.nvim",
    lazy = false,
    priority = 1000,
    dependencies = { "rktjmp/lush.nvim", lazy = false, priority = 1001 },
    config = function()
      vim.cmd "colorscheme zenbones"
      vim.o.background = "light"
    end,
  },
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
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
      -- require("Comment").setup {
      --   pre_hook = require(
      --     "ts_context_commentstring.integrations.comment_nvim"
      --   ).create_pre_hook(),
      -- }
    end,
  },
  {
    -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages

    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "RRethy/nvim-treesitter-endwise",
      "windwp/nvim-ts-autotag",
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
          "bash",
          "dockerfile",
          "gitignore",
          "hcl",
          "html",
          "javascript",
          "json",
          "lua",
          "nix",
          "python",
          "ruby",
          "terraform",
          "vim",
          "yaml",
          "markdown",
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
  { "L3MON4D3/LuaSnip" },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      require("cmp").setup {
        -- mapping = cmp.mapping.preset.insert {
        --   ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        --   ["<C-f>"] = cmp.mapping.scroll_docs(4),
        --   ["<C-Space>"] = cmp.mapping.complete(),
        --   ["<C-e>"] = cmp.mapping.abort(),
        --   ["<CR>"] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        -- },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
        },
      }
    end,
  },
  -- { "hrsh7th/cmp-nvim-lsp" },
  { "saadparwaiz1/cmp_luasnip" },
  -- { "hrsh7th/nvim-cmp" },
  { "neovim/nvim-lspconfig" },
  {
    "mfussenegger/nvim-lint",
    config = function()
      -- https://github.com/mfussenegger/nvim-lint#available-linters
      require("lint").linters_by_ft = {
        javascript = { "eslint" },
      }
    end,
  },
  {
    "kimat/formatter.nvim",
    branch = "add-erb-formatting-support",
    config = function()
      local util = require "formatter.util"
      require("formatter").setup {
        filetype = {
          eruby = require("formatter.filetypes.eruby").erbformatter,
          ruby = require("formatter.filetypes.ruby").standardrb,
          lua = require("formatter.filetypes.lua").stylua,
          terraform = {
            function()
              return { exe = "terraform", stdin = true, args = { "fmt", "-" } }
            end,
          },
          json = {
            function()
              return { exe = "underscore", stdin = true, args = { "print" } }
            end,
          },
          markdown = require("formatter.filetypes.markdown").prettier,
          python = require("formatter.filetypes.python").autopep8,
          nix = require("formatter.filetypes.nix").nixfmt,
          javascript = {
            function()
              return {
                exe = "prettier",
                stdin = true,
                args = {
                  "--with-node-modules",
                  "--stdin-filepath",
                  util.escape_path(util.get_current_buffer_file_path()),
                },
              }
            end,
          },
        },
      }
    end,
  },
  -- {
  --   'dense-analysis/ale',
  --   config = function()
  --     vim.g.ale_fix_on_save = 1
  --     vim.g.ale_lua_lua_format_options = "--no-use-tab --indent-width=2"
  --     vim.g.ruby_rubocop_options = "--safe"
  --     vim.g.ale_sign_error = '✖'
  --     vim.g.ale_sign_warning = '⚠'
  --     vim.g.ale_sign_style_error = 'q'
  --     vim.g.ale_sign_style_warning = 'S'

  --     vim.g.ale_linters = {
  --       ['ruby'] = {'rubocop'},
  --       ['javascript'] = {'eslint'}
  --     }

  --     vim.g.ale_fixers = {
  --       ['nix'] = {'nixfmt'},
  --       ['lua'] = {'lua-format'},
  --       ['javascript'] = {'prettier'},
  --       ['javascriptreact'] = {'prettier'},
  --       ['markdown'] = {'prettier'},
  --       ['ruby'] = {'rubocop'},
  --       ['hcl'] = {'terraform'}
  --     }
  --   end
  -- },

  -- {
  --   'plasticboy/vim-markdown',
  --   config = function()
  --     vim.g.vim_markdown_no_default_key_mappings = 1
  --     vim.g.vim_markdown_new_list_item_indent = 0
  --     vim.g.vim_markdown_no_extensions_in_markdown = 1
  --     vim.g.vim_markdown_folding_style_pythonic = 1
  --     vim.g.vim_markdown_override_foldtext = 0
  --     vim.g.vim_markdown_folding_level = 1
  --   end
  -- },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  -- {'nvim-treesitter/nvim-treesitter' -- syntax highlight using treesitter},
  -- {
  --   "norcalli/nvim-colorizer.lua",
  --   config = function()
  --     require("colorizer").setup { "css", "javascript", "html" }
  --   end,
  -- },
  {
    "ibhagwan/fzf-lua",
    lazy = false,
    dependencies = { "vijaymarupudi/nvim-fzf" },
    -- 'kyazdani42/nvim-web-devicons' } -- optional for icons
    -- use {'vijaymarupudi/nvim-fzf-commands'}
    config = function()
      map("n", "mo", "<Cmd>FzfLua files<CR>")
      map("n", "ml", "<Cmd>FzfLua buffers<CR>")
      map(
        "n",
        "mt",
        "<Cmd>lua require('fzf-lua').files({ cwd = '~/my/tips' })<CR>"
      )
      map(
        "n",
        "mc",
        "<Cmd>lua require('fzf-lua').files({ cmd = 'cat ~/my/zsh/.config/marks/configs' })<CR>"
      )
      map("n", "mm", "<Cmd>lua require('fzf-lua').files({ cwd = '~/my' })<CR>")

      require("fzf-lua").setup {
        default_previewer = "cat",
        files = { fzf_ansi = "", file_icons = false, git_icons = false },
        preview_layout = "vertical",
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

  -- viml based plugins
  {
    "previm/previm",
    ft = "markdown",
    config = function()
      vim.g.previm_open_cmd = "firefox"
      -- vim.g.previm_plantuml_imageprefix = "http://localhost:8080/plantuml/img"
    end,
  },
  {
    "esamattis/slimux",
    config = function()
      map("v", "ee", ":SlimuxREPLSendSelection<CR>")
      map("n", "ee", "<Cmd>SlimuxREPLSendLine<CR>")
      map("n", "ep", "vip:SlimuxREPLSendSelection<CR>")
      map("n", "ex", "<Cmd>SlimuxGlobalConfigure<CR>")
      map(
        "n",
        "ej",
        ':let @t=expand("%:.").":".line(".")<CR>:SlimuxShellRun spring rspec <c-r>t<CR>'
      )
      map(
        "n",
        "eJ",
        ':let @t=expand("%:.")<CR>:SlimuxShellRun spring rspec <c-r>t<CR>'
      )
      -- map <localleader>J :let @t=expand("%:.")<CR>:SlimuxShellRun spring rspec <c-r>t<CR>
      -- map <localleader>u :let @t=expand("%:.")<CR>:SlimuxShellRun cucumber -p local <c-r>t<CR>
      -- map <localleader>U :let @t=expand("%:.")<CR>:SlimuxShellRun cucumber -p local <c-r>t<CR>
    end,
  },
  { "tpope/vim-fugitive" },
  { "tpope/vim-rails" },
  -- { "tpope/vim-endwise" },
  { "editorconfig/editorconfig-vim" },
  { "bogado/file-line" },

  -- reformat text
  { "AndrewRadev/splitjoin.vim" },
  { "godlygeek/tabular" },

  { "cuducos/yaml.nvim" },
}
opts = {
  dev = {
    path = "~/dev",
  },
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { "habamax" },
    -- colorscheme = function()
    --   require("tokyonight").load()
    -- end,
  },
  ui = {
    border = "single",
    icons = {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
}
vim.g.mapleader = " "
require("lazy").setup(plugins, opts)
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*" },
  command = "FormatWrite",
})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})