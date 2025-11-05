from fastapi import FastAPI , Depends
from schemas import SignupSchema , LoginSchema
app = FastAPI()
from database import Base, engine, get_db,SessionLocal
from models import PatientDetails  # or wherever your model is

Base.metadata.create_all(bind=engine)

from routers.patients import router as patient_router

app.include_router(patient_router)
