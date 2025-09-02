# Advanced SQL Join Queries

This directory contains SQL scripts demonstrating advanced JOIN operations on the **Airbnb Clone Database**.

## Files
- **joins_queries.sql** → Contains SQL examples for:
  - **INNER JOIN** → Retrieve all bookings and the respective users who made those bookings.
  - **LEFT JOIN** → Retrieve all properties and their reviews (including properties without reviews).
  - **FULL OUTER JOIN** → Retrieve all users and all bookings, even if unmatched.

## Notes
- The **FULL OUTER JOIN** query works directly in **PostgreSQL**.
- For **MySQL**, a `UNION` of `LEFT JOIN` and `RIGHT JOIN` is used to achieve the same effect.

 
 Task 2: Apply Aggregations and Window Functions

**Objective:** Analyze bookings and properties using aggregation + ranking.

1. **Total Bookings Per User**
   ```sql
   SELECT u.user_id, u.first_name, u.last_name, COUNT(b.booking_id) AS total_bookings
   FROM Users u
   LEFT JOIN Bookings b ON u.user_id = b.user_id
   GROUP BY u.user_id, u.first_name, u.last_name
   ORDER BY total_bookings DESC;
