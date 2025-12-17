-- Create the salon database
CREATE DATABASE salon;

-- Connect to salon database (this would need to be done separately in psql)
-- \c salon

-- Create customers table
CREATE TABLE customers (
  customer_id SERIAL PRIMARY KEY,
  phone VARCHAR UNIQUE NOT NULL,
  name VARCHAR
);

-- Create services table
CREATE TABLE services (
  service_id SERIAL PRIMARY KEY,
  name VARCHAR
);

-- Create appointments table
CREATE TABLE appointments (
  appointment_id SERIAL PRIMARY KEY,
  customer_id INT NOT NULL,
  service_id INT NOT NULL,
  time VARCHAR,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (service_id) REFERENCES services(service_id)
);

-- Insert sample services
INSERT INTO services (name) VALUES ('cut');
INSERT INTO services (name) VALUES ('color');
INSERT INTO services (name) VALUES ('perm');
INSERT INTO services (name) VALUES ('style');
INSERT INTO services (name) VALUES ('trim');
