CREATE INDEX idx_employee_id ON employee (employee_id);
CREATE INDEX idx_service_id ON service (service_id);
CREATE INDEX idx_appointment_employee_id ON appointment (employee_id);
CREATE INDEX idx_appointment_datetime ON appointment (datetime);
CREATE INDEX idx_employee_service_employee_id ON employee_service (employee_id);
CREATE INDEX idx_employee_service_service_id ON employee_service (service_id);

CREATE VIEW view_employee_schedule AS
SELECT
    e.name AS 'Employee Name',
        GROUP_CONCAT(DISTINCT s.name ORDER BY s.name ASC SEPARATOR ', ') AS 'Services Provided',
        CONCAT(DATE_FORMAT(a.datetime, '%H:%i'), '-', DATE_FORMAT(ADDTIME(a.datetime, INTERVAL s.duration MINUTE), '%H:%i')) AS 'Time Slot',
        s.name AS 'Kind of Service'
FROM
    employee e
        JOIN
    employee_service es ON e.employee_id = es.employee_id
        JOIN
    service s ON es.service_id = s.service_id
        JOIN
    appointment a ON e.employee_id = a.employee_id AND DATE(a.datetime) = CURDATE()
        GROUP BY
        e.name, a.datetime, s.name;