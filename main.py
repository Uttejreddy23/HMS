from fastapi import FastAPI

app=FastAPI()

@app.get("/")
def get_all_users():
    return {"message":"login sucessfully"}