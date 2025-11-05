" ============================================================================
" VIM Configuration - VSCode-like Behavior
" ============================================================================

" Leader key
let mapleader="\<Space>"

" ============================================================================
" Basic Settings - VSCode Style
" ============================================================================

" Display
set number              " Show line numbers
set relativenumber      " Relative line numbers (like VSCode with relative line numbers)
set mouse=a             " Enable mouse support
set title               " Set terminal title
set nowrap              " Don't wrap lines
set cursorline          " Highlight current line
set cursorcolumn        " Highlight current column (helps with alignment)
set showmatch           " Show matching brackets
set matchtime=2         " Bracket blink time
set signcolumn=yes      " Always show sign column (like VSCode)
set scrolloff=8         " Keep 8 lines above/below cursor
set sidescrolloff=8     " Keep 8 columns left/right of cursor
set laststatus=2        " Always show status line
set showcmd             " Show command in bottom bar
set ruler               " Show line and column number
set visualbell          " No beep
set noerrorbells        " No error bells

" Indentation - Smart like VSCode
set tabstop=2           " Tab width
set shiftwidth=2        " Indent width
set softtabstop=2       " Soft tab width
set shiftround          " Round indent to multiple of shiftwidth
set expandtab           " Use spaces instead of tabs
set autoindent          " Auto indent
set smartindent         " Smart indent
set cindent             " C-style indenting

" Search - Enhanced
set ignorecase          " Ignore case in search
set smartcase           " Smart case sensitivity
set incsearch           " Incremental search
set hlsearch            " Highlight search results
set wrapscan            " Wrap search around file

" Behavior - Modern editor feel
set hidden              " Allow hidden buffers
set wildmenu            " Enhanced command-line completion
set wildmode=list:longest,full
set path+=**            " Search in subdirectories
set confirm             " Confirm dialog for unsaved changes
set autoread            " Auto reload changed files
set updatetime=300      " Faster update time (default 4000ms)
set timeoutlen=500      " Faster key sequence timeout
set clipboard=unnamed   " Use system clipboard

" Folding
set foldmethod=indent   " Fold based on indentation
set foldnestmax=3       " Max fold nesting
set foldlevelstart=99   " Start with all folds open
set foldcolumn=1        " Show fold column

" Splits - VSCode style
set splitbelow          " Open horizontal splits below
set splitright          " Open vertical splits to the right
set fillchars+=vert:\|  " Prettier vertical split character

" Persistent Undo
if has('persistent_undo')
    set undofile
    set undolevels=1000
    set undoreload=10000
    if !isdirectory($HOME.'/.vim/undo')
        call mkdir($HOME.'/.vim/undo', 'p', 0700)
    endif
    set undodir=~/.vim/undo
endif

" Backup and Swap
set nobackup            " Don't create backup files
set nowritebackup       " Don't create backup before overwriting
set noswapfile          " Don't create swap files

" Completion - IntelliSense-like
set completeopt=menuone,longest,preview
set complete+=kspell    " Add spell check to completion
set shortmess+=c        " Don't show completion messages
set pumheight=10        " Popup menu height

" File type detection
filetype plugin indent on
syntax enable

" ============================================================================
" Filetype Detection for Additional Languages
" ============================================================================

" Custom filetype associations for modern web frameworks and languages
augroup filetypedetect
  autocmd!
  " Svelte files (uses HTML syntax as base)
  autocmd BufNewFile,BufRead *.svelte set filetype=html syntax=html

  " TypeScript React
  autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact

  " TypeScript
  autocmd BufNewFile,BufRead *.ts set filetype=typescript

  " JSX
  autocmd BufNewFile,BufRead *.jsx set filetype=javascriptreact

  " Vue files
  autocmd BufNewFile,BufRead *.vue set filetype=html syntax=html

  " Markdown variants
  autocmd BufNewFile,BufRead *.md,*.markdown set filetype=markdown

  " YAML
  autocmd BufNewFile,BufRead *.yml,*.yaml set filetype=yaml

  " JSON
  autocmd BufNewFile,BufRead *.json set filetype=json

  " Docker
  autocmd BufNewFile,BufRead Dockerfile*,*.dockerfile set filetype=dockerfile

  " Terraform
  autocmd BufNewFile,BufRead *.tf,*.tfvars set filetype=terraform

  " Go templates
  autocmd BufNewFile,BufRead *.gotmpl,*.tmpl set filetype=gotmpl
