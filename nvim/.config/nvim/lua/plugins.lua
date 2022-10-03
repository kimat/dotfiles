local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  print "packer.nvim isn't installed"
  print "visit https://github.com/wbthomason/packer.nvim#quickstart for clone instructions"
  return
end

vim.cmd [[packadd packer.nvim]]
require("packer").startup {
  function()
    use {
      "nvim-treesitter/nvim-treesitter",
      requires = {
        "JoosepAlviste/nvim-ts-context-commentstring",
        "RRethy/nvim-treesitter-endwise",
        "windwp/nvim-ts-autotag",
      },
      run = ":TSUpdate",
      config = function()
        -- set foldmethod=expr
        -- set foldexpr=nvim_treesitter#foldexpr()
        -- require'nvim-treesitter.install'.compilers = {'gcc'}
        vim.wo.foldmethod = "expr"
        vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
        require("nvim-treesitter.configs").setup {
          context_commentstring = { enable = true, enable_autocmd = false }, -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
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
            "vim",
            "yaml",
            "markdown",
          },
        }
      end,
    }

    use {
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
    }

    use {
      "hrsh7th/nvim-cmp",
      requires = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "L3MON4D3/LuaSnip" },
      },
      config = function()
        local has_words_before = function()
          local line, col = unpack(vim.api.nvim_win_get_cursor(0))
          return col ~= 0
            and vim.api
                .nvim_buf_get_lines(0, line - 1, line, true)[1]
                :sub(col, col)
                :match "%s"
              == nil
        end
        local luasnip = require "luasnip"
        local cmp = require "cmp"
        cmp.setup {
          snippet = {
            expand = function(args)
              require("luasnip").lsp_expand(args.body)
            end,
          },
          mapping = {
            ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              elseif has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end, { "i", "s" }),

            ["<S-Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { "i", "s" }),
          },
        }
      end,
    }
    use {
      "neovim/nvim-lspconfig",
      config = function()
        vim.opt.completeopt = "menuone,noselect"
        local capabilities = require("cmp_nvim_lsp").update_capabilities(
          vim.lsp.protocol.make_client_capabilities()
        )
        require("lspconfig").bashls.setup { capabilities = capabilities } -- https://github.com/bash-lsp/bash-language-server
        require("lspconfig").solargraph.setup { capabilities = capabilities } --
        require("lspconfig").terraformls.setup { capabilities = capabilities } -- https://github.com/hashicorp/terraform-ls
      end,
    }

    -- Packer can manage itself as an optional plugin
    use { "wbthomason/packer.nvim", opt = true }

    use {
      "folke/tokyonight.nvim",
      config = function()
        -- vim.g.tokyonight_italic_functions = false
        -- vim.g.tokyonight_style = "day"
        -- vim.g.tokyonight_transparent = true
        -- vim.cmd 'colorscheme tokyonight'
        -- vim.cmd 'hi CursorLine cterm=NONE ctermbg=lightblue guibg=lightblue'
      end,
    }

    use {
      "Th3Whit3Wolf/space-nvim",
      config = function()
        -- vim.o.background = "light"
        -- vim.cmd 'colorscheme space-nvim'
      end,
    }

    use { "rktjmp/lush.nvim" }
    use {
      "mcchrish/zenbones.nvim",
      config = function()
        vim.cmd "colorscheme zenbones"
        vim.o.background = "light"
        -- requires = "rktjmp/lush.nvim"
      end,
    }

    use { "mfussenegger/nvim-lint" }

    use {
      "mhartington/formatter.nvim",
      config = function()
        local util = require "formatter.util"
        require("formatter").setup {
          logging = true,
          filetype = {
            ruby = {
              function()
                return {
                  exe = "rubocop",
                  args = {
                    "--fix-layout",
                    "--stdin",
                    util.escape_path(util.get_current_buffer_file_name()),
                    "--format",
                    "files",
                  },
                  stdin = true,
                  transform = function(text)
                    table.remove(text, 1)
                    table.remove(text, 1)
                    return text
                  end,
                }
              end,
            },
            lua = {
              function()
                return {
                  exe = "stylua",
                  args = {
                    "--search-parent-directories",
                    "--stdin-filepath",
                    util.escape_path(util.get_current_buffer_file_path()),
                    "--",
                    "-",
                  },
                  stdin = true,
                  -- cf. stylua.toml for extra config
                }
              end,
            },
            terraform = {
              function()
                return { exe = "terraform", args = { "fmt", "-" }, stdin = true }
              end,
            },
            markdown = require("formatter.filetypes.markdown").prettier,
            nix = {
              function()
                return { exe = "nixfmt", stdin = true }
              end,
            },
          },
        }
      end,
    }

    -- use {
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
    -- }

    -- use {
    --   'plasticboy/vim-markdown',
    --   config = function()
    --     vim.g.vim_markdown_no_default_key_mappings = 1
    --     vim.g.vim_markdown_new_list_item_indent = 0
    --     vim.g.vim_markdown_no_extensions_in_markdown = 1
    --     vim.g.vim_markdown_folding_style_pythonic = 1
    --     vim.g.vim_markdown_override_foldtext = 0
    --     vim.g.vim_markdown_folding_level = 1
    --   end
    -- }

    use {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup {
          pre_hook = require(
            "ts_context_commentstring.integrations.comment_nvim"
          ).create_pre_hook(),
        }
      end,
    }

    use {
      "windwp/nvim-autopairs",
      config = function()
        require("nvim-autopairs").setup()
      end,
    }

    -- use 'nvim-treesitter/nvim-treesitter' -- syntax highlight using treesitter
    use {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup { "css", "javascript", "html" }
      end,
    }

    use {
      "ibhagwan/fzf-lua",
      requires = { "vijaymarupudi/nvim-fzf" },
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
        map(
          "n",
          "mm",
          "<Cmd>lua require('fzf-lua').files({ cwd = '~/my' })<CR>"
        )

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
    }

    -- a

    -- viml based plugins
    use {
      "previm/previm",
      config = function()
        vim.g.previm_open_cmd = "firefox"
      end,
    }
    use {
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
    }
    use { "tpope/vim-fugitive" }
    use { "tpope/vim-rails" }
    -- use { "tpope/vim-endwise" }
    use { "editorconfig/editorconfig-vim" }
    use { "bogado/file-line" }
    -- reformat text
    use { "AndrewRadev/splitjoin.vim" }
    use { "godlygeek/tabular" }

    config = {
      display = {
        open_fn = function()
          return require("packer.util").float { border = "single" }
        end,
      },
    }
  end,
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.lua" },
  command = "source <afile> | PackerCompile",
})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*" },
  command = "FormatWrite",
})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
