#!/bin/bash

showheader() {
    local MSG=${1}

    echo ***
    echo "    ${MSG}"
    echo ***

    sleep 0.5
}

#showheader '1: make sure ansible is available'
#pip install --user ansible ansible-lint

#showheader '2: run playbook for local development'
ansible-playbook \
    --ask-become-pass \
    --inventory inventories/inventory_dev_machine.yml \
    --limit $(hostname --short) \
    playbook_mawus_local.yml
