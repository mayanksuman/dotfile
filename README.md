# MS dotfile - My configuration

Version 3.0! Dotfile managed by GNU stow using an ansible-playbook.

## Installation

Only tested on Debian/Ubuntu and Fedora based systems.

1. `git clone --depth 1 https://github.com/mayanksuman/dotfile.git ~/.dotfile && cd ~/.dotfile`
1. `./bootstrap.sh`
1. Use Fira Code font for terminal.

## Customized neovim Mappings

* Typing `jj` in insert mode is equivalent to `Escape`.
* `fzf` for fuzzy search in current directory and 'fzh' for fuzzy search in $HOME folder.
* Easy movement between vim/tmux panes using `Ctrl+h/j/k/l`
* Easy pane resizing by `Ctrl+=`


And many more. See [`mappings.vim`](roles/nvim/payload/.config/nvim/lua/mappings.lua) for more.

## Installing Custom VIM Plugins

Create a new `.vim` file with the same name as the plugin you'd like to install
in [`~/.config/nvim/vim_plugins/custom`](nvim/.config/nvim/vim_plugins/custom). Then add the installation
block. For example:

`nvim/vim_plugins/custom/vim-move.vim`

```viml
if exists('g:vim_plug_installing_plugins')
  Plug 'matze/vim-move.vim'
  finish
endif

let g:move_key_modifier = 'C'
```

This example installs [`vim-move`](https://github.com/matze/vim-move).

## Customized tmux management

* tmux always have utf support on.
* `ta` attaches to last tmux session.
* `tns` create new tmux session.
* `tls` list all the tmux sessions.


## Included fonts

* Indic font (Sakal Bharti; License: SIL OFL 1.1) is available at [`C-Dac`](https://cdac.in/index.aspx?id=dl_sakal_bharati_font)

## Other Features

1. Automatically sets ZSH as default shell.
1. Uses fzf for reverse lookup of history (ctrl-R).
1. GPG support in tty
1. Improved command/alias for better tmux management
1. Better X11 forwarding in tmux ssh session.
1. Transparent editting of encrypted gpg files right from nvim/vim

## License

GNU Public License v3 (GPLv3) except for included fonts.
