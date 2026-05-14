#!/bin/bash
set -e

echo "Обновление индексов пакетов"
sudo apt update
echo "Установка gnupg"
sudo apt install gnupg -y

echo "Загрузка mysql-apt-config"
wget https://dev.mysql.com/get/mysql-apt-config_0.8.39-1_all.deb

echo "Установка mysql-apt-config"
sudo dpkg -i mysql-apt-config_0.8.39-1_all.deb

echo "Обновление индексов пакетов"
sudo apt update
echo "Установка mysql-server"
sudo apt install mysql-server -y

echo "Настройка автозапуска и запуск службы"
systemctl enable mysql
systemctl start mysql

echo "Проверка статуса службы"
# Используем --no-pager, чтобы вывод не прерывал работу скрипта
systemctl status mysql --no-pager

echo "Установка завершена!"
