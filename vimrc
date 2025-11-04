" ============================================================================
" VIM Configuration with Claude Integration
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

" Indentation
set tabstop=2           " Tab width
set shiftwidth=2        " Indent width
set softtabstop=2       " Soft tab width
set shiftround          " Round indent to multiple of shiftwidth
set expandtab           " Use spaces instead of tabs

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
" Claude Integration Functions
" ============================================================================

" Function to execute Claude command and show output in a split
function! ClaudeExecute(prompt)
    " Create a temporary file for the output
    let l:temp_file = tempname()

    " Execute Claude command
    let l:cmd = 'claude ' . shellescape(a:prompt) . ' > ' . l:temp_file . ' 2>&1'
    call system(l:cmd)

    " Open result in a new split
    execute 'botright new'
    execute 'resize 15'
    execute 'read ' . l:temp_file

    " Set buffer options
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal noswapfile
    setlocal readonly
    setlocal nomodifiable

    " Delete first empty line
    normal! ggdd

    " Clean up temp file
    call delete(l:temp_file)
endfunction

" Function to send selected text to Claude for editing
function! ClaudeEdit(instructions) range
    " Get the selected text
    let l:lines = getline(a:firstline, a:lastline)
    let l:text = join(l:lines, "\n")

    " Create temporary files
    let l:input_file = tempname()
    let l:output_file = tempname()

    " Write selected text to temp file
    call writefile(l:lines, l:input_file)

    " Build the prompt
    let l:prompt = a:instructions . "\n\nText to edit:\n" . l:text

    " Execute Claude command
    let l:cmd = 'echo ' . shellescape(l:prompt) . ' | claude > ' . l:output_file . ' 2>&1'
    call system(l:cmd)

    " Read the response
    let l:response = readfile(l:output_file)

    " Show response in a new split
    execute 'botright new'
    execute 'resize 15'
    call setline(1, l:response)

    " Set buffer options
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal noswapfile

    " Clean up temp files
    call delete(l:input_file)
    call delete(l:output_file)
endfunction

" Function to ask Claude about selected text
function! ClaudeAsk(question) range
    " Get the selected text
    let l:lines = getline(a:firstline, a:lastline)
    let l:text = join(l:lines, "\n")

    " Create temporary file
    let l:output_file = tempname()

    " Build the prompt
    let l:prompt = a:question . "\n\nContext:\n" . l:text

    " Execute Claude command
    let l:cmd = 'echo ' . shellescape(l:prompt) . ' | claude > ' . l:output_file . ' 2>&1'
    call system(l:cmd)

    " Read the response
    let l:response = readfile(l:output_file)

    " Show response in a new split
    execute 'botright new'
    execute 'resize 15'
    call setline(1, l:response)

    " Set buffer options
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal noswapfile

    " Clean up temp file
    call delete(l:output_file)
endfunction

" Function to replace selected text with Claude's response
function! ClaudeReplace(instructions) range
    " Get the selected text
    let l:lines = getline(a:firstline, a:lastline)
    let l:text = join(l:lines, "\n")

    " Create temporary file
    let l:output_file = tempname()

    " Build the prompt
    let l:prompt = a:instructions . "\n\nText to modify:\n" . l:text . "\n\nProvide ONLY the modified code without explanations."

    " Execute Claude command
    let l:cmd = 'echo ' . shellescape(l:prompt) . ' | claude > ' . l:output_file . ' 2>&1'
    echo "Asking Claude..."
    call system(l:cmd)

    " Read the response
    let l:response = readfile(l:output_file)

    " Replace the selected lines
    execute a:firstline . ',' . a:lastline . 'delete'
    call append(a:firstline - 1, l:response)

    " Clean up temp file
    call delete(l:output_file)

    echo "Done!"
endfunction

" Function to send current buffer to Claude
function! ClaudeBuffer(instructions)
    " Get all lines from buffer
    let l:lines = getline(1, '$')
    let l:text = join(l:lines, "\n")

    " Create temporary file
    let l:output_file = tempname()

    " Build the prompt
    let l:prompt = a:instructions . "\n\nFile content:\n" . l:text

    " Execute Claude command
    let l:cmd = 'echo ' . shellescape(l:prompt) . ' | claude > ' . l:output_file . ' 2>&1'
    call system(l:cmd)

    " Read the response
    let l:response = readfile(l:output_file)

    " Show response in a new split
    execute 'botright new'
    execute 'resize 15'
    call setline(1, l:response)

    " Set buffer options
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal noswapfile

    " Clean up temp file
    call delete(l:output_file)
endfunction

" ============================================================================
" Claude Commands
" ============================================================================

" Execute Claude with a prompt
command! -nargs=+ Claude call ClaudeExecute(<q-args>)

" Edit selected text with Claude (requires visual selection)
command! -range -nargs=+ ClaudeEdit <line1>,<line2>call ClaudeEdit(<q-args>)

" Ask Claude about selected text (requires visual selection)
command! -range -nargs=+ ClaudeAsk <line1>,<line2>call ClaudeAsk(<q-args>)

" Replace selected text with Claude's response (requires visual selection)
command! -range -nargs=+ ClaudeReplace <line1>,<line2>call ClaudeReplace(<q-args>)

" Analyze current buffer with Claude
command! -nargs=+ ClaudeBuffer call ClaudeBuffer(<q-args>)

" ============================================================================
" Claude Mappings
" ============================================================================

" Quick Claude commands in visual mode
vnoremap <Leader>ce :ClaudeEdit
vnoremap <Leader>ca :ClaudeAsk
vnoremap <Leader>cr :ClaudeReplace

" Quick Claude command
nnoremap <Leader>c :Claude

" Analyze current buffer
nnoremap <Leader>cb :ClaudeBuffer

" ============================================================================
" Help for Claude commands
" ============================================================================
"
" Commands:
"   :Claude <prompt>              - Execute Claude with a prompt
"   :ClaudeEdit <instructions>    - Edit selected text (visual mode)
"   :ClaudeAsk <question>         - Ask about selected text (visual mode)
"   :ClaudeReplace <instructions> - Replace selected text (visual mode)
"   :ClaudeBuffer <instructions>  - Analyze entire buffer
"
" Mappings:
"   <Leader>c                     - Quick Claude command
"   <Leader>cb                    - Analyze current buffer
"   (visual) <Leader>ce           - Edit selection
"   (visual) <Leader>ca           - Ask about selection
"   (visual) <Leader>cr           - Replace selection
"
" Examples:
"   :Claude explain what is vim
"   (select code) :ClaudeEdit add comments to this code
"   (select code) :ClaudeAsk what does this code do?
"   (select code) :ClaudeReplace refactor this to be more efficient
"   :ClaudeBuffer review this file for potential bugs
"
" ============================================================================
