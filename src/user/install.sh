#!/bin/sh
set -e

USERNAME="${USERNAME:-"automatic"}"
USER_UID="${USERUID:-"automatic"}"
USER_GID="${USERGID:-"automatic"}"


# Checks if packages are installed and installs them if not
install_if_not() {
    if [ -z "$(apt list -I "$@")" ]; then
        echo "Install package $@"
        apt add --no-cache "$@"
    fi
}


# Update package list
apt update

install_if_not sudo
install_if_not shadow

echo "remote user _REMOTE_USER: ${_REMOTE_USER}"
echo "username: ${USERNAME}"
# If in automatic mode, determine if a user already exists, if not use vscode
if [ "${USERNAME}" = "auto" ] || [ "${USERNAME}" = "automatic" ]; then
    if [ "${_REMOTE_USER}" != "root" ]; then
        USERNAME="${_REMOTE_USER}"
    else
        USERNAME=""
        POSSIBLE_USERS="devcontainer vscode node codespace $(awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd)"
        for CURRENT_USER in "${POSSIBLE_USERS[@]}"; do
            if id -u ${CURRENT_USER} > /dev/null 2>&1; then
                USERNAME=${CURRENT_USER}
                break
            fi
        done
        if [ "${USERNAME}" = "" ]; then
            USERNAME=vscode
        fi
    fi
elif [ "${USERNAME}" = "none" ]; then
    USERNAME=root
    USER_UID=0
    USER_GID=0
fi
echo "remote user _REMOTE_USER: ${_REMOTE_USER}"
echo "username: ${USERNAME}"
# Create or update a non-root user to match UID/GID.
group_name="${USERNAME}"
if id -u ${USERNAME} > /dev/null 2>&1; then
    # User exists, update if needed
    if [ "${USER_GID}" != "automatic" ] && [ "$USER_GID" != "$(id -g $USERNAME)" ]; then
        group_name="$(id -gn $USERNAME)"
        groupmod --gid $USER_GID ${group_name}
        usermod --gid $USER_GID $USERNAME
    fi
    if [ "${USER_UID}" != "automatic" ] && [ "$USER_UID" != "$(id -u $USERNAME)" ]; then
        usermod --uid $USER_UID $USERNAME
    fi
else
    # Create user
    if [ "${USER_GID}" = "automatic" ]; then
        echo "Add group $USERNAME"
        groupadd $USERNAME
    else
        echo "Add group $USERNAME with id $USER_GID"
        groupadd --gid $USER_GID $USERNAME
    fi
    if [ "${USER_UID}" = "automatic" ]; then
        useradd -s /bin/bash --gid $USERNAME -m $USERNAME
        USER_UID=$(id -u $USERNAME)
    else
        useradd -s /bin/bash --uid $USER_UID --gid $USERNAME -m $USERNAME
    fi
    echo "Extract GID and UID for user ${USERNAME}"
    USER_GID=$(id -g $USERNAME)
    USER_UID=$(id -u $USERNAME)
fi

echo "remote user _REMOTE_USER: ${_REMOTE_USER}"
echo "username: ${USERNAME}"
# Add add sudo support for non-root user
if [ "${USERNAME}" != "root" ]; then
    echo "Add ${USERNAME} to sudo"
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME
    chmod 0440 /etc/sudoers.d/$USERNAME
    # echo '%sudo ALL=(ALL:ALL) ALL' | EDITOR='tee -a' visudo
    # groupadd -r sudo
    # usermod -aG sudo $USERNAME
    # passwd --delete $USERNAME
fi

echo "Done!"