augroup END

" ============================================================================
" Enhanced Mappings - VSCode Style
" ============================================================================

" Quick save (Ctrl+S style)
map <Esc><Esc> :w<CR>
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a
vnoremap <C-s> <Esc>:w<CR>gv

" Copy and paste to system clipboard
map <Leader>y "+y
map <Leader>p "+p
vnoremap <C-c> "+y
vnoremap <C-x> "+d
nnoremap <C-v> "+p
inoremap <C-v> <C-r>+

" Select all (like Ctrl+A in VSCode)
nnoremap <Leader>a ggVG

" Undo/Redo (VSCode style)
nnoremap <C-z> u
inoremap <C-z> <C-o>u
nnoremap <C-y> <C-r>
inoremap <C-y> <C-o><C-r>

" Duplicate line (like Ctrl+Shift+D in VSCode)
nnoremap <Leader>d :t.<CR>
vnoremap <Leader>d y'>p

" Move lines up/down (like Alt+Up/Down in VSCode)
nnoremap <A-Up> :m .-2<CR>==
nnoremap <A-Down> :m .+1<CR>==
vnoremap <A-Up> :m '<-2<CR>gv=gv
vnoremap <A-Down> :m '>+1<CR>gv=gv

" Better indenting in visual mode
vnoremap < <gv
vnoremap > >gv
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Window navigation (Ctrl+h/j/k/l like VSCode splits)
map <Leader>w <C-w>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Quick file explore (like Ctrl+Shift+E in VSCode)
let g:netrw_banner=0        " Disable banner
let g:netrw_altv=1          " Open splits to the right
let g:netrw_list_hide=',\(^\|\s\s\)\zs\.\S\+'
let g:netrw_liststyle=3     " Tree view
let g:netrw_browse_split=4  " Open in previous window
let g:netrw_winsize=25      " 25% width
map <Leader>e :Lexplore<CR>

" Tab management
map <Leader>t :tabedit<Space>
nnoremap <C-Tab> :tabnext<CR>
nnoremap <C-S-Tab> :tabprev<CR>

" Fuzzy find (Ctrl+P style)
map <Leader>f :find<Space>

" Buffer management (mantener tus comandos)
nnoremap <Leader>b :buffer<Space>
map <Leader>gn :bn<cr>
map <Leader>gp :bp<cr>
map <Leader>bd :bd<cr>

" Search in files (like Ctrl+Shift+F in VSCode)
map <Leader>F :grep -R<Space>

" Clear search highlighting
nnoremap <Leader><Space> :nohlsearch<CR>
nnoremap <Esc> :nohlsearch<CR><Esc>

" Toggle line numbers
nnoremap <Leader>n :set number! relativenumber!<CR>

" Quick comment toggle (basic version)
autocmd FileType javascript,typescript,c,cpp,java,rust nnoremap <Leader>/ :s/^/\/\/ /<CR>:nohlsearch<CR>
autocmd FileType javascript,typescript,c,cpp,java,rust vnoremap <Leader>/ :s/^/\/\/ /<CR>:nohlsearch<CR>
autocmd FileType python,ruby,sh,bash nnoremap <Leader>/ :s/^/# /<CR>:nohlsearch<CR>
autocmd FileType python,ruby,sh,bash vnoremap <Leader>/ :s/^/# /<CR>:nohlsearch<CR>
autocmd FileType vim nnoremap <Leader>/ :s/^/" /<CR>:nohlsearch<CR>
autocmd FileType vim vnoremap <Leader>/ :s/^/" /<CR>:nohlsearch<CR>

