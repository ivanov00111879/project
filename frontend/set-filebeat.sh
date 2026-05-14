#!/bin/bash

# Пути к файлам
SOURCE="/home/debian/project/frontend/filebeat.yml"
DEST="/etc/filebeat/filebeat.yml"

# Проверка на права root
if [ "$EUID" -ne 0 ]; then 
  echo "Пожалуйста, запустите скрипт с sudo"
  exit 1
fi

# 1. Копирование файла
if [ -f "$SOURCE" ]; then
    cp "$SOURCE" "$DEST"
    echo "Configuration completed"
else
    echo "Ошибка: Исходный файл $SOURCE не найден"
    exit 1
fi

# 2. Перезапуск службы
    systemctl restart filebeat
    echo "Filebeat успешно перезапущен"
