let mapleader="\<Space>"

set number
set mouse=a

set title 
set nowrap 

set tabstop=2
set shiftwidth=2
set softtabstop=2
set shiftround
set expandtab  

set hidden  

set ignorecase  
set smartcase  

set showmatch

set foldmethod=indent
set foldnestmax=1
set foldlevelstart=1

set cursorline

set splitbelow
set splitright

"quick save
map <Esc><Esc> :w<CR>

"copy and paste
map <Leader>y "+y
map <Leader>p "+p

"window mode mapping
map <Leader>w <C-w>

"explore files
let g:netrw_banner=0        " disable banner
let g:netrw_altv=1          " open splits to the right
let g:netrw_list_hide=',\(^\|\s\s\)\zs\.\S\+'

"Quick file explore
map <Leader>e :Explore<CR>

"Quick tab open
map <Leader>t :tabedit<Space>

" Per default, netrw leaves unmodified buffers open. This autocommand
" deletes netrw's buffer once it's hidden (using ':q', for example)
autocmd FileType netrw setl bufhidden=delete

set path+=**
set wildmenu wildmode=list:longest,full

"fuzzy find
map <Leader>f :find<Space> 

"Search buffers and open
nnoremap <Leader>b :buffer<Space>
"Control buffers
map <Leader>gn :bn<cr>
map <Leader>gp :bp<cr>
map <Leader>gd :bd<cr>

"Search in files
map <Leader>F :grep -R<Space>
map <Leader>t <C-w>s:terminal<cr>

tnoremap <Esc> <C-\><C-n>
