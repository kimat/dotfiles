vim.pack.add { "https://github.com/stevearc/conform.nvim" }

-- to disable auto formatting: `:ConformDisable`
require("conform").setup {
  formatters = {
    jq = { args = { "--indent", "2" } },
    shfmt = { args = { "-i", "2" } },
    just = {
      args = { "--fmt", "--unstable", "-f", "$FILENAME" },
    },
  },
  -- https://github.com/stevearc/conform.nvim#formatters
  formatters_by_ft = {
    sh = { "shfmt" },
    go = { "gofmt" },
    eruby = { "erb_format" },
    ruby = { "rubocop" },
    lua = { "stylua" },
    terraform = { "terraform_fmt" },
    markdown = { "prettier" },
    css = { "prettier" },
    python = { "ruff_format" },
    nix = { "nixfmt" },
    javascript = { "prettier" },
    json = { "jq" },
    yaml = { "prettier" },
    xml = { "xmllint" },
    just = { "just" },
  },
  format_on_save = function(bufnr)
    if string.match(vim.fn.getcwd(), "/home.*/dev/nix/.*") then
      return
    end
    return { timeout_ms = 500, lsp_fallback = true }
  end,
}
