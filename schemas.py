from pydantic import BaseModel, EmailStr, validator
import re

# -------------------- PATIENT --------------------
from pydantic import BaseModel, EmailStr, validator

class PatientSignupSchema(BaseModel):
    first_name: str
    second_name: str | None = None
    e_mail: EmailStr
    password: str
    conform_password: str
    gender: str | None = None
    age: int | None = None
    blood_group: str | None = None
    city: str | None = None
    country: str | None = None

    @validator("e_mail")
    def validate_gmail(cls, v):
        if not v.endswith("@gmail.com"):
            raise ValueError("Only Gmail addresses are allowed (must end with @gmail.com)")
        return v


class PatientLoginSchema(BaseModel):
    e_mail: EmailStr
    password: str



# -------------------- DOCTOR --------------------
class DoctorLoginSchema(BaseModel):
    gmail: EmailStr
    password: str

    @validator("gmail")
    def validate_gmail(cls, v):
        if not v.endswith("@gmail.com"):
            raise ValueError("Only Gmail addresses are allowed (must end with @gmail.com)")
        return v


# -------------------- ADMIN --------------------
class AdminLoginSchema(BaseModel):
    gmail: EmailStr
    password: str

    @validator("gmail")
    def validate_gmail(cls, v):
        if not v.endswith("@gmail.com"):
            raise ValueError("Only Gmail addresses are allowed (must end with @gmail.com)")
        return v
