#!/bin/bash

# به‌روزرسانی و نصب پیش‌نیازها
sudo apt update
sudo apt install -y curl

# نصب پکیج‌های ضروری برای ربات
echo "Pre-requisites installed successfully."

# دانلود و نصب ربات تلگرامی
echo "Running Telegram bot script..."

# دستور برای اجرای ربات (برای نمونه فایل bot.sh)
chmod +x bot.sh
./bot.sh

echo "Telegram bot is running..."
