#!/bin/bash

SOURCE="/home/debian/project/frontend/default"
DESTINATION="/etc/nginx/sites-available/default"

echo "Начинаю процесс обновления конфигурации Nginx..."

# 1. Проверяем, существует ли исходный файл
if [ ! -f "$SOURCE" ]; then
    echo "Ошибка: Исходный файл $SOURCE не найден!"
    exit 1
fi

# 2. Копируем файл с заменой (используем sudo, так как /etc/nginx защищена)
echo "Копирую конфигурацию в $DESTINATION..."
sudo cp "$SOURCE" "$DESTINATION"

# 3. Проверяем синтаксис Nginx перед перезагрузкой
echo "Проверяю корректность конфигурации Nginx..."
if sudo nginx -t; then
    # 4. Перезагружаем Nginx, если тесты прошли успешно
    echo "Тест пройден. Перезагружаю Nginx..."
    sudo systemctl reload nginx
    echo "Готово! Конфигурация обновлена."
else
    echo "Ошибка: В конфигурации Nginx найдены ошибки. Перезагрузка отменена."
    exit 1
fi
