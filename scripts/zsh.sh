./oh_my_zsh_install.sh
./base16-shell.sh 
curr_dir=$PWD

cd ..
cp -f zsh/template/zshrc.symlink zsh/zshrc.symlink
sed -i "/export MY_DOTFILE_FOLDER=*/c\\export MY_DOTFILE_FOLDER=$PWD" zsh/zshrc.symlink

  printf "Looking for an existing zsh config...\n"
  if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
    printf "Found ~/.zshrc. Backing up to ~/.zshrc.old\n";
    mv ~/.zshrc ~/.zshrc.old;
  fi
ln -s $(pwd)/zsh/zshrc.symlink ~/.zshrc
echo "source $(pwd)/shell_common_config">>~/.bashrc
cd $curr_dir
