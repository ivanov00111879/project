#!/bin/bash

MASTER_HOST="192.168.0.117"
REPL_USER="repl"
REPL_PASS="oTUSlave#2020"
LOG_FILE="mysql-bin.000001"
LOG_POS=872

# Проверка на права root
if [ "$EUID" -ne 0 ]; then
  echo "Пожалуйста, запустите скрипт с sudo"
  exit 1
fi

echo "Настройка репликации"

# Выполнение SQL команд
mysql -u root <<EOF
STOP REPLICA;
CHANGE REPLICATION SOURCE TO 
    SOURCE_HOST='$MASTER_HOST', 
    SOURCE_USER='$REPL_USER', 
    SOURCE_PASSWORD='$REPL_PASS', 
    SOURCE_LOG_FILE='$LOG_FILE', 
    SOURCE_LOG_POS=$LOG_POS, 
    GET_SOURCE_PUBLIC_KEY = 1;
START REPLICA;
EOF

if [ $? -eq 0 ]; then
    echo "Команды репликации успешно отправлены."
    echo "Текущий статус репликации:"
    mysql -u root -e "SHOW REPLICA STATUS\G" | grep -E "Slave_IO_Running|Slave_SQL_Running|Seconds_Behind_Master|Last_IO_Error"
else
    echo "Ошибка при настройке репликации."
    exit 1
fi
