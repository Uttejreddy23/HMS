# database.py
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# # DATABASE_URL = "postgresql://postgres:1234@localhost:5432/HMDB"  
# # DATABASE_URL="postgresql://postgres:[Nexnora14@]@db.ccfynwuswlcbcldkjvdk.supabase.co:5432/postgres"
# DATABASE_URL="postgresql://postgres:[Nexnora14@]@db.ccfynwuswlcbcldkjvdk.supabase.co:5432/postgres"
DATABASE_URL = "postgresql://postgres:uttejreddy2025@db.ccfynwuswlcbcldkjvdk.supabase.co:5432/postgres"


engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()
