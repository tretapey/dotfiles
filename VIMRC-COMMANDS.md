# 📋 VIMRC Commands Reference

> Complete guide for VSCode-like Vim configuration (without plugins)

**Leader Key:** `<Space>`

---

## 📑 Table of Contents

- [File Operations](#-file-operations)
- [Copy, Paste & Selection](#-copy-paste--selection)
- [Undo & Redo](#-undo--redo)
- [Editing](#-editing)
- [Indentation](#-indentation)
- [Window Navigation](#-window-navigation)
- [Window Management](#-window-management)
- [File Explorer](#-file-explorer)
- [Tabs](#-tabs)
- [File Search](#-file-search)
- [Buffer Management](#-buffer-management)
- [Search & Highlighting](#-search--highlighting)
- [Terminal Integration](#-terminal-integration)
- [Git Integration](#-git-integration)
- [Auto-Pairs](#-auto-pairs)
- [Auto-Complete](#-auto-complete)
- [Visual Features](#-visual-features)
- [Advanced Features](#-advanced-features)

---

## 💾 File Operations

| Keybinding | Description |
|------------|-------------|
| `Esc Esc` | Save file (all modes) |
| `Ctrl+S` | Save file (normal, insert, visual) |
| `:w` | Save file (command mode) |
| `:q` | Quit |
| `:wq` | Save and quit |
| `:qa` | Quit all windows |
| `:e <file>` | Edit/open file |

---

## 📋 Copy, Paste & Selection

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<Leader>y` | Normal/Visual | Copy to system clipboard |
| `<Leader>p` | Normal/Visual | Paste from system clipboard |
| `Ctrl+C` | Visual | Copy selection to clipboard |
| `Ctrl+X` | Visual | Cut selection to clipboard |
| `Ctrl+V` | Normal/Insert | Paste from clipboard |
| `<Leader>a` | Normal | Select all (ggVG) |
| `yy` | Normal | Yank (copy) current line |
| `dd` | Normal | Delete (cut) current line |
| `p` | Normal | Paste after cursor |
| `P` | Normal | Paste before cursor |

---

## ↩️ Undo & Redo

| Keybinding | Mode | Description |
|------------|------|-------------|
| `Ctrl+Z` | Normal/Insert | Undo |
| `Ctrl+Y` | Normal/Insert | Redo |
| `u` | Normal | Undo (native) |
| `Ctrl+R` | Normal | Redo (native) |

**Note:** Persistent undo enabled - history saved in `~/.vim/undo/`

---

## ✏️ Editing

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<Leader>d` | Normal | Duplicate current line |
| `<Leader>d` | Visual | Duplicate selection |
| `Alt+Up` | Normal | Move line up |
| `Alt+Down` | Normal | Move line down |
| `Alt+Up` | Visual | Move selection up |
| `Alt+Down` | Visual | Move selection down |
| `<Leader>/` | Normal/Visual | Toggle line comment (language-aware) |
| `<Leader>*` | Normal | Multi-cursor mode (cgn - use `.` to repeat) |
| `.` | Normal | Repeat last command |

### Comment Styles by File Type

- **JavaScript/TypeScript/C/C++/Java/Rust:** `//`
- **Python/Ruby/Shell/Bash:** `#`
- **Vim:** `"`

---

## 🔢 Indentation

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<` | Visual | De-indent (keeps selection) |
| `>` | Visual | Indent (keeps selection) |
| `Tab` | Visual | Indent (keeps selection) |
| `Shift+Tab` | Visual | De-indent (keeps selection) |
| `==` | Normal | Auto-indent current line |
| `gg=G` | Normal | Auto-indent entire file |

**Settings:**
- Tab width: 2 spaces
- Auto-indent enabled
- Smart indent enabled

---

## 🪟 Window Navigation

| Keybinding | Mode | Description |
|------------|------|-------------|
| `Ctrl+H` | Normal | Move to left window |
| `Ctrl+J` | Normal | Move to window below |
| `Ctrl+K` | Normal | Move to window above |
| `Ctrl+L` | Normal | Move to right window |
| `<Leader>w` | Normal | Window command prefix (same as `Ctrl+W`) |
| `Ctrl+W s` | Normal | Split horizontal |
| `Ctrl+W v` | Normal | Split vertical |
| `Ctrl+W c` | Normal | Close current window |
| `Ctrl+W o` | Normal | Close all other windows |

**From Terminal Mode:** Use same `Ctrl+H/J/K/L` to navigate out of terminal

---

## 🔍 Window Management

| Keybinding | Description |
|------------|-------------|
| `<Leader>z` | Toggle zoom (maximize/restore current window) |
| `<Leader>=` | Equalize all window sizes |
| `<Leader>_` | Maximize window vertically |
| `<Leader>\|` | Maximize window horizontally |
| `Ctrl+W +` | Increase window height |
| `Ctrl+W -` | Decrease window height |
| `Ctrl+W >` | Increase window width |
| `Ctrl+W <` | Decrease window width |

**Settings:**
- New splits open below (horizontal)
- New splits open right (vertical)

---

## 📁 File Explorer

| Keybinding | Description |
|------------|-------------|
| `<Leader>e` | Toggle file explorer (Lexplore - tree view) |

### Explorer Navigation

| Key | Action |
|-----|--------|
| `Enter` | Open file/directory |
| `i` | Toggle file details |
| `s` | Sort by different criteria |
| `-` | Go up a directory |
| `%` | Create new file |
| `d` | Create new directory |
| `D` | Delete file/directory |
| `R` | Rename file/directory |

**Settings:**
- No banner
- Tree view (style 3)
- 25% window width
- Opens in previous window

---

## 🏷️ Tabs

| Keybinding | Description |
|------------|-------------|
| `<Leader>t` | Open new tab (prompts for file) |
| `Ctrl+Tab` | Next tab |
| `Ctrl+Shift+Tab` | Previous tab |
| `:tabnew` | New empty tab |
| `:tabc` | Close current tab |
| `gt` | Next tab (native) |
| `gT` | Previous tab (native) |
| `1gt` | Go to tab 1 |
| `2gt` | Go to tab 2 (etc.) |

---

## 🔎 File Search

| Keybinding | Description |
|------------|-------------|
| `<Leader>f` | Find file by name (`:find`) |
| `<Leader>F` | Search in file contents (`:grep -R`) |

**Settings:**
- Searches recursively in subdirectories (`path+=**`)
- Wildmenu enabled for file completion

**Examples:**
```vim
<Leader>f config.json    " Find config.json
<Leader>F TODO           " Search for "TODO" in all files
```

---

## 📄 Buffer Management

| Keybinding | Description |
|------------|-------------|
| `<Leader>b` | Switch to buffer (prompts for buffer number/name) |
| `<Leader>gn` | Go to next buffer |
| `<Leader>gp` | Go to previous buffer |
| `<Leader>bd` | Close/delete current buffer |
| `:ls` | List all buffers |
| `:b <number>` | Switch to buffer by number |
| `:b <name>` | Switch to buffer by name (tab completion) |

**Settings:**
- Hidden buffers enabled (switch without saving)

---

## 🔦 Search & Highlighting

| Keybinding | Description |
|------------|-------------|
| `<Leader><Space>` | Clear search highlighting |
| `Esc` | Clear search highlighting + normal Esc |
| `<Leader>n` | Toggle line numbers (number + relativenumber) |
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` | Next search result |
| `N` | Previous search result |
| `*` | Search word under cursor forward |
| `#` | Search word under cursor backward |

**Settings:**
- Incremental search (shows matches as you type)
- Smart case sensitivity (case-insensitive unless uppercase used)
- Search wraps around file

---

## 💻 Terminal Integration

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<Leader>tt` | Normal | Open terminal (horizontal split, 15 lines) |
| `<Leader>tv` | Normal | Open terminal (vertical split) |
| `Esc Esc` | Terminal | Exit terminal mode (enter Normal mode) |
| `Ctrl+H/J/K/L` | Terminal | Navigate from terminal to other windows |
| `i` or `a` | Normal (in terminal) | Return to terminal mode |

**Vim Terminal:**
```vim
:terminal              " Open terminal in current window
:botright terminal     " Open terminal at bottom
:vertical terminal     " Open terminal vertically
```

**Features:**
- Terminal starts in Insert mode (Neovim only)
- Easy navigation with Ctrl+H/J/K/L from terminal
- Esc Esc to scroll/search terminal output

**Workflow:**
1. Press `<Leader>tt` to open terminal
2. Run your commands
3. Press `Esc Esc` to scroll through output
4. Press `i` to return to terminal mode
5. Use `Ctrl+W c` or `:q` to close terminal

---

## 🔧 Git Integration

### Git Keybindings

| Keybinding | Description |
|------------|-------------|
| `<Leader>gd` | Show git diff of current file |
| `<Leader>gq` | Close git diff view |
| `<Leader>gs` | Show git status |
| `<Leader>ga` | Show all git changes (git diff all) |

### Git Commands

| Command | Description |
|---------|-------------|
| `:GitDiff` | Show diff of current file (or list if no file open) |
| `:GitDiffClose` | Close git diff view |
| `:GitStatus` | Show git status in split |
| `:GitDiffAll` | Show all repository changes |

### Git Diff Navigation

| Keybinding | Description |
|------------|-------------|
| `]c` | Jump to next change |
| `[c` | Jump to previous change |
| `do` | Diff obtain (get change from other buffer) |
| `dp` | Diff put (put change to other buffer) |
| `:diffupdate` | Update diff highlighting |
| `zo` | Open fold |
| `zc` | Close fold |

### Git List Navigation

When viewing list of changed files:

| Key | Action |
|-----|--------|
| `j`/`k` or `↑`/`↓` | Navigate files |
| `Enter` | Open file and show diff |
| `q` or `Esc` | Close list |

### Git Workflow Examples

**View specific file changes:**
```vim
1. Edit a git-tracked file
2. Press <Leader>gd
   - Left: HEAD version (read-only)
   - Right: Your changes (editable)
3. Navigate with ]c and [c
4. Press <Leader>gq to close
```

**Browse all changes:**
```vim
1. Press <Leader>gd (with no file open)
2. Use j/k to navigate file list
3. Press Enter to view diff
4. Press <Leader>gq to close
5. Repeat for other files
```

---

## ⌨️ Auto-Pairs

**Insert Mode Only:**

| Keybinding | Result |
|------------|--------|
| `(` | `()`  with cursor in middle |
| `[` | `[]`  with cursor in middle |
| `{` | `{}`  with cursor in middle |
| `"` | `""`  with cursor in middle |
| `'` | `''`  with cursor in middle |
| `` ` `` | `` `` `` with cursor in middle |

### Special Auto-Pair Behaviors

| Keybinding | Behavior |
|------------|----------|
| `Backspace` | Delete entire empty pair |
| `Tab` | Jump out of brackets/quotes |
| `}` | Smart closing brace (auto-formats blocks) |

**Example:**
```javascript
// Type: function test(
function test(|)  // cursor at |

// Type: {
function test() {
  |               // cursor auto-indented
}

// Backspace on empty () deletes both
function test|    // after backspace
```

---

## 💡 Auto-Complete

**Automatic Completion Menu** (IntelliSense-style)

| Keybinding | Description |
|------------|-------------|
| `Ctrl+N` | Next completion |
| `Ctrl+P` | Previous completion |
| `Enter` | Accept completion |
| `Ctrl+E` | Cancel completion |

**Settings:**
- Shows menu with 1 match
- Longest common match highlighted
- Preview window shows details
- Maximum 10 items visible
- Spell checking included

**Manual Completion:**
```vim
Ctrl+X Ctrl+F    " File names
Ctrl+X Ctrl+L    " Whole lines
Ctrl+X Ctrl+O    " Omni completion (context-aware)
Ctrl+X Ctrl+N    " Keywords
```

---

## 🎨 Visual Features

### Display Settings

- ✅ Line numbers + relative numbers
- ✅ Sign column always visible (for git markers, etc.)
- ✅ Current line highlighted
- ✅ Current column highlighted
- ✅ Scroll offset: 8 lines above/below cursor
- ✅ Fold column visible
- ✅ Status line always shown
- ✅ No visual bell or error bells

### Status Line

Custom status line showing:
- Current mode (NORMAL/INSERT/VISUAL/etc.)
- File path
- Modified flag
- File type
- Encoding
- File format
- Position (percentage, line:column)

### Color Scheme

Uses terminal colors - customize your terminal theme for best results.

---

## 💾 Advanced Features

### Persistent Undo
- ✅ Unlimited undo history
- ✅ Survives vim restarts
- ✅ Stored in `~/.vim/undo/`
- 1000 undo levels
- 10000 lines to reload

### File Management
- ✅ Auto-reload files modified externally
- ✅ Auto-reload vimrc when saved
- ✅ Return to last edit position when opening files
- ✅ Trim trailing whitespace on save
- ✅ Auto-close preview window after completion
- ❌ No backup files
- ❌ No swap files

### Folding
- Method: Based on indentation
- Max nesting: 3 levels
- Start: All folds open
- Column: Visible

**Fold Commands:**
```vim
zo    " Open fold
zc    " Close fold
za    " Toggle fold
zR    " Open all folds
zM    " Close all folds
```

### Smart Features
- Confirm dialog for unsaved changes
- Fast update time (300ms)
- Fast key sequence timeout (500ms)
- System clipboard integration
- Enhanced command-line completion
- Smart case-sensitive search

---

## 📊 Quick Reference Card

### Most Used Commands

```vim
SAVE & QUIT
  Ctrl+S          Save
  :wq             Save & quit

EDIT
  <Leader>d       Duplicate line
  <Leader>/       Comment
  Alt+↑/↓         Move line

NAVIGATE
  Ctrl+H/J/K/L    Window nav
  <Leader>gn/gp   Buffer nav
  <Leader>e       File explorer

TERMINAL
  <Leader>tt      Open terminal
  Esc Esc         Exit terminal

GIT
  <Leader>gd      Git diff
  <Leader>gs      Git status
  ]c / [c         Next/prev change

WINDOW
  <Leader>z       Zoom toggle
  <Leader>=       Equalize

SEARCH
  <Leader>f       Find file
  <Leader>F       Grep files
  <Leader><Space> Clear highlight
```

---

## 🎯 Differences from Default Vim

### Added VSCode-like Features
- ✅ Ctrl+S to save
- ✅ Ctrl+Z/Y for undo/redo
- ✅ Ctrl+C/X/V for clipboard
- ✅ Alt+Up/Down to move lines
- ✅ Line duplication
- ✅ Auto-pairs for brackets
- ✅ Smart indentation in visual mode
- ✅ Terminal integration with easy navigation
- ✅ Enhanced git diff views
- ✅ Status line with mode indicator
- ✅ Relative line numbers
- ✅ Persistent undo
- ✅ Auto-trim whitespace

### Removed/Changed
- ❌ No Claude Code integration
- ✅ `<Leader>bd` for buffer delete (was `<Leader>gd`)
- ✅ `<Leader>gd` now exclusively for git diff

---

## 🔥 Pro Tips

1. **Multi-cursor simulation:** Press `<Leader>*` on a word, then `.` to change next occurrence
2. **Terminal workflow:** `<Leader>tt` → run commands → `Esc Esc` → scroll output → `i` to continue
3. **Git diff workflow:** `<Leader>gd` → `]c`/`[c]` to navigate → `<Leader>gq` to close
4. **Quick edit:** `<Leader>e` for explorer, `<Leader>f` to find files, `<Leader>F` to grep
5. **Window management:** `<Leader>z` to zoom, `Ctrl+H/J/K/L` to navigate
6. **Persistent undo:** Even after closing vim, you can undo changes from previous sessions!
7. **Buffer vs Tab:** Buffers are lighter - use `<Leader>gn/gp` instead of tabs when possible
8. **Smart search:** Type `/pattern` with lowercase = case-insensitive, with uppercase = case-sensitive

---

## 🆘 Help

### Getting Help
```vim
:help <topic>      " Help on specific topic
:help <Leader>     " Help on leader key
:help terminal     " Help on terminal
:help buffers      " Help on buffers
:help windows      " Help on windows
```

### Common Issues

**Terminal not working?**
- Check `:echo has('terminal')` (should return 1)
- For Neovim: `:echo has('nvim')` (should return 1)

**Clipboard not working?**
- Check `:echo has('clipboard')` (should return 1)
- Install `vim-gtk3` or `gvim` for clipboard support

**Auto-pairs interfering?**
- Can be disabled by removing the auto-pair mappings from vimrc

---

## 📝 Configuration File Location

```bash
# Vim
~/.vimrc
# or
~/dotfiles/vimrc

# Neovim
~/.config/nvim/init.vim
```

---

## 🚀 Getting Started

1. **Save the vimrc:**
   ```bash
   ln -s ~/dotfiles/vimrc ~/.vimrc
   ```

2. **Open vim:**
   ```bash
   vim
   ```

3. **Try basic commands:**
   - Press `<Leader>tt` to open terminal (Leader = Space)
   - Press `<Leader>e` to open file explorer
   - Press `Ctrl+S` to save
   - Edit a file and press `<Leader>/` to comment

4. **Learn gradually:**
   - Start with basic navigation (Ctrl+H/J/K/L)
   - Learn file operations (Ctrl+S, <Leader>e)
   - Add terminal workflow (<Leader>tt)
   - Master git integration (<Leader>gd)

---

**Version:** 2.0 - VSCode-like Behavior (No Plugins)
**Last Updated:** 2025-11-05
**Conflicts:** None ✅

---

Made with ❤️ for a better Vim experience
