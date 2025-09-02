- Query: Total number of bookings made by each user
SELECT 
    u.user_id,
    COUNT(b.booking_id) AS total_bookings
FROM Users u
LEFT JOIN Bookings b 
    ON u.user_id = b.user_id
GROUP BY u.user_id;

-Query: Rank properties based on total number of bookings
SELECT 
    p.property_id,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS rank_position
FROM Properties p
LEFT JOIN Bookings b 
    ON p.property_id = b.property_id
GROUP BY p.property_id;

-Query: Rank properties based on total number of bookings
SELECT 
    p.property_id,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS property_rank
FROM Properties p
LEFT JOIN Bookings b 
    ON p.property_id = b.property_id
GROUP BY p.property_id;
