#!/bin/bash

# به‌روز رسانی سیستم
echo "به‌روز رسانی سیستم..."
sudo apt update -y
sudo apt upgrade -y

# نصب پیش‌نیازهای عمومی
echo "نصب پیش‌نیازهای عمومی..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common python3-pip

# نصب Docker
echo "نصب Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update -y
sudo apt install -y docker-ce

# فعال‌سازی و راه‌اندازی Docker
sudo systemctl enable --now docker

# نصب Docker Compose
echo "نصب Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# بررسی نسخه‌های نصب شده
echo "بررسی نسخه‌های نصب شده..."
docker --version
docker-compose --version

# نصب کتابخانه‌های Python از requirements.txt
echo "نصب پیش‌نیازهای پایتون..."
if [ -f "requirements.txt" ]; then
  pip3 install -r requirements.txt
else
  echo "فایل requirements.txt یافت نشد. لطفاً این فایل را در پوشه اصلی پروژه قرار دهید."
fi

# پایان نصب
echo "نصب با موفقیت به پایان رسید!"
