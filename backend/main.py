from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class GameResult(BaseModel):
    user_id: str
    xp_gained: int
    coins: int

@app.get("/")
def read_root():
    return {"status": "FastAPI is running on Render"}

@app.post("/validate-save")
async def validate_save(result: GameResult):
    if result.xp_gained > 1000: 
        return {"success": False, "message": "XP gain exceeds limits"}
    
    return {"success": True, "data_received": result}