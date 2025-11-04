from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from database import get_db
from models import Doctor
from schemas import DoctorLoginSchema
from auth.auth_handler import verify_password

router = APIRouter(prefix="/doctors", tags=["Doctors"])

# -------------------- DOCTOR SIGNIN --------------------
@router.post("/signin")
def signin(data: DoctorLoginSchema, db: Session = Depends(get_db)):
    user = db.query(Doctor).filter(Doctor.gmail == data.gmail).first()
    if not user:
        raise HTTPException(status_code=404, detail="Doctor not found")
    if not verify_password(data.password, user.password):
        raise HTTPException(status_code=401, detail="Incorrect password")

    return {"message": "Doctor login successful", "doctor_id": user.id}
