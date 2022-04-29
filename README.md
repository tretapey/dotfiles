# dotfiles

Starting my list of dotfiles and others

## Files and Instructions

### vimrc (dotfile)

Install VIM with your package manager.

Create/Copy vimrc file (I use VIM): `vim ~/.vimrc`

### init.vim

Install neovim with package manager

Create/Copy init.vim into `~/.config/nvim/init.vim`

Optional install coc.vim for completion, github copilot for IA help and vim-polyglot for language syntax

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

