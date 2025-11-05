from pydantic import BaseModel, EmailStr, validator,Field

class SignupSchema(BaseModel):
    first_name: str
    last_name: str| None=None
    e_mail: EmailStr
    password: str
    confirm_password: str
    gender: str | None = None
    age: int | None = Field(
        default=None, 
        ge=12,        # greater than or equal to 12
        le=100,      # less than or equal to 100
        description="Age must be between 12 to 100"
    )
    blood_group: str | None = None
    city: str | None = None
    country: str | None = None

    # Field-level validation (API layer)
    @validator("e_mail")
    def gmail_only(cls, v):
        if not v.endswith("@gmail.com"):
            raise ValueError("Only Gmail addresses are allowed")
        return v

    @validator("confirm_password")
    def passwords_match(cls, v, values):
        if "password" in values and v != values["password"]:
            raise ValueError("Passwords do not match")
        return v

class LoginSchema(BaseModel):
    e_mail: EmailStr
    password: str