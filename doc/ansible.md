Ansible is an IT automation tool written in python. Ansible can automate tasks
on multiple computers at once. This dotfile is designed as an
*ansible-playbook*. An *ansible-playbook* specify the host (or a group of host)
computer(s) and a collection of tasks (also roles) for those host
(or a group of host) computer(s). These host (or group of host) computer(s)
must be defined with their ip addresses or fully qualified domain names (FQDNs)
in inventory file.

In this dotfile, `hosts` file in root folder is ansible inventory file. The file
can be updated to include other hosts or group of hosts. The variable for
group of host is defined in `group_vars` folder. Different configuration/data
for different programs managed by respective role in `roles` folder of this
dotfile. The individual role in `roles` folder confirm to folder structure
given in official
[ansible documentation](https://docs.ansible.com/ansible/latest/user_guide/playbooks_reuse_roles.html)
with a minor deviation of having an extra folder `payload` only for role that
needs to put files in user home folder as part of setting up the respective
program. Such role put the link to file/folder (from `payload` folder) in
home directory using `stow`.
