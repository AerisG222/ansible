#!/bin/bash
. ./_shared.sh

HOST=$(get_value "Workstation hostname (must exist in 'inventory/inventory_workstation.yml' inventory file): " 'n')

ansible-playbook \
    --ask-become-pass \
    --inventory inventories/inventory_workstation.yml \
    --limit "${HOST}" \
    playbook_workstation.yml
