#!/bin/bash

# Пути к файлам
SOURCE="/home/debian/project/mysql-master/mysqld.cnf"
DEST="/etc/mysql/mysql.conf.d/mysqld.cnf"

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

# 2. Проверка синтаксиса MySQL перед рестартом
echo "Проверка конфигурации..."
if mysqld --validate-config; then
    # 3. Перезапуск службы
    systemctl restart mysql
    echo "MySQL успешно перезапущен"
else
    echo "Ошибка в синтаксисе конфига! Рестарт отменен."
    exit 1
fi
