#!/bin/bash

# Файл для логирования
LOG_FILE="/var/log/script.log"

# Проверяем, запущен ли скрипт от суперпользователя
if [ "$EUID" -ne 0 ]; then
  echo "Необходимы права root"
  exit 1
fi

echo "==== Запуск скрипта ===="

# === Начало первой фазы ===
echo "==== Настройка сети ===="

echo "Изменяем сетевые параметры..."
{
  # Настройка параметров сети
  cat > /etc/network/interfaces <<EOL
source /etc/network/interfaces.d/*

auto lo
iface lo inet loopback

# Основное подключение к сети
allow-hotplug enp0s3
iface enp0s3 inet dhcp

# Внутренний шлюз
allow-hotplug enp0s8
iface enp0s8 inet static
address           192.168.1.1
netmask           255.255.255.0
network           192.168.1.0
dns-nameservers   77.88.8.1 8.8.8.8
EOL

  # Активируем интерфейс шлюза
  ifup enp0s8
} >> "$LOG_FILE" 2>&1

echo "Устанавливаем необходимые пакеты..."
{
  apt-get install iptables-persistent netfilter-persistent gcc -y
} >> "$LOG_FILE" 2>&1

echo "Добавляем NAT-правило..."
{
  iptables -t nat -A POSTROUTING -o enp0s3 -j MASQUERADE
  iptables-save
  netfilter-persistent save
} >> "$LOG_FILE" 2>&1

echo "Включаем пересылку пакетов..."
{
  sysctl -w net.ipv4.ip_forward="1"
  sysctl -p
} >> "$LOG_FILE" 2>&1

echo "Настраиваем DNS-сервер..."
{
  apt install -y bind9 bind9utils swaks
} >> "$LOG_FILE" 2>&1

echo "Устанавливаем DHCP-сервер..."
{
  DEBIAN_FRONTEND=noninteractive apt install -y isc-dhcp-server
  if [ $? -ne 0 ]; then
    echo "Ошибка установки DHCP-сервера"
  else
    echo "DHCP-сервер успешно установлен"
  fi
} >> "$LOG_FILE" 2>&1

echo "Настраиваем DHCP-сервер..."
{
  cat > /etc/default/isc-dhcp-server <<EOL
INTERFACESv4="enp0s8"
INTERFACESv6=""
EOL

  cat > /etc/dhcp/dhcpd.conf <<EOL
option domain-name "WORKGROUP";
option domain-name-servers 8.8.8.8;
default-lease-time 600;
max-lease-time 7200;
subnet 192.168.1.0 netmask 255.255.255.0
{
    range                       192.168.1.10 192.168.1.20;
    option broadcast-address    192.168.1.255;
    option routers              192.168.1.1;
    option domain-name-servers  8.8.8.8;
}
EOL
} >> "$LOG_FILE" 2>&1

echo "Запускаем DHCP-сервер..."
{
  /etc/init.d/isc-dhcp-server start
} >> "$LOG_FILE" 2>&1

echo "==== Завершена первая часть ===="
echo "Конфигурация завершена. Данные сохранены в $LOG_FILE"

echo "Переход ко второму этапу..."

# === Вторая часть ===
echo "==== Компиляция и запуск программы на C ===="

echo "Компилируем C-программу..."
gcc -o app lab1.c
chmod +x app

# Получаем входные данные от пользователя
read -p "Введите первое число: " num1
read -p "Введите второе число: " num2

# Запускаем бинарный файл с аргументами
./app $num1 $num2

echo "==== Скрипт завершён ===="
