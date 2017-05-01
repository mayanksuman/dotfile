# MS dotfile - My configuration

Version 2.1! Dotfile managed by GNU stow using an Install script. It is being migrated to GNU stow. Install script is complete, uninstall script need some love and time.

## Installation
Only tested on Debian/Ubuntu based systems.

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

## Other Features
1. Automatically sets ZSH as default shell.
1. Uses fzf for reverse lookup of history (ctrl-R).
1. Better DISPLAY variable forwarding in tmux ssh session.
1. Transparent editting of encrypted gpg files right from nvim/vim
