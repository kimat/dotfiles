local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  print("packer.nvim isn't installed")
  print(
      "visit https://github.com/wbthomason/packer.nvim#quickstart for clone instructions")
  return
end

-- vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])
vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')

vim.cmd [[packadd packer.nvim]]
require('packer').startup({
  function()
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function()
        -- set foldmethod=expr
        -- set foldexpr=nvim_treesitter#foldexpr()
        -- require'nvim-treesitter.install'.compilers = {'gcc'}
        vim.wo.foldmethod = 'expr'
        vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
        require'nvim-treesitter.configs'.setup {
          textobjects = {enable = true},
          rainbow = {enable = true},
          indent = {enable = true, disable = {}},
          folding = {enable = true},
          highlight = {
            ensure_installed = "maintained",
            enable = true,
            additional_vim_regex_highlighting = false
          },
          ensure_installed = {
            "dockerfile", "html", "bash", "javascript", "json", "lua", "nix",
            "ruby", "vim", "yaml", "markdown"
          }
        }
      end
    }
    if pcall(require, "nvim-treesitter.parsers") then
      -- install with ':TSInstallSync markdown'
      require"nvim-treesitter.parsers".get_parser_configs().markdown = {
        install_info = {
          url = "https://github.com/ikatyang/tree-sitter-markdown",
          files = {"src/parser.c", "src/scanner.cc"}
        }
      }
    end

    -- Packer can manage itself as an optional plugin
    use {"wbthomason/packer.nvim", opt = true}

    use {
      'folke/tokyonight.nvim',
      config = function()
        vim.g.tokyonight_italic_functions = false
        vim.g.tokyonight_style = "day"
        vim.g.tokyonight_transparent = true
        vim.cmd 'colorscheme tokyonight'
      end
    }

    use {
      'Th3Whit3Wolf/space-nvim',
      config = function()
        vim.o.background = "light"
        -- vim.cmd 'colorscheme space-nvim'
        vim.cmd 'hi CursorLine cterm=NONE ctermbg=lightblue guibg=lightblue'
      end
    }

    use {
      "mcchrish/zenbones.nvim",
      config = function()
        -- vim.cmd 'colorscheme zenbones'
      end
    }

    use {
      'w0rp/ale',
      config = function()
        vim.g.ale_fix_on_save = 1
        vim.g.ale_lua_lua_format_options = "--no-use-tab --indent-width=2"
        vim.g.ruby_rubocop_options = "--safe"
        vim.g.ale_sign_error = '✖'
        vim.g.ale_sign_warning = '⚠'
        vim.g.ale_sign_style_error = 'q'
        vim.g.ale_sign_style_warning = 'S'

        vim.g.ale_linters = {
          ['ruby'] = {'rubocop'},
          ['javascript'] = {'eslint'}
        }

        vim.g.ale_fixers = {
          ['nix'] = {'nixfmt'},
          ['lua'] = {'lua-format'},
          ['javascript'] = {'prettier'},
          ['markdown'] = {'prettier'},
          ['ruby'] = {'rubocop'}
        }
      end
    }

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

    --     use {
    --       'mhartington/formatter.nvim',
    --       config = function()
    --         require('formatter').setup({
    --           filetype = {
    --             ruby = {
    --               function()
    --                 return {
    --                   exe = "rubocop", -- might prepend `bundle exec `
    --                   args = {
    --                     '--auto-correct', '--stdin', '%:p', '2>/dev/null', '|',
    --                     "awk 'f; /^====================$/{f=1}'"
    --                   },
    --                   stdin = true
    --                 }
    --               end
    --             },
    --             lua = {
    --               function()
    --                 return {
    --                   exe = "lua-format", -- might prepend `bundle exec `
    --                   args = {'-i', '--no-use-tab', '--indent-width=2'},
    --                   stdin = true
    --                 }
    --               end
    --             }

    --           }
    --         })
    --         vim.cmd([[
    -- augroup FormatAutogroup
    --   autocmd!
    --   autocmd BufWritePost *.rb,*.lua FormatWrite
    -- augroup END
    -- ]], true)
    --       end
    --     }

    use {
      'b3nj5m1n/kommentary',
      config = function()
        require('kommentary.config').configure_language("default", {
          prefer_single_line_comments = true
        })
      end
    }

    use {
      'windwp/nvim-autopairs',
      config = function() require('nvim-autopairs').setup() end
    }

    -- use 'nvim-treesitter/nvim-treesitter' -- syntax highlight using treesitter
    use {
      'norcalli/nvim-colorizer.lua',
      config = function()
        require'colorizer'.setup({'css', 'javascript', 'html'})
      end
    }

    use {
      'ibhagwan/fzf-lua',
      requires = {'vijaymarupudi/nvim-fzf'},
      -- 'kyazdani42/nvim-web-devicons' } -- optional for icons
      -- use {'vijaymarupudi/nvim-fzf-commands'}
      config = function()
        map('n', 'mo', '<Cmd>FzfLua files<CR>')
        map('n', 'ml', '<Cmd>FzfLua buffers<CR>')
        map('n', 'mt',
            "<Cmd>lua require('fzf-lua').files({ cwd = '~/my/tips' })<CR>")
        map('n', 'mc',
            "<Cmd>lua require('fzf-lua').files({ cwd = '~/my/dotfiles' })<CR>")
        map('n', 'mm', "<Cmd>lua require('fzf-lua').files({ cwd = '~/my' })<CR>")

        require('fzf-lua').setup {
          default_previewer = "cat",
          preview_layout = "vertical",
          -- TODO bat theme not working because bright?
          -- bat = {
          --   cmd    = "bat",
          --   args   = "--style=numbers,changes --color always --theme ansi",
          --   theme  = 'ansi', -- bat preview theme (bat --list-themes)
          --   config = nil,            -- nil uses $BAT_CONFIG_PATH
          -- },
          fzf_binds = { -- fzf '--bind=' options
            'f2:toggle-preview', 'f3:toggle-preview-wrap',
            'shift-down:preview-page-down', 'shift-up:preview-page-up',
            'ctrl-a:beginning-of-line', 'ctrl-d:abort',
            'ctrl-u:unix-line-discard', 'ctrl-f:page-down', 'ctrl-b:page-up',
            'ctrl-a:toggle-all', 'ctrl-l:clear-screen'
          }
        }
      end
    }

    -- a

    -- viml based plugins
    use {
      'previm/previm',
      config = function() vim.g.previm_open_cmd = 'firefox' end
    }
    use {
      'esamattis/slimux',
      config = function()
        map('v', 'ee', ':SlimuxREPLSendSelection<CR>')
        map('n', 'ee', '<Cmd>SlimuxREPLSendLine<CR>')
        map('n', 'ep', 'vip:SlimuxREPLSendSelection<CR>')
        map('n', 'ex', '<Cmd>SlimuxGlobalConfigure<CR>')
        map('n', 'ej',
            ':let @t=expand("%:.").":".line(".")<CR>:SlimuxShellRun spring rspec <c-r>t<CR>')
        map('n', 'eJ',
            ':let @t=expand("%:.")<CR>:SlimuxShellRun spring rspec <c-r>t<CR>')
        -- map <localleader>J :let @t=expand("%:.")<CR>:SlimuxShellRun spring rspec <c-r>t<CR>
        -- map <localleader>u :let @t=expand("%:.")<CR>:SlimuxShellRun cucumber -p local <c-r>t<CR>
        -- map <localleader>U :let @t=expand("%:.")<CR>:SlimuxShellRun cucumber -p local <c-r>t<CR>
      end
    }
    use {'tpope/vim-fugitive'}
    use {'tpope/vim-rails'}
    use {'tpope/vim-endwise'}
    use {'editorconfig/editorconfig-vim'}
    use {'bogado/file-line'}
    -- reformat text
    use {'AndrewRadev/splitjoin.vim'}
    use {'godlygeek/tabular'}

    config = {
      display = {
        open_fn = function()
          return require('packer.util').float({border = 'single'})
        end
      }
    }
  end
})
