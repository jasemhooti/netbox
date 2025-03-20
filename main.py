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
