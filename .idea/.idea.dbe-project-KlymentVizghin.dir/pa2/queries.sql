SELECT employee.name AS employee_name, service.name AS service_name
FROM employee
         JOIN employee_service ON employee.employee_id = employee_service.employee_id
         JOIN service ON employee_service.service_id = service.service_id
WHERE employee.name = 'Alice Johnson';

SELECT employee.name AS employee_name, service.name AS service_name
FROM employee
         JOIN employee_service ON employee.employee_id = employee_service.employee_id
         JOIN service ON employee_service.service_id = service.service_id
WHERE service.name = 'Haircut';

SELECT employee.name AS employee_name, COUNT(appointment.employee_id) AS total_appointments
FROM employee
         JOIN appointment ON employee.employee_id = appointment.employee_id
GROUP BY employee.name
HAVING COUNT(appointment.employee_id) > 3;

SELECT service.name AS service_name, SUM(payment.amount) AS total_amount
FROM service
         JOIN appointment ON service.service_id = appointment.service_id
         JOIN payment ON appointment.appointment_id = payment.appointment_id
GROUP BY service.name
HAVING SUM(payment.amount) > 100;

SELECT service.name AS service_name, SUM(payment.amount) AS total_profit
FROM service
         JOIN appointment ON service.service_id = appointment.service_id
         JOIN payment ON appointment.appointment_id = payment.appointment_id
WHERE payment.date >= DATE_SUB(CURRENT_DATE(), INTERVAL 1 MONTH)
GROUP BY service.name
ORDER BY total_profit DESC;

SELECT employee.name AS employee_name, COUNT(appointment.appointment_id) AS total_appointments
FROM employee
         LEFT JOIN appointment ON employee.employee_id = appointment.employee_id
GROUP BY employee.name
ORDER BY total_appointments DESC;