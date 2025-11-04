from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import validates
from database import Base

class PatientDetails(Base):
    __tablename__ = "patient_details"

    patient_id = Column(Integer, primary_key=True, autoincrement=True)
    first_name = Column(String(50), nullable=False)
    second_name = Column(String(50), nullable=False)
    e_mail = Column(String(100), unique=True, nullable=False)
    password = Column(String(255), nullable=False)
    gender = Column(String(20))
    age = Column(Integer)
    blood_group = Column(String(10))
    city = Column(String(100))
    country = Column(String(100))

    # SQLAlchemy field-level validation
    @validates("e_mail")
    def validate_gmail(self, key, address):
        if not address.endswith("@gmail.com"):
            raise ValueError("Only Gmail addresses are allowed")
        return address
