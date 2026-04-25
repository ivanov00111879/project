#!/bin/bash
set -e

echo "Обновление индексов пакетов"
apt update

echo "Установка Apache2"
apt install -y apache2

echo "Настройка автозапуска и запуск службы"
systemctl enable apache2
systemctl start apache2

echo "Проверка статуса службы"
# Используем --no-pager, чтобы вывод не прерывал работу скрипта
systemctl status apache2 --no-pager

echo "Установка завершена!"
