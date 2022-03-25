#!/bin/bash
. ./_shared.sh

INVENTORY_FILE=$(get_file 'Inventory File: ' "$1")

ansible-playbook \
    --ask-become-pass \
    --inventory "${INVENTORY_FILE}" \
    playbook_ddclient.yml
