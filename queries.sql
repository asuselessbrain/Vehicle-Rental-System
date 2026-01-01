-- =========================================
-- Vehicle Booking Inventory System - SQL
-- =========================================

-- ==========================
-- 1. TABLE CREATION
-- ==========================

-- Users Table
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    password VARCHAR(255),
    role VARCHAR(50)
);

-- Vehicles Table
CREATE TABLE Vehicles (
    vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(50),
    model INT,
    registration_number VARCHAR(50),
    rental_price DECIMAL(10,2),
    status VARCHAR(50)
);

-- Bookings Table
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    vehicle_id INT,
    start_date DATE,
    end_date DATE,
    status VARCHAR(50),
    total_cost DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (vehicle_id) REFERENCES Vehicles(vehicle_id)
);

-- ==========================
-- 2. SAMPLE DATA INSERTS
-- ==========================

-- Users (passwords are sample plaintext for assignment purposes)
INSERT INTO Users (name, email, phone, password, role) VALUES
('Alice', 'alice@example.com', '1234567890', 'alice123', 'Customer'),
('Bob', 'bob@example.com', '0987654321', 'bob123', 'Admin'),
('Charlie', 'charlie@example.com', '1122334455', 'charlie123', 'Customer');

-- Vehicles
INSERT INTO Vehicles (name, type, model, registration_number, rental_price, status) VALUES
('Toyota Corolla', 'car', 2022, 'ABC-123', 50, 'available'),
('Honda Civic', 'car', 2021, 'DEF-456', 60, 'rented'),
('Yamaha R15', 'bike', 2023, 'GHI-789', 30, 'available'),
('Ford F-150', 'truck', 2020, 'JKL-012', 100, 'maintenance');

-- Bookings
INSERT INTO Bookings (user_id, vehicle_id, start_date, end_date, status, total_cost) VALUES
(1, 2, '2023-10-01', '2023-10-05', 'completed', 240),
(1, 2, '2023-11-01', '2023-11-03', 'completed', 120),
(3, 2, '2023-12-01', '2023-12-02', 'confirmed', 60),
(1, 1, '2023-12-10', '2023-12-12', 'pending', 100);

-- ==========================
-- 3. QUERIES
-- ==========================

-- Query 1: JOIN
-- Retrieve booking info with Customer name and Vehicle name
SELECT 
    b.booking_id,
    u.name AS customer_name,
    v.name AS vehicle_name,
    b.start_date,
    b.end_date,
    b.status
FROM Bookings b
INNER JOIN Users u ON b.user_id = u.user_id
INNER JOIN Vehicles v ON b.vehicle_id = v.vehicle_id;

-- Query 2: NOT EXISTS
-- Find vehicles that have never been booked
SELECT *
FROM Vehicles v
WHERE NOT EXISTS (
    SELECT 1
    FROM Bookings b
    WHERE b.vehicle_id = v.vehicle_id
);

-- Query 3: WHERE
-- Retrieve all available vehicles of a specific type (car)
SELECT *
FROM Vehicles
WHERE type = 'car'
  AND status = 'available';

-- Query 4: GROUP BY + HAVING
-- Total number of bookings per vehicle with more than 2 bookings
SELECT 
    v.name AS vehicle_name,
    COUNT(b.booking_id) AS total_bookings
FROM Vehicles v
INNER JOIN Bookings b ON v.vehicle_id = b.vehicle_id
GROUP BY v.vehicle_id, v.name
HAVING COUNT(b.booking_id) > 2;
