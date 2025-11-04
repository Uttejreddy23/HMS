from fastapi import FastAPI
import models
from database import engine,Base
from schemas import SignupSchema
from routers import patients

Base.metadata.create_all(bind=engine)
app=FastAPI(title='SMARTKARE')

app.include_router(patients.router)

@app.get("/")
def root():
    return {"message":"patient details signup"}

