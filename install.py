#!/bin/bash

# 1. بررسی نصب Python3 و pip
echo "بررسی نصب Python3 و pip ..."
if ! command -v python3 &>/dev/null; then
    echo "Python3 نصب نیست. در حال نصب Python3 ..."
    sudo apt update
    sudo apt install python3 python3-pip -y
else
    echo "Python3 نصب است."
fi

if ! command -v pip3 &>/dev/null; then
    echo "pip3 نصب نیست. در حال نصب pip3 ..."
    sudo apt install python3-pip -y
else
    echo "pip3 نصب است."
fi

# 2. نصب پیش‌نیازها از requirements.txt
echo "در حال نصب پیش‌نیازها ..."
if [ ! -f "requirements.txt" ]; then
    echo "فایل requirements.txt یافت نشد، ایجاد آن..."
    cat > requirements.txt << EOF
aiogram==2.21.0
fastapi==0.75.0
psycopg2==2.9.3
python-dotenv==0.19.2
EOF
fi

pip3 install -r requirements.txt

# 3. ایجاد فایل .env برای توکن و آیدی ادمین
echo "مرحله 1: تنظیمات اولیه ربات تلگرام"
read -p "لطفاً توکن ربات تلگرام خود را وارد کنید: " BOT_TOKEN
read -p "لطفاً آیدی عددی ادمین خود را وارد کنید: " ADMIN_ID

if [ -z "$BOT_TOKEN" ] || [ -z "$ADMIN_ID" ]; then
    echo "توکن یا آیدی ادمین نمی‌تواند خالی باشد. لطفاً دوباره امتحان کنید."
    exit 1
fi

echo "BOT_TOKEN=$BOT_TOKEN" > .env
echo "ADMIN_ID=$ADMIN_ID" >> .env

# 4. ایجاد اسکریپت اصلی ربات
echo "در حال ایجاد فایل اصلی ربات..."

cat > main.py << EOF
from aiogram import Bot, Dispatcher, types
from aiogram.utils import executor
import os
from dotenv import load_dotenv

# بارگذاری فایل .env
load_dotenv()

# دریافت توکن از فایل .env
bot = Bot(token=os.getenv("BOT_TOKEN"))
dp = Dispatcher(bot)

# آیدی ادمین از فایل .env
ADMIN_ID = os.getenv("ADMIN_ID")

@dp.message_handler(commands=['start'])
async def start(message: types.Message):
    await message.reply(f"سلام! ربات با توکن {os.getenv('BOT_TOKEN')} فعال است.")

if __name__ == "__main__":
    executor.start_polling(dp, skip_updates=True)
EOF

# 5. دستورالعمل‌های بعد از نصب
echo "تمام مراحل نصب با موفقیت انجام شد. شما می‌توانید ربات را با دستور زیر اجرا کنید:"
echo "python3 main.py"
