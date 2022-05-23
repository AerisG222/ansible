#!/bin/bash
. ./_shared.sh

MAW_ENV=$(get_maw_env)
HOST=$(get_value "Hostname (must exist in inventory file): " 'n')
FIRST_RUN=$(get_value "First Run - need to prompt for sshd password?  (y/N): " 'n' 'n')
ONEOFF=$(get_value "Run the one-off playbook?  (y/N): " 'n' 'n')
VERBOSE=$(get_value "Verbose?  (y/N): " 'n' 'n')
TAGS=$(get_value "Run specific tag?  (maw_backups | maw_host | maw_services...): " 'n' 'n')
ANSIBLE_RUNNER=ansible-playbook
ANSIBLE_ARGS=("--ask-become-pass")

if [ "${MAW_ENV}" == "prod" ]; then
    INVENTORY="inventories/inventory_prod.yml"
else
    INVENTORY="inventories/inventory_nonprod.yml"
fi

if [ "${FIRST_RUN}" == 'y' ]; then
    ANSIBLE_ARGS+=("--ask-pass")
fi

if [ "${VERBOSE}" == 'y' ]; then
    ANSIBLE_ARGS+=("-vvv")
fi

if [ "${TAGS}" != 'n' ]; then
    ANSIBLE_ARGS+=("--tags")
    ANSIBLE_ARGS+=("${TAGS}")
fi

ANSIBLE_ARGS+=("--inventory")
ANSIBLE_ARGS+=("${INVENTORY}")
ANSIBLE_ARGS+=("--limit")
ANSIBLE_ARGS+=("maw_current_prod,${HOST}")
ANSIBLE_ARGS+=("--extra-vars")
ANSIBLE_ARGS+=("@vars/maw_${MAW_ENV}.yml")

if [ "${ONEOFF}" == 'y' ]; then
    ANSIBLE_ARGS+=("playbook_maw_oneoff.yml")
else
    ANSIBLE_ARGS+=("playbook_maw.yml")
fi

echo ''
echo ''
echo '** this will run the following command **'
echo "${ANSIBLE_RUNNER} ${ANSIBLE_ARGS[*]}"
echo ''
echo ''

DO_RUN=$(get_value "Configure -[${MAW_ENV}]- environment for mikeandwan.us on -[${HOST}]-?  (y/N): " 'n' 'n')

if [ "${DO_RUN}" != 'y' ]; then
    exit
fi

"${ANSIBLE_RUNNER}" "${ANSIBLE_ARGS[@]}"
