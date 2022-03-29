get_value() {
    local prompt=$1
    local secure=$2
    local default=$3
    local val=

    while [ "${val}" = "" ]
    do
        if [ "${secure}" = "y" ]; then
            read -e -r -s -p "${prompt}" val
        else
            read -e -r -p "${prompt}" val
        fi

        if [ "${val}" = "" -a "${default}" != "" ]; then
            val="${default}"
        fi
    done

    echo "${val}"
}

get_file() {
    local prompt=$1
    local file=$2

    while [ "${file}" = "" -o ! -f "${file}" ]
    do
        file=$(get_value "${prompt}" 'n')
    done

    echo "${file}"
}

get_mawus_env() {
    local env=

    while [ "${env}" = "" ]
    do
        env=$(get_value 'Enter environment for mawus [dev | test | stage | prod]: ' 'n')

        if [ "${env}" != "dev" -a "${env}" != "test" -a "${env}" != "stage" -a "${env}" != "prod" ]; then
            env=
        fi
    done

    echo "${env}"
}
