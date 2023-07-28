#!/usr/bin/with-contenv bash

# Путь к файлу homed-zigbee.conf внутри контейнера
DOCKER_HOMED_CONF="/etc/homed/homed-zigbee.conf"

# Путь к файлу homed-zigbee.conf на хосте (папка config/homed)
HOST_HOMED_CONF="/config/homed/homed-zigbee.conf"

# Копируем файл, если он существует на хосте
if [ -f "$HOST_HOMED_CONF" ]; then
    touch /etc/homed/homed-zigbee.conf
    cat <<EOF > "HOST_HOMED_CONF"
homeassistant: true
EOF
fi

echo "Starting HOMED-Zigbee..."
