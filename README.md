# MS dotfile - My configuration

Version 1! Inspired by mutewinter, spf13, nicknishi dotfile.

## Installation
Only tested on Debian based systems.

1. `git clone http://github.com/mayanksuman/dotfile.git ~/.dotfile` && cd ~/.dotfile
1. `./install.sh`.

## Customized VIM Mappings

* Typing `jk` insert mode is equivalent to `Escape`.

And many more. See [`mappings.vim`](nvim/mappings.vim) for more.

## Installing Custom VIM Plugins

Create a new `.vim` file with the same name as the plugin you'd like to install
in [`nvim/vim_plugs/custom`](nvim/vim_plugins/custom). Then add the installation
block. For example:

`nvim/vim_plugs/custom/vim-move.vim`

```viml
if exists('g:vim_plug_installing_plugins')
  Plug 'matze/vim-move.vim'
  finish
endif

let g:move_key_modifier = 'C'
```

This example installs [`vim-move`](https://github.com/matze/vim-move).

