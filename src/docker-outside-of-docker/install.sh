#!/bin/sh

set -e

# Parse options from feature configuration in devcontainer.json
INSTALLDOCKER=${INSTALLDOCKER:-"true"}
INSTALLBUILDX=${INSTALLBUILDX:-"true"}
INSTALLDOCKERCOMPOSE=${INSTALLDOCKERCOMPOSE:-"true"}
SOURCE_SOCKET=/var/run/docker-host.sock
TARGET_SOCKET=/var/run/docker.sock

echo "Activating feature 'docker-outside-of-docker'"

apk update
# If init file already exists, exit
if [ -f "/usr/local/share/docker-init.sh" ]; then
    exit 0
fi

if [ "${INSTALLDOCKER}" = "true" ]; then
    apk --no-cache add docker-cli
fi

if [ "${INSTALLBUILDX}" = "true" ]; then
    apk --no-cache add docker-cli-buildx
fi

mkdir -p /usr/local/share

if [[ -z $_CONTAINER_USER ]]; then
    ln -s /var/run/docker-host.sock /var/run/docker.sock
    echo -e '#!/bin/sh\nexec "$@"' > /usr/local/share/docker-init.sh
else

apk --no-cache add socat sudo
echo "$_CONTAINER_USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$_CONTAINER_USER
chmod 0440 /etc/sudoers.d/$_CONTAINER_USER

mkdir -p "$(dirname "${SOURCE_SOCKET}")"
touch "${SOURCE_SOCKET}"
ln -s "${SOURCE_SOCKET}" "${TARGET_SOCKET}"

tee /usr/local/share/docker-init.sh > /dev/null \
<< EOF
#!/bin/sh

set -e

SOCAT_PATH_BASE=/tmp/vscr-docker-from-docker
SOCAT_LOG=\${SOCAT_PATH_BASE}.log
SOCAT_PID=\${SOCAT_PATH_BASE}.pid

SOURCE_SOCKET=$SOURCE_SOCKET
TARGET_SOCKET=$TARGET_SOCKET

if [ ! -f "\$SOCAT_PID" ] || ! kill -0 \$(cat \$SOCAT_PID) 2>/dev/null; then
    echo "Enabling socket proxy."
    echo "Proxying ${SOURCE_SOCKET} to ${TARGET_SOCKET} for vscode"
    sudo rm -rf ${TARGET_SOCKET}
    (sudo socat UNIX-LISTEN:\$TARGET_SOCKET,fork,mode=660,user=$_CONTAINER_USER,backlog=128 UNIX-CONNECT:\$SOURCE_SOCKET 2>&1 | sudoIf tee -a \${SOCAT_LOG} > /dev/null & echo "\$!" | sudoIf tee \${SOCAT_PID} > /dev/null)
else
    echo "Socket proxy already running."    
fi

set +e
exec "\$@"
EOF

    chown ${_CONTAINER_USER}:root /usr/local/share/docker-init.sh
fi

chmod +x /usr/local/share/docker-init.sh

if [[ $INSTALLDOCKERCOMPOSE == "true" ]]; then
    apk --no-cache add docker-compose
fi



echo 'Done!'