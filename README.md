# Ansible Scripts

This is an attempt to learn Ansible to automate the provisioning of a new server and workstation.

To use:

Consider adding `--check` to the commands below to see what ansible would do w/o actually performing the task.

1. Install Ansible: `sudo dnf install ansible`
2. Run (servers): `ansible-playbook -K -i inventory.yml playbook_servers.yml`
3. Run (workstations): `ansible-playbook -K -i inventory.yml playbook_workstations.yml`
4. Run (vmtest - note the ask-pass `-k` as ssh keys not configured yet): `ansible-playbook -kK -i inventory_test.yml playbook_servers.yml`

When Authoring Ansible files in VSCode

1. Install Ansible Language extension
2. Run: `sudo dnf install ansible-lint`

## References

- https://www.quora.com/How-can-TensorFlow-with-NVIDIA-GPU-support-be-installed-on-Fedora-32
- https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#podman
