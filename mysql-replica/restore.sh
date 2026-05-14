#!/bin/bash

# Настройки подключения к MySQL
MYSQL_USER="root"
MYSQL_PASSWORD="Vg741963Vv@!"
MYSQL_HOST="localhost"
MYSQL="mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h$MYSQL_HOST"

# Укажите путь к папке с бэкапом (например, mysql_backup_20240501_120000)
BACKUP_ROOT_DIR=$1

if [ -z "$BACKUP_ROOT_DIR" ]; then
    echo "Восстанавливаем на: $1"
    exit 1
fi

if [ ! -d "$BACKUP_ROOT_DIR" ]; then
    echo "Ошибка: Директория $BACKUP_ROOT_DIR не найдена"
    exit 1
fi

# 1. Отключаем логирование в бинлог для текущей сессии (чтобы ускорить процесс и избежать петель, если нужно)
# 2. Отключаем проверку внешних ключей для корректной заливки таблиц вразнобой
RESTORE_OPTS="SET FOREIGN_KEY_CHECKS=0; SET UNIQUE_CHECKS=0;"

echo "Начало восстановления из: $BACKUP_ROOT_DIR"

# Обходим папки баз данных
for db_path in "$BACKUP_ROOT_DIR"/*/; do
    db=$(basename "$db_path")
    
    echo "Восстановление базы данных: $db"
    
    # Создаем базу, если её нет
    $MYSQL -e "CREATE DATABASE IF NOT EXISTS \`$db\`;"

    # Обходим сжатые дампы таблиц
    for table_gz in "$db_path"*.sql.gz; do
        if [ -f "$table_gz" ]; then
            table_name=$(basename "$table_gz" .sql.gz)
            echo "  Заливка таблицы: $table_name"
            
            # Распаковываем и сразу заливаем в MySQL
            (echo "$RESTORE_OPTS"; zcat "$table_gz") | $MYSQL "$db"
            
            if [ $? -eq 0 ]; then
                echo "    OK"
            else
                echo "    ОШИБКА при восстановлении $table_name"
            fi
        fi
    done
done

echo "Восстановление завершено."
