#!/bin/bash

# Пути к файлам
SOURCE="/home/debian/project/logging/logstash-nginx.conf"
DEST="/etc/logstash/conf.d/logstash-nginx.conf"

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
    systemctl restart logstash.service
    echo "Logstash успешно перезапущен"
