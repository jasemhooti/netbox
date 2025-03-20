@router.message(lambda msg: msg.photo)
async def receive_receipt(message: types.Message):
    """دریافت عکس رسید و ارسال به ادمین"""
    await message.photo[-1].download(f"receipts/{message.from_user.id}.jpg")
    await message.answer("✅ رسید دریافت شد، منتظر تأیید ادمین باشید.")

    admin_msg = f"🛒 کاربر @{message.from_user.username} خرید انجام داده است.\n📸 لطفاً رسید را بررسی کنید."
    await bot.send_photo(ADMIN_ID, message.photo[-1].file_id, caption=admin_msg)
