-- saving is something that I do (too?) often
Map("n", "<esc>", "<Cmd>:w<cr>")
-- Map("n", "<esc>", "<Cmd>FormatWrite<cr>")

-- kill window faster
Map("n", "<C-c>", ":q<cr>")

-- leaders
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"
-- vim.g.maplocalleader = 'e'
Map("n", "M", "m")

-- yanky
Map("n", "<leader>p", "<Cmd>lua yanky()<CR><CR>")

-- dealing with splits should be seamless but the overridden keymaps should be accessible somehow
Map("n", "<leader>h", "H")
Map("n", "<leader>j", "J")
Map("n", "<leader>k", "K")
Map("n", "<leader>l", "L")
Map("n", "-", "<C-W>s<C-W>j")
Map("n", "|", "<C-W>v<C-W>l")
Map("n", "H", "<C-W>h")
Map("n", "J", "<C-W>j")
Map("n", "K", "<C-W>k")
Map("n", "L", "<C-W>l")

-- I don't use z.
Map("n", "zz", "ZZ")

-- I need a way to copy the current filepath
Map("n", "<leader>c", ':let @+=expand("%:.").":".line(".")<CR>')
Map("n", "<leader>C", ':let @+=expand("%:.")<CR>')

-- I need a faster way to insert a break point
Map("n", ",b", "odebugger<ESC>^")

-- gx should open any link under the cursor
Map(
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

Map("n", "gx", "<Cmd>lua browse(url_on_line())<CR>")
Map("v", "gx", ':luado os.execute("$BROWSER " .. line:match("http%S+"))<CR>')

-- search
Map("n", "gr", ":grep <C-R><C-W>")
Map("n", "<C-n>", ":cn<CR>")
vim.opt.grepprg = "rg --no-heading --vimgrep --hidden -g '!.git' -L"
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.path = "$PWD/**"

-- Map("n", "es", "<Cmd>e ~/my/tips/stack.md<CR>")

Map("n", "el", "<Cmd>e ~/my/tips/favorite/links<CR>")
Map("n", "eg", "<Cmd>silent !firefox-send Home<CR>")
Map("n", "ed", "<Cmd>silent !firefox-send ctrl+w<CR>")
Map("n", "eD", "<Cmd>silent !firefox-send ctrl+shift+t<CR>")
-- Map("n", "es", "<Cmd>silent !firefox-send ctrl+Page_Up<CR>")
-- Map("n", "ef", "<Cmd>silent !firefox-send ctrl+Page_Down<CR>")
Map("n", "er", "<Cmd>silent !firefox-send ctrl+r<CR>")
Map("n", "ey", "<Cmd>silent !firefox-copy-current-page-as-markdown<CR>")
Map("n", "eu", "<Cmd>silent !firefox-copy-current-page-as-markdown --close<CR>")

-- :help changelist
Map("n", "g.", "g;")

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
Map("n", "<leader>x", "<cmd>Trouble diagnostics toggle<cr>")

-- General mapping for all files
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*", -- Applies to all file types
  callback = function()
    Map("n", ",b", "odebugger<ESC>^")
  end,
})

-- Specific mapping for ERB files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "eruby", -- FileType for ERB files
  callback = function()
    Map("n", ",b", "o<% debugger %><ESC>^")
  end,
})

-- Fzf
Map("n", "mo", "<Cmd>FzfLua files<CR>")
Map("n", "ml", "<Cmd>FzfLua buffers<CR>")
Map("n", "mt", "<Cmd>lua require('fzf-lua').files({ cwd = '~/my/tips' })<CR>")
Map(
  "n",
  "mc",
  "<Cmd>lua require('fzf-lua').files({ cmd = 'cat ~/.config/marks/configs' })<CR>"
)
Map("n", "mm", "<Cmd>lua require('fzf-lua').files({ cwd = '~/my' })<CR>")
Map("n", "ga", "<Cmd>FzfLua lsp_code_actions<CR>")

-- so :h<enter> or :h<space> shows a fzf menu to open a help page
vim.cmd.cnoreabbrev(
  "<expr> h",
  'getcmdtype() == ":" && getcmdline() == "h" ? "H<cr>" : "h"'
)

local function switch_project()
  require("fzf-lua").fzf_exec(
    "cat ~/my/private-dotfiles/zsh/.config/marks/folders",
    {
      actions = {
        ["default"] = function(selected)
          -- local dir = vim.fn.expand(selected[1])
          -- vim.cmd("cd " .. vim.fn.fnameescape(dir))
          vim.cmd("cd " .. vim.fn.fnameescape(selected[1]))
          require("fzf-lua").files()
        end,
      },
      fzf_opts = {
        ["--no-sort"] = "",
      },
    }
  )
end

-- Recommended: Add a keymapping in your Neovim config
-- For example, <leader>pd for "project directory"
vim.keymap.set("n", "mO", switch_project, {
  noremap = true,
  silent = true,
  desc = "Switch to Project Directory",
})
