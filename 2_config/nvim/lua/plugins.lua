local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
	vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
	-- Package manager
	use 'wbthomason/packer.nvim'

	use { "catppuccin/nvim", as = "catppuccin" }

	use { -- Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		run = function()
			pcall(require('nvim-treesitter.install').update { with_sync = true })
		end,
	}

	use { "ellisonleao/glow.nvim" }

	use {
		'creativenull/diagnosticls-configs-nvim',
		tag = 'v0.1.8', -- `tag` is optional
		requires = 'neovim/nvim-lspconfig',
	}

	use { -- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		requires = {
			-- Automatically install LSPs to stdpath for neovim
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',

			-- Useful status updates for LSP
			'j-hui/fidget.nvim',

			-- Additional lua configuration, makes nvim stuff amazing
			'folke/neodev.nvim',
		},
	}

	use { -- Autocompletion
		'hrsh7th/nvim-cmp',
		requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
	}

	use 'lewis6991/gitsigns.nvim'


	use 'nvim-lualine/lualine.nvim' -- Fancier statusline
	use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
	use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
	use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically

	use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }
end)

require('nvim-treesitter.configs').setup {
	-- Add languages to be installed here that you want installed for treesitter
	ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'help', 'vim' },

	highlight = { enable = true },
	indent = { enable = true, disable = { 'python' } },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = '<c-space>',
			node_incremental = '<c-space>',
			scope_incremental = '<c-s>',
			node_decremental = '<c-backspace>',
		},
	},
}



require('glow').setup({})


require('lualine').setup {
	options = {
		icons_enabled = false,
		theme = 'onedark',
		component_separators = '|',
		section_separators = '',
	},
}

-- Enable Comment.nvim
require('Comment').setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require('indent_blankline').setup {
	char = '┊',
	show_trailing_blankline_indent = false,
}

-- Gitsigns
-- See `:help gitsigns.txt`
require('gitsigns').setup {
	signs = {
		add = { text = '+' },
		change = { text = '~' },
		delete = { text = '_' },
		topdelete = { text = '‾' },
		changedelete = { text = '~' },
	},
}

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
	defaults = {
		mappings = {
			i = {
				['<C-u>'] = false,
				['<C-d>'] = false,
			},
		},
	},
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

require('neodev').setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('mason').setup()


local servers = {
	-- clangd = {},
	gopls = {
		experimentalPostfixCompletions = true,
		analyses = {
			unusedparams = true,
			shadow = true,
		},
		staticcheck = true,
	},

	-- pyright = {},
	-- rust_analyzer = {},
	tsserver = {},
}

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
	ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
	function(server_name)
		require('lspconfig')[server_name].setup {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
		}
	end,
}

-- Turn on lsp status information
require('fidget').setup()



local dlsconfig = require 'diagnosticls-configs'
dlsconfig.init {
	default_config = false,
	format = true,
	on_attach = on_attach,
}
local eslint = require 'diagnosticls-configs.linters.eslint'
local prettier = require 'diagnosticls-configs.formatters.prettier'
prettier.requiredFiles = {
	'.prettierrc',
	'.prettierrc.json',
	'.prettierrc.toml',
	'.prettierrc.json',
	'.prettierrc.yml',
	'.prettierrc.yaml',
	'.prettierrc.json5',
	'.prettierrc.js',
	'.prettierrc.cjs',
	'prettier.config.js',
	'prettier.config.cjs',
}
dlsconfig.setup {
	['javascript'] = {
		linter = eslint,
		formatter = { prettier }
	},
	['javascriptreact'] = {
		linter = { eslint },
		formatter = { prettier }
	},
	['typescript'] = {
		linter = { eslint },
		formatter = { prettier }
	},
	['typescriptreact'] = {
		linter = { eslint },
		formatter = { prettier }
	},
	['css'] = {
		formatter = prettier
	},
	['html'] = {
		formatter = prettier
	},
}
