from fastapi import FastAPI
from database import Base, engine
from routers import patients

Base.metadata.create_all(bind=engine)

app = FastAPI(title="SMARTKARE")
app.include_router(patients.router)

@app.get("/")
def root():
    return {"message": "Patient API running"}
