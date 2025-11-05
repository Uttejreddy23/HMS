from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from database import get_db
from models import AppointmentBookingDetails, PatientDetails
from appoin_schemas import AppointmentCreate, AppointmentResponse

router = APIRouter(
    prefix="/appointments",
    tags=["appointments"]
)

# Create a new appointment
@router.post("/", response_model=AppointmentResponse)
def create_appointment(appointment: AppointmentCreate, db: Session = Depends(get_db)):
    # Check if patient exists
    patient = db.query(PatientDetails).filter(PatientDetails.patient_id == appointment.patient_id).first()
    if not patient:
        raise HTTPException(status_code=404, detail="Patient not found")

    # Create appointment
    new_appointment = AppointmentBookingDetails(
        patient_id=appointment.patient_id,
        patient_name=appointment.patient_name,
        age=appointment.age,
        gender=appointment.gender,
        city=appointment.city,
        country=appointment.country,
        problem=appointment.problem,
        doctor_name=appointment.doctor_name,
        doctor_specialist=appointment.doctor_specialist,
        time_slot=appointment.time_slot,
        amount_doctor=appointment.amount_doctor,
        having_sugar=appointment.having_sugar,
        having_bp=appointment.having_bp,
        time_zone=appointment.time_zone
    )

    db.add(new_appointment)
    db.commit()
    db.refresh(new_appointment)

    return new_appointment


# Get all appointments
@router.get("/", response_model=list[AppointmentResponse])
def get_appointments(db: Session = Depends(get_db)):
    appointments = db.query(AppointmentBookingDetails).all()
    return appointments


# Get a single appointment by ID
@router.get("/{appointment_id}", response_model=AppointmentResponse)
def get_appointment(appointment_id: int, db: Session = Depends(get_db)):
    appointment = db.query(AppointmentBookingDetails).filter(AppointmentBookingDetails.appointment_id == appointment_id).first()
    if not appointment:
        raise HTTPException(status_code=404, detail="Appointment not found")
    return appointment
