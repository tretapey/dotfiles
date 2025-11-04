" ============================================================================
" VIM Configuration with Claude Code Integration
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
" Claude Code Integration Functions
" ============================================================================

" Function to open Claude Code interactively in terminal
function! ClaudeOpen()
    " Check if we have terminal support
    if has('terminal')
        " Open Claude in a terminal split
        botright terminal ++close ++rows=20 claude
    elseif has('nvim')
        " Neovim terminal
        botright split
        resize 20
        terminal claude
    else
        " Fallback to shell execution
        !claude
    endif
endfunction

" Function to send current file to Claude Code
function! ClaudeFile(...)
    let l:prompt = a:0 > 0 ? join(a:000, ' ') : 'Review this file'
    let l:file = expand('%:p')

    if empty(l:file)
        echo "No file in current buffer"
        return
    endif

    " Create command to run claude with file context
    let l:cmd = 'claude "' . escape(l:prompt, '"') . '" "' . l:file . '"'

    " Check if we have terminal support
    if has('terminal')
        execute 'botright terminal ++close ++rows=20 ' . l:cmd
    elseif has('nvim')
        botright split
        resize 20
        execute 'terminal ' . l:cmd
    else
        execute '!' . l:cmd
    endif
endfunction

" Function to send selected text to Claude Code
function! ClaudeSelection(...) range
    let l:prompt = a:0 > 0 ? join(a:000, ' ') : 'Explain this code'

    " Get the selected text
    let l:lines = getline(a:firstline, a:lastline)
    let l:text = join(l:lines, "\n")

    " Create temporary file with selection
    let l:temp_file = tempname() . '.txt'
    call writefile(l:lines, l:temp_file)

    " Create command to run claude with selection
    let l:cmd = 'claude "' . escape(l:prompt, '"') . '" "' . l:temp_file . '"'

    " Check if we have terminal support
    if has('terminal')
        execute 'botright terminal ++close ++rows=20 ' . l:cmd
    elseif has('nvim')
        botright split
        resize 20
        execute 'terminal ' . l:cmd
    else
        execute '!' . l:cmd
    endif
endfunction

" Function to run Claude Code with a specific prompt
function! ClaudePrompt(prompt)
    let l:cmd = 'claude "' . escape(a:prompt, '"') . '"'

    " Check if we have terminal support
    if has('terminal')
        execute 'botright terminal ++close ++rows=20 ' . l:cmd
    elseif has('nvim')
        botright split
        resize 20
        execute 'terminal ' . l:cmd
    else
        execute '!' . l:cmd
    endif
endfunction

" Function to send current file to Claude and get code back
function! ClaudeEdit(...) range
    let l:prompt = a:0 > 0 ? join(a:000, ' ') : 'Refactor this code'

    " Get the text (either selection or whole file)
    if a:firstline != a:lastline || a:firstline != 1
        " We have a selection
        let l:lines = getline(a:firstline, a:lastline)
        let l:is_selection = 1
    else
        " Whole file
        let l:lines = getline(1, '$')
        let l:is_selection = 0
    endif

    " Create temporary input file
    let l:input_file = tempname() . '.txt'
    call writefile(l:lines, l:input_file)

    " Create temporary output file
    let l:output_file = tempname() . '.txt'

    " Run claude in non-interactive mode
    let l:full_prompt = l:prompt . '. Respond with ONLY the code, no explanations.'
    let l:cmd = 'claude "' . escape(l:full_prompt, '"') . '" "' . l:input_file . '" > "' . l:output_file . '" 2>&1'

    echo "Asking Claude Code..."
    call system(l:cmd)

    " Check if output file exists and has content
    if filereadable(l:output_file)
        let l:response = readfile(l:output_file)

        " Show response in a new split for review
        botright new
        resize 15
        call setline(1, l:response)
        setlocal buftype=nofile
        setlocal bufhidden=wipe
        setlocal noswapfile

        echo "Review the changes. Use :ClaudeApply to apply them."

        " Store the range and response for later use
        let g:claude_last_response = l:response
        let g:claude_last_range = [a:firstline, a:lastline]
        let g:claude_last_is_selection = l:is_selection
    else
        echo "Error: No response from Claude Code"
    endif

    " Clean up temp files
    call delete(l:input_file)
endfunction

" Function to apply the last Claude response
function! ClaudeApply()
    if !exists('g:claude_last_response')
        echo "No Claude response to apply"
        return
    endif

    " Close the preview window
    execute 'pclose'

    " Go back to the original window
    wincmd p

    " Apply the changes
    if g:claude_last_is_selection
        " Replace selection
        execute g:claude_last_range[0] . ',' . g:claude_last_range[1] . 'delete'
        call append(g:claude_last_range[0] - 1, g:claude_last_response)
    else
        " Replace whole file
        %delete
        call setline(1, g:claude_last_response)
    endif

    " Clean up
    unlet g:claude_last_response
    unlet g:claude_last_range
    unlet g:claude_last_is_selection

    echo "Changes applied!"
endfunction