" ============================================================================
" Terminal Integration - VSCode Style
" ============================================================================

" Open terminal in horizontal split (like Ctrl+` in VSCode)
nnoremap <Leader>tt :botright split \| resize 15 \| terminal<CR>

" Open terminal in vertical split
nnoremap <Leader>tv :botright vsplit \| terminal<CR>

" Terminal mode mappings for vim
if has('terminal')
    " Exit terminal mode with Esc Esc
    tnoremap <Esc><Esc> <C-W>N
    " Quick window navigation from terminal mode
    tnoremap <C-h> <C-w>h
    tnoremap <C-j> <C-w>j
    tnoremap <C-k> <C-w>k
    tnoremap <C-l> <C-w>l
endif

" Terminal mode mappings for neovim
if has('nvim')
    " Exit terminal mode with Esc Esc
    tnoremap <Esc><Esc> <C-\><C-n>
    " Quick window navigation from terminal mode
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
    " Start terminal in insert mode
    autocmd TermOpen * startinsert
endif

" ============================================================================
" VSCode-like Status Line
" ============================================================================

" Custom statusline
set statusline=
set statusline+=%#PmenuSel#                           " Color
set statusline+=\ %{StatuslineMode()}                 " Mode
set statusline+=\ %#LineNr#                           " Color
set statusline+=\ %f                                  " File path
set statusline+=\ %m                                  " Modified flag
set statusline+=\ %r                                  " Readonly flag
set statusline+=%=                                    " Right align
set statusline+=\ %#CursorColumn#                     " Color
set statusline+=\ %y                                  " File type
set statusline+=\ %{&fileencoding?&fileencoding:&encoding} " Encoding
set statusline+=\ [%{&fileformat}]                    " File format
set statusline+=\ %p%%                                " Percentage through file
set statusline+=\ %l:%c                               " Line:Column
set statusline+=\

" Function to get current mode
function! StatuslineMode()
    let l:mode=mode()
    if l:mode==#'n'
        return 'NORMAL'
    elseif l:mode==?'v'
        return 'VISUAL'
    elseif l:mode==#'i'
        return 'INSERT'
    elseif l:mode==#'R'
        return 'REPLACE'
    elseif l:mode==?'s'
        return 'SELECT'
    elseif l:mode==#'t'
        return 'TERMINAL'
    elseif l:mode==#'c'
        return 'COMMAND'
    elseif l:mode==#'!'
        return 'SHELL'
    endif
endfunction

" ============================================================================
" Auto Commands - VSCode Behaviors
" ============================================================================

" Return to last edit position when opening files
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Highlight yanked text
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=200}
augroup END

" Auto-close preview window after completion
autocmd CompleteDone * pclose

" Trim trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Auto-reload vimrc on save
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" ============================================================================
" Split Window Management
" ============================================================================

" Function to toggle window zoom (maximize/restore)
function! ToggleZoom()
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction

" Zoom toggle mapping
nnoremap <Leader>z :call ToggleZoom()<CR>

" Quick split resizing
nnoremap <Leader>= <C-w>=
nnoremap <Leader>_ <C-w>_
nnoremap <Leader><Bar> <C-w><Bar>

" ============================================================================
" Smart Features - VSCode Behaviors
" ============================================================================

" Auto-pairs for brackets (basic implementation without plugins)
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap ` ``<Left>

" Smart deletion of auto-pairs
inoremap <expr> <BS> <SID>DeletePair()
function! s:DeletePair()
    let l:line = getline('.')
    let l:col = col('.') - 1
    let l:prev_char = l:line[l:col - 1]
    let l:next_char = l:line[l:col]

    if (l:prev_char == '(' && l:next_char == ')') ||
     \ (l:prev_char == '[' && l:next_char == ']') ||
     \ (l:prev_char == '{' && l:next_char == '}') ||
     \ (l:prev_char == '"' && l:next_char == '"') ||
     \ (l:prev_char == "'" && l:next_char == "'") ||
     \ (l:prev_char == '`' && l:next_char == '`')
        return "\<Right>\<BS>\<BS>"
    else
        return "\<BS>"
    endif
endfunction

" Jump out of brackets with Tab
inoremap <expr> <Tab> search('\%#[]>)}''"`]', 'n') ? '<Right>' : '<Tab>'

