#!/bin/bash

# Пути к файлам
SOURCE="/home/debian/project/monitoring/prometheus.yml"
DEST="/etc/prometheus/prometheus.yml"

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
    systemctl reload prometheus
    echo "Prometheus успешно перезапущен"
