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

local plugins = {
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
      vim.api.nvim_set_hl(0, "Cursor", { bg = "#65B8C1" })
      vim.api.nvim_set_hl(0, "Cursor2", { bg = "#65B8C1" })
      vim.api.nvim_set_hl(0, "MarkdownHBg", { bg = "#DEDEDE" })
      vim.api.nvim_set_hl(0, "MarkdownCodeBlock", { bg = "#fbfbfb" })
      -- Set guicursor
      vim.o.guicursor =
        "n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor50"
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
  -- { "L3MON4D3/LuaSnip" },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v4.x",
        lazy = true,
        config = false,
      },
    },
    opts = {
      autoformat = false,
    },
    config = function()
      -- vim.lsp.set_log_level "info"
      local lspconfig = require "lspconfig"
      -- set some defaults for each following lspconfig.SERVER_NAME.setup call
      require("lsp-zero").extend_lspconfig {
        -- sign_text = true,
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      }

      -- lspconfig.vale_ls.setup {
      --   init_options = {
      --     installVale = false,
      --     syncOnStartup = true,
      --   },
      -- }

      lspconfig.typos_lsp.setup {
        filetypes = { "*" },
      }

      lspconfig.lua_ls.setup {
        on_init = function(client)
          local path = client.workspace_folders[1].name
          if
            vim.loop.fs_stat(path .. "/.luarc.json")
            or vim.loop.fs_stat(path .. "/.luarc.jsonc")
          then
            return
          end
          client.config.settings.Lua =
            vim.tbl_deep_extend("force", client.config.settings.Lua, {
              runtime = { version = "LuaJIT" },
              -- Make the server aware of Neovim runtime files
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME,
                  "${3rd}/luv/library",
                },
              },
            })
        end,
        settings = {
          Lua = {},
        },
      }

      lspconfig.bashls.setup {}

      lspconfig.yamlls.setup {}

      lspconfig.ruby_lsp.setup {
        filetypes = { "ruby", "eruby" },
        init_options = { formatter = { nil } },
        -- cmd = { "docker", "compose", "exec", "-T", "app", "ruby-lsp" },
        single_file_support = true,
        -- init_options = {
        --   enabledFeatures = {
        --     "signatureHelps",
        --     -- "documentHighlights",
        --     -- "documentSymbols",
        --     -- "foldingRanges",
        --     -- "selectionRanges",
        --     -- "formatting",
        --     -- "codeActions",
        --   },
        -- },
        settings = {},
      }

      -- lspconfig.typos_lsp.setup {
      --   filetypes = { "*" },
      --   -- Logging level of the language server. Logs appear in :LspLog. Defaults to error.
      --   cmd_env = { RUST_LOG = "error" },
      --   cmd = { "typos-lsp" },
      --   init_options = {
      --     -- Custom config. Used together with a config file found in the workspace or its parents,
      --     -- taking precedence for settings declared in both.
      --     -- Equivalent to the typos `--config` cli argument.
      --     -- config = '~/code/typos-lsp/crates/typos-lsp/tests/typos.toml',
      --     -- How typos are rendered in the editor, can be one of an Error, Warning, Info or Hint.
      --     -- Defaults to error.
      --     diagnosticSeverity = "Error",
      --   },
      -- }
    end,
  },
  -- { -- show as you type, lsp signature_help
  --   "ray-x/lsp_signature.nvim",
  --   -- event = "VeryLazy",
  --   opts = {},
  --   config = function(_, opts)
  --     require("lsp_signature").setup(opts)
  --   end,
  -- },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "chrisgrieser/cmp_yanky",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-path",
      -- "hrsh7th/cmp-cmdline",
    },
    config = function()
      local cmp = require "cmp"
      cmp.setup {
        mapping = cmp.mapping.preset.insert {
          ["<CR>"] = cmp.mapping.confirm { select = false }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        },
        formatting = {
          format = function(entry, vim_item)
            vim_item.menu = entry.source.name
            return vim_item
          end,
        },
        -- snippet = {
        --   expand = function(args)
        --     vim.snippet.expand(args.body)
        --   end,
        -- },
        sources = {
          { name = "cmp_yanky" },
          { name = "buffer" },
          { name = "nvim_lsp_signature_help" },
          { name = "path" },
          { name = "nvim_lsp" },
          -- { name = "cmdline" },
        },
        -- formatting = {
        --   format = function(entry, vim_item)
        --     local kind = vim_item.kind
        --     vim_item.kind = (icons[kind] or "?") .. " " .. kind
        --     local source = entry.source.name
        --     vim_item.menu = "->" .. icons[source]
        --     local item = entry:get_completion_item()
        --     -- log.debug(item)
        --     if item.detail then
        --       vim_item.menu = item.detail
        --     end
        --     return vim_item
        --   end,
        -- },
      }
    end,
  },
  -- { "VonHeikemen/lsp-zero.nvim", branch = "v4.x" },

  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  -- { "saadparwaiz1/cmp_luasnip" },

  {
    "mfussenegger/nvim-lint",
    config = function()
      -- https://github.com/mfussenegger/nvim-lint#available-linters
      require("lint").linters_by_ft = {
        javascript = { "eslint" },
        ruby = { "standardrb" },
      }
    end,
  },
  -- to disable auto formatting: `:set ei=BufWritePost`
  {
    "mhartington/formatter.nvim",
    config = function()
      require("formatter").setup {
        -- https://github.com/mhartington/formatter.nvim/tree/master/lua/formatter/filetypes
        filetype = {
          sh = require("formatter.filetypes.sh").shfmt,
          eruby = require("formatter.filetypes.eruby").erbformatter,
          -- ruby = require("formatter.filetypes.ruby").standardrb,
          ruby = require("formatter.filetypes.ruby").rubocop,
          lua = require("formatter.filetypes.lua").stylua,
          terraform = {
            function()
              return { exe = "terraform", stdin = true, args = { "fmt", "-" } }
            end,
          },
          markdown = require("formatter.filetypes.markdown").prettier,
          python = require("formatter.filetypes.python").ruff,
          nix = require("formatter.filetypes.nix").nixfmt,
          javascript = require("formatter.filetypes.javascript").prettier,
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

  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  -- {
  --   "norcalli/nvim-colorizer.lua",
  --   config = function()
  --     require("colorizer").setup { "css", "javascript", "html" }
  --   end,
  -- },
  {
    "ibhagwan/fzf-lua",
    lazy = false,
    dependencies = { "vijaymarupudi/nvim-fzf", "nvim-tree/nvim-web-devicons" },
    -- 'kyazdani42/nvim-web-devicons' } -- optional for icons
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

  {
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
  {
    "gbprod/yanky.nvim",
    opts = {},
  },

  {
    "esamattis/slimux", -- viml based plugin
    config = function()
      Map("v", "ee", ":SlimuxREPLSendSelection<CR>")
      Map("n", "ee", "<Cmd>SlimuxREPLSendLine<CR>")
      Map("n", "ep", "vip:SlimuxREPLSendSelection<CR>")
      Map("n", "ex", "<Cmd>SlimuxGlobalConfigure<CR>")
      Map(
        "n",
        "ej",
        ':let @t=expand("%:.").":".line(".")<CR>:SlimuxShellRun spring rspec <c-r>t<CR>'
      )
      Map(
        "n",
        "eJ",
        ':let @t=expand("%:.")<CR>:SlimuxShellRun spring rspec <c-r>t<CR>'
      )
      -- map <localleader>J :let @t=expand("%:.")<CR>:SlimuxShellRun spring rspec <c-r>t<CR>
      -- map <localleader>u :let @t=expand("%:.")<CR>:SlimuxShellRun cucumber -p local <c-r>t<CR>
      -- map <localleader>U :let @t=expand("%:.")<CR>:SlimuxShellRun cucumber -p local <c-r>t<CR>
    end,
  },
  {
    "tpope/vim-fugitive", -- viml based plugin
  },
  {
    "tpope/vim-rails", -- viml based plugin
  },
  {
    "editorconfig/editorconfig-vim", -- viml based plugin
  },
  {
    "bogado/file-line", -- viml based plugin
  },

  -- reformat text
  { "AndrewRadev/splitjoin.vim" },
  { "godlygeek/tabular" },

  { "cuducos/yaml.nvim" },

  {
    "pocco81/true-zen.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    "mrjones2014/smart-splits.nvim",
    config = function()
      vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
      vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
      vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
      vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
      vim.keymap.set("n", "<A-h>", require("smart-splits").move_cursor_left)
      vim.keymap.set("n", "<A-j>", require("smart-splits").move_cursor_down)
      vim.keymap.set("n", "<A-k>", require("smart-splits").move_cursor_up)
      vim.keymap.set("n", "<A-l>", require("smart-splits").move_cursor_right)
    end,
  },
}
local opts = {
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
  callback = function()
    require("lint").try_lint()
  end,
})

vim.api.nvim_create_augroup("__formatter__", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = "__formatter__",
  callback = function()
    if string.match(vim.fn.getcwd(), "/home.*/dev/nix/.*") then
      return
    end
    vim.cmd "FormatWrite"
  end,
})

-- vim.treesitter.language.register("embedded_template", "html")
vim.cmd.autocmd "BufRead,BufNewFile *.ejs se filetype=html"

-- Make a function with three string parameters that loops ten times and prints each string each time
-- function PrintStringsTenTimes(str1, str2, str3)
--   for _ = 1, 10 do
--     print(str1 .. str2 .. str3)
--   end
-- end

function yanky()
  local f = require "fzf-lua"
  local contents = require("yanky.history").all()

  local function getContent(args)
    local r = string.match(args[1], "^%d+")
    return contents[tonumber(r)]
  end

  local entries = {}
  for k, v in ipairs(contents) do
    table.insert(
      entries,
      string.format("%-2s", f.utils.ansi_codes.yellow(tostring(k)))
        .. " "
        .. v.regcontents:gsub("\n", f.utils.ansi_codes.yellow "\\n")
    )
  end

  local opts = {
    fzf_opts = {
      ["--no-multi"] = "",
      ["--border"] = "none",
      ["--preview-window"] = "right",
      -- ["--preview-window"] = "down:65%",
      ["--preview"] = f.shell.action(function(args)
        return getContent(args).regcontents
      end, nil, false),
    },
    actions = {
      ["default"] = function(args)
        require("yanky.picker").actions.put "p"(getContent(args))
      end,
    },
  }
  f.fzf_exec(entries, opts)
end
