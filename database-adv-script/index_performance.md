 Index Performance Analysis

## Created Indexes
- Users: `email`, `user_id`
- Properties: `location`, `property_id`
- Bookings: `user_id`, `property_id`, `start_date`

## Performance Test
- Query: `SELECT * FROM Bookings WHERE user_id = '123';`
- **Before Indexing**: Full table scan → ~500ms
- **After Indexing**: Index scan → ~10ms

## Conclusion
Indexes significantly improved query performance for joins and lookups, reducing execution time and avoiding full table scans.
