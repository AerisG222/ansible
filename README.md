# Ansible

This is an attempt to learn Ansible to automate the provisioning of a new server and workstation.

## Install Ansible

While it is possible to run `sudo dnf install ansible` to install Ansible, it may not be the most recent version.  As such, prefer installing via `pip install --user ansible` and be sure to use
`pip` to update Ansible afterwards.

If you will be authoring Ansible files in VSCode, make sure you additionally install the following:

1. Install Ansible Language extension in VSCode
2. Run: `pip install --user ansible-lint`

## Using Playbook Examples

Consider adding `--check` to the commands below to see what ansible would do w/o actually performing the task.

1. Run (servers): `ansible-playbook -K -i inventory.yml playbook_servers.yml`
2. Run (workstations): `ansible-playbook -K -i inventory.yml playbook_workstations.yml`
3. Run (vmtest - note the ask-pass `-k` as ssh keys not configured yet): `ansible-playbook -kK -i inventory_test.yml playbook_servers.yml`

## Notes

When trying to use the playbook to initialize a new Fedora Workstation, there are some steps that
must first be done on the new machine:

1. Make sure you have or create an admin account (not root) that can use sudo
2. Be sure to configure this user by setting the ansible_user variable - typically in the inventory file.
3. Determine IP address so this can be configured for ansible: `ifconfig -a`
4. Start the SSH service: `sudo systemctl start sshd.service`
5. Manually test connecting to workstation via ssh on command line from ansible runner: `ssh user@ip`

Not only does step 3 verify that ssh is working, it should also prompt you to accept the host - and by
accepting, should add the host key to your list of known hosts - which is required by sshpass, which is
used by ansible.

When running the ansible playbook, make sure you pass -kK which will prompt for the password ansible
should use when ssh'ing to the remote machine, along with the password to use for sudo.  Note that the
fedora_base role will harden ssh, so ansible will only use the ssh password for this initial step/role
and will instead use the public key afterwords when connecting.

## References

- https://www.ansible.com/hubfs/2018_Content/Ansible%20Best%20Practices%20Roles%20&%20Modules.pdf
- https://www.quora.com/How-can-TensorFlow-with-NVIDIA-GPU-support-be-installed-on-Fedora-32
- https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#podman
- https://github.com/geerlingguy/ansible-for-devops
- https://github.com/vbotka/ansible-linux-postinstall
