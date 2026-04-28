-- helper function to assign keymaps
function Map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

require "better-defaults"
require "personal-bindings"
require "styling"
require "folding"

require "plugins.code"
require "plugins.colorscheme"
require "plugins.comments"
require "plugins.completion"
require "plugins.folds"
require "plugins.formatting"
require "plugins.fzf"
require "plugins.linting"
require "plugins.lsp"
require "plugins.markdown"
require "plugins.tmux"
require "plugins.treesitter"
require "plugins.zen"
