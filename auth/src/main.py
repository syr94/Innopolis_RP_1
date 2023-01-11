from fastapi import FastAPI

app = FastAPI()

@app.get("/login")
async def auth():
    return {"page" : "login"}