#!/bin/bash
. ./_shared.sh

MAWUS_ENV=$(get_mawus_env)
HOST=$(get_value "Workstation hostname (must exist in inventory file): " 'n')
FIRST_RUN=$(get_value "First Run - need to prompt for sshd password?  (y/N): " 'n' 'n')
VERBOSE=$(get_value "Verbose?  (y/N): " 'n' 'n')
INVENTORY="inventories/inventory_mawus_${MAWUS_ENV}.yml"
PLAYBOOK="playbook_mawus_${MAWUS_ENV}.yml"
PLAYBOOK_ARGS=("--ask-become-pass")

if [ "${FIRST_RUN}" == 'y' ]; then
    PLAYBOOK_ARGS+=("--ask-pass")
fi

if [ "${VERBOSE}" == 'y' ]; then
    PLAYBOOK_ARGS+=("-vvv")
fi

PLAYBOOK_ARGS+=("--inventory")
PLAYBOOK_ARGS+=("${INVENTORY}")
PLAYBOOK_ARGS+=("--limit")
PLAYBOOK_ARGS+=("${HOST}")
PLAYBOOK_ARGS+=("${PLAYBOOK}")

echo ''

DO_RUN=$(get_value "Configure -[${MAWUS_ENV}]- environment for mikeandwan.us on -[${HOST}]-?  (y/N): " 'n' 'n')

if [ "${DO_RUN}" != 'y' ]; then
    exit
fi

ansible-playbook "${PLAYBOOK_ARGS[@]}"
