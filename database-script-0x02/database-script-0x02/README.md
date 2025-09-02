# Database Script 0x02 – Seed Data

This folder contains SQL scripts to populate the Airbnb database with sample data.

- `seed.sql`: Contains INSERT statements for Users, Properties, Bookings, Payments, Reviews, and Messages.

## How to Use

1. Ensure the schema (`schema.sql`) has been executed.  
2. Run the seed script:
```bash
psql -U username -d database_name -f seed.sql
