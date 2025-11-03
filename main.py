# main.py
from fastapi import FastAPI, Depends, HTTPException, status
from sqlalchemy.orm import Session
from database import SessionLocal, engine

import models
from pydantic import BaseModel
from passlib.context import CryptContext

# Create tables
models.Base.metadata.create_all(bind=engine)

app = FastAPI(title='hospital management')

# Password hashing
pwd_context = CryptContext(schemes=["argon2"], deprecated="auto")

# Dependency to get DB session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# Pydantic Schemas
class SignupSchema(BaseModel):
    first_name: str
    last_name: str | None = None
    gmail: str
    password: str
    contacts: str | None = None

class LoginSchema(BaseModel):
    gmail: str
    password: str


@app.get('/',status_code=201)
def main_page():
    return {"message":"WELCOME COME TO FASTAPI/HOSPITAL MANAGEMENT SYSTEM"}
# Signup endpoint
@app.post("/signup")
def signup(user: SignupSchema, db: Session = Depends(get_db)):
    existing_user = db.query(models.UsersSignup).filter(models.UsersSignup.gmail == user.gmail).first()
    if existing_user:
        raise HTTPException(status_code=400, detail="User already exists")

    hashed_pw = pwd_context.hash(user.password)
    new_user = models.UsersSignup(
        first_name=user.first_name,
        last_name=user.last_name,
        gmail=user.gmail,
        password=hashed_pw,
        contacts=user.contacts,
    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)

    return {"message": "Signup successful", "user_id": new_user.id}

# Signin endpoint
@app.post("/signin")
def signin(user: LoginSchema, db: Session = Depends(get_db)):
    db_user = db.query(models.UsersSignup).filter(models.UsersSignup.gmail == user.gmail).first()
    if not db_user:
        raise HTTPException(status_code=404, detail="User not found")

    if not pwd_context.verify(user.password, db_user.password):
        raise HTTPException(status_code=401, detail="Incorrect password")

    return {"message": "Signin successful", "user": db_user.gmail}
