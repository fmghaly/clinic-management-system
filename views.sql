-- Useful report views for Project 3: Clinic Management System
-- Run this script after schema.sql and insert_data.sql.

USE clinic_management_system;

CREATE OR REPLACE VIEW appointment_details_view AS
SELECT
    a.appointment_id,
    a.appointment_date,
    a.start_time,
    a.end_time,
    a.cost,
    a.status,
    a.diagnosis,
    p.patient_id,
    p.patient_name,
    p.phone_number AS patient_phone,
    d.doctor_id,
    d.doctor_name,
    dep.department_id,
    dep.department_name
FROM Appointment a
JOIN Patient p ON a.patient_id = p.patient_id
JOIN Doctor d ON a.doctor_id = d.doctor_id
JOIN Department dep ON d.department_id = dep.department_id;

CREATE OR REPLACE VIEW patient_payment_summary_view AS
SELECT
    p.patient_id,
    p.patient_name,
    COUNT(a.appointment_id) AS appointment_count,
    COALESCE(SUM(CASE WHEN a.status <> 'cancelled' THEN a.cost ELSE 0 END), 0) AS total_paid
FROM Patient p
LEFT JOIN Appointment a ON p.patient_id = a.patient_id
GROUP BY p.patient_id, p.patient_name;

CREATE OR REPLACE VIEW doctor_schedule_view AS
SELECT
    d.doctor_id,
    d.doctor_name,
    dep.department_name,
    a.appointment_id,
    a.appointment_date,
    a.start_time,
    a.end_time,
    a.status,
    p.patient_name
FROM Doctor d
JOIN Department dep ON d.department_id = dep.department_id
LEFT JOIN Appointment a ON d.doctor_id = a.doctor_id
LEFT JOIN Patient p ON a.patient_id = p.patient_id;

CREATE OR REPLACE VIEW department_revenue_view AS
SELECT
    dep.department_id,
    dep.department_name,
    COUNT(a.appointment_id) AS appointment_count,
    COALESCE(SUM(CASE WHEN a.status <> 'cancelled' THEN a.cost ELSE 0 END), 0) AS total_revenue
FROM Department dep
LEFT JOIN Doctor d ON dep.department_id = d.department_id
LEFT JOIN Appointment a ON d.doctor_id = a.doctor_id
GROUP BY dep.department_id, dep.department_name;
