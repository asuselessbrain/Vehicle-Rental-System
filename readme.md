# Vehicle Booking Inventory System - SQL Assignment

## 📌 Project Overview
This project is a **Vehicle Booking Inventory System** designed to manage customers, vehicles, and bookings. It demonstrates **database design** and **SQL query implementation** for common backend operations such as:

- Retrieving booking information
- Checking vehicle availability
- Analyzing booking statistics

The system is implemented entirely in **SQL**, focusing on practical examples of **JOINs, NOT EXISTS, WHERE, GROUP BY, HAVING**, and aggregate functions.

---

## 🗄️ Database Design



The system includes the following three primary tables:

### 1. Users
Stores customer and admin information.

| Column    | Type       | Description          |
|-----------|------------|----------------------|
| `user_id` | INT (PK)   | Unique user ID       |
| `name`    | VARCHAR    | Customer/Admin name  |
| `email`   | VARCHAR    | Email address        |
| `password`   | VARCHAR    | Hashed password        |
| `phone`   | VARCHAR    | Contact number       |
| `role`    | VARCHAR    | Customer/Admin role  |

### 2. Vehicles
Stores information about vehicles available for booking.

| Column                | Type       | Description                                   |
|-----------------------|------------|-----------------------------------------------|
| `vehicle_id`          | INT (PK)   | Unique vehicle ID                             |
| `name`                | VARCHAR    | Vehicle name                                  |
| `type`                | VARCHAR    | Vehicle type (car, bike, etc.)                |
| `model`               | VARCHAR    | Vehicle model year                            |
| `registration_number` | VARCHAR    | Vehicle registration number                   |
| `rental_price`        | DECIMAL    | Price per day                                 |
| `status`              | VARCHAR    | Availability (available, rented, maintenance) |

### 3. Bookings
Stores booking details including customer, vehicle, dates, status, and total cost.

| Column       | Type       | Description                                    |
|--------------|------------|------------------------------------------------|
| `booking_id` | INT (PK)   | Unique booking ID                              |
| `user_id`    | INT (FK)   | Customer ID (References Users)                 |
| `vehicle_id` | INT (FK)   | Vehicle ID (References Vehicles)               |
| `start_date` | DATE       | Booking start date                             |
| `end_date`   | DATE       | Booking end date                               |
| `status`     | VARCHAR    | Status (pending, confirmed, completed)         |
| `total_cost` | DECIMAL    | Total cost for the booking                     |

**ERD Link:** [View ERD on Lucidchart](https://www.lucidchart.com/your-public-erd-link)

---

## 💻 SQL Queries & Logic

The core logic is contained within `queries.sql`. Below are the key operations implemented:

### 1. Retrieve Booking Details (JOIN)
**Goal:** Retrieve booking information along with the Customer name and Vehicle name.

```sql
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
```
### 2. Find Unused Vehicles (NOT EXISTS)
**Goal:** Find all vehicles that have never been booked.

```sql
SELECT *
FROM Vehicles v
WHERE NOT EXISTS (
    SELECT 1
    FROM Bookings b
    WHERE b.vehicle_id = v.vehicle_id
);
```

### 3. Filter Available Cars (WHERE)
**Goal:** Retrieve all available vehicles of a specific type (e.g., cars).

```sql
SELECT *
FROM Vehicles
WHERE type = 'car'
  AND status = 'available';
```

### 4. High Volume Bookings (GROUP BY + HAVING)
**Goal:** Find the total number of bookings per vehicle and display only those with more than 2 bookings.

```sql
SELECT 
    v.name AS vehicle_name,
    COUNT(b.booking_id) AS total_bookings
FROM Vehicles v
INNER JOIN Bookings b ON v.vehicle_id = b.vehicle_id
GROUP BY v.vehicle_id, v.name
HAVING COUNT(b.booking_id) > 2;
```

## 🚀 How to Use

### 1. Clone the repository:
```sql
git clone [https://github.com/yourusername/vehicle-booking-sql.git](https://github.com/yourusername/vehicle-booking-sql.git)
```

### 2. Run the Script: Import and execute queries.sql to create the schema, insert sample data, and run the analysis queries.

### 3. Verify: Check the output console to see the results of the JOIN and Aggregation queries.