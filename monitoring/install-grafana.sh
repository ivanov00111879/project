# 1. Обновление и установка
sudo apt update
sudo apt install -y adduser libfontconfig1 musl
sudo dpkg -i /home/debian/project/monitoring/grafana_12.3.3_21957728731_linux_amd64-224190-c259b4.deb

# 2. Запуск и автозагрузка
sudo systemctl enable --now grafana-server

# 3. Проверка
if systemctl is-active --quiet grafana-server; then
    echo "✅ Grafana успешно запущена!"
    echo "Адрес: http://$(hostname -I | awk '{print $1}'):3000"
else
    echo "❌ Ошибка установки. Проверьте вывод выше."
fi

sudo systemctl status grafana-server --no-pager
