#!/bin/bash

# Обновляем списки пакетов
sudo apt update

# Устанавливаем node-exporter
sudo apt install -y prometheus-node-exporter

# Включаем автозапуск и стартуем сервис
sudo systemctl enable --now prometheus-node-exporter

echo "--- Node Exporter установлен и запущен ---"
echo "--- Метрики доступны по адресу: http://$(hostname -I | awk '{print $1}'):9100/metrics ---"
