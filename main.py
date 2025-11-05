from fastapi import FastAPI , Depends
from database import Base, engine, get_db,SessionLocal
from models import PatientDetails , AppointmentBookingDetails # or wherever your model is
from appoin_schemas import AppointmentBase

app = FastAPI(title = "Hospital Management System")
@app.on_event("startup")
def startup():
    Base.metadata.create_all(bind=engine)

from routers.patients import router as patient_router 
from routers.appointments import router as appointment_router


app.include_router(patient_router)
app.include_router(appointment_router)


@app.get("/")
def root():
    return {"message": "Welcome to the Hospital Management System API!"}

