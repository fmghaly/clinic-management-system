-- Project 3: Clinic Management System
-- Database schema for MySQL 8+

DROP DATABASE IF EXISTS clinic_management_system;
CREATE DATABASE clinic_management_system;
USE clinic_management_system;

-- Department stores the clinic's medical departments.
CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

-- Clinic stores physical clinics/branches that belong to departments.
CREATE TABLE Clinic (
    clinic_id INT PRIMARY KEY,
    clinic_name VARCHAR(120) NOT NULL,
    address VARCHAR(255) NOT NULL,
    department_id INT NOT NULL,
    CONSTRAINT uq_clinic_name_address UNIQUE (clinic_name, address),
    CONSTRAINT fk_clinic_department
        FOREIGN KEY (department_id)
        REFERENCES Department(department_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Doctor stores doctor information and the department each doctor belongs to.
CREATE TABLE Doctor (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(120) NOT NULL,
    phone_number VARCHAR(20) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL,
    department_id INT NOT NULL,
    CONSTRAINT fk_doctor_department
        FOREIGN KEY (department_id)
        REFERENCES Department(department_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- Patient stores patient personal and contact information.
CREATE TABLE Patient (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(120) NOT NULL,
    phone_number VARCHAR(20) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL,
    birth_date DATE NOT NULL,
    job VARCHAR(100)
);

-- Appointment stores appointments, payment cost, status, and diagnosis.
CREATE TABLE Appointment (
    appointment_id INT PRIMARY KEY,
    appointment_date DATE NOT NULL,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    cost DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    status VARCHAR(20) NOT NULL,
    diagnosis VARCHAR(255),
    CONSTRAINT fk_appointment_patient
        FOREIGN KEY (patient_id)
        REFERENCES Patient(patient_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_appointment_doctor
        FOREIGN KEY (doctor_id)
        REFERENCES Doctor(doctor_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_appointment_status
        CHECK (status IN ('scheduled', 'in progress', 'postponed', 'completed', 'cancelled')),
    CONSTRAINT chk_appointment_cost
        CHECK (cost >= 0),
    CONSTRAINT chk_appointment_time
        CHECK (end_time > start_time),
    CONSTRAINT uq_doctor_appointment_slot
        UNIQUE (doctor_id, appointment_date, start_time),
    CONSTRAINT uq_patient_appointment_slot
        UNIQUE (patient_id, appointment_date, start_time)
);
