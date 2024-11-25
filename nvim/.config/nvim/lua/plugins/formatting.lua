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
return {
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
          css = require("formatter.filetypes.css").prettier,
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
}
