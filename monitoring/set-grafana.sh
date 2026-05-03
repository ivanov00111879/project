#!/bin/bash

# Пути к файлам
SOURCE="/home/debian/project/monitoring/grafana.db"
DEST="/var/lib/grafana/grafana.db"

SOURCE1="/home/debian/project/monitoring/grafana.ini"
DEST1="/etc/grafana/grafana.ini"

# Проверка на права root
if [ "$EUID" -ne 0 ]; then 
  echo "Пожалуйста, запустите скрипт с sudo"
  exit 1
fi

sudo systemctl stop grafana-server


# Копирование файла
if [ -f "$SOURCE" ]; then
    cp "$SOURCE" "$DEST"
    echo "Configuration completed"
else
    echo "Ошибка: Исходный файл $SOURCE не найден"
    exit 1
fi

# Копирование файла
if [ -f "$SOURCE1" ]; then
    cp "$SOURCE1" "$DEST1"
    chown root:grafana "$DEST1"
    chmod 640 "$DEST1"
    echo "Configuration .ini completed"
else
    echo "Ошибка: Исходный файл $SOURCE1 не найден"
    exit 1
fi

sudo chown grafana:grafana /var/lib/grafana/grafana.db

# Запуск службы
sudo systemctl start grafana-server
systemctl status grafana-server --no-pager
    echo "Grafana успешно запущена"
