<img width="694" height="181" alt="scheme" src="https://github.com/user-attachments/assets/33f08e78-1247-4d1d-997b-2198ac67e506" />


frontend

1. Клонируем репозиторий: git clone -b master git@github.com:ivanov00111879/project.git
2. Копируем пакет filebeat_8.17.1
3. Запускаем скрипт установки: sudo bash /home/debian/project/frontend/install-frontend.sh
4. Запускаем скрипт настройки: sudo bash /home/debian/project/frontend/set-frontend.sh


backend-01

5. Клонируем репозиторий: git clone -b master git@github.com:ivanov00111879/project.git
6. Запускаем скрипт установки apache: sudo bash /home/debian/project/backend-01/install-apache2.sh
7. Запускаем скрипт настройки apache: sudo bash /home/debian/project/backend-01/set-apache2.sh


backend-02

8. Клонируем репозиторий: git clone -b master git@github.com:ivanov00111879/project.git
9. Запускаем скрипт установки apache: sudo bash /home/debian/project/backend-01/install-apache2.sh


mysql-master

1. Клонируем репозиторий: git clone -b master git@github.com:ivanov00111879/project.git
2. Запускаем скрипт установки mysql: sudo bash /home/debian/project/mysql-master/install-mysql.sh
3. Запускаем скрипт настройки mysql: sudo bash /home/debian/project/mysql-master/set-mysql.sh
888888. Запускаем скрипт восстановления базы: sudo bash /home/debian/project/mysql-replica/restore.sh /home/debian/project/mysql-replica/mysql_backup_20260501_110407


mysql-replica

4. Клонируем репозиторий: git clone -b master git@github.com:ivanov00111879/project.git
5. Запускаем скрипт установки mysql: sudo bash /home/debian/project/mysql-master/install-mysql.sh
6. Запускаем скрипт настройки mysql: sudo bash /home/debian/project/mysql-replica/set-mysql.sh
7. Запускаем скрипт запуска репликации (проверить позицию бинлога): sudo bash /home/debian/project/mysql-replica/start-replica.sh


monitoring

1. Клонируем репозиторий: git clone -b master git@github.com:ivanov00111879/project.git
2. Копируем пакет grafana_12.3.3
3. Запускаем скрипт установки: sudo bash /home/debian/project/monitoring/install-monitoring.sh
4. Запускаем скрипт настройки: sudo bash /home/debian/project/monitoring/set-monitoring.sh


logging

1. Клонируем репозиторий: git clone -b master git@github.com:ivanov00111879/project.git
2. Копируем пакеты: elasticsearch_8.17.1, kibana_8.17.1, logstash_8.17.1 на сервер
3. Запускаем скрипт установки: sudo bash /home/debian/project/logging/install-logging.sh
4. Запускаем скрипт настройки: sudo bash /home/debian/project/logging/set-logging.sh
