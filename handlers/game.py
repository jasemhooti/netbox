@router.message(Command("game"))
async def start_game(message: types.Message):
    """ایجاد بازی و شرط‌بندی"""
    await message.answer("🎲 لطفاً مبلغ شرط را وارد کنید (حداقل ۵۰۰ تومان، حداکثر ۵ میلیون تومان).")

@router.message(lambda msg: msg.text.isdigit())
async def set_bet(message: types.Message):
    amount = int(message.text)
    if amount < 500 or amount > 5000000:
        return await message.answer("❌ مبلغ باید بین ۵۰۰ تا ۵ میلیون باشد.")

    # ذخیره شرط در دیتابیس و جستجوی رقیب
    await message.answer("🔍 در حال جستجوی رقیب...")
