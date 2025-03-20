import asyncio

async def auto_approve():
    """تأیید خودکار بعد از ۵ دقیقه"""
    await asyncio.sleep(300)  # 5 دقیقه
    # ایجاد کانفیگ جدید و ارسال به کاربر
    config = xui.create_config(user_id, plan)
    await bot.send_message(user_id, f"✅ کانفیگ شما آماده است:\n{config}")
