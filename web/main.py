from fastapi import FastAPI
from database import get_users, get_usage

app = FastAPI()

@app.get("/dashboard")
async def dashboard():
    users = await get_users()
    usage = await get_usage()
    return {"total_users": len(users), "total_usage": usage}
