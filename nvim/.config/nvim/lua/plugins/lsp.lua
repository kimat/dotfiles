return {
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
  -- { "VonHeikemen/lsp-zero.nvim", branch = "v4.x" },
}
