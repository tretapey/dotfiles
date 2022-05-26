set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

"Terminal
map <Leader>t <C-w>s:terminal<cr>
tnoremap <Esc> <C-\><C-n>

"" If CoC installed
" command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument
" map <Leader>P :Prettier<cr>

"" GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

"" use <tab> for trigger completion and navigate to the next complete item
"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~ '\s'
"endfunction
"
"inoremap <silent><expr> <Tab>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<Tab>" :
"      \ coc#refresh()

"" If FZF installed
" set rtp+=/usr/local/opt/fzf
" map <Leader>o :FZF<cr>
 
