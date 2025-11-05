from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from database import get_db
from models import Admin
from schemas import AdminLoginSchema
from auth.auth_handler import verify_password

router = APIRouter(prefix="/admin", tags=["Admin"])

@router.post("/signin")
def admin_signin(request: AdminLoginSchema, db: Session = Depends(get_db)):
    admin = db.query(Admin).filter(Admin.gmail == request.gmail).first()
    if not admin:
        raise HTTPException(status_code=404, detail="Admin not found")
    if not verify_password(request.password, admin.password):
        raise HTTPException(status_code=401, detail="Incorrect password")

    return {"message": "Admin signin successful", "admin_gmail": admin.gmail}
