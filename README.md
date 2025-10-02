# EventDB - PostgreSQL Event Management System

**Created by: Aditya Jalgaonkar**  
📧 Connect: [LinkedIn](https://www.linkedin.com/in/aditya-jalgaonkar-b72a04282)

---

## About

Comprehensive PostgreSQL database project for event ticketing, featuring 3,100+ records across 6 interconnected tables (imported via CSV). Demonstrates mastery of SQL, from foundational queries to advanced analytics and performance optimization

---

**Tables:**
- `users` - Customer information
- `venues` - Event locations
- `events` - Scheduled events with pricing
- `orders` - Purchase transactions
- `tickets` - Individual bookings
- `attendance_log` - Activity tracking

---

## Quick Start

### 1. Setup Database
```bash
psql -U postgres
```

```sql
CREATE DATABASE eventdb;
\c eventdb
```

### 3. Import Data
```sql
\copy users FROM 'users.csv' WITH CSV HEADER;
\copy venues FROM 'venues.csv' WITH CSV HEADER;
\copy events FROM 'events.csv' WITH CSV HEADER;
\copy orders FROM 'orders.csv' WITH CSV HEADER;
\copy tickets FROM 'tickets.csv' WITH CSV HEADER;
\copy attendance_log FROM 'attendance_log.csv' WITH CSV HEADER;
```

---

## SQL Concepts Covered

**Basic:**
- SELECT, WHERE, ORDER BY, LIMIT
- Aggregations (COUNT, SUM, AVG)
- GROUP BY, HAVING
- Pattern matching (LIKE)

**Intermediate:**
- JOINS (INNER, LEFT, RIGHT)
- Subqueries
- CASE statements
- String functions

**Advanced:**
- Window Functions (ROW_NUMBER, RANK, LAG, LEAD)
- CTEs (Common Table Expressions)
- Recursive CTEs
- User Defined Functions
- Views & Materialized Views
---

## Sample Queries

### Top Revenue Events
```sql
SELECT 
    e.title, v.city,
    COUNT(t.id) as tickets_sold,
    SUM(t.price) as revenue
FROM events e
JOIN venues v ON e.venue_id = v.id
JOIN tickets t ON e.id = t.event_id
GROUP BY e.id, e.title, v.city
ORDER BY revenue DESC
LIMIT 10;
```

### Revenue Trend Analysis
```sql
SELECT 
    DATE(created_at) as date,
    SUM(total_amount) as daily_revenue,
    AVG(SUM(total_amount)) OVER (
        ORDER BY DATE(created_at) 
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) as moving_avg_7d
FROM orders
WHERE status = 'paid'
GROUP BY DATE(created_at)
ORDER BY date DESC;
```

---

## Business Analytics

**Revenue Analytics:**
- Daily/Monthly trends
- Moving averages
- weel-over-week growth

**Event Performance:**
- Ticket sales analysis
- Venue profitability
- Attendance patterns

---

## Meta Commands

| Command | Description |
|---------|-------------|
| `\l` | List databases |
| `\c eventdb` | Connect to database |
| `\dt` | List tables |
| `\d table_name` | Describe table |
| `\q` | Quit |

---

## License

MIT License - Open source project

---

**⭐ Star this repo if helpful!**

Made with ❤️ for data community
