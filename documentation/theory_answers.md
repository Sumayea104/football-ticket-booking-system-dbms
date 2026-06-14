# Football Ticket Booking System - Database Theory & Architecture

This document breaks down key database design principles, constraint mechanisms, and query logic using clear, real-world analogies.

---

## 📋 Theory Questions & Answers

### 1. Foreign Keys & Fake Tickets

> **What role does a Foreign Key play in the Bookings table, and how does it safeguard against entering a ticket sale for a match that doesn't exist?**

* **The Concept:** A **Foreign Key (FK)** links a transactional record to a master record. It enforces **Referential Integrity** across tables.
* **Real-World Analogy:** Think of a **stadium gate ticket scanner**. If a fan presents a fake ticket for *"Match #999"*, the guard checks the official match schedule board. Because Match #999 isn't listed, the scanner rejects it.
* **The Safeguard:** When entering a booking, the database instantly verifies if the `match_id` exists in the `Matches` table. If it doesn't find it, it blocks the entry and throws a validation error, preventing corrupted or fake sales.

---

### 2. Filtering Rows vs. Grouped Batches (WHERE vs. HAVING)

> **Why are we unable to use an aggregate function like `COUNT(booking_id)` inside a standard WHERE clause to filter match rows? How does HAVING solve this?**

* **The Concept:** This limitation comes down to the SQL order of operations. The database filters single rows *before* it groups them together to calculate totals.
* **Real-World Analogy:** * `WHERE` is a **security guard at the outer turnstile** checking individuals one-by-one *before* entry (*"Are you wearing a team jersey? No? Step aside."*).
  * `HAVING` is a **supervisor counting seated crowd blocks** *after* everyone is inside (*"Show me only stadium sections that have more than 500 fans grouped together."*).
* **The Solution:** Because `WHERE` runs before rows are grouped, it cannot calculate group counts or averages. `HAVING` runs directly after the `GROUP BY` stage, allowing you to easily filter aggregated results.

---

### 3. Why Primary Keys Cannot Be Blank (No-NULL Rule)

> **If a Primary Key column guarantees that all row entries are completely unique, why does the database system also explicitly forbid it from containing a NULL value?**

* **The Concept:** A Primary Key enforces **Entity Integrity**. Uniqueness ensures records stay distinct, but forbidding `NULL` ensures that every row actually has a findable identity.
* **Real-World Analogy:** Every physical seat in a football stadium has a clear identifier stamped onto it (e.g., **Block A, Row 5, Seat 12**).
  * If two seats had the same layout number, two fans would clash trying to sit in the exact same spot (**Uniqueness Constraint**).
  * If a seat had a completely blank, erased label, nobody could buy a ticket for it, security couldn't find it, and it loses its place in the stadium (**No-NULL Constraint**).
* **The Safeguard:** In relational databases, `NULL` means an "unknown" state. Because you cannot safely link a foreign key transaction to an unknown identifier, `NULL` values are strictly banned from Primary Keys.

---

### 4. New User Registrations & Left Joins

> **Imagine a newly registered fan who hasn't bought any match tickets yet. If you run a LEFT JOIN linking the Users table (left) to the Bookings table (right), what will the resulting rows look like for that specific fan?**

* **The Concept:** A `LEFT JOIN` preserves every single record from the left table, regardless of whether they have matching data in the right table.
* **Real-World Analogy:** Think of a master club roster ledger that prints every registered member's profile details, leaving an adjacent grid space on the page to paste their physical ticket receipts.
* **The Result:** For a brand-new fan who hasn't spent any money yet, their row will display their account details normally (`user_id`, `full_name`, `email`). However, all columns pulled from the ticket transaction table on the right side will display as blank **`NULL` placeholders**, indicating they exist but have no active purchases.

---

### 5. Scratchpad Calculations vs. Side-by-Side Lists (Subqueries vs. JOINs)

> **What is the difference between a main query and a subquery? In what scenarios would you choose to use a subquery over a standard JOIN operation?**

* **Definitions:**
  * **Main Query:** The primary outer statement that delivers the final rows to the screen.
  * **Subquery:** An isolated, nested query wrapped in parentheses `()` that runs first, passing its calculation up to the main query.
* **Real-World Analogy:** If you ask a ticket agent to show you all matches that cost more than the current average flight or ticket rate:
  * **Subquery Method:** The agent uses a calculator, computes the single average price, writes it on a temporary **scratchpad ($120)**, and checks the main catalog against that fixed target.
  * **JOIN Method:** The agent places two massive, identical catalogs side-by-side on the counter, matching every single row together line-by-line to execute a direct comparison.
* **When to choose a Subquery:**
  1. **Dynamic Scaling Filters:** When comparing values against an aggregated baseline calculation (e.g., `WHERE total_cost > (SELECT AVG(total_cost) FROM Bookings)`).
  2. **Existence Checking:** When you simply need to verify *if* a matching entry exists in another ledger without dragging its physical columns into your final printable list view.