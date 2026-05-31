from flask import Flask, flash, redirect, render_template, request, url_for
import mysql.connector
from mysql.connector import Error

from db_config import DB_CONFIG

app = Flask(__name__)
app.secret_key = "clinic-management-demo-key"


def get_connection():
    return mysql.connector.connect(**DB_CONFIG)


def fetch_all(query, params=None):
    connection = get_connection()
    cursor = connection.cursor(dictionary=True)
    cursor.execute(query, params or ())
    rows = cursor.fetchall()
    cursor.close()
    connection.close()
    return rows


def execute_query(query, params=None):
    connection = get_connection()
    cursor = connection.cursor()
    cursor.execute(query, params or ())
    connection.commit()
    cursor.close()
    connection.close()


@app.route("/")
def index():
    stats = {
        "departments": fetch_all("SELECT COUNT(*) AS count FROM Department")[0]["count"],
        "clinics": fetch_all("SELECT COUNT(*) AS count FROM Clinic")[0]["count"],
        "doctors": fetch_all("SELECT COUNT(*) AS count FROM Doctor")[0]["count"],
        "patients": fetch_all("SELECT COUNT(*) AS count FROM Patient")[0]["count"],
        "appointments": fetch_all("SELECT COUNT(*) AS count FROM Appointment")[0]["count"],
    }
    return render_template("index.html", stats=stats)


@app.route("/departments")
def departments():
    rows = fetch_all("SELECT * FROM Department ORDER BY department_id")
    return render_template("table.html", title="Departments", rows=rows)


@app.route("/clinics")
def clinics():
    rows = fetch_all(
        """
        SELECT c.clinic_id, c.clinic_name, c.address, d.department_name
        FROM Clinic c
        JOIN Department d ON c.department_id = d.department_id
        ORDER BY c.clinic_id
        """
    )
    return render_template("table.html", title="Clinics", rows=rows)


@app.route("/doctors")
def doctors():
    rows = fetch_all(
        """
        SELECT d.doctor_id, d.doctor_name, d.phone_number, d.address, dep.department_name
        FROM Doctor d
        JOIN Department dep ON d.department_id = dep.department_id
        ORDER BY d.doctor_id
        """
    )
    return render_template("table.html", title="Doctors", rows=rows)


@app.route("/patients")
def patients():
    rows = fetch_all("SELECT * FROM Patient ORDER BY patient_id")
    return render_template("patients.html", rows=rows)


@app.route("/appointments")
def appointments():
    rows = fetch_all(
        """
        SELECT appointment_id, appointment_date, start_time, end_time,
               patient_name, doctor_name, department_name, status, diagnosis, cost
        FROM appointment_details_view
        ORDER BY appointment_date DESC, start_time
        """
    )
    return render_template("appointments.html", rows=rows)


@app.route("/patients/add", methods=["GET", "POST"])
def add_patient():
    if request.method == "POST":
        try:
            execute_query(
                """
                INSERT INTO Patient
                (patient_id, patient_name, phone_number, address, birth_date, job)
                VALUES (%s, %s, %s, %s, %s, %s)
                """,
                (
                    request.form["patient_id"],
                    request.form["patient_name"],
                    request.form["phone_number"],
                    request.form["address"],
                    request.form["birth_date"],
                    request.form["job"],
                ),
            )
            flash("Patient added successfully.", "success")
            return redirect(url_for("patients"))
        except Error as exc:
            flash(f"Could not add patient: {exc}", "error")
    return render_template("add_patient.html")


@app.route("/appointments/add", methods=["GET", "POST"])
def add_appointment():
    patients_list = fetch_all("SELECT patient_id, patient_name FROM Patient ORDER BY patient_name")
    doctors_list = fetch_all("SELECT doctor_id, doctor_name FROM Doctor ORDER BY doctor_name")

    if request.method == "POST":
        try:
            execute_query(
                """
                INSERT INTO Appointment
                (appointment_id, appointment_date, patient_id, doctor_id,
                 start_time, end_time, cost, status, diagnosis)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
                """,
                (
                    request.form["appointment_id"],
                    request.form["appointment_date"],
                    request.form["patient_id"],
                    request.form["doctor_id"],
                    request.form["start_time"],
                    request.form["end_time"],
                    request.form["cost"],
                    request.form["status"],
                    request.form["diagnosis"],
                ),
            )
            flash("Appointment added successfully.", "success")
            return redirect(url_for("appointments"))
        except Error as exc:
            flash(f"Could not add appointment: {exc}", "error")

    return render_template(
        "add_appointment.html",
        patients=patients_list,
        doctors=doctors_list,
        statuses=["scheduled", "in progress", "postponed", "completed", "cancelled"],
    )


@app.route("/search")
def search():
    patient_name = request.args.get("patient_name", "").strip()
    doctor_name = request.args.get("doctor_name", "").strip()
    rows = []

    if patient_name or doctor_name:
        rows = fetch_all(
            """
            SELECT appointment_id, appointment_date, start_time, end_time,
                   patient_name, doctor_name, department_name, status, diagnosis, cost
            FROM appointment_details_view
            WHERE (%s = '' OR patient_name LIKE CONCAT('%%', %s, '%%'))
              AND (%s = '' OR doctor_name LIKE CONCAT('%%', %s, '%%'))
            ORDER BY appointment_date DESC, start_time
            """,
            (patient_name, patient_name, doctor_name, doctor_name),
        )

    return render_template(
        "search.html",
        rows=rows,
        patient_name=patient_name,
        doctor_name=doctor_name,
    )


@app.route("/payments", methods=["GET", "POST"])
def payments():
    patients_list = fetch_all("SELECT patient_id, patient_name FROM Patient ORDER BY patient_name")
    summary = None

    if request.method == "POST":
        patient_id = request.form["patient_id"]
        results = fetch_all(
            """
            SELECT patient_id, patient_name, appointment_count, total_paid
            FROM patient_payment_summary_view
            WHERE patient_id = %s
            """,
            (patient_id,),
        )
        if results:
            summary = results[0]

    return render_template("payments.html", patients=patients_list, summary=summary)


if __name__ == "__main__":
    app.run(debug=True)
