# Query Optimization Report — perfomance.md

## Task
Refactor a complex query that retrieves bookings + user + property + payment details, measure performance, and improve execution time.

## Baseline (Initial Query)
- The initial query joined Bookings, Users, Properties, and Payments directly.
- Potential issues:
  - If Payments has multiple rows per booking, the join multiplies result rows.
  - Query selected many columns (increasing I/O).
  - Missing indexes can force sequential scans.

## Indexes added
- `idx_bookings_user_id` ON Bookings(user_id)
- `idx_bookings_property_id` ON Bookings(property_id)
- `idx_bookings_start_date` ON Bookings(start_date)
- `idx_payments_booking_id` ON Payments(booking_id)

## Optimization steps applied
1. **Aggregated Payments** into a small derived table (`payments_agg`) to avoid row-multiplication.
2. **Selected only required columns** (reduced network/I/O).
3. **Added targeted indexes** to support joins and WHERE clauses.
4. **Limited result set** during testing (`LIMIT 500`) to get repeatable timings.

## EXPLAIN ANALYZE (example results — replace with your real numbers)

### Before optimization (example)
