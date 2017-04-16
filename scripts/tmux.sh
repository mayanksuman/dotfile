main() {
	# Use colors, but only if connected to a terminal, and that terminal
	# supports them.
	if which tput >/dev/null 2>&1; then
		ncolors=$(tput colors)
	fi
	if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
		RED="$(tput setaf 1)"
		GREEN="$(tput setaf 2)"
		YELLOW="$(tput setaf 3)"
		BLUE="$(tput setaf 4)"
		BOLD="$(tput bold)"
		NORMAL="$(tput sgr0)"
	else
		RED=""
		GREEN=""
		YELLOW=""
		BLUE=""
		BOLD=""
		NORMAL=""
	fi

	# Only enable exit-on-error after the non-critical colorization stuff,
	# which may fail on systems lacking tput or terminfo
	set -e
	curr_dir=$PWD

	CHECK_TMUX_INSTALLED=$(grep /tmux$ /etc/shells | wc -l)
	if [ ! $CHECK_TMUX_INSTALLED -ge 1 ]; then
		printf "${YELLOW}tmux is not installed!${NORMAL} Please install tmux first!\n"
		exit
	fi
	unset CHECK_TMUX_INSTALLED

	# Prevent the cloned repository from having insecure permissions. Failing to do
	# so causes compinit() calls to fail with "command not found: compdef" errors
	# for users with insecure umasks (e.g., "002", allowing group writability). Note
	# that this will be ignored under Cygwin by default, as Windows ACLs take
	# precedence over umasks except for filesystems mounted with option "noacl".
	umask g-w,o-w
	printf "${BLUE}Looking for an existing tmux config...${NORMAL}\n"
	if [ -f ~/.tmux.conf ] || [ -h ~/.tmux.conf ]; then
		printf "${YELLOW}Found ~/.tmux.conf.${NORMAL} ${GREEN}Backing up to ~/.tmux.conf.old${NORMAL}\n";
		mv ~/.tmux.conf ~/.tmux.conf.old;
	fi
	cd '../tmux'
	ln -s $(pwd)/tmux.conf.symlink ~/.tmux.conf
	cd $curr_dir

	if [ ! -n "$TPM_DIR" ]; then
		cd $HOME
		TPM_DIR="$(pwd)/.local/share/tmux/plugins/tpm"
		cd $curr_dir
		echo "tmux plugins are going to be installed in $TPM_DIR ."
	fi

	if [ -d "$TPM_DIR" ]; then
		printf "${YELLOW}You already have tmux plugins installed.${NORMAL}\n"
		printf "You'll need to remove $TPM_DIR if you want to re-install.\n"
		exit
	fi

	printf "${BLUE}Cloning tmux plugin manager (tpm)...${NORMAL}\n"
	mkdir -p $TPM_DIR
	hash git >/dev/null 2>&1 || {
	echo "Error: git is not installed"
	exit 1
}
# The Windows (MSYS) Git is not compatible with normal use on cygwin
if [ "$OSTYPE" = cygwin ]; then
	if git --version | grep msysgit > /dev/null; then
		echo "Error: Windows/MSYS Git is not supported on Cygwin"
		echo "Error: Make sure the Cygwin git package is installed and is first on the path"
		exit 1
	fi
fi
env git clone --depth=1 https://github.com/tmux-plugins/tpm $TPM_DIR || {
printf "Error: git clone of tpm repo failed\n"
exit 1
  }
  # Installing the tmux plugins
  # Tip from https://github.com/tmux-plugins/tpm/issues/6
  # start a server but don't attach to it
  tmux start-server
  # create a new session but don't attach to it either
  tmux new-session -d
  # install the plugins
  bash $TPM_DIR/scripts/install_plugins.sh
  # killing the server is not required, I guess
  tmux kill-server
  #All installation steps complete
  printf "${GREEN}tmux setup is now complete.${NORMAL}\n"
}

main
