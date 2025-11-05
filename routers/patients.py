from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from passlib.context import CryptContext
from database import get_db
from models import PatientDetails
from schemas import SignupSchema, LoginSchema

router = APIRouter(prefix="/patients", tags=["patients"])

pwd_context = CryptContext(schemes=["argon2"], deprecated="auto")

@router.post("/signup")
def signup(user: SignupSchema, db: Session = Depends(get_db)):
    existing_user = db.query(PatientDetails).filter(PatientDetails.e_mail == user.e_mail).first()
    if existing_user:
        raise HTTPException(status_code=400, detail="User already exists")

    hashed_pw = pwd_context.hash(user.password)

    new_patient = PatientDetails(
        first_name=user.first_name,
        last_name=user.last_name,
        e_mail=user.e_mail,
        password=hashed_pw
    )
    db.add(new_patient)
    db.commit()
    db.refresh(new_patient)
    return {"message": "Signup successful"}

@router.post("/signin")
def signin(user: LoginSchema, db: Session = Depends(get_db)):
    db_user = db.query(PatientDetails).filter(PatientDetails.e_mail == user.e_mail).first()
    if not db_user:
        raise HTTPException(status_code=404, detail="User not found")

    if not pwd_context.verify(user.password, db_user.password):
        raise HTTPException(status_code=401, detail="Incorrect password")

    return {"message": "Signin successful", "patient_id": db_user.patient_id}