" Smart closing brace
inoremap <expr> } <SID>CloseBlock()
function! s:CloseBlock()
    if getline('.')[col('.')-2] == '{'
        return "}\<Left>\<CR>\<CR>\<Up>\<Tab>"
    else
        return '}'
    endif
endfunction

" Multi-cursor simulation (simple version with cgn)
" Use * to search word, then use cgn to change next occurrence, then . to repeat
nnoremap <silent> <Leader>* *Ncgn

" ============================================================================
" Git Diff Integration Functions
" ============================================================================

" Function to show interactive list of changed files
function! GitDiffList()
    " Check if we're in a git repo
    let l:git_check = system('git rev-parse --git-dir 2>/dev/null')
    if v:shell_error != 0
        echo "Not in a git repository"
        return
    endif

    " Get list of changed files
    let l:changed_files = system('git diff HEAD --name-only')

    if v:shell_error != 0
        echo "Error getting changed files"
        return
    endif

    if empty(l:changed_files)
        echo "No changes in repository"
        return
    endif

    let l:files = split(l:changed_files, '\n')

    " Create a new split at the bottom
    botright new
    resize 15

    " Set buffer options
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal noswapfile
    setlocal nomodifiable
    setlocal cursorline

    " Set buffer name
    silent file [Git\ Changed\ Files]

    " Insert content
    setlocal modifiable
    call setline(1, '# Changed Files (press Enter to view diff, q to close)')
    call setline(2, '# Use j/k to navigate')
    call setline(3, '')
    let l:line_num = 4
    for l:file in l:files
        call setline(l:line_num, l:file)
        let l:line_num += 1
    endfor
    setlocal nomodifiable

    " Move to first file
    normal! 4G

    " Add syntax highlighting
    syntax match gitDiffListHeader "^#.*"
    syntax match gitDiffListFile "^[^#].*"
    highlight gitDiffListHeader ctermfg=cyan guifg=cyan
    highlight gitDiffListFile ctermfg=yellow guifg=yellow

    " Set up key mappings for this buffer
    nnoremap <buffer> <CR> :call OpenGitDiffFromList()<CR>
    nnoremap <buffer> q :q<CR>
    nnoremap <buffer> <Esc> :q<CR>

    echo "Press Enter to view diff, q to close"
endfunction

" Function to open git diff from the file list
function! OpenGitDiffFromList()
    " Get the current line
    let l:line = getline('.')

    " Skip header lines
    if l:line =~ '^#' || empty(l:line)
        return
    endif

    " Get the file path
    let l:file = trim(l:line)

    " Close the list window
    quit

    " Open the file
    execute 'edit ' . fnameescape(l:file)

    " Show diff for this file
    call GitDiffFileByPath(l:file)
endfunction

