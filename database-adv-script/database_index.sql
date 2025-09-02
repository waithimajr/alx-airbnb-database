 File: database_index.sql
-- Task: Implement Indexes for Optimization
-- ========================================

-- Indexes for Users
CREATE INDEX idx_users_email ON Users(email);
CREATE INDEX idx_users_role ON Users(role);

-- Indexes for Bookings
CREATE INDEX idx_bookings_user_id ON Bookings(user_id);
CREATE INDEX idx_bookings_property_id ON Bookings(property_id);
CREATE INDEX idx_bookings_start_date ON Bookings(start_date);

-- ✅ Indexes for Properties
CREATE INDEX idx_properties_host_id ON Properties(host_id);
CREATE INDEX idx_properties_location ON Properties(location);

-- Note:
-- Primary keys are auto-indexed by default,
-- so no need to manually index user_id, property_id, booking_id.

-Before index
EXPLAIN ANALYZE
SELECT * FROM Bookings WHERE start_date BETWEEN '2025-01-01' AND '2025-01-31';

-After index
EXPLAIN ANALYZE
SELECT * FROM Bookings WHERE start_date BETWEEN '2025-01-01' AND '2025-01-31';
