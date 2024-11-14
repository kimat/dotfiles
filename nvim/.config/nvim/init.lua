-- helper function to assign keymaps
function Map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

require "lazy/bootstrap"
require "better-defaults"
require "personal-bindings"
require "styling"
require "folding"
require "lazy/setup"
