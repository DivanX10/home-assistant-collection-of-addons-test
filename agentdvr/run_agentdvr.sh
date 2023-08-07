#!/bin/bash

# Путь к папке с файлами внутри контейнера
DOCKER_MEDIA_DIR="/agent/Media"
DOCKER_XML_DIR="/agent/Media/XML"
DOCKER_COMMANDS_DIR="/agent/Commands"

# Путь к папке с файлами на хосте (папка share/agentdvr)
HOST_MEDIA_DIR="/share/agentdvr/Media"
HOST_XML_DIR="/share/agentdvr/Media/XML"
HOST_COMMANDS_DIR="/share/agentdvr/Commands"

# Проверяем, существует ли папка /agent и она не пуста
if [ ! -d "$DOCKER_MEDIA_DIR" ] || [ -z "$(ls -A $DOCKER_MEDIA_DIR)" ]; then
    # Копируем содержимое папок из контейнера в папки на хосте
    rsync -avh --ignore-existing "$HOST_MEDIA_DIR/" "$DOCKER_MEDIA_DIR"
    rsync -avh --ignore-existing "$HOST_XML_DIR/" "$DOCKER_XML_DIR"
    rsync -avh --ignore-existing "$HOST_COMMANDS_DIR/" "$DOCKER_COMMANDS_DIR"
else
    # Копируем только измененные файлы из папок на хосте в контейнер
    rsync -avh --update "$HOST_MEDIA_DIR/" "$DOCKER_MEDIA_DIR"
    rsync -avh --update "$HOST_XML_DIR/" "$DOCKER_XML_DIR"
    rsync -avh --update "$HOST_COMMANDS_DIR/" "$DOCKER_COMMANDS_DIR"
fi

# Запускаем agentdvr
exec /agent/Agent

# После завершения работы agentdvr копируем файлы обратно в папку на хосте
rsync -avh --update "$DOCKER_MEDIA_DIR/" "$HOST_MEDIA_DIR"
rsync -avh --update "$DOCKER_XML_DIR/" "$HOST_XML_DIR"
rsync -avh --update "$DOCKER_COMMANDS_DIR/" "$HOST_COMMANDS_DIR"


