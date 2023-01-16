
local function ensure_packer()
    -- Automatically install packer
    local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        local packer_url = 'https://github.com/wbthomason/packer.nvim'
        vim.fn.system({'git', 'clone', '--depth', '1', packer_url, install_path})
        vim.cmd('packadd packer.nvim')
        return true
    end
    return false
end

local install_plugins = ensure_packer()


require('packer').startup(function(use)
    -- Plugin manager
    use {'wbthomason/packer.nvim'}

    use "neovim/nvim-lspconfig" -- enable LSP
  
    -- Theming
    use {'martinsione/darkplus.nvim'}
    use {'doums/darcula'}
    use {'kyazdani42/nvim-web-devicons'}
    use {'nvim-lualine/lualine.nvim'}
    use {'akinsho/bufferline.nvim'}
    use {'lukas-reineke/indent-blankline.nvim'}
  
    -- File explorer
    use {
      'nvim-tree/nvim-tree.lua',
      requires = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
      },
      tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    -- Fuzzy finder
    use {'nvim-telescope/telescope.nvim'}
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  
    -- Git
    use {'lewis6991/gitsigns.nvim'}
    use {'tpope/vim-fugitive'}
  
    -- Code manipulation
    use {'nvim-treesitter/nvim-treesitter'}
    use {'nvim-treesitter/nvim-treesitter-textobjects'}
    use {'numToStr/Comment.nvim'}
    use {'tpope/vim-surround'}
    use {'wellle/targets.vim'}
    use {'tpope/vim-repeat'}
  
    -- Utilities
    use {'moll/vim-bbye'}
    use {'nvim-lua/plenary.nvim'}
    use {'editorconfig/editorconfig-vim'}
    use {'akinsho/toggleterm.nvim'}
  
    if install_plugins then
      require('packer').sync()
    end
  end)


  ---
  -- Treesitter
  ---
  -- See :help nvim-treesitter-modules
  require('nvim-treesitter.configs').setup({
    highlight = {
      enable = true,
    },
    -- :help nvim-treesitter-textobjects-modules
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        }
      },
    },
    ensure_installed = {
      'javascript',
      'typescript',
      'tsx',
      'lua',
      'css',
      'json',
      'go'
    },
  })
  
  
  ---
  -- Comment.nvim
  ---
  require('Comment').setup({})
  
  
  ---
  -- Indent-blankline
  ---
  -- See :help indent-blankline-setup
  require('indent_blankline').setup({
    char = '▏',
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    use_treesitter = true,
    show_current_context = false
  })
  
  
  ---
  -- Gitsigns
  ---
  -- See :help gitsigns-usage
  require('gitsigns').setup({
    signs = {
      add = {text = '▎'},
      change = {text = '▎'},
      delete = {text = '➤'},
      topdelete = {text = '➤'},
      changedelete = {text = '▎'},
    }
  })
  
  
  ---
  -- Telescope
  ---
  -- See :help telescope.builtin
  vim.keymap.set('n', '<leader>?', '<cmd>Telescope oldfiles<cr>')
  vim.keymap.set('n', '<leader><space>', '<cmd>Telescope buffers<cr>')
  vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
  vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
  vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>')
  vim.keymap.set('n', '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
  
  require('telescope').load_extension('fzf')
  
  
  ---
  -- nvim-tree (File explorer)
  ---
  -- See :help nvim-tree-setup
  require("nvim-tree").setup({})  
  
  ---
  -- toggleterm
  ---
  -- See :help toggleterm-roadmap
  require('toggleterm').setup({
    open_mapping = '<C-g>',
    direction = 'horizontal',
    shade_terminals = true
  })