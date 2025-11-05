from sqlalchemy import Column, Integer, String, ForeignKey, Float, Boolean
from sqlalchemy.orm import relationship
from database import Base

class PatientDetails(Base):
    __tablename__ = "patient_details"  # table name in PostgreSQL

    patient_id = Column(Integer, primary_key=True, index=True)
    first_name = Column(String(50), nullable=False)
    last_name = Column(String(50), nullable=True)
    e_mail = Column(String(100), unique=True, nullable=False, index=True)
    password = Column(String(255), nullable=False)
    gender = Column(String(10), nullable=True)
    age = Column(Integer, nullable=True)
    blood_group = Column(String(5), nullable=True)
    city = Column(String(50), nullable=True)
    country = Column(String(50), nullable=True)
    appointments = relationship("AppointmentBookingDetails", back_populates="patient")

class AppointmentBookingDetails(Base):
    __tablename__ = "appointment_booking_details"

    appointment_id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    patient_id = Column(Integer, ForeignKey("patient_details.patient_id"), nullable=False)  # FK to patient table
    patient_name = Column(String, nullable=False)
    age = Column(Integer, nullable=False)
    gender = Column(String, nullable=False)
    city = Column(String, nullable=False)
    country = Column(String, nullable=False)
    problem = Column(String, nullable=False)
    doctor_name = Column(String, nullable=False)
    doctor_specialist = Column(String, nullable=False)
    time_slot = Column(String, nullable=False)
    amount_doctor = Column(Float, nullable=False)
    having_sugar = Column(Boolean, default=False)
    having_bp = Column(Boolean, default=False)    
    time_zone = Column(String, nullable=True)

    # Relationship to PatientDetails
    patient = relationship("PatientDetails", back_populates="appointments")
    