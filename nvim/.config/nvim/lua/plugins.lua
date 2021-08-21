local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  print("packer.nvim isn't installed")
  print("visit https://github.com/wbthomason/packer.nvim#quickstart for clone instructions")
  return
end

vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])

vim.cmd [[packadd packer.nvim]]
require('packer').startup(
  {function()
	-- Packer can manage itself as an optional plugin
	 use {"wbthomason/packer.nvim", opt = true}

	-- Colorschemes
	-- use {
	-- 	"nvim-lua/telescope.nvim",
	-- 	requires = {{"nvim-lua/popup.nvim", opt = true}, {"nvim-lua/plenary.nvim", opt = true}},
	-- 	cmd = {"Telescope"},
	-- }
	  use { 'nvim-telescope/telescope.nvim',
	    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
	    cmd = {"Telescope"},
	    config = function()
		    local map = vim.api.nvim_set_keymap
		    map('n', '<Leader>fb', '<Cmd>Telescope buffers<CR>', {noremap = true})
		    map('n', '<Leader>ff', '<Cmd>Telescope find_files<CR>', {noremap = true})
	     end,
     }

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

  use { 'previm/previm', config = function() vim.g.previm_open_cmd='firefox' end }

  use { 'ibhagwan/fzf-lua',
    requires = { 'vijaymarupudi/nvim-fzf'},
    -- 'kyazdani42/nvim-web-devicons' } -- optional for icons
    -- use {'vijaymarupudi/nvim-fzf-commands'}
    config = function()
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


  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
}end})
