-- vim.opt == set ...
-- vim.g == let ...
-- unfold all
vim.opt.foldlevel = 99

-- so I know on which line the cursor is
vim.opt.cursorline = true

-- utf8 only
vim.opt.encoding = "utf-8"
vim.opt.fileencodings = "utf-8"

-- searching should be case insensitive it contains a capital in it
vim.opt.ignorecase = true -- Ignore case
vim.opt.smartcase = true
vim.o.hlsearch = false

-- searching should be visually sound
opt.ignorecase = true
opt.incsearch = true -- Shows the match while typing

-- so colorschemes look as they should
vim.opt.termguicolors = true

-- indentation
-- vim.opt.tabstop=2
-- vim.opt.shiftwidth=2
-- vim.opt.expandtab = true
-- vim.opt.smartindent = true

-- anything saved to a register should also be saved to the system clipboard
vim.opt.clipboard = "unnamedplus"

-- sometimes selecting stuff with a mouse is ok?
vim.opt.mouse = "a"

-- I don't use netrw
vim.api.nvim_set_var("netrw_dirhistmax", 0)

vim.o.autoread = true
vim.o.hidden = true

-- some options don't seem to be configurable from lua yet?
-- hidden chars should jump out
vim.api.nvim_command([[ set list listchars+=tab:┌┐,trail:█ ]])

-- cursor is black on black on termite + tmux
-- vim.go.t_SI = "<Esc>Ptmux;<Esc><Esc>]50;CursorShape=1x7<Esc>"
-- vim.go.t_EI = "<Esc>Ptmux;<Esc><Esc>]50;CursorShape=0x7<Esc>"

-- restoring a session with :source sessionfile (created with :mksession) restores non highlighted buffers
-- vim.opt.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,localoptions"
-- added localoptions to the defaults

-- don't wrap long lines
vim.cmd("set nowrap")

-- just save more often
vim.o.swapfile = false
vim.bo.swapfile = false
