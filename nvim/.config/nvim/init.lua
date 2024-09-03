-- helper function to assign keymaps
function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--[[ vim.opt.setpath = ""
vim.opt.suffixesadd = ".lua" ]]
require "better-defaults"
require "personal-bindings"
require "plugins"
require "styling"
require "folding"
