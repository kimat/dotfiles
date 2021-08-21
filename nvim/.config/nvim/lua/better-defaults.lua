-- so I know on which line the cursor is
vim.opt.cursorline = true

-- searching should be case insensitive it contains a capital in it
vim.opt.ignorecase = true -- Ignore case
vim.opt.smartcase = true

-- searching should be visually sound
opt.ignorecase = true
opt.incsearch = true -- Shows the match while typing

-- so colorschemes look as they should
vim.opt.termguicolors = true

-- indentation
vim.opt.tabstop=2
vim.opt.shiftwidth=2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- anything saved to a register should also be saved to the system clipboard
vim.opt.clipboard = "unnamedplus"

-- sometimes selecting stuff with a mouse is ok?
vim.opt.mouse = "a"
