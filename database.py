from sqlalchemy import create_engine
<<<<<<< HEAD
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# Supabase PostgreSQL connection string
DATABASE_URL = "postgresql://postgres:uttejreddy2025@db.ccfynwuswlcbcldkjvdk.supabase.co:5432/postgres"

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()
=======
from sqlalchemy.orm import declarative_base, sessionmaker

DATABASE_URL = "postgresql://postgres:uttejreddy2025@db.ccfynwuswlcbcldkjvdk.supabase.co:5432/postgres"

engine = create_engine(DATABASE_URL, echo=True)

SessionLocal = sessionmaker(bind=engine)

Base = declarative_base()


# Dependency to get DB session in FastAPI
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
>>>>>>> 4711df5a9b568504e128fa325d0d0cfda0150ffb
