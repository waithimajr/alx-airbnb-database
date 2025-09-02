Query 1: Aggregation with COUNT and GROUP BY
- Find the total number of bookings made by each user
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM Users u
LEFT JOIN Bookings b 
    ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;

Query 2: Window Function (RANK)
-Rank properties based on total number of bookings
SELECT 
    p.property_id,
    p.title,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM Properties p
LEFT JOIN Bookings b 
    ON p.property_id = b.property_id
GROUP BY p.property_id, p.title
ORDER BY booking_rank;
