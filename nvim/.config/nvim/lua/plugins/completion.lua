return {
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
}
