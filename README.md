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

## References

- https://www.quora.com/How-can-TensorFlow-with-NVIDIA-GPU-support-be-installed-on-Fedora-32
- https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#podman
