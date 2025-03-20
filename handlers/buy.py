from aiogram import Router, types
from aiogram.filters import Command
from keyboards import buy_keyboard
import services.xui as xui

router = Router()

@router.message(Command("buy"))
async def show_plans(message: types.Message):
    """نمایش پلن‌های خرید VPN"""
    plans = [
        {"name": "10GB", "price": 50000},
        {"name": "50GB", "price": 200000},
        {"name": "100GB", "price": 350000},
    ]
    await message.answer("🔹 لطفاً حجم موردنظر را انتخاب کنید:", reply_markup=buy_keyboard(plans))

@router.callback_query(lambda call: call.data.startswith("buy_"))
async def buy_plan(call: types.CallbackQuery):
    """پرداخت کارت به کارت و تأیید خرید"""
    plan_id = call.data.split("_")[1]
    plan = {"10GB": 50000, "50GB": 200000, "100GB": 350000}.get(plan_id)

    if not plan:
        return await call.answer("❌ پلن نامعتبر است!")

    await call.message.answer(f"💰 قیمت: {plan} تومان\n🔻 لطفاً مبلغ را کارت به کارت کرده و رسید ارسال کنید.")
