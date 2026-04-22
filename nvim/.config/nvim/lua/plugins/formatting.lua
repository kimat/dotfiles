return {
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup {
        -- Map of filetype to formatters
        formatters_by_ft = {
          lua = { "stylua" },
          -- go = { "gofmt" },
          nix = { "nixfmt" },
          ruby = { "rubocop" },
          just = { "just" },
          yaml = { "yamlfmt" },
        },
        -- Set this to change the default values when calling conform.format()
        -- This will also affect the default values for format_on_save/format_after_save
        -- default_format_opts = {
        --   lsp_format = "fallback",
        -- },
        -- If this is set, Conform will run the formatter on save.
        -- It will pass the table to conform.format().
        -- This can also be a function that returns the table.
        format_on_save = {
          -- lsp_format = "fallback",
          timeout_ms = 500,
        },
        -- Set the log level. Use `:ConformInfo` to see the location of the log file.
        log_level = vim.log.levels.ERROR,
        -- Conform will notify you when a formatter errors
        notify_on_error = true,
        -- Conform will notify you when no formatters are available for the buffer
        notify_no_formatters = true,
      }
    end,
  },
}
