#!/bin/bash

# Остановить выполнение, если возникнет ошибка
set -e

echo "Обновление индексов пакетов..."
sudo apt update

echo "Установка default-jdk..."
sudo apt install default-jdk -y

echo "Проверка установки Java..."
java -version
javac -version

echo "Установка Elasticsearch из локального пакета..."
# Устанавливаем пакет
sudo dpkg -i /home/debian/elasticsearch_8.17.1_amd64-224190-a8d54b.deb

echo "Установка завершена успешно!"
