from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from database import get_db
from models import Patient
from schemas import PatientSignupSchema, PatientLoginSchema
from auth.auth_handler import get_password_hash, verify_password

router = APIRouter(prefix="/patients", tags=["Patients"])

# -------------------- PATIENT SIGNUP --------------------
@router.post("/signup")
def signup(data: PatientSignupSchema, db: Session = Depends(get_db)):
    # ✅ Check if patient already exists
    existing = db.query(Patient).filter(Patient.e_mail == data.e_mail).first()
    if existing:
        raise HTTPException(status_code=400, detail="Patient already exists")

    # ✅ Validate confirm password
    if data.password != data.conform_password:
        raise HTTPException(status_code=400, detail="Passwords do not match")

    # ✅ Hash password
    hashed_pw = get_password_hash(data.password)

    # ✅ Create new patient record
    new_patient = Patient(
        first_name=data.first_name,
        second_name=data.second_name,
        e_mail=data.e_mail,
        password=hashed_pw,
        conform_password=hashed_pw,  # Store same after validation
        gender=data.gender,
        age=data.age,
        blood_group=data.blood_group,
        city=data.city,
        country=data.country
    )

    db.add(new_patient)
    db.commit()
    db.refresh(new_patient)

    # ✅ Generate prefixed patient_id like P1, P2...
    new_patient.patient_id = f"P{new_patient.id}"
    db.commit()

    return {
        "message": "Patient signup successful",
        "patient_id": new_patient.patient_id,
        "patient_email": new_patient.e_mail
    }


# -------------------- PATIENT SIGNIN --------------------
@router.post("/signin")
def signin(data: PatientLoginSchema, db: Session = Depends(get_db)):
    # ✅ Verify user exists
    user = db.query(Patient).filter(Patient.e_mail == data.e_mail).first()
    if not user:
        raise HTTPException(status_code=404, detail="Patient not found")

    # ✅ Check password
    if not verify_password(data.password, user.password):
        raise HTTPException(status_code=401, detail="Incorrect password")

    return {
        "message": "Login successful",
        "patient_id": user.patient_id,
        "email": user.e_mail
    }

@router.get("/")
def get_all_patients(db: Session = Depends(get_db)):
    patients = db.query(Patient).all()
    return patients


# -------------------- GET SINGLE PATIENT --------------------
@router.get("/{patient_id}")
def get_patient(patient_id: str, db: Session = Depends(get_db)):
    patient = db.query(Patient).filter(Patient.patient_id == patient_id).first()
    if not patient:
        raise HTTPException(status_code=404, detail="Patient not found")
    return patient


# -------------------- UPDATE PATIENT --------------------
@router.put("/{patient_id}")
def update_patient(patient_id: str, data: PatientSignupSchema, db: Session = Depends(get_db)):
    patient = db.query(Patient).filter(Patient.patient_id == patient_id).first()
    if not patient:
        raise HTTPException(status_code=404, detail="Patient not found")

    # Update fields
    patient.first_name = data.first_name
    patient.second_name = data.second_name
    patient.e_mail = data.e_mail
    patient.gender = data.gender
    patient.age = data.age
    patient.blood_group = data.blood_group
    patient.city = data.city
    patient.country = data.country

    db.commit()
    db.refresh(patient)
    return {"message": "Patient details updated successfully", "patient_id": patient.patient_id}
