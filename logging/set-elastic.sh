#!/bin/bash

# Проверяем, запущен ли скрипт от имени root
if [ "$EUID" -ne 0 ]; then 
  echo "Пожалуйста, запустите скрипт через sudo"
  exit
fi

echo "Настройка JVM параметров..."
# Создаем файл jvm.options
cat > /etc/elasticsearch/jvm.options.d/jvm.options <<EOF
-Xms1g
-Xmx1g
EOF

echo "Настройка конфигурации elasticsearch"
# Копируем конфиг из указанной папки
cp /home/debian/project/logging/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

echo "Перезапуск и включение службы Elasticsearch..."
# Перезагружаем демона, чтобы подхватить изменения, и запускаем сервис
systemctl daemon-reload
systemctl enable --now elasticsearch.service

echo "Elasticsearch успешно запущен"
systemctl status elasticsearch --no-pager
