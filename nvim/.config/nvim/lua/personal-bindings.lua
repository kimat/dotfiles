-- saving is something that I do (too?) often
map("n", "<esc>", "<Cmd>update!<cr>")
-- map("n", "<esc>", "<Cmd>FormatWrite<cr>")

-- kill window faster
map("n", "<C-c>", ":q<cr>")

-- leaders
vim.g.mapleader = ","
-- vim.g.maplocalleader = 'e'
map("n", "M", "m")

-- yanky
map("n", "<leader>p", "<Cmd>YankyRingHistory<CR>")

-- dealing with splits should be seamless but the overridden keymaps should be accessible somehow
map("n", "<leader>h", "H")
map("n", "<leader>j", "J")
map("n", "<leader>k", "K")
map("n", "<leader>l", "L")
map("n", "-", "<C-W>s<C-W>j")
map("n", "|", "<C-W>v<C-W>l")
map("n", "H", "<C-W>h")
map("n", "J", "<C-W>j")
map("n", "K", "<C-W>k")
map("n", "L", "<C-W>l")

-- I don't use z.
map("n", "zz", "ZZ")

-- I need a way to copy the current filepath
map("n", "<leader>c", ':let @+=expand("%:.").":".line(".")<CR>')
map("n", "<leader>C", ':let @+=expand("%:.")<CR>')

-- I need a faster way to insert a break point
map("n", ",b", "obinding.pry<ESC>^")

-- gx should open any link under the cursor
map(
  "n",
  "gx",
  [[:silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<CR>]],
  opts
)

-- debug
-- :lua put(an_array)
function _G.put(...)
  local objects = {}
  for i = 1, select("#", ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, "\n"))
  return ...
end

function _G.url_on_line()
  local current_buffer = vim.api.nvim_get_current_buf()
  local current_line_number = vim.fn.line "."
  local current_line = vim.api.nvim_buf_get_lines(
    current_buffer,
    current_line_number - 1,
    current_line_number,
    1
  )[1]
  return current_line:match "(http%S+)%)+"
  -- os.execute('$BROWSER ' .. url)
end

-- prefer vim.fn.system since # & % need to be prefixed by \
function _G.safe_cmd(command)
  vim.cmd(command:gsub("([#%%])", "\\%1"))
end

function _G.browse(url)
  vim.fn.system("$BROWSER " .. url)
end

map("n", "gx", "<Cmd>lua browse(url_on_line())<CR>")
map("v", "gx", ':luado os.execute("$BROWSER " .. line:match("http%S+"))<CR>')

-- search
map("n", "gr", ":grep <C-R><C-W>")
map("n", "<C-n>", ":cn<CR>")
vim.opt.grepprg = "rg --no-heading --vimgrep --hidden -g '!.git'"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.path = "$PWD/**"

-- map("n", "es", "<Cmd>e ~/my/tips/stack.md<CR>")

map("n", "el", "<Cmd>e ~/my/tips/favorite/links<CR>")
map("n", "eg", "<Cmd>silent !firefox-send Home<CR>")
map("n", "ed", "<Cmd>silent !firefox-send ctrl+w<CR>")
map("n", "eD", "<Cmd>silent !firefox-send ctrl+shift+t<CR>")
map("n", "es", "<Cmd>silent !firefox-send ctrl+Page_Up<CR>")
map("n", "ef", "<Cmd>silent !firefox-send ctrl+Page_Down<CR>")
map("n", "er", "<Cmd>silent !firefox-send ctrl+r<CR>")
map("n", "ey", "<Cmd>silent !firefox-copy-current-page-as-markdown<CR>")
map(
  "n",
  "eu",
  "<Cmd>silent !firefox-copy-current-page-as-markdown && firefox-send ctrl+w<CR>"
)

-- :help changelist
map("n", "g.", "g;")

-- https://www.lua.org/pil/3.4.html

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "M", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-m>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<space>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gR", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<space>f", function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- Trouble nvim
map("n", "<leader>x", "<cmd>Trouble diagnostics toggle<cr>")