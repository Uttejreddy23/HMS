from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# ⚙️ Replace with your Supabase PostgreSQL connection URL
DATABASE_URL = "postgresql://postgres:uttejreddy2025@db.ccfynwuswlcbcldkjvdk.supabase.co:5432/postgres"

# 🔗 SQLAlchemy setup
engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

# ✅ DB dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
