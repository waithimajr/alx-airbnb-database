# Partitioning Performance Report

## Objective
The goal was to optimize queries on the large **Booking** table by implementing **table partitioning** based on the `start_date` column.

---

## Implementation
- Created a parent table `Booking` partitioned by **RANGE (start_date)**.
- Created yearly partitions:
  - `Booking_2023`
  - `Booking_2024`
  - `Booking_2025`

See [`partitioning.sql`](./partitioning.sql) for full implementation.

---

## Queries Tested
We tested queries that filter bookings by date ranges:

```sql
-- Query 1: Fetch bookings in the first half of 2024
SELECT * FROM Booking
WHERE start_date BETWEEN '2024-01-01' AND '2024-06-30';

-- Query 2: Fetch bookings in 2023
SELECT * FROM Booking
WHERE start_date BETWEEN '2023-03-01' AND '2023-08-31';

-- Query 3: Count confirmed bookings in 2025
SELECT COUNT(*) 
FROM Booking
WHERE start_date >= '2025-01-01' AND status = 'confirmed';
