set nocompatible
set encoding=utf-8
filetype off

let mapleader="\<Space>"

if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab

set nrformats-=octal

if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

set laststatus=2
set ruler
set incsearch

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

set autoread

if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options

set t_Co=256

if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set number

set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

set nowrap
set copyindent
set shiftround
set showmatch
set ignorecase
set smartcase
set hlsearch

"Markdown syntax
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']

set mouse=a
set undolevels=1000
set title 
set novisualbell 
set noerrorbells
set splitbelow
set splitright

"quick save
map <Esc><Esc> :w<CR>

"copy and paste
map <Leader>y "+y
map <Leader>p "+p

"window mode mapping
map <Leader>w <C-w>

"sessions [totally optional]
map <Leader>s :source ~/.vim/sessions/
map <Leader>S :mks! ~/.vim/sessions/

"explore files
let g:netrw_banner=0        " disable banner
let g:netrw_liststyle=3     " tree view
let g:netrw_altv=1          " open splits to the right
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

"Quick file explore
map <Leader>e :Explore<CR>

"Quick tab open
map <Leader>t :tabedit<CR>

" Per default, netrw leaves unmodified buffers open. This autocommand
" deletes netrw's buffer once it's hidden (using ':q', for example)
autocmd FileType netrw setl bufhidden=delete

set path+=**
set wildmenu

"fuzzy find
map <Leader>f :find<Space> 

"Search buffers and open
nnoremap <Leader>b :buffer<Space>
"Control buffers
map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>

"Find in folder (check pwd) vim-ack plugin needed
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

"Show git branch on airline
set statusline=%{fugitive#statusline()}

"keep it simple
let g:airline_theme='simple'

"NERDCommenter for .vue files
let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction
