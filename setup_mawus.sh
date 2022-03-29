#!/bin/bash
. ./_shared.sh

MAWUS_ENV=$(get_mawus_env)
HOST=$(get_value "Workstation hostname (must exist in inventory file): " 'n')
DO_RUN=$(get_value "Configure -[${MAWUS_ENV}]- environment for mikeandwan.us on -[${HOST}]-?  (y/N): " 'n' 'n')

if [ "${DO_RUN}" != 'y' ]; then
    exit
fi

INVENTORY="inventories/inventory_mawus_${MAWUS_ENV}.yml"
PLAYBOOK="playbook_mawus_${MAWUS_ENV}.yml"

ansible-playbook \
    --ask-become-pass \
    --inventory "${INVENTORY}" \
    --limit "${HOST}" \
    "${PLAYBOOK}"
