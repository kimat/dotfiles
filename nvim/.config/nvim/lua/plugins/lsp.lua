vim.pack.add {
  "https://github.com/neovim/nvim-lspconfig",
}

-- vim.lsp.set_log_level "info"

vim.lsp.config("gopls", {})

vim.lsp.config("typos_lsp", {
  filetypes = { "*" },
})

vim.lsp.config("lua_ls", {
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

vim.lsp.config("nixd", {})

vim.lsp.config("bashls", {})

vim.lsp.config("yamlls", {})

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

vim.lsp.enable {
  "gopls",
  "typos_lsp",
  "lua_ls",
  "nixd",
  "bashls",
  "yamlls",
  "ruby_lsp",
}

-- { -- show as you type, lsp signature_help
--   "ray-x/lsp_signature.nvim",
--   -- event = "VeryLazy",
--   opts = {},
--   config = function(_, opts)
--     require("lsp_signature").setup(opts)
--   end,
-- },
