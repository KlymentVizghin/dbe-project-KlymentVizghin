USE beauty_salon;

SELECT name, salary
FROM employee
WHERE salary = (
    SELECT MAX(salary)
    FROM employee
);
-- Retrieves the name and salary of employees whose salary equals the maximum salary among all employees.

SELECT name, position
FROM employee
WHERE position IN (
    SELECT DISTINCT position
    FROM employee
    WHERE salary > 2000
);
-- Retrieves the name and position of employees whose position is one of the positions held by employees with a salary greater than 2000.

SELECT name, position
FROM employee e
WHERE EXISTS (
    SELECT 1
    FROM appointment a
    WHERE a.employee_id = e.employee_id
);
-- Retrieves the name and position of employees who have at least one appointment.

SELECT name, salary
FROM employee e
WHERE salary = (
    SELECT AVG(salary)
    FROM employee
    WHERE position = e.position
);
-- Retrieves the name and salary of employees whose salary equals the average salary of employees in the same position.

SELECT name, position
FROM employee e
WHERE position IN (
    SELECT position
    FROM employee
    WHERE salary > e.salary
);
-- Retrieves the name and position of employees whose position is held by at least one employee with a higher salary.

SELECT name, position
FROM employee e
WHERE position NOT IN (
    SELECT position
    FROM employee
    WHERE salary > e.salary
);
-- Retrieves the name and position of employees whose position is not held by any employee with a higher salary.

SELECT name, position
FROM employee e
WHERE EXISTS (
    SELECT 1
    FROM appointment a
    WHERE a.employee_id = e.employee_id
      AND a.status = 'Confirmed'
);
-- Retrieves the name and position of employees who have at least one confirmed appointment.

SELECT name, position
FROM employee e
WHERE NOT EXISTS (
    SELECT 1
    FROM appointment a
    WHERE a.employee_id = e.employee_id
      AND a.status = 'Confirmed'
);
-- Retrieves the name and position of employees who have no confirmed appointments.

UPDATE service
SET price = 60.00
WHERE name = 'Haircut';
-- Update the price of the 'Haircut' service to $60.

UPDATE product
SET quantity = 10
WHERE name IN ('Shampoo', 'Face Mask');
-- Update the quantity of all products with names in a given list.

UPDATE appointment
SET status = 'Cancelled'
WHERE customer_id NOT IN (SELECT customer_id FROM customer WHERE name = 'John Doe');
-- Cancel all appointments not associated with a specific customer.

UPDATE employee
SET salary = salary + 500.00
WHERE EXISTS (
    SELECT 1
    FROM appointment
    WHERE Employee.employee_id = appointment.employee_id AND datetime = '2024-02-12');
-- Update the salary of all employees who have appointments scheduled for a specific date

UPDATE appointment
SET status = 'Cancelled'
WHERE NOT EXISTS (
    SELECT 1
    FROM payment
    WHERE appointment.appointment_id = payment.appointment_id
);
-- Cancel all appointments for customers who have not made any payments

UPDATE employee
SET salary = 4000.00
WHERE employee_id = (
    SELECT employee_id
    FROM employee
    ORDER BY salary DESC
    LIMIT 1
    );
-- Update the salary of the employee with the highest salary to $4000

UPDATE product
SET quantity = quantity - 1
WHERE product_id IN (
    SELECT product.product_id
    FROM product
             JOIN appointment ON product.product_id = appointment.service_id
    WHERE appointment.customer_id = 1
);
-- Update the quantity of all products associated with appointments made by a specific customer

UPDATE appointment
SET status = 'Cancelled'
WHERE service_id NOT IN (
    SELECT product_id
    FROM product
);
-- Cancel all appointments not associated with any product

UPDATE employee
SET salary = salary + 200.00
WHERE EXISTS (
    SELECT 1
    FROM appointment
    WHERE employee.employee_id = appointment.employee_id
      AND appointment.service_id = 1
);
-- Update the salary of all employees who have performed appointments for a specific service

UPDATE appointment
SET status = 'Canceled'
WHERE NOT EXISTS (
    SELECT 1
    FROM payment
    WHERE payment.appointment_id = appointment.appointment_id
);
-- Cancel all appointments that have not been paid for

