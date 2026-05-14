sudo dpkg -i /home/debian/logstash_8.17.1_amd64-224190-b63239.deb
sudo systemctl enable --now logstash.service
sudo systemctl status logstash.service --no-pager
