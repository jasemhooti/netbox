import os

def create_env_file():
    print("مرحله 1: تنظیمات اولیه ربات تلگرام")

    # گرفتن توکن و آیدی ادمین از کاربر
    bot_token = input("لطفاً توکن ربات تلگرام خود را وارد کنید: ")
    admin_id = input("لطفاً آیدی عددی ادمین خود را وارد کنید: ")

    # بررسی اینکه کاربر توکن و آیدی را وارد کرده باشد
    if not bot_token or not admin_id:
        print("توکن یا آیدی ادمین نمی‌تواند خالی باشد. لطفاً دوباره امتحان کنید.")
        return

    # ذخیره این اطلاعات در فایل .env
    with open(".env", "w") as f:
        f.write(f"BOT_TOKEN={bot_token}\n")
        f.write(f"ADMIN_ID={admin_id}\n")

    print("اطلاعات ذخیره شد. فایل .env با موفقیت ایجاد شد.")

def check_and_install_requirements():
    # بررسی وجود فایل requirements.txt و نصب پکیج‌ها
    if not os.path.isfile('requirements.txt'):
        print("فایل requirements.txt یافت نشد. ایجاد فایل و نصب پیش نیازها...")
        requirements = """
        aiogram==2.21.0
        fastapi==0.75.0
        psycopg2==2.9.3
        python-dotenv==0.19.2
        """
        with open('requirements.txt', 'w') as f:
            f.write(requirements)

    print("در حال نصب پیش‌نیازها از فایل requirements.txt...")
    os.system('pip3 install -r requirements.txt')

def create_bot_script():
    # ایجاد فایل اصلی ربات (main.py) که از توکن و آیدی استفاده می‌کند
    print("در حال ایجاد فایل اصلی ربات...")

    bot_script = """
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
"""
    with open('main.py', 'w') as f:
        f.write(bot_script)

    print("فایل اصلی ربات (main.py) با موفقیت ایجاد شد.")

def main():
    print("شروع نصب و راه‌اندازی ربات تلگرام...")

    # مرحله اول: ایجاد فایل .env
    create_env_file()

    # مرحله دوم: نصب پکیج‌ها از requirements.txt
    check_and_install_requirements()

    # مرحله سوم: ایجاد اسکریپت اصلی ربات
    create_bot_script()

    print("تمام مراحل نصب با موفقیت انجام شد. شما می‌توانید ربات را با دستور python3 main.py اجرا کنید.")

if __name__ == "__main__":
    main()
