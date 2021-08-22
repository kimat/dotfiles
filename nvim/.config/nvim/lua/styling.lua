-- Only show Cursor on active buffer
vim.cmd([[
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
]])

