-- Test data for Project 3: Clinic Management System
-- Run this script after schema.sql.

USE clinic_management_system;

INSERT INTO Department (department_id, department_name) VALUES
(1, 'Cardiology'),
(2, 'Gastroenterology'),
(3, 'Dermatology'),
(4, 'Pediatrics'),
(5, 'Orthopedics'),
(6, 'Neurology'),
(7, 'Ophthalmology'),
(8, 'ENT'),
(9, 'Internal Medicine'),
(10, 'Dental Medicine');

INSERT INTO Clinic (clinic_id, clinic_name, address, department_id) VALUES
(101, 'Heart Care Clinic', '12 Nile Street, Dokki, Giza', 1),
(102, 'Cardiology Follow-up Clinic', '45 Tahrir Street, Downtown Cairo', 1),
(103, 'Digestive Health Clinic', '18 Abbas El Akkad Street, Nasr City, Cairo', 2),
(104, 'Liver and Nutrition Clinic', '22 El Nozha Street, Heliopolis, Cairo', 2),
(105, 'Skin Care Clinic', '9 Makram Ebeid Street, Nasr City, Cairo', 3),
(106, 'Child Wellness Clinic', '31 Syria Street, Mohandessin, Giza', 4),
(107, 'Bone and Joint Clinic', '50 Gameat El Dewal Street, Mohandessin, Giza', 5),
(108, 'Brain and Nerve Clinic', '77 El Merghany Street, Heliopolis, Cairo', 6),
(109, 'Vision Clinic', '14 El Batal Ahmed Street, Mohandessin, Giza', 7),
(110, 'Ear Nose Throat Clinic', '60 Ramses Street, Cairo', 8);

INSERT INTO Doctor (doctor_id, doctor_name, phone_number, address, department_id) VALUES
(201, 'Dr. Ahmed Hassan', '0101000201', '15 Nile Street, Dokki, Giza', 1),
(202, 'Dr. Mona Ibrahim', '0101000202', '40 Tahrir Street, Downtown Cairo', 1),
(203, 'Dr. Karim Adel', '0101000203', '21 Abbas El Akkad Street, Nasr City, Cairo', 2),
(204, 'Dr. Sara Nabil', '0101000204', '19 El Nozha Street, Heliopolis, Cairo', 2),
(205, 'Dr. Laila Samir', '0101000205', '10 Makram Ebeid Street, Nasr City, Cairo', 3),
(206, 'Dr. Omar Youssef', '0101000206', '33 Syria Street, Mohandessin, Giza', 4),
(207, 'Dr. Hany Fawzy', '0101000207', '53 Gameat El Dewal Street, Mohandessin, Giza', 5),
(208, 'Dr. Dina Farouk', '0101000208', '75 El Merghany Street, Heliopolis, Cairo', 6),
(209, 'Dr. Tamer Said', '0101000209', '16 El Batal Ahmed Street, Mohandessin, Giza', 7),
(210, 'Dr. Nadia Lotfy', '0101000210', '62 Ramses Street, Cairo', 8);

INSERT INTO Patient (patient_id, patient_name, phone_number, address, birth_date, job) VALUES
(12527, 'Mostafa Mahmoud', '01120012527', '8 El Gezira Street, Zamalek, Cairo', '1985-04-12', 'Accountant'),
(12528, 'Farah Ghaly', '01120012528', '20 El Hegaz Street, Heliopolis, Cairo', '2001-09-21', 'Student'),
(12529, 'Youssef Ali', '01120012529', '13 Mostafa El Nahas Street, Nasr City, Cairo', '1994-01-15', 'Engineer'),
(12530, 'Mariam Samy', '01120012530', '44 Lebanon Street, Mohandessin, Giza', '1990-07-30', 'Teacher'),
(12531, 'Hassan Omar', '01120012531', '70 Faisal Street, Giza', '1978-11-03', 'Driver'),
(12532, 'Nour Khaled', '01120012532', '5 Makram Ebeid Street, Nasr City, Cairo', '1998-02-18', 'Pharmacist'),
(12533, 'Salma Ahmed', '01120012533', '3 Syria Street, Mohandessin, Giza', '1989-12-09', 'Designer'),
(12534, 'Omar Mostafa', '01120012534', '17 Ramses Street, Cairo', '2016-05-25', 'Student'),
(12535, 'Dalia Fathy', '01120012535', '24 Tahrir Street, Downtown Cairo', '1972-03-14', 'Banker'),
(12536, 'Khaled Nasser', '01120012536', '88 El Merghany Street, Heliopolis, Cairo', '1968-08-07', 'Retired');

INSERT INTO Appointment
(appointment_id, appointment_date, patient_id, doctor_id, start_time, end_time, cost, status, diagnosis) VALUES
(301, '2026-03-10', 12527, 203, '09:00:00', '09:30:00', 650.00, 'completed', 'Fatty liver'),
(302, '2025-09-18', 12528, 204, '10:00:00', '10:30:00', 600.00, 'completed', 'Fatty liver grade 1'),
(303, '2026-06-05', 12529, 201, '11:00:00', '11:30:00', 700.00, 'scheduled', 'Chest pain evaluation'),
(304, '2026-05-20', 12530, 202, '12:00:00', '12:30:00', 750.00, 'postponed', 'Hypertension follow-up'),
(305, '2024-11-15', 12531, 205, '13:00:00', '13:30:00', 400.00, 'completed', 'Eczema'),
(306, '2026-01-22', 12532, 206, '09:30:00', '10:00:00', 350.00, 'completed', 'Seasonal flu'),
(307, '2026-07-01', 12533, 207, '14:00:00', '14:45:00', 800.00, 'scheduled', 'Knee pain'),
(308, '2026-02-12', 12534, 208, '15:00:00', '15:30:00', 900.00, 'completed', 'Migraine'),
(309, '2025-12-03', 12535, 209, '16:00:00', '16:30:00', 500.00, 'completed', 'Myopia'),
(310, '2026-05-28', 12536, 210, '17:00:00', '17:30:00', 450.00, 'in progress', 'Sinusitis'),
(311, '2024-08-10', 12527, 201, '10:30:00', '11:00:00', 700.00, 'completed', 'Arrhythmia follow-up'),
(312, '2023-07-03', 12527, 202, '11:30:00', '12:00:00', 750.00, 'completed', 'High blood pressure'),
(313, '2026-04-14', 12529, 203, '12:30:00', '13:00:00', 650.00, 'completed', 'Gastritis'),
(314, '2026-06-10', 12528, 205, '13:30:00', '14:00:00', 400.00, 'cancelled', 'Acne consultation'),
(315, '2026-06-18', 12530, 204, '14:30:00', '15:00:00', 600.00, 'scheduled', 'Liver enzymes follow-up');
