#!/bin/bash

SOURCE="/home/debian/project/backend-01/index.html"
DESTINATION="/var/www/html/index.html"
BACKUP="/var/www/html/index.html.bak"

echo "Обновление index.html для Apache"

# 1. Проверяем, существует ли исходный файл
if [ ! -f "$SOURCE" ]; then
    echo "Ошибка: Исходный файл $SOURCE не найден!"
    exit 1
fi

# 2. Создаем бэкап старой страницы (на всякий случай)
if [ -f "$DESTINATION" ]; then
    echo "Создаю бэкап текущего файла"
    sudo cp "$DESTINATION" "$BACKUP"
fi

# 3. Копируем новый файл с заменой
echo "Копирую файл в $DESTINATION..."
sudo cp "$SOURCE" "$DESTINATION"

# 4. Выставляем правильные права (чтобы Apache мог прочитать файл)
echo "Настраиваю права доступа..."
sudo chown www-data:www-data "$DESTINATION"
sudo chmod 644 "$DESTINATION"

echo " Файл успешно обновлен!"
