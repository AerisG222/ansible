#!/bin/bash
. ./_shared.sh

DO_RUN=$(get_value "Configure mikeandwan.us development for local host -[$(hostname --short)]-?  (y/N): " 'n' 'n')

if [ "${DO_RUN}" = 'y' ]; then

    ansible-playbook \
        --ask-become-pass \
        --inventory inventories/inventory_workstation.yml \
        --limit "$(hostname --short)" \
        playbook_mawus_dev.yml

fi
