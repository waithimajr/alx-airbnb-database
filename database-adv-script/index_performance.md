
-- INDEX CREATION FOR OPTIMIZATION


-- 1. Create index on User table (frequently searched by email)
CREATE INDEX idx_user_email ON User(email);

-- 2. Create index on Booking table (frequently filtered/joined by user_id and property_id)
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);

-- 3. Create index on Property table (frequently searched/sorted by location and price)
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_property_price ON Property(price);


-- PERFORMANCE MEASUREMENT

-- Run EXPLAIN before and after creating indexes to measure performance.
-- Example queries:

-- Check how queries perform BEFORE indexes
EXPLAIN ANALYZE
SELECT * 
FROM Booking 
WHERE user_id = 1;

EXPLAIN ANALYZE
SELECT * 
FROM Property 
WHERE location = 'Nairobi'
ORDER BY price;

-- After adding indexes, the query plan should show
-- Index Scan instead of Sequential Scan, improving performance.


-- NOTES:
-- - EXPLAIN shows query execution plan.
-- - EXPLAIN ANALYZE executes the query and measures timing.
-- - Compare results before and after to validate index improvements.
