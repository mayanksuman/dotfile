This dotfile is designed as an ansible playbook and can be depolyed by
`ansible-playbook` command. However, before deploying, the list of host
computers can be edited in `hosts` file and the variables for them can be
defined in `group_var` folder. Please refer to `doc/ansible.md` for a brief
introduction to ansible concept.

The dotfile is collection of configurations of some programs, I use and some
custom programs/tools that I have written for my daily work (like `eg`, `gpw`
etc.). Additionally, this dotfile also setup some third party tools like
git-quick-stats, diff-so-fancy and others using git outside dotfile folder.
This is done on purpose as the dotfile is programmed in such a way that
updating, installing or uninstalling dotfile do not lead to any change in
`git status` of dotfile folder. The third party tools are updated outside
dotfile folder.

First run of this dotfile will install system software, system libraries, some
third party tools (using git), and their configuration (by linking/stowing
`payload` folder in appropriate role folder). It should be noted that
uninstalling dotfile will only remove configuration. For removing, please set
`dotfile_action` variable to `uninstall` and then run the `bootstrap.sh` script.
