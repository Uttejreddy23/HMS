from sqlalchemy import Column, Integer, String
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
