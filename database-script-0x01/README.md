
# Database Script 0x01

This directory contains the SQL scripts for creating the Airbnb database schema:

- `schema.sql`: Defines all tables, constraints, and indexes for Users, Properties, Bookings, Payments, Reviews, and Messages.

## How to Use

1. Connect to your database (PostgreSQL/MySQL).  
2. Run the schema script:
```bash
psql -U username -d database_name -f schema.sql   # PostgreSQL example
