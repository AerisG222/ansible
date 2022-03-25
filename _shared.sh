get_value() {
    local prompt=$1
    local secure=$2
    local val=

    while [ "${val}" = "" ]
    do
        if [ "${secure}" = "y" ]; then
            read -e -r -s -p "${prompt}" val
        else
            read -e -r -p "${prompt}" val
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
