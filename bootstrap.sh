#!/usr/bin/env bash
#set -e

SUDOENABLED=true        # enable or disable sudo support: please note installing software is only supported in sudo enabled mode

if [ "$(id -u)" = 0 ]; then
	error "This script should not be run as root. Exitting"
	exit 1 || return 1
fi

USERGROUP=$(id -gn)
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

HOSTS_FILE=hosts
if [ ! -f "$HOSTS_FILE" ]; then
    echo "Setting up default hosts file for localhost. Creating $HOSTS_FILE ..."
    cat > "$HOSTS_FILE" << EOF
[login]
localhost

[local]
localhost

[local:vars]
ansible_connection=local
EOF
    chown "$USER:$USERGROUP" "$HOSTS_FILE"
fi
echo


echo "Setting up group_vars and host_vars folders"
mkdir -p group_vars
chown -R "$USER:$USERGROUP" group_vars
chmod 700 group_vars

mkdir -p host_vars
chown -R "$USER:$USERGROUP" host_vars
chmod 700 host_vars

# check for default variable file for local group (group_vars/local);
# if not found then make a file with default variable values
LOCAL_VAR_FILE=group_vars/local
SEEN_LOCAL_VAR_FILE=false
if [ ! -f "$LOCAL_VAR_FILE" ]; then
    echo "     Setting up default variable file for local group. Creating $LOCAL_VAR_FILE ..."
    cat > "$LOCAL_VAR_FILE" << EOF
full_name: Mayank Suman
git_user: mayanksuman
git_email: mayanksuman@live.com

# Nerd Font to install
monospace_font_name: FiraCode

# Dotfile location and action (action can be install or uninstall)
dotfile_repo: https://github.com/mayanksuman/dotfile.git
dotfile_folder: "{{ user_home_folder }}/.dotfile"
dotfile_action: install

# system user details for the user running ansible: do not change in most cases
user_name: "{{ ansible_user_id }}"
user_group: "{{ user_name }}"
user_home_folder: "{{ '~' | expanduser }}"

# use system python for running ansible tasks
ansible_python_interpreter: /usr/bin/python3

### Optional Settings: Uncomment them if needed
## Path to git credential file if any
#git_credetial_file_path:

## Settings for smtp protocol for the git_email variable provided above
#smtp_server:
#smtp_port:
#smtp_encyption: tls
#smtp_ssl_cert_path:
#smtp_password:
EOF
    chown "$USER:$USERGROUP" "$LOCAL_VAR_FILE"
fi
echo


echo "Check for variable files in group_vars and host_vars"
if [[ ( $(ls -A1 group_vars 2>/dev/null|wc -l) -gt 0) || ( $(ls -A1 host_vars 2>/dev/null|wc -l) -gt 0 ) ]] ; then
    echo It is recommended that you should check variable definition in
    echo files in group_vars and host_vars before continuing.
    echo
    for file in group_vars/*; do
        printf "${BLUE} ${file} ${NC}\n"
        cat "$file"
        echo
    done
    for file in host_vars/*; do
        printf "${BLUE} ${file} ${NC}\n"
        cat "$file"
        echo
    done
    echo
    echo "The variables in these file can affect the ansible playbook."
    echo "Hence, review these files before continuing ..."
    echo
    read -p "Do you want to continue? (Y/N) " -n 1 -r
    if [[ ! $REPLY =~ ^[Yy]$ ]] ; then
        exit 1 || return 1
    fi
    echo
fi

# check if ansible installed otherwise install it
SYS_PIP=/usr/bin/pip3
if ! hash ansible 2>/dev/null; then
    if [ "$SUDOENABLED" = true ]; then
    	echo "Please enter your password, if asked"
    	if [ -x "$(command -v apt &> /dev/null)" ]; then
    		sudo apt install python3-dev python3-pip ansible
    	fi
    	if [ -x "$(command -v yum &> /dev/null)" ]; then
    		sudo yum install python3-dev python3-pip ansible
    	fi
    else
    	# Install ansible using pip for the current user only
    	if [ -f "$SYS_PIP" ]; then
    	    "$SYS_PIP" install --user -U ansible
    	fi
    fi
fi

# if you are not able to run ansible-galaxy then check
# (https://github.com/ansible-collections/community.digitalocean/issues/132)
ansible-galaxy collection install community.general

echo "Running deploy_plabook.yml ansible playbook..."
echo "Please enter your password, if asked"
if [ "$SUDOENABLED" = true ]; then
    ansible-playbook -i hosts deploy_playbook.yaml --ask-become-pass
else
    ansible-playbook -i hosts deploy_playbook.yaml
fi
