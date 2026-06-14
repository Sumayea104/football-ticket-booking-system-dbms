# Football Ticket Booking System - Database Design

## Assignment Overview
This project implements a complete database design and SQL queries for a Football Ticket Booking System.

## 📁 Repository Structure
- `/sql` - All SQL scripts (CREATE, INSERT, QUERIES)
- `/erd` - Entity Relationship Diagram
- `/documentation` - Theory answers
- `/screenshots` - Query output proofs

## 🗄️ Database Schema
- **Users** - Fan and staff information
- **Matches** - Tournament match details
- **Bookings** - Ticket purchase transactions

## 📊 ERD Link
![Football Ticket Booking System ERD](https://github.com/Sumayea104/football-ticket-booking-system-dbms/blob/main/erd/erd.drawio.png?raw=true)

[Open Full Resolution Link](https://github.com/Sumayea104/football-ticket-booking-system-dbms/blob/main/erd/erd.drawio.png)

## 📝 SQL Queries Completed
- [x] Query 1: Champions League available matches
- [x] Query 2: Name pattern search (LIKE)
- [x] Query 3: NULL handling with COALESCE
- [x] Query 4: INNER JOIN for booking details
- [x] Query 5: LEFT JOIN for users with no bookings
- [x] Query 6: Subquery with AVG comparison
- [x] Query 7: OFFSET/LIMIT for ranking

## 🎥 Viva Video
[Interview Recording Link]()

## 🚀 How to Run
1. Create database: `CREATE DATABASE football_ticket_system;`
2. Run `01_create_tables.sql`
3. Run `02_insert_sample_data.sql`
4. Run `03_queries.sql`