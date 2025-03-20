#!/bin/bash

echo "🔧 نصب ربات VPN..."
apt update && apt install -y python3-pip postgresql docker docker-compose

echo "📦 نصب پیش‌نیازها..."
pip3 install -r requirements.txt

echo "🚀 راه‌اندازی سرویس‌ها..."
docker-compose up -d
