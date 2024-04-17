CREATE DATABASE IF NOT EXISTS beauty_salon;

USE beauty_salon;

CREATE TABLE service (
                         service_id INT AUTO_INCREMENT PRIMARY KEY,
                         name VARCHAR(255) NOT NULL,
                         description TEXT,
                         duration INT NOT NULL,
                         price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE product (
                         product_id INT AUTO_INCREMENT PRIMARY KEY,
                         name VARCHAR(255) NOT NULL,
                         description TEXT,
                         quantity INT NOT NULL,
                         cost DECIMAL(10, 2) NOT NULL
);

CREATE TABLE customer (
                          customer_id INT AUTO_INCREMENT PRIMARY KEY,
                          name VARCHAR(255) NOT NULL,
                          phone VARCHAR(20),
                          email VARCHAR(255),
                          address TEXT
);

CREATE TABLE appointment (
                             appointment_id INT AUTO_INCREMENT PRIMARY KEY,
                             customer_id INT,
                             service_id INT,
                             date DATE NOT NULL,
                             time TIME NOT NULL,
                             status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
                             FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
                             FOREIGN KEY (service_id) REFERENCES Service(service_id)
);

CREATE TABLE payment (
                         payment_id INT AUTO_INCREMENT PRIMARY KEY,
                         customer_id INT,
                         appointment_id INT,
                         amount DECIMAL(10, 2) NOT NULL,
                         method VARCHAR(50) NOT NULL,
                         date DATE NOT NULL,
                         FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
                         FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);


CREATE TABLE employee (
                          employee_id INT AUTO_INCREMENT PRIMARY KEY,
                          name VARCHAR(255) NOT NULL,
                          phone VARCHAR(20),
                          email VARCHAR(255),
                          position VARCHAR(100) NOT NULL,
                          salary DECIMAL(10, 2) NOT NULL
);

INSERT INTO service (name, description, duration, price)
VALUES
    ('Haircut', 'Includes shampoo, cut, and styling', 60, 50.00),
    ('Manicure', 'Nail trimming, shaping, and polish', 30, 25.00),
    ('Facial', 'Cleansing, exfoliation, and moisturizing', 45, 75.00);


INSERT INTO product (name, description, quantity, cost)
VALUES
    ('Shampoo', 'Moisturizing shampoo for all hair types', 20, 15.00),
    ('Nail Polish', 'Assorted colors of nail polish', 50, 5.00),
    ('Face Mask', 'Hydrating and refreshing face mask', 30, 10.00);


INSERT INTO customer (name, phone, email, address)
VALUES
    ('John Doe', '123-456-7890', 'john@example.com', '123 Main St, City, Country'),
    ('Jane Smith', '987-654-3210', 'jane@example.com', '456 Elm St, City, Country'),
    ('Alice Johnson', '555-555-5555', 'alice@example.com', '789 Oak St, City, Country');


INSERT INTO appointment (customer_id, service_id, date, time, status)
VALUES
    (1, 1, '2024-02-12', '10:00:00', 'Scheduled'),
    (2, 2, '2024-02-13', '14:00:00', 'Scheduled'),
    (3, 3, '2024-02-14', '11:00:00', 'Scheduled');


INSERT INTO payment (customer_id, appointment_id, amount, method, date)
VALUES
    (1, 1, 50.00, 'Cash', '2024-02-12'),
    (2, 2, 25.00, 'Credit Card', '2024-02-13'),
    (3, 3, 75.00, 'Cash', '2024-02-14');


INSERT INTO employee (name, phone, email, position, salary)
VALUES
    ('Emily Brown', '111-111-1111', 'emily@example.com', 'Hair Stylist', 3000.00),
    ('Michael Johnson', '222-222-2222', 'michael@example.com', 'Nail Technician', 2500.00),
    ('Samantha Lee', '333-333-3333', 'samantha@example.com', 'Esthetician', 3500.00);