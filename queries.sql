-- Required and additional queries for Project 3: Clinic Management System
-- Run this script after schema.sql, insert_data.sql, and views.sql.

USE clinic_management_system;

-- 1. Required: List names of patients diagnosed with fatty liver in the last year.
SELECT DISTINCT p.patient_name
FROM Patient p
JOIN Appointment a ON p.patient_id = a.patient_id
WHERE LOWER(a.diagnosis) LIKE '%fatty liver%'
  AND a.appointment_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

-- 2. Required: List the addresses of cardiology clinics.
SELECT c.clinic_name, c.address
FROM Clinic c
JOIN Department d ON c.department_id = d.department_id
WHERE d.department_name = 'Cardiology';

-- 3. Required: List the total money paid by patient ID 12527 in the last three years.
SELECT
    p.patient_id,
    p.patient_name,
    SUM(a.cost) AS total_paid_last_three_years
FROM Patient p
JOIN Appointment a ON p.patient_id = a.patient_id
WHERE p.patient_id = 12527
  AND a.status <> 'cancelled'
  AND a.appointment_date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
GROUP BY p.patient_id, p.patient_name;

-- Additional: List all appointments with patient and doctor names.
SELECT
    appointment_id,
    appointment_date,
    start_time,
    end_time,
    patient_name,
    doctor_name,
    department_name,
    status,
    diagnosis,
    cost
FROM appointment_details_view
ORDER BY appointment_date, start_time;

-- Additional: Count appointments per department.
SELECT
    dep.department_name,
    COUNT(a.appointment_id) AS appointment_count
FROM Department dep
LEFT JOIN Doctor d ON dep.department_id = d.department_id
LEFT JOIN Appointment a ON d.doctor_id = a.doctor_id
GROUP BY dep.department_id, dep.department_name
ORDER BY appointment_count DESC;

-- Additional: List doctors with number of appointments.
SELECT
    d.doctor_id,
    d.doctor_name,
    COUNT(a.appointment_id) AS appointment_count
FROM Doctor d
LEFT JOIN Appointment a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.doctor_name
ORDER BY appointment_count DESC, d.doctor_name;

-- Additional: List patients with total payments.
SELECT *
FROM patient_payment_summary_view
ORDER BY total_paid DESC;

-- Additional: List upcoming scheduled appointments.
SELECT *
FROM appointment_details_view
WHERE status = 'scheduled'
  AND appointment_date >= CURDATE()
ORDER BY appointment_date, start_time;

-- Additional: List postponed appointments.
SELECT *
FROM appointment_details_view
WHERE status = 'postponed'
ORDER BY appointment_date, start_time;

-- Additional: List most common diagnoses.
SELECT
    diagnosis,
    COUNT(*) AS diagnosis_count
FROM Appointment
WHERE diagnosis IS NOT NULL
GROUP BY diagnosis
ORDER BY diagnosis_count DESC, diagnosis;

-- Additional: List revenue per department.
SELECT *
FROM department_revenue_view
ORDER BY total_revenue DESC;
