" Installs vim-plug
if empty(glob("~/.config/nvim/autoload/plug.vim"))
    silent !curl -fLso ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
end

" vim-plug plugins
call plug#begin("~/.config/nvim/plugged/")
source $HOME/.config/nvim/plugins.vim
call plug#end()

set title
set number
set relativenumber
set mouse=a

set nowrap
set cursorline
set colorcolumn=70

set tabstop=2
set shiftwidth=2
set softtabstop=2
set shiftround
set expandtab

set hidden
set ignorecase
set smartcase

set history=1000
set noswapfile
set nobackup

set autoindent
set showmatch
set laststatus=1

let mapleader=','
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1