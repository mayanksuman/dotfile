If you are facing problem with spell check in vim, delete the old languagetools binary and then reinstall it. `vim-grammarous` package save the languagetools binary in `misc` folder. The `vim-grammarous` also download the latest binary if `misc` folder is empty.

The plugins are installed at:

1. `~/.local/share/nvim/site/pack/packer/start` or ``~/.local/share/nvim/site/pack/packer/opt` in case of `packer` package manager.
2. `~/.local/share/nvim/plugged/` in case of `vim-plug` package manager.

```
rm -iRf <plugin_install_folder>/vim-grammarous/misc
nvim +GrammarousCheck +qa
```
