import uuid
from sqlalchemy import Column, String,Integer
from database import Base

class Users(Base):
    __tablename__ = "patient_users"

    id = Column(Integer, primary_key=True, autoincrement=True)

    first_name = Column(String, nullable=False)
    last_name = Column(String, nullable=True)
    gmail = Column(String, nullable=False, unique=True)
    password = Column(String, nullable=False)
    contacts = Column(String, nullable=True, unique=True)
