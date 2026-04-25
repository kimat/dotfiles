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

vim.pack.add { "https://github.com/mhartington/formatter.nvim" }

-- to disable auto formatting: `:set ei=BufWritePost`
require("formatter").setup {
  -- https://github.com/mhartington/formatter.nvim/tree/master/lua/formatter/filetypes
  filetype = {
    sh = require("formatter.filetypes.sh").shfmt,
    go = require("formatter.filetypes.go").gofmt,
    eruby = require("formatter.filetypes.eruby").erbformatter,
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
