-- saving is something that I do (too?) often
map('n', '<esc>', '<Cmd>update<cr>')

-- kill window faster
map('n', '<C-c>', ':q<cr>')

-- leaders
vim.g.mapleader = ','
-- vim.g.maplocalleader = 'e'
map('n', 'M', 'm')

-- dealing with splits should be seemless but the overwridden keymaps should be accessible somehow
map('n', '<leader>h', 'H')
map('n', '<leader>j', 'J')
map('n', '<leader>k', 'K')
map('n', '<leader>l', 'L')
map('n', '-', '<C-W>s<C-W>j')
map('n', '|', '<C-W>v<C-W>l')
map('n', 'H', '<C-W>h')
map('n', 'J', '<C-W>j')
map('n', 'K', '<C-W>k')
map('n', 'L', '<C-W>l')

-- I don't use z.
map('n', 'zz', 'ZZ')

-- I need a way to copy the current filepath
map('n', '<leader>c', ':let @+=expand("%:.").":".line(".")<CR>')
map('n', '<leader>C', ':let @+=expand("%:.")<CR>')

-- I need a faster way to insert a break point
map('n', ',b', 'obinding.pry<ESC>^')

-- gx should open any link under the cursor
-- map('n', 'gx', ':silent !firefox --new-tab <C-R>=escape("<C-R><C-F>", "#?&;\|%")<CR><CR>')

-- debug
-- :lua put(an_array)
function _G.put(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, '\n'))
  return ...
end

function _G.url_on_line()
  local current_buffer = vim.api.nvim_get_current_buf()
  local current_line_number = vim.fn.line(".")
  local current_line = vim.api.nvim_buf_get_lines(current_buffer,
                                                  current_line_number - 1,
                                                  current_line_number, 1)[1]
  return current_line:match("(http%S+)%)+")
  -- os.execute('$BROWSER ' .. url)
end

-- prefer vim.fn.system since # & % need to be prefixed by \
function _G.safe_cmd(command) vim.cmd(command:gsub("([#%%])", "\\%1")) end

function _G.browse(url) vim.fn.system("$BROWSER " .. url) end

map('n', 'gx', '<Cmd>lua browse(url_on_line())<CR>')
map('v', 'gx', ':luado os.execute("$BROWSER " .. line:match("http%S+"))<CR>')

-- search
map('n', 'gr', ':grep <C-R><C-W>')
map('n', '<C-n>', ':cn<CR>')
vim.opt.grepprg = "rg --no-heading --vimgrep --hidden -g '!.git'"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.path = "$PWD/**"

map('n', 'es', '<Cmd>e ~/my/tips/stack.md<CR>')

map('n', 'eg', '<Cmd>silent !firefox-send Home<CR>')
map('n', 'ed', '<Cmd>silent !firefox-send ctrl+w<CR>')
map('n', 'ey', '<Cmd>silent !firefox-copy-current-page-as-markdown<CR>')
map('n', 'eY',
    '<Cmd>silent !firefox-copy-current-page-as-markdown && firefox-send ctrl+w<CR>')

-- :help changelist
map('n', 'g.', 'g;')

-- https://www.lua.org/pil/3.4.html
