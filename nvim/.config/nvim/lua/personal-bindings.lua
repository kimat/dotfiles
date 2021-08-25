-- saving is something that I do (too?) often
map('n', '<esc>', '<Cmd>w<cr>')


-- leaders
vim.g.mapleader = ','
-- vim.g.maplocalleader = 'e'
map('n', 'M', 'm')

-- dealing with splits should be seemless but the overwridden keymaps should be accessible somehow
map('n', '<leader>h', 'H')
map('n', '<leader>j', 'J')
map('n', '<leader>k', 'K')
map('n', '<leader>l', 'L')
map('n', '-', '<C-W>s')
map('n', '|', '<C-W>v')
map('n', 'H', '<C-W>h')
map('n', 'J', '<C-W>j')
map('n', 'K', '<C-W>k')
map('n', 'L', '<C-W>l')

-- I don't use z.
map('n','zz','ZZ')

-- gx should open any link under the cursor
-- map('n', 'gx', ':silent !firefox --new-tab <C-R>=escape("<C-R><C-F>", "#?&;\|%")<CR><CR>')

-- debug
function _G.put(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, '\n'))
  return ...
end

-- function _G.open_url_undercursor_in_firefox(...)
--   return os.execute("firefox " .. vim.fn.expand("<cWORD>"))
-- end

map('n', 'gx','<Cmd>lua os.execute("$BROWSER " .. vim.fn.expand("<cWORD>"))<CR>')

-- search
map('n', 'gr', ':grep <C-R><C-W>')
map('n', '<C-n>', ':cn<CR>')
vim.opt.grepprg="rg --no-heading --vimgrep --hidden -g '!.git'"
vim.opt.grepformat="%f:%l:%c:%m"
vim.opt.path="$PWD/**"

map('n', 'es', '<Cmd>e ~/my/tips/stack.md<CR>' )

map('n','ey', '<Cmd>silent !firefox-copy-current-page-as-markdown<CR>')
map('n','eY', '<Cmd>silent !firefox-copy-current-page-as-markdown && firefox-send ctrl+w<CR>')

-- https://www.lua.org/pil/3.4.html
