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
" Help for Claude Code commands
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
