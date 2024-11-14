return {
  {
    "esamattis/slimux", -- ⚠️ viml based plugin
    config = function()
      Map("v", "ee", ":SlimuxREPLSendSelection<CR>")
      Map("n", "ee", "<Cmd>SlimuxREPLSendLine<CR>")
      Map("n", "ep", "vip:SlimuxREPLSendSelection<CR>")
      Map("n", "ex", "<Cmd>SlimuxGlobalConfigure<CR>")
      Map(
        "n",
        "ej",
        ':let @t=expand("%:.").":".line(".")<CR>:SlimuxShellRun spring rspec <c-r>t<CR>'
      )
      Map(
        "n",
        "eJ",
        ':let @t=expand("%:.")<CR>:SlimuxShellRun spring rspec <c-r>t<CR>'
      )
      -- map <localleader>J :let @t=expand("%:.")<CR>:SlimuxShellRun spring rspec <c-r>t<CR>
      -- map <localleader>u :let @t=expand("%:.")<CR>:SlimuxShellRun cucumber -p local <c-r>t<CR>
      -- map <localleader>U :let @t=expand("%:.")<CR>:SlimuxShellRun cucumber -p local <c-r>t<CR>
    end,
  },
  {
    "mrjones2014/smart-splits.nvim",
    config = function()
      vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
      vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
      vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
      vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
      vim.keymap.set("n", "<A-h>", require("smart-splits").move_cursor_left)
      vim.keymap.set("n", "<A-j>", require("smart-splits").move_cursor_down)
      vim.keymap.set("n", "<A-k>", require("smart-splits").move_cursor_up)
      vim.keymap.set("n", "<A-l>", require("smart-splits").move_cursor_right)
    end,
  },
}
