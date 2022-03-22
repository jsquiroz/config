set nocompatible 
set history=1000 


" Installs vim-plug
if empty(glob("~/.config/nvim/autoload/plug.vim"))
    silent !curl -fLso ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
end

" vim-plug plugins
call plug#begin("~/.config/nvim/plugged/")
source $HOME/.config/nvim/plugins.vim
call plug#end()

set noswapfile
set nobackup

set showmode
set laststatus=2
set wildmenu
set nowrap
set number
set relativenumber
set cursorline
set colorcolumn=80
set cursorcolumn

let mapleader=","

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

nmap <Leader>nt :NERDTreeToggle<cr>

let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync