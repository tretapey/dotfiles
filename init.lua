-- ============================================================================
-- Neovim Configuration — Ported from .vimrc
-- ============================================================================

-- Leader key (must be set before any mappings)
vim.g.mapleader = " "

-- ============================================================================
-- Basic Settings
-- ============================================================================

-- Display
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.title = true
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.laststatus = 2
vim.opt.showcmd = true
vim.opt.ruler = true
vim.opt.visualbell = true
vim.opt.errorbells = false

-- Encoding
vim.opt.encoding = "utf-8"
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.ttimeoutlen = 50

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.wrapscan = true

-- Behavior
vim.opt.hidden = true
vim.opt.wildmenu = true
vim.opt.wildmode = { "list:longest", "full" }
vim.opt.wildignore:append({
  "*/node_modules/*", "*/.git/*", "*/dist/*", "*/build/*", "*/.next/*",
  "*.o", "*.obj", "*.pyc", "*.class", "*.jar", "*.swp", "*.swo",
  "*.jpg", "*.png", "*.gif", "*.ico", "*.pdf", "*.DS_Store",
})
vim.opt.path:append("**")
vim.opt.confirm = true
vim.opt.autoread = true
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500

-- Folding
vim.opt.foldmethod = "indent"
vim.opt.foldnestmax = 3
vim.opt.foldlevelstart = 99
vim.opt.foldcolumn = "1"

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.fillchars:append({ vert = "|" })

-- Persistent Undo
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000
local undodir = vim.fn.expand("~/.vim/undo")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p", 0700)
end
vim.opt.undodir = undodir

-- Backup and Swap
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Completion
vim.opt.completeopt = { "menuone", "longest", "preview" }
vim.opt.complete:append("kspell")
vim.opt.shortmess:append("c")
vim.opt.pumheight = 10

-- ============================================================================
-- Filetype Detection
-- ============================================================================

vim.filetype.add({
  extension = {
    svelte = "svelte",
    vue = "vue",
    tf = "terraform",
    tfvars = "terraform",
    gotmpl = "gotmpl",
    tmpl = "gotmpl",
  },
})

-- ============================================================================
-- Netrw Configuration
-- ============================================================================

vim.g.netrw_banner = 0
vim.g.netrw_altv = 1
vim.g.netrw_list_hide = [[,\(^\|\s\s\)\zs\.\S\+]]
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4
vim.g.netrw_winsize = 25

-- ============================================================================
-- Keymaps
-- ============================================================================

local map = vim.keymap.set

-- Quick save
map({ "n", "v" }, "<Esc><Esc>", ":w<CR>", { desc = "Save file" })
map("n", "<C-s>", ":w<CR>", { desc = "Save file" })
map("i", "<C-s>", "<Esc>:w<CR>a", { desc = "Save file" })
map("v", "<C-s>", "<Esc>:w<CR>gv", { desc = "Save file" })

-- Select all
map("n", "<Leader>a", "ggVG", { desc = "Select all" })

-- Undo/Redo
map("n", "<C-z>", "u")
map("i", "<C-z>", "<C-o>u")
map("n", "<C-y>", "<C-r>")
map("i", "<C-y>", "<C-o><C-r>")

-- Duplicate line
map("n", "<Leader>d", ":t.<CR>", { desc = "Duplicate line" })
map("v", "<Leader>d", "y'>p", { desc = "Duplicate selection" })

-- Move lines up/down
map("n", "<A-Up>", ":m .-2<CR>==", { silent = true })
map("n", "<A-Down>", ":m .+1<CR>==", { silent = true })
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { silent = true })
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { silent = true })

-- Better indenting in visual mode
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "<Tab>", ">gv")
map("v", "<S-Tab>", "<gv")

-- Window navigation
map("n", "<Leader>w", "<C-w>", { desc = "Window prefix" })
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- File explorer
map("n", "<Leader>e", ":Lexplore<CR>", { desc = "Toggle file explorer" })

-- Tabs
map("n", "<Leader>t", ":tabedit ", { desc = "New tab" })
map("n", "<Leader>]", ":tabnext<CR>", { desc = "Next tab" })
map("n", "<Leader>[", ":tabprev<CR>", { desc = "Previous tab" })

-- Fuzzy find
map("n", "<Leader>f", ":find ", { desc = "Find file" })

-- Buffers
map("n", "<Leader>b", ":buffer ", { desc = "Switch buffer" })
map("n", "<Leader>gn", ":bn<CR>", { desc = "Next buffer" })
map("n", "<Leader>gp", ":bp<CR>", { desc = "Previous buffer" })
map("n", "<Leader>bd", ":bd<CR>", { desc = "Delete buffer" })

-- Search in files
map("n", "<Leader>F", function()
  local pattern = vim.fn.input("Grep: ")
  if pattern == "" then return end
  vim.cmd("grep " .. pattern)
  vim.cmd("copen")
  vim.fn.setreg("/", pattern)
  vim.opt.hlsearch = true
end, { desc = "Grep in files" })
map("n", "<Leader>co", ":copen<CR>", { desc = "Open quickfix list" })
map("n", "<Leader>cc", ":cclose<CR>", { desc = "Close quickfix list" })
map("n", "]q", ":cnext<CR>", { desc = "Next quickfix result" })
map("n", "[q", ":cprev<CR>", { desc = "Previous quickfix result" })

-- Clear search highlighting
map("n", "<Leader><Space>", ":nohlsearch<CR>", { silent = true })
map("n", "<Esc>", ":nohlsearch<CR><Esc>", { silent = true })

-- Toggle line numbers
map("n", "<Leader>n", ":set number!<CR>", { desc = "Toggle line numbers" })

-- Copy/paste with system clipboard
map({ "n", "v" }, "<Leader>y", '"*y', { desc = "Copy to clipboard" })
map("n", "<Leader>p", '"*p', { desc = "Paste from clipboard" })
map("n", "<Leader>P", '"*P', { desc = "Paste before from clipboard" })
map("v", "<Leader>p", '"*p', { desc = "Paste from clipboard" })

-- Multi-cursor simulation
map("n", "<Leader>*", "*Ncgn", { desc = "Change next occurrence" })

-- Zoom toggle
map("n", "<Leader>z", function()
  if vim.t.zoomed then
    vim.cmd(vim.t.zoom_winrestcmd)
    vim.t.zoomed = false
  else
    vim.t.zoom_winrestcmd = vim.fn.winrestcmd()
    vim.cmd("resize | vertical resize")
    vim.t.zoomed = true
  end
end, { desc = "Toggle zoom" })

-- Quick split resizing
map("n", "<Leader>=", "<C-w>=", { desc = "Equalize splits" })
map("n", "<Leader>_", "<C-w>_", { desc = "Maximize vertically" })
map("n", "<Leader>|", "<C-w>|", { desc = "Maximize horizontally" })

-- ============================================================================
-- Auto-Pairs (basic, no plugin)
-- ============================================================================

map("i", "(", "()<Left>")
map("i", "[", "[]<Left>")
map("i", "{", "{}<Left>")

-- Smart quotes: don't auto-pair inside words (e.g. it's, don't)
local function smart_quote(char)
  local col = vim.fn.col(".") - 1
  local prev = col > 0 and vim.fn.getline("."):sub(col, col) or ""
  if prev:match("%w") then
    return char
  end
  return char .. char .. "<Left>"
end

map("i", '"', function() return smart_quote('"') end, { expr = true })
map("i", "'", function() return smart_quote("'") end, { expr = true })

-- Smart backtick: don't auto-pair in markdown
map("i", "`", function()
  if vim.bo.filetype == "markdown" then
    return "`"
  end
  return smart_quote("`")
end, { expr = true })

-- Smart deletion of auto-pairs
map("i", "<BS>", function()
  local line = vim.fn.getline(".")
  local col = vim.fn.col(".") - 1
  local prev = line:sub(col, col)
  local next = line:sub(col + 1, col + 1)

  local pairs = { ["("] = ")", ["["] = "]", ["{"] = "}", ['"'] = '"', ["'"] = "'", ["`"] = "`" }
  if pairs[prev] == next then
    return "<Right><BS><BS>"
  end
  return "<BS>"
end, { expr = true })

-- Jump out of brackets with Ctrl+L
map("i", "<C-l>", function()
  if vim.fn.search([=[\%#[]>)}'"`]]=], "n") > 0 then
    return "<Right>"
  end
  return "<C-l>"
end, { expr = true })

-- Smart closing brace
map("i", "}", function()
  local col = vim.fn.col(".")
  local prev = vim.fn.getline("."):sub(col - 2, col - 2)
  if prev == "{" then
    return "}<Left><CR><CR><Up><Tab>"
  end
  return "}"
end, { expr = true })

-- ============================================================================
-- Comment Toggle
-- ============================================================================

local comment_strings = {
  javascript = "// ", typescript = "// ", typescriptreact = "// ", javascriptreact = "// ",
  c = "// ", cpp = "// ", java = "// ", rust = "// ", go = "// ",
  svelte = "// ", vue = "// ",
  python = "# ", ruby = "# ", sh = "# ", bash = "# ", zsh = "# ",
  yaml = "# ", terraform = "# ", conf = "# ",
  vim = '" ', lua = "-- ", css = "/* ", scss = "/* ",
}

local function get_comment_str()
  return comment_strings[vim.bo.filetype] or "# "
end

local function toggle_comment(line1, line2)
  local cs = get_comment_str()
  local ecs = vim.pesc(cs)
  local first_line = vim.fn.getline(line1)

  if first_line:match("^%s*" .. ecs) then
    -- Uncomment
    vim.cmd(string.format("silent! %d,%ds/^\\(\\s*\\)%s/\\1/e", line1, line2, vim.fn.escape(cs, "/")))
  else
    -- Comment
    vim.cmd(string.format("silent! %d,%ds/^\\(\\s*\\)/\\1%s/e", line1, line2, vim.fn.escape(cs, "/")))
  end
  vim.cmd("nohlsearch")
end

map("n", "<Leader>/", function()
  local line = vim.fn.line(".")
  toggle_comment(line, line)
end, { desc = "Toggle comment" })

map("v", "<Leader>/", function()
  -- Get visual selection range
  local line1 = vim.fn.line("'<")
  local line2 = vim.fn.line("'>")
  toggle_comment(line1, line2)
end, { desc = "Toggle comment" })

-- ============================================================================
-- Terminal Integration
-- ============================================================================

map("n", "<Leader>tt", ":botright split | resize 15 | terminal<CR>", { desc = "Open terminal (horizontal)" })
map("n", "<Leader>tv", ":botright vsplit | terminal<CR>", { desc = "Open terminal (vertical)" })

-- Terminal mode: exit with Esc Esc, navigate with Ctrl+hjkl
map("t", "<Esc><Esc>", [[<C-\><C-n>]])
map("t", "<C-h>", [[<C-\><C-n><C-w>h]])
map("t", "<C-j>", [[<C-\><C-n><C-w>j]])
map("t", "<C-k>", [[<C-\><C-n><C-w>k]])
map("t", "<C-l>", [[<C-\><C-n><C-w>l]])

-- Start terminal in insert mode
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.cmd("startinsert")
  end,
})

-- ============================================================================
-- Statusline
-- ============================================================================

local mode_names = {
  n = "NORMAL", v = "VISUAL", V = "V-LINE", ["\22"] = "V-BLOCK",
  i = "INSERT", R = "REPLACE", s = "SELECT", S = "SELECT",
  t = "TERMINAL", c = "COMMAND", ["!"] = "SHELL",
}

function StatuslineMode()
  return mode_names[vim.fn.mode()] or vim.fn.mode():upper()
end

vim.opt.statusline = table.concat({
  "%#PmenuSel#",
  " %{v:lua.StatuslineMode()} ",
  "%#LineNr#",
  " %f",
  " %m",
  " %r",
  "%=",
  "%#CursorColumn#",
  " %y",
  " %{&fileencoding?&fileencoding:&encoding}",
  " [%{&fileformat}]",
  " %p%%",
  " %l:%c ",
})

-- ============================================================================
-- Git Integration
-- ============================================================================

-- Show interactive list of changed files
local function git_diff_list()
  local git_check = vim.fn.system("git rev-parse --git-dir 2>/dev/null")
  if vim.v.shell_error ~= 0 then
    print("Not in a git repository")
    return
  end

  local changed = vim.fn.system("git diff HEAD --name-only")
  if vim.v.shell_error ~= 0 then
    print("Error getting changed files")
    return
  end
  if changed == "" then
    print("No changes in repository")
    return
  end

  local files = vim.split(vim.trim(changed), "\n")

  vim.cmd("botright new | resize 15")
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.swapfile = false
  vim.wo.cursorline = true

  local lines = {
    "# Changed Files (press Enter to view diff, q to close)",
    "# Use j/k to navigate",
    "",
  }
  for _, f in ipairs(files) do
    table.insert(lines, f)
  end
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.bo.modifiable = false
  vim.fn.cursor(4, 1)

  vim.cmd([[
    syntax match gitDiffListHeader "^#.*"
    syntax match gitDiffListFile "^[^#].*"
    highlight gitDiffListHeader ctermfg=cyan guifg=cyan
    highlight gitDiffListFile ctermfg=yellow guifg=yellow
  ]])

  map("n", "<CR>", function()
    local line = vim.fn.getline(".")
    if line:match("^#") or line == "" then return end
    local file = vim.trim(line)
    vim.cmd("quit")
    vim.cmd("edit " .. vim.fn.fnameescape(file))
    vim.cmd("GitDiff")
  end, { buffer = true })
  map("n", "q", ":q<CR>", { buffer = true })
  map("n", "<Esc>", ":q<CR>", { buffer = true })
end

-- Show git diff of current file in split view
local function git_diff_file()
  local file = vim.fn.expand("%:p")
  if file == "" then
    git_diff_list()
    return
  end

  local git_check = vim.fn.system("git ls-files --error-unmatch " .. vim.fn.shellescape(file) .. " 2>/dev/null")
  if vim.v.shell_error ~= 0 then
    print("File is not tracked by git")
    return
  end

  local git_path = vim.trim(vim.fn.system("git ls-files --full-name " .. vim.fn.shellescape(file)))

  local diff_check = vim.fn.system("git diff HEAD -- " .. vim.fn.shellescape(file))
  if diff_check == "" then
    print("No changes in current file")
    return
  end

  local head_content = vim.fn.system("git show HEAD:" .. git_path)
  if vim.v.shell_error ~= 0 then
    print("Error getting HEAD version")
    return
  end

  vim.cmd("leftabove vnew")
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.swapfile = false
  vim.bo.readonly = true

  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(head_content, "\n"))
  vim.bo.modifiable = false

  vim.cmd("silent file [HEAD]\\ " .. vim.fn.fnamemodify(file, ":t"))
  vim.cmd("diffthis")
  vim.cmd("wincmd l")
  vim.cmd("diffthis")
  print("Showing git diff. Use :GitDiffClose or <Leader>gq to close")
