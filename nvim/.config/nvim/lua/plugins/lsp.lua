return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = {
      autoformat = false,
    },
    config = function()
      local lspconfig = vim.lsp.config

      -- Replace lsp-zero's extend_lspconfig by modifying the default config
      -- This applies the cmp capabilities to every server you setup below
      -- local lspconfig_defaults = lspconfig.util.default_config
      -- lspconfig_defaults.capabilities = vim.tbl_deep_extend(
      --   "force",
      --   lspconfig_defaults.capabilities,
      --   require("cmp_nvim_lsp").default_capabilities()
      -- )-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- An example for configuring `clangd` LSP to use nvim-cmp as a completion engine
      vim.lsp.config("clangd", {
        capabilities = capabilities,
      })

      vim.lsp.config("gopls", {})
      vim.lsp.config("typos_lsp", {
        filetypes = { "*" },
      })
      vim.lsp.config("lua_ls", {
        on_init = function(client)
          -- Added a safe fallback in case workspace_folders is nil
          local path = (
            client.workspace_folders and client.workspace_folders[1].name
          ) or ""

          -- Modernized: vim.loop is deprecated in favor of vim.uv in Neovim 0.10+
          if
            vim.uv.vim.uv.fs_stat(path .. "/.luarc.json")
            or vim.uv.fs_stat(path .. "/.luarc.jsonc")
          then
            return
          end

          client.config.settings.Lua =
            vim.tbl_deep_extend("force", client.config.settings.Lua, {
              runtime = { version = "LuaJIT" },
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
      })
      --
      vim.lsp.config("nixd", {})
      vim.lsp.config("bashls", {})
      vim.lsp.config.yamlls = {
        on_attach = attached,
        capabilities = capabilities,
        settings = {
          yaml = {
            format = { enable = true },
            schemaStore = {
              enable = true,
            },
            schemas = {
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
              ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
              ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*gitlab-ci*.{yml,yaml}",
              ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
            },
          },
        },
      }
      vim.lsp.enable "yamlls"
      vim.lsp.config("ruby_lsp", {
        filetypes = { "ruby", "eruby" },
        single_file_support = true,
        settings = {
          diagnostics = {
            enabled = true,
          },
          format = {
            enable = false,
          },
        },
      })
    end,
  },
}
