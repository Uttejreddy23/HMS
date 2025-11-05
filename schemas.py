from pydantic import BaseModel, EmailStr

class SignupSchema(BaseModel):
    first_name: str
    last_name: str
    e_mail: EmailStr
    password: str

class LoginSchema(BaseModel):
    e_mail: EmailStr
    password: str
