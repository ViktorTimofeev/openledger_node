#!/bin/bash

sudo lvm lvextend -l +100%FREE /dev/ubuntu-vg/ubuntu-lv
sudo resize2fs -p /dev/mapper/ubuntu--vg-ubuntu--lv

sudo rm /etc/machine-id
sudo systemd-machine-id-setup

# Обновление системы
echo "Обновляем систему..."
sudo apt update && sudo apt upgrade -y

# Установка графического интерфейса
echo "Устанавливаем графический интерфейс Ubuntu..."
sudo apt install ubuntu-desktop -y
sudo apt update

# Запуск дисплейного менеджера
echo "Запускаем дисплейный менеджер..."
sudo systemctl start gdm

# Установка XRDP
echo "Устанавливаем XRDP..."
sudo apt install xrdp -y
sudo adduser xrdp ssl-cert
sudo systemctl restart xrdp

# Установка Docker
echo "Устанавливаем Docker..."
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker

# Загрузка и установка OpenLedger Node
echo "Скачиваем и устанавливаем OpenLedger Node..."
wget https://cdn.openledger.xyz/openledger-node-1.0.0-linux.zip
unzip openledger-node-1.0.0-linux.zip
sudo dpkg -i openledger-node-1.0.0.deb
sudo apt update

# Запуск OpenLedger Node
echo "Запускаем OpenLedger Node..."
openledger-node --no-sandbox

echo "======================================="
echo "Установка завершена! Все готово."
echo "======================================="
