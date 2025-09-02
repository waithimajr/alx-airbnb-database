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