" Function to show git diff of a specific file by path
function! GitDiffFileByPath(file_path)
    " Get the absolute path
    let l:file = fnamemodify(a:file_path, ':p')

    " Check if file is tracked by git
    let l:git_check = system('git ls-files --error-unmatch ' . shellescape(l:file) . ' 2>/dev/null')
    if v:shell_error != 0
        echo "File is not tracked by git"
        return
    endif

    " Get the relative path from git root
    let l:git_path = system('git ls-files --full-name ' . shellescape(l:file))
    let l:git_path = substitute(l:git_path, '\n', '', 'g')

    " Check if file has changes
    let l:diff_check = system('git diff HEAD -- ' . shellescape(l:file))
    if empty(l:diff_check)
        echo "No changes in this file"
        return
    endif

    " Get the HEAD version of the file
    let l:head_content = system('git show HEAD:' . l:git_path)

    if v:shell_error != 0
        echo "Error getting HEAD version: " . l:head_content
        return
    endif

    " Create a new vertical split on the left
    leftabove vnew

    " Set up the buffer with HEAD content
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal noswapfile
    setlocal readonly
    setlocal nomodifiable

    " Set the buffer name
    execute 'silent file [HEAD]\ ' . fnamemodify(a:file_path, ':t')

    " Insert HEAD content
    setlocal modifiable
    call setline(1, split(l:head_content, '\n'))
    setlocal nomodifiable

    " Enable diff mode on this buffer
    diffthis

    " Go back to the original window and enable diff
    wincmd l
    diffthis

    echo "Showing git diff. Use :GitDiffClose or <Leader>gq to close"
endfunction

" Function to show git diff of current file in split view
function! GitDiffFile()
    let l:file = expand('%:p')

    " Check if file exists and is in a git repo
    if empty(l:file)
        " No file open, show list of changed files
        call GitDiffList()
        return
    endif

    " Check if file is tracked by git
    let l:git_check = system('git ls-files --error-unmatch ' . shellescape(l:file) . ' 2>/dev/null')
    if v:shell_error != 0
        echo "File is not tracked by git"
        return
    endif

    " Get the relative path from git root
    let l:git_path = system('git ls-files --full-name ' . shellescape(l:file))
    let l:git_path = substitute(l:git_path, '\n', '', 'g')

    " Check if file has changes
    let l:diff_check = system('git diff HEAD -- ' . shellescape(l:file))
    if empty(l:diff_check)
        echo "No changes in current file"
        return
    endif

    " Save current window
    let l:current_win = winnr()

    " Get the HEAD version of the file
    let l:head_content = system('git show HEAD:' . l:git_path)

    if v:shell_error != 0
        echo "Error getting HEAD version: " . l:head_content
        return
    endif

    " Create a new vertical split on the left
    leftabove vnew

    " Set up the buffer with HEAD content
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal noswapfile
    setlocal readonly
    setlocal nomodifiable

    " Set the buffer name
    silent file [HEAD]\ %:t

    " Insert HEAD content
    setlocal modifiable
    call setline(1, split(l:head_content, '\n'))
    setlocal nomodifiable

    " Enable diff mode on this buffer
    diffthis

    " Go back to the original window and enable diff
    wincmd l
    diffthis

    echo "Showing git diff. Use :GitDiffClose or <Leader>gq to close"
endfunction

" Function to close git diff view
function! GitDiffClose()
    " Turn off diff mode in all windows
    diffoff!

    " Close any [HEAD] buffers
    let l:buffers = range(1, bufnr('$'))
    for l:buf in l:buffers
        if bufexists(l:buf) && bufname(l:buf) =~ '^\[HEAD\]'
            execute 'bwipeout! ' . l:buf
        endif
    endfor

    echo "Git diff closed"
endfunction

" Function to show git status in a split
function! GitStatus()
    " Get git status
    let l:status = system('git status')

    if v:shell_error != 0
        echo "Not in a git repository"
        return
    endif

    " Create a new split at the bottom
    botright new
    resize 15

    " Set buffer options
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal noswapfile
    setlocal nomodifiable

    " Set buffer name
    silent file [Git\ Status]

    " Insert content
    setlocal modifiable
    call setline(1, split(l:status, '\n'))
    setlocal nomodifiable

    " Add syntax highlighting
    syntax match gitStatusModified "^\s*modified:.*"
    syntax match gitStatusNew "^\s*new file:.*"
    syntax match gitStatusDeleted "^\s*deleted:.*"
    syntax match gitStatusRenamed "^\s*renamed:.*"
    syntax match gitStatusUntracked "^\s*.*Untracked files.*"

    highlight gitStatusModified ctermfg=yellow guifg=yellow
    highlight gitStatusNew ctermfg=green guifg=green
    highlight gitStatusDeleted ctermfg=red guifg=red
    highlight gitStatusRenamed ctermfg=blue guifg=blue
    highlight gitStatusUntracked ctermfg=red guifg=red

    echo "Press q to close"
    nnoremap <buffer> q :q<CR>
