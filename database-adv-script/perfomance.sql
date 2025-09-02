
-File: perfomance.sql
-Task: Optimize Complex Queries
-Location: database-adv-script/


/*
1) INITIAL query: fetch bookings + user + property + payment details
   (naive: selects many columns, joins Payments directly which may duplicate rows if multiple payments exist)
*/
-- Initial (unoptimized)
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location AS property_location,
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_method
FROM Bookings b
JOIN Users u       ON b.user_id = u.user_id
JOIN Properties p  ON b.property_id = p.property_id
LEFT JOIN Payments pay ON b.booking_id = pay.booking_id;

/*
2) How to analyze the initial query (PostgreSQL example)
   Run these BEFORE creating new indexes so you capture baseline.
*/
-- EXPLAIN (no ANALYZE) gives the plan
EXPLAIN
SELECT b.booking_id
FROM Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Properties p ON b.property_id = p.property_id
LEFT JOIN Payments pay ON b.booking_id = pay.booking_id;

-- EXPLAIN ANALYZE runs + times the query (use in dev environment)
-- WARNING: EXPLAIN ANALYZE will execute the query.
EXPLAIN ANALYZE
SELECT 
    b.booking_id, b.start_date
FROM Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Properties p ON b.property_id = p.property_id
LEFT JOIN Payments pay ON b.booking_id = pay.booking_id
WHERE b.start_date >= '2025-01-01' AND b.start_date < '2025-02-01';

/*
3) Create recommended indexes (run ONCE before re-testing)
   These indexes are designed to speed up the joins and common filters.
*/
-- Suggested indexes (Postgres / MySQL 8+ syntax)
CREATE INDEX IF NOT EXISTS idx_bookings_user_id ON Bookings(user_id);
CREATE INDEX IF NOT EXISTS idx_bookings_property_id ON Bookings(property_id);
CREATE INDEX IF NOT EXISTS idx_bookings_start_date ON Bookings(start_date);

CREATE INDEX IF NOT EXISTS idx_payments_booking_id ON Payments(booking_id);

-- (Users.user_id and Properties.property_id are PKs and already indexed)

/*
4) Optimized approach A: avoid duplicate rows from Payments by aggregating payments per booking,
   select only the required columns (less data movement).
*/
WITH payments_agg AS (
  SELECT booking_id,
         SUM(amount)       AS total_paid,
         MAX(payment_date) AS last_payment_date
  FROM Payments
  GROUP BY booking_id
)
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    u.user_id,
    u.first_name,
    u.last_name,
    p.property_id,
    p.name AS property_name,
    pa.total_paid,
    pa.last_payment_date
FROM Bookings b
JOIN Users u      ON b.user_id = u.user_id
JOIN Properties p ON b.property_id = p.property_id
LEFT JOIN payments_agg pa ON b.booking_id = pa.booking_id
WHERE b.start_date >= '2025-01-01' AND b.start_date < '2025-02-01'
ORDER BY b.start_date DESC
LIMIT 500;  -- limit is optional, useful for sampled manual checks

/*
5) Optimized approach B: use a subquery (covering) to reduce joined data
   Useful if Payments table is large and you only need sum per booking.
*/
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    u.first_name,
    u.last_name,
    p.name AS property_name,
    pay_sum.total_paid
FROM Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Properties p ON b.property_id = p.property_id
LEFT JOIN (
    SELECT booking_id, SUM(amount) AS total_paid
    FROM Payments
    GROUP BY booking_id
) AS pay_sum ON pay_sum.booking_id = b.booking_id
WHERE b.start_date >= '2025-01-01' AND b.start_date < '2025-02-01'
ORDER BY b.start_date DESC
LIMIT 500;

/*
6) Optional further micro-optimizations:
   - If you frequently filter by date and then join, ensure idx_bookings_start_date exists.
   - Consider a composite index if queries are always filtered by (start_date, property_id) etc:
       CREATE INDEX idx_bookings_startdate_property ON Bookings(start_date, property_id);
   - For repeatable analytic queries, consider materialized views (Postgres) or caching.
*/

/*
7) After adding indexes, re-run EXPLAIN ANALYZE on the optimized query to compare.
   Example:
*/
EXPLAIN ANALYZE
WITH payments_agg AS (
  SELECT booking_id, SUM(amount) AS total_paid
  FROM Payments
  GROUP BY booking_id
)
SELECT b.booking_id
FROM Bookings b
JOIN Users u ON b.user_id = u.user_id
JOIN Properties p ON b.property_id = p.property_id
LEFT JOIN payments_agg pa ON b.booking_id = pa.booking_id
WHERE b.start_date >= '2025-01-01' AND b.start_date < '2025-02-01';
