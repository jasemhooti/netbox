import os
import subprocess
import sys

def check_python_and_pip():
    """ بررسی نصب Python و pip """
    print("بررسی نصب Python و pip...")

    # بررسی نسخه Python
    try:
        python_version = subprocess.check_output(['python3', '--version'])
        print(f"Python version: {python_version.decode('utf-8')}")
    except FileNotFoundError:
        print("Python3 نصب نیست. لطفاً Python3 را نصب کنید.")
        sys.exit(1)

    # بررسی pip
    try:
        subprocess.check_output(['pip3', '--version'])
        print("pip3 نصب است.")
    except FileNotFoundError:
        print("pip3 نصب نیست. نصب pip3 در حال انجام است...")
        subprocess.check_call([sys.executable, "-m", "ensurepip", "--upgrade"])

def install_requirements():
    """ نصب پیش‌نیازهای پروژه از requirements.txt """
    print("در حال نصب پیش‌نیازها از فایل requirements.txt...")
    if not os.path.isfile('requirements.txt'):
        print("فایل requirements.txt یافت نشد، ایجاد آن...")
        requirements = """
        aiogram==2.21.0
        fastapi==0.75.0
        psycopg2==2.9.3
        python-dotenv==0.19.2
        """
        with open('requirements.txt', 'w') as f:
            f.write(requirements)

    subprocess.check_call([sys.executable, "-m", "pip", "install", "-r", 'requirements.txt'])
    print("پیش‌نیازها با موفقیت نصب شدند.")

def create_env_file():
    """ ایجاد فایل .env برای توکن ربات و آیدی ادمین """
    print("مرحله 1: تنظیمات اولیه ربات تلگرام")

    bot_token = input("لطفاً توکن ربات تلگرام خود را وارد کنید: ")
    admin_id = input("لطفاً آیدی عددی ادمین خود را وارد کنید: ")

    if not bot_token or not admin_id:
        print("توکن یا آیدی ادمین نمی‌تواند خالی باشد. لطفاً دوباره امتحان کنید.")
        return

    with open(".env", "w") as f:
        f.write(f"BOT_TOKEN={bot_token}\n")
        f.write(f"ADMIN_ID={admin_id}\n")

    print("اطلاعات ذخیره شد. فایل .env با موفقیت ایجاد شد.")

def create_bot_script():
    """ ایجاد اسکریپت اصلی ربات """
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
    """ اجرای تمام مراحل نصب """
    print("شروع نصب و راه‌اندازی ربات تلگرام...")

    # بررسی نصب Python و pip
    check_python_and_pip()

    # نصب پیش‌نیازها از requirements.txt
    install_requirements()

    # ایجاد فایل .env
    create_env_file()

    # ایجاد اسکریپت اصلی ربات
    create_bot_script()

    print("تمام مراحل نصب با موفقیت انجام شد. شما می‌توانید ربات را با دستور python3 main.py اجرا کنید.")

if __name__ == "__main__":
    main()
