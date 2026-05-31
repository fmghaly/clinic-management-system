# clinic-management-system
Project 3 is a complete MySQL database project for managing clinic departments, clinics, doctors, patients, appointments, diagnoses, and payments. It also includes a simple Flask web application for bonus marks.
Project Features
Conceptual design and ER explanation in `report/report_content.md`
MySQL schema with primary keys, foreign keys, `NOT NULL`, `UNIQUE`, and `CHECK` constraints
Realistic test data with at least 10 records in every table
Patient ID `12527` included for the required payment query
Cardiology department and cardiology clinics included
Fatty liver appointments included within the last year
Report views and required SQL queries
Optional Flask UI connected to MySQL
Folder Structure
```text
clinic_management_project/
├── database/
│   ├── schema.sql
│   ├── insert_data.sql
│   ├── views.sql
│   ├── queries.sql
│   ├── complete_project.sql
│   └── run_all.sql
├── app/
│   ├── app.py
│   ├── db_config.py
│   ├── requirements.txt
│   ├── templates/
│   └── static/
├── report/
│   └── report_content.md
└── README.md
```
How to Create the Database
Open MySQL from the `database` folder:
```bash
cd clinic_management_project/database
mysql -u root -p
```
Run the scripts in order:
```sql
SOURCE schema.sql;
SOURCE insert_data.sql;
SOURCE views.sql;
SOURCE queries.sql;
```
You can also run everything from MySQL with:
```sql
SOURCE run_all.sql;
```
For a single-file submission, run:
```sql
SOURCE complete_project.sql;
```
Or from the terminal:
```bash
mysql -u root -p < complete_project.sql
```
Tables and Relationships
`Department(department_id, department_name)`
`Clinic(clinic_id, clinic_name, address, department_id)`
`Doctor(doctor_id, doctor_name, phone_number, address, department_id)`
`Patient(patient_id, patient_name, phone_number, address, birth_date, job)`
`Appointment(appointment_id, appointment_date, patient_id, doctor_id, start_time, end_time, cost, status, diagnosis)`
Relationships:
One department has many clinics.
One department has many doctors.
One patient has many appointments.
One doctor has many appointments.
Each clinic, doctor, and appointment must belong to its parent entity.
Useful Views
`appointment_details_view`: joins appointments with patient, doctor, and department data.
`patient_payment_summary_view`: shows appointment count and total paid per patient.
`doctor_schedule_view`: shows each doctor's appointment schedule.
`department_revenue_view`: shows revenue per department.
Example Queries
The project includes all required queries in `database/queries.sql`, including:
Patients diagnosed with fatty liver in the last year
Addresses of cardiology clinics
Total money paid by patient ID `12527` in the last three years
Appointments with patient and doctor names
Appointment count per department
Doctors with appointment counts
Patient total payments
Upcoming scheduled appointments
Postponed appointments
Most common diagnoses
Revenue per department
How to Run the Flask Application
First create and populate the database using the SQL scripts.
Then update environment variables if your MySQL username, password, host, port, or database name is different. `app/db_config.py` reads these values:
```python
import os

DB_CONFIG = {
    "host": os.getenv("DB_HOST", "localhost"),
    "port": int(os.getenv("DB_PORT", "3306")),
    "user": os.getenv("DB_USER", "root"),
    "password": os.getenv("DB_PASSWORD", ""),
    "database": os.getenv("DB_NAME", "clinic_management_system"),
}
```
Install dependencies and run the app:
```bash
cd clinic_management_project/app
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python app.py
```
If the database is running on a non-default port, for example `3307`, run:
```bash
DB_PORT=3307 python app.py
```
Open:
```text
http://127.0.0.1:5000
```
The UI allows viewing departments, clinics, doctors, patients, appointments, adding patients, adding appointments, searching appointments, and showing payment totals.
