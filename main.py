from fastapi import FastAPI
import models
from database import engine
from schemas import SignupSchema


app=FastAPI()
