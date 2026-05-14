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

# 4. Создание пользователя для репликации
echo "Создание пользователя repl..."
mysql -u root <<EOF
CREATE USER IF NOT EXISTS 'repl'@'%' IDENTIFIED WITH 'caching_sha2_password' BY 'oTUSlave#2020';
GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%';
FLUSH PRIVILEGES;
EOF

if [ $? -eq 0 ]; then
    echo "Пользователь repl успешно создан и права назначены."
else
    echo "Ошибка при создании пользователя в MySQL."
    exit 1
fi
