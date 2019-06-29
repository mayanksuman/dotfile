#!/usr/bin/env bash

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

function ok() {
	echo -e "${GREEN}[ok]${NORMAL} "
}

function ok_msg() {
	echo -e "${GREEN}[ok]${NORMAL} $1"
}

function info() {
	echo -e "${GREEN}$1${NORMAL} "
}

function disp_file() {
	echo -e "${YELLOW}$1${NORMAL}";cat $1;echo
}

function action() {
	echo -e "${BOLD}${BLUE}[action]: $1 ... ${NORMAL}"
}

function step() {
	echo -e "${BLUE} ⇒ $1 ... ${NORMAL}"
}

function input() {
	read -p "${BLUE} $1 : ${NORMAL}" $2
}

function warning() {
	echo -e "${YELLOW}[warning]: $1 ${NORMAL}"
}

function error() {
	echo -e "${BOLD}${RED}[error]: $1 ${NORMAL}"
}

# ok
# action "My action"
# step "Step"
# warning "warned"
# error "error"
# info "My Info"
