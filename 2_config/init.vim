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
set termguicolors
color smyck

set fillchars+=vert:\┊
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

let mapleader=","

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

nmap <Leader>nt :NERDTreeToggle<cr>
nmap <Leader>gt :GitGutterLineHighlightsToggle<cr>

let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

set updatetime=100
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'

let g:gitgutter_override_sign_column_highlight = 1
highlight SignColumn guibg=NONE
highlight SignColumn ctermbg=NONE