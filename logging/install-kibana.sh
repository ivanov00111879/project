sudo dpkg -i /home/debian/kibana_8.17.1_amd64-224190-9c79ef.deb
sudo systemctl daemon-reload
sudo systemctl enable --now kibana.service
sudo systemctl status kibana.service --no-pager
