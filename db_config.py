import os

DB_CONFIG = {
    "host": os.getenv("DB_HOST", "localhost"),
    "port": int(os.getenv("DB_PORT", "3306")),
    "user": os.getenv("DB_USER", "clinic_user"),
    "password": os.getenv("DB_PASSWORD", "clinic123"),
    "database": os.getenv("DB_NAME", "clinic_management_system"),
}