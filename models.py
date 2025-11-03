# models.py
import uuid
from sqlalchemy import Column, String
from database import Base

class UsersSignup(Base):
    __tablename__ = "patient_signup"

    id = Column(String, primary_key=True, default=lambda: str(uuid.uuid4()))
    first_name = Column(String, nullable=False)
    last_name = Column(String, nullable=True)
    gmail = Column(String, nullable=False, unique=True)
    password = Column(String, nullable=False)
    contacts = Column(String, nullable=True)


class UsersLogin(Base):
    __tablename__ = "patients_login"

    gmail = Column(String, nullable=False, primary_key=True)
    password = Column(String, nullable=False)

