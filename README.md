# dotfiles

Starting my list of dotfiles and others

## Files and Instructions

### vimrc (dotfile)

Install VIM with your package manager.

Create/Copy vimrc file (I use VIM): `vim ~/.vimrc`

Features:
- You can use VIM sessions: Space-S to create or rewrite session; Space-s to source session
- Space-e to toggle netrw file explorer
- Space-y to copy to system clipboard and Space-p to paste from system clipboard
- Check more comments and mapping into the .vimrc file...

### install.sh (bash script)

This script will install some usefull vim plugins

Create pack folder: `mkdir ~/.vim/pack`

Put install.sh file into that folder

Give permissions: `chmod +x ~/.vim/pack/install.sh`

Run script: `~/.vim/pack/install.sh`

NOTE: Every time you want to update your plugins run the script again.

### tmux.conf (dotfile)

Install tmux with your package manager

Create/Copy tmux.conf: `vim ~/.tmux.conf`
