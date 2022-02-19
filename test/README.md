# Playing with Ansible Vault

## Create a Vault

The following will open an editor to start creating a new vault.  Within the vault, you
can create anything you want, but in this test, we will prepare a file that contains varialbes
that can be used by the playbook.

`ansible-vault create --vault-id vaulttest@prompt ~/ansible_vault/vaulttest.yml`

In the resulting editor, enter the following (note: do not prefix the yaml file with ---):

```yaml
vault_mysecret: secretpwd
```

Now, you can confirm that the content was encrypted by the following:

`cat ~/ansible_vault/vaulttest.yml`

Next, you can view the contents of the file by:

`ansible-vault view ~/ansible_vault/vaulttest.yml`

## Naming Conventions

Because the variable name and value are both in the encrypted yaml file, this obscures the name of the
variable in the downstream playbooks / roles / tasks / etc.  To address this, we can use Jinja
to get the best of both worlds, by using a regular variable in a non-secure variable file and reference
the encrypted value.  For example, we might have something like the following:

`mysecret: "{{ vault_mysecret }}"`

Given this ability, we can adopt a naming convention where encrypted values should be prefixed with
`vault_`.

## Use Vaulted Secrets

Now that you have a vault, you can use them from a playbook.  To do so, run the following:

`ansible-playbook --ask-vault-pass -e @~/ansible_vault/vaulttest.yml playbook_vault.yml`

## References

- https://docs.ansible.com/ansible/latest/user_guide/vault.html
- https://www.digitalocean.com/community/tutorials/how-to-use-vault-to-protect-sensitive-ansible-data
