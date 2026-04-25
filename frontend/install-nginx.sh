#!/bin/bash
set -e

echo "Обновление индексов пакетов"
apt update

echo "Установка Nginx"
apt install -y nginx

echo "Настройка автозапуска и запуск службы"
systemctl enable nginx
systemctl start nginx

echo "Проверка статуса службы"
if systemctl is-active --quiet nginx; then
    echo "Nginx успешно запущен!"
else
    echo "Ошибка: Nginx не удалось запустить."
    exit 1
fi

echo "Установка завершена!"
