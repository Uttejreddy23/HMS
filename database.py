from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base
 
# ✅ Use the pooler connection on port 6543 (NOT 5432)
DATABASE_URL = "postgresql+psycopg2://postgres.opvjbhwagrevikzupgzx:viLvEXjJKDgI3tDT@aws-1-ap-southeast-2.pooler.supabase.com:6543/postgres"
 
# Create the SQLAlchemy engine with SSL
engine = create_engine(
    DATABASE_URL,
    connect_args={"sslmode": "require"}
)
 
# Create a session
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()
 
# Test the connection
try:
    with engine.connect() as conn:
        print("✅ Connected successfully via pooler!")
except Exception as e:
    print("❌ Error connecting:", e)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()