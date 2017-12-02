# MS dotfile - My configuration

Version 3.0! Dotfile managed by GNU stow using an Install script.

## Installation

Only tested on Debian/Ubuntu based systems.

1. `git clone --depth 1 https://github.com/mayanksuman/dotfile.git ~/.dotfile && cd ~/.dotfile`
1. `./install.sh`.
1. Use RoboMono Nerd Medium font for terminal.

## Customized VIM Mappings

* Typing `jj` in insert mode is equivalent to `Escape`.
* `fzf` for fuzzy search in current directory and 'fzh' for fuzzy search in $HOME folder.
* Easy movement between vim/tmux panes using `Ctrl+h/j/k/l`
* Easy pane resizing by `Ctrl+=`


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

## Customized tmux management

* tmux always have utf support on.
* `ta` attaches to last tmux session.
* `tns` create new tmux session.
* `tls` list all the tmux sessions.


## Included Terminal and Indic fonts

* Indic font (Sakal Bharti; License: SIL OFL 1.1) is available at [`C-Dac`](https://cdac.in/index.aspx?id=dl_sakal_bharati_font)
* RobotoMono Nerd font version 1.2.0 (MIT License) is available at [`NERD Fonts`](https://github.com/ryanoasis/nerd-fonts)

## Other Features

1. Automatically sets ZSH as default shell.
1. Uses fzf for reverse lookup of history (ctrl-R).
1. GPG support in tty
1. Improved command/alias for better tmux management
1. Better X11 forwarding in tmux ssh session.
1. Transparent editting of encrypted gpg files right from nvim/vim

## License

GNU Public License 3 except for included fonts.