" Function to open Claude Code with current file as context (interactive)
function! ClaudeWithFile()
    let l:file = expand('%:p')

    if empty(l:file)
        call ClaudeOpen()
        return
    endif

    " Open Claude with file as context
    let l:cmd = 'claude "' . l:file . '"'

    if has('terminal')
        execute 'botright terminal ++close ++rows=20 ' . l:cmd
    elseif has('nvim')
        botright split
        resize 20
        execute 'terminal ' . l:cmd
    else
        execute '!' . l:cmd
    endif
endfunction

" ============================================================================
" Git Diff Integration Functions
" ============================================================================

" Function to show git diff of current file in split view
function! GitDiffFile()
    let l:file = expand('%:p')

    " Check if file exists and is in a git repo
    if empty(l:file)
        echo "No file in current buffer"
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
" Claude Code Commands
" ============================================================================

" Open Claude Code interactively
command! Claude call ClaudeOpen()

" Send current file to Claude with optional prompt
command! -nargs=* ClaudeFile call ClaudeFile(<f-args>)

" Send selection to Claude with optional prompt (requires visual selection)
command! -range -nargs=* ClaudeSelection <line1>,<line2>call ClaudeSelection(<f-args>)

" Run Claude with a specific prompt
command! -nargs=+ ClaudePrompt call ClaudePrompt(<q-args>)

" Edit code with Claude (shows result for review)
command! -range -nargs=* ClaudeEdit <line1>,<line2>call ClaudeEdit(<f-args>)

" Apply the last Claude response
command! ClaudeApply call ClaudeApply()

" Open Claude with current file as context
command! ClaudeContext call ClaudeWithFile()

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
" Claude Code Mappings
" ============================================================================
" Note: Using <Leader>ai prefix to avoid conflicts with other plugins
" (ai = Artificial Intelligence)

" Open Claude Code interactively
nnoremap <Leader>ai :Claude<CR>

" Send current file with context (interactive Claude)
nnoremap <Leader>ac :ClaudeContext<CR>

" Edit selection with Claude (visual mode)
vnoremap <Leader>ae :ClaudeEdit

" Apply last Claude response
nnoremap <Leader>aa :ClaudeApply<CR>

" Alternative: You can also just use the commands directly:
" :Claude, :ClaudeContext, :ClaudeFile, :ClaudeSelection, :ClaudePrompt, :ClaudeEdit, :ClaudeApply

" ============================================================================
" Help - Git Integration
" ============================================================================
"
" Commands:
"   :GitDiff                      - Show git diff of current file in split view
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
" Git Diff Navigation (when in diff mode):
"   ]c                            - Jump to next change
"   [c                            - Jump to previous change
"   do                            - Obtain change from other buffer
"   dp                            - Put change to other buffer
"   :diffupdate                   - Update diff highlighting
"   zo                            - Open fold
"   zc                            - Close fold
"
" Workflow Example:
"   1. Edit a file that's tracked by git
"   2. Press <Leader>gd to see changes side-by-side
"      - Left side: HEAD version (read-only)
"      - Right side: Your changes (editable)
"   3. Navigate between changes with ]c and [c
"   4. Press <Leader>gq to close diff view
"   5. Use <Leader>gs to see git status anytime
"
" ============================================================================
" Help - Terminal and Split Management
" ============================================================================
"
" Terminal Scrolling:
"   When in Claude terminal, press Esc Esc to enter Normal mode
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
" Help - Claude Code Commands
" ============================================================================
"
" Commands:
"   :Claude                       - Open Claude Code interactively
"   :ClaudeFile [prompt]          - Send current file to Claude with prompt
"   :ClaudeContext                - Open Claude with current file as context
"   :ClaudeSelection [prompt]     - Send selection to Claude (visual mode)
"   :ClaudePrompt <prompt>        - Run Claude with a specific prompt
"   :ClaudeEdit [instructions]    - Edit code with Claude (shows for review)
"   :ClaudeApply                  - Apply the last Claude response
"
" Mappings:
"   <Leader>ai                    - Open Claude Code interactively
"   <Leader>ac                    - Open Claude with file context
"   (visual) <Leader>ae           - Edit selection with Claude
"   <Leader>aa                    - Apply last Claude response
"
" Note: Most commands are better used directly via :Command syntax
"
" Workflow Examples:
"
"   1. Interactive Claude:
"      :Claude                    - Opens Claude Code in terminal
"      <Leader>ai                 - Same as above (shortcut)
"
"   2. Ask about current file:
"      :ClaudeFile what does this file do?
"      :ClaudeFile explain this code
"
"   3. Work with Claude interactively with file context:
"      :ClaudeContext             - Opens Claude with file loaded
"      <Leader>ac                 - Same as above (shortcut)
"
"   4. Edit selection:
"      (select code) :ClaudeEdit add comments
"      (select code) <Leader>ae add comments
"      Then review and :ClaudeApply (or <Leader>aa) to accept changes
"
"   5. Quick question:
"      :ClaudePrompt explain async/await in JavaScript
"
"   6. Send selection to Claude:
"      (select code) :ClaudeSelection explain this
"
" Note: Leader key is <Space> by default
"
" ============================================================================
