set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

"Terminal
map <Leader>t <C-w>s:terminal<cr>
tnoremap <Esc> <C-\><C-n>