endfunction

" Function to show git diff of all changes
function! GitDiffAll()
    " Get git diff
    let l:diff = system('git diff HEAD')

    if v:shell_error != 0
        echo "Error getting git diff"
        return
    endif

    if empty(l:diff)
        echo "No changes in repository"
        return
    endif

    " Create a new split at the bottom
    botright new
    resize 20

    " Set buffer options
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal noswapfile
    setlocal nomodifiable

    " Set buffer name
    silent file [Git\ Diff\ All]

    " Insert content
    setlocal modifiable
    call setline(1, split(l:diff, '\n'))
    setlocal nomodifiable

    " Set filetype to diff for syntax highlighting
    setlocal filetype=diff

    echo "Press q to close"
    nnoremap <buffer> q :q<CR>
endfunction

" ============================================================================
" Git Commands
" ============================================================================

" Show git diff of current file in split view
command! GitDiff call GitDiffFile()

" Close git diff view
command! GitDiffClose call GitDiffClose()

" Show git status
command! GitStatus call GitStatus()

" Show all git changes
command! GitDiffAll call GitDiffAll()

" ============================================================================
" Git Mappings
" ============================================================================

" Show git diff of current file (split view like VSCode)
nnoremap <Leader>gd :GitDiff<CR>

" Close git diff view
nnoremap <Leader>gq :GitDiffClose<CR>

" Show git status
nnoremap <Leader>gs :GitStatus<CR>

" Show all git changes
nnoremap <Leader>ga :GitDiffAll<CR>

" ============================================================================
" Quick Reference - VSCode-like Vim Configuration
" ============================================================================
"
" Leader Key: <Space>
"
" File Management:
"   <Leader>e                     - Toggle file explorer
"   <Leader>f                     - Fuzzy find files
"   <Leader>F                     - Search in files (grep)
"   <Leader>t                     - Open new tab
"   Ctrl+S / Esc Esc              - Save file
"
" Editing:
"   <Leader>d                     - Duplicate line
"   <Leader>/                     - Toggle line comment
"   <Leader>a                     - Select all
"   Alt+Up/Down                   - Move line up/down
"   Ctrl+Z                        - Undo
"   Ctrl+Y                        - Redo
"   Tab/Shift+Tab in Visual       - Indent/Unindent
"
" Navigation:
"   Ctrl+H/J/K/L                  - Navigate between splits
"   <Leader>gn / <Leader>gp       - Next/Previous buffer
"   <Leader>bd                    - Close buffer (buffer delete)
"   Ctrl+Tab / Ctrl+Shift+Tab     - Next/Previous tab
"
" Git Integration:
"   <Leader>gd                    - Show git diff
"   <Leader>gq                    - Close git diff
"   <Leader>gs                    - Show git status
"   <Leader>ga                    - Show all git changes
"   ]c / [c                       - Next/Previous git change (in diff mode)
"
" Window Management:
"   <Leader>z                     - Toggle zoom (maximize/restore)
"   <Leader>=                     - Equalize all splits
"   <Leader>_                     - Maximize vertically
"   <Leader>|                     - Maximize horizontally
"
" Terminal:
"   <Leader>tt                    - Open terminal (horizontal split)
"   <Leader>tv                    - Open terminal (vertical split)
"   Esc Esc (in terminal)         - Exit terminal mode
"   Ctrl+H/J/K/L (in terminal)    - Navigate from terminal to other windows
"
" Other:
"   <Leader><Space>               - Clear search highlighting
"   <Leader>n                     - Toggle line numbers
"   <Leader>*                     - Multi-cursor mode (cgn)
"
" ============================================================================
