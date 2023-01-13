if empty(glob('~/.local/share/nvim/site/pack/packer/start/packer.nvim'))
    silent !git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    source ~/.config/nvim/init.vim
endif

lua require("plugins")

vim.g.mapleader = ','

source ~/.config/nvim/settings.vim
source ~/.config/nvim/mappings.vim
