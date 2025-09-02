1. INNER JOIN: All bookings and their respective users
SELECT 
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM Bookings b
INNER JOIN Users u 
    ON b.user_id = u.user_id;

2. LEFT JOIN: All properties and their reviews (including properties without reviews)
SELECT 
    p.property_id,
    p.title,
    p.location,
    r.review_id,
    r.rating,
    r.comment
FROM Properties p
LEFT JOIN Reviews r 
    ON p.property_id = r.property_id
ORDER BY p.property_id;


3. FULL OUTER JOIN: All users and all bookings

SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date
FROM Users u
FULL OUTER JOIN Bookings b 
    ON u.user_id = b.user_id;


SELECT 
    u.user_id, u.first_name, u.last_name,
    b.booking_id, b.property_id, b.start_date, b.end_date
FROM Users u
LEFT JOIN Bookings b 
    ON u.user_id = b.user_id

UNION

SELECT 
    u.user_id, u.first_name, u.last_name,
    b.booking_id, b.property_id, b.start_date, b.end_date
FROM Users u
RIGHT JOIN Bookings b 
    ON u.user_id = b.user_id;
