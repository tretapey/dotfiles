" ============================================================================
" VIM Configuration for VSCode-like Experience
" ============================================================================

" Leader key
let mapleader="\<Space>"

" ============================================================================
" Basic Settings
" ============================================================================

" Display
set number              " Show line numbers
set mouse=a             " Enable mouse support
set title               " Set terminal title
set nowrap              " Don't wrap lines
set cursorline          " Highlight current line
set showmatch           " Show matching brackets
set laststatus=2        " Always show statusline
set showtabline=2       " Always show tabline

" Indentation
set tabstop=2           " Tab width
set shiftwidth=2        " Indent width
set softtabstop=2       " Soft tab width
set shiftround          " Round indent to multiple of shiftwidth
set expandtab           " Use spaces instead of tabs
set autoindent
set smartindent

" Search
set ignorecase          " Ignore case in search
set smartcase           " Smart case sensitivity
set incsearch           " Incremental search
set hlsearch            " Highlight search results

" Behavior
set hidden              " Allow hidden buffers
set wildmenu            " Enhanced command-line completion
set wildmode=list:longest,full
set path+=**            " Search in subdirectories
set autoread            " Auto reload files changed outside
set updatetime=300      " Faster CursorHold (diagnostics, etc.)
set scrolloff=8         " Keep cursor away from screen edge
set sidescrolloff=8
set backspace=indent,eol,start
set shortmess+=c        " Avoid "press ENTER" prompts for completion
set confirm             " Prompt instead of erroring on quit with unsaved changes
set noerrorbells
set visualbell
set t_vb=
set belloff=all
set noshowmode          " Rely on statusline instead of mode text
set lazyredraw          " Smoother scrolling during macros
set iskeyword+=-        " Treat hyphenated words as a single word
set wildignore+=*/node_modules/*,*/.git/*,*.pyc,*.o,*.swp,*.zip

" Visual Enhancements for VSCode-like UX
if has('termguicolors')
    set termguicolors
endif
set signcolumn=yes
set fillchars+=vert:\|
set list               " Show tabs/trailing spaces similar to VSCode
set listchars=tab:>-,trail:-,extends:>,precedes:<

" Clipboard and Undo Behavior
set clipboard=unnamedplus   " Share clipboard with system
if has('persistent_undo')
    let undo_dir = expand('~/.vim/undo')
    if !isdirectory(undo_dir)
        call mkdir(undo_dir, 'p', 0755)
    endif
    set undodir=~/.vim/undo
    set undofile
endif

" Completion behavior similar to VSCode suggestions
set completeopt=menuone,noinsert,noselect
set pumheight=12

" Diff and split visuals
set diffopt+=vertical

" Language awareness and indentation helpers
syntax on
filetype plugin indent on

if has('autocmd')
    augroup vscode_like_autoread
        autocmd!
        autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * silent! checktime
    augroup END
endif

" Folding
set foldmethod=indent   " Fold based on indentation
set foldnestmax=1       " Max fold nesting
set foldlevelstart=1    " Start with folds open

" Splits
set splitbelow          " Open horizontal splits below
set splitright          " Open vertical splits to the right

" ============================================================================
" Basic Mappings
" ============================================================================

" Quick save
map <Esc><Esc> :w<CR>

" Copy and paste to system clipboard
map <Leader>y "+y
map <Leader>p "+p

" Window navigation
map <Leader>w <C-w>

" Quick file explore
let g:netrw_banner=0        " Disable banner
let g:netrw_altv=1          " Open splits to the right
let g:netrw_list_hide=',\(^\|\s\s\)\zs\.\S\+'
map <Leader>e :Explore<CR>

" Tab management
map <Leader>t :tabedit<Space>

" Fuzzy find
map <Leader>f :find<Space>

" Buffer management
nnoremap <Leader>b :buffer<Space>
map <Leader>gn :bn<cr>
map <Leader>gp :bp<cr>
map <Leader>gd :bd<cr>

" Search in files
map <Leader>F :grep -R<Space>

" Clear search highlighting
nnoremap <Leader><Space> :nohlsearch<CR>

" ============================================================================
" Terminal Mappings
" ============================================================================

" Terminal mode mappings for vim
if has('terminal')
    " Exit terminal mode with Esc (easier than Ctrl-W N)
    tnoremap <Esc><Esc> <C-W>N
    " Quick window navigation from terminal mode
    tnoremap <C-w> <C-W>
endif

" Terminal mode mappings for neovim
if has('nvim')
    " Exit terminal mode with Esc
    tnoremap <Esc><Esc> <C-\><C-n>
    " Quick window navigation from terminal mode
    tnoremap <C-w>h <C-\><C-n><C-w>h
    tnoremap <C-w>j <C-\><C-n><C-w>j
    tnoremap <C-w>k <C-\><C-n><C-w>k
    tnoremap <C-w>l <C-\><C-n><C-w>l
endif

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
nnoremap <Leader>\| <C-w>\|

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
" Help - Git Integration
" ============================================================================
"
" Commands:
"   :GitDiff                      - Show git diff (file or interactive list)
"   :GitDiffClose                 - Close git diff view
"   :GitStatus                    - Show git status in split
"   :GitDiffAll                   - Show all git changes in repository
"
" Mappings:
"   <Leader>gd                    - Show git diff (split view like VSCode)
"   <Leader>gq                    - Close git diff view
"   <Leader>gs                    - Show git status
"   <Leader>ga                    - Show all git changes
"
" Git Diff Behavior:
"   - If a file is open: Shows diff of that file in split view
"   - If no file is open: Shows interactive list of all changed files
"
" Interactive File List (when no file is open):
"   j/k or arrows                 - Navigate between files
"   Enter                         - Open file and show its diff
"   q or Esc                      - Close the list
"
" Git Diff Navigation (when in diff mode):
"   ]c                            - Jump to next change
"   [c                            - Jump to previous change
"   do                            - Obtain change from other buffer
"   dp                            - Put change to other buffer
"   :diffupdate                   - Update diff highlighting
"   zo                            - Open fold
"   zc                            - Close fold
"
" Workflow Examples:
"
"   Example 1 - View specific file changes:
"     1. Edit a file that's tracked by git
"     2. Press <Leader>gd to see changes side-by-side
"        - Left side: HEAD version (read-only)
"        - Right side: Your changes (editable)
"     3. Navigate between changes with ]c and [c
"     4. Press <Leader>gq to close diff view
"
"   Example 2 - Browse all changes (NEW!):
"     1. Open vim without a file (or run :GitDiff with no file)
"     2. Press <Leader>gd to see list of changed files
"     3. Use j/k to navigate to a file
"     4. Press Enter to view that file's diff
"     5. Press <Leader>gq to close diff
"     6. Repeat to view other files
"
"   Example 3 - Quick status check:
"     1. Press <Leader>gs to see git status anytime
"
" ============================================================================
" Help - Terminal and Split Management
" ============================================================================
"
" Terminal Scrolling:
"   In any terminal buffer press Esc Esc to enter Normal mode (see mappings above)
"   Then you can:
"     - Use j/k or arrow keys to scroll
"     - Use Ctrl-u/Ctrl-d for page up/down
"     - Use gg/G to go to top/bottom
"     - Use / to search
"   Press i or a to return to terminal mode
"
" Split Management:
"   <Leader>z                     - Toggle zoom (maximize/restore current split)
"   <Leader>=                     - Equalize all splits
"   <Leader>_                     - Maximize current split vertically
"   <Leader>|                     - Maximize current split horizontally
"   Ctrl-w h/j/k/l                - Navigate between splits
"   Ctrl-w +/-                    - Resize split height
"   Ctrl-w >/<                    - Resize split width
"
" ============================================================================
" Help - VSCode-like Enhancements
" ============================================================================
"
" Visual & Navigation:
"   termguicolors / signcolumn     - Rich UI with dedicated change column
"   list & listchars               - Reveal tabs/trailing spaces (toggle with :set nolist)
"   scrolloff=8                    - Keeps cursor away from the screen edge
"   diffopt+=vertical              - Side-by-side diffs similar to VSCode
"
" Editing Experience:
"   clipboard=unnamedplus          - Shares clipboard with your OS
"   backspace=indent,eol,start     - Backspace behaves like modern editors
"   persistent undo (undofile)     - Undo history survives restarts
"   completeopt settings           - Popup completion shows but does not auto-accept
"
" Quality of Life:
"   autoread + :checktime          - Buffers auto-refresh when files change on disk
"   updatetime=300                 - Faster CursorHold events for linting
"   fillchars & showtabline        - Cleaner splits and visible tabline
"
" Tips:
"   :set nolist                    - Hide whitespace markers temporarily
"   :set colorcolumn=81            - Optional column guide when needed
"   :help scrolloff                - Learn more about centered scrolling
"
" ============================================================================
