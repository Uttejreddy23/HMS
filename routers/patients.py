from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from passlib.context import CryptContext
from database import get_db
from models import PatientDetails
from schemas import SignupSchema, LoginSchema

router = APIRouter(
    prefix="/patients",
    tags=["patients"]
)

# Password hashing using Argon2
pwd_context = CryptContext(schemes=["argon2"], deprecated="auto")


# Signup route
@router.post("/signup")
def signup(user: SignupSchema, db: Session = Depends(get_db)):
    # Check if user already exists
    existing_user = db.query(PatientDetails).filter(PatientDetails.e_mail == user.e_mail).first()
    if existing_user:
        raise HTTPException(status_code=400, detail="User already exists")

    # Check password confirmation
    if user.password != user.confirm_password:
        raise HTTPException(status_code=400, detail="Passwords do not match")

    # Hash password
    hashed_pw = pwd_context.hash(user.password)

    # Create new patient record
    new_patient = PatientDetails(
        first_name=user.first_name,
        last_name=user.last_name,
        e_mail=user.e_mail,
        password=hashed_pw,
        gender=user.gender,
        age=user.age,
        blood_group=user.blood_group,
        city=user.city,
        country=user.country
    )

    db.add(new_patient)
    db.commit()
    db.refresh(new_patient)

    return {"message": "Signup successful", "patient_id": new_patient.patient_id}


# ✅ Signin route
@router.post("/signin")
def signin(user: LoginSchema, db: Session = Depends(get_db)):
    db_user = db.query(PatientDetails).filter(PatientDetails.e_mail == user.e_mail).first()
    if not db_user:
        raise HTTPException(status_code=404, detail="User not found")

    if not pwd_context.verify(user.password, db_user.password):
        raise HTTPException(status_code=401, detail="Incorrect password")

    return {
        "message": "Signin successful",
        "user": db_user.e_mail,
        "patient_id": db_user.patient_id
    }
