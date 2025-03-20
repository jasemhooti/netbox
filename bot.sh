#!/bin/bash

# توکن ربات
BOT_TOKEN="YOUR_BOT_TOKEN"
CHAT_ID="YOUR_CHAT_ID"  # ID چت یا گروه برای ارسال پیام
MESSAGE="سلام! من ربات تلگرام هستم."

# ارسال پیام به ربات تلگرام با استفاده از API
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" -d "chat_id=$CHAT_ID&text=$MESSAGE"
