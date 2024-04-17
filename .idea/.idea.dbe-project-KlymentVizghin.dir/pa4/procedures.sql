USE beauty_salon;

DELIMITER //

CREATE PROCEDURE proc_get_appointments_by_customer(IN customer_name VARCHAR(255))
BEGIN
SELECT appointment_id, customer.name AS customer_name, service.name AS service_name, employee.name AS employee_name, datetime, status
FROM appointment
         INNER JOIN customer ON appointment.customer_id = customer.customer_id
         INNER JOIN service ON appointment.service_id = service.service_id
         INNER JOIN employee ON appointment.employee_id = employee.employee_id
WHERE customer.name = customer_name;
END//

DELIMITER ;
-- takes a parameter customer_name as input and returns all appointments for the specified customer.

DELIMITER //

CREATE PROCEDURE proc_get_total_appointments_by_employee(
    IN employee_name VARCHAR(255),
    OUT total_appointments INT
)
BEGIN
SELECT COUNT(*) INTO total_appointments
FROM appointment
         INNER JOIN employee ON appointment.employee_id = employee.employee_id
WHERE employee.name = employee_name;
END//

DELIMITER ;
-- takes employee_name as an input parameter and total_appointments as an output
-- retrieves the total number of appointments for the specified employee

DELIMITER //

CREATE PROCEDURE proc_update_product_description(
    INOUT product_description TEXT,
    IN additional_text TEXT
)
BEGIN
    SET product_description = CONCAT(product_description, ' ', additional_text);
END //

DELIMITER ;
-- adds the provided text to the existing description without removing the previous text

CREATE PROCEDURE proc_update_product_quantity(
    IN product_id INT,
    IN quantity_change INT,
    INOUT updated_quantity INT
)
BEGIN
    DECLARE current_quantity INT;

START TRANSACTION;

-- Retrieve the current quantity of the product
SELECT quantity INTO current_quantity
FROM product
WHERE product_id = product.product_id;

-- Update the quantity
UPDATE product
SET quantity = current_quantity + quantity_change
WHERE product_id = product.product_id;

-- Check if the updated quantity is negative
IF (current_quantity + quantity_change) < 0 THEN
        -- Rollback changes if the updated quantity is negative
        ROLLBACK;
        SET updated_quantity = current_quantity; -- Set updated_quantity to the original quantity
ELSE
        -- Commit changes if the updated quantity is non-negative
        COMMIT;
        SET updated_quantity = current_quantity + quantity_change;
END IF;

END