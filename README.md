### Beauty Salon Database Schema
# Overview
This repository contains the schema for a database designed specifically for managing operations within a beauty salon. The schema is designed to efficiently organize and store data related to various aspects of salon management, including client information, appointments, services offered, staff details, and more.

# Schema Structure
The schema has 8 tables with following attributes:

Service

Attributes: service_id, name, description, duration, price

Product

Attributes: product_id, name, description, quantity, cost

Employee

Attributes: employee_id, name, phone, email, position, salary

Customer

Attributes: customer_id, name, phone, email, address

Appointment

Attributes: appointment_id, customer_id, service_id, employee_id, datetime, status

Payment

Attributes: payment_id, appointment_id, amount, method, date

Services_Products

Attributes: service_id, product_id

Employee_Service

Attributes: employee_id, service_id

# Usage
To utilize this database schema, follow these steps:

Database Setup: Create a new database instance using your preferred database management system (e.g., MySQL, PostgreSQL).
Schema Import: Import the provided SQL script containing the schema definitions into your database instance.
Data Population (Optional): Populate the database with sample data to simulate real-world scenarios and test the functionality of the schema.
Integration: Integrate the database schema into your application or system for managing salon operations.

# About author
My name is Klyment Vizghin. I am currently studying cybersecurity in Kyiv school of economics. This is my final project for the "Database fundamentals" course