end

-- Close git diff view
local function git_diff_close()
  vim.cmd("diffoff!")
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.fn.bufname(buf):match("^%[HEAD%]") then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
  print("Git diff closed")
end

-- Show git status
local function git_status()
  local status = vim.fn.system("git status")
  if vim.v.shell_error ~= 0 then
    print("Not in a git repository")
    return
  end

  vim.cmd("botright new | resize 15")
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.swapfile = false

  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(status, "\n"))
  vim.bo.modifiable = false

  vim.cmd([[
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
  ]])

  map("n", "q", ":q<CR>", { buffer = true })
end

-- Show all git changes
local function git_diff_all()
  local diff = vim.fn.system("git diff HEAD")
  if vim.v.shell_error ~= 0 then
    print("Error getting git diff")
    return
  end
  if diff == "" then
    print("No changes in repository")
    return
  end

  vim.cmd("botright new | resize 20")
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.swapfile = false

  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(diff, "\n"))
  vim.bo.modifiable = false
  vim.bo.filetype = "diff"

  map("n", "q", ":q<CR>", { buffer = true })
end

-- Git commands
vim.api.nvim_create_user_command("GitDiff", function() git_diff_file() end, {})
vim.api.nvim_create_user_command("GitDiffClose", function() git_diff_close() end, {})
vim.api.nvim_create_user_command("GitStatus", function() git_status() end, {})
vim.api.nvim_create_user_command("GitDiffAll", function() git_diff_all() end, {})

-- Git keymaps
map("n", "<Leader>gd", ":GitDiff<CR>", { desc = "Git diff current file" })
map("n", "<Leader>gq", ":GitDiffClose<CR>", { desc = "Close git diff" })
map("n", "<Leader>gs", ":GitStatus<CR>", { desc = "Git status" })
map("n", "<Leader>ga", ":GitDiffAll<CR>", { desc = "Git diff all" })

-- ============================================================================
-- Autocommands
-- ============================================================================

local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- Return to last edit position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- No auto-comment on new lines
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Auto-close preview window after completion
vim.api.nvim_create_autocmd("CompleteDone", {
  group = augroup,
  command = "pclose",
})

-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  command = [[%s/\s\+$//e]],
})

-- Auto-reload config on save
vim.api.nvim_create_autocmd("BufWritePost", {
  group = augroup,
  pattern = vim.fn.expand("$MYVIMRC"),
  command = "source $MYVIMRC",
})

-- ============================================================================
-- Tree-sitter Highlighting
-- ============================================================================

-- Enable tree-sitter highlighting for filetypes with an installed parser
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- ============================================================================
-- Load Plugins
-- ============================================================================

require("plugins")
