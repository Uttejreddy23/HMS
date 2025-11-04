from fastapi import FastAPI
from database import Base, engine
from models import *
from routers import patients, doctors, admin

# Create tables in database
Base.metadata.create_all(bind=engine)

app = FastAPI(title="🏥Smart Hospital Management System")

# Include routes
app.include_router(patients.router)
app.include_router(doctors.router)
app.include_router(admin.router)

@app.get("/")
def home():
    return "Welcome to SmartCare Hospital Management system👨‍⚕️💊"
