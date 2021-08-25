local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  print("packer.nvim isn't installed")
  print("visit https://github.com/wbthomason/packer.nvim#quickstart for clone instructions")
  return
end

-- vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])
vim.cmd('autocmd BufWritePost plugins.lua PackerCompile')

vim.cmd [[packadd packer.nvim]]
require('packer').startup({function()
  -- Packer can manage itself as an optional plugin
  use {"wbthomason/packer.nvim", opt = true}

  use {'folke/tokyonight.nvim', config = function()
    vim.g.tokyonight_italic_functions = false
    vim.g.tokyonight_style = "day"
    vim.cmd 'colorscheme tokyonight'
  end}


  use {'b3nj5m1n/kommentary',
  config = function()
    require('kommentary.config').configure_language("default", {
      prefer_single_line_comments = true,
    })
  end
  }

  use {'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup() end
  }

  -- use 'nvim-treesitter/nvim-treesitter' -- syntax highlight using treesitter
  use { 'norcalli/nvim-colorizer.lua', config = function()
    require'colorizer'.setup({ 'css'; 'javascript'; 'html'; })
  end }

  use { 'ibhagwan/fzf-lua',
    requires = { 'vijaymarupudi/nvim-fzf'},
    -- 'kyazdani42/nvim-web-devicons' } -- optional for icons
    -- use {'vijaymarupudi/nvim-fzf-commands'}
    config = function()
      map('n', 'mo', '<Cmd>FzfLua files<CR>')
      map('n', 'ml', '<Cmd>FzfLua buffers<CR>')
      map('n', 'mt', "<Cmd>lua require('fzf-lua').files({ cwd = '~/my/tips' })<CR>")
      map('n', 'mc', "<Cmd>lua require('fzf-lua').files({ cwd = '~/my/dotfiles' })<CR>")
      map('n', 'mm', "<Cmd>lua require('fzf-lua').files({ cwd = '~/my' })<CR>")

      require('fzf-lua').setup {
        default_previewer   = "cat",
        preview_layout = "vertical",
        -- TODO bat theme not working because bright?
        -- bat = {
        --   cmd    = "bat",
        --   args   = "--style=numbers,changes --color always --theme ansi",
        --   theme  = 'ansi', -- bat preview theme (bat --list-themes)
        --   config = nil,            -- nil uses $BAT_CONFIG_PATH
        -- },
        fzf_binds = { -- fzf '--bind=' options
        'f2:toggle-preview',
        'f3:toggle-preview-wrap',
        'shift-down:preview-page-down',
        'shift-up:preview-page-up',
        'ctrl-a:beginning-of-line',
        'ctrl-d:abort',
        'ctrl-u:unix-line-discard',
        'ctrl-f:page-down',
        'ctrl-b:page-up',
        'ctrl-a:toggle-all',
        'ctrl-l:clear-screen',
      }}
  end
  }

--a

  -- viml based plugins
  use { 'previm/previm', config = function() vim.g.previm_open_cmd='firefox' end }
  use { 'esamattis/slimux',
  config = function()
    map('v', 'ee', ':SlimuxREPLSendSelection<CR>')
    map('n', 'ee',  '<Cmd>SlimuxREPLSendLine<CR>')
    map('n', 'ep',  'vip:SlimuxREPLSendSelection<CR>')
    map('n', 'ex',  '<Cmd>SlimuxGlobalConfigure<CR>')
  end
  }
  use { 'tpope/vim-fugitive' }
  use { 'tpope/vim-rails' }
  use { 'tpope/vim-endwise' }
  use { 'editorconfig/editorconfig-vim' }
  use { 'bogado/file-line' }
  -- reformat text
  use { 'AndrewRadev/splitjoin.vim' }
  use { 'godlygeek/tabular' }


  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
}end})
