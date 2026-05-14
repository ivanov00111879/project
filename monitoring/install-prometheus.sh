apt update
apt install prometheus -y
systemctl enable --now prometheus
if systemctl is-active --quiet prometheus; then
    echo "Prometheus успешно запущен!"
else
    echo "Ошибка: Prometheus не смог запуститься."
fi
systemctl status prometheus --no-pager
