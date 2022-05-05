#!/bin/bash
. ./_shared.sh

HOST=$(get_value "Workstation hostname: " 'n')

ansible-playbook \
    --ask-become-pass \
    --inventory inventories/inventory_nonprod.yml \
    --limit "${HOST}" \
    playbook_workstation.yml
