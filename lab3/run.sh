#!/bin/bash

CONFIG_FILE="/home/vanya/ovpn.ovpn"
LOG_FILE="/var/log/openvpn.log"

# Проверяем, установлен ли OpenVPN
if ! command -v openvpn &> /dev/null; then
    echo "OpenVPN не установлен. Устанавливаем..."
    sudo apt update && sudo apt install -y openvpn
fi

# Запускаем OpenVPN
echo "Подключаемся к VPN..."
sudo openvpn --config "$CONFIG_FILE" --daemon --log "$LOG_FILE"

# Проверяем, запущен ли OpenVPN
sleep 5
if pgrep -x "openvpn" > /dev/null; then
    echo "VPN подключен успешно."
else
    echo "Не удалось подключиться к VPN. Проверяйте лог: $LOG_FILE"
fi 
