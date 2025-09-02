 Booking Table Partitioning Implementation
-- ==========================================

-- Step 1: Create the Partitioned Booking Table
CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
PARTITION BY RANGE (start_date);

-- Step 2: Create Yearly Partitions
CREATE TABLE Booking_2023 PARTITION OF Booking
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE Booking_2024 PARTITION OF Booking
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE Booking_2025 PARTITION OF Booking
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- ==========================================
-- Step 3: Test Queries with EXPLAIN ANALYZE
-- ==========================================

-- Before partitioning: (on a single large Booking table)
-- SELECT * FROM Booking WHERE start_date BETWEEN '2024-01-01' AND '2024-06-30';

-- After partitioning: Query will only scan Booking_2024
EXPLAIN ANALYZE
SELECT * 
FROM Booking
WHERE start_date BETWEEN '2024-01-01' AND '2024-06-30';

-- Another test: Fetch all bookings in 2023
EXPLAIN ANALYZE
SELECT * 
FROM Booking
WHERE start_date BETWEEN '2023-03-01' AND '2023-08-31';

-- Another test: Count confirmed bookings in 2025
EXPLAIN ANALYZE
SELECT COUNT(*) 
FROM Booking
WHERE start_date >= '2025-01-01' AND status = 'confirmed';