DELETE FROM service
WHERE name = 'Manicure';
-- Delete the service with the name 'Manicure'

DELETE FROM product
WHERE name IN ('Shampoo', 'Nail Polish');
-- Delete shampoo and nail polish from the table of products

DELETE FROM appointment
WHERE customer_id NOT IN (SELECT customer_id FROM customer WHERE name = 'John Doe');
-- Delete all appointments not associated with a customer named John Doe

DELETE FROM payment
WHERE EXISTS (
    SELECT 1
    FROM payment
    WHERE payment.amount < 10.00
);
-- Delete all payments with an amount less than $10

DELETE FROM customer
WHERE NOT EXISTS (
    SELECT 1
    FROM appointment
    WHERE customer.customer_id = appointment.customer_id
);
-- Delete all customers who have not made any appointments

DELETE FROM appointment
WHERE appointment_id = (
    SELECT appointment_id
    FROM appointment
    ORDER BY appointment_id DESC
    LIMIT 1
    );
-- Delete the appointment with the highest appointment_id

DELETE FROM product
WHERE product_id IN (
    SELECT product.product_id
    FROM product
             JOIN appointment ON product.product_id = appointment.service_id
    WHERE appointment.customer_id = 1
);
-- Delete all products associated with appointments made by a specific customer

DELETE FROM appointment
WHERE appointment_id NOT IN (
    SELECT appointment_id
    FROM payment
);
-- Delete all appointments not associated with any product

DELETE FROM employee
WHERE EXISTS (
    SELECT 1
    FROM appointment
    WHERE employee.employee_id = appointment.employee_id
      AND appointment.service_id = 1
);
-- Delete all employees who have not performed appointments for a specific service

DELETE FROM customer
WHERE NOT EXISTS (
    SELECT 1
    FROM appointment
    WHERE customer.customer_id = appointment.customer_id
      AND appointment.service_id = 2
);
-- Delete all customers who have not made appointments with a specific service

SELECT name
FROM customer
         JOIN appointment ON customer.customer_id = appointment.customer_id

UNION

SELECT name
FROM customer
WHERE customer_id IN (SELECT customer_id FROM payment);
-- Retrieve the names of customers who have appointments and those who have made payments, without duplicates

SELECT name
FROM customer
         JOIN appointment ON customer.customer_id = appointment.customer_id

UNION ALL

SELECT name
FROM customer
WHERE customer_id IN (SELECT customer_id FROM payment);
-- Retrieve the names of customers who have appointments and those who have made payments, including duplicates

SELECT name
FROM customer
         JOIN appointment ON customer.customer_id = appointment.customer_id

INTERSECT

SELECT name
FROM customer
WHERE customer_id IN (SELECT customer_id FROM payment);
-- Retrieve the names of customers who have both appointments and payments

SELECT name
FROM customer
         JOIN appointment ON customer.customer_id = appointment.customer_id

INTERSECT

SELECT name
FROM customer
WHERE customer_id IN (SELECT customer_id FROM payment);
-- Retrieve the names of customers who have both appointments and payments

SELECT name
FROM customer
         JOIN appointment ON customer.customer_id = appointment.customer_id

EXCEPT

SELECT name
FROM customer
WHERE customer_id IN (SELECT customer_id FROM payment);
-- Retrieve the names of customers who have appointments but have not made any payments

SELECT employee.*
FROM employee
WHERE employee.position = 'Hair Stylist'
  AND employee.employee_id NOT IN (
    SELECT DISTINCT appointment.employee_id
    FROM appointment
    WHERE datetime = '2024-03-10'
);
-- Show all hair stylists available on a particular date

SELECT
    product.product_id,
    product.name,
    SUM(product.quantity WHERE product.product_id = services_products.product_id) AS total_quantity_needed
FROM
    services_products
        JOIN
    product ON services_products.product_id = product.product_id
        JOIN
    appointment ON services_products.service_id = appointment.service_id
WHERE
    appointment.status = 'Confirmed'
GROUP BY
    product.product_id, product.name;
-- Show the products needed to perform all confirmed services