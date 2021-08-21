-- backslash is awful as a leader on non qwerty layouts
-- vim.g.mapleader = "<space>"
-- vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
-- map('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ','
vim.g.maplocalleader = 'e'

map('n', 'M', 'm')

-- map('n', '<SPACE>', '<Leader>')
map('n', 'mo', ':FzfLua files<CR>')
map('n', 'mt', ":lua require('fzf-lua').files({ cwd = '~/my/tips' })<CR>")
map('n', 'mO', ':Telescope find_files<CR>')

-- map('n', '<leader>t', ':lua require("telescope.builtin").find_files({search_dirs = {"~/my/tips"}, hidden = true})<CR>')
