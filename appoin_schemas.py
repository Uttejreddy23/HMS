from pydantic import BaseModel, Field
from typing import Optional

class AppointmentBase(BaseModel):
    patient_id: int
    patient_name: str
    age: int = Field(..., ge=0, le=120)
    gender: str
    city: str
    country: str
    problem: str
    doctor_name: str
    doctor_specialist: str
    time_slot: str
    amount_doctor: float
    having_sugar: Optional[bool] = False
    having_bp: Optional[bool] = False
    time_zone: Optional[str] = None

class AppointmentCreate(AppointmentBase):
    """Schema for creating a new appointment"""
    pass

class AppointmentResponse(AppointmentBase):
    """Schema for returning appointment data with ID"""
    appointment_id: int

    class Config:
        from_attributes = True
