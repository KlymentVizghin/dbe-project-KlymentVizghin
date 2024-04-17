USE beauty_salon;

CREATE TABLE IF NOT EXISTS service (
                                       service_id INT AUTO_INCREMENT PRIMARY KEY,
                                       name VARCHAR(255) NOT NULL,
    description TEXT,
    duration INT,
    price DECIMAL(10, 2)
    );

CREATE TABLE IF NOT EXISTS product (
                                       product_id INT AUTO_INCREMENT PRIMARY KEY,
                                       name VARCHAR(255) NOT NULL,
    description TEXT,
    quantity INT,
    cost DECIMAL(10, 2)
    );

CREATE TABLE IF NOT EXISTS employee (
                                        employee_id INT AUTO_INCREMENT PRIMARY KEY,
                                        name VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(255),
    position VARCHAR(100),
    salary DECIMAL(10, 2)
    );

CREATE TABLE IF NOT EXISTS customer (
                                        customer_id INT AUTO_INCREMENT PRIMARY KEY,
                                        name VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(255),
    address TEXT
    );

CREATE TABLE IF NOT EXISTS appointment (
                                           appointment_id INT AUTO_INCREMENT PRIMARY KEY,
                                           customer_id INT,
                                           service_id INT,
                                           employee_id INT,
                                           datetime DATETIME,
                                           status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (service_id) REFERENCES service(service_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
    );

CREATE TABLE IF NOT EXISTS payment (
                                       payment_id INT AUTO_INCREMENT PRIMARY KEY,
                                       appointment_id INT,
                                       amount DECIMAL(10, 2),
    method VARCHAR(50),
    date DATE,
    FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id)
    );

CREATE TABLE IF NOT EXISTS services_products (
                                                 service_id INT,
                                                 product_id INT,
                                                 FOREIGN KEY (service_id) REFERENCES service(service_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id),
    PRIMARY KEY (service_id, product_id)
    );

CREATE TABLE IF NOT EXISTS employee_service (
                                                employee_id INT,
                                                service_id INT,
                                                FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
    FOREIGN KEY (service_id) REFERENCES service(service_id),
    PRIMARY KEY (employee_id, service_id)
    );

INSERT INTO service (name, description, duration, price) VALUES
                                                             ('Haircut', 'Basic haircut', 30, 25.00),
                                                             ('Manicure', 'Basic manicure', 45, 20.00),
                                                             ('Pedicure', 'Basic pedicure', 60, 30.00);

INSERT INTO product (name, description, quantity, cost) VALUES
                                                            ('Shampoo', 'Basic shampoo', 100, 10.00),
                                                            ('Nail Polish', 'Red nail polish', 50, 5.00),
                                                            ('Hand Cream', 'Moisturizing hand cream', 80, 8.00);

INSERT INTO customer (name, phone, email, address) VALUES
                                                       ('John Doe', '123-456-7890', 'john@example.com', '123 Main St, City'),
                                                       ('Jane Smith', '987-654-3210', 'jane@example.com', '456 Elm St, Town'),
                                                       ('Emily Brown', '555-555-5555', 'emily@example.com', '789 Oak St, City, Country'),
                                                       ('Michael Wilson', '666-666-6666', 'michael@example.com', '321 Pine St, City, Country'),
                                                       ('Sarah Martinez', '777-777-7777', 'sarah@example.com', '456 Maple St, City, Country'),
                                                       ('David Taylor', '888-888-8888', 'david@example.com', '987 Cedar St, City, Country'),
                                                       ('Jessica Garcia', '999-999-9999', 'jessica@example.com', '654 Birch St, City, Country'),
                                                       ('Daniel Rodriguez', '111-222-3333', 'daniel@example.com', '852 Walnut St, City, Country'),
                                                       ('Olivia Lopez', '222-333-4444', 'olivia@example.com', '741 Elm St, City, Country'),
                                                       ('William Hernandez', '333-444-5555', 'william@example.com', '369 Ash St, City, Country'),
                                                       ('Emma Smith', '444-555-6666', 'emma@example.com', '258 Cedar St, City, Country'),
                                                       ('James Johnson', '555-666-7777', 'james@example.com', '147 Pine St, City, Country');


INSERT INTO employee (name, phone, email, position, salary) VALUES
                                                                ('Emily Johnson', '555-123-4567', 'emily@example.com', 'Stylist', 3000.00),
                                                                ('Michael Brown', '555-987-6543', 'michael@example.com', 'Manicurist', 2500.00),
                                                                ('Sophia Brown', '777-888-9999', 'sophia@example.com', 'Hair Stylist', 2800.00),
                                                                ('Matthew Davis', '888-999-0000', 'matthew@example.com', 'Nail Technician', 2200.00),
                                                                ('Ava Wilson', '999-000-1111', 'ava@example.com', 'Salon Manager', 3000.00);

INSERT INTO appointment (customer_id, service_id, employee_id, datetime, status) VALUES
                                                                                     (1, 1, 1, '2024-03-05 10:00:00', 'Confirmed'),
                                                                                     (2, 2, 2, '2024-03-06 14:00:00', 'Confirmed'),
                                                                                     (3, 1, 1, '2024-03-07 11:00:00', 'Confirmed'),
                                                                                     (4, 2, 2, '2024-03-08 15:00:00', 'Confirmed'),
                                                                                     (5, 3, 1, '2024-03-09 10:30:00', 'Confirmed'),
                                                                                     (6, 1, 2, '2024-03-10 12:00:00', 'Confirmed'),
                                                                                     (7, 2, 1, '2024-03-11 14:30:00', 'Confirmed'),
                                                                                     (8, 3, 2, '2024-03-12 16:00:00', 'Confirmed'),
                                                                                     (9, 1, 1, '2024-03-13 09:00:00', 'Confirmed'),
                                                                                     (10, 2, 2, '2024-03-14 13:30:00', 'Confirmed');

INSERT INTO payment (appointment_id, amount, method, date) VALUES
                                                               (1, 25.00, 'Cash', '2024-03-05'),
                                                               (2, 20.00, 'Credit Card', '2024-03-06'),
                                                               (3, 35.00, 'Card', '2024-03-07'),
                                                               (4, 25.00, 'Cash', '2024-03-08'),
                                                               (5, 45.00, 'Card', '2024-03-09'),
                                                               (6, 20.00, 'Cash', '2024-03-10'),
                                                               (7, 35.00, 'Card', '2024-03-11');

INSERT INTO services_products (service_id, product_id) VALUES
                                                           (1, 1),
                                                           (2, 2),
                                                           (3, 3);

INSERT INTO employee_service (employee_id, service_id) VALUES
                                                           (1, 1),
                                                           (2, 2),
                                                           (1, 3),
                                                           (2, 3);
