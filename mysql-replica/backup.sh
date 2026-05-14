#!/bin/bash

# Настройки подключения к MySQL
MYSQL_USER="root"
MYSQL_PASSWORD="Vg741963Vv@!"
MYSQL_HOST="localhost"
MYSQL="mysql --skip-column-names -u$MYSQL_USER -p$MYSQL_PASSWORD -h$MYSQL_HOST"
MYSQLDUMP="mysqldump -u$MYSQL_USER -p$MYSQL_PASSWORD -h$MYSQL_HOST"

# Функция для остановки репликации
stop_replication() {
    echo "Остановка репликации..."
    $MYSQL -e "STOP REPLICA"
    if [ $? -eq 0 ]; then
        echo "Репликация успешно остановлена"
        sleep 2
    else
        echo "Ошибка при остановке репликации"
        exit 1
    fi
}

# Функция для запуска репликации
start_replication() {
    echo "Запуск репликации..."
    $MYSQL -e "START REPLICA"
    if [ $? -eq 0 ]; then
        echo "Репликация успешно запущена"
    else
        echo "Ошибка при запуске репликации"
        exit 1
    fi
}

# Основная функция бэкапа
perform_backup() {
    BACKUP_DIR="mysql_backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    # Сохраняем абсолютный путь, чтобы cd не ломал логику
    ROOT_DIR=$(pwd)

    echo "Создание резервных копий в директорию: $BACKUP_DIR"

    # Получаем список БД (исключая системные)
    DATABASES=$($MYSQL -e "SHOW DATABASES WHERE \`Database\` NOT IN ('information_schema', 'performance_schema', 'sys', 'mysql')")

    for db in $DATABASES; do
        echo "Обработка базы данных: $db"
        
        # Создаем папку для бэкапа
        CURRENT_DB_DIR="$ROOT_DIR/$BACKUP_DIR/$db"
        mkdir -p "$CURRENT_DB_DIR"

        TABLES=$($MYSQL -D $db -e "SHOW TABLES")

        if [ -z "$TABLES" ]; then
            echo "  База данных $db не содержит таблиц"
            continue
        fi

        for table in $TABLES; do
            echo "  Дамп таблицы: $table"

            # Dump database
            $MYSQLDUMP --add-drop-table --add-locks --create-options --disable-keys --extended-insert \
                --single-transaction --quick --set-charset --events --routines --triggers \
                --complete-insert --hex-blob --opt --order-by-primary --skip-comments \
                --tz-utc --set-gtid-purged=OFF \
                "$db" "$table" | gzip -1 > "$CURRENT_DB_DIR/$table.sql.gz"

            if [ $? -eq 0 ]; then
                echo "    OK: $table.sql.gz"
            else
                echo "    ОШИБКА при дампе таблицы $table"
            fi
        done
    done
}

# Выполнение скрипта
main() {
    echo "Выполнение Бэкап"

    if ! $MYSQL -e "SELECT 1" >/dev/null 2>&1; then
        echo "Ошибка подключения к MySQL"
        exit 1
    fi

    stop_replication
    perform_backup
    start_replication

    echo "Бэкап завершен"
}

main
