#!/bin/bash
. ./_shared.sh

MAW_ENV=dev # $(get_maw_env)
HOST=barett # $(get_value "Hostname (must exist in inventory file): " 'n')
FIRST_RUN=n  # $(get_value "First Run - need to prompt for sshd password?  (y/N): " 'n' 'n')
VERBOSE=n    # $(get_value "Verbose?  (y/N): " 'n' 'n')
TAGS=maw_services # $(get_value "Run specific tag?  (maw_backups | maw_host | maw_services): " 'n' 'n')
PLAYBOOK_ARGS=("--ask-become-pass")

if [ "${MAW_ENV}" == "prod" ]; then
    INVENTORY="inventories/inventory_prod.yml"
else
    INVENTORY="inventories/inventory_nonprod.yml"
fi

if [ "${FIRST_RUN}" == 'y' ]; then
    PLAYBOOK_ARGS+=("--ask-pass")
fi

if [ "${VERBOSE}" == 'y' ]; then
    PLAYBOOK_ARGS+=("-vvv")
fi

if [ "${TAGS}" == 'maw_backups' -o "${TAGS}" == 'maw_host' -o "${TAGS}" == 'maw_services' ]; then
    PLAYBOOK_ARGS+=("--tags")
    PLAYBOOK_ARGS+=("${TAGS}")
fi

PLAYBOOK_ARGS+=("--inventory")
PLAYBOOK_ARGS+=("${INVENTORY}")
PLAYBOOK_ARGS+=("--limit")
PLAYBOOK_ARGS+=("maw_current_prod,${HOST}")
PLAYBOOK_ARGS+=("--extra-vars")
PLAYBOOK_ARGS+=("@vars/maw_${MAW_ENV}.yml")
PLAYBOOK_ARGS+=("playbook_maw.yml")

echo ''

DO_RUN=y # $(get_value "Configure -[${MAW_ENV}]- environment for mikeandwan.us on -[${HOST}]-?  (y/N): " 'n' 'n')

if [ "${DO_RUN}" != 'y' ]; then
    exit
fi

ansible-playbook "${PLAYBOOK_ARGS[@]}"
