USE clinic_management_system; 

DELIMITER // 

CREATE TRIGGER prevent_doctor_appointment_overlap_insert 

BEFORE INSERT ON Appointment 

FOR EACH ROW 

BEGIN 

    IF EXISTS ( 

        SELECT 1 FROM Appointment 

        WHERE doctor_id = NEW.doctor_id 

          AND appointment_date = NEW.appointment_date 

          AND NEW.start_time < end_time 

          AND NEW.end_time > start_time 

    ) THEN 

        SIGNAL SQLSTATE '45000' 

        SET MESSAGE_TEXT = 'Doctor already has an overlapping appointment.'; 

    END IF; 

END// 

CREATE TRIGGER prevent_doctor_appointment_overlap_update 

BEFORE UPDATE ON Appointment 

FOR EACH ROW 

BEGIN 

    IF EXISTS ( 

        SELECT 1 FROM Appointment 

        WHERE doctor_id = NEW.doctor_id 

          AND appointment_date = NEW.appointment_date 

          AND appointment_id <> NEW.appointment_id 

          AND NEW.start_time < end_time 

          AND NEW.end_time > start_time 

    ) THEN 

        SIGNAL SQLSTATE '45000' 

        SET MESSAGE_TEXT = 'Doctor already has an overlapping appointment.'; 

    END IF; 

END// 

DELIMITER ; 