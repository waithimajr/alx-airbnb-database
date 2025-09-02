# Database Normalization – Airbnb Clone

## 1. First Normal Form (1NF)
- All tables contain atomic values.  
- No repeating groups or arrays.  
- Example: User table stores a single email per row.

## 2. Second Normal Form (2NF)
- All non-key attributes fully depend on the primary key.  
- Example: In Booking table, `start_date`, `end_date`, and `status` depend entirely on `booking_id`, not partially on `property_id` or `user_id`.

## 3. Third Normal Form (3NF)
- No transitive dependencies exist.  
- Example: In Property table, `host_id` links to User, but other attributes (`name`, `location`, `price_per_night`) depend only on `property_id`.

## Summary
- All tables comply with 3NF principles.  
- No redundant data exists in current schema.  
- Relationships are properly normalized using foreign keys.
